Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D91C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1480E60F24
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhKBPWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:22:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:55847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231437AbhKBPWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635866411;
        bh=A8rzlOuRffRDxYqtxL4Mvf/lViMNeksd4P9OXGLrjKo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LxsEVtMqaOsskMURaIwhr1pukc6TbNwj/dUee3ypENrXcxGvEuddADmSwqP2Yh8sG
         Y9Jm1JTUVOaPF7I6CmEWk7UB9zi61EerLr/1PsTPBYXMM10RrfEjOEZu0N8Fmy+Gku
         7EeESsIwHNC6qdRrhMFix9+upzNAwjTx21ImEgcU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.29]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79uI-1mgv1b1Zxk-017RxL; Tue, 02
 Nov 2021 16:20:11 +0100
Date:   Tue, 2 Nov 2021 16:20:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        vtbassmatt@gmail.com
Subject: Re: [PATCH 1/3] test-lib: add prerequisite for 64-bit platforms
In-Reply-To: <xmqqee84pyfb.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111021619020.56@tvgsbejvaqbjf.bet>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com> <20211028205649.84036-1-carenas@gmail.com> <20211028205649.84036-2-carenas@gmail.com> <nycvar.QRO.7.76.6.2110282344330.56@tvgsbejvaqbjf.bet> <CAPUEspj2B7M_-cbA2O3LickF7MeVYNtXjfJMBMeYkLag5K=Z3g@mail.gmail.com>
 <xmqqee84pyfb.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:urR/ljm6o+SmklT5pKuw62IiRPjbjC5ThL7S3M0ck+oFsSyV084
 A6KOLYnlzhU8jeFWYA7X49a2C4KD2W6HprSxD3gVgGXUQhqeo6B88+eP2mFyLzCc29SELPL
 DTW82MAUGmjNWjaCvNxxbjOLGuq0yQK4AoGLMdoV9BaJv/OUChk9o3fluq5ORhHQAzgl3ix
 9Pw34JXYPNaqeM9QrO25Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1J9flrWwPig=:lMAYGyFisWij6l9A1c7CxX
 rAD3ALVYG47ZU7jxIAT3dKgQ4qb4sN98+8DVMaTySyezqOhUpPb4DCXd8L5dPRKRFAG9C1mA1
 FVMIbMZa3igFYaKEaw71r3exBWV26NY+jOFcRrMMkx9P3BTKWY4DLaeiuOg9i22/eQgUlxN0j
 +Wd2jQq/MVOR64W95aPwUD9V+w4lWEbZMboYH4tCyc54Vmsz2bxWvGmsWg933oQ9+8Zeu4iLN
 20mw44ABqSaDNxkKJg7wOAT+IAimB6RcksrtxpuOM1MYwJfn5yqrb9xPu/+ieTwsMsMJVDZQ6
 c+9KFxZws0BqkrEEvWzt9sCA4Fj0o8hBkdYN6Hyng0vjw6CzRtA5c3g3WqyIB1IQuRAdT9j1d
 HauZGoiDz3MgMxIB05STnOMx3+tI1yataThWEGcpP/Qe3ntRfIBcnh7t5shq5XPg4eqP5UhLi
 SKc8s8dhX/kvM8SXud/hwTwBf520f3hP68WtEO/01sH/Qol3jlUxN2JLyFa+tL7G/9LSSTc6A
 Wzt7hSzA2/ziK0qq+1BhTVjZG19w+kXLQ5BgjFztwOv4BQ+I6UehEU0DJ7KDzt7MqLo/zJ6Fu
 Rj1VMdj9LXJvCC+NtLQo4uoL8hmXusIyqYLfHhMKV8SJ1W7/228oDb1aFj6azbhGi1KFnFpic
 VNCwxpYYPCjQS7IkC3H2p+nQrxgZVlMpsZ1DZI6RS5d1Z0kTc5qrLF0uLIFHnFZ5t+414Rx5n
 V7LWhuLQql3MHIcW9oRaZ5pitJM0+kjQ4CxapxYutpdwLVaunI/YhZ+ydJLhT64q3uN0UAUHj
 ZP9Tj7r/54fdYb971URzm3e3/aZbWvxItjI8IUvjHAYvkAU0rbf6GJClSkeJvs7LsI8+D9o3o
 UiRUCyqp/gbGx21+k6IhRd2F/fEYkR7bTQcA5GK6DyQoSv21TRu6wv6+mqey9hieSwVYO3Bcs
 k4z6oMz/0MoiqBh1Dzp5TksOtvylPLpsG0vRSvtCvRMo/kQU8PHS3Glv0uu/092DkGeX4TFAP
 rXlzVwQNp4S2iZ1j/j6cH5+TlM7RxdwKzVhRW+JkSXZxUKLTIJyFgIRwaa6VOobx/HDRgBe4v
 3yXaGquJwvZHaw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 28 Oct 2021, Junio C Hamano wrote:

> Carlo Arenas <carenas@gmail.com> writes:
>
> >> Since this is clearly copied from `LONG_IS_64BIT`, why the change fro=
m
> >> `-le` to `-eq`? It is at least inconsistent to use anything different
> >> here.
> >
> > My assumption is that the check for sizeof(size_t) we have is really
> > about finding the bit width of the platform, and we currently support
> > 2 of them (32-bit and 64-bit), which is why the name I chose was
> > "IS_64BIT" and also why I was strict on it being exactly 8 bytes
> > (considering all platforms git supports have bytes with 8 bits).
> >
> > It can go eitherway IMHO, and your point about being inconsistent
> > (with my lack of explanation in the commit) suggests we should instead
> > use your proposal, do you want me to resend or could adjust them in
> > your tree?
>
> Is LONG_IS_64BIT used to ensure that long is _at least_ 64 bit?  If
> so, perhaps its name may need to be rethought.  On the other hand,
> if it is meant to ensure that long is exactly 64 bit, then it should
> use -eq to compare.

`LONG_IS_64BIT` is used by the `tar` tests to ensure that `long` can
represent file sizes larger than 4GB. So yeah, it is an `_AT_LEAST_`
instead of an `_IS_`.

Not -rc material, though.

Ciao,
Dscho
