Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862BCC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 11:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhLHLTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 06:19:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:41193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhLHLTb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 06:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638962145;
        bh=FF+kOphi/i/CtKATbLa8pnu9g3cv0FEKVKdi2/DNvLM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZU35OS2Do+0la5ycM9cNSp1+CBUrVel/olCt5y3GexbAxJblWDlAw79TItfoJOAYD
         ru9yHgetR0MqZj2ViXc3ag3PPxmLh4VExl00RpSUPhFtgB/vHd4D2v7yom9DMhxlRk
         NfGZ8UAUhybCOOEnNZ2LoNigGtqt18SYLJacAOcc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([89.1.212.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIwzA-1nFLBq3OKg-00KPhP; Wed, 08
 Dec 2021 12:15:44 +0100
Date:   Wed, 8 Dec 2021 12:15:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v10 00/15] Upstreaming the Scalar command
In-Reply-To: <xmqq4k7nmksi.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2112081207320.90@tvgsbejvaqbjf.bet>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com> <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com> <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com> <xmqq4k7nmksi.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Z1xSE2kpvZ7GatjhJHuo8ZGrdNRzAfkLJLhHaVPtZIhJ2ijSqZD
 mOby7/jc6nXmkuNekFONAecF3okuvVRkOiOncS2B3bQ2SWHciH8yw81xfNaBf6wvnpc+w3N
 iGNPlIxB/xXIRqvgoZ1OhLYt/50i7xYv3jWtxqC43eoF/FJ2wRlieTc6hsF54ZXJjZhEzsy
 dvEwB7mivdJWnYLKpW/Dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O8G+QwHPYXs=:F0x+dZhXI/ZtrkXNqaOFI/
 /wsKDan3CxeRog7n7XqwcazKYXLKcODHGdLkOKesa6fRAuvxTYB97/k8v+Ufqwq8y4+iHRrao
 AJ+8kzZW7SkPlpGjUfNsD+NrDH5xzZ9fjgpZYXrnO5L1uIndyMMvqSHiB9G1AAXjv5MbbgaHG
 LxYf6zgV9jqlP6WqlkvUk5juZXBkajylZfU9t6G05RctxetcpMlAyHarDY/sPvjWZG7rLRwgG
 GFvECJynD1dh1vxrOCX7w8GbCDqEUFrJ3PfGQDewducXs6h5afSg6aHdsqReIQ4qqtN7Xk0Fx
 ZX3NfBEDOd/bkjs1PKwtGkEZErTxD4oQZdtbPROAxVSZZ/5HpO+Jf+5+F0wHeOVTa6RPIfHco
 noauh2TuptC/ZshjObiKS9QBcaxhJg5uxDoLlTPRElM9j/Mt4LMWevvayF2fUkb3jNBjvioTb
 uUX9SqTc6+q1aHH5sSYq7MzVU3kORcRaZXr9InBlDhNIJMpsXhcR+ZGJ787A31zB5vZm5j9XA
 M/ySVdpcq3uQlwuWBZHwC0e76meBDPpknnfb4RrPUQzDr0UiLOTRZPYd0iYATHiQOzIn2ep/J
 bIJU2OgT1iYjp1ItnBIWPEJWBfZKVXNgCj7MtfDBckH362570TGNgEE4axB7EqwF78+kHbFfq
 tYMAQ2BlXtWnp3tatHi2nbMrr8c6h40mcUhy23zWNe0NaAnPj57MdzQWUEFoEHwi7UiYPOx8P
 ahv4limCKrLkK8bTjANl5LzFjg/NeCI24XK0r86VnQuQmWUwjOx2vMrmrOydKLcolRdIlJCSn
 86C0dOUIYwSyjYnpYHPsrVxN5VhqXPxS0LeHvEqV4rQsJVT9UA2jMHI8FasUxyE81S2EJcZHz
 M7pcF6qXVER6rAMU/n6TbVnCQbWOFV78zKRvntgfhYxbjE15Q4ajZbgOF3rPcLFtyXN1igXQ1
 eu4Srd7b3TCEiafwzyfGLa5EyNv9UEPOULhZs690aY+VV7fjz+hCybozxLM5ALPsUTPjH4Z3d
 KN2Y58k3mN6f1fCy9rBKSTSX5KFc0ln+y9RdB01ovU9q/dw1w97rBKjtkSPPN00FpSxQQbHTl
 tBIwzCpEzUjYrM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 5 Dec 2021, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
>
> > From your wording it sounds like the plan might not include moving
> > these tests over.  Perhaps it doesn't make sense to move them all
> > over, but since they've caught problems in both Scalar and core Git,
> > it would be nice to see many of those tests come to Git as well as
> > part of a future follow on series.
>
> Yeah, we may be initially queuing this without tests for expediency,
> but a production code cannot go forever without CI tests to ensure
> continued code health.  People make changes in other parts of the
> system Scalar may depend on and unknowingly break some assumption
> Scalar makes on it.

The Scalar Functional Tests were designed with Azure Repos in mind, i.e.
they specifically verify that the `gvfs-helper` (emulating Partial Clone
using the predecessor of Partial Clone, the GVFS protocol) manages to
access the repositories in the intended way.

I do not know off-hand how entangled the GVFS part is in the test suite,
but from what I recall, every single test starts with cloning a test
repository. From Azure Repos. Using the `gvfs-helper`.

Which means that the `gvfs-helper` would need to be upstreamed and be
maintained in the git.git repository proper.

Previously I was under the impression that that might be met with grumpy
rejection.

I do realize, though, that clarity of intention has been missing from this
mail thread all around, so let me ask point blank: Junio, do you want me
to include upstreaming `gvfs-helper` in the overall Scalar plan?

Ciao,
Dscho
