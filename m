Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B217C9F7
	for <git@vger.kernel.org>; Thu, 30 May 2024 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076638; cv=none; b=b4era7dLXTOqQw2ZKCSXnTjTfKERgBpjJoOsk+eIc2Vbh9uvgloiwNGKHM1foigoUneb9d4x03sGzI7O8PwfpNTTwzem/mIg9NqK8HFAJbCusiN+8wCoq4YOsNRZxOGxO/RIYlTG2ZUkoWVkGPXE8PQTzs5RhrvG82RaE9u+nJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076638; c=relaxed/simple;
	bh=ZNZLd+skaTak7Qg1XsfYufC7C9JhpIlUsvlPHXVnXTw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gWKk2OdTXnnboZ5QW/85s3hH1o04qvNOTrjr+mtxNpToFLDxnIlzhvTzz7d7SlHj6gA/ZDrYnai/hBgqZ9xuZxKI1KRUeKXL3SIHTBDIq5GG498QXUcAmp3go6KXUQfJd1xBInl17t/XNczkRWLJ9BS6lXzR9KcNoy3iHzZ89Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvaEKp5Z; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvaEKp5Z"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-354f14bd80cso596322f8f.1
        for <git@vger.kernel.org>; Thu, 30 May 2024 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717076634; x=1717681434; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiegT6MHJWRZf/ZHUjF7tc4JVjQVHslRBVlUDHzwZQU=;
        b=QvaEKp5ZbHWZFbojJX/dpKrd0xqRdfaCIYGyumRw4r34W+2wpVJ24uxMjYW5Dm6iy8
         dZkowFuf74g6viTOCEe2P1WLhOMdqUE9enQIh9iJAYyJzJ1L9xQ9MtE0VDSogrhRdOdw
         yE7V6APbr9KBKtJjL1fP6DHVwwPHxTb+e3pG/ViS/wa1AUbtYrefCTl6ISn0DjIJrfRN
         94LvX0XPVeehrN4lzj76vy8xJ5z8PEmwG4VKuDch17YwvJsrRy7Y4HpDQv5XfLx2mEXv
         xFAnkRSzs+9mgbOAV2XNp7E7E7r+2DNqjpRiWVRo8PylB6l7C0O65sQptqjfS2qPwkqa
         rNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717076634; x=1717681434;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiegT6MHJWRZf/ZHUjF7tc4JVjQVHslRBVlUDHzwZQU=;
        b=p0S20cEBR/oaXNGdwQzQobaMr6rCKylb8O/iBky+zv3+w/Qj5e7rEKcN3R0yI8SRL+
         +288u0M0xW/05cbXwFZhuH1z/DpIbKjHX4KeaNgy5/MOlts+FEHNKev0BcGY3huHvAdz
         QlwQGbgevoWnvDX+mYkkwv7JfxQZrzJhNNlKpcrHTrFqaNTHv9fSGNHNnrhwQTAzH6nL
         3o1XzRp/Nyv9S802qeiQMUt0U8XiK2mole2XJUFHDYZfist8sOm3KO/gdZG+y2zeEUow
         +uUm/zY4uuqxH37uDGS2r38iBR03GoG2TddW4W8Jhmo+1Ccboxt5tbj64ycycQLgB/w/
         es9w==
X-Gm-Message-State: AOJu0Yxe63QV9ru+o8OB4TU0oq0KWIhjXUk2sMcZrwcZBn3V3LEo1HLp
	uJj94G4TaVgIEdYJ/VjGDCOBvMFZprvLv+Ovcr/NAtIUhCbWJU/JKLlOUw==
X-Google-Smtp-Source: AGHT+IFdxS/Hiy2L15VJqGwIaWv4kMCuzQA6TJ6jdNVjlBFuuniSJ6ipzzERl49Ue04FwFZcbOvxiQ==
X-Received: by 2002:adf:a309:0:b0:354:be7c:954 with SMTP id ffacd0b85a97d-35dc00919fbmr1644619f8f.15.1717076634178;
        Thu, 30 May 2024 06:43:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-358c0acf7d5sm12110579f8f.7.2024.05.30.06.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:43:53 -0700 (PDT)
