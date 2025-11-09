Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7216205E02
	for <git@vger.kernel.org>; Sun,  9 Nov 2025 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762683779; cv=none; b=IihoDgDVa1pRZoNlgnO0C25+wBp9W6JvgETi+lgdadzn8Fn65L4MiROCB8FAHuWUnxipmoTh1fHrM00eZSkl75qg+aNrxpXkm8tAZb9j2E+TJOGpFmiNwcVrkbycT933M89koZMR6xJw/H3hXe1pKOKgM6gvuGuzXMeTXS1bAQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762683779; c=relaxed/simple;
	bh=4iSflrMk7AtSrj2yD5Hua5oIkryrK5t31X1dtGbBZ3A=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=YlxGr+ruj4olglzACUtaCIzIEG4IrxUtqXlQynZhzATHLZHbIULvJll6EucqKxMbuecEMGgAT6ei9ZN3ySjcW5+9ct8+UO4YZUlhOAOTDb9hHT2Twdazv42RAe75SPxydXbpcYOhpXETgJKJTqVeK0WK64GdCU84FYZ+WUxyKRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3Y2kXgU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3Y2kXgU"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b679450ecb6so1597567a12.2
        for <git@vger.kernel.org>; Sun, 09 Nov 2025 02:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762683777; x=1763288577; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QNkNg3Z7gyyVA9yuMLyEocSYTu7/IG+bviINrwGiyok=;
        b=T3Y2kXgUvXC+2a3KPR4zuZSBLY7B1aOG+I5dkLM3Y3JWJRvkm05PfemYucatRwti4L
         oe4Jr6g04kTMBvCsv5IYFWMQIgeSOucFhxWOE7zcE1Va7wmSTEs9/+xdMRr/p/qj2/YD
         outLwnoGlWO3y4VOSg6szeRksuaY4OJ2GrgYm1svDHsoRXCbXg3HJd1xRgKPMyyipbYn
         Qm6aDC/vKh7Qhl8gTnS7GLUeAd9fEUL4B1i5cMVrV+KoifqofesFfWawrdMGEFBC23tD
         lJFfYKFPkDgQ5/hrgonoS61VlXE38Cbt/R7b+a9c6c3pK0uS3jdlnjfz+IJi/LUPGc3+
         gIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762683777; x=1763288577;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNkNg3Z7gyyVA9yuMLyEocSYTu7/IG+bviINrwGiyok=;
        b=mHfLfR/z6EmFDMJn3GOOU8nV/xFUqOJeXeAgoa9AYTIdkJTWUO4PCQBsLvWkwkvLeI
         fSTmrPOKKWfKI2HLkXUm3YRELitjTBnbnBuHd7MP5vY3Ftc+W7r7ip0DY0quznxq5czA
         uM6+UqPcy8ribnxhK5NeZYNwuHaQ85X0oA9RVoHITeZcBreC6aQISqeN7QFaHotxceKw
         1WcLlMXJSfElVc41sMGS2d1rK3qr1L2Fz25GIZ9aB8C32fgnofC1XXEg5f+hEzYna2MS
         iJwk2qSu4oBG9mmntjRUSUSLgxt/Z/GtWuMYk2RIMZzMYokKxS7NPA53qpIvL3RR3PJu
         fMXg==
X-Gm-Message-State: AOJu0YxGlCnMFAvXQ3xk9zViNa4xSh+9mNUsGFMuzMwK4Wu3PfCSuW92
	majkoXa8MNBMUOnrx+rvcMFDxlHeiJo3bfI0i8wHwzrfuvvwBC8k9JLxRRUokw==
