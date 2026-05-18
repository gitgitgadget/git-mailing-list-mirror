Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80C6301717
	for <git@vger.kernel.org>; Mon, 18 May 2026 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103428; cv=none; b=tFYTy+gBLac+7a9x+SiIItQGs3Fd8NjOLE8sVlGIwgiA6h64BMr+6lUi/5zAl15KqZG2bQoZoUKOfa0nQktcOdawSFVmgC0vvCOQL5UgsglKTHEYyTqHPZqGjTrDoYp2ADpN32c6C2xkAwXgQLV0fb+IH1HtMU6MFYlcN7fFSJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103428; c=relaxed/simple;
	bh=CO0f7a6nefu6Z7KTus8I+hChsPZe1q0vv6qnEzK2p0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl8SHPRlXIjta+AFEfT6FDqA+kjmWwM5koAFjTEo5M8ZGSD5b3aiPF+cG5ZTvOrWOSeQ5/g4/JOlHpXd/iIuB8dyQESzedXniozb/I76WzLv4OTkvtiqq0NnNR3xE2TWkNSlrTRf9MzAhFEHB6hatFkojD+PSKKzjo4Pa8JQTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUVd45xL; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUVd45xL"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8891febd2so3001470e87.1
        for <git@vger.kernel.org>; Mon, 18 May 2026 04:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779103420; x=1779708220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/mU+qyxi/Qsj2HoEMwx6Nsp4QC6YVrXSG83M/8trJY=;
        b=eUVd45xLIlqvLkPNZ7FQmNFx5nadPG/B02noZVLcrpSb7WD2J+I1UZaGIVfgLvU82K
         LJQQ2nZrrWVAxEulVorNXZjoCi12mSo6IMtAQ9+ZBKXRlOSq3ufBWbdsHHO0ulznkX2i
         Qo6TntGpNB8tKJCczP+kN99mhQ3KZZQPjaO0cgbuZT0Onpsq3vbgORkqV6pxDBX5Tmsx
         wv34/Tk3p60644YN/iInKyKah3ep8YGqmrynvXwpXqXLZ2HDQnOMo1XREsIGkTbRw+pc
         Rwf8jYi5KPZ5VJYpf4Y6ixvZaneDLPfxg2vVh83cexgAMskaPsxppeNx6Hxr/eBV4fGF
         BciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779103420; x=1779708220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/mU+qyxi/Qsj2HoEMwx6Nsp4QC6YVrXSG83M/8trJY=;
        b=ewJ/C0RIvTS/pN1vJI0cLyUV/yvw/xvQso2QB6tYlAjOHfzb9hRzq6Tm+ydyRrO06l
         1sOcAJjRlaa6+lCcuQJEfljUw4DuQ9QiV1BBuEbtYDR4pMB0kcyJGM9kbSlQIXDg5lO5
         0nJqGfnagVpjxcy5EDcKNot8KsN2ltCp8kxZI/9bU+CEuZaOSBtneQmeSmXye2a/fz4b
         CdmHSMCUuM1cRHJj8Meq/KiENhJZt55IB/cCE+5bL2t5mPBNlbYZ9E2WEfvrg4CDcRT9
         TQDpH67J+h9y8ZLsBeECTKn7thmJKliClzVALBMxKkPpo9xDeOgu9iRb4Xi4S4Ps65yy
         MpTQ==
X-Gm-Message-State: AOJu0Yx9OwuYZL0oqFNK3eSMjeX7RMP0YaI2dyMTJPMW/pMHXIi/6kcL
	Gmp9J3UWJYHBnaMkjkHY4r8n9AUZiceZQiVI6tmCOzAA3j7tV/MRfZiXcAxJQA==
X-Gm-Gg: Acq92OGFkwvV/YwSINnNrxSl3Ba5swVg3j3LkkkTTi+O/u6lSdtZapeLynqQbyGRQv/
	pcoZ9xQAf/VsPMdk26aESB7DNTV13DUPAOos85I6EEtR3eAN1nN4o8bDF+OrJKe6Q0oLV8nhqpY
	IAnp1c+URLxCTKNJktwZ5nglFWVhspLoqZWllPqs/70SLpd6p/xJg31dnEiYTGNDCoz7jJ8GCbe
	McSo0OVcwdlUnxW7SgmalYrXhg5MuUBBMWkzMDa4ZyytlE9UTviZHc1iGhrJsgR+zvUs/FrnsEr
	IkNmkzUQSn4AqfPoh0q6Z9R0ORrIT+hSwNqWvE0BRl4tTRyM2+ksJU/Y3eos9ZsX3RaPp+2hkgJ
	bmUbf8KH5nfsQ8oCbDLbcPr+FmMR+GPJXQReGiksbcoEFOkU3dCWyskwUXIMarZzCHrP8oNSb8l
	YxNlK1ZPibbnLgXW1lLWkWNIbwajILctUN6Ncv5h6c+5IpTGIF3KJVrCUNSQn97dWNWVoru6NwR
	/5tPSyv47W3E/aaS8foeeZzCN2WKf5kUkBsbxxyaphHobmvyvELHskx6Hy4wyBJ
