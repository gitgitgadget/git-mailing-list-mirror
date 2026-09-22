Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD74544D55
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082464; cv=none; b=OnlFk7qNILcKQBwNOt9TAWLOfz5HN40imnXXtuZxSYzbFoSgIFtUJV3LMvfCxCvIL3dwdONc0QYgaNhhKuZvqRPegqsAq7cQbHMvdWSPJeMEQkK4PA2Mr4h75r2qgtFPIipsTchjC73G6+jaxPY9zYHZaMHGNpjznEB8iSmyjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082464; c=relaxed/simple;
	bh=8V6VHeiTw6j467Q92ydBvBCnF3F+xldOblF5Fsk18pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wo7dx7Qc/M0Vdl84tgesLhHO7cU/FfAL8BGngKIDkUFjASzXSPj7MfXMH/7S2vl9Hu4qPefmaAoxWWvcPxAGdcZFIlQ20vuIlGtiq8eYC6UT23EeOYXJAxzwAWXrINChN5Kr5eu54ObxcTXtprOicYdOtIlkFIbugl7GPd0IauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzMRI8bQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzMRI8bQ"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b76694fb7aso859138e87.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790082459; x=1790687259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yG9KgJOel0Qs6o4TnLlUm2cEm6X1jZgwKplItFMHBAs=;
        b=WzMRI8bQCfJiavVRl519L22HEm33IVHVlnZN4DF05ZJmIqnl6EU47SFs9zn+tDhDyT
         zPvrmD9y5I16Zc6ILijhW/4q+S0SG1sP4LZne+scPeAcgd21LC3EKTI/kVqopj1dZn3C
         y4mRc0GIX3DWIckSwNCEICWscuwIF3mgBYCQi1lcZlAZSJNzVvbCjlBKHvwU6AXukbpQ
         eW1ESI1QzpNqpuWSp2JCca5g7McEZDlOaCWtTAQEVm5SRXT+suti5PtRa+cIaEhk6OxS
         sFnLtBCVvj6JaRQyoL6bivz+dxXYIa5clPV2B76giPVt9y0EYUZCUhOFu8mOrWNj9t/G
         +B9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082459; x=1790687259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yG9KgJOel0Qs6o4TnLlUm2cEm6X1jZgwKplItFMHBAs=;
        b=s/ih1K+iVE8FopiWtstaYjHGC1TIfQZOeqOKQdx2sXxsNIvaU+7lRv4httl8/Ee9KO
         MOQFMsG8zn/q6Gd4PPZW3nNtzc3VHyzH14BHSHvrXS+jCJnLyzCyqIQ6uqLoX5b4EmJY
         yASrZBSaKWhiVivMBZ/55rvJIuxDgHgEPgObW3IzX/oB1XP6aClCaABbCmHn49cUnkxU
         1tdCUETR3Uxig+wqvetUO2tQ9/x9VBWeCpSPOpP53GD8UMlcQqDsPunrNnoaVlOFNgXV
         2N8NLjeYAC+3NQpw0S8BP5fLHNKksm0p8wi0FJeDwrnn5KfNILimkspGPn2eImw4KbTd
         dLvw==
X-Gm-Message-State: AFuF++k70gU2RbAYDm0ibHKEBSrxdOsOmtapLXZAzhAzKio6UGNfUvlc
	wystIjeeCSqTOfCutIr0KIvu22ky+EQmqIpZK5DfFVCHQZUFzxKOaIhF/xwsVg==
