Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C007C433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D251E221FC
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725308AbhAZFAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:00:24 -0500
Received: from mout.web.de ([212.227.17.12]:44345 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729244AbhAYQz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 11:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1611593588;
        bh=U3o/zoFSiUnkKbEdzt4/UFGCg7FgPAx5/N3AzduTr2E=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kkkyqZbDrn4UcjMSQ6b9thziQ4pBwfBvplfpTGSm08NnjgEteR/l1n9GcynXZRvku
         bVyD0w4wUo17FdAX5rIsmA5VoscNU7zkqW0BCCCf3WkM5DEk/GiSl/Bk8k6ljvmYtM
         ytDwGdyMgMF+3/H5d6iaATwDOEHiU/iZ6gCggjdY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKB5-1lMyL334QP-00Paaj; Mon, 25
 Jan 2021 17:53:08 +0100
Date:   Mon, 25 Jan 2021 17:53:08 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, random_n0body@icloud.com,
        evraiphilippeblain@gmail.com,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH/RFC v1 1/1] git restore -p . and precomposed unicode
Message-ID: <20210125165307.2qkmbtixzih532ay@tb-raspi4>
References: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
 <20210124151306.23185-1-tboegi@web.de>
 <xmqqsg6qyuyi.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqsg6qyuyi.fsf@gitster.c.googlers.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:VcuOo2nrFfN7t8HnHOUJfeqyP5ggY+eT/QrlVzwxaoUjlqjIRNH
 8k2WPEPvEhdgWy+qw0MbTKAt+wvpjuwWcf/EEF3jw8ODmk48vji0c5xw5YDH1tf7HzT4tpY
 tUMKGXgkoODmvX1Xk1C3GhHhyOyvYdHp62mptj63lmpBt4bEVo4Kj3M9CcKZZYXUlzq8mLF
 t/GsH8JC6Z0UMxLjdF2yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a8hejwF+8+Q=:EKrZEqh+7qDay/VeteVwE2
 dVdUSqMcXfwUlYLL3pQH7JQRxUmq2EYTB1MwWN85Qy0AvWbObR5cFBJzcNhhBcW3d5L1oD59h
 Fr/WcahQrsp8ek/ylpAA8063k+48bca+u6ipnW3g+fBasedWqD4F8kf/etxhs8e2ClHTW2+IL
 Yb2UNoOAjYhsiCJ7bJBCqacm36VRgX99Y3MPtj3TJXBteHgpgz8ivN8KqELmnDkBrZVgVfL/C
 tWlaoxjxcmUCQFNmTb4tNbayJaryvYUTrtiCwRBa7DFChJZI4r2PYbX//bmZxOu7t4ti4Pm9N
 tG0ay0Wx2SMWHcTb1SU3TS3X3QfVVnuPJg7b+qZOc/AANk/Ga3FBSsjW9qCxm9PXdZsBFMWqr
 3hYYJyGw+TZzDt5SbQ7A4+yuVXlRzctEkdhYgAQm5HsZuXBm2QWdujvy/mgz3bIdq82nfZzrT
 3g+yyg0eDRfUM1vSGM1X1sDFtlTwAZ72UEA/xPV3c4sg7JTK7xkEjAc8Q/XItfgamnYpFK67G
 0I5/6yX/UNbRzr2/bqpoaGyYeMJdZuquSMKI6wFfLYfKRX2W093MORTOskZ1XL9Pq2sfI3vGb
 2bMCRSbtPh7HHm6iWk4lSDUgqSIE2G6ydcHdCnwS+bQtTn/6aUeXNgxY59NF+RqD9NZ1oY9O3
 w9vOj+z2LYPUZFzOxIitMbHXwc5zIb5KBF0K1R1A89ftS822x68hAc+XAxgIsM/BTLa0kk3Px
 hfbmuSEy8fsaY7jgXTCPmKxxzE79vqPMBRxrGThPcCRMJMzi9og1VQFiZQpL+DLx3AExWX0yP
 krjnJQ3udr8V4uu3a145kBfYhMrZz8B/h1oh1oGQcstaL5S2KVf5W2tnOPbzrD12kzoXpPYGS
 hQPxfwbMVgMTvTB31cfg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 24, 2021 at 11:51:33AM -0800, Junio C Hamano wrote:

Thanks for the fast review, much appreciated.

The short answer: There is more to be done, V2 is coming somewhen.
For the longer story, please see inline.

> tboegi@web.de writes:
>
> > The solution is to read the config variable "core.precomposeunicode" e=
arly.
>
> For a single command like "restore", we need to fail if it is run
> outside a repository anyway, so it is OK, but code in "git.c" in
> general can be called outside a repository, we may not know where
> our configuration files are, though.  So I'd prefer to avoid
> adding too many "do this thing early for every single command".
>
> Where do we normally read that variable?  I see calls to
> precompose_argv() on only a few codepaths
>
> builtin/diff-files.c:38:	precompose_argv(argc, argv);
> builtin/diff-index.c:28:	precompose_argv(argc, argv);
> builtin/diff-tree.c:129:	precompose_argv(argc, argv);
> builtin/diff.c:455:	precompose_argv(argc, argv);
> builtin/submodule--helper.c:1260:	precompose_argv(diff_args.nr, diff_arg=
s.v);
> parse-options.c:872:	precompose_argv(argc, argv);
>
> I guess the reason we can get away with it is because most of the
> newer commands use the parse_options() API, and the call to
> precompose_argv() is used by the codepaths implementing these
> commands.  And as a rule, these commands read config first before
> calling parse_options(), so by the time the control reaches there,
> the value of the variable may be already known.

Yes.

>
> The question is why "restore -p" is so special?  Or does this patch
> mean everybody, even the ones that use parse_options() is broken?

One special thing is that it uses pathspec, `git restore -p .`
and $CWD is inside a decomposed directory.

There is more work to be done, as it seems.
Running `git status . ` in an ASCII based repo (ignore the debug prints)

  user@mac:/tmp/210125-precomp/A.dir>  git status .
  git.c/handle_builtin:699 cmd=3D"status" len=3D6
  git.c:428 prefix=3D"A.dir/" (6)
  git.c:434 prec_pfx=3D"(null)" (4294967295)
  builtin/commit.c:1401 prefix=3D"A.dir/" (6)
  On branch master
  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
      (use "git restore <file>..." to discard changes in working directory=
)
              modified:   O.file

=2D------------------------
But doing the same test within a decomosed directory:
  user@mac:/tmp/210125-decomp/=C4.dir> git status .
  git.c/handle_builtin:699 cmd=3D"status" len=3D6
  git.c:428 prefix=3D"=C4.dir/" (8)
  git.c:434 prec_pfx=3D"=C4.dir/" (7)
  builtin/commit.c:1401 prefix=3D"=C4.dir/" (7)
  On branch master
  nothing to commit, working tree clean
=2D--------
But using ".." as the pathspec works:

  user@mac:/tmp/210125-decomp/=C4.dir> git status ..
  git.c/handle_builtin:699 cmd=3D"status" len=3D6
  git.c:428 prefix=3D"=C4.dir/" (8)
  git.c:434 prec_pfx=3D"=C4.dir/" (7)
  builtin/commit.c:1401 prefix=3D"=C4.dir/" (7)
  On branch master
  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
      (use "git restore <file>..." to discard changes in working directory=
)
              modified:   "../A\314\210.dir/\303\226.file"

  no changes added to commit (use "git add" and/or "git commit -a")
=2D-------------

So in that sense, it seems as if `git restore` is special because
the patch helps.

More patches are needed asseen above.

And the rest of the suggestions makes all sense.
