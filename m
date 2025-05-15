Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25115278160
	for <git@vger.kernel.org>; Thu, 15 May 2025 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747275633; cv=none; b=gW1tBJG2eMQ9jtYdvueB6iUvjUbsUlaJfbhi0IuhoHVKTaO8GXFugM4JwC9RDXakS6TB2QryfK+fpRsBC2wWZkB/iFPcpzqPon87P+kxvYDhJh7XckM4YXyIjk6RjXhkistR76iGpPkJ9hG0NR8oc6HBSHcPwcrGTEWDGbg+uF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747275633; c=relaxed/simple;
	bh=e69epfAudHAXsoZtjpqwqNDtXyjzvW9d6uk3kKD8W40=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fIG+ddfZfjAdTGZVZomZnavcHYQXYpb9Imn9G75XAjbubWC4o5GaS+xUoncz4beWwBiIleANXJERWD4zpHMQsgle22IYLxQTg5Dr50QQr2Ct/656fB84O+I7LIpxpxQ2IaQmlblkvGaDadXbqiFAuT1I4EdGPmwTg/SSvOgXmtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJqTEHi4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJqTEHi4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442f5b3c710so3487695e9.1
        for <git@vger.kernel.org>; Wed, 14 May 2025 19:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747275629; x=1747880429; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GEcR9qyJQaS5Ai90AsOhomLK3ZEA44GwskJE4MyH2VU=;
        b=XJqTEHi4v/4t8VYP4wUhIBriHLTAE2UnS2QglY4h6axukFigZj6ZZ1MOGx59lqqGYL
         19l8dUa1t8DF9RG5WXVtxAPbXiJvd0H4xmcZ0KXat0S0yN64FZYF/RnW70bkPNhoH4KC
         53n7u+NBtfAJ97DlJhSKqwmMNNl9wDKhHJwFuRdTdzo7rd+YJO9x0AGYZB6sPrzQfwJ+
         4HZ2PPwahkDj8key4w3FNcU8GRDWmkZG/rJ+e0t2mHLySIULu8dyKA8R692NOx8pes4i
         hpyEGpm7oIHhzEDIAhbfScpqjli3b3c56l32azgvvLUW9FpL3PK84Bhtm2cWZ4WHT9rW
         rELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747275629; x=1747880429;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEcR9qyJQaS5Ai90AsOhomLK3ZEA44GwskJE4MyH2VU=;
        b=wSQGkRgrARWLufEcZK6zlwSa4QdiB7NyiEYAg4HNv0Ittk6t1WNaC0jEZELx9ker2E
         Lgg4IVFhPNkRGo6YAi+jz2ovU8dIZE21XAKEAhZo2ANYA1O+1n4i1A3DvOaEySe1l7yy
         2yq4V4WZdGj9tfXgG+A9lieEEGVj0UlmcNc9nX1C59ypxUE/nyZ80rOt0HKipkUXoxu6
         Mtayo5ngP2E0rq00BhJvXQOtLm4sC8+NpOOKGuXCnCKtVNEY5jca8d7eAv/teh/RLLba
         CMicqDe/khDDYULah+Wc+RG7JNT7NlEzWBLM+JOnHnxIXsQQjoCPDXnmjvTR+HoqawP9
         UehQ==
X-Gm-Message-State: AOJu0Yw6pf1CVI2/t9I/4efPx23wlQ02kInC3voIuJCEXNmZZI4zulGe
	KGH9milFvgFX79gRfrWvGPXblwZCRGCjeudjn9waPtnfGxNh8TYONRDbHA==
X-Gm-Gg: ASbGncufZrI2pQUMsk78JZCA+8wPWOmbh7XfdlkDL0z37GtBB5yIx29bCgq/v3awX1H
	OKNc42nfNW1RxeldUR7Stzy7oc6c2CoNX/DnrZxRf/PIAOVq3dbm3QkoaYZFxwRK8RIjq+b01L1
	fnCfyHNx/3lTlIISInIMjH2AfIKGlpuxUu3zRcWdsWK9Jlr9bcS8n8suFy3QX3gWgDQzaGPRypG
	RB4dA2K5mR8PqMP32TTXvuMSsBpbdB3odT5Qf/JTEDZnfjri8kaZEZseqw9G62QxcfIEENcKRYp
	iKTIsUBR2o/Nj0plD3+s+8qvVC0HmNYpK14HwXDnpTy799MmZOzz
