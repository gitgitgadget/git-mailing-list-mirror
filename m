Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B30A81F404
	for <e@80x24.org>; Wed, 21 Mar 2018 16:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeCUQQs (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:16:48 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:44225 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCUQQr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:16:47 -0400
Received: by mail-ot0-f170.google.com with SMTP id x6-v6so4733787otg.11
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dHPS79gjXnDDriLlxYAwfjGqBWDGe4GYLeQlDsovh90=;
        b=adpUrRUwmzTktLbrJ8hraajsYoevCbCxBTHOLVHVDVMQDjGA0++09aaYtGzg1AGYLd
         XpO1vq3bR53H5pbHxPxi0MnFTfFYU6ZFYpa/FZzt1gr5UCRs1NZUOa3OW2d5WGxBeDbZ
         KTQDozJ9t2U4VeY+m1iidVgatkbrRfHOBh/UOyHhugszvQPLhCBkFEGEu7pojYoMh9jb
         lLnSyT3GyKmNZL1qmPfPc83Y8fIElViJkeIyR0ruhvj8JlEDUnNOOZxKyrz6jYi3EHtm
         n9OD1SzyuXYYLdhZEjpXso0T8sBu9eiCgEhchKGOZjkcdYq0SDcR66bpnhTLQ4G0sYxa
         fLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dHPS79gjXnDDriLlxYAwfjGqBWDGe4GYLeQlDsovh90=;
        b=aArd1MWH/c4Kkg/CgUP4/AJ/G7SEdDDA6+y15teB02kemwcHnBpamkebbNJHNVYS8Z
         gsR/19Rw3NALihYmqzndsYPK5UXmp9SslCPVwwwYoaTchGZpyLLu+zLaxj03uJ//fCh+
         u0aJNVTu2LQuaZO2COvfYn0rdx3ub07tp35yKUvX8O5QrfAx4T0mkjtLYtRQ7Fnk2lOE
         CjVmEElvetiVjg6OUOvRcmBjK0/rLfMylxFUYBieREm6nM1X0Qzod17boO/df3xZ8Anz
         Br6gPt6gnrtfoMkgARX4yQ3kAppyG+5bie31k2Osgiv5pCw+eDZAhrcaFAuP+PNqoIgc
         pzbw==
X-Gm-Message-State: AElRT7G6yjpgo2+q97SyRMlkJaDEDEk+U6GwkgblAewJgibLh0N8+zv7
        zQQNgP/koXfSevO4/hUY7usKwJltys+SsO2oBN1bCg==
X-Google-Smtp-Source: AG47ELvUM4DUVCNR5+qxmmxjM/xSo5sxUJ2TJf3MPeEmBtKsa9VzE5m2N0wFdKAKadDFvUBv/xZL4+OHiW08l7ktIPU=
X-Received: by 2002:a9d:ae9:: with SMTP id 96-v6mr14292969otq.75.1521649006947;
 Wed, 21 Mar 2018 09:16:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Wed, 21 Mar 2018 09:16:16 -0700 (PDT)
In-Reply-To: <20180321065005.GB16784@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net> <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net> <20180320041454.GA15213@sigill.intra.peff.net>
 <CACsJy8CpwtNfp9oQGvECBuWGcwLEKK609iPJVEiXH4cDD6mpEg@mail.gmail.com> <20180321065005.GB16784@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 21 Mar 2018 17:16:16 +0100
Message-ID: <CACsJy8DCkh=kn1bmCQf4idPggsh5cEY936gfR-5qaQKRsmLBzA@mail.gmail.com>
Subject: Re: [PATCH] doc/gitattributes: mention non-recursive behavior
To:     Jeff King <peff@peff.net>
Cc:     Dakota Hawkins <dakota@dakotahawkins.com>,
        Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 7:50 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 20, 2018 at 05:41:52PM +0100, Duy Nguyen wrote:
>
>> > +The rules by which the pattern matches paths are the same as in
>> > +`.gitignore` files (see linkgit:gitignore[5]), with a few exceptions:
>> > +
>> > +  - negative patterns are forbidden
>>
>> After 8b1bd02415 (Make !pattern in .gitattributes non-fatal -
>> 2013-03-01) maybe we could use the verb "ignored" too instead of
>> "forbidden"
>
> Makes sense. The original is already in 'next', so do you want to send
> an incremental patch?

It's up to you. After all it's you who's doing all the work :)

>> > +    pointless in an attributes file; use `path/**` instead)
>>
>> We probably could do this internally too (converting "path/" to
>> "path/**") but we need to deal with corner cases (e.g. "path" without
>> the trailing slash, but is a directory). So yes, suggesting the user
>> to do it instead may be easier.
>
> Yeah, I almost suggested that, but I worried about those corner cases.
> It seems like documenting the current behavior is the right first step
> in any case.

Agreed.

> One other maybe-difference I came across coincidentally today: you have
> to quote the pattern in .gitattributes if it contains spaces, but not in
> .gitignore. But that's more an artifact of the rest of the file syntax
> than the pattern syntax (.gitignore has no other fields to confuse it
> with).

Yeah I forgot about that (and I was the one who started it). The
document was updated in 860a74d9d9 (attr: support quoting pathname
patterns in C style - 2017-01-27) though.
-- 
Duy
