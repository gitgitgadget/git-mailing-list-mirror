Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5435C1AD
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697517; cv=none; b=E+rD4FiLOQzDOB7xatkS/TdY2DbJdHkQb5fQRsb1XyuKr8+5+6VD7z1iCPljcjK5T0Cd6UFQSo+di/VQc2fMKXwUNQtbHBS8Q8OAZdrFjMya71tsQuisPNN3doSMglhltlmh2kpunR7o0lkofKb+K+g+l6a3KfVLCYX4Hkc73X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697517; c=relaxed/simple;
	bh=YjIhZsf9jotSMJtAPee2DFmaDeD4T8HacVc+BBNxawQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saEBqg4lKvdf8zEWNgrlOVUEYCRfMJRQSgDq9vLxdGRyAJgzi0LFBcGKYGXW5uV4xyjcL+TcBepACDpCKuZg+JdLDdRTLboG6hl0NhzS5FzCBMmIV/Bm3z8QXL8Pv26No/rmyolJ30G6EVN+Vx//EO7YPiA4vghIMQiBfVD+/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRcxDek2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRcxDek2"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so9699315e9.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776697513; x=1777302313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XfkURLCFDdL+AIMcY0eACe54sC1ADZf7YW4jM5eVtSk=;
        b=iRcxDek2NiFNVkE38nWAX6zfTm7wX5X6t56dc0BHoUQiVJ2tnAKVOmxMwIpWJaESRg
         G5KMBxYzlpyPZtwK1ylYGhp4OJB52d0+3sm4zZ/d5SXsNsIqtMF5mDo044j7vNXnKs9S
         3ttvlT+9Taa9tLHJ5/aGz/paEfiK2W88vLuX5/Gg+ABNfGslj405DeylPcZDNag+fFFy
         8QRqGpxsTkt4G6g2BfUTj6y7Ez5EiWyIZVzzzUtKe+0dTtpj6wSiPjgJgKKQVJirNEdz
         Q5dRK+O77PyJt/2fhoU9AKCqpUqDFKyZHwRN8DtLgz0b29PKAE73fA007FKU5QERlU48
         Lm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776697513; x=1777302313;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfkURLCFDdL+AIMcY0eACe54sC1ADZf7YW4jM5eVtSk=;
        b=Av+iKzrVdWDRj8q/0TuG4GYl0fs5puWPFDP2/ebZXd+tGhtqKXt7gXuePC4kymOsb7
         L7eANmgWzFrPOprIf7CWOu5iL1K8YHzCK3OH5hHakb7P/xjR2w3ZVWrKTP4cVHKTLU2e
         P9JxObBZ28WtKW+/o2/vnF8nuupGsga4ZWfnHHfEixJGPgR2tN0KsYq4MDH5qJzHInW3
         UrQVSaiQCEVMa0/Io9zs5C1q3tBUhwC/roDx/eYBIDvtoRha1uAN5M7xiqbzYPtM3TRo
         ACtcI5QQ79TBeEW8fPyrZRo/6osSfiDRNfkEmJjqnvElPJWqOZfrHxhD0NDrhAMm0h+G
         z5fg==
X-Gm-Message-State: AOJu0YzBg/p9+ecy+vN2kb7caISNzJx3mYGE9zlR/UjBY9Hd5kf0vuYp
	ow3MpNrfeJSJvbqS5NgMRXCdMMoz74LwsiEm75BKMhF2DkvQIRoO5FTnzJjumA==
X-Gm-Gg: AeBDieufs9FyQY2+hMJafdrGQWSJJ4yRsjelc1Zb2+lTpU6RyiZFrWsHggOagh1ngGm
	R060irtyN1hupw3F+caBgx6gDVmn9BfPEMm3t1z9sZ02ZdhWDdDL/8o+W7pBgTvYaz4UBBhbE9h
	QfttiFRmCvydVs+dWoO/NlVG7jw7xN/o3xhWylkVsby2WecxESC6IVBfKaQMV20Fdv8obDgmFpg
	NK50YuAkYViLWtVmC9SysuxbRhOj1LaakQ+YQmlXYV66xEnvhBkqNEF00sjxpVwvgoEAWAPBV3x
	o5v5+MsiKeZehZlEhCQen6iKhWNIghR4kqgx3r0gpPb+exzslbcay8gETdd4ikFkcjiRoNCH/+j
	3fJFW3wKd/0Ri3oyfZoyOqrVA//Gt7RBNObXTteI6MWxXxVUGUT8pI4/ZTXi96oFsuEg3TJqZQW
	PGOOPS2X90wSufAmCBelO7MC3sZ68KMdIKYRNp
