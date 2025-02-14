Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5F1DE2B4
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574160; cv=none; b=Fndw23NiGcr7f/z6PIDvn9ERf85F9pOgz178HhdIpszXEOrS8JPQdP/q84/8yUki9M8HpIECermaUKA6BsVMrY1vk3yRdjXtMphqGAw1bO5Bmspd264IWaE6Y9cCCOdMXQxRgjTp6ZGwA3wcbLsE4Ko9q0Mgel4NGKMQDyTGJyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574160; c=relaxed/simple;
	bh=QirvhC/GcH9fB/4ExWC4PwOzK4tzDTsE4MUD+GHJMEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKAdi4rckXrHf8hciLxMhDSeNznwS8qeNS1MlvWplieEOCKM/khPeWOAB3sFIVvxaz/MWfJg1Hz3VtFgslWLlCf6kTve4zt/kQL82AdcJ0/QmKnGh68tgpJ+6J5f2NXep8uViSs5K42Qs05JmpPEyP7d1w2/517YwsJ4qACWJrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdFc5M4Y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdFc5M4Y"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220ecbdb4c2so37376125ad.3
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 15:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739574158; x=1740178958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8cKSW/SlXPNJ5ybtVAZEcWFZty7EVG9+jJPYUZVC5U=;
        b=MdFc5M4YzXXs0vnceOawZu5d+5JesdDYmVwPPVX5/Kq27YS084Dhp+dS00n3qiQI8v
         qs/2FzDsQnPbeNkTIhMT+pzuiHcoiGd4Y+PkWap78GJXibIZs8xC16GctG8ve38L/bGL
         /UIfGwyK7BU7IhV5ZMDOCyFtJmvEm7LSNo70nSKqPyI7EznBQnn+iDpg8pwARvhlVK3N
         w0iteQTmixu8rauS1hE52MYP61ERxAPuzPiOEU+jFIfaB6RPgrSIDDr88oHc0PfRlyvM
         i2Q+ayZe7VIhonIbQ1/KSeCPjLs0ZTvUOvATvPTd4zplA0ofCTHp4Jr2CpauN8MB46Jl
         lz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739574158; x=1740178958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8cKSW/SlXPNJ5ybtVAZEcWFZty7EVG9+jJPYUZVC5U=;
        b=qjg+OQG8p3k2z4ln0JMnecIyqFC+rI9ycp+KwrM8BnbFiik8622OqtkBF7bDDpGa8b
         pEEDAQdoa1Mly14W2iDIdcKVvmJC7WUITHq/Whi7RNDL59Ggobtai+cQYABtS/MpQ231
         nteEklJ8CwD72+DLn6oUFtow4lIrW++4x/ajVFir04/DgCrWmJUjnVqctbhSs6yE3ZOk
         50b3rxr7gLDCwSO6zaze9jXqqDCR+GwgykD73RVBhHSsifH71U5Y6cFSSV+scSu4mRY/
         GrbzmZiuN2cwAiFRj50fv9+93/JeB3hUF2MDrAyDY/ZBqyNf5m/up5P/3xM+7vewDvTq
         reiA==
X-Gm-Message-State: AOJu0Yz4XXDpJblNMDSP9g+tw02oG5y2MSr1jXdf208c263GTXamfPGR
	8rjOjo/Q9/+E4V839MZRIJjhUHll8YqLUvxBPtwoPxP3bjgd2QzqJeyQ++6L
X-Gm-Gg: ASbGncs+Y8+ZHiGVbxHiOGnyFcjLqpH4/pUUuLPyoTZKQXelv/ND+grODe1ITROV3Sf
	1jWhBFl+2qgwZKp36EL+P5I5S5q/kpBDKZr4dJGtH7YoiJpe9j2y0Cz19+zMRXKIFsIR9eW8N+x
	wuTikVOXCHzbzgol7WJhnpJgqkHfEBYevz5kFB0dxXUkHizkcm7z5zyV5DIUfKgnJsVgDDo79Em
	XU0geFkjt4FMlcoBYurirX3ELy5K+vIpflyYZgwNSkDMgl7ZzamrJqm7wVLFtSCxYqpG0TeOwmY
	xH3W3YPCHtnwGb1i+YbhVq2hZknPG+uO4PBk1gOg
X-Google-Smtp-Source: AGHT+IE9PDnsNa3pA1eMOmr9ikwAD6VJovUO/3Eh9zHY+FsaI2zimWYUZqZSokRAghD8I8lK3d1mGg==
X-Received: by 2002:a17:902:d50d:b0:220:e896:54e1 with SMTP id d9443c01a7336-221040566e6mr16731165ad.26.1739574158023;
        Fri, 14 Feb 2025 15:02:38 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22105174c73sm1495245ad.216.2025.02.14.15.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 15:02:37 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH 7/7] builtin/checkout-index.c: stop using `the_repository`
Date: Sat, 15 Feb 2025 04:27:23 +0530
Message-ID: <20250214230210.1460111-8-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/checkout-index.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_checkout_index()` function with `repo`
set to NULL and then early in the function, `show_usage_with_options_if_asked()`
call will give the options help and exit, without having to consult much
of the configuration file.

Let's pass `repository` argument to `checkout_all()` and `checkout_file()`
functions to remove their dependency on the global `the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/checkout-index.c | 43 ++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index e30086c7d4..46035444eb 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -5,7 +5,6 @@
  *
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -68,10 +67,10 @@ static void write_tempfile_record(const char *name, const char *prefix)
 	}
 }
 
