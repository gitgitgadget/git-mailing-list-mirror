Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B43DE454
	for <git@vger.kernel.org>; Tue, 26 May 2026 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792505; cv=none; b=UsX+bJneYmUkRsDqZ9Efvr94Ey9rt461SnhnC8S4bvuUwfxvG7CGCIekNN4He92nM1q0SqSqS/tEtlpNusPjc3jVnUpcePaKm6QEyYzXI1YQTA701rMAHd/NZWiM1sweTBbHbOlQiYHggVBTVGyierjGApwV1uhMhO769WVV1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792505; c=relaxed/simple;
	bh=HsOnnokSrWxwNTKyu+T5uRxZvw9u6L0zDtQdOH1uftU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyQOAIe5+a33V9ovvbm0hz/i1Yf8YBYgUbMMmbpZ4oH3LnoS14+3zdEgQbwWdQjgD8CSfnCPubdYPiqBqKsn/n1ZmnWC/7C4KNCM4Kt0+OUHkZxDIsTmjAJK/JK8/EVnWRNAM1Pm4x1uhQg2xIRYNCmXbj/LVTWPWbDW6H1bJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qq9OCs1T; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qq9OCs1T"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so11167556e87.2
        for <git@vger.kernel.org>; Tue, 26 May 2026 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792502; x=1780397302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pg5C4slb2xDZSD8WhEEcL/n8BweYwwDI6M4zpDqw6c=;
        b=qq9OCs1TLJ8OT25bH6guhl0fPVvxR03I3BZklhNIHd4sW1Y2OK6xQeVA9xh5lpacXv
         LpzDZr32b98I8/U001jWEPqpBr3psw7fKzLRnTiosrC1HpOznY5Eyq1YwTfK2g8nvGU/
         iDI0PgeGX9U4eE33eQPw1oyQi0KuMmI/XVM3YNJkvsgl2aC69ZbeQfY/v5JVCM6j5Klb
         SIex+XT/ucuMUIXfBAsc0PL/2xKo0zxnT6rypD17Ym4pNozo1pwHduQc8kiQa5WuL1NX
         7FbcZF7Xu1aLEvs0uTcThjl+O7/aXg28zCZF2ooX7xzFkOi65drLX6PTkIVXKjr/AG+O
         /rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792502; x=1780397302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pg5C4slb2xDZSD8WhEEcL/n8BweYwwDI6M4zpDqw6c=;
        b=jJkdXCq1EfctQ+7hyeMXIYNYNo7DBPKdX3feehLRptaEo1Orxm/GaOUc0an/nZ2L9B
         Ukfp1pj4oZtX8FtBEKvsw5vwDio3WibkicOYOhw4QbTI4Fk9M+sYfYFH8cLpPpglKik8
         ImxLT4KOveArvZCNe7bBtlvCREvFQyJVe0K8b9aGH9gCAtp+m8iY9LCfMG9akbqURiqa
         FV0A8B2HmFx+wpzq0X2I4Lq/7gN2lR182PfRA3bxvVINaaGikNRSbLE7iHz5GNtq2ihk
         l4jPKCioQZy2lCzCWsRfgobziQ/V24tnXnpBGbRzOkcLTbQCwKGTZhJ8jiSS3YQOY/eG
         nUzQ==
X-Gm-Message-State: AOJu0Yx0Mo6piKqPg/i6eF8OloWw+PZU6CHkXOMpg98jxmRE2iQTyjK3
	TbhtxF4v82BDKdbU4tobcv7ilwkKmXWmy5XO3GOITWUoplLFA3F9QLaKKu0UMA==
X-Gm-Gg: Acq92OFk+NVqUnSTFGqN2gX6CQ+84xx1r/DgNlUzc7rGt6eBV/K3KPeuBe2CSRaP6Vk
	RV/uZU0rQedG7v4yg994duV6yvysgVnr5D21/xzCoI6tweqnjhScyYMicZadoRNRH7tybS3yOdv
	bagmE92dtiBDFqAmK827+FaDPKwpyU+vs3JtXYhf4o+Lzayi/egUX5vL/R94DYTXuZepel2mDNO
	7pMb/wRObw1LXaeF11OH3+W9Lud8dXuDot8nD0exbjBc5+9FkENnmBzptmH96kcU5QteZv5LiRV
	qttTKWpvizRcDnmULGg58pDYRPVrymnaC0s49d4oPQszXc08HWVt+JJFvA5vKAJcNGw9kmQVOag
	uMNNRGIp5tKri763riK0itJEe6qZcF1X4GMl/aR4CNKqzU+jF2uXT2+DMGIeBnad2f+5wdiXTov
	u9Tjc+mpO3HJjY+q5oQSCeH5ZZVFdJuxsmmXFA/qaK22Nz69ZkzOZGUi/aY2E4C5eNWngdToUl3
	i6i3ntcq7F6RU5gmWHgE/gBnyJ7llMxeSvrfjGkfm+o+Vmj7y6DZOZWiTL3fkJ6yeHF+qJQLb8=
X-Received: by 2002:a05:6512:318d:b0:5a8:6e64:e88b with SMTP id 2adb3069b0e04-5aa32314419mr5208024e87.4.1779792501864;
        Tue, 26 May 2026 03:48:21 -0700 (PDT)
Received: from localhost ([2001:2043:be0a:d700:954c:d0e6:555c:211f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa463312b2sm348674e87.62.2026.05.26.03.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:48:21 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
From: erik@cervined.in
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	Erik Cervin-Edin <erik@cervined.in>
Subject: [PATCH v2 2/2] commit: allow -c/-C for all kinds of --fixup
Date: Tue, 26 May 2026 12:47:44 +0200
Message-ID: <b3fc743abf5d35fbb23c7483836de292ad5bffda.1779792311.git.erik@cervined.in>
X-Mailer: git-send-email 2.54.0.1014.g842965a2d5
In-Reply-To: <cover.1779792311.git.erik@cervined.in>
References: <20260518112225.73172-2-erik@cervined.in> <cover.1779792311.git.erik@cervined.in>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erik Cervin-Edin <erik@cervined.in>

The previous commit allowed -m and -F for all --fixup variations.  The
-c/-C flags were blocked by the same higher-layer incompatibility check
that previously caught -F, namely die_for_incompatible_opt4() grouping
them with --fixup.

Drop --fixup from that check and route the resolved commit through
prepare_amend_commit() in the fixup path, mirroring the no-message-source
behaviour of --fixup=amend.  With this in place, -m/-F/-c/-C all behave
consistently across the plain, amend, and reword --fixup forms.

Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
---
 Documentation/git-commit.adoc             |  9 ++--
 builtin/commit.c                          | 13 +++--
 t/t7500-commit-template-squash-signoff.sh | 60 +++++++++++++++++++++--
 3 files changed, 71 insertions(+), 11 deletions(-)

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
index 3f1fca2919..fcf148eb21 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -837,9 +837,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
@@ -851,6 +851,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
@@ -1341,7 +1346,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
 	die_for_incompatible_opt3(!!use_message, "-C",
 				  !!edit_message, "-c",
-				  !!fixup_message, "--fixup");
+				  !!logfile, "-F");
 	die_for_incompatible_opt4(have_option_m, "-m",
 				  !!edit_message, "-c",
 				  !!use_message, "-C",
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 01c7400136..48e1247d9e 100755
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
2.54.0.1014.g842965a2d5

