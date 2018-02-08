Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 778E61F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeBHQUH (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:07 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39649 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeBHQUG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:06 -0500
Received: by mail-wm0-f65.google.com with SMTP id b21so11041006wme.4
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eBdZBU0Ewbqy9m66Je2Ry8MZp0ZNSt/GTkeDTpw8DW4=;
        b=qsYVPWwTSITJPMMl4hgfjzvg45H8fmqigz4GjX9xcl6ZCF7557GEvus+9b3befX2lV
         9ev/6w/l5qEizXZXmJ7uSVxTy+n2sbvPjoKV3T2vt4nHKOTq0IluovvSMA254/WHd/fN
         4HxiS+tdPy5WqTCoTkP9Cn/SNKN7Wg5T1i4LeCy33J0RO1s/7GEwBoE4Fhp9AtCkmXqZ
         8Q6L1w3FrHzpKCOaAM/OLA4I1iGA3FpiR+ct9LF+CfHWhr4GM+yZwv3UtGXBCDrfV10T
         LyGlvtGqM88Dz7Nj0TGGN9jJhfFHIxXZs9FrjS2IVOtlPjCc1QhGAk5EoDzB6GLgP01I
         +8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eBdZBU0Ewbqy9m66Je2Ry8MZp0ZNSt/GTkeDTpw8DW4=;
        b=miI7A2syVeqMKzn8C5Ao7TOvnlMQdNdo1fn/iXYHmJidgvEHqrCHng9gWDE4Io5QTK
         4FldIdt+Ur5rR3tFhemVGm2z7P23q6FRCHPRp0KxiwHO2IwDMyUAn2ksFRL74983nxpB
         4NpO5TBFvHuS68Bgnwnd2qY9I3VstKLvQ/dQDFLUGUGpdWbwJlQmZKOYchA1xBOZTQUo
         /gygZ/iXZonmHA3hHOJko7hTNTub/Mzoyan5jrj0xtS7XKR/sJSR3pXyQvbm03YIkeWC
         vhgvHaH4OF0cQImJBv/BLSlT52EVXvyZo8VOECETzwqRd+kiJfw62sAEj1ZE4Eg8FqKz
         r/KA==
X-Gm-Message-State: APf1xPDSfoXkhr65tJDyVDUhaDxLG7ypOXpRZGvLbT6gBAndpClFdQAJ
        EcgCxGe2xkIIsjbRl1al9zbkDXMb
X-Google-Smtp-Source: AH8x225NzfAU1stuv9NqYFtCeuH1jyqngxfAoF8J6MxnLcrfxWMtHPKFky7Lt7D4xDoOF3T5m6tJGw==
X-Received: by 10.28.191.131 with SMTP id o3mr1458793wmi.81.1518106804853;
        Thu, 08 Feb 2018 08:20:04 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/17] fetch: trivially refactor assignment to ref_nr
Date:   Thu,  8 Feb 2018 16:19:21 +0000
Message-Id: <20180208161936.8196-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180208161936.8196-1-avarab@gmail.com>
References: <20180208161936.8196-1-avarab@gmail.com>
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trivially refactor an assignment to make a subsequent patch
smaller. The "ref_nr" variable is initialized to 0 earlier, just as
"j" is, and "j" is only incremented in that loop, so this change isn't
a logic error.

This change makes a subsequent change which splits the incrementing of
"ref_nr" into two blocks.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b34665db9e..72085e30b9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1301,8 +1301,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 						    argv[i], argv[i]);
 			} else
 				refs[j++] = argv[i];
+			ref_nr++;
 		}
-		ref_nr = j;
 	}
 
 	sigchain_push_common(unlock_pack_on_signal);
-- 
2.15.1.424.g9478a66081