X-Google-Smtp-Source: AGHT+IHJf9vYfV08DgcfuMrg7lc9xtUskRqmPdIdarUxuwseEkDilP3H5clVvfvXK0dgiNuaiBisVA==
X-Received: by 2002:a05:600c:6099:b0:439:6118:c188 with SMTP id 5b1f17b1804b1-442f2110fe7mr53294725e9.19.1747275628565;
        Wed, 14 May 2025 19:20:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e852fsm53369435e9.27.2025.05.14.19.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 19:20:28 -0700 (PDT)
Message-Id: <pull.1923.git.1747275627422.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 02:20:27 +0000
Subject: [PATCH] sequencer: make it clearer that commit descriptions are just
 comments
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Every once in a while, users report that editing the commit summaries
in the todo list does not get reflected in the rebase operation,
suggesting that users are (a) only using one-line commit messages, and
(b) not understanding that the commit summaries are merely helpful
comments to help them find the right hashes.

It may be difficult to correct users' poor commit messages, but we can
at least try to make it clearer that the commit summaries are not
directives of some sort by inserting a comment character.  Hopefully
that leads to them looking a little further and noticing the hints at
the bottom to use 'reword' or 'edit' directives.

Yes, this change may look funny at first since it hardcodes '#' rather
than using comment_line_str.  However:

  * comment_line_str exists to allow disambiguation between lines in
    a commit message and lines that are instructions to users editing
    the commit message.  No such disambiguation is needed for these
    comments that occur on the same line after existing directives
  * the exact "comment" character(s) on regular pick lines used aren't
    actually important; I could have used anything, including completely
    random variable length text for each line and it'd work because we
    ignore everything after 'pick' and the hash.
  * The whole point of this change is to signal to users that they
    should NOT be editing any part of the line after the hash (and if
    they do so, their edits will be ignored), while the whole point of
    comment_line_str is to allow highly flexible editing.  So making
    it more general by using comment_line_str actually feels
    counterproductive.
  * The character for merge directives absolutely must be '#'; that
    has been deeply hardcoded for a long time (see below), and will
    break if some other comment character is used instead.  In a
    desire to have pick and merge directives be similar, I use the
    same comment character for both.
  * Perhaps merge directives could be fixed to not be inflexible about
    the comment character used, if someone feels highly motivated, but
    I think that should be done in a separate follow-on patch.

