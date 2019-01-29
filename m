Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DE41F453
	for <e@80x24.org>; Tue, 29 Jan 2019 23:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfA2XI1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 18:08:27 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38074 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfA2XI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 18:08:27 -0500
Received: by mail-qt1-f193.google.com with SMTP id p17so24287059qtl.5
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 15:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TlytZHre6m6yA6cxjoL5VFwlicwDfmEBstAtsm/QNnU=;
        b=bwcBtbEUq5fk7NB+WhzYchxOKeNJI7lXoN1gC1YXMnTYFKhK/PVNW4EiWO4kIuf3wx
         bqE2Ba6CWeKX44KQTgju/bB7UFXic9aZ2fwvmZ1zPTkOf6NFIXO52hWnXuArLP/BYRbJ
         7f3n+wH7LdQYnDPVcJ6+QiH1+z0mVbCV/n5boNrUDLrqGkQcPqUAShv1MJdaXYO+0qIf
         mjWzH//rg/QUkptOhujTFTMPa5bNY1rlvHVwKIE2Wtqe5bx67be3qNzg3E6ftbu0gApj
         Mpkj2zfmanC1Ghr9fsARLE6O7Jte5kbG3+v+wXQYmaoaafWAFnHz2KAzxvzGu3e/ducK
         Nl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TlytZHre6m6yA6cxjoL5VFwlicwDfmEBstAtsm/QNnU=;
        b=ZLcqV3mIWT6CPE0S/9Q1f4VcpLUrEMOURilSXvaa5rOpEpstoDb5hTdGhWfQoIIJbp
         +fpKCz9/1i5ZDkukkUXgLeaTJVAlc20TS7m7VVlFUvRZYnNWDOhR3xY/bHPDqMJ3gffE
         yHpIY+Bf8cvu4qBeH3T1oWb79N2C8CxWCTJEpCrteGi5S+yKjd04s0eOYOx9ofMUds7t
         CChxNaTz+aoUlw31lHyu18OZgkcy4GT1du/MsDf4w3TH9JOoo/MnqQB04c7cQStEDA/4
         P9nrcosY/rIf2PA2kYgOEiVAdc0u0iVDHszDM6QZxO2onQh1L4ie+eTmxLysN4hpCg9l
         TEcw==
X-Gm-Message-State: AJcUukfvR4qDyAETkJOGYhe7ctw+QKq10VxzGga43taWLHpVAcaWnLC8
        FPFJeYNiZsMnKyBZo4eLHheyyWyp
X-Google-Smtp-Source: ALg8bN7M5KecHOwL1YLUYP5KWTSGvJhFiNbbyNqs+XQkB2ZTfIz9T1npGS7ObmNk/Rynvjmp7urFeg==
X-Received: by 2002:a0c:f212:: with SMTP id h18mr26829012qvk.106.1548803304702;
        Tue, 29 Jan 2019 15:08:24 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id n72sm93423952qki.26.2019.01.29.15.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 15:08:23 -0800 (PST)
Received: (nullmailer pid 5344 invoked by uid 1000);
        Tue, 29 Jan 2019 23:08:22 -0000
From:   William Hubbs <williamh@gentoo.org>
To:     git@vger.kernel.org
Cc:     williamh@gentoo.org, chutzpah@gentoo.org
Subject: [PATCH v3 1/1] config: allow giving separate author and committer idents
Date:   Tue, 29 Jan 2019 17:08:06 -0600
Message-Id: <20190129230806.5295-2-williamh@gentoo.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190129230806.5295-1-williamh@gentoo.org>
References: <20190129230806.5295-1-williamh@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The author.email, author.name, committer.email and committer.name
settings are analogous to the GIT_AUTHOR_* and GIT_COMMITTER_*
environment variables, but for the git config system. This allows them
to be set separately for each repository.

Git supports setting different authorship and committer
information with environment variables. However, environment variables
are set in the shell, so if different authorship and committer
information is needed for different repositories an external tool is
required.

This adds support to git config for author.email, author.name,
committer.email and committer.name  settings so this information
can be set per repository.

Also, it generalizes the fmt_ident function so it can handle author vs
committer identification.

Signed-off-by: William Hubbs <williamh@gentoo.org>
---
 Documentation/config/user.txt | 23 ++++++---
 blame.c                       |  3 +-
 builtin/am.c                  |  1 +
 builtin/commit.c              |  3 +-
 cache.h                       | 13 ++++-
 config.c                      |  6 +++
 ident.c                       | 92 ++++++++++++++++++++++++++++++++---
 log-tree.c                    |  3 +-
 sequencer.c                   |  5 +-
 t/t7517-per-repo-email.sh     | 74 ++++++++++++++++++++++++++++
 10 files changed, 200 insertions(+), 23 deletions(-)

diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index b5b2ba1199..8b31b5fa31 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -1,12 +1,19 @@
-user.email::
-	Your email address to be recorded in any newly created commits.
-	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, and
-	`EMAIL` environment variables.  See linkgit:git-commit-tree[1].
-
 user.name::
-	Your full name to be recorded in any newly created commits.
-	Can be overridden by the `GIT_AUTHOR_NAME` and `GIT_COMMITTER_NAME`
-	environment variables.  See linkgit:git-commit-tree[1].
+user.email::
+author.name::
+author.email::
+committer.name::
+committer.email::
+	The `user.name` and `user.email` variables determine what ends
+	up in the `author` and `committer` field of commit
+	objects.
+	If you need the `author` or `committer` to be different, the
+	`author.name`, `author.email`, `committer.name` or
+	`committer.email` variables can be set.
+	Also, all of these can be overridden by the `GIT_AUTHOR_NAME`,
+	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME` and
+	`GIT_COMMITTER_EMAIL` environment variables.
+	See linkgit:git-commit-tree[1] for more information.
 
 user.useConfigOnly::
 	Instruct Git to avoid trying to guess defaults for `user.email`
diff --git a/blame.c b/blame.c
index 43861437f7..c9c351eb36 100644
--- a/blame.c
+++ b/blame.c
@@ -204,7 +204,8 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 
 	origin = make_origin(commit, path);
 
-	ident = fmt_ident("Not Committed Yet", "not.committed.yet", NULL, 0);
+	ident = fmt_ident("Not Committed Yet", "not.committed.yet",
+			WANT_BLANK_IDENT, NULL, 0);
 	strbuf_addstr(&msg, "tree 0000000000000000000000000000000000000000\n");
 	for (parent = commit->parents; parent; parent = parent->next)
 		strbuf_addf(&msg, "parent %s\n",
diff --git a/builtin/am.c b/builtin/am.c
index 95370313b6..3727d4d267 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1594,6 +1594,7 @@ static void do_commit(const struct am_state *state)
 	}
 
 	author = fmt_ident(state->author_name, state->author_email,
+		WANT_AUTHOR_IDENT,
 			state->ignore_date ? NULL : state->author_date,
 			IDENT_STRICT);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 7d2e0b61e5..98c642d993 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -608,7 +608,8 @@ static void determine_author_info(struct strbuf *author_ident)
 		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
 	}
 
-	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
+	strbuf_addstr(author_ident, fmt_ident(name, email, WANT_AUTHOR_IDENT, date,
+				IDENT_STRICT));
 	assert_split_ident(&author, author_ident);
 	export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
 	export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
diff --git a/cache.h b/cache.h
index 009e8b3b15..375be1f68b 100644
--- a/cache.h
+++ b/cache.h
@@ -1494,10 +1494,19 @@ int date_overflows(timestamp_t date);
 #define IDENT_STRICT	       1
 #define IDENT_NO_DATE	       2
 #define IDENT_NO_NAME	       4
+
+enum want_ident {
+	WANT_BLANK_IDENT,
+	WANT_AUTHOR_IDENT,
+	WANT_COMMITTER_IDENT,
+};
+
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
-extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
-extern const char *fmt_name(const char *name, const char *email);
+extern const char *fmt_ident(const char *name, const char *email,
+		enum want_ident whose_ident,
+		const char *date_str, int);
+extern const char *fmt_name(enum want_ident);
 extern const char *ident_default_name(void);
 extern const char *ident_default_email(void);
 extern const char *git_editor(void);
diff --git a/config.c b/config.c
index ff521eb27a..4bd5920dea 100644
--- a/config.c
+++ b/config.c
@@ -1484,6 +1484,12 @@ int git_default_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (starts_with(var, "author."))
+		return git_ident_config(var, value, cb);
+
+	if (starts_with(var, "committer."))
+		return git_ident_config(var, value, cb);
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/ident.c b/ident.c
index 33bcf40644..9c2eb0a2d0 100644
--- a/ident.c
+++ b/ident.c
@@ -11,6 +11,10 @@
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
 static struct strbuf git_default_date = STRBUF_INIT;
+static struct strbuf git_author_name = STRBUF_INIT;
+static struct strbuf git_author_email = STRBUF_INIT;
+static struct strbuf git_committer_name = STRBUF_INIT;
+static struct strbuf git_committer_email = STRBUF_INIT;
 static int default_email_is_bogus;
 static int default_name_is_bogus;
 
@@ -355,13 +359,19 @@ N_("\n"
    "\n");
 
 const char *fmt_ident(const char *name, const char *email,
-		      const char *date_str, int flag)
+		      enum want_ident whose_ident, const char *date_str, int flag)
 {
 	static struct strbuf ident = STRBUF_INIT;
 	int strict = (flag & IDENT_STRICT);
 	int want_date = !(flag & IDENT_NO_DATE);
 	int want_name = !(flag & IDENT_NO_NAME);
 
+	if (!email) {
+		if (whose_ident == WANT_AUTHOR_IDENT && git_author_email.len)
+			email = git_author_email.buf;
+		else if (whose_ident == WANT_COMMITTER_IDENT && git_committer_email.len)
+			email = git_committer_email.buf;
+	}
 	if (!email) {
 		if (strict && ident_use_config_only
 		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
@@ -377,6 +387,13 @@ const char *fmt_ident(const char *name, const char *email,
 
 	if (want_name) {
 		int using_default = 0;
+		if (!name) {
+			if (whose_ident == WANT_AUTHOR_IDENT && git_author_name.len)
+				name = git_author_name.buf;
+			else if (whose_ident == WANT_COMMITTER_IDENT &&
+					git_committer_name.len)
+				name = git_committer_name.buf;
+		}
 		if (!name) {
 			if (strict && ident_use_config_only
 			    && !(ident_config_given & IDENT_NAME_GIVEN)) {
@@ -425,9 +442,25 @@ const char *fmt_ident(const char *name, const char *email,
 	return ident.buf;
 }
 
-const char *fmt_name(const char *name, const char *email)
+const char *fmt_name(enum want_ident whose_ident)
 {
-	return fmt_ident(name, email, NULL, IDENT_STRICT | IDENT_NO_DATE);
+	char *name = NULL;
+	char *email = NULL;
+
+	switch (whose_ident) {
+	case WANT_BLANK_IDENT:
+		break;
+	case WANT_AUTHOR_IDENT:
+		name = getenv("GIT_AUTHOR_NAME");
+		email = getenv("GIT_AUTHOR_EMAIL");
+		break;
+	case WANT_COMMITTER_IDENT:
+		name = getenv("GIT_COMMITTER_NAME");
+		email = getenv("GIT_COMMITTER_EMAIL");
+		break;
+	}
+	return fmt_ident(name, email, whose_ident, NULL,
+			IDENT_STRICT | IDENT_NO_DATE);
 }
 
 const char *git_author_info(int flag)
@@ -438,6 +471,7 @@ const char *git_author_info(int flag)
 		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
+			 WANT_AUTHOR_IDENT,
 			 getenv("GIT_AUTHOR_DATE"),
 			 flag);
 }
@@ -450,6 +484,7 @@ const char *git_committer_info(int flag)
 		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
+			 WANT_COMMITTER_IDENT,
 			 getenv("GIT_COMMITTER_DATE"),
 			 flag);
 }
@@ -473,10 +508,45 @@ int author_ident_sufficiently_given(void)
 	return ident_is_sufficient(author_ident_explicitly_given);
 }
 
-int git_ident_config(const char *var, const char *value, void *data)
+static int set_ident(const char *var, const char *value)
 {
-	if (!strcmp(var, "user.useconfigonly")) {
-		ident_use_config_only = git_config_bool(var, value);
+	if (!strcmp(var, "author.name")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strbuf_reset(&git_author_name);
+		strbuf_addstr(&git_author_name, value);
+		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		ident_config_given |= IDENT_NAME_GIVEN;
+		return 0;
+	}
+
+	if (!strcmp(var, "author.email")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strbuf_reset(&git_author_email);
+		strbuf_addstr(&git_author_email, value);
+		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		ident_config_given |= IDENT_MAIL_GIVEN;
+		return 0;
+	}
+
+	if (!strcmp(var, "committer.name")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strbuf_reset(&git_committer_name);
+		strbuf_addstr(&git_committer_name, value);
+		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		ident_config_given |= IDENT_NAME_GIVEN;
+		return 0;
+	}
+
+	if (!strcmp(var, "committer.email")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strbuf_reset(&git_committer_email);
+		strbuf_addstr(&git_committer_email, value);
+		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		ident_config_given |= IDENT_MAIL_GIVEN;
 		return 0;
 	}
 
@@ -505,6 +575,16 @@ int git_ident_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
+int git_ident_config(const char *var, const char *value, void *data)
+{
+	if (!strcmp(var, "user.useconfigonly")) {
+		ident_use_config_only = git_config_bool(var, value);
+		return 0;
+	}
+
+	return set_ident(var, value);
+}
+
 static int buf_cmp(const char *a_begin, const char *a_end,
 		   const char *b_begin, const char *b_end)
 {
diff --git a/log-tree.c b/log-tree.c
index 3cb14256ec..1e56df62a7 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -687,8 +687,7 @@ void show_log(struct rev_info *opt)
 	 */
 	if (ctx.need_8bit_cte >= 0 && opt->add_signoff)
 		ctx.need_8bit_cte =
-			has_non_ascii(fmt_name(getenv("GIT_COMMITTER_NAME"),
-					       getenv("GIT_COMMITTER_EMAIL")));
+			has_non_ascii(fmt_name(WANT_COMMITTER_IDENT));
 	ctx.date_mode = opt->date_mode;
 	ctx.date_mode_explicit = opt->date_mode_explicit;
 	ctx.abbrev = opt->diffopt.abbrev;
diff --git a/sequencer.c b/sequencer.c
index 213815dbfc..fe2a1b2fcf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -837,7 +837,7 @@ static const char *read_author_ident(struct strbuf *buf)
 	}
 
 	strbuf_reset(&out);
-	strbuf_addstr(&out, fmt_ident(name, email, date, 0));
+	strbuf_addstr(&out, fmt_ident(name, email, WANT_AUTHOR_IDENT, date, 0));
 	strbuf_swap(buf, &out);
 	strbuf_release(&out);
 	free(name);
@@ -4094,8 +4094,7 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 	int has_footer;
 
 	strbuf_addstr(&sob, sign_off_header);
-	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
-				getenv("GIT_COMMITTER_EMAIL")));
+	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
 	strbuf_addch(&sob, '\n');
 
 	if (!ignore_footer)
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index 231b8cc19d..b2401cec3e 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -85,4 +85,78 @@ test_expect_success REBASE_P \
 	test_must_fail git rebase -p master
 '
 
+test_expect_success 'author.name overrides user.name' '
+	test_config user.name user &&
+	test_config user.email user@example.com &&
+	test_config author.name author &&
+	test_commit author-name-override-user &&
+	echo author user@example.com > expected-author &&
+	echo user user@example.com > expected-committer &&
+	git log --format="%an %ae" -1 > actual-author &&
+	git log --format="%cn %ce" -1 > actual-committer &&
+	test_cmp expected-author actual-author &&
+	test_cmp expected-committer actual-committer
+'
+
+test_expect_success 'author.email overrides user.email' '
+	test_config user.name user &&
+	test_config user.email user@example.com &&
+	test_config author.email author@example.com &&
+	test_commit author-email-override-user &&
+	echo user author@example.com > expected-author &&
+	echo user user@example.com > expected-committer &&
+	git log --format="%an %ae" -1 > actual-author &&
+	git log --format="%cn %ce" -1 > actual-committer &&
+	test_cmp expected-author actual-author &&
+	test_cmp expected-committer actual-committer
+'
+
+test_expect_success 'committer.name overrides user.name' '
+	test_config user.name user &&
+	test_config user.email user@example.com &&
+	test_config committer.name committer &&
+	test_commit committer-name-override-user &&
+	echo user user@example.com > expected-author &&
+	echo committer user@example.com > expected-committer &&
+	git log --format="%an %ae" -1 > actual-author &&
+	git log --format="%cn %ce" -1 > actual-committer &&
+	test_cmp expected-author actual-author &&
+	test_cmp expected-committer actual-committer
+'
+
+test_expect_success 'committer.email overrides user.email' '
+	test_config user.name user &&
+	test_config user.email user@example.com &&
+	test_config committer.email committer@example.com &&
+	test_commit committer-email-override-user &&
+	echo user user@example.com > expected-author &&
+	echo user committer@example.com > expected-committer &&
+	git log --format="%an %ae" -1 > actual-author &&
+	git log --format="%cn %ce" -1 > actual-committer &&
+	test_cmp expected-author actual-author &&
+	test_cmp expected-committer actual-committer
+'
+
+test_expect_success 'author and committer environment variables override config settings' '
+	test_config user.name user &&
+	test_config user.email user@example.com &&
+	test_config author.name author &&
+	test_config author.email author@example.com &&
+	test_config committer.name committer &&
+	test_config committer.email committer@example.com &&
+	GIT_AUTHOR_NAME=env_author && export GIT_AUTHOR_NAME &&
+	GIT_AUTHOR_EMAIL=env_author@example.com && export GIT_AUTHOR_EMAIL &&
+	GIT_COMMITTER_NAME=env_commit && export GIT_COMMITTER_NAME &&
+	GIT_COMMITTER_EMAIL=env_commit@example.com && export GIT_COMMITTER_EMAIL &&
+	test_commit env-override-conf &&
+	echo env_author env_author@example.com > expected-author &&
+	echo env_commit env_commit@example.com > expected-committer &&
+	git log --format="%an %ae" -1 > actual-author &&
+	git log --format="%cn %ce" -1 > actual-committer &&
+	sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
+	sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
+	test_cmp expected-author actual-author &&
+	test_cmp expected-committer actual-committer
+'
+
 test_done
-- 
2.19.2

