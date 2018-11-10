Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917691F454
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeKJPdO (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44921 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbeKJPdN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so3353492lji.11
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MV9sOhK71D/5nPdJWlbZfiX6fEmpxDGgzlQphw3MBaU=;
        b=N1L1hG30eOHrYcQCQeAIAIZOtya2EkCX8my/41Cz1fw1Gl/fvkhMLcmB4yx2W5tHDm
         sWL9pok/co2p2B5M8bLc+3D3TEOtpeDriCLAzVsXT8suHXA5X02q5r0jdBWhPtvEbYTw
         5LkTof0F2JqbHGgk2oV6ecllkTQoolkoOF3ibyaGj/bcOPRl4uW3S0BWs6fzPwb4rOkw
         FdTIfPWyHajdh3yQBK7tczYC0PndJOfRp+nRGtlXcW9HLUgtQN5RA0NyNZ2ZcsVeju9u
         vzw24w8QcVmcPfP+P/WuXrJa9SAGfqA+xzByvOYvUyZq1j9JuGUvjBbRGa3S/gLHoI2J
         J6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MV9sOhK71D/5nPdJWlbZfiX6fEmpxDGgzlQphw3MBaU=;
        b=a9S560gSmM/TIRuklx/O5mKTKg/kYbDD7v88oUwGBDoIQ4w22Obn/wgmPaCYi3W/VU
         Fo7pkYlnrvBlHpsN/d60/t9LenfHATuD3yBv/QSAqebs4KRb09aXhLYAFtw1lTmGwfFk
         nkT5C2Mfx8PhqbOMUB4+VfM+TIll8jyR3kCTBCGlWE6SqCrtA2EwcMBwHWQ88hTVIeBE
         5rIlb5k20vCtO2r0/mplDSw8g/NBxg+PonMHXotFDoF7JdQxjG3LqLRUKgjPsj7YLiev
         odEJSlB9J14d2gtArC9SPN07kvx0BNPydwkoCuFXaZzUn85Rm87J4EZDGG1RgD70tQoh
         hD0g==
X-Gm-Message-State: AGRZ1gJCO/k8rdz8J43g8ZOUZb2oLkf+Awup9RfNqZXWqegW/Bu2Sz5w
        OIPgoaFEBMeM5DuGt92cRajj5JSZ
X-Google-Smtp-Source: AJdET5ech4fmapYkqf+gx0vPV4Js561po9lMY6riyeV0FEUGfuMUKuNlnTAYaOp4V1zt8TL9zCQcww==
X-Received: by 2002:a2e:5152:: with SMTP id b18-v6mr4456850lje.88.1541828965965;
        Fri, 09 Nov 2018 21:49:25 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:25 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 06/22] notes-merge.c: remove implicit dependency the_repository
Date:   Sat, 10 Nov 2018 06:48:54 +0100
Message-Id: <20181110054910.10568-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 notes-merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 0c22f09b28..72688d301b 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -558,7 +558,7 @@ int notes_merge(struct notes_merge_options *o,
 	else if (!check_refname_format(o->local_ref, 0) &&
 		is_null_oid(&local_oid))
 		local = NULL; /* local_oid == null_oid indicates unborn ref */
-	else if (!(local = lookup_commit_reference(the_repository, &local_oid)))
+	else if (!(local = lookup_commit_reference(o->repo, &local_oid)))
 		die("Could not parse local commit %s (%s)",
 		    oid_to_hex(&local_oid), o->local_ref);
 	trace_printf("\tlocal commit: %.7s\n", oid_to_hex(&local_oid));
@@ -576,7 +576,7 @@ int notes_merge(struct notes_merge_options *o,
 			die("Failed to resolve remote notes ref '%s'",
 			    o->remote_ref);
 		}
-	} else if (!(remote = lookup_commit_reference(the_repository, &remote_oid))) {
+	} else if (!(remote = lookup_commit_reference(o->repo, &remote_oid))) {
 		die("Could not parse remote commit %s (%s)",
 		    oid_to_hex(&remote_oid), o->remote_ref);
 	}
-- 
2.19.1.1231.g84aef82467

