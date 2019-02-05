Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759BC1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 19:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfBETwc (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 14:52:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54964 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfBETwc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 14:52:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so186998wmh.4
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 11:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N8o62a3TrevpTwn3LYL7TlKRALcLMZeR6BYRIMmBEQQ=;
        b=EkExTq2LNazjy2N5vZalE6BzCtbE/9GBPYtQbgaki/O07/FA/Hrh0KMh9Qfj2zroqo
         lj6fJ5J9HO+ratIwDTfo5yDlae4GU56RlOsaCkOWxaLpEu5KUvir3kDmrzjfO8LrwDbq
         2dOJUbv7SwqcPAhiae3hImCS92HvgGO1QbWwPPy6+3hbEtXN4PFBLtACVZb3BPj8MpKU
         KUJlUr5GDEx+O/fb6UJTT2mgvchWwP2VCllerKlIdGFX7dYc3heSKwnCVykqG5zoyDLT
         AGtOfZQK829MleMfUatB2+OE4alNJOpd1Iq8tA2yrrGSmVPj64jSzUfFQa8YiY4Wamig
         7qSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N8o62a3TrevpTwn3LYL7TlKRALcLMZeR6BYRIMmBEQQ=;
        b=oSUr9zdjSL0J4Oofdd2atwKcVqG2V3vPQvKgxxzbQRr651zLpJBclnr7UBk1qhE5LC
         zVL1QJd7MEmtheoszn0RIYVhKjz8kYKume1/LBQlqLVvUlqmzyoukIvKDWXMkHVfjYa3
         FeVkzoibIQjVutQAfM4wZNHQQRTAZTZ6oGEz2JABy2nLWjLMpbKoZSbuUGU2ol7/uuZ0
         GEjL5DprsX2QFKojWX0sK7R8Lvi0CAT88tmyr3t6BT+IHT0c+3FIIeD5f/1LgN67I3zU
         0G+vM/9pRP3KLX0hVpJTLwYPA9PegWikJg5EJxexOzA16xAWAFSLeEQHEv/H8EOL0EXS
         ryFQ==
X-Gm-Message-State: AHQUAuZ+EMfvhL1qmrf9h8NOLexsOakLwxeSxqXCzOcf802Qx1cGGddB
        vRzNFDErppcL/wHsIOlnEifsHeCQ
X-Google-Smtp-Source: AHgI3IZe18pBkiTwzz+3zjDlmknbDLWkc450aXTEmC/JBWZxWYGh9oXa9TA2NtqdR9BL8XQTksdIKg==
X-Received: by 2002:a1c:7eca:: with SMTP id z193mr255891wmc.5.1549396347719;
        Tue, 05 Feb 2019 11:52:27 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j24sm24022240wrd.86.2019.02.05.11.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 11:52:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        William Hubbs <williamh@gentoo.org>, chutzpah@gentoo.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 2/2] config: allow giving separate author and committer idents
Date:   Tue,  5 Feb 2019 20:52:12 +0100
Message-Id: <20190205195212.25550-3-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1
In-Reply-To: <20190204184850.10040-1-williamh@gentoo.org>
References: <20190204184850.10040-1-williamh@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Hubbs <williamh@gentoo.org>

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
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/user.txt     |  23 ++++---
 Documentation/git-commit-tree.txt |   3 +-
 blame.c                           |   3 +-
 builtin/am.c                      |   1 +
 builtin/commit.c                  |   3 +-
 cache.h                           |  13 +++-
 config.c                          |   4 +-
 ident.c                           | 101 ++++++++++++++++++++++--------
 log-tree.c                        |   3 +-
 sequencer.c                       |   6 +-
 t/t7517-per-repo-email.sh         |  76 +++++++++++++++++++++-
 11 files changed, 190 insertions(+), 46 deletions(-)

diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index b5b2ba1199..0557cbbceb 100644
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
+	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`,
+	`GIT_COMMITTER_EMAIL` and `EMAIL` environment variables.
+	See linkgit:git-commit-tree[1] for more information.
 
 user.useConfigOnly::
 	Instruct Git to avoid trying to guess defaults for `user.email`
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 002dae625e..091e3a77ca 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -88,7 +88,8 @@ if set:
 (nb "<", ">" and "\n"s are stripped)
 
 In case (some of) these environment variables are not set, the information
-is taken from the configuration items user.name and user.email, or, if not
+is taken from the configuration items user.name and user.email, or the more
+specific author.{name,email} and committer.{name,email} variables, or, if not
 present, the environment variable EMAIL, or, if that is not set,
 system user name and the hostname used for outgoing mail (taken
 from `/etc/mailname` and falling back to the fully qualified hostname when
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
index 95370313b6..d4a1cbe828 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1594,6 +1594,7 @@ static void do_commit(const struct am_state *state)
 	}
 
 	author = fmt_ident(state->author_name, state->author_email,
+			WANT_AUTHOR_IDENT,
 			state->ignore_date ? NULL : state->author_date,
 			IDENT_STRICT);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 7d2e0b61e5..0af8fc3503 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -608,7 +608,8 @@ static void determine_author_info(struct strbuf *author_ident)
 		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
 	}
 
-	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
+	strbuf_addstr(author_ident, fmt_ident(name, email, WANT_AUTHOR_IDENT, date,
+					      IDENT_STRICT));
 	assert_split_ident(&author, author_ident);
 	export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
 	export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
diff --git a/cache.h b/cache.h
index 009e8b3b15..c2f9d4e680 100644
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
+	WANT_COMMITTER_IDENT
+};
+
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
-extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
-extern const char *fmt_name(const char *name, const char *email);
+extern const char *fmt_ident(const char *name, const char *email,
+			     enum want_ident whose_ident,
+			     const char *date_str, int flag);
+extern const char *fmt_name(enum want_ident);
 extern const char *ident_default_name(void);
 extern const char *ident_default_email(void);
 extern const char *git_editor(void);
diff --git a/config.c b/config.c
index ff521eb27a..fd36db7790 100644
--- a/config.c
+++ b/config.c
@@ -1445,7 +1445,9 @@ int git_default_config(const char *var, const char *value, void *cb)
 	if (starts_with(var, "core."))
 		return git_default_core_config(var, value, cb);
 
-	if (starts_with(var, "user."))
+	if (starts_with(var, "user.") ||
+	    starts_with(var, "author.") ||
+	    starts_with(var, "committer."))
 		return git_ident_config(var, value, cb);
 
 	if (starts_with(var, "i18n."))
diff --git a/ident.c b/ident.c
index 33bcf40644..7c3be81ee1 100644
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
 
@@ -355,13 +359,20 @@ N_("\n"
    "\n");
 
 const char *fmt_ident(const char *name, const char *email,
-		      const char *date_str, int flag)
+		      enum want_ident whose_ident, const char *date_str,
+		      int flag)
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
@@ -377,6 +388,13 @@ const char *fmt_ident(const char *name, const char *email,
 
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
@@ -425,9 +443,25 @@ const char *fmt_ident(const char *name, const char *email,
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
@@ -438,6 +472,7 @@ const char *git_author_info(int flag)
 		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
+			 WANT_AUTHOR_IDENT,
 			 getenv("GIT_AUTHOR_DATE"),
 			 flag);
 }
@@ -450,6 +485,7 @@ const char *git_committer_info(int flag)
 		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
+			 WANT_COMMITTER_IDENT,
 			 getenv("GIT_COMMITTER_DATE"),
 			 flag);
 }
@@ -473,6 +509,41 @@ int author_ident_sufficiently_given(void)
 	return ident_is_sufficient(author_ident_explicitly_given);
 }
 
+static int set_ident_internal(const char *var, const char *value,
+			    struct strbuf *sb, const int flag)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	strbuf_reset(sb);
+	strbuf_addstr(sb, value);
+	author_ident_explicitly_given |= flag;
+	ident_config_given |= flag;
+	return 0;
+}
+
+static int set_ident(const char *var, const char *value)
+{
+	if (!strcmp(var, "author.name"))
+		return set_ident_internal(var, value, &git_author_name,
+					  IDENT_NAME_GIVEN);
+	else if (!strcmp(var, "author.email"))
+		return set_ident_internal(var, value, &git_author_email,
+					  IDENT_MAIL_GIVEN);
+	else if (!strcmp(var, "committer.name"))
+		return set_ident_internal(var, value, &git_committer_name,
+					  IDENT_NAME_GIVEN);
+	else if (!strcmp(var, "committer.email"))
+		return set_ident_internal(var, value, &git_committer_email,
+					  IDENT_MAIL_GIVEN);
+	else if (!strcmp(var, "user.name"))
+		return set_ident_internal(var, value, &git_default_name,
+					  IDENT_NAME_GIVEN);
+	else if (!strcmp(var, "user.email"))
+		return set_ident_internal(var, value, &git_default_email,
+					  IDENT_MAIL_GIVEN);
+	return 0;
+}
+
 int git_ident_config(const char *var, const char *value, void *data)
 {
 	if (!strcmp(var, "user.useconfigonly")) {
@@ -480,29 +551,7 @@ int git_ident_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
-	if (!strcmp(var, "user.name")) {
-		if (!value)
-			return config_error_nonbool(var);
-		strbuf_reset(&git_default_name);
-		strbuf_addstr(&git_default_name, value);
-		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
-		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
-		ident_config_given |= IDENT_NAME_GIVEN;
-		return 0;
-	}
-
-	if (!strcmp(var, "user.email")) {
-		if (!value)
-			return config_error_nonbool(var);
-		strbuf_reset(&git_default_email);
-		strbuf_addstr(&git_default_email, value);
-		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-		ident_config_given |= IDENT_MAIL_GIVEN;
-		return 0;
-	}
-
-	return 0;
+	return set_ident(var, value);
 }
 
 static int buf_cmp(const char *a_begin, const char *a_end,
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
index 213815dbfc..c031787826 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -837,7 +837,8 @@ static const char *read_author_ident(struct strbuf *buf)
 	}
 
 	strbuf_reset(&out);
-	strbuf_addstr(&out, fmt_ident(name, email, date, 0));
+	strbuf_addstr(&out, fmt_ident(name, email, WANT_AUTHOR_IDENT, date,
+				      0));
 	strbuf_swap(buf, &out);
 	strbuf_release(&out);
 	free(name);
@@ -4094,8 +4095,7 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 	int has_footer;
 
 	strbuf_addstr(&sob, sign_off_header);
-	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
-				getenv("GIT_COMMITTER_EMAIL")));
+	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
 	strbuf_addch(&sob, '\n');
 
 	if (!ignore_footer)
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index 84bd9e89e5..e0182779ed 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -85,7 +85,7 @@ test_expect_success REBASE_P \
 	test_must_fail git rebase -p master
 '
 
-test_expect_success 'fallbacks for GIT_* and user.{name,email}' '
+test_expect_success 'fallbacks for GIT_* and {user,author,committer}.{name,email}' '
 	# We must have committer in the object
 	test_must_fail test_env \
 		GIT_AUTHOR_NAME=author.name \
@@ -119,4 +119,78 @@ test_expect_success 'fallbacks for GIT_* and user.{name,email}' '
 	test_cmp expected actual
 '
 
+test_expect_success 'author.name overrides user.name' '
+	test_config user.name user &&
+	test_config user.email user@example.com &&
+	test_config author.name author &&
+	test_commit author-name-override-user &&
+	echo author user@example.com >expected-author &&
+	echo user user@example.com >expected-committer &&
+	git log --format="%an %ae" -1 >actual-author &&
+	git log --format="%cn %ce" -1 >actual-committer &&
+	test_cmp expected-author actual-author &&
+	test_cmp expected-committer actual-committer
+'
+
+test_expect_success 'author.email overrides user.email' '
+	test_config user.name user &&
+	test_config user.email user@example.com &&
+	test_config author.email author@example.com &&
+	test_commit author-email-override-user &&
+	echo user author@example.com >expected-author &&
+	echo user user@example.com >expected-committer &&
+	git log --format="%an %ae" -1 >actual-author &&
+	git log --format="%cn %ce" -1 >actual-committer &&
+	test_cmp expected-author actual-author &&
+	test_cmp expected-committer actual-committer
+'
+
+test_expect_success 'committer.name overrides user.name' '
+	test_config user.name user &&
+	test_config user.email user@example.com &&
+	test_config committer.name committer &&
+	test_commit committer-name-override-user &&
+	echo user user@example.com >expected-author &&
+	echo committer user@example.com >expected-committer &&
+	git log --format="%an %ae" -1 >actual-author &&
+	git log --format="%cn %ce" -1 >actual-committer &&
+	test_cmp expected-author actual-author &&
+	test_cmp expected-committer actual-committer
+'
+
+test_expect_success 'committer.email overrides user.email' '
+	test_config user.name user &&
+	test_config user.email user@example.com &&
+	test_config committer.email committer@example.com &&
+	test_commit committer-email-override-user &&
+	echo user user@example.com >expected-author &&
+	echo user committer@example.com >expected-committer &&
+	git log --format="%an %ae" -1 >actual-author &&
+	git log --format="%cn %ce" -1 >actual-committer &&
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
+
+	test_env \
+		GIT_AUTHOR_NAME=env_author \
+		GIT_AUTHOR_EMAIL=env_author@example.com \
+		GIT_COMMITTER_NAME=env_commit \
+		GIT_COMMITTER_EMAIL=env_commit@example.com \
+		test_commit env-override-conf &&
+	echo env_author env_author@example.com >expected-author &&
+	echo env_commit env_commit@example.com >expected-committer &&
+	git log --format="%an %ae" -1 >actual-author &&
+	git log --format="%cn %ce" -1 >actual-committer &&
+	test_cmp expected-author actual-author &&
+	test_cmp expected-committer actual-committer
+'
+
 test_done
-- 
2.20.1.611.gfbb209baf1

