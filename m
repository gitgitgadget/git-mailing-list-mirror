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
	by dcvr.yhbt.net (Postfix) with ESMTP id 156BC1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 19:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfBETw0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 14:52:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39156 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfBETw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 14:52:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so209342wmi.4
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 11:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HNxSMbX9zbFq+nPsYw+YELdPEJLqDHw+pGKoc+akiA=;
        b=r/yx8+iV/vu5V9HoHQtoMOnrwFLkpKTQ1LqdutC+Tn9dQfm2o114I/byfxnQ4kNdsX
         5cbE4sLK5qCVvMBo4s4uQRVs2NFpf70bW+srMgPlYZAGVqQXp1zHSl+pz5AKIgPx5Q0N
         MUwTneh96Rgxm5AEH1NYtIA0sShh72kSDZ/PpbJXefQtBnMRBuHt1p0OztxrVxtqrKpE
         m9oGjF3kaLJXZli7tFjMnuNZbOrTolXeU/kxxAxGW4XUuuAjf4u2uDOyt9iVV/EL+sFc
         Sf9yJSred03gfYjzDJmmm/UqKHG5s15ghrOmBt3KYtZSHjRbTl49hbyg5WlUvBfP2Daq
         1FWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HNxSMbX9zbFq+nPsYw+YELdPEJLqDHw+pGKoc+akiA=;
        b=aRMfq5sDK5CQDRR38yJ4beHM/3QBEwKHlI5jhfPMZHPbyubgN4zMTBWTDooB989r6a
         Tf5L4JOrBvGFOlqxaKQ9qTyRxY8uNIvoVGO2USP5IaAYVHucZlktX7xN6/A9R4EkZnsL
         4nslqhs27SJICyYCKeZDlv1VlOG2YsSpqVAZ9CYbssa5ERTihW7JhuSGTIOZJ9vT2lnp
         9X875JzpL/wnHqgbOLU15nl+drHbxjZOxqHbdBO5yyHenc1CmcAWMS40rYdd6F0Hc/TG
         JwZwA8pJy1EbPbwXyfDaHf+/YMLM/WyzMuXvSwFr1MttPDOC10N7l5OWb6KPyhM2zRNs
         rWfw==
X-Gm-Message-State: AHQUAub8Ne7wD1LL2JJGmSmqNuM2vvEgU1U5gdKQatU5n1tD9T+9LT8L
        HkszYrfI9NINOKfgUtOy3Mp54tDC
X-Google-Smtp-Source: AHgI3IalQc+wQugRBsCKn/q2CL0wxU4HyZPe8LQeDmeZnCA0pR4ZFPNWh/Urcn7N/ls+oG7GR9kq1Q==
X-Received: by 2002:a1c:f518:: with SMTP id t24mr305572wmh.26.1549396343818;
        Tue, 05 Feb 2019 11:52:23 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j24sm24022240wrd.86.2019.02.05.11.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 11:52:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        William Hubbs <williamh@gentoo.org>, chutzpah@gentoo.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 0/2] New {author,committer}.{name,email} config
Date:   Tue,  5 Feb 2019 20:52:10 +0100
Message-Id: <20190205195212.25550-1-avarab@gmail.com>
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

I had some feedback on v2 that wasn't addressed. See
https://public-inbox.org/git/875zuc49uj.fsf@evledraar.gmail.com/ &
https://public-inbox.org/git/871s4w4khs.fsf@evledraar.gmail.com/

This fixes that, except I couldn't with limited time reproduce the bug
I was talking about in the latter E-Mail in the test suite, maybe we
only infer the E-Mail from the hostname outside of it? So 1/1 is the
patch I was going to fleshen out with that test, but didn't, but I
figured I'd leave it.

Other changes can be seen in the range-diff, briefly:

* We now update the git-commit-tree docs
* Bunch of coding style nits fixed (alignment, past 79 chars)
* Factored a bunch of copy/pasted code into a helper in ident.c
* Fixed a test to skip a whole GIT_*= && export && sane_unset dance,
  and just use test_env instead.
* Test style: ">f" not "> f" in redirection.

William Hubbs (1):
  config: allow giving separate author and committer idents

Ævar Arnfjörð Bjarmason (1):
  ident: test how GIT_* and user.{name,email} interact

 Documentation/config/user.txt     |  23 ++++---
 Documentation/git-commit-tree.txt |   3 +-
 blame.c                           |   3 +-
 builtin/am.c                      |   1 +
 builtin/commit.c                  |   3 +-
 cache.h                           |  13 +++-
 config.c                          |   4 +-
 ident.c                           | 101 +++++++++++++++++++++-------
 log-tree.c                        |   3 +-
 sequencer.c                       |   6 +-
 t/t7517-per-repo-email.sh         | 108 ++++++++++++++++++++++++++++++
 11 files changed, 223 insertions(+), 45 deletions(-)