X-Received: by 2002:a05:600c:34ca:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48a07615b87mr32921065e9.8.1776697513207;
        Mon, 20 Apr 2026 08:05:13 -0700 (PDT)
Received: from berwick ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52583fe7sm27335685e9.13.2026.04.20.08.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:05:12 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/2] status: improve rebase todo list parsing
Date: Mon, 20 Apr 2026 16:04:44 +0100
Message-ID: <d20dc1f6550078883995ae963b91faaa00984c6e.1776697483.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.rc1.174.gd833f386ac5.dirty
In-Reply-To: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When there is rebase in progress "git status" displays the last couple
of completed and the next couple of pending commands from the todo
list. When it does this is tries to abbreviate the object ids of
the commits to be picked. Unfortunately it does not abbreviate the
object ids when the line starts with "fixup -C" or "merge -C". It
also mistakenly replaces the refname in "reset main" and "update-ref
refs/heads/main" with the object id that the ref points to. Use
the function added in the last commit to parse the command name and
only try to abbreviate the argument for commands that take an object
id. When trying to abbreviate an object id, only replace the object
name if it starts with the abbreviated object id so that labels or
branch names that contain only hex digits are left unchanged.

Comments are now processed after stripping any leading
whitespace from the line. This matches what the sequencer does in
parse_insn_line(). The existing test cases are updated to test a
wider variety of commands. Only the pending commands in the tests
are changed to avoid removing existing coverage.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t7512-status-help.sh |  74 ++++++++++++++++---------
 wt-status.c            | 121 ++++++++++++++++++++++++++++++++---------
 2 files changed, 143 insertions(+), 52 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 08e82f7914..aca4b6d332 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -224,7 +224,7 @@ test_expect_success 'status when splitting a commit' '
 	COMMIT3=$(git rev-parse --short split_commit) &&
 	test_commit four_split main.txt four &&
 	COMMIT4=$(git rev-parse --short split_commit) &&
-	FAKE_LINES="1 edit 2 3" &&
+	FAKE_LINES="reword 1 edit 2 fixup_-C 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
@@ -233,10 +233,10 @@ test_expect_success 'status when splitting a commit' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   pick $COMMIT2 # two_split
+   reword $COMMIT2 # two_split
    edit $COMMIT3 # three_split
 Next command to do (1 remaining command):
-   pick $COMMIT4 # four_split
+   fixup -C $COMMIT4 # four_split
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
@@ -297,7 +297,7 @@ test_expect_success 'prepare for several edits' '
 
 
 test_expect_success 'status: (continue first edit) second edit' '
-	FAKE_LINES="edit 1 edit 2 3" &&
+	FAKE_LINES="edit 1 edit 2 drop 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
@@ -312,7 +312,7 @@ Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+   drop $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -327,7 +327,7 @@ EOF
 
 test_expect_success 'status: (continue first edit) second edit and split' '
 	git reset --hard several_edits &&
-	FAKE_LINES="edit 1 edit 2 3" &&
+	FAKE_LINES="edit 1 edit 2 squash 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
@@ -343,7 +343,7 @@ Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+   squash $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
@@ -362,7 +362,7 @@ EOF
 
 test_expect_success 'status: (continue first edit) second edit and amend' '
 	git reset --hard several_edits &&
-	FAKE_LINES="edit 1 edit 2 3" &&
+	FAKE_LINES="edit 1 edit 2 fixup 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
@@ -378,7 +378,7 @@ Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+   fixup $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -393,7 +393,7 @@ EOF
 
 test_expect_success 'status: (amend first edit) second edit' '
 	git reset --hard several_edits &&
