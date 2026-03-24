Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80463F7E7A
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355972; cv=none; b=F1hGaEhgpbCxz0negmHF3pW8ROvOueSCRiilxiaHQRBthSoox88hDGKD/t2CoMmZIa/IiGUf6Yc3g7mhow/ZNfZRJIweQRTO4lRszmTcaxi435RyrqBs+XJkPG7izBDOwez8jIkoeZ4rp1YSVUXuxLRLy8mS/ZVjfg+yQHxWeD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355972; c=relaxed/simple;
	bh=CbGdCYk6SisSq66+xSE/k9t3w+0mYk8tykoQadD27wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZnsfHElRaZAJgsGDFExt7+F4JNS4nZUe+//P4qRTfHyOaI/mvjVP0GrcWajTMRJDVAahb7iEQLXlxtkRjl5tRzONTdC0B3gSjYI1tINKMUdaCtXK2GJIvCPpvC6WY4/cPHBQSKHwBwvDmcr9QzdcwPNRLWq4ScI6IsDvylBgO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCmy14nG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCmy14nG"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486b96760easo11246325e9.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774355969; x=1774960769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB2vcmoJfwh4eJJpsddKXM87DTR5ECKgw33quGp+oS8=;
        b=jCmy14nGXBFx6hj9Y8l+xG0H+CUfnEK1TvO+Cktd1Zx9SeOQ6JkeqS/uwCd9f/g5rH
         ckdGsJdwVJIqBdaVkZHuZ/0Kd1/nnSpFv9ywwDR9ujdjJlIRl6GWyzwug8xbxfOHVA0d
         4QyIZv4g04J0d0XWILQDLMg2tu5EX/Ke1IrSvAfd4yl9loLjmp+Y8FHV+6JhKS2U4++A
         6/f7QsJaUQ8MwU60rN59bLhO0XxuYcj8/LY6BMfbX61/E1IoE30oEi72lyzNm/6+V0rn
         Q6hfbvCoPWKUjVLchF3aP/SyBb2gqBQnXbLDwsVgY7//G9BmymvrWYsLhd0rktS6jstn
         HCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355969; x=1774960769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eB2vcmoJfwh4eJJpsddKXM87DTR5ECKgw33quGp+oS8=;
        b=HEHg02krBxiwg4EUa8ERN/xz/JndJ8cK5DXtDszTCxkXSxhYMLKLSppD4ae4gg0HIm
         UNZvM/6zy56DWkeS9BhiZbz8f9YF9flkpHbvryHRGW4HqGIre6yxmhwXWv+nZcWYnwII
         A6J9nbhDArVKtH+AgKEmm/SAnUIjN0iID7TGzk1FjvAtAR35HsKEoE1RkMXCKML5/yX5
         SeB4o5M6/yyPm293nhg8wR5A5IOYXY3jEa9wF7pi4hPMVOf3T1XLCTegzBp0/jB+jZh9
         y8LbU7qTHoKntKMmhCTzuE4Dx8OvMLzxY/xTdU8drM/tPdN3k73uxyOXiWO5Rr/05rZp
         9kfg==
X-Gm-Message-State: AOJu0Yyrjkt/mafTCBgvNVPauVBPbPjg/AE1/Ptqv9ZDkmUqZc4MLcWI
	Vc5P6mUbLa+dyiLyHmjqc9MmM/F9c4KsWWnFnRlvkj9FhOYBWbYm+wKg7TnafYOz
X-Gm-Gg: ATEYQzxIN1aqvw1ZB1y5+GDLqv71jBu/wTCPPSFYSqQuU3AG6izYmydz09OXP6hZ7DE
	3XlDGctSBj/7y2TUlx11EueWt+c8e5rVS5uFp3tR5vHMsiN0WHMjrZ1Piz5e2g3Syyx4fl/He4P
	CSyu6RKaAiD2ctV60H/jDkp2AzlwGwu3miFg4iHsBUdTvYyB/VapAqMl1n4UDEiCNS/9YpqyJSQ
	Dkf9SC9D0dqMkTIF/pnR0748JeOXJcWL4exxS8RP0vObKCsfRmUPfpQIQCeX4hncn5RAiM0A6yp
	HPMnc5dNgGocl/nsRwCmtzi22NqKMMaVl/mdvXifKBpPLDbInH6kmUyCg7dnEIEefnP8jLCz6kO
	tIT0sX63OQ7ssfynXkaj7lr/nYgUueBcoXYqYANN5ET/hnYFFMltQi8k2kKon2zEf1wG7CCj3NU
	Tv2LJHUfDKZleb3SUfahkyMkvz0/GhPYey2548NGhGFy2wFRSp65ZN75wTYSncAU25
X-Received: by 2002:a05:600c:3554:b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-486ff01edc9mr232859985e9.31.1774355968611;
        Tue, 24 Mar 2026 05:39:28 -0700 (PDT)
