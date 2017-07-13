Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54818202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 18:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbdGMS5E (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 14:57:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34854 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbdGMS5D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 14:57:03 -0400
Received: by mail-qt0-f193.google.com with SMTP id w12so7202568qta.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 11:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bvz+5yT0OmVXvtBId5WkLbXlVXlgGxA9TOBKVAf38tA=;
        b=arzImtQVHLnffbYew05rwBci4hwzdqmpxlkTRUYaM4Zupm2rrTE+hdM6VMO69Pr2SI
         +z8OwL+20Z73giRmC3eoWqc6uZuJMjGf3sO4Y4pXp2+YiPWtSVolKHKTLfxHfonpOgsN
         h1PbVcEGl3UiFeqYGuoMXSv/jxyTdN91DV8W/f3Djpep+qD3ZbnRmYes+22qPqmxzU/c
         4wY80o0ol4IvL1WPtLAfwQTwovwxgP3dGqfPpv+oj6x+V3424b2Y1DShAjlt6DcnKs8T
         dvGLdWoPuXgL4R1cqR7tv3avLaHm/cnjnFJZqjnrTOmC7lh/Nv9OnlrT0uqOv5CXc67Z
         Sm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bvz+5yT0OmVXvtBId5WkLbXlVXlgGxA9TOBKVAf38tA=;
        b=tpHsaudGWAh+qFriAT2x/A36maVcE2L8ks3x96fmCE9OKjEvqeVPjSFYhRlBl/i1Ue
         0XEaiImI1J11euyWbVXaIKPuv3K/bD6iME7JKOK/WwpEhRS6H2fctKdDexgSlvYIOjEC
         8f3a7Se58Jo1ADmncGnI5bVhWY5kssqS/f07XPRW4SEihkszwsLRkuHj33/KmK7+iYxa
         SUacihUoFP9fflmlPDXuCDbKI7nXVGSSULzCy5w3oEbRx1WziImnajml3mSeyVyh1AWL
         uW9n2gHeJC67meQrhrHyVnDTAVTIlMWcQuRmYLSzn3HCRWoclvMqN3vNpgUNQ0K7VX5U
         C46w==
X-Gm-Message-State: AIVw113lIDL5V0kQgQMGU4fb2TYR1Z3Ao/ZGhmhDd5epEPXNs1XmKx++
        fQQ9WxVV4rJ2X3de18hu6BUG6/lu+PaG
X-Received: by 10.237.46.99 with SMTP id j90mr7481271qtd.76.1499972222732;
 Thu, 13 Jul 2017 11:57:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Thu, 13 Jul 2017 11:57:01 -0700 (PDT)
In-Reply-To: <20170713165840.e5cdw7pa2m6haaen@sigill.intra.peff.net>
References: <20170713065050.19215-1-chriscool@tuxfamily.org> <20170713165840.e5cdw7pa2m6haaen@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 13 Jul 2017 20:57:01 +0200
Message-ID: <CAP8UFD3VnpMuMpcfRcTwL4nRpOF5URj6zsQqiEWYwo=1pi5Phw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Teach 'run' perf script to read config files
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 6:58 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 13, 2017 at 08:50:46AM +0200, Christian Couder wrote:
>
>> Goal
>> ~~~~
>>
>> Using many long environment variables to give parameters to the 'run'
>> script is error prone and tiring.
>>
>> We want to make it possible to store the parameters to the 'run'
>> script in a config file. This will make it easier to store, reuse,
>> share and compare parameters.
>
> Because perf-lib is built on test-lib, it already reads
> GIT-BUILD-OPTIONS.

Actually the 'run' script also sources GIT-BUILD-OPTIONS, so maybe
this is not necessary.
Also are the variables in GIT-BUILD-OPTIONS exported already?

> And the Makefile copies several perf-related values
> into it, including GIT_PERF_MAKE_OPTS and GIT_PERF_REPEAT_COUNT. So you
> can already do:
>
>   echo 'GIT_PERF_REPEAT_COUNT = 10' >>config.mak
>   echo 'GIT_PERF_MAKE_OPTS = CFLAGS="-O2" DEVELOPER=1' >>config.mak
>   make

The "make" here might not even be needed as in the 'run' script
"config.mak" is copied into the "build/$rev" directory where "make" is
run to build the $rev version.

>   cd t/perf
>   ./run <versions-and-scripts>
>
> I suspect there are still a lot of things that could be made easier with
> a config file, so I'm not against the concept. Your example here:
>
>> [perf "with libpcre"]
>>         makeOpts = DEVELOPER=1 CFLAGS='-g -O0' USE_LIBPCRE=YesPlease
>> [perf "without libpcre"]
>>         makeOpts = DEVELOPER=1 CFLAGS='-g -O0'
>
> is a lot more compelling. But right now the perf suite is not useful at
> all for comparing two builds of the same tree. For that, I think it
> would be more useful if we could define a tuple of parameters for a run.
> One of which could be the tree we're testing. Build opts are another.
> Tested repository is another. And then we'd fill in a table of results
> and let you slice up the table by any column (e.g., compare times for
> runs against a single tree but with differing build options).

Yeah, improving the output part is another thing that I have discussed
with AEvar and that I have planned to work on.
