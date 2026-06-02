Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1DF3F7884
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420269; cv=none; b=FeD8xPxsROJ4QQGG6OdQS9KyotsJP2YQ6aQ0LSj5nlqke7jTIZYoLAZgFmfwLvsJ1GG+kgQPEONxz5+fRRodNsjEEMf185KHVdFfNgTN4b4kPqVQuKo22okgPVKbqb79B6eCSi2HdKEY0SFJZWADeLc0IKSvI81x1Ahm50ZicGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420269; c=relaxed/simple;
	bh=/6c+dbeiUG3B+YUM0ZLJCPU2dmO4rHRaKXrNwisDGN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ns6dR0UUVZ1PH0FN9Y9PzRq1+2U0I2jKrgTzvXQjftp4hqOEARJwexyGhBf9nRsct8wVB33Oc698iPe6Qas8F3oW1Rqj0Rsgs7LiGfBSZraCW9gpLEi0/lcT6AkATa+vM/8Uj8PZGEkSsk8VnAAkczJZpCe6qygREg2A6HgKXD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3oIK/iW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3oIK/iW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b3637b90so7553245e9.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 10:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780420266; x=1781025066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seC9EwPT85Hqc0mYP/zzdggodyJfK5UAqOgowPQ23y8=;
        b=P3oIK/iWr88V2x9bFQr89PIJEXn6Vr8fOSpk1PFQYsg3OhwVLUXH05Q3AZ1immmId5
         OD9WhbritsJR0zIZ03/6Xnqn9ZIga4TOELRjCqygHD0caikYgXKAwof6vexogUM/KglU
         GSwNrg94T09aS0aEAuRR4BzN1K4sDLE05KXHZibfHXiECmCmAp7D+hzjTjHyT9pORPy9
         87eGq8RmsSNulcVDfpgqm33od/kXzWMoy9hfAj/6TJI22xEnc/sPA21HJwD3G+bQMaDR
         eSkah3lgMBGoVf3wWf88r14rXn5d1c4ftzSO3J2S9+QpzjSCLq5b0r6A6U76KtzytMsc
         7dFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420266; x=1781025066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=seC9EwPT85Hqc0mYP/zzdggodyJfK5UAqOgowPQ23y8=;
        b=lPAvmJn/Rp9Uv4VlYW99Wof4xCrJoWTBLA378ZD8fby4cpPO4qp3twLuFng786P0Pu
         GyX96TaF9rdDvKErGVyeW+97TDcHfCjhhZDq3zNKuCS1f6n2RU3Lm+lDWIamHsCopDSB
         8jf5bqE216+BBZmq+0l0XKFkFune72ep3g0gYtl09tNCwKQI8zInGAz0aX5jBHJjrFux
         o8q54nSg69X7CqBfih3bDPZjYr9DyZSzWiTnJjwQsczpoR7jrJvxbNKLMKp4h6TGOj60
         xBBE61ryUopDn+IIYPCnmzUKENT9FHdH4vRCzsAl4WK9fk5q5qzDrmbyJZiIy/mMsf0v
         qsVg==
X-Gm-Message-State: AOJu0YxTp9UZYN/lRBDD+JZH9ideFoF/BM5vlaxwa61W+rAteYkGsr2s
	fTTgEEW1WIfnpBI5DB2wvJ47o2fFnVrpnlduYIOTbXEq2Fgmy9tnVP7O6wo4SboL
X-Gm-Gg: Acq92OHXQpvQbWgTtMraZy0RBX6BmvatDuAtBmp3WjWHNH/FusLBOCkF1eynxXXBWIh
	yH5fH+jbbD7+aeBvEKfBYtLLnp8pJ/m7G8btbRzpw836pgQgn3O5QkzfZ5dxRAXxh3qLQgmjnn+
	KaeArLTskvhMKpoIAts8irCOCDzQOUAlCLS4rtPnb6AhaMF2LuyEJ5RHbe5JXbzmhUMdc3N0NPO
	HcGd4TeTRAp4kpiZ3rTodz0XYVNCVrkRP4JFcHCQfOOWE/COG9+meQzCyy+Bhgc1oTa8CHFKHs9
	WfigjBpSoDcFtKY+fFscookANaSVf8GNw0JKmKpDqXz9e7uPnZ4Elt20M/l2dS8IS3W/BYN/3md
	2/OoZV/wDxTVa5r3+LIwvhstPVibaOC6MGaFKAJhgldOgFzOCG09QEznICLTUXiuYFiY8FcEEQs
	hR2ny9fB3mgfXVP+JBP4VVccOvAm7xNu25nt2YqRRgl4DaARCnlSD3MBx8TkAixxD/Y5jMG4U=
