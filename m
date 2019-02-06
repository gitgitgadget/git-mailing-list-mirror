Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253B81F453
	for <e@80x24.org>; Wed,  6 Feb 2019 05:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfBFFDx (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 00:03:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40617 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfBFFDw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 00:03:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id q21so1192908wmc.5
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 21:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=T0sNqWqYQGhTogi9I1rUVv41nOwTkGmITKw05SBrUtc=;
        b=d5OKeWU8QzACaoChxbzUD+ng8LeLhLgPgIk6DEQBMDkwgeUEw3EJF4/mDiqhlu0M4y
         PeCJS01150qUqDdyFONy4Xuk8kMnkPiS8B3JqHURhz4gs2Q11yFoe6l76FKZBKz7WBpg
         9TIfSr8VCL+cF56PwOIuFihNk6P20Iw1lgCBH67fVRHdUReTffMUb8zh+lIFh2r8ZrgQ
         7bpp4+JI07aNODZkvb+T15YjXI7iLPTltljQbaCSHMxbLXlO8ca5mje76aP9vivKCjf8
         FktbFebLAXqhA8vvBvLgUunvqd3OnnLblJJf9rzeVyqNWyh576HnsZdbWC/Bfx07/5WV
         QM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=T0sNqWqYQGhTogi9I1rUVv41nOwTkGmITKw05SBrUtc=;
        b=gwBvt/usTaCW1Vt0vwvI9TX2TAKzISmP4zoQfYHULFnwFQPsFoJn3nZis4bO0htdb2
         BVy5Xd6Ag/GCBW2y3jQg/pha6H3iJ8GbVz2ejq5HrN/XjDiaQt4uAqieGVhd/JU3glP6
         RQRcSa2elfPT3T+r4jK9Wz+fxDgCIIFO6k4+zI5azCZOH6gnBt7FrCWsXQfPJrpTakgI
         DmR4Ona+lOMmDNJfj+k4T4iO0oAOVZE+OK4EITUQqJOrbpCb6Okal7Sfw4WFVgHL6YCJ
         8I2bhms2f7fFsLljcDhElp3Y64psPcD8NuIbobsTUkWL+4H8Dyb1BG+4cJqYfp0gSW8T
         RodQ==
X-Gm-Message-State: AHQUAubePX+DWD9MGYGlxe902KQ3M18vccEj2J2ZDB1yq0Xb46au0Yu1
        wrwwEVcjtf34IwGLCrO38vk=
X-Google-Smtp-Source: AHgI3IYHsHs3a+dyJzvB2h4FPnsbF2wi0Ey6MRACnQMehx51eIqGKzkqBj4qf4vklZkQoUtAboGaUA==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr1591180wmg.48.1549429429315;
        Tue, 05 Feb 2019 21:03:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y24sm8504313wma.0.2019.02.05.21.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 21:03:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Hubbs <williamh@gentoo.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and committer idents
References: <20190204184850.10040-1-williamh@gentoo.org>
        <20190205195212.25550-3-avarab@gmail.com>
        <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
        <87k1iekkea.fsf@evledraar.gmail.com>
        <20190206000413.GA734@whubbs1.gaikai.biz>
Date:   Tue, 05 Feb 2019 21:03:47 -0800
In-Reply-To: <20190206000413.GA734@whubbs1.gaikai.biz> (William Hubbs's
        message of "Tue, 5 Feb 2019 18:04:13 -0600")
Message-ID: <xmqqwomdqzik.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Hubbs <williamh@gentoo.org> writes:

> I attempted to save your patches to apply them, but didn't have any luck

I'll push a topic branch (not merged to any of the integration
branches) ab/author-committer-ident-config later today at the
https://github.com/gitster/git repository.

> Also, according to Junio's report, my patch is already merged to next,

In an earlier "What's cooking" I may have said that I plan to merge
it to 'next', but I think the plan is now to leave it there for now
until this discussion settles and the latest report should reflect
that.

I just double-checked and wh/author-committer-ident-config is not in
'next'.  Whew.

Here is a diff that turns wh/author-committer-ident-config into what
ab/author-committer-ident-config has.  There are some formatting
changes, all of which I agree with, a bogus set_ident() refactoring
that should not be used, in addition to some test changes.

 Documentation/git-commit-tree.txt |  3 +-
 builtin/am.c                      |  2 +-
 builtin/commit.c                  |  2 +-
 cache.h                           |  4 +-
 ident.c                           | 95 +++++++++++++--------------------------
 sequencer.c                       |  3 +-
 t/t7517-per-repo-email.sh         | 88 +++++++++++++++++++++++++-----------
 7 files changed, 101 insertions(+), 96 deletions(-)

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
diff --git a/builtin/am.c b/builtin/am.c
index 3727d4d267..d4a1cbe828 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1594,7 +1594,7 @@ static void do_commit(const struct am_state *state)
 	}
 
 	author = fmt_ident(state->author_name, state->author_email,
-		WANT_AUTHOR_IDENT,
+			WANT_AUTHOR_IDENT,
 			state->ignore_date ? NULL : state->author_date,
 			IDENT_STRICT);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index f96b90daeb..a7879d65d1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -608,7 +608,7 @@ static void determine_author_info(struct strbuf *author_ident)
 	}
 
 	strbuf_addstr(author_ident, fmt_ident(name, email, WANT_AUTHOR_IDENT, date,
-				IDENT_STRICT));
+					      IDENT_STRICT));
 	assert_split_ident(&author, author_ident);
 	export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
 	export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
