Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3F61F403
	for <e@80x24.org>; Thu,  7 Jun 2018 19:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932444AbeFGT3w (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 15:29:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37442 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932401AbeFGT3v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 15:29:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so21260088wmg.2
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 12:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oRK/yFdNbgzoYgeT+UlliSFlzzkgnHUoNDVYF6vA85A=;
        b=pTN9pfRsphnlbiuOpKBGaGd+HyLfOwlE4vYe8wIdw1XRZGV5rhQCXQ10I+0YZ7QNIN
         ld2VnxMn8RysLhhn/Y7Wj4n0b7xK4Q5RhCKHM31Gd/IacoSF45G/B3YcQ+sdmb31aUbN
         dpR8BKFkjhQWF+ss6j5Jhg/0sIInURaZ+vhqzQO+xP0Ocfk/ti/pqzTPr3XPdYci5OE4
         MlH1jRDxX8gzZBo8dmjQJhi7kqCecYdah9BfdPcmab4lzXbVtxEiCGZbVNcluOB5Q2qL
         wI+2dNSfUn8cpH1z7MlxCnzSM88nMTYwyiHWSO6brRtuqbAGylofADpqp2TKpV9RXCgC
         ZMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oRK/yFdNbgzoYgeT+UlliSFlzzkgnHUoNDVYF6vA85A=;
        b=QW35+xoH/TKHtjHeMqmasNPzIvoEEqQsF/WbL4mLFU1bBZGOfEXJG5gwVELRMDnnfs
         ushljZDCofZhWAqoYGoQ9vgl3bvj+FSKFwiQ/LRSAyokWRW0RBn9ld8Nm/Lwy3YNyx0Y
         0CwYO9h/9C78lAIC/baG5NUZvIk8vbo7BVoGW411K0wqtmVBG99BH/t9xEe/9H4rZd/0
         Nrehrb6/43tp7D84OUDfFexPSV7Omg3fKKWu6sFBe5l3k9LbD+EkZHHjC1fy4Cp4hr/f
         4arH6FfCMSrZs76VxmUgvLXarIYtjnyIEr3FLy2u7y9KslD/KuWvQhlIONdp/Uxp+a4Z
         vayw==
X-Gm-Message-State: APt69E3jM2WC9aCQQp3AvV/UwQ62MPfZceMeSQOrKmUPAIBYloRqoRme
        BnUK0fXvblgdgS1VHIbtHu3CoyXW
X-Google-Smtp-Source: ADUXVKK9vpxOUwn05/7hAbHJTBHYE+ROS+0SIInutvMM+zSoAxDcq206eoP5m1EinuaLdd6umOFU8Q==
X-Received: by 2002:a50:e807:: with SMTP id e7-v6mr3946378edn.235.1528399790281;
        Thu, 07 Jun 2018 12:29:50 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id z44-v6sm23377212edb.72.2018.06.07.12.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 12:29:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep with leading inverted bracket expression
References: <20180607152711.GA27079@bombadil.infradead.org> <87602uza56.fsf@evledraar.gmail.com> <20180607192213.GB24370@bombadil.infradead.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180607192213.GB24370@bombadil.infradead.org>
Date:   Thu, 07 Jun 2018 21:29:48 +0200
Message-ID: <874liez977.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 07 2018, Matthew Wilcox wrote:

> On Thu, Jun 07, 2018 at 09:09:25PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> On Thu, Jun 07 2018, Matthew Wilcox wrote:
>> > If the first atom of a regex is a bracket expression with an inverted range,
>> > git grep is very slow.
>>
>> I have some WIP patches to fix all of this, which I'll hopefully submit
>> before 2.19 is out the door.
>>
>> What you've discovered here is how shitty your libc regex engine is,
>> because unless you provide -P and compile with a reasonably up-to-date
>> libpcre (preferably v2) with JIT that's what you'll get.
>
> I'm using Debian's build, and it is linked against a recent libpcre2:
> $ ldd /usr/lib/git-core/git
> 	libpcre2-8.so.0 => /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x00007f59ad5f2000)
> $ dpkg --status libpcre2-8-0
> Version: 10.31-3
>
> But I wasn't using -P.  If I do, then I see the performance numbers you do:
>
> $ time git grep -P '[^t]truct_size' >/dev/null
> real	0m0.354s
> user	0m0.340s
> sys	0m0.639s
> $ time git grep -P 'struct_size' >/dev/null
> real	0m0.336s
> user	0m0.552s
> sys	0m0.457s
> $ time git grep 'struct_size' >/dev/null
> real	0m0.335s
> user	0m0.535s
> sys	0m0.474s
>
>> So you need to just use an up-to-date libpcre2 & -P and performance
>> won't suck.

Yeah that's recent enough & will get you all the benefits.

> I don't tend to use terribly advanced regexps, so I'll just set
> grep.patternType to 'perl' and then it'll automatically be fast for me
> without your patches ;-)

Indeed, if you're happy with that that'll do it.

>> My WIP patches will make us use PCRE for all grep modes, using an API it
>> has to convert basic & extended regexp syntax to its own syntax, so
>> we'll be able to do that transparently.
>
> That's clearly the right answer.  Thanks!

Yeah, unfortunately git-grep's default is "basic" regexp which has a
really atrocious syntax that's different enough from extended & Perl's
that we probably couldn't just switch it over.

That won't be needed with my patches, but maybe I'll follow-up with
something to s/basic/extended/g by default, because on side effect of
having the pattern converter is that we could have a warning whenever
the user has a pattern that would be different under extended/perl, so
we can see how common that is.
