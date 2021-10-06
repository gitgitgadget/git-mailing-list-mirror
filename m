Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4486CC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5D261152
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhJFUkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:40:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:53965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231887AbhJFUkO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633552691;
        bh=ib61uj7D3o9bSe4P6n+cTy7bpMZmx6MkFZ6B8PF07Jk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AifdFqTyY9dSC4tGv81ayXO8vZDoI1gptkntzFnN0TXDRWC+xkgk8e14DDe9ji6Sz
         fqRxh4rIFLA2adKxeLr+xw2gh7Q7iKL30c/JZsWpIztL1WEDGis9Cp/mSfpkMCRUfO
         +zA4mh/y6KKORE/k5EVBKIMkQ6YSFN4Fuzro/D8I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.23.42] ([46.183.103.8]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU0q-1n6SZD1R0W-00aUu1; Wed, 06
 Oct 2021 22:38:11 +0200
Date:   Wed, 6 Oct 2021 22:38:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 04/15] scalar: 'register' sets recommended config and
 starts maintenance
In-Reply-To: <CABPp-BGLcLKk1QLHtb6KpCOpn=M1-wwK6KD91rLCYbh6n5gTYA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110062233180.395@tvgsbejvaqbjf.bet>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com> <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com> <bbbc4c3339043bcd718dd2defcbaaaac2092227a.1631630356.git.gitgitgadget@gmail.com>
 <CABPp-BGLcLKk1QLHtb6KpCOpn=M1-wwK6KD91rLCYbh6n5gTYA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Imff6hkBNrQ311gKI0osCu096ZnP+wGCL5nr3B0S/pwFy536CbA
 UtPiQ0TYor/SJQzhIPHGP51LTj9uWYTDexnh42hQ1Qb1MVVJ6r0+rrj7XjcyxiVD+X2jrL9
 m6HLK2MGNAj/YJ6kIXgX8970ES4s2yOYLv8V5td4j2xW4rypusEijiuzS53b7FbSzLsEr2k
 OV8OOXhFHwMQjlMd/nH0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7pPXJNRwISU=:VP/iibzHvVMMIyi3/3spcQ
 g7uhRi5F6tZ5oaA3imknBa4XgOC5YxP7+mB4AE4MIUqeecl1Srl35f1/YFOPY6mz6pOA8t5Kz
 5AyOvCWwvCcG23uxq956Srg7CYoofL3duOhe/nlKwYxkKUJ3V7DWrOAyDnRBSRAUWTpqv+fSb
 7oteD24OUB+61PPIqZRouCdcTLAzqoqHe3xrSios5TSCJChgBRtLLhQpFG5MwIu6X8Zw2gm29
 5MwbnPQM2jlEOzCLBPEVPS/Z1d3xC7CGU49O7MLcNfsBTh7YCK+zwSVrwHu34/9dOkiYBq30P
 rn6zqAO+Eaeq02NWpekkgQJIjmQ+eIMPd6ZrUML8gQfBwoMFpb1H5C1GibncxCgD63iz/Goxi
 2bM8ftjLpXbkN1EZwrM2aNPsHeixy1nFKLhKS1uBBjRimtGpuf+rvLSasHdINi4ZyU9tnBJyQ
 ++Pe4w/SVl2x4XUUJBRrJf8IUnZJxWjZLL6UJna9lJ6Ob/n1X2N37uF6g9MkOUEdFxWSQMhOa
 QER5EFmXA2QgkyzDPgPWUGfYSvVupv5yf/g+9m/RKSt0LVG4DHduVkaT1uykTF9Y98zTpYu9i
 0x5RU3W6WAcj6oiHQEgBwKJlVOnqm+qeRJXabdAOi2ahkBrOCS2I4ZgLmBhom3E3ESrsGk2jS
 rSqtoVlziJ6N1+o0cKOZEzIRNE9yAuuC8ffddl1S2icQ1J9IyFfDUDtx0pWjBHnIUXqpzZOab
 QTWaQqX8HQEuKeqiHeOdRPmCL2+rXVKf6ZgoubJPMljLNFzVXKlEiNKdDnQ9FEk1NnaC6JfB7
 UU4oQG00WfruoF9/5d/B5mWMsyC8Qci+pKHi+3pKJ03thNc1CIubul8o0a5wczTnkLv1/2YBZ
 pNMFj6QTFP+2jlXGTTlPDtHU76E527C2ywQvt+PHkdinM+Zoco7mzoB8mrpn+gf56Hi2gIW0V
 kQprRP/TlPa7tZ+66QthDEQA9Ag8aH9EaAAVSzQa0Ux/O0StQDRsIiM/MVnWNlwmdI9tAZ4Bp
 nJsbh36JeyWR/w+hEM8Gg1rTXTvAH2h2H5TlbNxhLfSwByOi2sDIz9tq4zhWWcP6w7PpqHQmk
 QY3aYGvp+qcI/5XcTYKqA5/9GdLrVQBmITD
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 27 Sep 2021, Elijah Newren wrote:

> Sorry, one more thing...
>
> On Tue, Sep 14, 2021 at 7:39 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> ...
> > +               /* check if currently in enlistment root with src/ wor=
kdir */
> > +               strbuf_addstr(&path, "/src/.git");
> > +               if (is_git_directory(path.buf)) {
>
> ...and...
>
> > +               /* check if currently in workdir */
> > +               strbuf_addstr(&path, "/.git");
> > +               if (is_git_directory(path.buf)) {
>
> Do these two checks suggest that only a primary worktree can be
> enlisted with scalar?  (Is git-worktree generally incompatible?)

Good point! I think we'll need to use `is_nonbare_repository_dir()`
instead.

This also has the additional benefit of doing away with quite a bit of
`/.git` appending and undoing it. I.e. it simplifies the code
dramatically.

Ciao,
Dscho
