Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08784C4363C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 20:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C353F23A5D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 20:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Yyv2WMWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgIUU7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:59:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:59777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgIUU7F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 16:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600721931;
        bh=X2h/Hc8NZ+lZq0gzC28kZHoaDAX3JJeGnDO4bI0yIMY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Yyv2WMWqhE/UddGxYHhKB5St8vEi8dPPA5CizjMP7xEEYaQRibcjrxYiIrdNuhdqI
         d/d240og1kYXd7fYadp3IzkrWKMFB/FWwIt34NAc3Jl+6BvA4Be44M+NmMSg9Xfmqf
         kKtqe05BvHsiu757nFOR0G8d95FXnXZydco/25wU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.93]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLR1V-1k3DIG2FXP-00ITJP; Mon, 21
 Sep 2020 22:58:51 +0200
Date:   Sun, 20 Sep 2020 17:43:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/5] t3200: avoid variations of the `master` branch
 name
In-Reply-To: <20200916223950.GA1207950@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2009201739250.5061@tvgsbejvaqbjf.bet>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com> <2f1d0a2df41f567bc1a8bc446c26e1cb8b6dc36c.1600279853.git.gitgitgadget@gmail.com> <20200916211150.GA617237@coredump.intra.peff.net> <xmqqft7huzju.fsf@gitster.c.googlers.com>
 <20200916223950.GA1207950@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VylP3Ecz4j+25tJtPzs2Y9bfFTXUcj3eqy8MdeMzL8VwBctOqEi
 rFCsGKaZKMAeoROLGAkd4E1R5gLnxJH+AH+2vfUGXW75rPWLr5vhV5gBTsc5gDBw0yxhD7D
 HSB4EkkoDZrZX+TYjtDcKsq2oYunWFvJVtQ4SW4hwhgevUH7PLtsnI4JeRqBVpN3yK3P0a/
 npxo2fk5cOzlyKUyOUsew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pAADCHwK8eo=:CzajHLC8RsQyHVM9VFPDN3
 BmFA+eUaP7TjHfxuBS1A2cvNyyRFM5LYvx7tXIYKtTUjnvZkqw2pBozz0+nH7ixS3jbh+a3az
 LcQL9AEP3HmyiFf+gyKBzL2aaitWlj+h1bXZJ9b0K8QlQDhdmnO9AsrGnWvgLKyDwQ1oQ3fc9
 iXMlwsh/km7WMIUG8F4L4OAkOG/1gfRYxqaOYNus/KsdTuy2DvU3WXstzNGh/i9ehwSvwqOBv
 v818zaeVZgtKjFv93nQCjqxVSBYP70r8N/dXfp3A7bZGf6jLdl9asmuzsOTXnHtX5JQNxNjKL
 i/CVcaRF/8p5Hx7H9QCABGJDRZ77C//Bi+F+4UMYdOta3bPiPxb51BSBHcu+Z4xlgqVho8TQa
 e+DgX/M/n3aIAGix2x+j+WdN2fqvNKaFZfQcaDKazmYkojaXUvlZkcWx4d22tGWqftjUFsjpf
 bPZHBzYYX/Tiqo87gNcTgeg96WYpiuWF6gcPO/59LwDTpRPVR3TbU/cNWtCMTfBpTqY1U7mCE
 IZXdZ7C3F3V6SZjsQL83X5Eyc0GhLsIuXdjXbHetrDaPVY3ynRzC0LV72TZxdj6fhxQK2w/3O
 lgheaNNT4iImzUmLC8n1xBSQufUf+tqG0cFQaa8YZjRS3cs88OhxOlrj2ultXJjz1Ycj3yiwh
 Ig6CZlTrOhEDu7V0Q53i6U0TwnWB6s7oGfeZLNMlpQqHQenmBwTMZDAdEuiPQqDCh3hkOBcLt
 +Bo1GzSd3XfBZ3utSBHH0PTz9aSDd2VLERphe0/k3eVBOhIOs3bKalJK8wuDkr4wrYPm+JAhr
 pg4gEyvfae/4fhRAlkdQ2hZnSG0ijoeVJqUxEM7Q4qEwrcweG/yJsdkeGTGizc3OyVBXrEg/B
 ZJpjGCel0dUKmbCY5vGP0CrbqBxsjB2xOQBPoY7JmFbGnMdjXTA7e7GbwtTn7ZE3WT0M4vrki
 q8oR4V67hlBc7mGADABHU7xtYWbRIdOS4gmbWpF+9q+xCTT8uYClQDyqWEiX38Nl2uaSdIyQ8
 YcYhurFCuZjnmyCN7AVgZp7h05ZikiR4EFOFU4EXRHK1ZNkghY3dcI5zYIOjQ2SCCm3gZEwDv
 fWE9/Vzlk3z8ZDMym1R28d+KiRa5EDorRtkXtw5wpXBjrffD8OfVZpss1obE7aMWxYRVx/JI1
 hCfuujZZ0zDCtj9TIESnoVSVqFZjJx9kQiTQMegMEX2SsFcvjGfCqwOtwRizL9YSOMpc9ZXqA
 UwcS2iYnmZ5vSltIIPQD4b+DZTGfrRapE2JIUFQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Peff,

On Wed, 16 Sep 2020, Jeff King wrote:

> On Wed, Sep 16, 2020 at 03:28:21PM -0700, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > I'm on the fence on whether this matters. It's a temporary
> > > inconsistency, assuming we eventually move to "main" as the default.
> > > We _could_ push this change off to that patch, too, but it does make
> > > it more noisy.
> >
> > Another way to handle this is perhaps to teach test-lib.sh a way to
> > tell it that we want to live in the world where the initial default
> > branch name is 'main' and use that at the beginning of these select
> > test scripts like t3200.  Then we can do three related things in a
> > single patch to t3200, which are:
> >
> >  - Declare that any "git init" in this test (including the initial
> >    one) uses 'main' as the default branch name;
> >
> >  - rename 'master' used in the test to 'main'
> >
> >  - rename 'master2' used in the test to 'main2'
> >
> > and it would eliminate the awkwardness.
> >
> > The change to test-lib.sh would likely to use init.defaultBranch
> > which also would be a good thing.
>
> Yeah, I'd be perfectly happy with that.

I do want to introduce something like that in the patch series after the
next one.

However, in this instance, I think it makes more sense to use a separate
name altogether. I settled for using `topic` instead of `main2`, and
`new-topic` instead of `main3` locally.

Ciao,
Dscho