Range-diff:
-:  ---------- > 1:  ffd41a882a ident: test how GIT_* and user.{name,email} interact
1:  1172f91155 ! 2:  788ec8412d config: allow giving separate author and committer idents
    @@ -21,6 +21,7 @@
         committer identification.
     
         Signed-off-by: William Hubbs <williamh@gentoo.org>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
      --- a/Documentation/config/user.txt
    @@ -54,6 +55,20 @@
      user.useConfigOnly::
      	Instruct Git to avoid trying to guess defaults for `user.email`
     
    + diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
    + --- a/Documentation/git-commit-tree.txt
    + +++ b/Documentation/git-commit-tree.txt
    +@@
    + (nb "<", ">" and "\n"s are stripped)
    + 
    + In case (some of) these environment variables are not set, the information
    +-is taken from the configuration items user.name and user.email, or, if not
    ++is taken from the configuration items user.name and user.email, or the more
    ++specific author.{name,email} and committer.{name,email} variables, or, if not
    + present, the environment variable EMAIL, or, if that is not set,
    + system user name and the hostname used for outgoing mail (taken
    + from `/etc/mailname` and falling back to the fully qualified hostname when
    +
      diff --git a/blame.c b/blame.c
      --- a/blame.c
      +++ b/blame.c
    @@ -75,7 +90,7 @@
      	}
      
      	author = fmt_ident(state->author_name, state->author_email,
    -+		WANT_AUTHOR_IDENT,
    ++			WANT_AUTHOR_IDENT,
      			state->ignore_date ? NULL : state->author_date,
      			IDENT_STRICT);
      
    @@ -89,7 +104,7 @@
      
     -	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
     +	strbuf_addstr(author_ident, fmt_ident(name, email, WANT_AUTHOR_IDENT, date,
    -+				IDENT_STRICT));
    ++					      IDENT_STRICT));
      	assert_split_ident(&author, author_ident);
      	export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
      	export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
    @@ -113,8 +128,8 @@
     -extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
     -extern const char *fmt_name(const char *name, const char *email);
     +extern const char *fmt_ident(const char *name, const char *email,
    -+		enum want_ident whose_ident,
    -+		const char *date_str, int);
    ++			     enum want_ident whose_ident,
    ++			     const char *date_str, int flag);
     +extern const char *fmt_name(enum want_ident);
      extern const char *ident_default_name(void);
      extern const char *ident_default_email(void);
    @@ -129,8 +144,8 @@
      
     -	if (starts_with(var, "user."))
     +	if (starts_with(var, "user.") ||
    -+		starts_with(var, "author.") ||
    -+			starts_with(var, "committer."))
    ++	    starts_with(var, "author.") ||
    ++	    starts_with(var, "committer."))
      		return git_ident_config(var, value, cb);
      
      	if (starts_with(var, "i18n."))
    @@ -154,7 +169,8 @@
      
      const char *fmt_ident(const char *name, const char *email,
     -		      const char *date_str, int flag)
    -+		      enum want_ident whose_ident, const char *date_str, int flag)
    ++		      enum want_ident whose_ident, const char *date_str,
    ++		      int flag)
      {
      	static struct strbuf ident = STRBUF_INIT;
      	int strict = (flag & IDENT_STRICT);
    @@ -232,68 +248,75 @@
      	return ident_is_sufficient(author_ident_explicitly_given);
      }
      
    --int git_ident_config(const char *var, const char *value, void *data)
    -+static int set_ident(const char *var, const char *value)
    - {
    --	if (!strcmp(var, "user.useconfigonly")) {
    --		ident_use_config_only = git_config_bool(var, value);
    -+	if (!strcmp(var, "author.name")) {
    -+		if (!value)
    -+			return config_error_nonbool(var);
    -+		strbuf_reset(&git_author_name);
    -+		strbuf_addstr(&git_author_name, value);
    -+		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
    -+		ident_config_given |= IDENT_NAME_GIVEN;
    -+		return 0;
    -+	}
    -+
    -+	if (!strcmp(var, "author.email")) {
    -+		if (!value)
    -+			return config_error_nonbool(var);
    -+		strbuf_reset(&git_author_email);
    -+		strbuf_addstr(&git_author_email, value);
    -+		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
    -+		ident_config_given |= IDENT_MAIL_GIVEN;
    -+		return 0;
    -+	}
    ++static int set_ident_internal(const char *var, const char *value,
    ++			    struct strbuf *sb, const int flag)
    ++{
    ++	if (!value)
    ++		return config_error_nonbool(var);
    ++	strbuf_reset(sb);
    ++	strbuf_addstr(sb, value);
    ++	author_ident_explicitly_given |= flag;
    ++	ident_config_given |= flag;
    ++	return 0;
    ++}
     +
    -+	if (!strcmp(var, "committer.name")) {
    -+		if (!value)
    -+			return config_error_nonbool(var);
    -+		strbuf_reset(&git_committer_name);
    -+		strbuf_addstr(&git_committer_name, value);
    -+		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
    -+		ident_config_given |= IDENT_NAME_GIVEN;
    -+		return 0;
    -+	}
    ++static int set_ident(const char *var, const char *value)
    ++{
    ++	if (!strcmp(var, "author.name"))
    ++		return set_ident_internal(var, value, &git_author_name,
    ++					  IDENT_NAME_GIVEN);
    ++	else if (!strcmp(var, "author.email"))
    ++		return set_ident_internal(var, value, &git_author_email,
    ++					  IDENT_MAIL_GIVEN);
    ++	else if (!strcmp(var, "committer.name"))
    ++		return set_ident_internal(var, value, &git_committer_name,
    ++					  IDENT_NAME_GIVEN);
    ++	else if (!strcmp(var, "committer.email"))
    ++		return set_ident_internal(var, value, &git_committer_email,
    ++					  IDENT_MAIL_GIVEN);
    ++	else if (!strcmp(var, "user.name"))
    ++		return set_ident_internal(var, value, &git_default_name,
    ++					  IDENT_NAME_GIVEN);
    ++	else if (!strcmp(var, "user.email"))
    ++		return set_ident_internal(var, value, &git_default_email,
    ++					  IDENT_MAIL_GIVEN);
    ++	return 0;
    ++}
     +
    -+	if (!strcmp(var, "committer.email")) {
    -+		if (!value)
    -+			return config_error_nonbool(var);
    -+		strbuf_reset(&git_committer_email);
    -+		strbuf_addstr(&git_committer_email, value);
    -+		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
    -+		ident_config_given |= IDENT_MAIL_GIVEN;
    + int git_ident_config(const char *var, const char *value, void *data)
    + {
    + 	if (!strcmp(var, "user.useconfigonly")) {
    +@@
      		return 0;
      	}
      
    -@@
    - 	return 0;
    +-	if (!strcmp(var, "user.name")) {
    +-		if (!value)
    +-			return config_error_nonbool(var);
    +-		strbuf_reset(&git_default_name);
    +-		strbuf_addstr(&git_default_name, value);
    +-		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
    +-		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
    +-		ident_config_given |= IDENT_NAME_GIVEN;
    +-		return 0;
    +-	}
    +-
    +-	if (!strcmp(var, "user.email")) {
    +-		if (!value)
    +-			return config_error_nonbool(var);
    +-		strbuf_reset(&git_default_email);
    +-		strbuf_addstr(&git_default_email, value);
    +-		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
    +-		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
    +-		ident_config_given |= IDENT_MAIL_GIVEN;
    +-		return 0;
    +-	}
    +-
    +-	return 0;
    ++	return set_ident(var, value);
      }
      
    -+int git_ident_config(const char *var, const char *value, void *data)
    -+{
    -+	if (!strcmp(var, "user.useconfigonly")) {
    -+		ident_use_config_only = git_config_bool(var, value);
    -+		return 0;
    -+	}
    -+
    -+	return set_ident(var, value);
    -+}
    -+
      static int buf_cmp(const char *a_begin, const char *a_end,
    - 		   const char *b_begin, const char *b_end)
    - {
     
      diff --git a/log-tree.c b/log-tree.c
      --- a/log-tree.c
    @@ -317,7 +340,8 @@
      
      	strbuf_reset(&out);
     -	strbuf_addstr(&out, fmt_ident(name, email, date, 0));
    -+	strbuf_addstr(&out, fmt_ident(name, email, WANT_AUTHOR_IDENT, date, 0));
    ++	strbuf_addstr(&out, fmt_ident(name, email, WANT_AUTHOR_IDENT, date,
    ++				      0));
      	strbuf_swap(buf, &out);
      	strbuf_release(&out);
      	free(name);
    @@ -339,15 +363,24 @@
      	test_must_fail git rebase -p master
      '
      
    +-test_expect_success 'fallbacks for GIT_* and user.{name,email}' '
    ++test_expect_success 'fallbacks for GIT_* and {user,author,committer}.{name,email}' '
    + 	# We must have committer in the object
    + 	test_must_fail test_env \
    + 		GIT_AUTHOR_NAME=author.name \
    +@@
    + 	test_cmp expected actual
    + '
    + 
     +test_expect_success 'author.name overrides user.name' '
     +	test_config user.name user &&
     +	test_config user.email user@example.com &&
     +	test_config author.name author &&
     +	test_commit author-name-override-user &&
    -+	echo author user@example.com > expected-author &&
    -+	echo user user@example.com > expected-committer &&
    -+	git log --format="%an %ae" -1 > actual-author &&
    -+	git log --format="%cn %ce" -1 > actual-committer &&
    ++	echo author user@example.com >expected-author &&
    ++	echo user user@example.com >expected-committer &&
    ++	git log --format="%an %ae" -1 >actual-author &&
    ++	git log --format="%cn %ce" -1 >actual-committer &&
     +	test_cmp expected-author actual-author &&
     +	test_cmp expected-committer actual-committer
     +'
    @@ -357,10 +390,10 @@
     +	test_config user.email user@example.com &&
     +	test_config author.email author@example.com &&
     +	test_commit author-email-override-user &&
    -+	echo user author@example.com > expected-author &&
    -+	echo user user@example.com > expected-committer &&
    -+	git log --format="%an %ae" -1 > actual-author &&
    -+	git log --format="%cn %ce" -1 > actual-committer &&
    ++	echo user author@example.com >expected-author &&
    ++	echo user user@example.com >expected-committer &&
    ++	git log --format="%an %ae" -1 >actual-author &&
    ++	git log --format="%cn %ce" -1 >actual-committer &&
     +	test_cmp expected-author actual-author &&
     +	test_cmp expected-committer actual-committer
     +'
    @@ -370,10 +403,10 @@
     +	test_config user.email user@example.com &&
     +	test_config committer.name committer &&
     +	test_commit committer-name-override-user &&
    -+	echo user user@example.com > expected-author &&
    -+	echo committer user@example.com > expected-committer &&
    -+	git log --format="%an %ae" -1 > actual-author &&
    -+	git log --format="%cn %ce" -1 > actual-committer &&
    ++	echo user user@example.com >expected-author &&
    ++	echo committer user@example.com >expected-committer &&
    ++	git log --format="%an %ae" -1 >actual-author &&
    ++	git log --format="%cn %ce" -1 >actual-committer &&
     +	test_cmp expected-author actual-author &&
     +	test_cmp expected-committer actual-committer
     +'
    @@ -383,10 +416,10 @@
     +	test_config user.email user@example.com &&
     +	test_config committer.email committer@example.com &&
     +	test_commit committer-email-override-user &&
    -+	echo user user@example.com > expected-author &&
    -+	echo user committer@example.com > expected-committer &&
    -+	git log --format="%an %ae" -1 > actual-author &&
    -+	git log --format="%cn %ce" -1 > actual-committer &&
    ++	echo user user@example.com >expected-author &&
    ++	echo user committer@example.com >expected-committer &&
    ++	git log --format="%an %ae" -1 >actual-author &&
    ++	git log --format="%cn %ce" -1 >actual-committer &&
     +	test_cmp expected-author actual-author &&
     +	test_cmp expected-committer actual-committer
     +'
    @@ -398,17 +431,17 @@
     +	test_config author.email author@example.com &&
     +	test_config committer.name committer &&
     +	test_config committer.email committer@example.com &&
    -+	GIT_AUTHOR_NAME=env_author && export GIT_AUTHOR_NAME &&
    -+	GIT_AUTHOR_EMAIL=env_author@example.com && export GIT_AUTHOR_EMAIL &&
    -+	GIT_COMMITTER_NAME=env_commit && export GIT_COMMITTER_NAME &&
    -+	GIT_COMMITTER_EMAIL=env_commit@example.com && export GIT_COMMITTER_EMAIL &&
    -+	test_commit env-override-conf &&
    -+	echo env_author env_author@example.com > expected-author &&
    -+	echo env_commit env_commit@example.com > expected-committer &&
    -+	git log --format="%an %ae" -1 > actual-author &&
    -+	git log --format="%cn %ce" -1 > actual-committer &&
    -+	sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
    -+	sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
    ++
    ++	test_env \
    ++		GIT_AUTHOR_NAME=env_author \
    ++		GIT_AUTHOR_EMAIL=env_author@example.com \
    ++		GIT_COMMITTER_NAME=env_commit \
    ++		GIT_COMMITTER_EMAIL=env_commit@example.com \
    ++		test_commit env-override-conf &&
    ++	echo env_author env_author@example.com >expected-author &&
    ++	echo env_commit env_commit@example.com >expected-committer &&
    ++	git log --format="%an %ae" -1 >actual-author &&
    ++	git log --format="%cn %ce" -1 >actual-committer &&
     +	test_cmp expected-author actual-author &&
     +	test_cmp expected-committer actual-committer
     +'
-- 
2.20.1.611.gfbb209baf1

