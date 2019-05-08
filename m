Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7CF71F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfEHLOi (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:14:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34649 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEHLOi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:14:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so9962466pgt.1
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6dBq6shRUFhCwxorTRNrM7Qvz4MnpA8ohnOuII6ZU0=;
        b=B468ucT3CZtfXw1HwPdPU3JpAQdhMfpyPKciTC9/cIee8n4VHmC+9ry2yOhy+YqD/E
         LD/Rx0B74XHWRyFf1FEDpfDtfsqEY4zb3xJbvLnKezLwL0Z9LP+tvnqzYySW8p2uvONN
         jDxtjruFSS5GAaKepIoZ69ztL9Nab64o8LKlY173OCMw7J2B4pHdXDaAqUUN2YAnFJzc
         O9mSMZc4PUcGZnjRBrbbwErpkDmI/isBSbUBRXoE4JeEJJc8YH2ISZkEmwgcc0sGFJci
         XfoGf5Tz9Q6qUACjQowJlU/1cLmUicngPcyzCP53JkBT2ieeL0AvIL9UGeUSS0SXmUOW
         ZoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6dBq6shRUFhCwxorTRNrM7Qvz4MnpA8ohnOuII6ZU0=;
        b=D9cyqJoMC7NYDtBOCXFqR+UPXM3FHWQ9Ph6+12l4ePtKU8gQzIEBJG52HbAapRzO6F
         yULnG7IuVDPWOzJUZdh7ffmHIY60RoyDNYWGQyGXCIsZZP2/Pi9CVUih3m1cBIia+jmp
         TL7D9KaTLbnaZ/mnelGUGBMaXxyqrmh58S2fP5/gHHudeiz6kJCBEcH0x+yOnMwxYYIO
         r7b/GU0dSIs7FepH8cJIuTD6QE0Sj8Rqf0HKXoYIJKEKgKorUj4PtEDvxxhHWXv9UnKv
         7wRvvOhC1uEBFqLp5a637pJNUe/YzuaxFoj8SenI5fSwXd+6xwpONW6cFqX0yw5FwPVZ
         82Ag==
X-Gm-Message-State: APjAAAWtsUP+Grl3/gFB8Q3IrVRaEQpG5vthi+Gbjri8PY5xYyooNe9C
        RSkwyxlyg7z7mv1Fx6ax1RnaeYlM
X-Google-Smtp-Source: APXvYqxmpir4HEoM8Kz8JyhR2haq3/Uf4Z3uCqvqFNR9g8oPJUznv2x1Uuo0BQo8xeYXnuJOyIHGqw==
X-Received: by 2002:a63:1b65:: with SMTP id b37mr23703404pgm.408.1557314077443;
        Wed, 08 May 2019 04:14:37 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id n64sm23477948pfb.38.2019.05.08.04.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:14:36 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:14:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/19] rev-parseopt: convert --max-count
Date:   Wed,  8 May 2019 18:12:47 +0700
Message-Id: <20190508111249.15262-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190508111249.15262-1-pclouds@gmail.com>
References: <20190508111249.15262-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/revision.c b/revision.c
index f15aa3e62d..c53347d362 100644
--- a/revision.c
+++ b/revision.c
@@ -1976,12 +1976,26 @@ static int rev_opt_abbrev(const struct option *opt,
 	return 0;
 }
 
+static int rev_opt_max_count(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct rev_info *revs  = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	revs->max_count = atoi(arg);
+	revs->no_walk = 0;
+	return 0;
+}
+
 static void make_rev_options(struct rev_info *revs)
 {
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "abbrev", revs, N_("n"),
 			       N_("show the given source prefix instead of \"a/\""),
 			       PARSE_OPT_OPTARG, rev_opt_abbrev),
+		OPT_REV('n', "max-count", N_("<n>"),
+			N_("limit the number of commis to stdout"),
+			rev_opt_max_count),
 		OPT_END(),
 	};
 	revs->options = parse_options_concat(options, revs->diffopt.parseopts);
@@ -2022,11 +2036,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	if (argc)
 		return argc;
 
-	if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
-		revs->max_count = atoi(optarg);
-		revs->no_walk = 0;
-		return argcount;
-	} else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
+	if ((argcount = parse_long_opt("skip", argv, &optarg))) {
 		revs->skip_count = atoi(optarg);
 		return argcount;
 	} else if ((*arg == '-') && isdigit(arg[1])) {
@@ -2035,15 +2045,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		    revs->max_count < 0)
 			die("'%s': not a non-negative integer", arg + 1);
 		revs->no_walk = 0;
-	} else if (!strcmp(arg, "-n")) {
-		if (argc <= 1)
-			return error("-n requires an argument");
-		revs->max_count = atoi(argv[1]);
-		revs->no_walk = 0;
-		return 2;
-	} else if (skip_prefix(arg, "-n", &optarg)) {
-		revs->max_count = atoi(optarg);
-		revs->no_walk = 0;
 	} else if ((argcount = parse_long_opt("max-age", argv, &optarg))) {
 		revs->max_age = atoi(optarg);
 		return argcount;
-- 
2.21.0.1141.gd54ac2cb17

