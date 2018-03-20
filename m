Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507941F404
	for <e@80x24.org>; Tue, 20 Mar 2018 16:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeCTQ3S (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 12:29:18 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:38654 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCTQ3R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 12:29:17 -0400
Received: by mail-oi0-f49.google.com with SMTP id c3-v6so1847108oib.5
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YyhaHPPmhjfcHh4imC442XlkueYKYkt2L97D5iKpFQU=;
        b=Pu9Mz0jOhq5SbD3DgGrcD9L3xM7SnoPB5EFjo6YSW7q50/SwRRImMJ+gTvYDtdv8wC
         85SRzBEHOG+h7HYKscPgp6HGLLwMx9yokN0rPXGAQ/cWJbzAScyIn28xUHmRHULcCGIr
         Ox5iyMwpB7x4QxxR1wWcL5TqUjEhC2XZfbz7W4vhwaQ8ixPjrNnYfkhc7YPlqj/IOdX3
         pBQ07YarXQ+Mr2bDacvHM4s/E4XzYUCsgP0CwfH2YMjcjYxlIvBlWJfr+zsNnncOF58R
         8JqLUViJiWAqhEs3Xzbq62KU+Eb0DaNsQGxkH+zWS2eZbPRpr66nVTwGpP7so0u0T1k0
         srSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YyhaHPPmhjfcHh4imC442XlkueYKYkt2L97D5iKpFQU=;
        b=paG/MKUDNB9D8nTpDyffHJAJlB++WqjCI9Rfr4VLzffUyN7k16vdsVDmjku9NcFB3X
         zonXzsSAbEylRPzOjCTx+ujBTuOVoN7Bk1aZ+fTKffSDvj2WnNn8h2eVLnigrU3Wy/5m
         dws5hjlgctI8oSzEO4kiRn10OZll1bI3u2mQflmKNxdf64Y2BqX+OdplriNgp+mmVk6h
         cCDJbnxpASdzo6rLyfDZv2/bY/IkemYt/j2CJW/PcKmQQH9+nybExTuKik05EWeJj7kV
         6dr/uVYHQp6PQNGkzNluENlZ6bCaX3yOFVRJ3tv4BwAA+tZXCVk00qQvHnX3coBZAMgW
         hcGQ==
X-Gm-Message-State: AElRT7H/7a5b3SR6T/JcmcykQjJChOPsn36ktmgAcWnJJqXxNc+7e848
        zJjpMGCWQ7T+5U8p1sE2yUfonIBLsrTjcjqG7f8Y5g==
X-Google-Smtp-Source: AG47ELtNN9TVXRmVPjOhrdJsFfrSswNzTkNj10YWxS/mbjkrs2cnBoHhA9uGsdUDJuqsc8LNIEY4XSasCahRiVlmveA=
X-Received: by 10.202.81.200 with SMTP id f191mr9768150oib.32.1521563356721;
 Tue, 20 Mar 2018 09:29:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Tue, 20 Mar 2018 09:28:46 -0700 (PDT)
In-Reply-To: <20180320044036.GD13302@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net> <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net> <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
 <20180320044036.GD13302@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 20 Mar 2018 17:28:46 +0100
Message-ID: <CACsJy8BP+ov0jeHp6QZoi=etPDQX5qEFqEfktyA-U-ffUE92vA@mail.gmail.com>
Subject: Re: .gitattributes override behavior (possible bug, or documentation bug)
To:     Jeff King <peff@peff.net>
Cc:     Dakota Hawkins <dakota@dakotahawkins.com>,
        Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 5:40 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 20, 2018 at 12:25:27AM -0400, Dakota Hawkins wrote:
>
>> > Right. The technical reason is mostly "that is not how it was designed,
>> > and it would possibly break some corner cases if we switched it now".
>>
>> I'm just spitballing here, but do you guys think there's any subset of
>> the combined .gitignore and .gitattributes matching functionality that
>> could at least serve as a good "best-practices, going forward"
>> (because of consistency) for both? I will say every time I do this for
>> a new repo and have to do something even slightly complicated or
>> different from what I've done before with .gitattributes/.gitignore
>> that it takes me a long-ish time to figure it out. It's like I'm
>> vaguely aware of pitfalls I've encountered in the past in certain
>> areas but don't remember exactly what they are, so I consult the docs,
>> which are (in sum) confusing and lead to more time spent
>> trying/failing/trying/works/fails-later/etc.
>>
>> One "this subset of rules will work for both this way" would be

You know, you (Dakota) could implement the new "exclude" attribute in
.gitattributes and ignore .gitignore files completely. That makes it
works "for both" ;-) The effort is probably not small though.

>> awesome even if the matching capabilities are technically divergent,
>> but on the other hand that might paint both into a corner in terms of
>> functionality.
>
> As far as I know, they should be the same with the exception of this
> recursion, and the negative-pattern thing. But I'm cc-ing Duy, who is
> the resident expert on ignore and attributes matching (whether he wants
> to be or not ;) ).

Ha ha ha.

> I wouldn't be surprised if there's something I don't know about.

The only thing from the top of my head is what made me fail to unify
the implementation of the two. It's basically different order of
evaluation [1] when your patterns are spread out in multiple files. I
think it makes gitattr and gitignore behavior different too (but I
didn't try to verify).

Apart from that, the two should behave the same way besides the
exceptions you pointed out.

[1] https://public-inbox.org/git/%3CCACsJy8B8kYU7bkD8SiK354z4u=sY3hHbe4JVwNT_1pxod1cqUw@mail.gmail.com%3E/

> So I think the "recommended subset" is basically "everything but these
> few constructs". We just need to document them. ;)
>
> I probably should cc'd Duy on the documentation patch, too:
>
>   https://public-inbox.org/git/20180320041454.GA15213@sigill.intra.peff.net/
>
> -Peff
-- 
Duy
