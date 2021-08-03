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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D373C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE1B604AC
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhHCW4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:56:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:50003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhHCW4j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 18:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628031386;
        bh=b8XLoM8dNjcSw/zLqcLFgd/4/naE/3kBRX/9QXHznh4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=f7tIdotpqdYBQ2ZdFDh58K0RvbQngOqr29engOSqtEIXKw2gpOURPVxbkUge1SCe9
         z63+aDPm43DyjmynkJNqjmW4xWsWv87BnRxj9kzbI4BsQuTrIe2HzVGs4tj+ND3wgX
         FpWSDVI1Al/8wUyP4qtpQR+l2A4IlRlasUe/D1i4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1mCz8S47bd-006scu; Wed, 04
 Aug 2021 00:56:26 +0200
Date:   Wed, 4 Aug 2021 00:56:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/10] merge-strategies.txt: do not imply using copy
 detection is desired
In-Reply-To: <5f974afe47ce46521f6c51484d1ebd59cd7339dd.1628004920.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108040056080.55@tvgsbejvaqbjf.bet>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com> <5f974afe47ce46521f6c51484d1ebd59cd7339dd.1628004920.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7u6cTDUOZkNuUmUEEPj0MmolA6/BgwabhuiwGgOd9pr6QvqNGSS
 Uxe42128bZrFgjZ9PXvMoXovn9SMCZErAPEQzyefZSnLfRRP11xYYoujG7e56Idc9KrF1h/
 M7u6UNtjJLVjBVzvZj8/gBvLoUF2xGn+xU3jRfuOkhBnP2LxHMacO0bH0TcGR9xz2XBwYxD
 naPfKzueA+NmvtB6CS/TQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KKbrYw7Jqao=:DrONClFmr5Zr6nyemeiBsN
 5jf5beI6Fb+fbU6RWkFoost5fMmXAnu0ZgVsET439y5AENEcyPoI87oQHBJfGDWDTzZLnQC0p
 AMFBxpdCrYa3YWQKDpq2yis9Mk2fnCPLr5y2bnJohegI3McBpX2UivFvNgbDyV/mllFD0ujYn
 193knMZgOjXLsO3gJf6pTGhalxFDPs6nJYrJhOhFeEcwqcyQ6PbhrqeVJ2ofuXcohYgAXd6F8
 jStHZYsaLrLbmLetzoBIoO/gZZ8soPZSFv2jmvAKZbbs63+OUqXAA3xOzSuATxFwBKK3qUulC
 jJc8rEwZsXtJikP8ImcVEFb9TBvET36FH8A4GskMPqe1H9rYyyerBFDvxdO1LLCJ34qLH5odu
 d+qK7xfWpFBehEo+nHPixHCqyEY4Fk8c3wbOmN3zst/rzSobW3wK7qbboe6gOj16N/rNTS1fT
 Y7btxUtlUJgYMgi2kryrkFOjgHwJWMZ8jHKSLSfAVNUCu4g4X4fAlU1NHzIrruESw+Ef8NEfr
 RQ9AIHjGDGCjE/A2NJ4MZj4mAIlE/DY/Bt3z2/53him8MiUMqBsSCslujm6fOFIiBPSAhtGRP
 ud49J5ar0bvjZUPELgwRQKcg7I622h58NSdCjSjzMcRD3fbsgMJaIU+E6k+zTNL1T/BAhi+pk
 qDX2uPM9tfRBqHjGFjQYVsvnDybSJRBVb0wIYk/XAhB4bFivZTRSN4jvVpWS6oB9sCZRTi83Z
 owGZBeP5jP6UzmAefmypZWlJd/zEW6tBAFc8uFE+qG79EgVCLuV7fBExoCpBeZ7+HbgDYjO52
 CGEKMqzEo1kD0Y8rxY7UtAJHJORqQDGIHSd7zxc7CLCEQ7SZZXmBO9USCTBdVYbveA1PIK9A9
 5C2vZJ0iDYAd5gHdw9YZUnrwqkszx881Zc895sg2R24+zj8C+IgjiA/XEtBh5psRN0eDjB8lw
 m8joImXzaHhrmyktt66RFogSpkIDUoX/zfgOtUnBX5CWD2xwN/V6nzu7MIPxikHQ6SZyrcoy3
 eWbvYC+GMuuokyl+Drx7LqR5Gy32dbErzIDRPEjn/3UgVOHo+4Daf2QoO4GT0rcexe2rnR6Wq
 zCh3axe/mCELxhu3X5zSw6AhaC/k9kQWA0ckAcg2QO601m8qnqdzAmJlw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 3 Aug 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Stating that the recursive strategy "currently cannot make use of
> detected copies" implies that this is a technical shortcoming of the
> current algorithm.  I disagree with that.  I don't see how copies could
> possibly be used in a sane fashion in a merge algorithm -- would we
> propagate changes in one file on one side of history to each copy of
> that file when merging?  That makes no sense to me.  I cannot think of
> anything else that would make sense either.  Change the wording to
> simply state that we ignore any copies.

FWIW I fully agree with this reasoning.

Ciao,
Dscho

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/merge-strategies.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-st=
rategies.txt
> index 6b6017e1cc8..bc82799365a 100644
> --- a/Documentation/merge-strategies.txt
> +++ b/Documentation/merge-strategies.txt
> @@ -16,9 +16,9 @@ recursive::
>  	causing mismerges by tests done on actual merge commits
>  	taken from Linux 2.6 kernel development history.
>  	Additionally this can detect and handle merges involving
> -	renames, but currently cannot make use of detected
> -	copies.  This is the default merge strategy when pulling
> -	or merging one branch.
> +	renames.  It does not make use of detected copies.  This
> +	is the default merge strategy when pulling or merging one
> +	branch.
>  +
>  The 'recursive' strategy can take the following options:
>
> --
> gitgitgadget
>
>
