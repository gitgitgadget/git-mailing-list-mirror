Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1CBC2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 13:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB67420873
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 13:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kvu5dQO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgBMNeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:34:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:60433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729674AbgBMNeI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 08:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581600838;
        bh=D6VGh2QQA9f0DS88ougPk6iLYAPiRWe4EukPuJXDfCQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kvu5dQO+IMe13uCIjharBuYxZLK4+eHXF3XSmUJ25lLT0TYJf/L+RsfRjBxHMX6W1
         hz6q7QKfNCFvlOwdbKnblT09D3c/C5eDmEDfx9do1LoyYaOGCnGQSz14u+/I03MLBF
         t2HWmQ401RarkEmJE6ltnryvxkHJ1z8x4WuiLmYY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fii-1jUwfO2Phg-011yp9; Thu, 13
 Feb 2020 14:33:58 +0100
Date:   Thu, 13 Feb 2020 14:33:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
cc:     git@vger.kernel.org, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com
Subject: Re: Conversion of 'git submodule' to C: need some help
In-Reply-To: <20200209111349.20472-1-shouryashukla.oo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002131412300.46@tvgsbejvaqbjf.bet>
References: <20200209111349.20472-1-shouryashukla.oo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yHSXAQY4Iv4gcJiqTbbQUZxuLUiaHQR1gfClh2nye4qdnJyxJTR
 mnseN72KPj1bHxmjLG7Y8WKxPjKeoyyxB0oMuOKDBVujzPugt21Ou8R8xhATp1MfQIgYle9
 oRW1q9wnnpMKTYir6CPQ6+tUd5jChSZzmLW+cJ9mksPLt9idtpE2cTa+vs3aE2loJdxR5Mt
 ODwV7XycT/rgTLOPamiDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xxvWoKZXJd4=:fPFUM9M1+qzS8OUbzzYPeF
 HkwEOE0pZBSH9DtgXITe1HngD/pVRbXktEO2DE5nTNOOnFhAU26dI3K6CIQz/B8OdYeLZle/9
 MEczRxRHUvNTc3fv8eibF+zJ7Zhh8UM5Rf4SxVKuV7JIEx3Bzy3mXEkB4jzljiQZqKyYdqqaM
 BfCv/2H/K8LzoFsKa+r8vx9s2IrqWUSo3qpU5WKzPr4xNqRdp/GuPNBjxrbRMSowYng6rx+d7
 AuKAWDi+H6bBMiRUrWd0AdFwnidK/7zPa3wkqKKQSzaXrfNxoaXICJjg/HKYJL9Jml2TZKdaQ
 w8lVmlH/49TkAA4a+Grp06f/pSSdCiO3A+E9HudqydkURzCKkJTAFzoQogoNu1mQGe1wjp0Zg
 Y+f3Qagw/YONPsE0PeAyWdDuxsba1CYQV+UrGSM+Dk1T62Kf2m2JKgVgexzDe/A1f/Ann3qu1
 myBbz38Bo/pLVw+TVNO9PVwuaJZSL14oHDdJkS6wJ3k2OyeaWrIoKrOFGBUNyiR6KInstJBIv
 m5iRJ2gywHxT7NLbyew3vgXKjDJBcDkYgpq64s9qv3wCG+c2zSBIYGotZTNAO9kGaB8nD+QoK
 i0bC+89L7XJtRd/EWgC9jAoasOXj958V++9WRnWKhlnN85veelSm8vqbYWKQ00SAaWle1SGaH
 LpRqmF3CNsaqDjnUw89WLtX48wmyz3H7kVDNR6jhc/7XjV59MQ14WKMyxt2skWd4rgZiO+4TI
 yWjluJ1fZYa2+OWV68LQL+caf4hnJy/KlWzwlAeZDjWRB277RrnLYlOPREQrImt8KoJpQtIjR
 R6qtmDYkCuDkDwCna/ILIdWcS45mKZ9PmTTua1jfhdF33QlN4eAJNWTDimmCX+4MazhEGvy+7
 785oS+kqMtH4woEf9G1GwnYWvW6GJfnVL00IKsz0rK9/a7PxMfBfBKf7/Y0miIPWrMacdlQLp
 19MGslsGIvv9dStaNf/LcOdjRAATOGC6dbS2nDbkMRPWgoLeqbCJnDdY24rTuHj9HV3KMH13r
 RuW+fsQdMiRxHPbJfGEO6qJZMx/PKrQunfm9smLfFP+QHeRh0oakny9poLljbrfRX3GQF7Pau
 y7m1PFtCBGJPely66oHlCwCCOR4HcAts6MJJrCUdcrHMuo5lO97ZS1MPhsjvVi5YeMEfEcahh
 ob5cW1IgtS6T1kbiQl+LgeLm4s9VJ2uX2s7dUZ4meG7a04SaTd92EXQFZOc9HyA54+sOmkbUQ
 qldqwJ1LNul3GUtqb
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

just adding a little to what Abhishek said (which was pretty sound
advice!) below.

On Sun, 9 Feb 2020, Shourya Shukla wrote:

> I am facing some problems and would love some insight on them:
>
> 	1. What exactly are we aiming in [3]? To replace the function completel=
y
> 	   or to just add some 'repo_submodule_init' functionality?

If you follow the "Git blame" link in the breadcrumb menu, you will get to
the commit that added the TODO:
https://github.com/periperidip/git/commit/18cfc0886617e28fb6d29d579bec0ffc=
db439196

