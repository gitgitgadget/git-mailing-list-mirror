Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08D288D1
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 04:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725597754; cv=none; b=i86JLxN997HCSR+beQx4RZXzZX6ZQAk2dSULIj4esA+Z9oKpepmm8gSGYUTG1ZzbjOef1ErP/DZS1s4VaYVY3qRQxpaISGHiHSWApycJpYiQ39IEuf5AnmHwC53rntuoD9+IhYRALI0sbSuitb+AFfJYsr4qN7tAx94d+hKocEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725597754; c=relaxed/simple;
	bh=2QOCiTe4Z6IA4d39VtRek8CU3PsA84wWe9g7lMjMUqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7Px1hI0o8gG+VRht/dvYv6sBRWbt9DKhuXtoEuxz+gaqOUMQiN0+DBloPFfkWnETSli2HBEheJpB+NnDStqc2zESJOEDdw6n6IjWGsj6SHaNK6aNH9lR9hRArk0+XOYEcQtGOF3JQ7a9MfKGRHjQg2Sn1mbInV/HTGCprXUIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAsqeo2s; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAsqeo2s"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d8fa2ca5b1so1173150a91.3
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 21:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725597752; x=1726202552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ0fvIlh2+v3ZK9XWlOXRvawbB7wX3u40PodH7m1Sg8=;
        b=ZAsqeo2seSrSX+sjmTsRI7NgC39qcLQ7yf5YnA3Qsgb4KfeddwSHuVPPA6UtOfrPwj
         EOh+tGeL8cLztU98iPcHzj/5GoRDCBYrfSTtaxhKS9SAwBn3fmUHUJYp8O/WnTbV94ip
         vYu6KcB1Qwe8RhRiW2PtPF/0enjBWE0sPiI85XyIj5zecwYbeUzwYEPJeED5Bnu0XCQe
         fEEQrdpSafBELPMoP+3S+DFgiE5UYuCBEn5eP1UHj94avzyvg07dCM6AFN5qYA2g5eTt
         jBPwQhRNtmfjGMcwcFaLzdU00q6Ip4XsFdmiZOcsg3PYc+ElTtuQ0Nhcy9kLM1HbctMK
         40Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725597752; x=1726202552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQ0fvIlh2+v3ZK9XWlOXRvawbB7wX3u40PodH7m1Sg8=;
        b=wNNHj97Ad32yFxD+atsVegJQ4PsZlNuXeRKqas6hsdaCpHH3XFrL4uixlnfkvu32P8
         UmPoVF9T9areW7dGaqGjQ0btMzDyuQf4VB3VUeQFAUg/ufumYjKW3BajsXmpUFA+WwVv
         rHt48qaj2ffrdKsSvlD3S1unvNoxoeNn6kYKZuLboOMMmNP+bVdbeuUSwImQe5e0PkEW
         54brW6pPNgpJuMc421hnui+JXdZJhWX3Rvt1HjvVmIVvZY8qqgS5XGWIfpxSlnFXhcNz
         4bKLSdk7bCUq2lDet5iEeTLspFTB/S3RSvEj1SceZq9X0bWGPcYy3a5tOQDyN67FEJXy
         Alyw==
X-Gm-Message-State: AOJu0YyyUEZvHLjDEFDYh66cHFwRMZL15dmAF9paukhIVk1gprs3D1Uy
	5srnpX2MMM0x7ADkDdN8pTF+uX3o+TF5ZDxP7YMCY1MmdZhRJpJdwcj1SA==
X-Google-Smtp-Source: AGHT+IF9hAr/yxd5ujZbUEibuvU8+HjIVqk2AKLEhqfsgZPmgW5mI4CWagxbvL8Ziy58aza1yJTCnA==
X-Received: by 2002:a17:90b:1050:b0:2d8:8ab3:2889 with SMTP id 98e67ed59e1d1-2dad4ef0caamr1843148a91.11.1725597751370;
        Thu, 05 Sep 2024 21:42:31 -0700 (PDT)