X-Gm-Gg: ASbGncvRntGLAas6FUednEywo3zzVqSaQJGfULkrOlgEFeMDHNHdLmlhRonuQQzEEjC
	SMjl8xAmBAdZQVXee8S8IMlCGRNOZ6m+EpNg1tSNHQwfZKWR1lVvj1Yo1NDvHLAEHoshiMxxu5f
	nAVZhVAFM7oc0uoLXcboiP67ZGAD+va2wFKEY1WKfpEyXrgtQWtofNdQdQrLai6idUmFDbqfp3x
	JuubYf10iK9ydMyghxGyytK05mq2TF0x9GkBMNNcRUmjqbLyoMB3DAooEVlb4qrd53e3KZsieeW
	vlMJbOaphx7MkZcmbpFVm2XEUmjqq7t8hZPKEGz/qN7FrFsO8JZrSvOMEZcbInl536NjQzirVFJ
	8y1ryqJ+54lRQ/lg958p+/6URNrn5iGkNCawQrMfkouSeokZN43gflyt0nJEjXMM5KWlM10AJp7
	LB6Myx
X-Google-Smtp-Source: AGHT+IGZMafAchFy1KBNHTjnl9O/h1kBATLe7+iYgVZLre4JqmQ0P4iu+nvryIDclZvO2E1Qo0YY3g==
X-Received: by 2002:a17:903:986:b0:297:fec4:1557 with SMTP id d9443c01a7336-297fec4165emr29185365ad.60.1762683776604;
        Sun, 09 Nov 2025 02:22:56 -0800 (PST)
