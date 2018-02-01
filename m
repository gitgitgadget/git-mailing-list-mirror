Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3DF21F404
	for <e@80x24.org>; Thu,  1 Feb 2018 12:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeBAMsF (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 07:48:05 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44000 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeBAMsE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 07:48:04 -0500
Received: by mail-pf0-f194.google.com with SMTP id y26so15366746pfi.10
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 04:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z4iRWaDqrgHS5sXyHndzzfRTpZSxDHLz/IqzPK7mJrs=;
        b=flYRY0aiYKq5YdY1vYsMMvQOwNpqoAPLYmChdRGlO8iPh9HygvrjBpMI7CF84JH3VS
         LMr5dYxyNmGcAzU34/6LvyPKao67BEitjJyQ5tYx9ACzMjxYTMIf1u4KIpTybfMUZxk3
         8fIDrDkdtgwIALTwQakGK8khbkkvUzcJIel6shGQzLhLrjvrWlX15XRM9LqOVrDdqM3K
         FDwEm01gefyCJlh3PLoIVJwB0rUqSG1vJ4ZXtFeZdfpRkquFLrC8pZ0c91Ce/q7N2VyR
         z3OifT9JQH99GO6ea5afzdG0+Fu/6qss9faHlyds1o04A+mCSb73kvJM/nAqSpmVW63k
         vkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z4iRWaDqrgHS5sXyHndzzfRTpZSxDHLz/IqzPK7mJrs=;
        b=gYyKlZcI6IffndN3MpJiQz6ukp5kLAUROHXjH3KuWiA4PSl0LEvmoEpHMZum0oQMnX
         +zqrvfIX60dTHNYdt26NE1vdxYLJI3Idap7SfPUA6dAe29NJ+jDULqHzgUVwX4EFR+Fu
         WpoKsZYLtGe629kuCqZEER/4lczmGugo1cNNwA+gNfEOTgTjq8isJ6mEEkSdJVmQ2Wtj
         pCp2m2YRrLg4x6ydJTXPfylbhit//YpuZmn7L/C9/fghN4GIEN3z4WNm7iGRrk66iR8z
         8Azj0fsi0hA2XWXHsIDRu6hBUmD7bmHmEydp0Rzr1e39zj22Xj+3VzmjQerPNtyp/Cv+
         EK+Q==
X-Gm-Message-State: AKwxyteUlrjdNyxD85Tcuj2DwIhc/cdXW3EI3UCCec30zmq6HHsxP1bt
        anOJUEh8Lq4pppxg5llwkIsBTQ==
X-Google-Smtp-Source: AH8x224CqA+kxpxpDZzBOCqJx6P6oZMZUjJEXMV4nJme6P0KjTKsw1LaL3YOFLiOix6IrXlyLQAYtg==
X-Received: by 10.99.177.76 with SMTP id g12mr12351329pgp.269.1517489283551;
        Thu, 01 Feb 2018 04:48:03 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id q82sm28403233pfa.58.2018.02.01.04.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2018 04:48:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Feb 2018 19:47:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 1/2] format-patch: keep cover-letter diffstat wrapped in 72 columns
Date:   Thu,  1 Feb 2018 19:47:49 +0700
Message-Id: <20180201124750.15032-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180201124750.15032-1-pclouds@gmail.com>
References: <20180125115927.16196-1-pclouds@gmail.com>
 <20180201124750.15032-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already wrap shortlog around 72 columns in cover letters. Do the same
for diffstat (also in cover letters).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/log.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 46b4ca13e5..96af897403 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -29,6 +29,8 @@
 #include "gpg-interface.h"
 #include "progress.h"
 
+#define MAIL_DEFAULT_WRAP 72
+
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
 
@@ -1044,7 +1046,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	shortlog_init(&log);
 	log.wrap_lines = 1;
-	log.wrap = 72;
+	log.wrap = MAIL_DEFAULT_WRAP;
 	log.in1 = 2;
 	log.in2 = 4;
 	log.file = rev->diffopt.file;
@@ -1061,6 +1063,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	memcpy(&opts, &rev->diffopt, sizeof(opts));
 	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
+	opts.stat_width = MAIL_DEFAULT_WRAP;
 
 	diff_setup_done(&opts);
 
-- 
2.16.1.205.g271f633410