X-Received: by 2002:a05:6512:3d88:b0:5a8:7f52:62d1 with SMTP id 2adb3069b0e04-5aa0e733f44mr5386138e87.1.1779103420248;
        Mon, 18 May 2026 04:23:40 -0700 (PDT)
Received: from localhost ([2001:2043:be0a:d700:1996:ae89:4512:3a7e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a91e2b6d78sm3230221e87.82.2026.05.18.04.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:23:39 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
From: erik@cervined.in
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	charvi077@gmail.com,
	Erik Cervin-Edin <erik@cervined.in>
Subject: [PATCH 1/1] commit: allow -m/-F with --fixup=amend: or reword:
Date: Mon, 18 May 2026 13:22:26 +0200
Message-ID: <20260518112225.73172-4-erik@cervined.in>
X-Mailer: git-send-email 2.54.0.772.g683d7313b1
In-Reply-To: <20260518112225.73172-2-erik@cervined.in>
References: <20260518112225.73172-2-erik@cervined.in>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erik Cervin-Edin <erik@cervined.in>

--fixup=amend: and --fixup=reword: require an editor to supply the
replacement commit message. The -m and -F flags are rejected: -m is
caught by a die() in prepare_to_commit(), and -F is caught by
die_for_incompatible_opt4() which groups -F with --fixup as mutually
exclusive. This makes these modes unusable in non-interactive
workflows -- notably AI coding agents.

When the amend suboption was introduced in 494d314a05 (commit: add
amend suboption to --fixup to create amend! commit, 2021-03-15),
-m support for amend fixups was discussed but not pursued, and -F
was already caught by the higher-layer incompatibility check grouping
it with --fixup.

Allow -m and -F to supply the replacement message body for amend and
reword fixups. When provided, bypass the editor and directly use the
user's message as the body, replacing the original commit's message. For
-F, the file contents are read into the message strbuf and then handled
identically to -m.

Plain --fixup (without amend: or reword:) continues to reject -F but
still accepts -m (even though it's practically a no-op).

Signed-off-by: Erik Cervin Edin <erik@cervined.in>
---
 Documentation/git-commit.adoc             | 13 +++--
 builtin/commit.c                          | 41 ++++++++++----
 t/t7500-commit-template-squash-signoff.sh | 67 +++++++++++++++++++----
 3 files changed, 92 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index 8329c1034b..9478d5d265 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -111,12 +111,13 @@ commit, but the additional commentary will be thrown away once the
 The commit created by `--fixup=amend:<commit>` is similar but its
 title is instead prefixed with "amend!". The log message of
 _<commit>_ is copied into the log message of the "amend!" commit and
-opened in an editor so it can be refined. When `git rebase
---autosquash` squashes the "amend!" commit into _<commit>_, the
-log message of _<commit>_ is replaced by the refined log message
-from the "amend!" commit. It is an error for the "amend!" commit's
-log message to be empty unless `--allow-empty-message` is
-specified.
+opened in an editor so it can be refined. The replacement message may
+also be supplied directly using `-m` or `-F`, bypassing the need to open
+an editor. When `git rebase --autosquash` squashes the "amend!" commit
+into _<commit>_, the log message of _<commit>_ is replaced by the
+refined log message from the "amend!" commit. It is an error for the
+"amend!" commit's log message to be empty unless `--allow-empty-message`
+is specified.
 +
 `--fixup=reword:<commit>` is shorthand for `--fixup=amend:<commit>
  --only`. It creates an "amend!" commit with only a log message
diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..269c2d782b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -837,21 +837,19 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg1 = "message";
 
 		/*
-		 * Only `-m` commit message option is checked here, as
-		 * it supports `--fixup` to append the commit message.
-		 *
-		 * The other commit message options `-c`/`-C`/`-F` are
-		 * incompatible with all the forms of `--fixup` and
-		 * have already errored out while parsing the `git commit`
-		 * options.
+		 * `-m` (and `-F`, converted to `-m` earlier for
+		 * amend/reword) appends the message body here.
+		 * `-c`/`-C` are still incompatible with all forms
+		 * of `--fixup`.
 		 */
 		if (have_option_m && !strcmp(fixup_prefix, "fixup"))
 			strbuf_addbuf(&sb, &message);
 
 		if (!strcmp(fixup_prefix, "amend")) {
 			if (have_option_m)
-				die(_("options '%s' and '%s:%s' cannot be used together"), "-m", "--fixup", fixup_message);
-			prepare_amend_commit(commit, &sb, &ctx);
+				strbuf_addbuf(&sb, &message);
+			else
+				prepare_amend_commit(commit, &sb, &ctx);
 		}
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
 		size_t merge_msg_start;
@@ -1338,10 +1336,12 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	}
 	if (fixup_message && squash_message)
 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
-	die_for_incompatible_opt4(!!use_message, "-C",
+	die_for_incompatible_opt3(!!use_message, "-C",
 				  !!edit_message, "-c",
-				  !!logfile, "-F",
 				  !!fixup_message, "--fixup");
+	die_for_incompatible_opt3(!!use_message, "-C",
+				  !!edit_message, "-c",
+				  !!logfile, "-F");
 	die_for_incompatible_opt4(have_option_m, "-m",
 				  !!edit_message, "-c",
 				  !!use_message, "-C",
@@ -1410,6 +1410,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		}
 	}
 
+	if (logfile && fixup_message && !strcmp(fixup_prefix, "fixup"))
+		die(_("options '%s' and '%s' cannot be used together"), "-F", "--fixup");
+
 	if (0 <= edit_flag)
 		use_editor = edit_flag;
 
@@ -1821,6 +1824,22 @@ int cmd_commit(int argc,
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
+
+	if (logfile && fixup_message && !strcmp(fixup_prefix, "amend")) {
+		if (!strcmp(logfile, "-")) {
+			if (isatty(0))
+				fprintf(stderr, _("(reading log message from standard input)\n"));
+			if (strbuf_read(&message, 0, 0) < 0)
+				die_errno(_("could not read log from standard input"));
+		} else {
+			if (strbuf_read_file(&message, logfile, 0) < 0)
+				die_errno(_("could not read log file '%s'"), logfile);
+		}
+		strbuf_complete_line(&message);
+		have_option_m = 1;
+		FREE_AND_NULL(logfile);
+	}
+
 	if (trailer_args.nr)
 		trailer_config_init();
 
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 66aff8e097..b7579ad789 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -384,18 +384,28 @@ test_expect_success '--fixup=reword: ignores staged changes' '
 	test_cmp foo actual
 '
 
-test_expect_success '--fixup=reword: error out with -m option' '
+test_expect_success '--fixup=amend: with -m option' '
 	commit_for_rebase_autosquash_setup &&
-	echo "fatal: options '\''-m'\'' and '\''--fixup:reword'\'' cannot be used together" >expect &&
-	test_must_fail git commit --fixup=reword:HEAD~ -m "reword commit message" 2>actual &&
-	test_cmp expect actual
+	cat >expected <<-EOF &&
+	amend! $(git log -1 --format=%s HEAD~)
+
+	amend commit message
+	EOF
+	git commit --fixup=amend:HEAD~ -m "amend commit message" &&
+	get_commit_msg HEAD >actual &&
+	test_cmp expected actual
 '
 
-test_expect_success '--fixup=amend: error out with -m option' '
+test_expect_success '--fixup=reword: with -m option' '
 	commit_for_rebase_autosquash_setup &&
-	echo "fatal: options '\''-m'\'' and '\''--fixup:amend'\'' cannot be used together" >expect &&
-	test_must_fail git commit --fixup=amend:HEAD~ -m "amend commit message" 2>actual &&
-	test_cmp expect actual
+	cat >expected <<-EOF &&
+	amend! $(git log -1 --format=%s HEAD~)
+
+	reword commit message
+	EOF
+	git commit --fixup=reword:HEAD~ -m "reword commit message" &&
+	get_commit_msg HEAD >actual &&
+	test_cmp expected actual
 '
 
 test_expect_success 'consecutive amend! commits remove amend! line from commit msg body' '
@@ -432,6 +442,12 @@ test_expect_success 'deny to create amend! commit if its commit msg body is empt
 	test_cmp expected actual
 '
 
+test_expect_success '--fixup=amend: -m with empty message aborts' '
+	commit_for_rebase_autosquash_setup &&
+	test_must_fail git commit --fixup=amend:HEAD~ -m "" 2>err &&
+	test_grep "empty commit message body" err
+'
+
 test_expect_success 'amend! commit allows empty commit msg body with --allow-empty-message' '
 	commit_for_rebase_autosquash_setup &&
 	cat >expected <<-EOF &&
@@ -468,10 +484,37 @@ test_expect_success '--fixup=reword: give error with pathsec' '
 	test_cmp expect actual
 '
 
-test_expect_success '--fixup=reword: -F give error message' '
-	echo "fatal: options '\''-F'\'' and '\''--fixup'\'' cannot be used together" >expect &&
-	test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
-	test_cmp expect actual
+test_expect_success '--fixup=reword: with -F option' '
+	commit_for_rebase_autosquash_setup &&
+	echo "message from file" >msgfile &&
+	cat >expected <<-EOF &&
+	amend! $(git log -1 --format=%s HEAD~)
+
+	message from file
+	EOF
+	git commit --fixup=reword:HEAD~ -F msgfile &&
+	get_commit_msg HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--fixup=amend: with -F option' '
+	commit_for_rebase_autosquash_setup &&
+	echo "amend message from file" >msgfile &&
+	cat >expected <<-EOF &&
+	amend! $(git log -1 --format=%s HEAD~)
+
+	amend message from file
+	EOF
+	git commit --fixup=amend:HEAD~ -F msgfile &&
+	get_commit_msg HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '-F with plain --fixup still errors' '
+	commit_for_rebase_autosquash_setup &&
+	echo "message" >msgfile &&
+	test_must_fail git commit --fixup HEAD~ -F msgfile 2>err &&
+	test_grep "cannot be used together" err
 '
 
 test_expect_success 'commit --squash works with -F' '
-- 
2.54.0.772.g683d7313b1

