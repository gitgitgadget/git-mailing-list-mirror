Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665B41F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfBGKdu (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:33:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38175 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfBGKdu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:33:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so4310117pgc.5
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lSjxoSUFxifX3ZDrjHz6Bpvg76h8wcPxSWcNwNZuUtI=;
        b=pITgVFJYPwi7EwEZV+n//rYRxTMlIYXNEmTsRpIlG+E5mDlOoVWEcPlBh5MhzybHvB
         G92/ybHvdiGTftZHeqlb/wQ4oRS4CYxZSf1SBLvKkNz82aaVJgpPOqe5zYsV3K/EikfQ
         W0mwf4y3Gj6IZ997uIiG/Pu3YpGW1fZ6IPOSbAZZcZsnoZ3ZddKLZC4AndWMN/pr77hB
         tT1Wm0Bn50eMZp/3ToZX9RJ9oz82TfqynEanLgE5cLHbmkeyqRrgnr9qH/JW8cf4uhpg
         gwKLTZjvDfQgm33ifQg7FMaP+GFGlmnh32gxNzAjSgKQG6lz6WXHXg2+UBbg6pu5AycF
         UUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lSjxoSUFxifX3ZDrjHz6Bpvg76h8wcPxSWcNwNZuUtI=;
        b=WvMVEYBthKOIh+EEDp1ezmV1RMUEcY5P4qN3kSuqJ9P/aVlmHrkYM7fFGgijJ4pnKr
         E/v3OWxyZG1cxK8Bu6EvcVOlx96kPdqDoHDzoakYRiNSR5wBR24+7h46tXBi7jcmBtFQ
         ftVCPMk3JPq3wo4bhzFjZXVOGKtmyd/jmQsY59bDY5GsjMDYO/Q9aSofeznYBdknJCM+
         ImmwwoEawePZpqboT2NVOsARtjUuCOWX141puhJbfPbTxwtH4Yntwg0sVykq9qeRic2X
         b8kMQ8TYcVtJCvsak/FsHE4AXs7uWleNp3klzIOnSapbcsFhBvLvstQZELEC12JmFF8l
         p9SQ==
X-Gm-Message-State: AHQUAubbAzX04LgImrNuD1ywStYPJO4+FH9P4R8m6Lc5EuwSQJ2Gp3Ug
        U/LcwQYzhUv3myFf7uYWKyFU17em
X-Google-Smtp-Source: AHgI3IbTutuqgkMK4tjDFzPiMz9I1G2kALJr/33dRgPGHVQIL1ZhJF+r6ZN5K2+Z+HkDd9CO8rhClQ==
X-Received: by 2002:a63:990a:: with SMTP id d10mr14174910pge.279.1549535629350;
        Thu, 07 Feb 2019 02:33:49 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id h80sm11171569pfd.63.2019.02.07.02.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:33:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:33:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/21] diff.c: convert --patch-with-raw
Date:   Thu,  7 Feb 2019 17:33:06 +0700
Message-Id: <20190207103326.10693-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 4bc9df7362..12e333c67f 100644
--- a/diff.c
+++ b/diff.c
@@ -4901,6 +4901,10 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "raw", &options->output_format,
 			  N_("generate the diff in raw format"),
 			  DIFF_FORMAT_RAW, PARSE_OPT_NONEG),
+		OPT_BITOP(0, "patch-with-raw", &options->output_format,
+			  N_("synonym for '-p --raw'"),
+			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
+			  DIFF_FORMAT_NO_OUTPUT),
 		OPT_END()
 	};
 
@@ -4929,10 +4933,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--patch-with-raw")) {
-		enable_patch_output(&options->output_format);
-		options->output_format |= DIFF_FORMAT_RAW;
-	} else if (!strcmp(arg, "--numstat"))
+	if (!strcmp(arg, "--numstat"))
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-- 
2.20.1.682.gd5861c6d90