X-Gm-Gg: AYBFou1Mwx+cWw9XVJdWaZ/Vdvz1HeasKopXPbTqR/mJmUYoO4pH5nocHu3eitkJWCB
	9rwBd17r4ka8zsPr+MPYs5lcaU+w2PMbrm+b1jj3hEaFXfmR40CnAhIQ3Mb6JJkxHsOtEvRrCv5
	ABdZk5HuOtYu/VS9C2siexfR4pi2al+VbrFN1pslw4tEAo7I5feG3tMZCAFHbXqtnk8Sso6lM4M
	5+jmRNZWcoub9+pOAZZkBfcf6+5LgML9y1wKHWwm9L1Slcw29ScJC6DJw7gyKnl6BD+WBklYguu
	/klOsg71WVFd00BfwFW4P6XGvuz3W5w3Yj8vNyYc3im8Ueh0VHeBuhdOHy3hB65dUrKbeji9629
	9fQ9sHkQzvKimvfZ5tkZJtFCZHWkprogyP52JPgdsHXP7eONKVkmp0Lq9cjeaCgK2fwjxJ0+IBM
	5POK04cbvAktTIzO1eO9asUnYkmp2yP97sgfNhvD5BjcY4b95x+E0JIA+IW+Yny+QogBGezSj3m
	dhwrXf+issiUIQBCFm0v+0+D2f4uoqD4sOSlhStpSTzgSXfKcPu7NOBGdFYJXjP8uul+Or2NkG1
	YTIwf+ZQP+3s4NbUDCbArVQ=
X-Received: by 2002:a05:6512:12cd:b0:5b4:ab0c:f606 with SMTP id 2adb3069b0e04-5b8d28ebc87mr830595e87.2.1790082459141;
        Tue, 22 Sep 2026 06:07:39 -0700 (PDT)