-static int checkout_file(const char *name, const char *prefix)
+static int checkout_file(struct repository *repo, const char *name, const char *prefix)
 {
 	int namelen = strlen(name);
-	int pos = index_name_pos(the_repository->index, name, namelen);
+	int pos = index_name_pos(repo->index, name, namelen);
 	int has_same_name = 0;
 	int is_file = 0;
 	int is_skipped = 1;
@@ -81,8 +80,8 @@ static int checkout_file(const char *name, const char *prefix)
 	if (pos < 0)
 		pos = -pos - 1;
 
-	while (pos <the_repository->index->cache_nr) {
-		struct cache_entry *ce =the_repository->index->cache[pos];
+	while (pos < repo->index->cache_nr) {
+		struct cache_entry *ce =repo->index->cache[pos];
 		if (ce_namelen(ce) != namelen ||
 		    memcmp(ce->name, name, namelen))
 			break;
@@ -137,13 +136,13 @@ static int checkout_file(const char *name, const char *prefix)
 	return -1;
 }
 
-static int checkout_all(const char *prefix, int prefix_length)
+static int checkout_all(struct repository *repo, const char *prefix, int prefix_length)
 {
 	int i, errs = 0;
 	struct cache_entry *last_ce = NULL;
 
-	for (i = 0; i < the_repository->index->cache_nr ; i++) {
-		struct cache_entry *ce = the_repository->index->cache[i];
+	for (i = 0; i < repo->index->cache_nr ; i++) {
+		struct cache_entry *ce = repo->index->cache[i];
 
 		if (S_ISSPARSEDIR(ce->ce_mode)) {
 			if (!ce_skip_worktree(ce))
@@ -156,8 +155,8 @@ static int checkout_all(const char *prefix, int prefix_length)
 			 * first entry inside the expanded sparse directory).
 			 */
 			if (ignore_skip_worktree) {
-				ensure_full_index(the_repository->index);
-				ce = the_repository->index->cache[i];
+				ensure_full_index(repo->index);
+				ce = repo->index->cache[i];
 			}
 		}
 
@@ -213,7 +212,7 @@ static int option_parse_stage(const struct option *opt,
 int cmd_checkout_index(int argc,
 		       const char **argv,
 		       const char *prefix,
-		       struct repository *repo UNUSED)
+		       struct repository *repo)
 {
 	int i;
 	struct lock_file lock_file = LOCK_INIT;
@@ -253,19 +252,19 @@ int cmd_checkout_index(int argc,
 	show_usage_with_options_if_asked(argc, argv,
 					 builtin_checkout_index_usage,
 					 builtin_checkout_index_options);
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 	prefix_length = prefix ? strlen(prefix) : 0;
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
 
-	if (repo_read_index(the_repository) < 0) {
+	if (repo_read_index(repo) < 0) {
 		die("invalid cache");
 	}
 
 	argc = parse_options(argc, argv, prefix, builtin_checkout_index_options,
 			builtin_checkout_index_usage, 0);
-	state.istate = the_repository->index;
+	state.istate = repo->index;
 	state.force = force;
 	state.quiet = quiet;
 	state.not_new = not_new;
@@ -285,8 +284,8 @@ int cmd_checkout_index(int argc,
 	 */
 	if (index_opt && !state.base_dir_len && !to_tempfile) {
 		state.refresh_cache = 1;
-		state.istate = the_repository->index;
-		repo_hold_locked_index(the_repository, &lock_file,
+		state.istate = repo->index;
+		repo_hold_locked_index(repo, &lock_file,
 				       LOCK_DIE_ON_ERROR);
 	}
 
@@ -304,7 +303,7 @@ int cmd_checkout_index(int argc,
 		if (read_from_stdin)
 			die("git checkout-index: don't mix '--stdin' and explicit filenames");
 		p = prefix_path(prefix, prefix_length, arg);
-		err |= checkout_file(p, prefix);
+		err |= checkout_file(repo, p, prefix);
 		free(p);
 	}
 
@@ -326,7 +325,7 @@ int cmd_checkout_index(int argc,
 				strbuf_swap(&buf, &unquoted);
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
-			err |= checkout_file(p, prefix);
+			err |= checkout_file(repo, p, prefix);
 			free(p);
 		}
 		strbuf_release(&unquoted);
@@ -334,7 +333,7 @@ int cmd_checkout_index(int argc,
 	}
 
 	if (all)
-		err |= checkout_all(prefix, prefix_length);
+		err |= checkout_all(repo, prefix, prefix_length);
 
 	if (pc_workers > 1)
 		err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
@@ -344,7 +343,7 @@ int cmd_checkout_index(int argc,
 		return 1;
 
 	if (is_lock_file_locked(&lock_file) &&
-	    write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
+	    write_locked_index(repo->index, &lock_file, COMMIT_LOCK))
 		die("Unable to write new index file");
 	return 0;
 }
-- 
2.48.1