X-Received: by 2002:a05:600c:6304:b0:490:9804:afdc with SMTP id 5b1f17b1804b1-490b50a669amr8287325e9.23.1780420266167;
        Tue, 02 Jun 2026 10:11:06 -0700 (PDT)
Received: from pop-os.localdomain ([102.91.81.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e239f4sm122904265e9.7.2026.06.02.10.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:11:05 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v5 8/8] environment: move "warn_on_object_refname_ambiguity" into `struct repo_config_values`
Date: Tue,  2 Jun 2026 18:09:21 +0100
Message-ID: <20260602170921.35869-9-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260602170921.35869-1-belkid98@gmail.com>
References: <20260601154211.82370-1-belkid98@gmail.com>
 <20260602170921.35869-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `core.warnAmbiguousRefs` configuration was previously stored in a
global `int` variable, making it shared across repository instances
and risking cross‑repository state leakage.

Store it instead in `repo_config_values`, where eagerly‑parsed
repository configuration lives. This option is parsed eagerly because
ambiguity warnings influence how users interpret object references in
many commands; a lazy parse could cause these warnings to behave
inconsistently or to appear for the wrong repository, confusing users
and hindering libification. This preserves the existing behavior while
tying the value to the repository from which it was read, avoiding
cross‑repository state leakage and continuing the effort to reduce
reliance on global configuration state.

Update all references to use `repo_config_values()`.

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
index d9fbad5358..cfc5430186 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -901,6 +901,7 @@ static int batch_objects(struct batch_options *opt)
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf output = STRBUF_INIT;
 	struct expand_data data = EXPAND_DATA_INIT;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	int save_warning;
 	int retval = 0;
 
@@ -973,8 +974,8 @@ static int batch_objects(struct batch_options *opt)
 	 * warn) ends up dwarfing the actual cost of the object lookups
 	 * themselves. We can work around it by just turning off the warning.
 	 */
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = cfg->warn_on_object_refname_ambiguity;
+	cfg->warn_on_object_refname_ambiguity = 0;
 
 	if (opt->batch_mode == BATCH_MODE_QUEUE_AND_DISPATCH) {
 		batch_objects_command(opt, &output, &data);
@@ -1002,7 +1003,7 @@ static int batch_objects(struct batch_options *opt)
  cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
-	warn_on_object_refname_ambiguity = save_warning;
+	cfg->warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8ccbe7e178..7df75fe91e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4788,6 +4788,7 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	struct setup_revision_opt s_r_opt = {
 		.allow_exclude_promisor_objects = 1,
 	};
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	char line[1000];
 	int flags = 0;
 	int save_warning;
@@ -4798,8 +4799,8 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = cfg->warn_on_object_refname_ambiguity;
+	cfg->warn_on_object_refname_ambiguity = 0;
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
@@ -4827,7 +4828,7 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
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
index 21dcdc4a0e..319d3db01d 100644
--- a/object-name.c
+++ b/object-name.c
@@ -684,11 +684,12 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
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
index 599b3a66c3..4e7faa7eb1 100644
--- a/revision.c
+++ b/revision.c
@@ -2922,9 +2922,10 @@ static void read_revisions_from_stdin(struct rev_info *revs,
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
@@ -2958,7 +2959,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 		read_pathspec_from_stdin(&sb, prune);
 
 	strbuf_release(&sb);
-	warn_on_object_refname_ambiguity = save_warning;
+	cfg->warn_on_object_refname_ambiguity = save_warning;
 }
 
 static void NORETURN diagnose_missing_default(const char *def)
diff --git a/submodule.c b/submodule.c
index b1a0363f9d..f26235bbb7 100644
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