Received: from localhost ([185.104.15.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a627d284c6sm5536521fa.11.2026.09.22.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:07:38 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
From: erik@cervined.in
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	Erik Cervin-Edin <erik@cervined.in>
Subject: [PATCH v3 2/2] commit: allow -c/-C for all kinds of --fixup
Date: Tue, 22 Sep 2026 15:04:37 +0200
Message-ID: <39e408e14718f533edc6ed2de6ff41ed961c6e05.1790082176.git.erik@cervined.in>
X-Mailer: git-send-email 2.55.0.770.g0473647dd8
In-Reply-To: <cover.1790082176.git.erik@cervined.in>
References: <cover.1779792311.git.erik@cervined.in> <cover.1790082176.git.erik@cervined.in>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erik Cervin-Edin <erik@cervined.in>

The fixup code path in prepare_to_commit() only knows how to take a
message body from -m or -F.  Now that the previous commit allows -m and
-F for all --fixup variations, -c/-C are the odd ones out.

Teach the fixup path to look up the ref given to -c/-C and seed its
message when preparing to amend the commit, mirroring what --fixup=amend
does when no message source is given.  With this in place, -m/-F/-c/-C
all behave consistently across the plain, amend, and reword --fixup
forms.

The incompatibility check grouping -C, -c, and --fixup can go away
entirely, as -C and -c are already rejected together by the check that
groups them with -m and -F.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
---
 Documentation/git-commit.adoc             |  9 ++--
 builtin/commit.c                          | 14 +++---
 t/t7500-commit-template-squash-signoff.sh | 60 +++++++++++++++++++++--
 3 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index 61efd29e66..98c50a3be5 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -102,8 +102,8 @@ include::diff-context-options.adoc[]
 +
 The commit created by plain `--fixup=<commit>` has a title
 composed of "fixup!" followed by the title of _<commit>_,
-and is recognized specially by `git rebase --autosquash`. The `-m`
-or `-F` option may be used to supplement the log message
+and is recognized specially by `git rebase --autosquash`. The `-m`,
+`-F`, `-C`, or `-c` option may be used to supplement the log message
 of the created commit, but the additional commentary will be thrown
 away once the "fixup!" commit is squashed into _<commit>_ by
 `git rebase --autosquash`.
@@ -112,8 +112,9 @@ The commit created by `--fixup=amend:<commit>` is similar but its
 title is instead prefixed with "amend!". The log message of
 _<commit>_ is copied into the log message of the "amend!" commit and
 opened in an editor so it can be refined. The replacement message may
-also be supplied directly using `-m` or `-F`, bypassing the
-need to open an editor. When `git rebase
+also be supplied directly using `-m`, `-F`, or `-C`, bypassing the
+need to open an editor, or using `-c` to open the editor pre-populated
+with the referenced commit's message. When `git rebase
 --autosquash` squashes the "amend!" commit into _<commit>_, the log
 message of _<commit>_ is replaced by the refined log message from the
 "amend!" commit. It is an error for the "amend!" commit's log message
diff --git a/builtin/commit.c b/builtin/commit.c
index ffb8644653..25341cc3e7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -849,9 +849,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg1 = "message";
 
 		/*
-		 * Only `-m` and `-F` are handled here. `-c`/`-C` are
-		 * incompatible with --fixup and have already errored out
-		 * during option parsing.
+		 * `-m`, `-F`, `-C`, and `-c` provide the message body.
+		 * If none was given and this is an amend, use the target
+		 * commit's body instead.
 		 */
 		if (have_option_m) {
 			strbuf_addbuf(&sb, &message);
@@ -863,6 +863,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		} else if (logfile) {
 			if (strbuf_read_file(&sb, logfile, 0) < 0)
 				die_errno(_("could not read log file '%s'"), logfile);
+		} else if (use_message) {
+			struct commit *c = lookup_commit_reference_by_name(use_message);
+			if (!c)
+				die(_("could not lookup commit '%s'"), use_message);
+			prepare_amend_commit(c, &sb, &ctx);
 		} else if (!strcmp(fixup_prefix, "amend")) {
 			prepare_amend_commit(commit, &sb, &ctx);
 		}
@@ -1366,9 +1371,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	}
 	if (fixup_message && squash_message)
 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
-	die_for_incompatible_opt3(!!use_message, "-C",
-				  !!edit_message, "-c",
-				  !!fixup_message, "--fixup");
 	die_for_incompatible_opt4(have_option_m, "-m",
 				  !!edit_message, "-c",
 				  !!use_message, "-C",
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 9b2ecb1356..de3221ea52 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -492,6 +492,62 @@ test_expect_success 'commit --fixup works with -F' '
 	EOF
 '
 
+test_expect_success 'commit --fixup works with -C' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --fixup HEAD~ -C HEAD &&
+	test_commit_message HEAD <<-EOF
+	fixup! $(git log -1 --format=%s HEAD~2)
+
+	$(get_commit_msg HEAD~)
+	EOF
+'
+
+test_expect_success 'commit --fixup=amend: works with -c' '
+	commit_for_rebase_autosquash_setup &&
+	test_set_editor : &&
+	git commit --fixup=amend:HEAD -c HEAD~ &&
+	test_commit_message HEAD <<-EOF
+	amend! intermediate commit
+
+	target message subject line
+
+	target message body line 1
+	target message body line 2
+	EOF
+'
+
+test_expect_success 'commit --fixup=amend:HEAD with -C HEAD and without have the same message' '
+	commit_for_rebase_autosquash_setup &&
+	start=$(git rev-parse HEAD) &&
+
+	git commit --fixup=amend:HEAD -C HEAD &&
+	git commit --fixup=amend:HEAD -C HEAD &&
+	git log -1 --pretty=%B >with-c &&
+
+	git reset --hard "$start" &&
+	test_set_editor : &&
+	git commit --fixup=amend:HEAD &&
+	git commit --fixup=amend:HEAD &&
+	git log -1 --pretty=%B >without-c &&
+
+	test_cmp with-c without-c
+'
+
+test_expect_success 'commit --fixup=amend: with -C copies full subject + body of squash commit' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --squash HEAD~ -m "inner body" &&
+	echo "extra" >>foo &&
+	git add foo &&
+	git commit --fixup=amend:HEAD -C HEAD &&
+	test_commit_message HEAD <<-EOF
+	amend! squash! $(git log -1 --format=%s HEAD~3)
+
+	squash! $(git log -1 --format=%s HEAD~3)
+
+	inner body
+	EOF
+'
+
 test_expect_success 'commit --fixup=reword: works with -F' '
 	commit_for_rebase_autosquash_setup &&
 	echo "message from file" >msgfile &&
@@ -553,9 +609,7 @@ test_expect_success 'invalid message options when using --fixup' '
 	echo changes >>foo &&
 	echo "message" >log &&
 	git add foo &&
-	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2 &&
-	test_must_fail git commit --fixup HEAD~1 -C HEAD~2 &&
-	test_must_fail git commit --fixup HEAD~1 -c HEAD~2
+	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2
 '
 
 cat >expected-template <<EOF
-- 
2.55.0.770.g0473647dd8

