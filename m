Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4749FC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 07:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242D161037
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 07:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhJHHxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 03:53:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:51257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhJHHxl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 03:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633679497;
        bh=d/qAnv2h+hLGOoz5GhuDIeOqTrjTmjWEM7jTukSdZSo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OADeoR7v8s61Yv6xr2s4mkUCpmDo9Sd0lmXq9ZQCg2gza+RWjH+3tkE2BNZeHtRhZ
         8gZgZhbYd6/+xggQZV/1FJxjNq8ziuBLZol/Tq/7vLm9HxH2JbeTxb1i5iJF4DXA9U
         4l5+j91O2Mt/wygLjm/iiA5Kf1PGhRsYWiFDFAsA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.23.42] ([195.63.203.190]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1n8a8543O1-00q9su; Fri, 08
 Oct 2021 09:51:37 +0200
Date:   Fri, 8 Oct 2021 09:51:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
In-Reply-To: <YV/BMkZrj4xQyvUL@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2110080946060.395@tvgsbejvaqbjf.bet>
References: <xmqqfstdr8b5.fsf@gitster.g> <YV5aaD418SyZqS/1@coredump.intra.peff.net> <YV5dmkkuCqAY2qqG@coredump.intra.peff.net> <YV5yi+AejPGO9qOi@nand.local> <YV/BMkZrj4xQyvUL@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Pgy7fIheaCaTos68k/cU30OI04Hyc7fILRnsBbWVjbD8GBvQZ0j
 PUyY2dIdf6pqEYptYOUsyU+fmQ0O8RFtrkQw71avmlZd6s3/o2sb+7AIUUJdK0Bbiyxjjog
 AmP+0VUoSxQhSN3gBPPk4EMh4AOmsqsfIVSUPN7M2//UbLHY6xEFSwlZzad1llFjKh044cn
 5Kxp0mlU8kbIZyomqRxdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:02f+HBh1z3A=:dmWxf9u5Mx6fXLRwVj8XII
 zLOmFzyeLVO8fNKgBRRFB1M6NztsBzwfIa0gwh7cQ7z8E9TJg1WS7wEpv3HvLwuVll2wG7tta
 UaRY0lHm+i/og9Bf+32ayzXS/FJ59r6vXLMq+5395Y1uQsUsS3+HekCjC1X3Fa84l0ls+CbSz
 qo5n3FO65VchquoTeIu8kpFcFFAikJBBQR2x+pjC8ynuOldSPayAQI0tB932lAMSbawwV8ctH
 j6acGyzDumvjJuycYtpw1jBhUMblrKpj3Y8iA4ceXlZfCoiHD/kZhmBnW2VpAR13FXI+PH/wV
 tpSYsxNMpJ5wAPQ3i66B6p8Y1kqj3i0fecC8E5l+L/t9rsdWOx4N7D3GcweZtMB5k4jkXE0Y4
 4Ds974voFBG5azfBjcG8qSgdX6Cp9wRWU2sjCq/AReaS0UmLMs/HrHAwyL0dJk6FscxlNdJH0
 9ocBNejSc/F/X9OzJIs/SPj5DqnBLt6JGDdcIaR4uTvpHk6fbgJEB/GyMmR82dlW+EXhhrF19
 LEHrg3Z68UgYoF3UHxrN1CInamzh3uMplbIqs31bECRxPYz/xQViwKJxLENIUKkcLopi0voQ/
 L7bxrBdqV0boqj8nKW5Icc0jV0VkZEIHYeOyGnTSTp0tQXCjQUhGhXmgt8RhvFM/mtaabHIJC
 8LfpsBQc+lfg1OPM6tT5hgFdZL+f0bq0b5Fm0OFRRke5KBLL2vZXLfhZBfbArMMR7Cz3OtNA4
 6ay2IA/2yXM8AVG5cufxu2926lPS77fSq/qtOnzHUW7Xro7uG2myWh+EPbSL9kTJvWk48OwSa
 rhgra7MqJqMVjJKhzyh/DdUEOhtvdH6rJiRYQhRtSoLEB+X59yH64cQ8IgxbCX7G6GgL47/HT
 uyjYYeNQdrImVeAV05sHbKBFkmIOD1NsYprFmF9Dw8fV8Q5Wq6JIgCXibZxnQylwy6oWnISGV
 pmzsb/DhD4mB4aLB///sjGQPPx6ZPAmKEtmkfdv/Oc4D49ZwtRgIu3jrUChKPFD2vYUjbBckr
 7JoRea+Ezz7ZEVx5aSmQT2eSujcFSl2yA4zNBpN/aMDuduAGp3Rt0GXVbvnAg0zGHvjZCy25w
 EBEg7+lwkTIXYA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff & Taylor,

On Thu, 7 Oct 2021, Jeff King wrote:

> On Thu, Oct 07, 2021 at 12:07:39AM -0400, Taylor Blau wrote:
>
> > On Wed, Oct 06, 2021 at 10:38:18PM -0400, Jeff King wrote:
> > > The reason for that is that I didn't find it by inspection; I've sta=
rted
> > > running my personal builds through coverity. It wasn't too bad to se=
t up
> > > with a GitHub Action, like so:
> > >
> > > [...]
> >
> > It looks like this would never cause the build to fail, but is merely
> > responsible for sending any warnings off to Coverity's UI?
>
> Sort of. They basically wrap the "make" invocation to intercept "cc". My
> understanding is that their faux-compiler is mostly about gathering data
> about the code. That gets stuffed into a tarball and uploaded to their
> servers, where the real analysis happens.
>
> It's very black-box, which I don't love. But in my experience it
> produces by far the most useful static-analysis output of any tool I've
> seen.

It is pretty black box, but I have to disagree that the static analysis
output is very useful. The majority are false positives about
strbuf/strvec type usage of a static, fixed-size array that is dynamically
replaced by a dynamically-allocated array. Coverity misses that subtlety
and reports out-of-bounds accesses.

Granted, I worked around those (I thought) by using the
`-DFLEX_ARRAY=3D65536` trick, but I guess that is either not working as
designed, or it stopped working at some stage.

FWIW I have set up an Azure Pipeline to keep Git for Windows' `main`
branch covered by Coverity:

https://dev.azure.com/git-for-windows/git/_build?definitionId=3D35

It essentially calls into this scripted code:
https://github.com/git-for-windows/build-extra/blob/4676f286a1ec830a5038b3=
2400808a353dc6c48d/please.sh#L1820-L1915

Ciao,
Dscho
