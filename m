Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_DBL_SPAM shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC42D1F454
	for <e@80x24.org>; Sun,  3 Nov 2019 11:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfKCLN6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 06:13:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44786 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfKCLN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 06:13:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id g3so8429328ljl.11
        for <git@vger.kernel.org>; Sun, 03 Nov 2019 03:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=LCfj3gGd9dhSMvXtqDCfh0obGhPjpKKbHPKuwyOFUFo=;
        b=M/9Q8wNhiQzXKi+Jqr4YuVUWydgJBfwAmr8dCrIQB6KKWofRWYfqeUPbFA2AeQVVgh
         Smuolhl2wVKyLXOilPlJyhYR8FP7IlRGyIR332SjSRZEjNFaMB4XFlXshSOd2BPVGhlx
         SANnaX/abCEunowFd8qRuXngTyd8aWc0464O+W104BWYul7oNguio2FE8BteY+z1JRj3
         kboUCEbOQ7TnADpcFhsW4vf8JKhM9lIUTuEhjxn/FPMA5gg2tBr9vdT6vThLTpQssXBf
         xIWv7zHEOxiDuI1vC9mbkcpRPas0w2fqInLvinL46qlIxkU3VWma71/Uh4jJe3Ng/J2d
         e/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=LCfj3gGd9dhSMvXtqDCfh0obGhPjpKKbHPKuwyOFUFo=;
        b=oB1LgeahwSK61jZeKyaPv1X+ShnJKiJHUKj4ZG8BsuscPkhPzv2rKMugkkL89rasl8
         Ja5/12VsXIR0w8IGUUx0fErmqyKa7uGsBCOe0LbAxxfYiIhabqsvnumUSSHPbdFDSWJX
         E3vKsQwszqvYcSDOtzqB3nRQbk89izssUl8tur92PSyP1uRkwwfmFHuY5Z/KBgBxY+Qf
         e+3YqHmIM+POr2d67osONpRQVVFGfM0nqhf9AmbTPWLGnKg2aAsGa0GQxphFRq1GLjOo
         HB15/ClxcF/maPZlTF0nc6ceAi/TUS2D3T2J47PP6xwD8bv9G6Qv2361+2GkqzQavEfh
         t8ag==
X-Gm-Message-State: APjAAAVd5mTEhhLdRDjFKUtKxHUKlyn0SUddpgP2gKG0nN9x84glUViK
        PVDsCnHOgLrkiuxaFfIDdjo=
X-Google-Smtp-Source: APXvYqxHJ03oRB/bzM9toKUwJGP9JZtA+YkPstutFf+DdBgJDLJtzkW+FvoRCdKkY2UB2PCmAMpBcQ==
X-Received: by 2002:a2e:96c1:: with SMTP id d1mr15691110ljj.87.1572779634851;
        Sun, 03 Nov 2019 03:13:54 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id i17sm5409809ljd.2.2019.11.03.03.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Nov 2019 03:13:53 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/4] doc: move author and committer information to git-commit(1)
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
        <20191102192615.10013-2-sandals@crustytoothpaste.net>