Received: from panther.801labs.org ([136.41.66.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc04d7a4sm463289a91.29.2024.09.05.21.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 21:42:31 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org,
	gitster@pobox.com,
	bert.wesarg@googlemail.com
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] apply: support --ours, --theirs, and --union for three-way merges
Date: Thu,  5 Sep 2024 22:22:36 -0600
Message-ID: <20240906044222.4881-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

--ours, --theirs, and --union are already supported in `git merge-file`
for automatically resolving conflicts in favor of one version or the
other, instead of leaving conflict markers in the file. Support them in
`git apply -3` as well because the two commands do the same kind of
file-level merges.

In case in the future --ours, --theirs, and --union gain a meaning
outside of three-way-merges, they do not imply --3way but rather must be
specified alongside it.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-apply.txt |  9 ++++++-
 apply.c                     | 49 ++++++++++++++++++++++++++++++++++---
 apply.h                     |  2 ++
 t/t4108-apply-threeway.sh   | 40 ++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 9cce68a38b..dd4a61ef28 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -9,7 +9,8 @@ git-apply - Apply a patch to files and/or to the index
 SYNOPSIS
 --------
 [verse]
-'git apply' [--stat] [--numstat] [--summary] [--check] [--index | --intent-to-add] [--3way]
+'git apply' [--stat] [--numstat] [--summary] [--check]
+	  [--index | --intent-to-add] [--3way] [--ours | --theirs | --union]
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
@@ -92,6 +93,12 @@ OPTIONS
 	When used with the `--cached` option, any conflicts are left at higher stages
 	in the cache.
 
+--ours::
+--theirs::
+--union::
+	Instead of leaving conflicts in the file, resolve conflicts favouring
+	our (or their or both) side of the lines. Requires --3way.
+
 --build-fake-ancestor=<file>::
 	Newer 'git diff' output has embedded 'index information'
 	for each blob to help identify the original version that
diff --git a/apply.c b/apply.c
index 6e1060a952..e47ec6dc56 100644
--- a/apply.c
+++ b/apply.c
@@ -110,6 +110,7 @@ int init_apply_state(struct apply_state *state,
 	state->prefix = prefix;
 	state->repo = repo;
 	state->apply = 1;
+	state->merge_opts.conflict_style = -1;
 	state->line_termination = '\n';
 	state->p_value = 1;
 	state->p_context = UINT_MAX;
@@ -3578,7 +3579,7 @@ static int three_way_merge(struct apply_state *state,
 			  &our_file, "ours",
 			  &their_file, "theirs",
 			  state->repo->index,
-			  NULL);
+			  &state->merge_opts);
 	if (status == LL_MERGE_BINARY_CONFLICT)
 		warning("Cannot merge binary files: %s (%s vs. %s)",
 			path, "ours", "theirs");
@@ -3704,7 +3705,15 @@ static int try_threeway(struct apply_state *state,
 		return status;
 	}
 
-	if (status) {
+	if (state->merge_opts.variant) {
+		/*
+		 * XDL_MERGE_FAVOR_(OURS|THEIRS|UNION) automatically resolves
+		 * conflicts, but the ll_merge function is not yet smart enough
+		 * to report whether or not there were conflicts, so just print
+		 * a generic message.
+		 */
+		fprintf(stderr, _("Applied patch to '%s'.\n"), patch->new_name);
+	} else if (status) {
 		patch->conflicted_threeway = 1;
 		if (patch->is_new)
 			oidclr(&patch->threeway_stage[0], the_repository->hash_algo);
@@ -4980,6 +4989,23 @@ static int apply_option_parse_space_change(const struct option *opt,
 	return 0;
 }
 
+static int apply_option_parse_favorite(const struct option *opt,
+				       const char *arg, int unset)
+{
+	struct apply_state *state = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	BUG_ON_OPT_NEG(unset);
+
+	if (!strcmp(opt->long_name, "ours"))
+		state->merge_opts.variant = XDL_MERGE_FAVOR_OURS;
+	else if (!strcmp(opt->long_name, "theirs"))
+		state->merge_opts.variant = XDL_MERGE_FAVOR_THEIRS;
+	else
+		state->merge_opts.variant = XDL_MERGE_FAVOR_UNION;
+	return 0;
+}
+
 static int apply_option_parse_whitespace(const struct option *opt,
 					 const char *arg, int unset)
 {
@@ -5151,6 +5177,18 @@ int apply_parse_options(int argc, const char **argv,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_BOOL('3', "3way", &state->threeway,
 			 N_( "attempt three-way merge, fall back on normal patch if that fails")),
+		OPT_CALLBACK_F(0, "ours", state, NULL,
+			N_("for conflicts, use our version"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			apply_option_parse_favorite),
+		OPT_CALLBACK_F(0, "theirs", state, NULL,
+			N_("for conflicts, use their version"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			apply_option_parse_favorite),
+		OPT_CALLBACK_F(0, "union", state, NULL,
+			N_("for conflicts, use a union version"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			apply_option_parse_favorite),
 		OPT_FILENAME(0, "build-fake-ancestor", &state->fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
 		/* Think twice before adding "--nul" synonym to this */
@@ -5190,5 +5228,10 @@ int apply_parse_options(int argc, const char **argv,
 		OPT_END()
 	};
 
-	return parse_options(argc, argv, state->prefix, builtin_apply_options, apply_usage, 0);
+	argc = parse_options(argc, argv, state->prefix, builtin_apply_options, apply_usage, 0);
+
+	if (state->merge_opts.variant && !state->threeway)
+		die(_("--ours, --theirs, and --union require --3way"));
+
+	return argc;
 }
diff --git a/apply.h b/apply.h
index cd25d24cc4..096f4472b4 100644
--- a/apply.h
+++ b/apply.h
@@ -3,6 +3,7 @@
 
 #include "hash.h"
 #include "lockfile.h"
+#include "merge-ll.h"
 #include "string-list.h"
 #include "strmap.h"
 
@@ -59,6 +60,7 @@ struct apply_state {
 	struct repository *repo;
 	const char *index_file;
 	enum apply_verbosity apply_verbosity;
+	struct ll_merge_options merge_opts;
 	char *fake_ancestor;
 	const char *patch_input_file;
 	int line_termination;
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 3211e1e65f..c6302163d8 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -82,6 +82,46 @@ test_expect_success 'apply with --3way with merge.conflictStyle = diff3' '
 	test_apply_with_3way
 '
 
+test_apply_with_3way_favoritism () {
+	apply_arg=$1
+	merge_arg=$2
+
+	# Merging side should be similar to applying this patch
+	git diff ...side >P.diff &&
+
+	# The corresponding conflicted merge
+	git reset --hard &&
+	git checkout main^0 &&
+	git merge --no-commit $merge_arg side &&
+	git ls-files -s >expect.ls &&
+	print_sanitized_conflicted_diff >expect.diff &&
+
+	# should apply successfully
+	git reset --hard &&
+	git checkout main^0 &&
+	git apply --index --3way $apply_arg P.diff &&
+	git ls-files -s >actual.ls &&
+	print_sanitized_conflicted_diff >actual.diff &&
+
+	# The result should resemble the corresponding merge
+	test_cmp expect.ls actual.ls &&
+	test_cmp expect.diff actual.diff
+}
+
+test_expect_success 'apply with --3way --ours' '
+	test_apply_with_3way_favoritism --ours -Xours
+'
+
+test_expect_success 'apply with --3way --theirs' '
+	test_apply_with_3way_favoritism --theirs -Xtheirs
+'
+
+test_expect_success 'apply with --3way --union' '
+	echo "* merge=union" >.gitattributes &&
+	test_apply_with_3way_favoritism --union &&
+	rm .gitattributes
+'
+
 test_expect_success 'apply with --3way with rerere enabled' '
 	test_config rerere.enabled true &&
 
-- 
2.46.0