Here are (some of?) the locations where '#' has already been hardcoded
for a long time for merges:

  1) In check_label_or_ref_arg():
	case TODO_LABEL:
		/*
		 * '#' is not a valid label as the merge command uses it to
		 * separate merge parents from the commit subject.
		 */

  2) In do_merge():

	/*
	 * For octopus merges, the arg starts with the list of revisions to be
	 * merged. The list is optionally followed by '#' and the oneline.
	 */
	merge_arg_len = oneline_offset = arg_len;
	for (p = arg; p - arg < arg_len; p += strspn(p, " \t\n")) {
		if (!*p)
			break;
		if (*p == '#' && (!p[1] || isspace(p[1]))) {

  3) In label_oid():

		if ((buf->len == the_hash_algo->hexsz &&
		     !get_oid_hex(label, &dummy)) ||
		    (buf->len == 1 && *label == '#') ||
		    hashmap_get_from_hash(&state->labels,
					  strihash(label), label)) {
			/*
			 * If the label already exists, or if the label is a
			 * valid full OID, or the label is a '#' (which we use
			 * as a separator between merge heads and oneline), we
			 * append a dash and a number to make it unique.
			 */

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    sequencer: make it clearer that commit descriptions are just comments

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1923%2Fnewren%2Fsequencer-todo-commit-msgs-are-comments-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1923/newren/sequencer-todo-commit-msgs-are-comments-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1923

 sequencer.c                   | 16 +++++--
 t/t3404-rebase-interactive.sh | 54 +++++++++++-----------
 t/t3415-rebase-autosquash.sh  | 14 +++---
 t/t3430-rebase-merges.sh      | 10 ++--
 t/t5520-pull.sh               |  2 +-
 t/t7512-status-help.sh        | 86 +++++++++++++++++------------------
 6 files changed, 94 insertions(+), 88 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b5c4043757e..2735966544b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5901,11 +5901,11 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 
 		/* Create a label from the commit message */
 		strbuf_reset(&label_from_message);
-		if (skip_prefix(oneline.buf, "Merge ", &p1) &&
+		if (skip_prefix(oneline.buf, "# Merge ", &p1) &&
 		    (p1 = strchr(p1, '\'')) &&
 		    (p2 = strchr(++p1, '\'')))
 			strbuf_add(&label_from_message, p1, p2 - p1);
-		else if (skip_prefix(oneline.buf, "Merge pull request ",
+		else if (skip_prefix(oneline.buf, "# Merge pull request ",
 				     &p1) &&
 			 (p1 = strstr(p1, " from ")))
 			strbuf_addstr(&label_from_message, p1 + strlen(" from "));
@@ -5940,7 +5940,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 
 			strbuf_addstr(&buf, label_oid(oid, label, &state));
 		}
-		strbuf_addf(&buf, " # %s", oneline.buf);
+		strbuf_addf(&buf, " %s", oneline.buf);
 
 		FLEX_ALLOC_STR(entry, string, buf.buf);
 		oidcpy(&entry->entry.oid, &commit->object.oid);
@@ -6022,7 +6022,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			else {
 				strbuf_reset(&oneline);
 				pretty_print_commit(pp, commit, &oneline);
-				strbuf_addf(out, "%s %s # %s\n",
+				strbuf_addf(out, "%s %s %s\n",
 					    cmd_reset, to, oneline.buf);
 			}
 		}
@@ -6090,8 +6090,14 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	git_config_get_string("rebase.instructionFormat", &format);
 	if (!format || !*format) {
 		free(format);
-		format = xstrdup("%s");
+		format = xstrdup("# %s");
 	}
+	if (*format != '#') {
+		char *temp = format;
+		format = xstrfmt("# %s", temp);
+		free(temp);
+	}
+
 	get_commit_format(format, &revs);
 	free(format);
 	pp.fmt = revs.commit_format;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 2aee9789a2f..6bac217ed35 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1468,7 +1468,7 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
 	cat >expect <<-EOF &&
 	Warning: some commits may have been dropped accidentally.
 	Dropped commits (newer to older):
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary)
+	 - $(git log --format="%h # %s" -1 primary)
 	To avoid this message, use "drop" to explicitly remove a commit.
 	EOF
 	test_config rebase.missingCommitsCheck warn &&
@@ -1486,8 +1486,8 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	cat >expect <<-EOF &&
 	Warning: some commits may have been dropped accidentally.
 	Dropped commits (newer to older):
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary)
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary~2)
+	 - $(git log --format="%h # %s" -1 primary)
+	 - $(git log --format="%h # %s" -1 primary~2)
 	To avoid this message, use "drop" to explicitly remove a commit.
 
 	Use '\''git config rebase.missingCommitsCheck'\'' to change the level of warnings.
@@ -1530,11 +1530,11 @@ test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ig
 test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
 	cat >expect <<-EOF &&
 	error: invalid command '\''pickled'\''
-	error: invalid line 1: pickled $(git rev-list --pretty=oneline --abbrev-commit -1 primary~4)
+	error: invalid line 1: pickled $(git log --format="%h # %s" -1 primary~4)
 	Warning: some commits may have been dropped accidentally.
 	Dropped commits (newer to older):
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary)
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary~4)
+	 - $(git log --format="%h # %s" -1 primary)
+	 - $(git log --format="%h # %s" -1 primary~4)
 	To avoid this message, use "drop" to explicitly remove a commit.
 	EOF
 	head -n5 expect >expect.2 &&
@@ -1565,11 +1565,11 @@ test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = wa
 test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
 	cat >expect <<-EOF &&
 	error: invalid command '\''pickled'\''
