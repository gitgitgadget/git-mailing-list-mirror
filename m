Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB3C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29EB60F93
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhHCXEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 19:04:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:38189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231482AbhHCXEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 19:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628031840;
        bh=h8VADivIz9qZ2yPTaGJ2qSum/min1G08lSt3jabtNCM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dRJrvYXzF8XZi4PPf9i0AEPRjgeYATScHaW+RoSyKEPqOGkU0NzEtKYALs6hZuA6f
         I6KNg0e6clvtM402RceWMYs1Lq5nLeJwfxW1ybPUZ7VZvuiQnculFuqaIhOiKGEhMg
         KoLNXtW3rrJ3QZPWdPW1ScQzM+5dGe47asWa/6Cw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDNl-1mwX9T2jL5-00qfdl; Wed, 04
 Aug 2021 01:04:00 +0200
Date:   Wed, 4 Aug 2021 01:03:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 09/10] Documentation: add coverage of the `ort` merge
 strategy
In-Reply-To: <37a69fd2e0bdb7fba6b6c47c3edec0964165cb61.1628004920.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108040102220.55@tvgsbejvaqbjf.bet>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com> <37a69fd2e0bdb7fba6b6c47c3edec0964165cb61.1628004920.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:R3KJ9BsYqwLUwVZBCGjJkUwfR9niRRTuXK/hRgii8BnSVDXlRWn
 Mi+0zPSeMnZSkjXF4mFxWK/Zf/3elq847zF2C1Mt8OfgCaX+7Er4ZHrKrfEeck7BWigWsvA
 GMdF0fGdsuTnGnrY/NHqDoN73MGhg1CE5G4lE5r0q6YYLLJdA73F/raR2SHW3y7beOOArG3
 YbKan7G1QFwQVAekPsTzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MtP+r0V1Mgc=:OCazCpcVwtRrWNQFJ7xkXj
 bkB9zGTKUlyHw6U3l0g6vyF8ye5E7g/VUPCD2EAw2qP3srzzKw0fxtHCmnrCCk1mRKTB5sPv5
 s5xw1gQctxq2fTnuEPS6UXqFhXGVFI26KFyf0F0C41oRCmGK7ckAUz4RpHjHd+qoJP7kFViw4
 nrCDMWYvvoujV9IXgp7knQIasyyysXUPzV7ErGv8LPB1gApMk/TEt9IDuoNiIaZhZl2thPtBj
 UviVU++5EUSBGX0UKWIAuOXrQmGK9VIbl67TDu+81esSxuewZpL4ypE45tr67LfZvcoO6vmY7
 SVnkwWDC5RBRLpt+/59OzUBNkhZdups7ho51hIDJR+lxPOhVA/46HnTBgjDgTCkckJ0eBFSDD
 Zn6iLLkS3wjrTP+CB8zL0eIzx4ektwGn8YAQ5xJsBFWQAQ6r69E+MHHqD4aNvWaQulcl2Y4qh
 0iW/I+lLmKBZMK94FSSTJUL2BV9rn/u38qiOjmcXW3yet0g858nL+7Xbynwp8IVRZMwzy4hea
 7peSDgK/Bq2OxkBiVqnWa1y/Q5IDaUc9qD3va3JgDRDrcB4rEvnbBdarPIXv3AqbDsCbrMlIj
 OpLABua4KEpu20YXWzN6oX2+YLYtrRu679qnOqQwPe6VtmWo7JzfwqBvgsbbgC/6QUWsqkzW8
 zb/2tz9Ksfs9H0K37qY5b0z3HvhhIgt5buRPH4T+12WXvrKcaMgBZ63IYmaCMBNVQ4TMRy9MI
 mC0tKo305HCqs/bQ9OGRBPu9g1yD6To+Eu5tbRXJWviPkJYn7Y/+pf0ARpr3fMm/3D0ffUPrh
 LDktmCQtWpdj4C9lIGWL0x6q98SqM3hOD7n0xLjKZahLLoLAnIfSLRnGdibxyRxkq6BWsrRj8
 vhSEZkH4UwfkFoZdbKRpzT3gO+iCeQarzt8865ZxcQacATX7Rvlt7ghEab6sGD3jVnBdsTgZ5
 KP2P34EK2MrLUPohgAQ4DuHgGPafRJWkm/rJyFMudJ8tHGR8JbDSwd1LhycAuttuv1KDfwCCi
 8OjgRhYc0TqstnPbCOX3BZ7PpQz2qFwkZOyIEeJfpgMOmIuLVRtAne9kkcTppuYKbIUP8BwBP
 J9W1zFEIbJ4QHESOn1H+hYnbEwv5rzhprDMCwcbbfBAe+5taWZiTq1Mrw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 3 Aug 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-rebase.txt       |  7 ++++---
>  Documentation/merge-strategies.txt | 14 ++++++++++++++
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index b4429954480..3e112011c6f 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -340,9 +340,10 @@ See also INCOMPATIBLE OPTIONS below.
>
>  -m::
>  --merge::
> -	Use merging strategies to rebase.  When the recursive (default) merge
> -	strategy is used, this allows rebase to be aware of renames on the
> -	upstream side.  This is the default.
> +	Use merging strategies to rebase.  When either the `recursive`
> +	(default) or `ort` merge strategy is used, this allows rebase
> +	to be aware of renames on the upstream side.  This is the
> +	default.

Since this now talks about two merge strategies, I think "This is the
default" needs to specify which of the two strategies is the default.

>  +
>  Note that a rebase merge works by replaying each commit from the workin=
g
>  branch on top of the <upstream> branch.  Because of this, when a merge
> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-st=
rategies.txt
> index d21dbd1e051..d13d4a29875 100644
> --- a/Documentation/merge-strategies.txt
> +++ b/Documentation/merge-strategies.txt
> @@ -96,6 +96,20 @@ subtree[=3D<path>];;
>  	is prefixed (or stripped from the beginning) to make the shape of
>  	two trees to match.
>
> +ort::
> +	This is meant as a drop-in replacement for the `recursive`
> +	algorithm (as reflected in its acronym -- "Ostensibly
> +	Recursive's Twin"), and will likely replace it in the future.
> +	It fixes corner cases that the `recursive` strategy handles
> +	suboptimally, and is significantly faster in large
> +	repositories -- especially when many renames are involved.
> ++
> +The `ort` strategy takes all the same options as `recursive`.
> +However, it ignores three of those options: `no-renames`,
> +`patience` and `diff-algorithm`.  It always runs with rename
> +detection (it handles it much faster than `recursive` does), and
> +it specifically uses diff-algorithm=3Dhistogram.

Probably `diff-algorithm=3Dhistogram` should also be enclosed within
backticks.

Thanks,
Dscho

> +
>  resolve::
>  	This can only resolve two heads (i.e. the current branch
>  	and another branch you pulled from) using a 3-way merge
> --
> gitgitgadget
>
>
