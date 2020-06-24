Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47359C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 12:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146C920706
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 12:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Sua5gWqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390179AbgFXMzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:55:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:35233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388942AbgFXMzh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 08:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593003313;
        bh=r7eISVAJz9YwKpnHEhNMe8nljidEXP0Mpv+kGVqtPdE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Sua5gWqdtnj0/HKW8HT8WykNb2pa4xQufnWOChHTVJk7ZUa6aSVD2lPBQ0yqE8avi
         3zcdTb8xWT34P+bOfODDImY5Xu/OBf5uEXiNa/nW9Vpep0Wra+WG1ngea56knixqlH
         3lT6dOq7NnTWfxJHpX9RIppyvApc1Y7DBZsQrXPM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeI8-1jOk2n1EDE-00RYQW; Wed, 24
 Jun 2020 14:55:13 +0200
Date:   Wed, 24 Jun 2020 14:55:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 4/8] init: allow specifying the initial branch name
 for the new repository
In-Reply-To: <xmqqmu4t9t57.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006241452540.54@tvgsbejvaqbjf.bet>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <pull.656.v3.git.1592951611.gitgitgadget@gmail.com> <e8a6587c1a783476413277296c6ce3db74e217e6.1592951611.git.gitgitgadget@gmail.com> <xmqqmu4t9t57.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:51Q/Tadtnr8Ltn0AaVkxuYrhDuK3PnlO9URUVDX77reDkAseQDR
 cRscbn7HhomOuyAVKzLKFlYpaczgbDBHLdpR4cbDYjofLwfuLLbPjzZopWl6zR8fx8H1Jt1
 ObKQGyrsJLXjwvYsKH0BvHmOx2sZmHTVidPsVaHFEnhpmyoXiFrrQgSz/Qvr6YR5Ji6pBN+
 DB999oogxTkTHkvDagseg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XNBJSydBfR8=:VXFrje+o6uURds2UnKliwU
 8jtsHrZTdLRsy2gIN4+0/Ux67CvChuHWSkziYK3t9o0pi5tkN4QGI/bpsqPFW5TL6/xqW0bpm
 Dwl0pIserdRZb197010cWMi+kXfjlRD5xiJiIyPSUv/byvstPZMz3uxwFxMOEIUZibO9CZtyk
 h2nAz229+CGmm653rBgheHKYenYE4Nd/wMModtnRbyG9MMsgCXiopGer6DK/IddsSLlb6rN33
 9VrhdhSzfbw7U9fY/xezXxDk7IIFyWwKVRoHRpCzDCROyXLmOP9zy/caxngG9crPzMz1CLrsE
 psD2h+HNOC9k25hFlw1eCV9XSEmeL97cDEbGevrnUgSE+9t5DilR1gbkrqsZWY83oMdM3p6ot
 2oTl/gLlXmHT7M9kL2qvTzoGgvUa9rSTHdRgzgBJAyMEz5Q9EazqF7DB8T6cncQ0sBphUe9GC
 fjJDweQDDFsA5ps6wDz84Z82LNAaKoE94GxbYFFq0ks2ToWp+uZ7vDwty7aMxJ9pI0Cnx2hnP
 HXEryX2ft++nyjyCp+M7DmYIT/9mGzHlAocVgduAhXUDsMIJl5ikyOxm/LQM3dfkVSXTN7huw
 t3jQbau65n/yC+48Y525Y+ijy2UDz7SaLtifjWPi96ZOjvD/rMnPv2h6cEj9X4OJ5izLVVDx5
 fjdCeLS61mZQK5BE+9YNLVksNd7bQ+6r7OP+5+BzZgRiP6o5OZqC8ztA+LlHOG3oywlll06VW
 z+n7gCmqr7TYIHxsMiLKF1qAI3vcGpbnIsTBhuxLspU8CypTouRKV5HHr8fYNVk9VHd/4hWoY
 BOgnJvAuIs90+Dccc7GGwjvi0stSxP28LpzPztFOp2nwZNCNi14DkHydV7CKExLAgR/gIYi6l
 ON145DZNZzmQbASMBINfW2nvxiNOfZ1TZOmOSuXCXgJ1Zk5qpf3VoY3vDG4TcBGeCYF5KB9jq
 JWsYlCZWIEUbl7/tAtF1DVeWaDtRp73+igG5SsAPHe3syud5eVN8jL1eU6XcYPs36GijcjnF8
 blO1AEAw5D0AmJB19UNCLG7e/4784LS8626ZDddElQ1gNKYF2URh2IJoyUOXD2IRopnNxwmls
 q6wDPHTZO8HY06RoY+XaCwYOCwGjtJovfeIb1R4zsC18kWiA9N0YVSW59r5PEkZNWYM7afoI6
 2EjbHwZw4t4TCOClx0g6/P10HuY71E9N3Xp+TrjQrNremOzjVxETml9B3DFJisLacy4Wi23/X
 D1aCXPBGDB6+AtTryMF5+q/FkFYJc+6l5aNYs4A==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 23 Jun 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> >  [verse]