Unfortunately, it does not necessarily help me understand what that TODO
is about. So let's analyze the code:

int add_submodule_odb(const char *path)
{
	struct strbuf objects_directory =3D STRBUF_INIT;
	int ret =3D 0;
	ret =3D strbuf_git_path_submodule(&objects_directory, path, "objects/");
	if (ret)
		goto done;
	if (!is_directory(objects_directory.buf)) {
		ret =3D -1;
		goto done;
	}
	add_to_alternates_memory(objects_directory.buf);
done:
	strbuf_release(&objects_directory);
	return ret;
}

Okay, so this just adds the object database of the submodule (if it
exists, if it does not exist, the submodule is probably _already_ using
the superproject's database).

To understand what I am talking about, have a look at this document:
https://git-scm.com/docs/gitrepository-layout#Documentation/gitrepository-=
layout.txt-objects

So what does the function do that was suggested as a better alternative?

int repo_submodule_init(struct repository *subrepo,
			struct repository *superproject,
			const struct submodule *sub)
{
	struct strbuf gitdir =3D STRBUF_INIT;
	struct strbuf worktree =3D STRBUF_INIT;
	int ret =3D 0;


	if (!sub) {
		ret =3D -1;
		goto out;
	}


	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", sub->path);
	strbuf_repo_worktree_path(&worktree, superproject, "%s", sub->path);


	if (repo_init(subrepo, gitdir.buf, worktree.buf)) {
		/*
		 * If initialization fails then it may be due to the
		 * submodule
		 * not being populated in the superproject's worktree.
		 * Instead
		 * we can try to initialize the submodule by finding it's
		 * gitdir
		 * in the superproject's 'modules' directory.  In this
		 * case the
		 * submodule would not have a worktree.
		 */
		strbuf_reset(&gitdir);
		strbuf_repo_git_path(&gitdir, superproject,
				     "modules/%s", sub->name);


		if (repo_init(subrepo, gitdir.buf, NULL)) {
			ret =3D -1;
			goto out;
		}
	}


	subrepo->submodule_prefix =3D xstrfmt("%s%s/",
					    superproject->submodule_prefix ?
					    superproject->submodule_prefix :
					    "", sub->path);

out:
	strbuf_release(&gitdir);
	strbuf_release(&worktree);
	return ret;
}

Ah, that populates a complete `struct repository`! I fear, however, that
our object lookup is currently not tied to such a `struct repository`
instance. So I think that this TODO can only be addressed once a ton more
patch series like
https://lore.kernel.org/git/f1e4da02-9411-8a93-ca62-6d7ae7bf4ae8@gmail.com=
/
made it not only to the Git mailing list, but into `master`.

> 	2. Something I inferred was that functions with names of the pattern 's=
trbuf_git_*'
> 	   are trying to 'create a path'(are they physically creating the path =
or just
> 	   instructing git about them?) while functions of the pattern 'git_*' =
are trying
> 	   to check some conditions denoted by their function names(for instanc=
e
> 	   'git_config_rename_section_in_file')? Is this inference correct to s=
ome extent?

All `strbuf_*()` functions work on our "string class" (I forgot who said
it, but it is true that any sufficiently advanced C project sooner or
later develops their own string data type).

To know whether the functions in question create a path or not, you will
have to find their documentation in the appropriate header file (usually
`strbuf.h`), or absent that, find and understand their implementation
(usually in `strbuf.c`).

> 	3. How does one check which all parts of a command have been completed?=
 Is it checked
> 	   by looking at the file history or by comparing with the shell script=
 of the command
> 	   or are there any other means?

You mean whether a scripted command has been completely converted to C?
There is no universal way to do that.

In `git submodule`'s instance, I would say that a subcommand is converted
successfully when all parts except for the command-line option parsing
have been moved into the `submodule--helper`. Eventually,
`git-submodule.sh` will only have functions that parse command-line
options and then pass the result on to the helper. At that point, the
command-line option parsing can _also_ be moved into the helper. Or maybe
even the entire script in one go, I am not sure how big of a patch that
would be.

> 	4. Is it fine if I am not able to understand the purpose of certain fun=
ctions right now(such as
> 	   'add_submodule_odb')? I am able to get a rough idea of what the func=
tions are doing but I am
> 	   not able to decode certain functions line-by-line.

It is okay not to understand all the details, but if you want to work on
the code, you will need to understand at least the purpose, and if you
want to come up with a project plan (e.g. for GSoC), it will be _really_
helpful to form an understanding of the implementation details, too.

> Currently, I am studying in depth about 'git objects' and the submodule =
command on the git Documentation.
> What else do would you advise me to strengthen my understanding of the c=
ode and git in general?

I don't know what in particular you want to strengthen. Typically, a good
way to learn enough about the code base in preparation for Google Summer
of Code or Outreachy is to read the code, and whenever anything is
unclear, try to learn about the data structures and/or the underlying
design by studying the files in `Documentation/` (in particular in the
`technical/` subdirectory) whose names seem relevant.

Ciao,
Johannes

>
> Regards,
> Shourya Shukla
>
> [1]: https://github.com/periperidip/git/blob/v2.25.0/submodule.c
> [2]: https://lore.kernel.org/git/20200201173841.13760-1-shouryashukla.oo=
@gmail.com/
> [3]: https://github.com/periperidip/git/blob/v2.25.0/submodule.c#L168
>
>
