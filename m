Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_BLACK,URIBL_DBL_SPAM shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E17611F453
	for <e@80x24.org>; Fri, 25 Jan 2019 22:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfAYW6Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 17:58:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35036 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYW6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 17:58:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so8631908edx.2
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 14:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=wDEsQxjBLHYRR4rCdSbGpU75ph/w+vcz89S+1inTItg=;
        b=ThaJEbCCJTPCq4lW+QP0FvFF4x7Qd9/y9gZ5K8GMaVj6N5mTeTpRt4jn5Dxsl3cy1O
         7dwlaMV65TePIQGPCZw6Lx9kK6Qxxd2gXbsqHkb/pGKOZ2T+lHlx2rPZUaNe4OemGrwN
         XmvYfTmBVjsWArDbCFShitMDD5wwCrUPHuL23OH+sLh6jp35TwMvTKueUuPGaKyAtD/S
         mkEjnl87lCxb0D2h8V3M1WyjBrDo7VPTDhSbYl8h7FKYcbznjne0Dv37fqV10DadqgMp
         rGcdKeHZkWPI+kzCYHBOX9mZ96dWuDCDVpp0MtZ3tFMbaTjNA8x+aqJYaxNGWJ6LOdgI
         bHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=wDEsQxjBLHYRR4rCdSbGpU75ph/w+vcz89S+1inTItg=;
        b=Une4KVtS744UhuqxDm7nBL2khrdPVeA7qIuiPaj8ShBlF+Y17tiailAcIIes2UGAdZ
         uTnZVek6sQTnsfF9Ju2M328ctif/9vHTkMDB2GI/8DE5m4WWkXWB8UJLHJjcEY9jSzs9
         gMVmZFaZQWeNcSiKQzm0P6EKRyl82FEb/8XDzjX4OQrixoNzmCd4cmpFn7Z0xs1lMZmP
         bS/Nlwh9M0OrS9tEkTuwgNC2Daa/JkylTPLThIRII7gH3N5KMBqwZeQXgBAkyi62DU1s
         gsMdpCq1Qra64SAKEX/35/NxsWiW9QBx5nfl9ntQfgDkDUjQWWF9C23w0gPtWs8p8umg
         w8Jw==
X-Gm-Message-State: AJcUukeIumSnrX2Rsn0S5wxQ82kNuwdeFnjAQGC9D2gv44jWcuVAhstF
        iaK3uKzKqYWzKAl4/xtYymiTDxE8
X-Google-Smtp-Source: ALg8bN7idX17EiVPFAFnFTJG5DoPRgBRAAVu8HQhigSLnJs2tn1Fkh0NzARLxQxpyZJJk3GXY8rdkQ==
X-Received: by 2002:a50:f489:: with SMTP id s9mr12316616edm.101.1548457093147;
        Fri, 25 Jan 2019 14:58:13 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id p16-v6sm6624950eju.73.2019.01.25.14.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 14:58:11 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     William Hubbs <williamh@gentoo.org>
Cc:     git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH v2 1/2] config: allow giving separate author and committer idents
References: <20190125215955.30032-1-williamh@gentoo.org> <20190125215955.30032-2-williamh@gentoo.org>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190125215955.30032-2-williamh@gentoo.org>
Date:   Fri, 25 Jan 2019 23:58:10 +0100
Message-ID: <877ees4a65.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 25 2019, William Hubbs wrote:

> The author.email, author.name, committer.email and committer.name
> settings are analogous to the GIT_AUTHOR_* and GIT_COMMITTER_*
> environment variables, but for the git config system. This allows them
> to be set separately for each repository.
>
> Git supports setting different authorship and committer
> information with environment variables. However, environment variables
> are set in the shell, so if different authorship and committer
> information is needed for different repositories an external tool is
> required.
>
> This adds support to git config for author.email, author.name,
> committer.email and committer.name  settings so this information
> can be set per repository.
>
> Also, it generalizes the fmt_ident function so it can handle author vs
> committer identification.

I have not tested this in any detail...

> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> index b5b2ba1199..18e1ec3c1b 100644
> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -1,12 +1,39 @@
> +author.email::
> +	The email address used for the author of newly
> +	created commits.  Defaults to the value of the
> +	`GIT_AUTHOR_EMAIL` environment variable, or if
> +	the environment variable is not set, the `user.email`
> +	configuration variable.
> +
> +author.name::
> +	The full name used for the author of newly created commits.
> +	Defaults to the value of the `GIT_AUTHOR_NAME` environment variable, or
> +	if the environment variable is not set,
> +	the `user.email` configuration variable.
> +
> +committer.email::
> +	The email address used for the committer of newly created commits.
> +	Defaults to the value of the `GIT_COMMITTER_EMAIL` environment
> +	variable, or if the environment variable is not set, the `user.email`
> +	configuration variable.
> +
> +committer.name::
> +	The full name used for the committer of newly created commits.
> +	Defaults to the value of the `GIT_COMMITTER_NAME` environment
> +	variable, or if the environment variable is not set, the `user.name`
> +	configuration variable.
> +
>  user.email::
>  	Your email address to be recorded in any newly created commits.
>  	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, and
> -	`EMAIL` environment variables.  See linkgit:git-commit-tree[1].
> +	`EMAIL` environment variables or the `author.email` or
> +	`committer.email` settings discussed above. See linkgit:git-commit-tree[1].
>
>  user.name::
>  	Your full name to be recorded in any newly created commits.
>  	Can be overridden by the `GIT_AUTHOR_NAME` and `GIT_COMMITTER_NAME`
> -	environment variables.  See linkgit:git-commit-tree[1].
> +	environment variables or the `author.name` or `committer.name`
> +	settings discussed above. See linkgit:git-commit-tree[1].

Looks correct, although I wonder if we're at the point where it would be
better to present this info as a table.

