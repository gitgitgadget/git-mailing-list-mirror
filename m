Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE50B1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbeAWWNx (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:13:53 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34080 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbeAWWNu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:13:50 -0500
Received: by mail-wm0-f65.google.com with SMTP id j21so15376633wmh.1
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 14:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pN/9ianrtC1VASeGlUqfraGTXr4whxfIpASWEyC1vdY=;
        b=YEvFaWB8T+O/ZnvxMZ1XVjuQFTZSOoVdMCXNi5dtp2l0IixNSMCo1gxtwOvBPy7Ccc
         OmgXv4OpHUINgHtCnWDDU9ipv1zV5VecrGqQJaauYgj+E6Rg4Q0h2BYSlWUj72epIX2L
         g2kjxTFpDfUrgGR1h+bKZ2i+DlV9Am9oH4Exl2jN+wOS2dYcWJmp2YyoHe2BfyI6zoDX
         HUGqlZsTzWPT9Zpu2dlMpJXNpRaaLgETMScSqlZ6y/kFNzN8TZPHWnyu03BHnhSXRNPm
         kt/BGKDIPuENboVfrLAaWNODvdMTPziM5g4CZml3bNKK46gA/SaU/uyw8iHvb8sY87AJ
         FLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pN/9ianrtC1VASeGlUqfraGTXr4whxfIpASWEyC1vdY=;
        b=JX4AIGUY7dKRcj5HTMvldMoxQ5HoCBAmGQYRmdKm2GhIT9IK77U5vbdgQvk3sTZrjs
         0RzP1dL8KQR1XVsU+2Nesac1Oo4n99EFKkLlUTlqz3m6RDTf1UYpoAZDiRzYIbSNQWFd
         T8++Ji9QWuiVCdyHOu2vZGgDhu8LIixvI1f7wxleHNhC1Zq6I96MwOSe3APTlH2cO4sr
         DKKUwvFlb1a6ufd7D1LBK2uaIwkou4NsJDDVXpNYnXpSugExYxs5ezRS0PznWpICPQdz
         LZ75KSCOGKNtLhunXeN5+7k08tLfnQYW4P71RJu+6jM2PtISO1KRE036Vhni2wMcFM8e
         V/bg==
X-Gm-Message-State: AKwxytcz2hHpVSfpJK/bz7bDOaQ6cm+gnmzzob9ZNN0Pxiy+Crbp1M54
        QAlaHO5EtOAGnDho0bBhZPpyWk4m
X-Google-Smtp-Source: AH8x225IZTEMoCHYNgdwuuX+RTjPsr0QIVI93uoUyA5NxAhcKRDMWPRxyxIJ+T1ozNcjfwlJ8CK7TA==
X-Received: by 10.80.172.226 with SMTP id x89mr21290885edc.112.1516745628586;
        Tue, 23 Jan 2018 14:13:48 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s5sm14321282eda.60.2018.01.23.14.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 14:13:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/11] fetch: don't redundantly NULL something calloc() gave us
Date:   Tue, 23 Jan 2018 22:13:16 +0000
Message-Id: <20180123221326.28495-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop redundantly NULL-ing the last element of the refs structure,
which was retrieved via calloc(), and is thus guaranteed to be
pre-NULL'd.

This code dates back to b888d61c83 ("Make fetch a builtin",
2007-09-10), where wasn't any reason to do this back then either, it's
just something left over from when git-fetch was initially introduced.

The initial motivation for this change was to make a subsequent change
which would also modify the refs variable smaller, since it won't have
to copy this redundant "NULL the last + 1 item" pattern.

As it turns out that change was bad, and better done differently, but
as this pattern is still pointless let's fix it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7bbcd26faf..b34665db9e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1302,7 +1302,6 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 			} else
 				refs[j++] = argv[i];
 		}
-		refs[j] = NULL;
 		ref_nr = j;
 	}
 
-- 
2.15.1.424.g9478a66081