-	FAKE_LINES="edit 1 edit 2 3" &&
+	FAKE_LINES="edit 1 edit 2 fixup_-c 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
@@ -409,7 +409,7 @@ Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+   fixup -c $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -460,14 +460,20 @@ EOF
 
 test_expect_success 'status: (amend first edit) second edit and amend' '
 	git reset --hard several_edits &&
-	FAKE_LINES="edit 1 edit 2 3" &&
-	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
 	COMMIT3=$(git rev-parse --short several_edits^) &&
 	COMMIT4=$(git rev-parse --short several_edits) &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
-	git rebase -i HEAD~3 &&
+	cat >todo <<-EOF &&
+	edit several_edits^^ # two_edits
+	edit several_edits^ # three_edits
+	merge $(git rev-parse main) $(git rev-parse several_edits)
+	EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i HEAD~3
+	) &&
 	git commit --amend -m "c" &&
 	git rebase --continue &&
 	git commit --amend -m "d" &&
@@ -477,7 +483,7 @@ Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+   merge $(git rev-parse --short main) $COMMIT4
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -525,14 +531,21 @@ EOF
 
 test_expect_success 'status: (split first edit) second edit and split' '
 	git reset --hard several_edits &&
-	FAKE_LINES="edit 1 edit 2 3" &&
-	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
 	COMMIT3=$(git rev-parse --short several_edits^) &&
 	COMMIT4=$(git rev-parse --short several_edits) &&
+	cat >todo <<-EOF &&
+	edit several_edits^^ # two_edits
+	edit several_edits^ # three_edits
+	reset $(git rev-parse main)
+	merge -C several_edits topic # title
+	EOF
 	ONTO=$(git rev-parse --short HEAD~3) &&
-	git rebase -i HEAD~3 &&
+	(
+		set_replace_editor todo &&
+		git rebase -i HEAD~3
+	) &&
 	git reset HEAD^ &&
 	git add main.txt &&
 	git commit --amend -m "f" &&
@@ -543,8 +556,9 @@ interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
-Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+Next commands to do (2 remaining commands):
+   reset $(git rev-parse --short main)
+   merge -C $COMMIT4 topic # title
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
@@ -563,14 +577,21 @@ EOF
 
 test_expect_success 'status: (split first edit) second edit and amend' '
 	git reset --hard several_edits &&
-	FAKE_LINES="edit 1 edit 2 3" &&
-	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	git branch cafe main &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
 	COMMIT3=$(git rev-parse --short several_edits^) &&
-	COMMIT4=$(git rev-parse --short several_edits) &&
+	cat >todo <<-EOF &&
+	edit several_edits^^ # two_edits
+	edit several_edits^ # three_edits
+	update-ref refs/heads/main
+	reset cafe
+	EOF
 	ONTO=$(git rev-parse --short HEAD~3) &&
-	git rebase -i HEAD~3 &&
+	(
+		set_replace_editor todo &&
+		git rebase -i HEAD~3
+	) &&
 	git reset HEAD^ &&
 	git add main.txt &&
 	git commit --amend -m "g" &&
@@ -581,8 +602,9 @@ interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
-Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+Next commands to do (2 remaining commands):
+   update-ref refs/heads/main
+   reset cafe
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
diff --git a/wt-status.c b/wt-status.c
index 479ccc3304..ba93a18fc2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1363,6 +1363,51 @@ static int split_commit_in_progress(struct wt_status *s)
 	free(rebase_orig_head);
 
 	return split_in_progress;
