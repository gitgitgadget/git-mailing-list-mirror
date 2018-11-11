Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7F61F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 12:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeKKWWS (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 17:22:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43124 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeKKWWS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 17:22:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id e4so5170212edv.10
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 04:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=H+stZRxRwLyOLCwQf+DUSjo243Q8Am00B6lZFqZ4d54=;
        b=RlNb+e5R5Vtn4s7+f2lWQd+HrbSLm2VG+cuz66y44WDzPX7RrFuBs5BTvTty5RjbwF
         MGtkacNJzZinh+4ooKqXaCTvNwS9x/esDMy9g91NUUbPoefL3uPwxp8jVkrh/THC/daO
         BvtQKsoaDguXF9YTGxQwiR76Dc00k2odS8I/VrdOQYwbH76ckyc/DzPXXF6Bm+DDPS7s
         JlUuWfwCQ56BXEWi77yMte/WlOOrhPS9KCgbQgqGGZmkgt/gXZd7lUciG5zDdx/dTyxt
         RhQ2NAvSuX0yNPA9ISsOHGlytoWzNs1SX1IPH1VZB1/eCcwiHYw+UnpD4HoYGfmWjXuW
         SzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=H+stZRxRwLyOLCwQf+DUSjo243Q8Am00B6lZFqZ4d54=;
        b=h2uoFFOMoiw3a5zUlpyA9+yBQnim0JpkTHyDeBN3LJImKtUUuipOXpkxUx4R3BlQUf
         26eb9qfLqNn6KL1eDObxMKa9b3mXx4QuKfiAGBlqcYc7P4nqy38ig5WKxTM4Ud+6iBRm
         tTPoJenE/IKQQbH+CNPrww4C91NnyRfY3kmvF9lqaZTn7XSsbh9NRLTYatnTA8J4PdyL
         Ti+p9r1bHbrEy3rwaLgRtOpJFhL5/FlBGGKc51Z+7ZZFPkQ+QI/OHlXCoKiaD9OWRClh
         dAOJzfnRLmm9CdYiXYe4VlEe1RMydatB12iA0ajVjiAfHVi9C7A8Wc5/0HrnzCZn9L2+
         XT/g==
X-Gm-Message-State: AGRZ1gJ/1zaZqbV+qcb9R+2ovTXzp7vPRXf7dmabj3/d2FMqtfvDbsti
        culDRX2kNOE6b1eqMUGtjf8=
X-Google-Smtp-Source: AJdET5dhqiEUw3bTHDe5Rn6U4CwVL881/SbEao5sBeH6/r5vsrmUNgBeT7cfbIT22Um4igdea86iqw==
X-Received: by 2002:a50:adcf:: with SMTP id b15-v6mr8774548edd.215.1541939628430;
        Sun, 11 Nov 2018 04:33:48 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id r8-v6sm1879610ejb.52.2018.11.11.04.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 04:33:47 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <20181111095254.30473-1-pclouds@gmail.com> <875zxa6xzp.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181111095254.30473-1-pclouds@gmail.com>
Date:   Sun, 11 Nov 2018 13:33:44 +0100
Message-ID: <871s7r4wuv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[CC-ing some of the people involved in recent threads about this]

On Sun, Nov 11 2018, Nguyễn Thái Ngọc Duy wrote:

> Since this topic has come up twice recently, I revisited this
> "precious" thingy that I started four years ago and tried to see if I
> could finally finish it. There are a couple things to be sorted out...
>
> A new attribute "precious" is added to indicate that certain files
> have valuable content and should not be easily discarded even if they
> are ignored or untracked (*).
>
> So far there are two parts of Git that are made aware of precious
> files: "git clean" will leave precious files alone and unpack-trees.c
> (i.e. merges and branch switches) will not overwrite
> ignored-but-precious files.
>
> Is there any other parts of Git that should be made aware of this
> "precious" attribute?
>
> Also while "precious" is a fun name, but it does not sound serious.
> Any suggestions? Perhaps "valuable"?
>
> Very lightly tested. The patch is more to have something to discuss
> than is bug free and ready to use.
>
> (*) Note that tracked files could be marked "precious" in the future
>     too although the exact semantics is not very clear since tracked
>     files are by default precious.
>
>     But something like "index log" could use this to record all
>     changes to precious files instead of just "git add -p" changes,
>     for example. So these files are in a sense more precious than
>     other tracked files.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/git-clean.txt     |  3 ++-
>  Documentation/gitattributes.txt | 13 +++++++++++++
>  attr.c                          |  9 +++++++++
>  attr.h                          |  2 ++
>  builtin/clean.c                 | 19 ++++++++++++++++---
>  unpack-trees.c                  |  3 ++-
>  6 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index 03056dad0d..a9beadfb12 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -21,7 +21,8 @@ option is specified, ignored files are also removed. This can, for
>  example, be useful to remove all build products.
>
>  If any optional `<path>...` arguments are given, only those paths
> -are affected.
> +are affected. Ignored or untracked files with `precious` attributes
> +are not removed.
>
>  OPTIONS
>  -------
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index b8392fc330..c722479bdc 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -1188,6 +1188,19 @@ If this attribute is not set or has an invalid value, the value of the
>  (See linkgit:git-config[1]).
>
>
> +Precious files
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +`precious`
> +^^^^^^^^^^
> +
> +This attribute is set on files to indicate that their content is
> +valuable. Many commands will behave slightly different on precious
> +files. linkgit:git-clean[1] will leave precious files alone. Merging
> +and branch switching will not silently overwrite ignored files that
> +are marked "precious".
> +
> +
>  USING MACRO ATTRIBUTES
>  ----------------------
>
> diff --git a/attr.c b/attr.c
> index 60d284796d..d06ca0ae4b 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -1186,3 +1186,12 @@ void attr_start(void)
>  	pthread_mutex_init(&check_vector.mutex, NULL);
>  #endif
>  }
> +
> +int is_precious_file(struct index_state *istate, const char *path)
> +{
> +	static struct attr_check *check;
> +	if (!check)
> +		check = attr_check_initl("precious", NULL);
> +	git_check_attr(istate, path, check);
> +	return check && ATTR_TRUE(check->items[0].value);
> +}

