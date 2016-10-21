Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5963820986
	for <e@80x24.org>; Fri, 21 Oct 2016 11:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755112AbcJULAd (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 07:00:33 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38729 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754307AbcJULAc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 07:00:32 -0400
Received: by mail-it0-f44.google.com with SMTP id 66so151843611itl.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 04:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TdGH16JmVQLXpsncbYTix+rAwEo5jyJ1z3zleV1goT4=;
        b=nBBGP2C06+0/25K9OOAjMBqXZ+h4gUNJQbI2amlvXtHBX4l5bRwbmuaE+rKKTHkVli
         atOb9HQ/Ad4w0METjsz2Vf7QpMdNXGvTAAP1KtkRLhgX4o0prKeqcprO9lEOaY/kWC9p
         hNympiTaSGlqc3g+MmsjDla/LR91V5THtgTfrDyrlF4nFIZnOCqg2SoHCC6Ys46lTpeF
         GPvS/dwKMBtpBmVomuqksGyyyTbIa7rpLjzfoYQehra4AAEgcdxfK3DYrn/afxsulZel
         W7BUuuu9z8v+3XjQIvU27jozNpftVrAX1vbk/E7kBZJDiooAowGeCOFpN140KMJmSIj7
         RvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TdGH16JmVQLXpsncbYTix+rAwEo5jyJ1z3zleV1goT4=;
        b=coCUo7fqaO7Wa5n9zg/mboaL1EdBYRHOPImN2H3JfEjScepo96q9Pqh1dqVsav0HOC
         cBw/kEc3OZZvod/zTotyzgJYbVOg/Z76LZ0Up+oRMbebNjDVT0oh3IV4zKqj6bjWmhkB
         MRI3S6e9NIwK2PCLtwzHAh/aKjD6OP7mpRZCqrWHJ1c54kO3eja0KU46750Ui0O3WoLM
         WABKTICeyQJyKZaGJUd4GNWosBEVVPGPnkiw9jf+ldVE/dGIl8fowMWX5l5PXjQJ272x
         +5kMaMp+18syhbpVP1VK4IjpgPeEGzWW1IvUn7gfY5MX8mqDVSbWwAjvLRkqVa4mdgoi
         nrjw==
X-Gm-Message-State: ABUngvf8zZ87HSl+CEtTDr28yu2aUUgT1ge9mExXTm3niMUDpYQiQkxzoDq2EX5qNL1IiJJRgGESQKwzuk0M5w==
X-Received: by 10.107.44.17 with SMTP id s17mr230454ios.212.1477047624470;
 Fri, 21 Oct 2016 04:00:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Fri, 21 Oct 2016 03:59:53 -0700 (PDT)
In-Reply-To: <e0e320ce-14a1-b4a8-aa07-6bc4f3c4a424@web.de>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <CACsJy8ALRjnvgM6sW5ioFHtquSR6zgQHkQ6-LUnKFnqXV9eDCQ@mail.gmail.com> <e0e320ce-14a1-b4a8-aa07-6bc4f3c4a424@web.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Oct 2016 17:59:53 +0700
Message-ID: <CACsJy8D-o8BeaV1jrL7ADXgVwJ=KwnBCHTCN_fuCGvS1VVpU6A@mail.gmail.com>
Subject: Re: Drastic jump in the time required for the test suite
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 11:40 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 20.10.2016 um 13:02 schrieb Duy Nguyen:
>> On Wed, Oct 19, 2016 at 4:18 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> Hi Junio,
>>>
>>> I know you are a fan of testing things thoroughly in the test suite, bu=
t I
>>> have to say that it is getting out of hand, in particular due to our
>>> over-use of shell script idioms (which really only run fast on Linux, n=
ot
>>> a good idea for a portable software).
>>>
>>> My builds of `pu` now time out, after running for 3h straight in the VM
>>> dedicated to perform the daily routine of building and testing the git.=
git
>>> branches in Git for Windows' SDK. For comparison, `next` passes build &
>>> tests in 2.6h. That is quite the jump.
>>
>> I'm just curious, will running git.exe from WSL [1] help speed things
>> up a bit (or, hopefully, a lot)? I'm assuming that shell's speed in
>> WSL is quite fast.
>>
>> I'm pretty sure the test suite would need some adaptation, but if the
>> speedup is significant, maybe it's worth spending time on.
>>
>> [1] https://news.ycombinator.com/item?id=3D12748395
>
> I get this on WSL with prove -j8:
>
> Files=3D750, Tests=3D13657, 906 wallclock secs ( 8.51 usr 17.17 sys + 282=
.62 cusr 3731.85 csys =3D 4040.15 CPU)
>
> And this for a run on Debian inside a Hyper-V VM on the same system:
>
> Files=3D759, Tests=3D13895, 99 wallclock secs ( 4.81 usr  1.06 sys + 39.7=
0 cusr 25.82 csys =3D 71.39 CPU)
>
> All tests pass on master.

Thank you for doing this. 10 times slower is probably not worth
following up (though absolute numbers still look amazing, you have
some beefy machine there).
--=20
Duy