> >  'git init' [-q | --quiet] [--bare] [--template=3D<template_directory>=
]
> >  	  [--separate-git-dir <git dir>] [--object-format=3D<format]
>
> Completely offtopic.  We lack the closing ket> here.

Not so off-topic: the fix for this would cause conflicts. In the interest
of avoiding merge conflicts, I incorporated a patch to fix that (`git
grep` found two more instances, which I fixed "while at it").

> > +	  [-b <branch-name> | --initial-branch=3D<branch-name>]
> >  	  [--shared[=3D<permissions>]] [directory]
> >
> >
> > @@ -67,6 +68,12 @@ repository.
> >  +
> >  If this is reinitialization, the repository will be moved to the spec=
ified path.
> >
> > +-b <branch-name::
> > +--initial-branch=3D<branch-name>::
> > +
> > +Use the specified name for the initial branch in the newly created re=
pository.
> > +If not specified, fall back to the default name: `master`.
>
> OK.
>
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 2a8e3aaaed..b751bdf13e 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -1111,7 +1111,8 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
> >  		}
> >  	}
> >
> > -	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, IN=
IT_DB_QUIET);
> > +	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NU=
LL,
> > +		INIT_DB_QUIET);
> >
> >  	if (real_git_dir)
> >  		git_dir =3D real_git_dir;
> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index 0b7222e718..a898153901 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -203,6 +203,7 @@ void initialize_repository_version(int hash_algo)
> >
> >  static int create_default_files(const char *template_path,
> >  				const char *original_git_dir,
> > +				const char *initial_branch,
> >  				const struct repository_format *fmt)
> >  {
> >  	struct stat st1;
> > @@ -258,16 +259,29 @@ static int create_default_files(const char *temp=
late_path,
> >  		die("failed to set up refs db: %s", err.buf);
> >
> >  	/*
> > -	 * Create the default symlink from ".git/HEAD" to the "master"
> > -	 * branch, if it does not exist yet.
> > +	 * Create the default symlink from ".git/HEAD" to the default
> > +	 * branch name, if it does not exist yet.
> >  	 */
>
> To the caller of this helper, it may be "the default", but as far as
> this helper is concerned, it is not "default" but the initial branch
> that was given by the caller.  How about...
>
> 	/*
> 	 * Point the initial branch with HEAD symref, if HEAD does
> 	 * not exist yet.
> 	 */
>
> ... to modernize the reference to symlink and replace it with
> symref?

Good point. I massaged your proposed comment and replaced the old one with
it.

> > +		if (!initial_branch)
> > +			initial_branch =3D "master";
> > +
> > +		ref =3D xstrfmt("refs/heads/%s", initial_branch);
> > +		if (check_refname_format(ref, 0) < 0)
> > +			die(_("invalid initial branch name: '%s'"),
> > +			    initial_branch);
>
> Good.  We make sure to prefix with "refs/heads/" so the callers
> cannot abuse us to point HEAD outside the local branches.

Yes, Peff offered that concern, and I agree.

> > +		if (create_symref("HEAD", ref, NULL) < 0)
> >  			exit(1);
> > -	}
> > +		free(ref);
> > +	} else if (initial_branch)
> > +		warning(_("re-init: ignoring --initial-branch=3D%s"),
> > +			initial_branch);
>
> Somehow the error checking convention feels uneven in this API.  It
> is a warning-worthy offense for the caller to give initial_branch
> when we are re-initializing, but it is not an error for the caller
> not to supply the initial branch name on the other side of if/else.
> Worse yet, this helper function even knows the command line option
> name that resulted in the parameter coming to it.
>
> That unevenness ultimately comes from the fact that the caller does
> not know if we are dealing with a repository that already has HEAD
> before calling, but at least we should be able to tell the caller
> if we initialized or not with our return value and allow the caller
> to issue this warning---that way we can lose the warning from here
> and get rid of the uneven feeling.  Oh, and ...
>
> > @@ -383,7 +397,8 @@ static void validate_hash_algorithm(struct reposit=
ory_format *repo_fmt, int hash
> >  }
> >
> >  int init_db(const char *git_dir, const char *real_git_dir,
> > -	    const char *template_dir, int hash, unsigned int flags)
> > +	    const char *template_dir, int hash, const char *initial_branch,
> > +	    unsigned int flags)
> >  {
> >  	int reinit;
> >  	int exist_ok =3D flags & INIT_DB_EXIST_OK;
> > @@ -425,7 +440,8 @@ int init_db(const char *git_dir, const char *real_=
git_dir,
> >
> >  	validate_hash_algorithm(&repo_fmt, hash);
> >
> > -	reinit =3D create_default_files(template_dir, original_git_dir, &rep=
o_fmt);
> > +	reinit =3D create_default_files(template_dir, original_git_dir,
> > +				      initial_branch, &repo_fmt);
>
> ... we are telling the caller if we are in reinit situation, so we
> can afford to do exactly that.
>
> 	reinit =3D create_default_files...
>  	if (reinit && initial_branch)
> 		warning(_("re-init: ignored --initial-branch"));

I changed it accordingly.

Thanks,
Dscho

>
> That's much better ;-)
>
> Other than that, looks good to me.
>
> Thanks.
>
>