Date:   Sun, 03 Nov 2019 12:13:51 +0100
In-Reply-To: <20191102192615.10013-2-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 2 Nov 2019 19:26:12 +0000")
Message-ID: <86y2wx5i1c.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> While at one time it made perfect sense to store information about
> configuring author and committer information in the documentation for
> git commit-tree, in modern Git that operation is seldom used.  Most
> users will use git commit and expect to find comprehensive documentation
> about its use in the manual page for that command.
>
> Considering that there is significant confusion about how one is to use
> the user.name and user.email variables, let's put as much documentation
> as possible into an obvious place where users will be more likely to
> find it.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/config/user.txt     |  2 +-
>  Documentation/git-commit-tree.txt | 39 ++++---------------------------
>  Documentation/git-commit.txt      | 34 ++++++++++++++++++++++++---
>  3 files changed, 37 insertions(+), 38 deletions(-)
>
> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> index 0557cbbceb..a1f80e823c 100644
> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -13,7 +13,7 @@ committer.email::
>  	Also, all of these can be overridden by the `GIT_AUTHOR_NAME`,
>  	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`,
>  	`GIT_COMMITTER_EMAIL` and `EMAIL` environment variables.
> -	See linkgit:git-commit-tree[1] for more information.
> +	See linkgit:git-commit[1] for more information.

O.K., lets refer users to the command they actually use.

>  user.useConfigOnly::
>  	Instruct Git to avoid trying to guess defaults for `user.email`
> diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit=
-tree.txt
> index 4b90b9c12a..d518dffce0 100644
> --- a/Documentation/git-commit-tree.txt
> +++ b/Documentation/git-commit-tree.txt
> @@ -42,6 +42,10 @@ tend to just write the result to the file that is poin=
ted at by
>  `.git/HEAD`, so that we can always see what the last committed
>  state was.
>=20=20
> +A commit comment is read from stdin. If a changelog
> +entry is not provided via "<" redirection, 'git commit-tree' will just w=
ait
> +for one to be entered and terminated with ^D.
> +

I understand this is what is extracted from the removed part (moved to
git-commit documentation).  But I think it is not enough to understand
how to actually use this command; this change makes reference
documentation not self contained.

>  OPTIONS
>  -------
>  <tree>::
> @@ -69,40 +73,6 @@ OPTIONS
>  	Do not GPG-sign commit, to countermand a `--gpg-sign` option
>  	given earlier on the command line.
>=20=20
> -
> -Commit Information
> -------------------
> -
> -A commit encapsulates:
> -
> -- all parent object ids
> -- author name, email and date
> -- committer name and email and the commit time.

O.K., I can understand moving this information to a better place
(nb. what about gitglossry?).

> -
> -While parent object ids are provided on the command line, author and
> -committer information is taken from the following environment variables,
> -if set:
> -
> -	GIT_AUTHOR_NAME
> -	GIT_AUTHOR_EMAIL
> -	GIT_AUTHOR_DATE
> -	GIT_COMMITTER_NAME
> -	GIT_COMMITTER_EMAIL
> -	GIT_COMMITTER_DATE
> -
> -(nb "<", ">" and "\n"s are stripped)
> -
> -In case (some of) these environment variables are not set, the informati=
on
> -is taken from the configuration items user.name and user.email, or, if n=
ot
> -present, the environment variable EMAIL, or, if that is not set,
> -system user name and the hostname used for outgoing mail (taken
> -from `/etc/mailname` and falling back to the fully qualified hostname wh=
en
> -that file does not exist).

I'm not sure if this should not be left here, perhaps extracted into
separate fragment file to be included in both git-commit-tree.txt and in
git-commit.txt

I see that we are missing the ebvious information that if GIT_*_DATE
environment variables are not set, Git will use current date and time.
Is there a place where we say what format GIT_*_DATE needs to be in?

> -
> -A commit comment is read from stdin. If a changelog
> -entry is not provided via "<" redirection, 'git commit-tree' will just w=
ait
> -for one to be entered and terminated with ^D.
> -
>  include::date-formats.txt[]
>=20=20
>  Discussion
> @@ -117,6 +87,7 @@ FILES
>  SEE ALSO
>  --------
>  linkgit:git-write-tree[1]
> +linkgit:git-commit[1]

All right.

>=20=20
>  GIT
>  ---
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index afa7b75a23..f684f7fdc2 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -352,9 +352,6 @@ changes to tracked files.
>  	these files are also staged for the next commit on top
>  	of what have been staged before.
>=20=20
> -:git-commit: 1
> -include::date-formats.txt[]
> -

All right, it is moved down, not removed.

>  EXAMPLES
>  --------
>  When recording your own work, the contents of modified files in
> @@ -448,6 +445,37 @@ alter the order the changes are committed, because t=
he merge
>  should be recorded as a single commit.  In fact, the command
>  refuses to run when given pathnames (but see `-i` option).
>=20=20
> +COMMIT INFORMATION
> +------------------
> +
> +A commit encapsulates:
> +
> +- all parent object ids
> +- author name, email and date
> +- committer name and email and the commit time.
> +
> +While parent object ids are provided on the command line,
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This was true for `git commit-tree`, with the following synopsis

  git commit-tree <tree> [(-p <parent>)=E2=80=A6=E2=80=8B]
  git commit-tree [(-p <parent>)=E2=80=A6=E2=80=8B] [-S[<keyid>]] [(-m <mes=
sage>)=E2=80=A6=E2=80=8B]
  		  [(-F <file>)=E2=80=A6=E2=80=8B] <tree>

This is decidely *NOT true* for `git commit`:

  git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
  	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
  	   [--allow-empty-message] [--no-verify] [-e] [--author=3D<author>]
  	   [--date=3D<date>] [--cleanup=3D<mode>] [--[no-]status]
  	   [-i | -o] [-S[<keyid>]] [--] [<file>=E2=80=A6=E2=80=8B]

Parent ids are *not* provided on the command line.

>                                                            author and
> +committer information is taken from the following environment variables,
> +if set:
> +
> +	GIT_AUTHOR_NAME
> +	GIT_AUTHOR_EMAIL
> +	GIT_AUTHOR_DATE
> +	GIT_COMMITTER_NAME
> +	GIT_COMMITTER_EMAIL
> +	GIT_COMMITTER_DATE
> +
> +(nb "<", ">" and "\n"s are stripped)
> +
> +In case (some of) these environment variables are not set, the informati=
on
> +is taken from the configuration items user.name and user.email, or, if n=
ot
> +present, the environment variable EMAIL, or, if that is not set,
> +system user name and the hostname used for outgoing mail (taken
> +from `/etc/mailname` and falling back to the fully qualified hostname wh=
en
> +that file does not exist).

I think that this description, while perfectly fine for plumbing command
`git commit-tree`, might be needlesly confusing for `git commit` users,
as it describes less often common used way of providing committer and
author information first.

Also in `git commit` there are *options* specifically for adjusting how
committer and author information is handled: `--reuse-message=3D<commit>`
and `--reedit-message=3D<commit>`, `--reset-author` (doesn't make sense
alone), `--author=3D<author>` and `--date=3D<date>`.

Maybe describe usual way first, then describe the various options and
their priority?

> +
> +:git-commit: 1
> +include::date-formats.txt[]
>=20=20
>  DISCUSSION
>  ----------

Best,
--=20
Jakub Nar=C4=99bski