Message-Id: <86052416b22143a5c71ad011ca8d6e4cf80bcc50.1717076630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1672.v3.git.1717076630.gitgitgadget@gmail.com>
References: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
	<pull.1672.v3.git.1717076630.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 May 2024 13:43:50 +0000
Subject: [PATCH v3 2/2] rebase -i: improve error message when picking merge
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Stefan Haller <lists@haller-berlin.de>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The only todo commands that accept a merge commit are "merge" and
"reset". All the other commands like "pick" or "reword" fail when they
try to pick a a merge commit and print the message

    error: commit abc123 is a merge but no -m option was given.

followed by a hint about the command being rescheduled. This message is
designed to help the user when they cherry-pick a merge and forget to
pass "-m". For users who are rebasing the message is confusing as there
is no way for rebase to cherry-pick the merge.

Improve the user experience by detecting the error and printing some
advice on how to fix it when the todo list is parsed rather than waiting
for the "pick" command to fail. The advice recommends "merge" rather
than "exec git cherry-pick -m ..." on the assumption that cherry-picking
merges is relatively rare and it is more likely that the user chose
"pick" by a mistake.

It would be possible to support cherry-picking merges by allowing the
user to pass "-m" to "pick" commands but that adds complexity to do
something that can already be achieved with

    exec git cherry-pick -m1 abc123

Reported-by: Stefan Haller <lists@haller-berlin.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/config/advice.txt |  2 ++
 advice.c                        |  1 +
 advice.h                        |  1 +
 sequencer.c                     | 63 +++++++++++++++++++++++++++++++--
 t/t3404-rebase-interactive.sh   | 45 +++++++++++++++++++++++
 5 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 0e35ae5240f..fa612417568 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -96,6 +96,8 @@ advice.*::
 		`pushNonFFCurrent`, `pushNonFFMatching`, `pushAlreadyExists`,
 		`pushFetchFirst`, `pushNeedsForce`, and `pushRefNeedsUpdate`
 		simultaneously.
+	rebaseTodoError::
+		Shown when there is an error after editing the rebase todo list.
 	refSyntax::
 		Shown when the user provides an illegal ref name, to
 		tell the user about the ref syntax documentation.
