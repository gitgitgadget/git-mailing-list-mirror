Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF391F453
	for <e@80x24.org>; Tue, 22 Jan 2019 00:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfAVA0q (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 19:26:46 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:39532 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVA0p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 19:26:45 -0500
Received: by mail-pl1-f176.google.com with SMTP id 101so10533667pld.6
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 16:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nyqyKDWSpGUairiQnX03WBCZhkh/w4K549wITrlKrIM=;
        b=P9LLvnyo7ryEnrUc8qRfDUGLjEXqCf/kbpsA8pR9+ShCdP6gJUh4jAD7mzXaGbWfH7
         SWiQR2OcBQ/Pdx+XRUwLAaX+3NMrZeyWHMfH5bsYmGW9ExAe6k+PzNo/M6X1XaDKuQ6u
         bzarWXHe/bEP5IN9cl4idJ2BX8C0mR/ncKAJ+xk2hcBedROGbKpNt0gM3pRKPmNmpfq7
         FB880Q8E3ipRnwCprLLmJw5WLB5+5M++8HwxYiJpliTwEk/jEK2Mga7crbc59IU5ki4V
         UktDZXqW601iQnjrKp406u3cboYKpEhiwv+mBMdd8zjJMLoE/VkVGtn7C3kEJwmUHNkx
         Da0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyqyKDWSpGUairiQnX03WBCZhkh/w4K549wITrlKrIM=;
        b=qC2ny3bcXz65Eba3zzbuP80cHxSl44HZEm8Aowqa9/la9pS/T0WYUo0IVxvtIxzIDY
         87RTLUKnw99IFiK+38MrPcNW+ajm22zOZa7o/X8DEYKc4aURfQ81BHYbQvuPhJ1RBW4m
         8fpMbkcRbC/9NZDgk1NzJvxy98bt7DaR2F+20jIucnO1SB1Gj8dDylvx0FSQDnTlLIoK
         uslcL9OFsTwVErFDzlG/YmfH6fLxhIPvziwcTZL3bDBOKqn9MmF5pmHGWJKtHZySbVRk
         6k4e6MBUCJaPY4O8QtxJ2E6TMNQinVXVLmlTFzzl0TP5vp057pxuDuNxR17A06gcMU16
         vjaw==
X-Gm-Message-State: AJcUuke3uj0QIW4j6pI0FddDqf8zfAI27UWoydqNndZ5d0T9K5Q+OIr+
        JTu+JwOPlMBm9HKvtBcGmYKfRFwp
X-Google-Smtp-Source: ALg8bN5eLe8rWZFPrS3MvpB54cFaZl3GuhB9ojksTEZMvQgWSSzhP7Tqor2UD9kperGxNS71nPqNog==
X-Received: by 2002:a17:902:8f83:: with SMTP id z3mr31252960plo.328.1548116804540;
        Mon, 21 Jan 2019 16:26:44 -0800 (PST)
Received: from dektop.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id u123sm21306640pfb.1.2019.01.21.16.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 16:26:44 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/3] diff.c: delete unused functions
Date:   Tue, 22 Jan 2019 07:26:34 +0700
Message-Id: <20190122002635.9411-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190122002635.9411-1-pclouds@gmail.com>
References: <20190122002635.9411-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the parseopt conversion, a few functions are no longer
needed. Delete them.

Noticed-by: SZEDER Gábor <szeder.dev@gmail.com>
Noticed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 diff.c | 65 ----------------------------------------------------------
 1 file changed, 65 deletions(-)

diff --git a/diff.c b/diff.c
index 747e691190..da5ba835ce 100644
--- a/diff.c
+++ b/diff.c
@@ -104,11 +104,6 @@ static const char *color_diff_slots[] = {
 	[DIFF_FILE_NEW_BOLD]	      = "newBold",
 };
 
-static NORETURN void die_want_option(const char *option_name)
-{
-	die(_("option '%s' requires a value"), option_name);
-}
-
 define_list_config_array_extra(color_diff_slots, {"plain"});
 
 static int parse_diff_color_slot(const char *var)
@@ -4578,66 +4573,6 @@ void diff_setup_done(struct diff_options *options)
 	FREE_AND_NULL(options->parseopts);
 }
 
-static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
-{
-	char c, *eq;
-	int len;
-
-	if (*arg != '-')
-		return 0;
-	c = *++arg;
-	if (!c)
-		return 0;
-	if (c == arg_short) {
-		c = *++arg;
-		if (!c)
-			return 1;
-		if (val && isdigit(c)) {
-			char *end;
-			int n = strtoul(arg, &end, 10);
-			if (*end)
-				return 0;
-			*val = n;
-			return 1;
-		}
-		return 0;
-	}
-	if (c != '-')
-		return 0;
-	arg++;
-	eq = strchrnul(arg, '=');
-	len = eq - arg;
-	if (!len || strncmp(arg, arg_long, len))
-		return 0;
-	if (*eq) {
-		int n;
-		char *end;
-		if (!isdigit(*++eq))
-			return 0;
-		n = strtoul(eq, &end, 10);
-		if (*end)
-			return 0;
-		*val = n;
-	}
-	return 1;
-}
-
-static inline int short_opt(char opt, const char **argv,
-			    const char **optarg)
-{
-	const char *arg = argv[0];
-	if (arg[0] != '-' || arg[1] != opt)
-		return 0;
-	if (arg[2] != '\0') {
-		*optarg = arg + 2;
-		return 1;
-	}
-	if (!argv[1])
-		die("Option '%c' requires a value", opt);
-	*optarg = argv[1];
-	return 2;
-}
-
 int parse_long_opt(const char *opt, const char **argv,
 		   const char **optarg)
 {
-- 
2.20.1.560.g70ca8b83ee

