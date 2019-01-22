Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573101F453
	for <e@80x24.org>; Tue, 22 Jan 2019 00:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfAVAap (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 19:30:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45407 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVAao (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 19:30:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so10167590pgc.12
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 16:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FUY6Ex0/QZJyM7EoR2y01ofTf2ML7qqR67U1RRk/jyQ=;
        b=jKH0U7VJkcTrKYH0emjvZdDSaRYef5xW2mcdqosXdnFqPy7xp1MnghXRfUfIDJ5Zrs
         81lLmpoKJ5trG6lfBSJngbRhdWtXpnU1NjRvMRVu50E8+y3DtfWyZQXkwzzgp+JTVi7j
         ZpLj6oZ9uQqN2gfcHkTHmO5Lef3oZEQuj7+aqYxOM0V4iwCAu06Z1zYPvEyg8y/qh8n8
         ZKrrqqIn+cRcYDD0BjMTJZj45pTYQ95P6YZRv2rIF4s6LTM1Z5OBi2BfDbdQsBrFfFMv
         eSB6xAy+y7zGd6V2W9T+97a/ZGsVWPgmAKjv7+sI5ye3qub37dpPqRh7wRs1fxaFx6Ua
         /vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUY6Ex0/QZJyM7EoR2y01ofTf2ML7qqR67U1RRk/jyQ=;
        b=hL6yj86JfCuKtjlUQI1/pdJgaigeu8eLNkG8to/FAjrDZg0weYSvShKJLqZfGWDV7Z
         /OCuyjWJPyDFrNNMAzvDLvb3uy2cabkdE+WwaU/uSHRBB0ZDtW/IFLdFdHuvLrO3XElJ
         NwucjFmqf09BGoW6eXWbuwhIN8QGRPBu6zEQ9ggVgxCJ40R8W4Sj3eVj96OyK/MxHzgp
         6g01Ld5n/6tRR5CXqMyziIF8FVnpspSkmUKOF4bXGONQvO6RQB+1fT3WyZTNXhthyzI6
         vwKR/OXuRZaEwp29R1IgopYEyGglJPnGYkBSpEM+vKp+WazKHzF10P1wKENMGFAhyvW0
         aILA==
X-Gm-Message-State: AJcUukcq7ZyhjTCXQChSthgm7Hem9tYnlBfxkNIoPzt0GUY0lYvlam1U
        RWGdOm8smIgFOuMsUg+VigCBHmA+
X-Google-Smtp-Source: ALg8bN5oOua3Ar5Zyx3Rv0DDGmrRXy3KsYjrX3IzjdmnhOUCBS2hxz1sqiF8Y1/+IegXWI0CRgjpKQ==
X-Received: by 2002:a63:5402:: with SMTP id i2mr29336839pgb.79.1548117043927;
        Mon, 21 Jan 2019 16:30:43 -0800 (PST)
Received: from dektop.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id p77sm26157897pfi.85.2019.01.21.16.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 16:30:43 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 2/3] diff.c: delete unused functions
Date:   Tue, 22 Jan 2019 07:30:19 +0700
Message-Id: <20190122003020.9672-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190122003020.9672-1-pclouds@gmail.com>
References: <20190122002635.9411-1-pclouds@gmail.com>
 <20190122003020.9672-1-pclouds@gmail.com>
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
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
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

