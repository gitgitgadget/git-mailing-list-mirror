Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 751991F6A9
	for <e@80x24.org>; Wed,  2 Jan 2019 22:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfABW5s (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 17:57:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39439 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfABW5s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 17:57:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id f81so28812947wmd.4
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 14:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9z4UO0Mg0Jl/7LJDk2qik6mdF4JHpK6Nlyz7peLktzo=;
        b=uIwwBYVFc76s//62fyRMlgMBWadCsFnHQdqwogfxiiPeLbfe3tChC4+cayggmI0DN3
         h6EFxwPkUKSkqmcqpS7Y/QoP6IkyjdZQwkmola5+EaO8A+JSAqZNclkAz4QVw2CMiMsp
         xTfR9r/GIk2LzLFleOBNFi8MXjEbkRf0AnutT2BAqnuUV498X4Z+Pn8yBvR0F6bHIiod
         5UtsY0b+lSi4ehAWlaD2+gO6c+bIoyz5RQpjQY/9jr/uhNQykMo0yRoevfp5Ltc93Zq5
         F33Ov+vqh/XUnxspvvR9OXB7GRH3DAAmQ+Cm8rxMZG5dDhs4CitqtCNLoaLFcIw6OBTu
         mvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9z4UO0Mg0Jl/7LJDk2qik6mdF4JHpK6Nlyz7peLktzo=;
        b=fpR281mmBMS5Dc1a2uvFv7hgPe865tAv7IvZpw3I0wRoE4tdX3GULxaS8K9PwzvmGL
         8gq6mw7brxXhEOFGjG5G1pgeGRgpO1YcsnRkaMuDbO5mxyROh3EqmqPPpG/1Eq5SNpiU
         KiZmdX6j0qMop559yPXbDud7LGYRh5tEzlRZIlOvEYp85yn4+xJtO3otW1akMuFL8WKN
         UPpb+iSvVY6WzsLbdwh9IFTdhNFKmRY8NXi0IjQbtRfjcrpiakvEvIpDxNF/70I0EGQT
         EMNXTIZNJqRJeIDR2rrey27sX5pZrgFt9kr6ezsOZoAAI2bmcvR/1WBI7rYcF4cCnUmt
         8Z4g==
X-Gm-Message-State: AJcUukeeppiTjV+ziczcSxHGkn1axEKK8WI099N0Ilj8G3y/SdTqU5yq
        bJ+1aIYPP8BZyg7Rksu6TrM=
X-Google-Smtp-Source: ALg8bN5yl89/QvR7lR8cdzk+1qTocdRXnYf2Vsj7FhrpJ4YNvdcTVCHlvF3+7GnahBEXHLnKD/uXig==
X-Received: by 2002:a1c:cbcb:: with SMTP id b194mr33422299wmg.64.1546469865034;
        Wed, 02 Jan 2019 14:57:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q3sm47521303wrn.84.2019.01.02.14.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 14:57:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Hubbs <williamh@gentoo.org>
Cc:     git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH 1/1]     Add author and committer configuration settings
References: <20181219183939.16358-1-williamh@gentoo.org>
        <20181219183939.16358-2-williamh@gentoo.org>
Date:   Wed, 02 Jan 2019 14:57:42 -0800
In-Reply-To: <20181219183939.16358-2-williamh@gentoo.org> (William Hubbs's
        message of "Wed, 19 Dec 2018 12:39:39 -0600")
Message-ID: <xmqq1s5uk6qh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Hubbs <williamh@gentoo.org> writes:

> Subject: Re: [PATCH 1/1]     Add author and committer configuration settings

Perhaps something like this

	Subject: config: allow giving separate author and committer idents

would fit better in "git shortlog --no-merges" output.

>     The author.email, author.name, committer.email and committer.name
>     settings are analogous to the GIT_AUTHOR_* and GIT_COMMITTER_*
>     environment variables, but for the git config system. This allows them
>     to be set separately for each repository.

Don't indent the whole proposed log message.

> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> index b5b2ba1199..6ba7002252 100644
> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -1,3 +1,23 @@
> +author.email::
> +Your email address to be recorded on the author line of any newly
> +created commits.
> +If this is not set, we use user.email.

"author line" is a bit too technical and appropriate only to those
who are familiar with "git cat-file commit" output.  How about
phrasing it a bit differently, like

	author.email::
		The email-address used for the author of newly
		created commits.  Defaults to the value of the
		`GIT_AUTHOR_EMAIL` environment variable, or if it is
		not set, the `user.email` configuration variable.

Likewise for the other three variables.

>  user.email::
>  	Your email address to be recorded in any newly created commits.
>  	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, and