Received: from pop-os.localdomain ([102.88.113.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48710fd2c4esm32049815e9.4.2026.03.24.05.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:39:28 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 8/8] env: move "warn_on_object_refname_ambiguity" into `repo_config_values`
Date: Tue, 24 Mar 2026 13:37:50 +0100
Message-ID: <20260324123750.157143-9-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260324123750.157143-1-belkid98@gmail.com>
References: <20260324123750.157143-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `warn_on_object_refname_ambiguity` variable was previously a global
integer, which makes it shared across repository instances in a single
process.

Move it into `repo_config_values` so the value is associated with the
repository from which it was read. This preserves existing behavior
while avoiding cross-repository state leakage and is another step
toward eliminating repository-dependent global state.

Update all references to use repo_config_values().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 builtin/cat-file.c     | 7 ++++---
 builtin/pack-objects.c | 7 ++++---
 environment.c          | 2 +-
 environment.h          | 2 +-
 object-name.c          | 3 ++-
 revision.c             | 7 ++++---
 submodule.c            | 7 ++++---
 7 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index da059d0e26..32f60f2f64 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -897,6 +897,7 @@ static int batch_objects(struct batch_options *opt)
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf output = STRBUF_INIT;
 	struct expand_data data = EXPAND_DATA_INIT;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	int save_warning;
 	int retval = 0;
 
@@ -969,8 +970,8 @@ static int batch_objects(struct batch_options *opt)
 	 * warn) ends up dwarfing the actual cost of the object lookups
 	 * themselves. We can work around it by just turning off the warning.
 	 */
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = cfg->warn_on_object_refname_ambiguity;
+	cfg->warn_on_object_refname_ambiguity = 0;
 
 	if (opt->batch_mode == BATCH_MODE_QUEUE_AND_DISPATCH) {
 		batch_objects_command(opt, &output, &data);
@@ -998,7 +999,7 @@ static int batch_objects(struct batch_options *opt)
  cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
-	warn_on_object_refname_ambiguity = save_warning;
+	cfg->warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7c5bc96916..b972449ca1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4653,6 +4653,7 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	struct setup_revision_opt s_r_opt = {
 		.allow_exclude_promisor_objects = 1,
 	};
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	char line[1000];
 	int flags = 0;
 	int save_warning;
@@ -4663,8 +4664,8 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = cfg->warn_on_object_refname_ambiguity;
+	cfg->warn_on_object_refname_ambiguity = 0;
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
@@ -4692,7 +4693,7 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 			die(_("bad revision '%s'"), line);
 	}
 
-	warn_on_object_refname_ambiguity = save_warning;
+	cfg->warn_on_object_refname_ambiguity = save_warning;
 
 	if (use_bitmap_index && !get_object_list_from_bitmap(revs))
 		return;
diff --git a/environment.c b/environment.c
index 57587ede56..ba2c60103f 100644
--- a/environment.c
+++ b/environment.c
@@ -47,7 +47,6 @@ int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
 int is_bare_repository_cfg = -1; /* unspecified */
-int warn_on_object_refname_ambiguity = 1;
 char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
@@ -725,4 +724,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 	cfg->core_sparse_checkout_cone = 0;
 	cfg->sparse_expect_files_outside_of_patterns = 0;
+	cfg->warn_on_object_refname_ambiguity = 1;
 }
diff --git a/environment.h b/environment.h
index 609cdaa07f..1ff0a7ba8b 100644
--- a/environment.h
+++ b/environment.h
@@ -97,6 +97,7 @@ struct repo_config_values {
 	int pack_compression_level;
 	int precomposed_unicode;
 	int core_sparse_checkout_cone;
+	int warn_on_object_refname_ambiguity;
 
 	/* section "sparse" config values */
 	int sparse_expect_files_outside_of_patterns;
@@ -174,7 +175,6 @@ extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
-extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
 extern unsigned long pack_size_limit_cfg;
diff --git a/object-name.c b/object-name.c
index 7b14c3bf9b..ddd863d293 100644
--- a/object-name.c
+++ b/object-name.c
@@ -969,11 +969,12 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	int refs_found = 0;
 	int at, reflog_len, nth_prior = 0;
 	int fatal = !(flags & GET_OID_QUIETLY);
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
 		if (!(flags & GET_OID_SKIP_AMBIGUITY_CHECK) &&
 		    repo_settings_get_warn_ambiguous_refs(r) &&
-		    warn_on_object_refname_ambiguity) {
+		    cfg->warn_on_object_refname_ambiguity) {
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
diff --git a/revision.c b/revision.c
index 402eb1b029..cff821132b 100644
--- a/revision.c
+++ b/revision.c
@@ -2904,9 +2904,10 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 	int seen_end_of_options = 0;
 	int save_warning;
 	int flags = 0;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = cfg->warn_on_object_refname_ambiguity;
+	cfg->warn_on_object_refname_ambiguity = 0;
 
 	strbuf_init(&sb, 1000);
 	while (strbuf_getline(&sb, stdin) != EOF) {
@@ -2940,7 +2941,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 		read_pathspec_from_stdin(&sb, prune);
 
 	strbuf_release(&sb);
-	warn_on_object_refname_ambiguity = save_warning;
+	cfg->warn_on_object_refname_ambiguity = save_warning;
 }
 
 static void NORETURN diagnose_missing_default(const char *def)
diff --git a/submodule.c b/submodule.c
index 508938e4da..486b41011c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -898,12 +898,13 @@ static void collect_changed_submodules(struct repository *r,
 	struct setup_revision_opt s_r_opt = {
 		.assume_dashdash = 1,
 	};
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = cfg->warn_on_object_refname_ambiguity;
+	cfg->warn_on_object_refname_ambiguity = 0;
 	repo_init_revisions(r, &rev, NULL);
 	setup_revisions_from_strvec(argv, &rev, &s_r_opt);
-	warn_on_object_refname_ambiguity = save_warning;
+	cfg->warn_on_object_refname_ambiguity = save_warning;
 	if (prepare_revision_walk(&rev))
 		die(_("revision walk setup failed"));
 
-- 
2.53.0.155.g9f36b15afa

