Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47AA61F463
	for <e@80x24.org>; Thu, 26 Sep 2019 14:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfIZOUe (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 10:20:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46966 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfIZOUe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 10:20:34 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so6858256ioo.13
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDego3gEKzsT9wqnSmMH9L8M5RO9y2ff0Mpi/qeNHRk=;
        b=tb5wKVEWYqfbOKDBqNcH8f9I0BaWl+sj6XgDkJUWGKca/kv64n3pxHiU25x4sH+S4t
         wJ5TIdmqGQeYgwdZ3DRxI8xNf5m7xNGUqDTRzgy//+RFu4qWzThcVtmNj4Yx7Ao1K+9r
         LgDVKf1q+MFVuhyFCeJu4uyivXEYFW7eerxKq3iviK7ifslBpT+yTq4+oCqfcgG/cFUA
         FUNOnwr2RPjQdEG3HLiT12ow4j3hF2dfQO0HXjNpJKR4G/ccNCvjKdTcKKp4YpX7xQyB
         YnZVP1zDmlTP/9taEuDTYQP9AuTam7aGE+6hjNURCkGbgNCsPwZHazqXszOdEQou934b
         jL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDego3gEKzsT9wqnSmMH9L8M5RO9y2ff0Mpi/qeNHRk=;
        b=DSHTiW8vMVbkJNj4hlicw1d0oQ+Sp7M8mPtgIPKZwXuPFPe7abBr1OKsbjDWtQH9EK
         1Pn3Ds8A2YwlnW+oMNaGkIlmimx8vkGtKiLEyR0FcQ0y7l/2gMldt7CZTDfHf46wW5dz
         pjIH7fNZgtD5VgvocdX2Bj9ChVOki4uIwSoj19fPODx3VpJxRXBZ6eKOXpHpOVFTL+z+
         txvL9Mc/o9xV0R4PaafCJM66tFj+zTZCZelmK2TrK3C/H2XUmQOd4xmSa596yS2WHoSM
         2vljPIHFCTKy1pTq7z/oMNdAsexwJnlzm7KIsJ/4x+Kdj/70qr61+e0/khzwoAoSvMYr
         MVRQ==
X-Gm-Message-State: APjAAAUndaxTv/X/xbJahze/R69iwFjusI5KFUEQ2kWAteeu1NTVlpED
        zLb98/l8mIENN7QbA07YiZ55iNmV1DCRSZQRrdc=
X-Google-Smtp-Source: APXvYqzJGGftYk4PmIuqzlItBn996yDs2QQTjYw+A0c5uaYHkj5dqnPSv5mwiNx1JAuexsjQm8kXEXlnpu30otBZAwc=
X-Received: by 2002:a92:4994:: with SMTP id k20mr2552988ilg.159.1569507631725;
 Thu, 26 Sep 2019 07:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190520120636.GA12634@sigill.intra.peff.net> <20190520121301.GD11212@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905230858570.46@tvgsbejvaqbjf.bet> <20190524063955.GD25694@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905281301070.44@tvgsbejvaqbjf.bet> <20190528213529.GG24650@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905291356240.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1905291356240.44@tvgsbejvaqbjf.bet>
From:   Alejandro Sanchez <asanchez1987@gmail.com>
Date:   Thu, 26 Sep 2019 16:20:05 +0200
Message-ID: <CAA4phoF5xm=HuoAmor+dQEBqBJn_0thAT38ao8JtA6XhGCDQ6Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] am: fix --interactive HEAD tree resolution
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Are there any updates to this problem?

Thank you,
Alex


On Wed, May 29, 2019 at 1:57 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Peff,
>
> On Tue, 28 May 2019, Jeff King wrote:
>
> > On Tue, May 28, 2019 at 01:06:21PM +0200, Johannes Schindelin wrote:
> >
> > > > Or do you prefer having a one-liner? I'd rather come up with a more
> > > > generic helper to cover this case, that can run any command and compare
> > > > it to a single argument (or stdin). E.g.,:
> > > >
> > > >   test_cmp_cmd no-conflict git log -1 --format=%s
> > > >
> > > > or
> > > >
> > > >   test_cmp_cmd - git foo <<-\EOF
> > > >   multi-line
> > > >   expectation
> > > >   EOF
> > >
> > > I guess that you and me go into completely opposite directions here. I
> > > want something *less* general. Because I want to optimize for the
> > > unfortunate times when a test fails and most likely somebody else than the
> > > original author of the test case is tasked with figuring out what the heck
> > > goes wrong.
> > >
> > > You seem to want to optimize for writing test cases. Which I find -- with
> > > all due respect -- the wrong thing to optimize for. It is already dirt
> > > easy to write new test cases. But *good* test cases (i.e. easy to debug
> > > ones)? Not so much.
> >
> > Hmm. I too want the test output to be useful to people other than the
> > test author. But I find the output from test_cmp perfectly fine there.
> > My first step in digging into a failure is usually to look at what
> > commands the test is running, which generally makes it obvious why we
> > are expecting one thing and seeing another (or at least, just as obvious
> > as a hand-written message).
> >
> > So to me the two are equal on that front, which makes me want to go with
> > the thing that is shorter to write, as it makes it more likely the test
> > writer will write it. The _worst_ option IMHO is a straight-up use of
> > "test" which provides no output at all in the test log of what value we
> > _did_ see. That requires the person looking into the failure to re-run
> > the test, which is hard if it's a remote CI, or if the failure does not
> > always reproduce.
>
> If you think your version is easier to debug, then I won't object.
>
> Thanks,
> Dscho
