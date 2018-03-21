Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8630E1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 03:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeCUDWF (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 23:22:05 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:37357 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeCUDWD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 23:22:03 -0400
Received: by mail-oi0-f54.google.com with SMTP id f186-v6so3211217oig.4
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 20:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BE3t7/SffNzg/E8UUMU/EGmhg9maMAwMvSfpw1Wv8Gg=;
        b=C4dQbl+m0ZhljmhrSL8a+zTcnzh5jX5wvzUMNUEvtePY28W/dvX6xkZbgxo6p8w3RC
         9RwCs7fChpn9k4tvF6vw8EeYFsgwI7GciZmZR/79wRgRNsx4uvGyk1CclMLApAe+e051
         EMQOBsH41O4RtgGVZ+AXDX95ffu4QcguBtPyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BE3t7/SffNzg/E8UUMU/EGmhg9maMAwMvSfpw1Wv8Gg=;
        b=JrR3zOZn/6fzYpTwwePtOv2pDpNjyJ2HBmi8D1NmMuV2wJjjwAetlC92oQwjzdoNZL
         aUEscWvMsUuluJJuzANw+zoUXvNgpP5XvBkncK69VNXF+ORGt8WDSJdCZeyhpA3qkqYd
         OdDWOBCZ9ZH1uz3lg91Ls6FXGyfJM1nYLFgIpEryQcrRibv9nIs5Za7NgRNKK7UK2dJE
         ViDzcJFLvmYh/zSVZ4tIuj6b2HRzhPc9O5DrZ3zApJThntXuMCPQpgzsm7zfe1yHzMfV
         TCmr4bT5ed09TOJZdR6FyAtOtCOJlTHbnZoTM7+a2gYIufuXK8Jf10Z1nlcUVBxGEzMV
         0gHg==
X-Gm-Message-State: AElRT7HWtMy38e0qIR0b3VC66gAqCPj2NnawTYw1l1C3Oz9xwPPu2Hxv
        fK40AnPcLhwUdQdJq8fd/wjIA0FFuTw7FnuhTNW6Lw==
X-Google-Smtp-Source: AG47ELs+MSpOL6abc1YGMxRvjn7YkMMxlv7ByvPBSzKEuzGnAlG/NXdAh1MUm+DknMLk/+HFVk+RI7eEN0hPPpmmV38=
X-Received: by 10.84.78.138 with SMTP id c10mr10425539oiy.236.1521602522830;
 Tue, 20 Mar 2018 20:22:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Tue, 20 Mar 2018 20:22:02
 -0700 (PDT)
In-Reply-To: <CACsJy8BP+ov0jeHp6QZoi=etPDQX5qEFqEfktyA-U-ffUE92vA@mail.gmail.com>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net> <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net> <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
 <20180320044036.GD13302@sigill.intra.peff.net> <CACsJy8BP+ov0jeHp6QZoi=etPDQX5qEFqEfktyA-U-ffUE92vA@mail.gmail.com>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Tue, 20 Mar 2018 23:22:02 -0400
Message-ID: <CAHnyXxRsqR3A0FpHJwnfOWo29WNx05qWSXfxvmwPv1TUdqm0aQ@mail.gmail.com>
Subject: Re: .gitattributes override behavior (possible bug, or documentation bug)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thinking about this a little more, I'm now attracted to the idea that
its .gitignore that's weird.

As I understand it, .gitignore stops recursion when there's a
directory match (`somedir/`) but also explicitly allows nested
.gitnore file _as well as_ exclusion (`!*.txt`).

So, in the following (contrived) example, the user doesn't get what they want:

    repo/
    |- .git/
    |- .gitignore               # /ignore-most/
    |- ignore-most/
    |  |- .gitignore            # !*.txt
    |  |- please_ignore.png
    |  |- dont_ignore_me.txt

`repo/ignore-most/dont_ignore_me.txt` is still ignored, despite what
seems like the obvious intention of the user.

Maybe a unified "best-practices" would first-and-foremost recommend
against matching directories at all (makes sense, git doesn't manage
directories). In the above example, changing `/ignore-most/` to
`/ignore-most/*` has the "desired" effect.

What do you think?

On Tue, Mar 20, 2018 at 12:28 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Mar 20, 2018 at 5:40 AM, Jeff King <peff@peff.net> wrote:
>> On Tue, Mar 20, 2018 at 12:25:27AM -0400, Dakota Hawkins wrote:
>>
>>> > Right. The technical reason is mostly "that is not how it was designed,
>>> > and it would possibly break some corner cases if we switched it now".
>>>
>>> I'm just spitballing here, but do you guys think there's any subset of
>>> the combined .gitignore and .gitattributes matching functionality that
>>> could at least serve as a good "best-practices, going forward"
>>> (because of consistency) for both? I will say every time I do this for
>>> a new repo and have to do something even slightly complicated or
>>> different from what I've done before with .gitattributes/.gitignore
>>> that it takes me a long-ish time to figure it out. It's like I'm
>>> vaguely aware of pitfalls I've encountered in the past in certain
>>> areas but don't remember exactly what they are, so I consult the docs,
>>> which are (in sum) confusing and lead to more time spent
>>> trying/failing/trying/works/fails-later/etc.
>>>
>>> One "this subset of rules will work for both this way" would be
>
> You know, you (Dakota) could implement the new "exclude" attribute in
> .gitattributes and ignore .gitignore files completely. That makes it
> works "for both" ;-) The effort is probably not small though.
>
>>> awesome even if the matching capabilities are technically divergent,
>>> but on the other hand that might paint both into a corner in terms of
>>> functionality.
>>
>> As far as I know, they should be the same with the exception of this
>> recursion, and the negative-pattern thing. But I'm cc-ing Duy, who is
>> the resident expert on ignore and attributes matching (whether he wants
>> to be or not ;) ).
>
> Ha ha ha.
>
>> I wouldn't be surprised if there's something I don't know about.
>
> The only thing from the top of my head is what made me fail to unify
> the implementation of the two. It's basically different order of
> evaluation [1] when your patterns are spread out in multiple files. I
> think it makes gitattr and gitignore behavior different too (but I
> didn't try to verify).
>
> Apart from that, the two should behave the same way besides the
> exceptions you pointed out.
>
> [1] https://public-inbox.org/git/%3CCACsJy8B8kYU7bkD8SiK354z4u=sY3hHbe4JVwNT_1pxod1cqUw@mail.gmail.com%3E/
>
>> So I think the "recommended subset" is basically "everything but these
>> few constructs". We just need to document them. ;)
>>
>> I probably should cc'd Duy on the documentation patch, too:
>>
>>   https://public-inbox.org/git/20180320041454.GA15213@sigill.intra.peff.net/
>>
>> -Peff
> --
> Duy
