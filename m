Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DEF01F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 20:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbfJ1U4b (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 16:56:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:51855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbfJ1U4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 16:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572296183;
        bh=e45ue2lbi3Q7xrbHHQaN2JpPc8daE6FiJGOIhTBquvI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hbnfMaSa2Vuaff1ubT7ulqZPfd0nqIfQaEFYMM9aecpI0J7WyBPzTJbHN/JqcKSCX
         MHE7vbW5E2w/D5FSvdOJOBKHzE+X6y1pzgsT4z0xmEufj559Rg6nopJyQElGAjpBag
         lUR8nG1H62INoKPjHCvjrKfxQ6moXyCaeY7T0bEw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybKp-1i44de2ZxN-00yve2; Mon, 28
 Oct 2019 21:56:23 +0100
Date:   Mon, 28 Oct 2019 21:56:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix git stash with skip-worktree entries
In-Reply-To: <xmqqpniha9a8.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910282152080.46@tvgsbejvaqbjf.bet>
References: <pull.355.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910272203360.46@tvgsbejvaqbjf.bet> <xmqqpniha9a8.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s2Ps6PxTYWwTjUguc59b4tr1wY0jdsOo1dp5t5TrK5U0kjtB8lP
 7nQdGK4JVyoB1RZ6/w7auhKHZxuOGP+KNZ7/pURU0d1nFMzqu2DAABTktdbLGH5ixjZAQdj
 /bQ2TGJocB8trfGQUOmOrvgtirRfdoBOQqLa2n7edekdG2p4V5gXIzc4mSJFEfOB0PUuTXg
 bxafXhivE/fiWWxyE/noQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GblU3tybGuU=:nPm3F6ytd8blQ7jEJn743b
 exqJwtE3FtnkNWl67hnHkmFMgik7S1DlQJXUZVZJgKUOEAR23zEnjroprQn9S7gTxT3Fm1ttq
 IBv0+e5ttvkGrwhVgyAvIl1XnBL3NftwfbAU/dNbsbwg//VziRiorGT+JU001HpWStRAz5iG/
 D56QG+/zUoLaA+/+r+XZ5Fj2cEuJ3wOXhlsTzksswPdNlk8XliHsiCOp3jGBYHcIoMPlZAG2e
 rYUFfGJWbAtRsFNqMsbPcDZ5qMZAJprZu4GAydE4wOdFf+KZuv88o1dTPkWYFOpNIiq0zPKIb
 3EBinvOiAoxyEH65gjEoFoYL4k1Dp7kRzPe6hcGJ3bXj+aBqm0boErKVUiJxO5OTK4pT0ouGB
 jGdi7Xmtbg2KYb88skQvMh5Utv5AeL4+wIfS6qp8Pc8UfJGYWkn+VPL4wVOMymyiZKqA3DBnQ
 sX9PuQ6HOxpMhJo6/1mivYX8pIQ5DGTO6N+GMA/xGfZHZRMswP+7aoULoYq7U09RYOi54Mleq
 +6oylO5s7Y2oL3adBUtJQ7ttcsKKmqrUoX0U7y3fqbYEjmHsgm9sUr3ACwEKMjPgpP0lXgcez
 l3n3ew53l3qY7+pkank3gc/IsyLQE6w9oxvWOZBcxXueY2a6/f7Gmf4IwsumAqzyTs5mBO66w
 xsYQBtqOGcRyLSfIDra7KSJqwhM8dPuZaAnKZ5GTnRZeDCeM9Ui7qFJP4rldolk0jKb4oLVKo
 BgyAGleRJsDUUkZOk8EvgI9oBWaq2HfXxAvLLPT6yq5ceAuzagVW7WK+54i/haHv60gy4Hrwx
 OEjZh80KmVaQcx2FLqFXdnGD2qEIVLbajj1YAs1F7HqiIa3FSxtU/RIjsq76KmGFBBCAMKX/y
 2xuOi8GJzMg/Dsri/v6Wub1mzj/C5VquaRIrwtJcfhxthDKt1d2cboQ31PNYTjL9k+HDXSotP
 Mv+XOpU7nFgzmgQ887h2cX822CbjU6WwhI+nbTndpDYj8DLXWHcKZorHHuY3LuAZK03Zc0jGB
 Vc1vHQ3kGxAHWm9adAEhTbiVeBzgYFcC7JAVNHX/XTcPakL6TRj9DA9G3N/yjwXWqd19JTo1O
 FRljbhkB4begl5hlokU5FDCOZUviLi/l1MCvi9AQ+zddikY9CpiONslybNBxkFCpZjRQuccrI
 L2rVN7Ff0jRtEK9rGSx6lQWmwi268T1TC4IQFC9C/xrgWbU8W/TKx+9yC6kEx7XDqZmv6cBc4
 XOFl2JdUQrcn9JhcOSBFpo2CA4LY5xc0Nk2y0DlBPwTPNFaQzxLHNV/Hx2V0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Oct 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Thu, 26 Sep 2019, Johannes Schindelin via GitGitGadget wrote:
> >
> >> My colleague Dan Thompson reported a bug in a sparse checkout,
> >> where git stash (after resolving merge conflicts and then making up
> >> their mind to stash the changes instead of committing them) would
> >> "lose" files (and files that were not even in the sparse checkout's
> >> cone!).
> >
> > I only realized _now_ that this patch has not made it anywhere.
>
> Yeah, I do not recall seeing any of the patches in the topic (nor
> the cover letter).  It is not clear to me what "lose" above means,
> which is an indication that I didn't read the topic a month ago X-<.

Sorry, in this context, "to lose a file" means that a `git stash` would
record such a file as deleted. A subsequent `git stash apply` _would_
then delete it.

> Did it even get any review by skip worktree bit experts back then?

Sadly, it did not get any review back then...

Ciao,
Dscho
