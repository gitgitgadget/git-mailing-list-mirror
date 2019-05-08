Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74FDC1F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfEHLNy (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:13:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34009 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:13:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id n19so1783638pfa.1
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NPvS6o29MVYpA3fJJQHNXptvb8jUx8VKCa5sWZSLBfM=;
        b=h4AOEgstDKMdFjhxRdEaabjfXYxPBFL6nDEcIY28gU3GDsvVMNuSAYrpgMeg/SncGb
         PFO9Psue4Qk1Wcqg0HelFyVvOEiSMHCeEu9gPi0udikKWfM3AzruOl/RkOzwykpK7SBC
         g5RsgrNAJjtVc6A1kpbqHv/dRbJ4qb/ffMO31xEzk/dLy+7/4KUskOu4VzojZhqG+a+q
         e9YvMLIXeMRNtOEvzmAPHQ2JcM/9aHpO9nB91hqTWyb5oRifQbqTM1VRGVlKlOV1U0gb
         D0NBi4ctaoIQLeyyFUbUUuJ7keG1Gta5YUpHhmqMz8FE5bJGNbhIWmqK7nvpUVcLBKbV
         gLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NPvS6o29MVYpA3fJJQHNXptvb8jUx8VKCa5sWZSLBfM=;
        b=I5QOPKCSctGVkaTH19vnLJUx8MHiNtBAz/PrZf3XWrzydqsjTPUIAlm5gbbIuGgNn1
         5QNlIru4GfZA4NLSMsnDY7JQJRvLzJ9xTTgPe7Mw/NwJVkEuSUAqpi/2E9Nh5zzNSJY5
         PAGX+t+g8N3IGs8/aIGX3bsbx/60K8jnPAQtJ4PhgH9/3mMf+eUfa+f5sC9LF51V+kWt
         Q8Bh/bELY+xcwljRqxo7SpLMaLtYNnrSy842xpDy7EdiaTDPB9WgGXLMWbklrulw2eqL
         VkN2R+Cp7xD2XD6NMiyHoI7czR1gzPWCGJ9SfS6AE3Uqucl7IG5ywNZJGh1dvuFZHxzN
         Ihhg==
X-Gm-Message-State: APjAAAWpkLfCeAGyVecPWW/3AffOyPDYKVCcc9mlHVaftuHl9mBFsFG7
        oKO4P1Bwaz/WF5z21vFyoucadjQr
X-Google-Smtp-Source: APXvYqxlTvGZLS+3FEZ0HwyIwwGuOL43DXkws9gqaAkP7rVM2hnSuw2rheQ0VxjI45LkdqVP6wTcOg==
X-Received: by 2002:a63:af45:: with SMTP id s5mr45611627pgo.420.1557314033569;
        Wed, 08 May 2019 04:13:53 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id 19sm40494600pfs.104.2019.05.08.04.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:13:52 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:13:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/19] rev-parseopt: convert --tags
Date:   Wed,  8 May 2019 18:12:37 +0700
Message-Id: <20190508111249.15262-8-pclouds@gmail.com>
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
index 0d34f81716..5183cdf66d 100644
--- a/revision.c
+++ b/revision.c
@@ -2425,6 +2425,27 @@ static int rev_opt_branches(const struct option *opt,
 	return 0;
 }
 
+static int rev_opt_tags(const struct option *opt,
+			const char *arg, int unset)
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
+		for_each_glob_ref_in(handle_one_ref, arg, "refs/tags/", &cb);
+		clear_ref_exclusion(&revs->ref_excludes);
+	} else {
+		handle_refs(refs, revs, flags, refs_for_each_tag_ref);
+		clear_ref_exclusion(&revs->ref_excludes);
+	}
+	return 0;
+}
+
 static void make_pseudo_options(struct rev_info *revs)
 {
 	/*
@@ -2447,6 +2468,9 @@ static void make_pseudo_options(struct rev_info *revs)
 		OPT_REV_NOARG(0, "bisect",
 			      N_("synonym to refs/bisect/good-* --not refs/bisect/bad"),
 			      rev_opt_bisect),
+		OPT_REV_OPTARG(0, "tags", N_("<pattern>"),
+			       N_("include all refs in refs/tags (optionally matches pattern)"),
+			       rev_opt_tags),
 		OPT_END()
 	};
 	ALLOC_ARRAY(revs->pseudo_options, ARRAY_SIZE(options));
@@ -2487,10 +2511,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (argc)
 		return argc;
 
-	if (!strcmp(arg, "--tags")) {
-		handle_refs(refs, revs, *flags, refs_for_each_tag_ref);
-		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (!strcmp(arg, "--remotes")) {
+	if (!strcmp(arg, "--remotes")) {
 		handle_refs(refs, revs, *flags, refs_for_each_remote_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
@@ -2502,11 +2523,6 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
 		return argcount;
-	} else if (skip_prefix(arg, "--tags=", &optarg)) {
-		struct all_refs_cb cb;
-		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--remotes=", &optarg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-- 
2.21.0.1141.gd54ac2cb17