-	error: invalid line 1: pickled $(git rev-list --pretty=oneline --abbrev-commit -1 primary~4)
+	error: invalid line 1: pickled $(git log --format="%h # %s" -1 primary~4)
 	Warning: some commits may have been dropped accidentally.
 	Dropped commits (newer to older):
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary)
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary~4)
+	 - $(git log --format="%h # %s" -1 primary)
+	 - $(git log --format="%h # %s" -1 primary~4)
 	To avoid this message, use "drop" to explicitly remove a commit.
 
 	Use '\''git config rebase.missingCommitsCheck'\'' to change the level of warnings.
@@ -1642,11 +1642,11 @@ test_expect_success 'respects rebase.abbreviateCommands with fixup, squash and e
 	test_commit "fixup! first" file2.txt "first line again" first_fixup &&
 	test_commit "squash! second" file1.txt "another line here" second_squash &&
 	cat >expected <<-EOF &&
-	p $(git rev-list --abbrev-commit -1 first) first
-	f $(git rev-list --abbrev-commit -1 first_fixup) fixup! first
+	p $(git rev-list --abbrev-commit -1 first) # first
+	f $(git rev-list --abbrev-commit -1 first_fixup) # fixup! first
 	x git show HEAD
-	p $(git rev-list --abbrev-commit -1 second) second
-	s $(git rev-list --abbrev-commit -1 second_squash) squash! second
+	p $(git rev-list --abbrev-commit -1 second) # second
+	s $(git rev-list --abbrev-commit -1 second_squash) # squash! second
 	x git show HEAD
 	EOF
 	git checkout abbrevcmd &&
@@ -1665,7 +1665,7 @@ test_expect_success 'static check of bad command' '
 		set_fake_editor &&
 		test_must_fail env FAKE_LINES="1 2 3 bad 4 5" \
 		git rebase -i --root 2>actual &&
-		test_grep "pickled $(git rev-list --oneline -1 primary~1)" \
+		test_grep "pickled $(git log --format="%h # %s" -1 primary~1)" \
 				actual &&
 		test_grep "You can fix this with .git rebase --edit-todo.." \
 				actual &&
@@ -1865,15 +1865,15 @@ test_expect_success '--update-refs adds label and update-ref commands' '
 		set_cat_todo_editor &&
 
 		cat >expect <<-EOF &&
-		pick $(git log -1 --format=%h J) J
-		fixup $(git log -1 --format=%h update-refs) fixup! J # empty
+		pick $(git log -1 --format=%h J) # J
+		fixup $(git log -1 --format=%h update-refs) # fixup! J # empty
 		update-ref refs/heads/second
 		update-ref refs/heads/first
-		pick $(git log -1 --format=%h K) K
-		pick $(git log -1 --format=%h L) L
-		fixup $(git log -1 --format=%h is-not-reordered) fixup! L # empty
+		pick $(git log -1 --format=%h K) # K
+		pick $(git log -1 --format=%h L) # L
+		fixup $(git log -1 --format=%h is-not-reordered) # fixup! L # empty
 		update-ref refs/heads/third
-		pick $(git log -1 --format=%h M) M
+		pick $(git log -1 --format=%h M) # M
 		update-ref refs/heads/no-conflict-branch
 		update-ref refs/heads/is-not-reordered
 		update-ref refs/heads/shared-tip
@@ -1905,19 +1905,19 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
 		cat >expect <<-EOF &&
 		label onto
 		reset onto
-		pick $(git log -1 --format=%h branch2~1) F
-		pick $(git log -1 --format=%h branch2) I
+		pick $(git log -1 --format=%h branch2~1) # F
+		pick $(git log -1 --format=%h branch2) # I
 		update-ref refs/heads/branch2
 		label branch2
 		reset onto
-		pick $(git log -1 --format=%h refs/heads/second) J
+		pick $(git log -1 --format=%h refs/heads/second) # J
 		update-ref refs/heads/second
 		update-ref refs/heads/first
-		pick $(git log -1 --format=%h refs/heads/third~1) K
-		pick $(git log -1 --format=%h refs/heads/third) L
-		fixup $(git log -1 --format=%h update-refs-with-merge) fixup! L # empty
+		pick $(git log -1 --format=%h refs/heads/third~1) # K
+		pick $(git log -1 --format=%h refs/heads/third) # L
+		fixup $(git log -1 --format=%h update-refs-with-merge) # fixup! L # empty
 		update-ref refs/heads/third