If we merge two branches is this using the merged post-image of
.gitattributes as a source?

>  	if (o->dir &&
> -	    is_excluded(o->dir, o->src_index, name, &dtype))
> +	    is_excluded(o->dir, o->src_index, name, &dtype) &&
> +	    !is_precious_file(o->src_index, name))
>  		/*
>  		 * ce->name is explicitly excluded, so it is Ok to
>  		 * overwrite it.

I wonder if instead we should just be reverting c81935348b ("Fix
switching to a branch with D/F when current branch has file D.",
2007-03-15), which these days (haven't dug deeply) would just be this,
right?:

>    diff --git a/unpack-trees.c b/unpack-trees.c
    index 7570df481b..b3efaddd4f 100644
    --- a/unpack-trees.c
    +++ b/unpack-trees.c
    @@ -1894,13 +1894,6 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
     	if (ignore_case && icase_exists(o, name, len, st))
     		return 0;

    -	if (o->dir &&
    -	    is_excluded(o->dir, o->src_index, name, &dtype))
    -		/*
    -		 * ce->name is explicitly excluded, so it is Ok to
    -		 * overwrite it.
    -		 */
    -		return 0;
     	if (S_ISDIR(st->st_mode)) {
     		/*
     		 * We are checking out path "foo" and

Something like the approach you're taking will absolutely work from a
technical standpoint, but I fear that it's going to be useless in
practice.

The users who need protection against git deleting their files the most
are exactly the sort of users who aren't expert-level enough to
understand the nuances of how the semantics of .gitignore and "precious"
are going to interact before git eats their data.

This is pretty apparent from the bug reports we're getting about
this. None of them are:

    "Hey, I 100% understood .gitignore semantics including this one part
    of the docs where you say you'll do this, but just forgot one day
    and deleted my work. Can we get some more safety?"

But rather (with some hyperbole for effect):

    "ZOMG git deleted my file! Is this a bug??"

So I think we should have the inverse of this "precious"
attribute". Just a change to the docs to say that .gitignore doesn't
imply these eager deletion semantics on tree unpacking anymore, and if
users want it back they can define a "garbage" attribute
(s/precious/garbage/).

That will lose no data, and in the very rare cases where a checkout of
tracked files would overwrite an ignored pattern, we can just error out
(as we do with the "Ok to overwrite" branch removed) and tell the user
to delete the files to proceed.

Three tests in our test suite fail with that patch applied, and they're
explicitly testing for exactly the sort of scenario where users are likely to lose data. I.e.:

 1. Open a tracked file in an editor
 2. Save it
 3. Switch to a topic branch, that has different .gitignore semantics
    (e.g. let's say a build/ dir exists there)
 4. Have their work deleted

So actually in writing this out I've become convinced that this
"precious" approach can't work either, because *even if* you're an
expert who manages to perfectly define their .gitignore and "precious"
rules in advance to avoid data deletion, those rules will *also* need to
take into account switching between branches (or even different
histories) where you have other sorts of rules.

So really, if there's ambiguity let's just not delete stuff by default
and ask the user to resolve it.