diff --git a/cache.h b/cache.h
index bb78eb9a3a..ca6ba1e423 100644
--- a/cache.h
+++ b/cache.h
@@ -1489,8 +1489,8 @@ enum want_ident {
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email,
-		enum want_ident whose_ident,
-		const char *date_str, int);
+			     enum want_ident whose_ident,
+			     const char *date_str, int flag);
 extern const char *fmt_name(enum want_ident);
 extern const char *ident_default_name(void);
 extern const char *ident_default_email(void);
diff --git a/ident.c b/ident.c
index 9c2eb0a2d0..7c3be81ee1 100644
--- a/ident.c
+++ b/ident.c
@@ -359,7 +359,8 @@ N_("\n"
    "\n");
 
 const char *fmt_ident(const char *name, const char *email,
-		      enum want_ident whose_ident, const char *date_str, int flag)
+		      enum want_ident whose_ident, const char *date_str,
+		      int flag)
 {
 	static struct strbuf ident = STRBUF_INIT;
 	int strict = (flag & IDENT_STRICT);
@@ -508,70 +509,38 @@ int author_ident_sufficiently_given(void)
 	return ident_is_sufficient(author_ident_explicitly_given);
 }
 
-static int set_ident(const char *var, const char *value)
+static int set_ident_internal(const char *var, const char *value,
+			    struct strbuf *sb, const int flag)
 {
-	if (!strcmp(var, "author.name")) {
-		if (!value)
-			return config_error_nonbool(var);
-		strbuf_reset(&git_author_name);
-		strbuf_addstr(&git_author_name, value);
-		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
-		ident_config_given |= IDENT_NAME_GIVEN;
-		return 0;
-	}
-
-	if (!strcmp(var, "author.email")) {
-		if (!value)
-			return config_error_nonbool(var);
-		strbuf_reset(&git_author_email);
-		strbuf_addstr(&git_author_email, value);
-		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-		ident_config_given |= IDENT_MAIL_GIVEN;
-		return 0;
-	}
-
-	if (!strcmp(var, "committer.name")) {
-		if (!value)
-			return config_error_nonbool(var);
-		strbuf_reset(&git_committer_name);
-		strbuf_addstr(&git_committer_name, value);
-		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
-		ident_config_given |= IDENT_NAME_GIVEN;
-		return 0;
-	}
-
-	if (!strcmp(var, "committer.email")) {
-		if (!value)
-			return config_error_nonbool(var);
-		strbuf_reset(&git_committer_email);
-		strbuf_addstr(&git_committer_email, value);
-		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-		ident_config_given |= IDENT_MAIL_GIVEN;
-		return 0;
-	}
-
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
+	if (!value)
+		return config_error_nonbool(var);
+	strbuf_reset(sb);
+	strbuf_addstr(sb, value);
+	author_ident_explicitly_given |= flag;
+	ident_config_given |= flag;
+	return 0;
+}
 
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
 	return 0;
 }
 
diff --git a/sequencer.c b/sequencer.c
index 3505d52bb9..98ba2106f6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -836,7 +836,8 @@ static const char *read_author_ident(struct strbuf *buf)
 	}
 
 	strbuf_reset(&out);
-	strbuf_addstr(&out, fmt_ident(name, email, WANT_AUTHOR_IDENT, date, 0));
+	strbuf_addstr(&out, fmt_ident(name, email, WANT_AUTHOR_IDENT, date,
+				      0));
 	strbuf_swap(buf, &out);
 	strbuf_release(&out);
 	free(name);
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index b2401cec3e..e0182779ed 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -85,15 +85,49 @@ test_expect_success REBASE_P \
 	test_must_fail git rebase -p master
 '
 