-		pick $(git log -1 --format=%h HEAD~2) M
+		pick $(git log -1 --format=%h HEAD~2) # M
 		update-ref refs/heads/no-conflict-branch
 		merge -C $(git log -1 --format=%h HEAD~1) branch2 # merge
 		update-ref refs/heads/merge-branch
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index fcc40d6fe1f..26b42a526a1 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -257,8 +257,8 @@ test_expect_success 'auto squash of fixup commit that matches branch name which
 	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
 	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
 	cat <<-EOF >expect &&
-	pick HASH second commit
-	pick HASH fixup! self-cycle # empty
+	pick HASH # second commit
+	pick HASH # fixup! self-cycle # empty
 	EOF
 	test_cmp expect actual
 '
@@ -311,10 +311,10 @@ test_auto_fixup_fixup () {
 		parent2=$(git rev-parse --short HEAD^^) &&
 		parent3=$(git rev-parse --short HEAD^^^) &&
 		cat >expected <<-EOF &&
-		pick $parent3 first commit
-		$1 $parent1 $1! first
-		$1 $head $1! $2! first
-		pick $parent2 second commit
+		pick $parent3 # first commit
+		$1 $parent1 # $1! first
+		$1 $head # $1! $2! first
+		pick $parent2 # second commit
 		EOF
 		test_cmp expected actual
 	) &&
@@ -389,7 +389,7 @@ test_expect_success 'autosquash with empty custom instructionFormat' '
 		set_cat_todo_editor &&
 		test_must_fail git -c rebase.instructionFormat= \
 			rebase --autosquash  --force-rebase -i HEAD^ >actual &&
-		git log -1 --format="pick %h %s" >expect &&
+		git log -1 --format="pick %h # %s" >expect &&
 		test_cmp expect actual
 	)
 '
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index b84d68c4b96..5f8fa05420c 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -106,18 +106,18 @@ test_expect_success 'generate correct todo list' '
 	label onto
 
 	reset onto
-	pick $b B
+	pick $b # B
 	label first
 
 	reset onto
-	pick $c C
+	pick $c # C
 	label branch-point
-	pick $f F
-	pick $g G
+	pick $f # F
+	pick $g # G
 	label second
 
 	reset branch-point # C
-	pick $d D
+	pick $d # D
 	merge -C $e first # E
 	merge -C $h second # H
 
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 47534f1062d..52a5e4c016b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -813,7 +813,7 @@ test_expect_success 'git pull --rebase does not reapply old patches' '
 		cd dst &&
 		test_must_fail git pull --rebase &&
 		cat .git/rebase-merge/done .git/rebase-merge/git-rebase-todo >work &&
-		grep -v -e \# -e ^$ work >patches &&
+		sed -e s/#.*// work | grep -v ^$ >patches &&
 		test_line_count = 1 patches &&
 		rm -f work
 	)
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 802f8f704c6..25e8e9711f8 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -139,7 +139,7 @@ test_expect_success 'status during rebase -i when conflicts unresolved' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last command done (1 command done):
-   pick $LAST_COMMIT one_second
+   pick $LAST_COMMIT # one_second
 No commands remaining.
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
   (fix conflicts and then run "git rebase --continue")
@@ -168,7 +168,7 @@ test_expect_success 'status during rebase -i after resolving conflicts' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last command done (1 command done):
-   pick $LAST_COMMIT one_second
+   pick $LAST_COMMIT # one_second
 No commands remaining.
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
   (all conflicts fixed: run "git rebase --continue")
@@ -200,8 +200,8 @@ test_expect_success 'status when rebasing -i in edit mode' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   pick $COMMIT2 two_rebase_i
-   edit $COMMIT3 three_rebase_i
+   pick $COMMIT2 # two_rebase_i
+   edit $COMMIT3 # three_rebase_i
 No commands remaining.
 You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -233,10 +233,10 @@ test_expect_success 'status when splitting a commit' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   pick $COMMIT2 two_split
-   edit $COMMIT3 three_split
+   pick $COMMIT2 # two_split
+   edit $COMMIT3 # three_split
 Next command to do (1 remaining command):
