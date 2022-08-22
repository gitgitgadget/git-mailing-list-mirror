Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C540FC32774
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 16:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbiHVQCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiHVQCk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 12:02:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B9531DC4
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661184156;
        bh=IEEnSBmsoRkRvFad0hL4z/xt/lEuEgXZdSiJAt4Hu1w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cl6Dn4HGCUlOUjWs757H+OWZCJe6dajMMTESaI0/O/6DFv4Mcrh690nhag3IKSwro
         76mX+JIo1f/0jPtpp0Ii881AsfSU4VaDiPNtFOhpmqtqummr0lNSXuj0VH0YG2FX13
         +ONrJTELUzM9a6TLsx/oJ2DOdEKXwrBrKSIGKHNo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMbU-1oeRdH41YK-00EMCs; Mon, 22
 Aug 2022 18:02:36 +0200
Date:   Mon, 22 Aug 2022 18:02:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     squirrel <jatjasjem@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: `git range-diff` lists chunks with uninteresting changes
In-Reply-To: <CAAsFbAtu0vYhwa-Kb6dfpNBZ7jSLriVODi1s7H=-Deq9J6L0ww@mail.gmail.com>
Message-ID: <252qppor-o3pp-s13o-q59r-9166478no04r@tzk.qr>
References: <CAAsFbAtu0vYhwa-Kb6dfpNBZ7jSLriVODi1s7H=-Deq9J6L0ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jW7kxYlEuVIJOAtgpLsDcW1T8Ti/7yh9vbKddEv9GMPJ+hNcekq
 pKqbE01Q74eKc6vzr4GqGwRS9E0ib18ambnQq8i+Z/vWgpj2CM1Pvhbi9tQukNNmaY59waB
 lVEcnmzGhiN7dYo7ULKEiQ9laq0Uf7SEQ0INOoR1jZa/E3sfg1JDtRsKN1RgxL+SxT8+4k4
 5IMCT02HPEugmL124X8JA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v4sYpjV4VMU=:HWC4AmA5SnXJhwKw6ZL/j1
 H7sWif4YGtMRr/xnn/SMjQ2m1AzTAltCG33ITY0TR5H6bf5Xgi/pAW4vi9R2uw6MvLYUZo2Z5
 f/O3ddcsPJ6jCsGP1GrsNc9CyAQM/fJZh7cCyZdPtBFXLrUB8Ilznbzqus6Nzc65csa3uXpSK
 mku+hRJJuvvBdwEYeR4UvkxJgnb/zISKyXGzkruzU/s1U9dKUnxIr0dP/GwuKdXLbtwT9a+dI
 SxCD0Gsg2kqIxfncXpaIONZV0wlNkSthJi7SeGaKtcs4buumne870wvcUFjYWMXRJyEVMknmy
 iGu4wVTjIzrq6ru9o58DMQNAuGMkoz+naleBt2HKmpODjIq0aS/8Is23gttnCGfVXisV4mH9u
 ye+rbRKceM1c0JzM4gGWlj9cPBVEn5qtad0U8RupnyTqdlj3b166Qpn+3cALYjp3PP9Kgi/yB
 SuIu5T6bqRfYWuIU9R9MOzV4CjuytdREpov+WUoF5mdrFqDUAjiZukGydFfYo/on0FaLXcZyE
 Oh96rFm8mIHD0GnRNO7RWWqtoxT6kmNirYkfQTCb7D5oZuTLxCuRzJeaBVvrWsM/XlYDhWwx7
 Y8Xwf/LIBySUf9W4DT97P1AzXWgAWK7CiJsePKmSgr9KFxk8wnXI3kFj/mPPvEx26RpzUVIxm
 tS841yipJpkVv1hv02lL7Osqb8Qr2yrqgje38Waxvpoo5bn9mw+1E8RFxR7dqTxtN5Pwgmbx5
 OwAsGwa5yn1lpehimpFEggVbofXsPmbRaX1UB0cxyiv1oXEenMsoOn22wouKBidbiNpytWRiR
 By64Fe7D6r5ArWWaWh3CKfwNeA+uz73n2H4OqpQCO8Koi06CT+NcBS1DMVyQzssOwY945iZZy
 4JmnFK/JdFGXJkKXHxpNOs24R68+iWGhIsI0P4dhx1tuKcHxOGAy2EoJWyE3b+pgIssZF2f0h
 386weF4PLaSGWcG62JvElN28aFJe3n7x5cZbDp1D3m3fos44C5jO2ggS4OVdy/pqASEpC2w7X
 HCtYsarObjqb0iUXOuqBUtOkXHP8KzVcYz94QgKNV2b8W4reomOKmB/M8tHz6TWLWfIqsj6Pi
 um+TrqbfTJCyjS+mhMOBGZWYVnQLnyVKjtEhTN7tOIWfhvc0K4nasbpww==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi squirrel,