+test_expect_success 'fallbacks for GIT_* and {user,author,committer}.{name,email}' '
+	# We must have committer in the object
+	test_must_fail test_env \
+		GIT_AUTHOR_NAME=author.name \
+		GIT_AUTHOR_EMAIL=author@email \
+		GIT_COMMITTER_NAME= \
+		GIT_COMMITTER_EMAIL= \
+		test_commit A 2>stderr &&
+	test_i18ngrep "empty ident name.*not allowed" stderr &&
+
+	# With no committer E-Mail we will have an empty field
+	test_env \
+		GIT_AUTHOR_NAME=author.name \
+		GIT_AUTHOR_EMAIL=author@email \
+		GIT_COMMITTER_NAME=committer.name \
+		GIT_COMMITTER_EMAIL= \
+		test_commit B 2>stderr &&
+	echo "author.name author@email committer.name " >expected &&
+	git log --format="%an %ae %cn %ce" -1 >actual &&
+	test_cmp expected actual &&
+
+	# Environment overrides config
+	test_config user.name author.config.name &&
+	test_env \
+		GIT_AUTHOR_NAME=author.name \
+		GIT_AUTHOR_EMAIL=author@email \
+		GIT_COMMITTER_NAME=committer.name \
+		GIT_COMMITTER_EMAIL= \
+		test_commit C 2>stderr &&
+	echo "author.name author@email committer.name " >expected &&
+	git log --format="%an %ae %cn %ce" -1 >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'author.name overrides user.name' '
 	test_config user.name user &&
 	test_config user.email user@example.com &&
 	test_config author.name author &&
 	test_commit author-name-override-user &&
-	echo author user@example.com > expected-author &&
-	echo user user@example.com > expected-committer &&
-	git log --format="%an %ae" -1 > actual-author &&
-	git log --format="%cn %ce" -1 > actual-committer &&
+	echo author user@example.com >expected-author &&
+	echo user user@example.com >expected-committer &&
+	git log --format="%an %ae" -1 >actual-author &&
+	git log --format="%cn %ce" -1 >actual-committer &&
 	test_cmp expected-author actual-author &&
 	test_cmp expected-committer actual-committer
 '
@@ -103,10 +137,10 @@ test_expect_success 'author.email overrides user.email' '
 	test_config user.email user@example.com &&
 	test_config author.email author@example.com &&
 	test_commit author-email-override-user &&
-	echo user author@example.com > expected-author &&
-	echo user user@example.com > expected-committer &&
-	git log --format="%an %ae" -1 > actual-author &&
-	git log --format="%cn %ce" -1 > actual-committer &&
+	echo user author@example.com >expected-author &&
+	echo user user@example.com >expected-committer &&
+	git log --format="%an %ae" -1 >actual-author &&
+	git log --format="%cn %ce" -1 >actual-committer &&
 	test_cmp expected-author actual-author &&
 	test_cmp expected-committer actual-committer
 '
@@ -116,10 +150,10 @@ test_expect_success 'committer.name overrides user.name' '
 	test_config user.email user@example.com &&
 	test_config committer.name committer &&
 	test_commit committer-name-override-user &&
-	echo user user@example.com > expected-author &&
-	echo committer user@example.com > expected-committer &&
-	git log --format="%an %ae" -1 > actual-author &&
-	git log --format="%cn %ce" -1 > actual-committer &&
+	echo user user@example.com >expected-author &&
+	echo committer user@example.com >expected-committer &&
+	git log --format="%an %ae" -1 >actual-author &&
+	git log --format="%cn %ce" -1 >actual-committer &&
 	test_cmp expected-author actual-author &&
 	test_cmp expected-committer actual-committer
 '
@@ -129,10 +163,10 @@ test_expect_success 'committer.email overrides user.email' '
 	test_config user.email user@example.com &&
 	test_config committer.email committer@example.com &&
 	test_commit committer-email-override-user &&
-	echo user user@example.com > expected-author &&
-	echo user committer@example.com > expected-committer &&
-	git log --format="%an %ae" -1 > actual-author &&
-	git log --format="%cn %ce" -1 > actual-committer &&
+	echo user user@example.com >expected-author &&
+	echo user committer@example.com >expected-committer &&
+	git log --format="%an %ae" -1 >actual-author &&
+	git log --format="%cn %ce" -1 >actual-committer &&
 	test_cmp expected-author actual-author &&
 	test_cmp expected-committer actual-committer
 '
@@ -144,17 +178,17 @@ test_expect_success 'author and committer environment variables override config
 	test_config author.email author@example.com &&
 	test_config committer.name committer &&
 	test_config committer.email committer@example.com &&
-	GIT_AUTHOR_NAME=env_author && export GIT_AUTHOR_NAME &&
-	GIT_AUTHOR_EMAIL=env_author@example.com && export GIT_AUTHOR_EMAIL &&
-	GIT_COMMITTER_NAME=env_commit && export GIT_COMMITTER_NAME &&
-	GIT_COMMITTER_EMAIL=env_commit@example.com && export GIT_COMMITTER_EMAIL &&
-	test_commit env-override-conf &&
-	echo env_author env_author@example.com > expected-author &&
-	echo env_commit env_commit@example.com > expected-committer &&
-	git log --format="%an %ae" -1 > actual-author &&
-	git log --format="%cn %ce" -1 > actual-committer &&
-	sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
-	sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
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
 	test_cmp expected-author actual-author &&
 	test_cmp expected-committer actual-committer
 '