diff --git a/advice.c b/advice.c
index 0a122c2020b..558a46fc0b3 100644
--- a/advice.c
+++ b/advice.c
@@ -70,6 +70,7 @@ static struct {
 	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName" },
 	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected" },
 	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward" }, /* backwards compatibility */
+	[ADVICE_REBASE_TODO_ERROR]			= { "rebaseTodoError" },
 	[ADVICE_REF_SYNTAX]				= { "refSyntax" },
 	[ADVICE_RESET_NO_REFRESH_WARNING]		= { "resetNoRefresh" },
 	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict" },
diff --git a/advice.h b/advice.h
index c8d29f97f39..5105d90129d 100644
--- a/advice.h
+++ b/advice.h
@@ -37,6 +37,7 @@ enum advice_type {
 	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
 	ADVICE_PUSH_UPDATE_REJECTED,
 	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
+	ADVICE_REBASE_TODO_ERROR,
 	ADVICE_REF_SYNTAX,
 	ADVICE_RESET_NO_REFRESH_WARNING,
 	ADVICE_RESOLVE_CONFLICT,
diff --git a/sequencer.c b/sequencer.c
index 7ab465da14a..ee209c46417 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2626,7 +2626,61 @@ static int check_label_or_ref_arg(enum todo_command command, const char *arg)
 	return 0;
 }
 
-static int parse_insn_line(struct repository *r, struct replay_opts *opts UNUSED,
+static int check_merge_commit_insn(enum todo_command command)
+{
+	switch(command) {
+	case TODO_PICK:
+		error(_("'%s' does not accept merge commits"),
+		      todo_command_info[command].str);
+		advise_if_enabled(ADVICE_REBASE_TODO_ERROR, _(
+			/*
+			 * TRANSLATORS: 'pick' and 'merge -C' should not be
+			 * translated.
+			 */
+			"'pick' does not take a merge commit. If you wanted to\n"
+			"replay the merge, use 'merge -C' on the commit."));
+		return -1;
+
+	case TODO_REWORD:
+		error(_("'%s' does not accept merge commits"),
+		      todo_command_info[command].str);
+		advise_if_enabled(ADVICE_REBASE_TODO_ERROR, _(
+			/*
+			 * TRANSLATORS: 'reword' and 'merge -c' should not be
+			 * translated.
+			 */
+			"'reword' does not take a merge commit. If you wanted to\n"
+			"replay the merge and reword the commit message, use\n"
+			"'merge -c' on the commit"));
+		return -1;
+
+	case TODO_EDIT:
+		error(_("'%s' does not accept merge commits"),
+		      todo_command_info[command].str);
+		advise_if_enabled(ADVICE_REBASE_TODO_ERROR, _(
+			/*
+			 * TRANSLATORS: 'edit', 'merge -C' and 'break' should
+			 * not be translated.
+			 */
+			"'edit' does not take a merge commit. If you wanted to\n"
+			"replay the merge, use 'merge -C' on the commit, and then\n"
+			"'break' to give the control back to you so that you can\n"
+			"do 'git commit --amend && git rebase --continue'."));
+		return -1;
+
+	case TODO_FIXUP:
+	case TODO_SQUASH:
+		return error(_("cannot squash merge commit into another commit"));
+
+	case TODO_MERGE:
+		return 0;
+
+	default:
+		BUG("unexpected todo_command");
+	}
+}
+
+static int parse_insn_line(struct repository *r, struct replay_opts *opts,
 			   struct todo_item *item, const char *buf,
 			   const char *bol, char *eol)
 {
@@ -2732,7 +2786,12 @@ static int parse_insn_line(struct repository *r, struct replay_opts *opts UNUSED
 		return status;
 
 	item->commit = lookup_commit_reference(r, &commit_oid);
-	return item->commit ? 0 : -1;
+	if (!item->commit)
+		return -1;
+	if (is_rebase_i(opts) &&
+	    item->commit->parents && item->commit->parents->next)
+		return check_merge_commit_insn(item->command);
+	return 0;
 }
 
 int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *action)
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d1bead61fad..f92baad1381 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2215,6 +2215,51 @@ test_expect_success 'bad labels and refs rejected when parsing todo list' '
 	test_path_is_missing execed
 '
 
+test_expect_success 'non-merge commands reject merge commits' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout E &&
+	git merge I &&
+	oid=$(git rev-parse HEAD) &&
+	cat >todo <<-EOF &&
+	pick $oid
+	reword $oid
+	edit $oid
+	fixup $oid
+	squash $oid
+	EOF
+	(
+		set_replace_editor todo &&
+		test_must_fail git rebase -i HEAD 2>actual
+	) &&
+	cat >expect <<-EOF &&
+	error: ${SQ}pick${SQ} does not accept merge commits
+	hint: ${SQ}pick${SQ} does not take a merge commit. If you wanted to
+	hint: replay the merge, use ${SQ}merge -C${SQ} on the commit.
+	hint: Disable this message with "git config advice.rebaseTodoError false"
+	error: invalid line 1: pick $oid
+	error: ${SQ}reword${SQ} does not accept merge commits
+	hint: ${SQ}reword${SQ} does not take a merge commit. If you wanted to
+	hint: replay the merge and reword the commit message, use
+	hint: ${SQ}merge -c${SQ} on the commit
+	hint: Disable this message with "git config advice.rebaseTodoError false"
+	error: invalid line 2: reword $oid
+	error: ${SQ}edit${SQ} does not accept merge commits
+	hint: ${SQ}edit${SQ} does not take a merge commit. If you wanted to
+	hint: replay the merge, use ${SQ}merge -C${SQ} on the commit, and then
+	hint: ${SQ}break${SQ} to give the control back to you so that you can
+	hint: do ${SQ}git commit --amend && git rebase --continue${SQ}.
+	hint: Disable this message with "git config advice.rebaseTodoError false"
+	error: invalid line 3: edit $oid
+	error: cannot squash merge commit into another commit
+	error: invalid line 4: fixup $oid
+	error: cannot squash merge commit into another commit
+	error: invalid line 5: squash $oid
+	You can fix this with ${SQ}git rebase --edit-todo${SQ} and then run ${SQ}git rebase --continue${SQ}.
+	Or you can abort the rebase with ${SQ}git rebase --abort${SQ}.
+	EOF
+	test_cmp expect actual
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
gitgitgadget