-   pick $COMMIT4 four_split
+   pick $COMMIT4 # four_split
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
@@ -271,8 +271,8 @@ test_expect_success 'status after editing the last commit with --amend during a
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (3 commands done):
-   pick $COMMIT3 three_amend
-   edit $COMMIT4 four_amend
+   pick $COMMIT3 # three_amend
+   edit $COMMIT4 # four_amend
   (see more in file .git/rebase-merge/done)
 No commands remaining.
 You are currently editing a commit while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
@@ -309,10 +309,10 @@ test_expect_success 'status: (continue first edit) second edit' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   edit $COMMIT2 two_edits
-   edit $COMMIT3 three_edits
+   edit $COMMIT2 # two_edits
+   edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 four_edits
+   pick $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -340,10 +340,10 @@ test_expect_success 'status: (continue first edit) second edit and split' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   edit $COMMIT2 two_edits
-   edit $COMMIT3 three_edits
+   edit $COMMIT2 # two_edits
+   edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 four_edits
+   pick $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
@@ -375,10 +375,10 @@ test_expect_success 'status: (continue first edit) second edit and amend' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   edit $COMMIT2 two_edits
-   edit $COMMIT3 three_edits
+   edit $COMMIT2 # two_edits
+   edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 four_edits
+   pick $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -406,10 +406,10 @@ test_expect_success 'status: (amend first edit) second edit' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   edit $COMMIT2 two_edits
-   edit $COMMIT3 three_edits
+   edit $COMMIT2 # two_edits
+   edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 four_edits
+   pick $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -438,10 +438,10 @@ test_expect_success 'status: (amend first edit) second edit and split' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   edit $COMMIT2 two_edits
-   edit $COMMIT3 three_edits
+   edit $COMMIT2 # two_edits
+   edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 four_edits
+   pick $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
@@ -474,10 +474,10 @@ test_expect_success 'status: (amend first edit) second edit and amend' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   edit $COMMIT2 two_edits
-   edit $COMMIT3 three_edits
+   edit $COMMIT2 # two_edits
+   edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 four_edits
+   pick $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -507,10 +507,10 @@ test_expect_success 'status: (split first edit) second edit' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   edit $COMMIT2 two_edits
-   edit $COMMIT3 three_edits
+   edit $COMMIT2 # two_edits
+   edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 four_edits
+   pick $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -541,10 +541,10 @@ test_expect_success 'status: (split first edit) second edit and split' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   edit $COMMIT2 two_edits
-   edit $COMMIT3 three_edits
+   edit $COMMIT2 # two_edits
+   edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 four_edits
+   pick $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
@@ -579,10 +579,10 @@ test_expect_success 'status: (split first edit) second edit and amend' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   edit $COMMIT2 two_edits
-   edit $COMMIT3 three_edits
+   edit $COMMIT2 # two_edits
+   edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 four_edits
+   pick $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -997,11 +997,11 @@ test_expect_success 'status: two commands done with some white lines in done fil
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   pick $COMMIT2 two_commit
+   pick $COMMIT2 # two_commit
    exec exit 15
 Next commands to do (2 remaining commands):
-   pick $COMMIT3 three_commit
-   pick $COMMIT4 four_commit
+   pick $COMMIT3 # three_commit
+   pick $COMMIT4 # four_commit
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -1025,12 +1025,12 @@ test_expect_success 'status: two remaining commands with some white lines in tod
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (3 commands done):
-   pick $COMMIT2 two_commit
+   pick $COMMIT2 # two_commit
    exec exit 15
   (see more in file .git/rebase-merge/done)
 Next commands to do (2 remaining commands):
-   pick $COMMIT3 three_commit
-   pick $COMMIT4 four_commit
+   pick $COMMIT3 # three_commit
+   pick $COMMIT4 # four_commit
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -1050,7 +1050,7 @@ test_expect_success 'status: handle not-yet-started rebase -i gracefully' '
 On branch several_commits
 No commands done.
 Next command to do (1 remaining command):
-   pick $COMMIT four_commit
+   pick $COMMIT # four_commit
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)

base-commit: 1a8a4971cc6c179c4dd711f4a7f5d7178f4b3ab7
-- 
gitgitgadget