+}
+
+static void abbrev_oid_in_line(struct repository *r,
+			       struct strbuf *line, char **pp)
+{
+	char *p = *pp;
+	char *end_of_object_name, saved;
+	const char *abbrev;
+	struct object_id oid;
+	bool have_oid;
+
+	p += strspn(p, " \t");
+	end_of_object_name = p + strcspn(p, " \t");
+	/*
+	 * The for "merge" and "reset" the object name may be a label or
+	 * ref rather than a hex object id. Only abbreviate the object
+	 * name if it is a hex object id.
+	 */
+	for (const char *q = p; q < end_of_object_name; q++) {
+		if (!isxdigit(*q))
+			goto out;
+	}
+	saved = *end_of_object_name;
+	*end_of_object_name = '\0';
+	have_oid = !repo_get_oid(r, p, &oid);
+	*end_of_object_name = saved;
+	if (!have_oid)
+		goto out; /* object name was a label */
+	abbrev = repo_find_unique_abbrev(r, &oid, DEFAULT_ABBREV);
+	if (!starts_with(p, abbrev))
+		goto out; /* object name was a refname containing only xdigits */
+	p += strlen(abbrev);
+	strbuf_remove(line, p - line->buf, end_of_object_name - p);
+	end_of_object_name = p;
+out:
+	*pp = end_of_object_name;
+}
+
+static void skip_dash_c(char **pp) {
+	char *p = *pp;
+
+	p += strspn(p, " \t");
+	/* The (void) cast is required to silence -Wunused_value */
+	(void)(skip_prefix(p, "-C", &p) || skip_prefix(p, "-c", &p));
+	*pp = p;
 }
 
 /*
@@ -1371,29 +1416,57 @@ static int split_commit_in_progress(struct wt_status *s)
  * into
  * "pick d6a2f03 some message"
  *
- * The function assumes that the line does not contain useless spaces
- * before or after the command.
+ * Returns false on comment lines, true otherwise
  */
-static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
+static bool format_todo_line(struct repository *r, struct strbuf *line)
 {
-	struct string_list split = STRING_LIST_INIT_DUP;
-	struct object_id oid;
-
-	if (starts_with(line->buf, "exec ") ||
-	    starts_with(line->buf, "x ") ||
-	    starts_with(line->buf, "label ") ||
-	    starts_with(line->buf, "l "))
-		return;
-
-	if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
-	    !repo_get_oid(r, split.items[1].string, &oid)) {
-		strbuf_reset(line);
-		strbuf_addf(line, "%s ", split.items[0].string);
-		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
-		for (size_t i = 2; i < split.nr; i++)
-			strbuf_addf(line, " %s", split.items[i].string);
+	enum todo_command cmd;
+	char *p = line->buf;
+
+	if (!sequencer_parse_todo_command((const char**)&p, &cmd))
+		return true; /* keep invalid lines */
+
+	switch (cmd) {
+	case TODO_COMMENT:
+		return false;
+
+	case TODO_MERGE:
+		skip_dash_c(&p);
+		while (true) {
+			p += strspn(p, " \t");
+			if (!p[0] || (p[0] == '#' && (!p[1] || isspace(p[1]))))
+				break;
+			abbrev_oid_in_line(r, line, &p);
+		}
+		break;
+
+	case TODO_FIXUP:
+		skip_dash_c(&p);
+		/* fallthrough */
+	case TODO_DROP:
+	case TODO_EDIT:
+	case TODO_PICK:
+	case TODO_RESET:
+	case TODO_REVERT:
+	case TODO_REWORD:
+	case TODO_SQUASH:
+		abbrev_oid_in_line(r, line, &p);
+		break;
+
+	/*
+	 * Avoid "default" and instead list all the other commands so
+	 * that -Wswitch warns if a new command is added without handling
+	 * it in this function.
+	 */
+	case TODO_BREAK:
+	case TODO_EXEC:
+	case TODO_LABEL:
+	case TODO_NOOP:
+	case TODO_UPDATE_REF:
+		break;
 	}
-	string_list_clear(&split, 0);
+
+	return true;
 }
 
 static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
@@ -1411,13 +1484,9 @@ static int read_rebase_todolist(struct repository *r, const char *fname, struct
 			  repo_git_path_replace(r, &buf, "%s", fname));
 	}
 	while (!strbuf_getline_lf(&buf, f)) {
-		if (starts_with(buf.buf, comment_line_str))
-			continue;
 		strbuf_trim(&buf);
-		if (!buf.len)
-			continue;
-		abbrev_oid_in_line(r, &buf);
-		string_list_append(lines, buf.buf);
+		if (format_todo_line(r, &buf))
+			string_list_append(lines, buf.buf);
 	}
 	fclose(f);
 
-- 
2.54.0.rc1.174.gd833f386ac5.dirty