Received: from [127.0.0.1] ([172.182.226.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccc19asm110382335ad.104.2025.11.09.02.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 02:22:54 -0800 (PST)
Message-Id: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
From: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 09 Nov 2025 10:22:54 +0000
Subject: [PATCH] commit: add --committer option
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Jeff King <peff@peff.net>,
    ZheNing Hu <adlternative@gmail.com>,
    ZheNing Hu <adlternative@gmail.com>

From: ZheNing Hu <adlternative@gmail.com>

Add --committer option to git-commit, allowing users to override the
committer identity similar to how --author works. This provides a more
convenient alternative to setting GIT_COMMITTER_* environment variables.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>

Co-authored-by: Aone-Agent <aone-agent@alibaba-inc.com>
---
    commit: add --committer option
    
    Currently, when users need to override the committer identity in
    git-commit, they have to set GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL
    environment variables, which can be cumbersome in scripting scenarios or
    when frequently switching committer identities.
    
    While git-commit already provides the --author option to conveniently
    override the author identity, there's no equivalent --committer option
    for the committer identity. This asymmetry creates an inconsistent user
    experience.
    
    This patch introduces the --committer option to git-commit, providing:
    
     1. Consistency with the existing --author option
     2. A more convenient alternative to environment variables
     3. Better support for automated workflows and scripts
     4. Improved user experience when managing multiple identities
    
    The implementation follows the same pattern as the --author option,
    accepting the format "Name " and properly validating the input.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1997%2Fadlternative%2Fzh%2Fimplement-committer-option-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1997/adlternative/zh/implement-committer-option-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1997

 Documentation/git-commit.adoc |  9 +++-
 builtin/commit.c              | 58 ++++++++++++++++++++++++-
 t/t7509-commit-authorship.sh  | 80 +++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index 54c207ad45..a015c8328e 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -12,7 +12,7 @@ git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]
 	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
-	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
+	   [--date=<date>] [--committer=<committer>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
 	   [--] [<pathspec>...]
@@ -181,6 +181,13 @@ See linkgit:git-rebase[1] for details.
 `--date=<date>`::
 	Override the author date used in the commit.
 
+`--committer=<committer>`::
+	Override the committer for the commit. Specify an explicit committer using the
+	standard `A U Thor <committer@example.com>` format. Otherwise _<committer>_
+	is assumed to be a pattern and is used to search for an existing
+	commit by that author (i.e. `git rev-list --all -i --author=<committer>`);
+	the commit author is then copied from the first such commit found.
+
 `-m <msg>`::
 `--message=<msg>`::
 	Use _<msg>_ as the commit message.
diff --git a/builtin/commit.c b/builtin/commit.c
index 0243f17d53..88e77cbaab 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -49,7 +49,7 @@ static const char * const builtin_commit_usage[] = {
 	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]\n"
 	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
 	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
-	   "           [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
+	   "           [--date=<date>] [--committer=<committer>] [--cleanup=<mode>] [--[no-]status]\n"
 	   "           [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
 	   "           [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]\n"
 	   "           [--] [<pathspec>...]"),
@@ -112,6 +112,7 @@ static enum {
 } commit_style;
 
 static const char *force_author;
+static const char *force_committer;
 static char *logfile;
 static char *template_file;
 /*
@@ -690,6 +691,48 @@ static void determine_author_info(struct strbuf *author_ident)
 	free(date);
 }
 
+static void determine_committer_info(struct strbuf *committer_ident)
+{
+	char *name, *email, *date;
+	struct ident_split committer;
+
+	name = xstrdup_or_null(getenv("GIT_COMMITTER_NAME"));
+	email = xstrdup_or_null(getenv("GIT_COMMITTER_EMAIL"));
+	date = xstrdup_or_null(getenv("GIT_COMMITTER_DATE"));
+
+	if (force_committer) {
+		struct ident_split ident;
+
+		if (split_ident_line(&ident, force_committer, strlen(force_committer)) < 0)
+			die(_("malformed --committer parameter"));
+		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
+		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
+
+		if (ident.date_begin) {
+			struct strbuf date_buf = STRBUF_INIT;
+			strbuf_addch(&date_buf, '@');
+			strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
+			strbuf_addch(&date_buf, ' ');
+			strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
+			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
+		}
+	}
+
+	if (force_date) {
+		struct strbuf date_buf = STRBUF_INIT;
+		if (parse_force_date(force_date, &date_buf))
+			die(_("invalid date format: %s"), force_date);
+		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
+	}
+
+	strbuf_addstr(committer_ident, fmt_ident(name, email, WANT_COMMITTER_IDENT, date,
+				IDENT_STRICT));
+	assert_split_ident(&committer, committer_ident);
+	free(name);
+	free(email);
+	free(date);
+}
+
 static int author_date_is_interesting(void)
 {
 	return author_message || force_date;
@@ -1321,6 +1364,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && renew_authorship)
 		die(_("options '%s' and '%s' cannot be used together"), "--reset-author", "--author");
 
+	if (force_committer && !strchr(force_committer, '>'))
+		force_committer = find_author_by_nickname(force_committer);
+
 	if (logfile || have_option_m || use_message)
 		use_editor = 0;
 
@@ -1709,6 +1755,7 @@ int cmd_commit(int argc,
 		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
 		OPT_STRING(0, "author", &force_author, N_("author"), N_("override author for commit")),
 		OPT_STRING(0, "date", &force_date, N_("date"), N_("override date for commit")),
+		OPT_STRING(0, "committer", &force_committer, N_("committer"), N_("override committer for commit")),
 		OPT_CALLBACK('m', "message", &message, N_("message"), N_("commit message"), opt_parse_m),
 		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
 		OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reuse message from specified commit")),
@@ -1785,6 +1832,7 @@ int cmd_commit(int argc,
 
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf author_ident = STRBUF_INIT;
+	struct strbuf committer_ident = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
 	struct object_id oid;
 	struct commit_list *parents = NULL;
@@ -1930,8 +1978,13 @@ int cmd_commit(int argc,
 		append_merge_tag_headers(parents, &tail);
 	}
 
+	if (force_committer) {
+		determine_committer_info(&committer_ident);
+	}
+
 	if (commit_tree_extended(sb.buf, sb.len, &the_repository->index->cache_tree->oid,
-				 parents, &oid, author_ident.buf, NULL,
+				 parents, &oid, author_ident.buf,
+				 force_committer ? committer_ident.buf : NULL,
 				 sign_commit, extra)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
@@ -1980,6 +2033,7 @@ cleanup:
 	free_commit_extra_headers(extra);
 	free_commit_list(parents);
 	strbuf_release(&author_ident);
+	strbuf_release(&committer_ident);
 	strbuf_release(&err);
 	strbuf_release(&sb);
 	free(logfile);
diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
index 8e373b566b..45527f6a70 100755
--- a/t/t7509-commit-authorship.sh
+++ b/t/t7509-commit-authorship.sh
@@ -12,6 +12,11 @@ author_header () {
 	sed -n -e '/^$/q' -e '/^author /p'
 }
 
+committer_header () {
+	git cat-file commit "$1" |
+	sed -n -e '/^$/q' -e '/^committer /p'
+}
+
 message_body () {
 	git cat-file commit "$1" |
 	sed -e '1,/^$/d'
@@ -171,4 +176,79 @@ test_expect_success '--reset-author with CHERRY_PICK_HEAD' '
 	test_cmp expect actual
 '
 
+test_expect_success '--committer option overrides committer' '
+	git checkout Initial &&
+	echo "Test --committer" >>foo &&
+	test_tick &&
+	git commit -a -m "test committer" --committer="Custom Committer <custom@committer.example>" &&
+	committer_header HEAD >actual &&
+	grep "Custom Committer <custom@committer.example>" actual
+'
+
+test_expect_success '--committer with pattern search' '
+	echo "Test committer pattern" >>foo &&
+	test_tick &&
+	git commit -a -m "test committer pattern" --committer="Frigate" &&
+	committer_header HEAD >actual &&
+	grep "Frigate <flying@over.world>" actual
+'
+
+test_expect_success '--committer malformed parameter' '
+	echo "Test malformed" >>foo &&
+	test_tick &&
+	test_must_fail git commit -a -m "test malformed" --committer="malformed committer"
+'
+
+test_expect_success '--committer with --amend option' '
+	git checkout -f Initial &&
+	echo "Test committer with amend" >>foo &&
+	test_tick &&
+	git commit -a -m "initial commit for amend test" &&
+	echo "Modified for amend" >>foo &&
+	test_tick &&
+	git commit -a --amend --no-edit \
+		--author="Test Author <test@author.example>" \
+		--committer="Test Committer <test@committer.example>" &&
+	author_header HEAD >actual_author &&
+	grep "Test Author <test@author.example>" actual_author &&
+	committer_header HEAD >actual_committer &&
+	grep "Test Committer <test@committer.example>" actual_committer
+'
+
+test_expect_success 'GIT_COMMITTER_* environment variables' '
+	git checkout -f Initial &&
+	echo "Test env vars" >>foo &&
+	test_tick &&
+	GIT_COMMITTER_NAME="Env Committer" \
+	GIT_COMMITTER_EMAIL="env@test.example" \
+	git commit -a -m "test committer env vars" &&
+	committer_header HEAD >actual &&
+	grep "Env Committer <env@test.example>" actual
+'
+
+test_expect_success '--committer overrides GIT_COMMITTER_* environment variables' '
+	echo "Test override" >>foo &&
+	test_tick &&
+	GIT_COMMITTER_NAME="Env Committer" \
+	GIT_COMMITTER_EMAIL="env@test.example" \
+	git commit -a -m "test override" \
+		--committer="Override Committer <override@test.example>" &&
+	committer_header HEAD >actual &&
+	grep "Override Committer <override@test.example>" actual
+'
+
+test_expect_success '--date with --committer changes both author and committer dates' '
+	git checkout -f Initial &&
+	echo "Test date override" >>foo &&
+	test_tick &&
+	git commit -a -m "test date" \
+		--author="Date Author <date@author.example>" \
+		--committer="Date Committer <date@committer.example>" \
+		--date="2024-06-15 10:30:00 +0800" &&
+	git log -1 --format="%ai" >author_date &&
+	git log -1 --format="%ci" >committer_date &&
+	grep "2024-06-15 10:30:00 +0800" author_date &&
+	grep "2024-06-15 10:30:00 +0800" committer_date
+'
+
 test_done

base-commit: 4badef0c3503dc29059d678abba7fac0f042bc84
-- 
gitgitgadget
