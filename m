Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02021F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfEHLN7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:13:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45394 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:13:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so9932856pgi.12
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZUM7gI5InJUf0+qZmV9xNjRDOOAmpEtrxBYL5F+fm6Q=;
        b=bMWHAcKwF6qR30PgS/3Xf1Vd6IyqRGn7DDUCpDKKeuLNxDDBfhBwheEydZpjozNMp+
         3rTgrQUZPnOehZX5hAhSR9fRYKVkYWvAQVHgdoA+O4IpHWmqkbRavC1kFzN6QSGPl9TW
         ZUt/0vhE0UHlTBnVgJRQYEU+0UR7xMhkpD5/5DhdrQ5JwWkyM6mPxtLtBj73MFe17wvI
         tKsezZZFoR3WFyV8+Ij5n8WzQyPSHlFGwfQOPIBsUgToPwMbw2bols4zYc7C5YEcHAq7
         9mGEPNPYYjU8xKn1If+faxA2aaTjJzvB4JCsUqOznsqHw2Xe4JuSTpRY2WqadGPx6M5X
         R21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZUM7gI5InJUf0+qZmV9xNjRDOOAmpEtrxBYL5F+fm6Q=;
        b=rjXi0381ysdWneg8QzUQIR+7Cz3evMomWSWzY1fqo1gzXSzp64ThrUkZAUIAQNZN7+
         8GjWKUeaPkWNUsGhlJIxPRPYdu0/LTJvMwowE4oEFp97Yq+NMrtWu8pSvNJkPnQyd0C9
         lqdt5tZ4BmKDBYJYrSmK+WnLSsdTTQh1fzCoqetPccgiktes8mCDRMnvJYHo6lcQtR5C
         3MCv4mPa12DRM0CFWCsPP8YJHGSXMYLOwA8o0COwNdJoK69lG8LKFy7Pael+bI5dYUvF
         jfjZPjNoRmLad6yLEdiTGtCYRhJ/1RW/zdZa7qlfqMw45eAYp8Dxd4iw1gPu46HwbM9M
         /k2A==
X-Gm-Message-State: APjAAAX5Li2idbFDloIDnmAolNvS+7hornRYhI5hHJDG7U3nItNfj2o7
        47fh6iYNvEVjKSe3RoLmFXEnoyyb
X-Google-Smtp-Source: APXvYqz9QwFBE2n0Zklu+W3lD+Bz0rGOdDlkuWYGpeiQ4AKgw53zxMmqxxCrd1XPELGNd5KxsS5LIg==
X-Received: by 2002:a65:5181:: with SMTP id h1mr46539443pgq.167.1557314038026;
        Wed, 08 May 2019 04:13:58 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id n184sm18581875pfn.21.2019.05.08.04.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:13:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:13:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/19] rev-parseopt: convert --remotes
Date:   Wed,  8 May 2019 18:12:38 +0700
Message-Id: <20190508111249.15262-9-pclouds@gmail.com>
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
 revision.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index 5183cdf66d..bcfca8856f 100644
--- a/revision.c
+++ b/revision.c
@@ -2425,6 +2425,27 @@ static int rev_opt_branches(const struct option *opt,
 	return 0;
 }
 
+static int rev_opt_remotes(const struct option *opt,
+			   const char *arg, int unset)
+{
+	struct rev_info		*revs  = opt->value;
+	int			 flags = *revs->pseudo_flags;
+	struct ref_store	*refs  = revs->pseudo_refs;
+
+	BUG_ON_OPT_NEG(unset);
+	if (arg) {
+		struct all_refs_cb cb;
+
+		init_all_refs_cb(&cb, revs, flags);
+		for_each_glob_ref_in(handle_one_ref, arg, "refs/remotes/", &cb);
+		clear_ref_exclusion(&revs->ref_excludes);
+	} else {
+		handle_refs(refs, revs, flags, refs_for_each_remote_ref);
+		clear_ref_exclusion(&revs->ref_excludes);
+	}
+	return 0;
+}
+
 static int rev_opt_tags(const struct option *opt,
 			const char *arg, int unset)
 {
@@ -2471,6 +2492,9 @@ static void make_pseudo_options(struct rev_info *revs)
 		OPT_REV_OPTARG(0, "tags", N_("<pattern>"),
 			       N_("include all refs in refs/tags (optionally matches pattern)"),
 			       rev_opt_tags),
+		OPT_REV_OPTARG(0, "remotes", N_("<pattern>"),
+			       N_("include all refs in refs/remotes (optionally matches pattern)"),
+			       rev_opt_remotes),
 		OPT_END()
 	};
 	ALLOC_ARRAY(revs->pseudo_options, ARRAY_SIZE(options));
@@ -2511,10 +2535,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (argc)
 		return argc;
 
-	if (!strcmp(arg, "--remotes")) {
-		handle_refs(refs, revs, *flags, refs_for_each_remote_ref);
-		clear_ref_exclusion(&revs->ref_excludes);
-	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
+	if ((argcount = parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref(handle_one_ref, optarg, &cb);
@@ -2523,11 +2544,6 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
 		return argcount;
-	} else if (skip_prefix(arg, "--remotes=", &optarg)) {
-		struct all_refs_cb cb;
-		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--indexed-objects")) {
-- 
2.21.0.1141.gd54ac2cb17

