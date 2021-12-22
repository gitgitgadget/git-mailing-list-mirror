Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793E2C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 16:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbhLVQUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 11:20:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:56777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241647AbhLVQUO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 11:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640190001;
        bh=Loaykws5d97VttjlpAC5SrHonbE4PhRYePajirndHUc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KqsFaGqmAQO6uWckbg2iQd7ED8ED/+qYK1Vr4r237xWw9u/a7AUVNwnIQylr0sldf
         BEA3q3hT2gUiiBL4xfd9cJCAd6IV1Ef3g05ybbQNDP0GVEhRWUlZZaS0m5nuWExUZW
         FmJr2NeXaTLW7ow7vURViZHlKMUmr2goN60BTdQs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.215.174]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Fs-1memXe3uf0-00oCan; Wed, 22
 Dec 2021 17:20:01 +0100
Date:   Wed, 22 Dec 2021 17:19:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Erik Cervin Edin <erik@cervined.in>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Sean Allred <allred.sean@gmail.com>,
        git@vger.kernel.org
Subject: Re: Custom subcommand help handlers
In-Reply-To: <xmqqa6guub9n.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2112221717440.347@tvgsbejvaqbjf.bet>
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>        <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com>        <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>        <YcEJtOknDjSgxK5j@camp.crustytoothpaste.net>
 <xmqqa6guub9n.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gAg1CDQYqkGh911cY4oixu0gRU3ZFcSQVLP86mFC4UrRSJjRZF8
 zcAqNkUevZP2RCQ04TN81VNZnqpqq2zrYLw66Rn8w1mlULmtJuj5zNSVfEp5PXMjsW3A6Nr
 LL5n9/J4ylFxDLUVyDwPbg7PyHhkYzBvQnH1I/R6DRol8QFPsDiAZeBSlXqHCFr916ZkKg+
 GL28/kLqNd1oUGM6AriBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bPueS1ANz9w=:fWQVbZs53orD2vxk8NtXAK
 8owyrdOM5T3rADiYxfXqekbcaYu3OOADGvELrXAwcv7zMxxLLsgLvSFSF13G57bPVHyxlhmuy
 CZFHJVO2Cr2W5O+ck/OjBI0G/qRTBUCkfwfLtGW5/Aw7lDSylCU1ZN6zWe2UFXFfPwWPsAGG+
 6zdneFvUJfKC+gPLZRIxz2Cy8jzfTAEyhhcyz+jiCy7cuuHwsIulWfSAq2RuFghxEHVHAFtkv
 JuI5DSzR4WzoHij3A721w1e6bzJxDcyWQAkyU5M3K8IlciCPzAfA7XgYhB09XM8maEi8bNRgY
 t1tUpxsUGQBcM2EV11fEO0bsKyGjmlOtXmZm3JnpWJ5c3qOk1Na28gpZBxn67bLSqsxPd67hz
 vqcns8wSD7qGs0yuuLnnNMQgaVGCi3tsPOUnpmZrgzG9xtOv3PTjdaQduI80mIXOxl3naArUc
 h7Lk31+VBM3pfE8v3Hy3iZs3Ab010QHkqPrVoYCvGUl5Gc9q0VgX1Vp1tXyVQyQrA5MrqV5J7
 Jv3V7iTFN8crD0jpAvtlwqf3t20C+N0o0OLRvs05tsyEYLF2HPfJ7QGyzwXFrytrl+U7dX4sj
 vuOT/fPpVE5x6Kq4V7Kri798Uqsa6ObuJ3qO2Wk0JW7PZ0b3Fv5+uKFTeungMYoIxYt28OjLq
 4oOs98q6z/q+ViQNbPHFZN32qsDA5+rVLKixbYYfvWkCCNDWfRDLZ49F+lkEwB1QbbkC0M05g
 mzs84vs97EbgFi6GuHh9dZ4BRFAhleW6PXssoqODiRr42QQ/jm1PMdKv0ChHuCcW4to7MHbBs
 Xyp9mB/TuV4YtG3RcHTVFyBKCQZ8Gf+JbZGPTtA8CpFTsFt+3tAOdeIGUlklnBlulJZ1RmiOB
 fJet0d9D/k/ooDURX9mLD4kgkTfCqt482o5i1yL9Wqh61VwiAabN5e1BJJeVOwWula01bDT9H
 lEFAaiH9tAs7jEs6+mVuvkjQOSNoEB9baRPLmObsP7PYnR7NgrTgE1dhm8t9dGUEO9wUsIVec
 ECws1IoL5oGRn9RBLKho0OUi0B8y/8jAvFh4FGQeoR8xXJQsSKEeZKETf5Xyf+yVGRnpUFiqJ
 mBnw+QxfbECx6E=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 20 Dec 2021, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > I should point out that in most cases on Unix, it _is_ expected that y=
ou
> > install your manual pages into the same place as everyone else, so in
> > this case, installing the HTML documentation alongside Git's may be th=
e
> > best solution.
>
> Yup, that sounds like the most sensible way to do things.

So what about `~/bin/git-my-reply-to-junio`? Do we expect people to write
a manual page and install it into `~/man/man1` and for `man` to pick that
up?

In other words: I think you're trying to make the problem sound less
complex than it is.

Ciao,
Dscho