> diff --git a/builtin/am.c b/builtin/am.c
> index 95370313b6..53fdd22c45 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1594,7 +1594,7 @@ static void do_commit(const struct am_state *state)
>  	}
>
>  	author = fmt_ident(state->author_name, state->author_email,
> -			state->ignore_date ? NULL : state->author_date,
> +			WANT_AUTHOR_IDENT, state->ignore_date ? NULL : state->author_date,

This & a few other things in this series take the code beyond 79
characters.

>  			IDENT_STRICT);
>
>  	if (state->committer_date_is_author_date)
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 004b816635..f96b90daeb 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -607,7 +607,8 @@ static void determine_author_info(struct strbuf *author_ident)
>  		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
>  	}
>
> -	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
> +	strbuf_addstr(author_ident, fmt_ident(name, email, WANT_AUTHOR_IDENT, date,
> +				IDENT_STRICT));
>  	assert_split_ident(&author, author_ident);
>  	export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
>  	export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
> diff --git a/cache.h b/cache.h
> index 49713cc5a5..f13c6e244f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1479,10 +1479,19 @@ int date_overflows(timestamp_t date);
>  #define IDENT_STRICT	       1
>  #define IDENT_NO_DATE	       2
>  #define IDENT_NO_NAME	       4
> +
> +enum want_ident {
> +	WANT_BLANK_IDENT,
> +	WANT_AUTHOR_IDENT,
> +	WANT_COMMITTER_IDENT,
> +};
> +
>  extern const char *git_author_info(int);
>  extern const char *git_committer_info(int);
> -extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
> -extern const char *fmt_name(const char *name, const char *email);
> +extern const char *fmt_ident(const char *name, const char *email,
> +		enum want_ident whose_ident,
> +		const char *date_str, int);
> +extern const char *fmt_name(enum want_ident);
>  extern const char *ident_default_name(void);
>  extern const char *ident_default_email(void);
>  extern const char *git_editor(void);
> diff --git a/config.c b/config.c
> index ff521eb27a..4bd5920dea 100644
> --- a/config.c
> +++ b/config.c
> @@ -1484,6 +1484,12 @@ int git_default_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>
> +	if (starts_with(var, "author."))
> +		return git_ident_config(var, value, cb);
> +
> +	if (starts_with(var, "committer."))
> +		return git_ident_config(var, value, cb);
> +
>  	/* Add other config variables here and to Documentation/config.txt. */
>  	return 0;
>  }
> diff --git a/ident.c b/ident.c
> index 33bcf40644..a1e774c3e5 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -11,6 +11,10 @@
>  static struct strbuf git_default_name = STRBUF_INIT;
>  static struct strbuf git_default_email = STRBUF_INIT;
>  static struct strbuf git_default_date = STRBUF_INIT;
> +static struct strbuf git_author_name = STRBUF_INIT;
> +static struct strbuf git_author_email = STRBUF_INIT;
> +static struct strbuf git_committer_name = STRBUF_INIT;
> +static struct strbuf git_committer_email = STRBUF_INIT;
>  static int default_email_is_bogus;
>  static int default_name_is_bogus;
>
> @@ -355,13 +359,19 @@ N_("\n"
>     "\n");
>
>  const char *fmt_ident(const char *name, const char *email,
> -		      const char *date_str, int flag)
> +		      enum want_ident whose_ident, const char *date_str, int flag)
>  {
>  	static struct strbuf ident = STRBUF_INIT;
>  	int strict = (flag & IDENT_STRICT);
>  	int want_date = !(flag & IDENT_NO_DATE);
>  	int want_name = !(flag & IDENT_NO_NAME);
>
> +	if (!email) {
> +		if (whose_ident == WANT_AUTHOR_IDENT && git_author_email.len)
> +			email = git_author_email.buf;
> +		else if (whose_ident == WANT_COMMITTER_IDENT && git_committer_email.len)
> +			email = git_committer_email.buf;
> +	}
>  	if (!email) {
>  		if (strict && ident_use_config_only
>  		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
> @@ -377,6 +387,13 @@ const char *fmt_ident(const char *name, const char *email,
>
>  	if (want_name) {
>  		int using_default = 0;
> +		if (!name) {
> +			if (whose_ident == WANT_AUTHOR_IDENT && git_author_name.len)
> +				name = git_author_name.buf;
> +			else if (whose_ident == WANT_COMMITTER_IDENT &&
> +					git_committer_name.len)
> +				name = git_committer_name.buf;
> +		}
>  		if (!name) {
>  			if (strict && ident_use_config_only
>  			    && !(ident_config_given & IDENT_NAME_GIVEN)) {
> @@ -425,9 +442,25 @@ const char *fmt_ident(const char *name, const char *email,
>  	return ident.buf;
>  }
>
> -const char *fmt_name(const char *name, const char *email)
> +const char *fmt_name(enum want_ident whose_ident)
>  {
> -	return fmt_ident(name, email, NULL, IDENT_STRICT | IDENT_NO_DATE);
> +	char *name = NULL;
> +	char *email = NULL;
> +
> +	switch (whose_ident) {
> +	case WANT_BLANK_IDENT:
> +		break;
> +	case WANT_AUTHOR_IDENT:
> +		name = getenv("GIT_AUTHOR_NAME");
> +		email = getenv("GIT_AUTHOR_EMAIL");
> +		break;
> +	case WANT_COMMITTER_IDENT:
> +		name = getenv("GIT_COMMITTER_NAME");
> +		email = getenv("GIT_COMMITTER_EMAIL");
> +		break;
> +	}
> +	return fmt_ident(name, email, whose_ident, NULL,
> +			IDENT_STRICT | IDENT_NO_DATE);
>  }
>
>  const char *git_author_info(int flag)
> @@ -438,6 +471,7 @@ const char *git_author_info(int flag)
>  		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
>  	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
>  			 getenv("GIT_AUTHOR_EMAIL"),
> +			 WANT_AUTHOR_IDENT,
>  			 getenv("GIT_AUTHOR_DATE"),
>  			 flag);
>  }
> @@ -450,6 +484,7 @@ const char *git_committer_info(int flag)
>  		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
>  	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
>  			 getenv("GIT_COMMITTER_EMAIL"),
> +			 WANT_COMMITTER_IDENT,
>  			 getenv("GIT_COMMITTER_DATE"),
>  			 flag);
>  }
> @@ -480,6 +515,46 @@ int git_ident_config(const char *var, const char *value, void *data)
>  		return 0;
>  	}
>
> +	if (!strcmp(var, "author.name")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		strbuf_reset(&git_author_name);
> +		strbuf_addstr(&git_author_name, value);
> +		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
> +		ident_config_given |= IDENT_NAME_GIVEN;
> +		return 0;
> +	}
> +
> +	if (!strcmp(var, "author.email")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		strbuf_reset(&git_author_email);
> +		strbuf_addstr(&git_author_email, value);
> +		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> +		ident_config_given |= IDENT_MAIL_GIVEN;
> +		return 0;
> +	}
> +
> +	if (!strcmp(var, "committer.name")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		strbuf_reset(&git_committer_name);
> +		strbuf_addstr(&git_committer_name, value);
> +		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
> +		ident_config_given |= IDENT_NAME_GIVEN;
> +		return 0;
> +	}
> +
> +	if (!strcmp(var, "committer.email")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		strbuf_reset(&git_committer_email);
> +		strbuf_addstr(&git_committer_email, value);
> +		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> +		ident_config_given |= IDENT_MAIL_GIVEN;
> +		return 0;
> +	}
> +

This whole thing should be split into a static function. It's the same
code copy/pasted 4x times just with a differnet value for "var", the
strbuf variable & IDENT_*_GIVEN.