On Sat, 20 Aug 2022, squirrel wrote:

> When someone makes a PR, they may be asked to rebase their feature branc=
h onto
> main to resolve conflicts. It may be useful to quickly see what changed =
during
> the rebase, that is how the new version of PR is different to the old on=
e.
>
> If the PR branch has not been reparented, you may get away with `git dif=
f`.
> But if it has, `git diff` may contain a lot of changes from upstream. In=
stead,
> `git range-diff` can be used.
>
> The problem with this is that in this case `git range-diff` can show chu=
nks
> with changes that have nothing to do with changes in the PR. Consider th=
is
> repository (commands are runnable):
>
>     git init
>     git branch -m main
>     echo -e "a\nb\nc\nd\ne\n1\n2\n3\nf" > file
>     git add file
>     git commit -am "a b c d e f"
>
>     git checkout -b foo
>     echo -e "a\nb\nc\nd\ne\n1\n2\n3\nfoo" > file
>     git commit -am "f -> foo"
>
>     git checkout main
>     git checkout -b cat
>     echo -e "a\nb\ncat\nd\ne\n1\n2\n3\nf" > file
>     git commit -am "c -> cat"
>
> We got a few letters of alphabet on separate lines on main, and in branc=
h
> foo `f` is changed to `foo`, and in branch cat `c` is changed to `cat`.
>
>     $ git log --all --graph --pretty=3Doneline
>     * 90e873e3 (HEAD -> cat) c -> cat
>     | * 3d8c1baf (foo) f -> foo
>     |/
>     * 4d2337dd (main) a b c d e f
>
> Now, still on cat, let's combine the two changes.
>
>     $ git rebase foo
>     Successfully rebased and updated refs/heads/cat
>
>     $ git log --all --graph --pretty=3Doneline
>     * 98e554a0 (HEAD -> cat) c -> cat
>     * 3d8c1baf (foo) f -> foo
>     * 4d2337dd (main) a b c d e f
>
> Now, `git rebase foo` worked automatically, so *the change* of the last =
commit
> on `cat` is the same as it was without rebase, which is changing `c` to =
`cat`.
> But if we run `git range-diff`, we will see this:
>
>     $ git range-diff 90e873e3...cat
>     -:  ------- > 1:  3d8c1ba f -> foo
>     1:  90e873e ! 2:  98e554a c -> cat
>         @@ file
>          +cat
>           d
>           e
>         - f
>         + foo
>
> It seems that this chunk is included for the sole reason that the change=
 from
> `foo` is sort of close. If we try the same code, but put the lines `c` a=
nd `f`
> further apart, for example by replacing `e\n` with `e\n1\n2\n3\n` in the
> commands above, the output would be, as expected,
>
>     $ git range-diff f1e0a6cc3...cat
>     -:  ------- > 1:  4db06be f -> foo
>     1:  f1e0a6c =3D 2:  cc56db7 c -> cat
>
> I suggest not showing uninteresting chunks like that, or perhaps having =
a
> command line option that controls how close together the changes must be=
 in
> order to be included in the output.

In a generic tool like `range-diff`, it is virtually guaranteed that the
default operation does not satisfy all use cases. This example
demonstrates that ;-)

In general, the `A...B` form does what users want, namely show you pairs
between the "left" and the "right" commits in that symmetric range.

However, you _can_ use `range-diff` in a way that it produces what you
want. In the example you provided above, `git range-diff foo cat@{1} cat`
should do it. That would be the `<upstream> <before> <after>` form.

In general, you might need to play with `git merge-base --fork-point` (see
*1* for more information). I could imagine that the following command
might give you what you want in even more cases:

	git range-diff \
		$(git merge-base --fork-point @{u} @{1})..@{1} \
		$(git merge-base --fork-point @{u} HEAD)..HEAD

Ciao,
Johannes

Footnote *1*: https://git-scm.com/docs/git-merge-base#_discussion_on_fork_=
point_mode
