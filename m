Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843621F404
	for <e@80x24.org>; Wed, 29 Aug 2018 17:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeH2VyH (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 17:54:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42991 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbeH2VyG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 17:54:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so2608357pff.9
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FxWIXBM19FZ8B5tDb4LH+sgbWk3eE6jqjTFDrBWCYpQ=;
        b=jIvFypJKanv5jSSt2zf5eynV5rTaV55c789iEl0w7I9EEaQJu0reCUq9c34kwhomiU
         zAOv6OZpECYzBopv/Gz4RoXCE5Kh4CrKUwpmaelSyCpPYVBd3tUjKXJC/rrmE3ndiqge
         BkuZl2mNggXCHveRowFwr5FP74MpJ0dTXAzSzj8TkqOvbRdKpt5Uj5qL4hKCcHmg3CaL
         HRVB2H+qXLQQGGQYijyNTcNK04rZKq1p6gfGLWtyniVfWLVmi4gzgEanfEqoWbZ5x+XB
         BHA4RCczJGYKpJm6daiol8owiaEXtX9DgjKfiaNOYTbe9wmf4b8HxaN7WI05ay0vC4CU
         cyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FxWIXBM19FZ8B5tDb4LH+sgbWk3eE6jqjTFDrBWCYpQ=;
        b=GsxiR0E1Z2Q7S5bm8VwXl+zpjg8hM6UYFc3Inj5KgnkAJ+OC/kwt8yAx/CyQeaKbnW
         zFqoH2cX9H1LfbdYWXpKKRRrpNi3PgX5ZLXxVoeToXIPEkOEFj0sp2P5Fm6OGy2WvRV+
         jTydfTxESzyjWFmoy+g0XinRYgi11/MHOuIZK8kZU6AalFy85CTfYmVDgWhk0apE1Sk5
         zAQyTkkHtPJ2wW4mpWt83/amDMyCFeDXcGGwAnFre5C+aX2eW4noJowpCDbnJk0IQa7I
         0Co5wFFvm1wXj5/aMg/V7DLWshjc68bIdLUlR7MppKr8JsoIto+D9N5qZRfyq6/X0ZFF
         u0qg==
X-Gm-Message-State: APzg51D62OWZObxkA/VEC47EnfRP2xaPJ6MOmABBe1BanQU2Qr5vDCaW
        1cVkOOieAwUD2fIvk6bLw83hNJM2
X-Google-Smtp-Source: ANB0VdbZwXjX+sKKzLCOUvf1a5qoAc2hRLvV5cu8LifK3C1yv6ZYsJDWa6wcXrrx6YF+s2zifqE9yQ==
X-Received: by 2002:a63:2acc:: with SMTP id q195-v6mr6490637pgq.291.1535565364806;
        Wed, 29 Aug 2018 10:56:04 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n24-v6sm6728827pfi.161.2018.08.29.10.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 10:56:04 -0700 (PDT)
Date:   Wed, 29 Aug 2018 10:56:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: How is the ^{sha256} peel syntax supposed to work?
Message-ID: <20180829175602.GA7547@aiede.svl.corp.google.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
 <20180824014703.GE99542@aiede.svl.corp.google.com>
 <877ek9edsa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877ek9edsa.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:
> On Fri, Aug 24 2018, Jonathan Nieder wrote:
>> Ævar Arnfjörð Bjarmason wrote:

>>> Or is this expected to be chained, as e.g. <object>^{tag}^{sha256} ?
>>
>> Great question.  The latter (well, <hexdigits>^{sha256}^{tag}, not the
>> other way around).
>
> Since nobody's chimed in with an answer, and I suspect many have an
> adversion to that big thread I thought I'd spin out just this small
> question into its own thread.
>
> brian m. carlson did some prep work for this in his just-submitted
> https://public-inbox.org/git/20180829005857.980820-2-sandals@crustytoothpaste.net/
>
> I was going to work on some of the peel code soon (digging up the type
> disambiguation patches I still need to re-submit), so could do this
> while I'm at it, i.e. implement ^{sha1}.

Cool!

> But as noted above it's not clear how it should work. Jonathan's
> chaining suggestion (<hexdigits>^{sha256}^{tag} not
> <hexdigits>^{tag}^{sha256}) makes more sense than mine, but is that what
> we're going for, or ^{sha256:tag}?

I don't have a strong opinion about this, but since it affects the
interpretation of <hexdigits>, my assumption has been that, in the
spirit of referential transparency, you would put
'<hexdigits>^{format}' and could put any additional specifiers after
that.

In other words, ^{format} changes the interpretation of <hexdigits> so
my assumption is that people would want it to be close by.

But if something else is easier to implement, we can start with that
something else and figure out whether we like it in review.

Thanks,
Jonathan
