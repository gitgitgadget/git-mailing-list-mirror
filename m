Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA6E1F576
	for <e@80x24.org>; Thu, 25 Jan 2018 11:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeAYL74 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 06:59:56 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32956 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbeAYL7z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 06:59:55 -0500
Received: by mail-pf0-f194.google.com with SMTP id t5so5598990pfi.0
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 03:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=exvJ36a1AwdGOUSQOgrcJNzrpAlxTcs3BBfMsBueBIU=;
        b=TNYo5wTj4azt8r42GCDVGdLi+RPrYTzQ8AxTG+3VPjJY+NCeA9qLk2tq1lurR0DlLG
         aB8WkUWjzOyZ9ZKtsTAsf9kLeLQTNhJbRJSSH37iYuyucrbQlUlFywb1t5IcFyz8QsT6
         RDM3WUUHUYQ7Ji6Bb9rxEjDwQ1BQvv5bsA/6Bl+Fpb325HIiNPfS0McS60K6TP70/TqB
         ENtzsyzMkZMfPvfbT3+soRQMpKrVeOKtd40dzHFTL0aDJ4ajjlsw795SipOHBLB69wUS
         pSyS7XrjX8t06SnG+kXZnxX2TydECvwIMUYIl8CdBx80Ccj2vRrS3A3pf7slBRy7bW+9
         gOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=exvJ36a1AwdGOUSQOgrcJNzrpAlxTcs3BBfMsBueBIU=;
        b=T+yaeVbUF/6/qMr9hfTVwWUh85nNOAS/EvWIkN4CyySDxQXIOQRRuHamH/jqUayC+L
         LLbvaniJihzyp6oev/5jNSRk8fxlVmY95NU7/kCd4O6yg7DQDEN7NR/w75mZcDhVlMtu
         SifEC81MAoXqoLyAC5hDcBFv7JK8Jc+RZZBeEQxI8nHk0R0IgtpRrZDtXJIX7aJEyJOJ
         /twVKGNvOwcpfVNJai9AX/r9LOztY5jWOrybnnitYyTAE1Xp4cFtzEgHLooJPjcEOxUO
         3ioMbR1/oKX6pDgl/mvu9kqlMytdQDrc7RCnVnjcCNwcqWRTEP4GcfZKDkgpIHvZ67YM
         BNhA==
X-Gm-Message-State: AKwxytd7Zxs2p11HXmfryj4hn02HJU4ittGRmFwp779HELa59vibOED9
        IVxOnCGLFXUhmCv3iJfxYH/GMQ==
X-Google-Smtp-Source: AH8x225RZs3+82KxmAK/Vv6DgLW3AAdxvFz5SfC/Uzxcd9XMXS48mimjtXcQica4c3T9ovfOk7L7iQ==
X-Received: by 10.99.182.12 with SMTP id j12mr13677749pgf.113.1516881594500;
        Thu, 25 Jan 2018 03:59:54 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id z19sm16686722pff.3.2018.01.25.03.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2018 03:59:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Jan 2018 18:59:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/2] format-patch: keep cover-letter diffstat wrapped in 72 columns
Date:   Thu, 25 Jan 2018 18:59:26 +0700
Message-Id: <20180125115927.16196-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.200.g71ee9f6994
In-Reply-To: <20180125115927.16196-1-pclouds@gmail.com>
References: <20180122123154.8301-1-pclouds@gmail.com>
 <20180125115927.16196-1-pclouds@gmail.com>
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
2.16.1.200.g71ee9f6994

