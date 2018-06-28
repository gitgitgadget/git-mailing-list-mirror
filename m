Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2084B1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 13:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965455AbeF1NS1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 09:18:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:56323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752170AbeF1NS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 09:18:27 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lkzph-1g6llj0EDd-00akDF; Thu, 28
 Jun 2018 15:18:22 +0200
Date:   Thu, 28 Jun 2018 15:18:06 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tim Harper <timcharper@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Makefile: fix the "built from commit" code
In-Reply-To: <pull.7.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806281509260.73@tvgsbejvaqbjf.bet>
References: <pull.7.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5OosGcvtLWHZDdJxxeZBsjtNUuJMIlCpUgr77ujl0W1C8AaCVCV
 fnpRxf52aywNs76buMinCXZDHy87J/0ti8GPChDMAYnow5AcXWn8cYdurUyqZIWBQGwjRD2
 Gv/1yT2GbpmWwsgTwNHjbfm+FqhAOZZ5kzqe2MP+TGE1ZoMy29IXyQfCxUHXjlTYNvl2OTX
 0ktPzDC82/s3ZldoregkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:br9zltQhgiY=:zlxSbz3P9PAsskNsqKRZM4
 t10JelWMC7tNxFAjZ1MvuhYxm2XXSQ7uG6UDVtaAo71+XZBV2oseXU3h/OU/N74EKzuCxg2RD
 c0BuMgvWrT50spSacs6lIY9HMaRjU483zVHhz315+8KiRnmRHQL8D+hk6Gp+bvTHmvyCQ3QGw
 UVd3OldPM0ReBY7j0iSopm9VsV/sv42phGkE8dvKWRetZ+mx6uALw2W3G6hovaUgp2+LLY2SN
 M+2LuiI43mL5v6xWeUIlep0NMh9xE2yYTB1GRRNQD8CPwK8PtEXOjK+ALp6Pw2oE5S3tDVnpS
 eTxO30VwGXWIIBjSKczjbivWT7N6BlgfNgDO8fENXLj6aQWi0TOM4HuP5xPoDUicNWMw14UID
 ugiJdSD8bPuLZs48J/SOt35/89FkkVmnA7FQmJp/AAjtk+NUXgnZvobYsIctMUqmILU2QHZop
 lOcC1ni8uADcaCWD0dPxvHYrXRqXSBSf+FJjEzvlAeWRV1MtVTrIez4JprNmTk8sMMU59NLTM
 s0Qbtg1yPcBL/y6azEimIfj4a1nowP1xh75xIhddRv8EQ47LNvjqV2eFfTmzBAk8eTqbYIBaf
 lSx+9PJQn9W2JALwBu8dEj/ADevIoa+L9dBzzk4V81Xdph2ZzFx0UPcHELjQQbsVk2ehPWmuO
 AtAI1vrYGVuvL9FxyxHvtTuZptJGZ0MmLZrkPhn1/GXQgGc0mNtOroNQCrJ3/i8elUW4rfN+T
 QGkkO7NIakwVghMwgzks1jYl+nxV6a7knutDJEhM2fRRSsdVO+YR9gt7NXrEov6IOQzCim1YX
 pc5mTIH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

[Cc:ing Tim]

On Thu, 28 Jun 2018, Johannes Schindelin via GitGitGadget wrote:

> In ed32b788c06 (version --build-options: report commit, too, if
> possible, 2017-12-15), we introduced code to let `git version
> --build-options` report the current commit from which the binaries were
> built, if any.
> 
> To prevent erroneous commits from being reported (e.g. when unpacking
> Git's source code from a .tar.gz file into a subdirectory of a different
> Git project, as e.g. git_osx_installer does), we painstakingly set
> GIT_CEILING_DIRECTORIES when trying to determine the current commit.
> 
> Except that we got the quoting wrong, and that variable therefore does
> not have the desired effect.
> 
> Let's fix that quoting, and while at it, also suppress the unhelpful
> message
> 
> fatal: not a git repository (or any of the parent directories): .git
> 
> that gets printed to stderr if no current commit could be determined,
> and might scare the occasional developer who simply tries to build Git
> from scratch.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Sorry for the repeated commit message. I meant to edit the cover letter
before sending. It should have read something like this:

-- snip --
Fix "built from commit" logic

When I tried recently to build macOS installers via Tim Harper's wonderful
project at https://github.com/timcharper/git_osx_installer, it worked
(with a couple of quirks), but it reported to be built from a commit that
I first could not place.

Turns out that the git_osx_installer project insists on building Git from
a .tar.gz file (even if I have the source code right here, in a perfectly
fine worktree). And due to a bug in the logic I introduced, it did not
stop looking for a Git repository where it should have stopped. The end
effect is that `git version --build-options` reports being built from 
git_osx_installer's HEAD.

This commit fixes that, and also suppresses the error when no repository
could be found.
-- snap --

> Thanks for taking the time to contribute to Git! Please be advised that the
> Git community does not use github.com for their contributions. Instead, we use
> a mailing list (git@vger.kernel.org) for code submissions, code reviews, and
> bug reports. Nevertheless, you can use submitGit to conveniently send your Pull
> Requests commits to our mailing list.
> 
> Please read the "guidelines for contributing" linked above!

Again, sorry for failing to edit this before sending.

> 
> Johannes Schindelin (1):
>   Makefile: fix the "built from commit" code
> 
>  Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> 
> base-commit: ed843436dd4924c10669820cc73daf50f0b4dabd
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-7/dscho/fix-build-options-commit-info-v1

This should be
https://github.com/gitgitgadget/git/releases/tag/pr-7%2Fdscho%2Ffix-build-options-commit-info-v1
instead. Again: sorry!

> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-7/dscho/fix-build-options-commit-info-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/7

These are correct.

Ciao,
Dscho
> -- 
> gitgitgadget
> 