As you can see, the enumeration list in this file is formatted by
indenting the definition body.  

> diff --git a/builtin/commit.c b/builtin/commit.c
> index c021b119bb..49a97adeb8 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -607,7 +607,7 @@ static void determine_author_info(struct strbuf *author_ident)
>  		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
>  	}
>  
> -	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
> +	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT|IDENT_AUTHOR));

That's now a bit overly long line.

>  	assert_split_ident(&author, author_ident);
>  	export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
>  	export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
> diff --git a/cache.h b/cache.h
> index ca36b44ee0..0ee87f22a9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1479,10 +1479,13 @@ int date_overflows(timestamp_t date);
>  #define IDENT_STRICT	       1
>  #define IDENT_NO_DATE	       2
>  #define IDENT_NO_NAME	       4
> +#define IDENT_AUTHOR          8
> +#define IDENT_COMMITTER       16

>  extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);

It is wrong to pass "do we want the author, or the committer, name?"
information in the same flag parameter to fmt_ident(), and it is
wrong to introduce IDENT_AUTHOR/COMMITTER bits as if they belong to
the existing four.  For one thing, unlike these other bits, these
two are not independent bits.  It would be an error for a caller to
pass neither bits, or both bits at the same time.

One way to do it better may be to pass it as another parameter, e.g.

	enum want_ident {
		WANT_AUTHOR_IDENT,
		WANT_COMMITTER_IDENT
	};
	const char *fmt_ident(const char *name, const char *email,
				enum want_ident whose_ident,
				const char *date_str, int flags);

In the remainder of the review, I'd give update suggestions based on
this function signature.

> diff --git a/ident.c b/ident.c
> index 33bcf40644..3da96ebbef 100644
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
> @@ -361,7 +365,15 @@ const char *fmt_ident(const char *name, const char *email,
>  	int strict = (flag & IDENT_STRICT);
>  	int want_date = !(flag & IDENT_NO_DATE);
>  	int want_name = !(flag & IDENT_NO_NAME);
> +	int want_author = (flag & IDENT_AUTHOR);
> +	int want_committer = (flag & IDENT_COMMITTER);
>  
> +	if (!email) {
> +		if (want_author && git_author_email.len)
> +			email = git_author_email.buf;
> +		else if (want_committer && git_committer_email.len)
> +			email = git_committer_email.buf;
> +	}
>  	if (!email) {
>  		if (strict && ident_use_config_only
>  		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
> @@ -377,6 +389,12 @@ const char *fmt_ident(const char *name, const char *email,
>  
>  	if (want_name) {
>  		int using_default = 0;
> +		if (!name) {
> +			if (want_author && git_author_name.len)
> +				name = git_author_name.buf;
> +			else if (want_committer && git_committer_name.len)
> +				name = git_committer_name.buf;
> +		}
>  		if (!name) {
>  			if (strict && ident_use_config_only
>  			    && !(ident_config_given & IDENT_NAME_GIVEN)) {

The reviewer's interest here is to see how "author.name trumps
user.name" precedence is implemented; by mucking with "name" before
the code that deals with the ident_default_name(), which yields
git_default_name taken from user.name, the code gives precedence to
these newly introduced variables.

Which makes sense.

> @@ -425,9 +443,11 @@ const char *fmt_ident(const char *name, const char *email,
>  	return ident.buf;
>  }
>  
> -const char *fmt_name(const char *name, const char *email)
> +const char *fmt_committer_name(void)
>  {
> -	return fmt_ident(name, email, NULL, IDENT_STRICT | IDENT_NO_DATE);
> +	char *name = getenv("GIT_COMMITTER_NAME");
> +	char *email = getenv("GIT_COMMITTER_EMAIL");
> +	return fmt_ident(name, email, NULL, IDENT_STRICT | IDENT_NO_DATE|IDENT_COMMITTER);
>  }

OK, we are lucky that no existing caller use fmt_name() with author
information, I guess?  The resulting codebase does invite a question
"why don't we have fmt_author_name() at all?", which is somewhat
disturbing.

As we are going to change this function *and* all of its callers
anyway, perhaps we can generalize it with minimum effort, like so:

	const char *fmt_name(enum want_ident whose_ident)
	{
		switch (whose_ident) {
		case WANT_AUTHOR_IDENT:
			name = getenv("GIT_AUTHOR_NAME");
			email = getenv("GIT_COMMITTER_NAME");
			break;
		case WANT_COMMITTER_IDENT:
			...
		}
		return fmt_ident(name, email, whose_ident,
				  NULL, IDENT_STRICT | IDENT_NO_DATE);
	}

Thanks.
