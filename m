Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793E41F404
	for <e@80x24.org>; Wed, 29 Aug 2018 20:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbeH3ApC (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 20:45:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42058 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbeH3ApC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 20:45:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so2802649plq.9
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TN8w2Z87XhhL03YQRWT3yyiumeYqLTf9mZ8uzME74gE=;
        b=ai60tnMvjn5a0xdn/qsjv9Lc9QTB6uLwTwf6BpxDwGqo0Vz4GL/ZB7hiEslFoJkiYc
         LOWUBGXWgUGyqBkOkvX9/7D1EygZqEfPxVqhmHOHvOKy154yoAQsLn1tgmLCxlOrRKo3
         bKC9G4no7DJpwuiVaYAJ7WRUFLIlCn5uDX4hqRAnZX/Q6jQquH4YCHHsciI99fnba4i0
         sGvSw9WU/2scBMQNPNAldSu2wqL+kB+KanbTGXGZMhVzp1LfvI7wjgu7Vgnf01jY2tuW
         H21beazQWM7s5HuB0n3mu9kulb0F3Hq5CswKokE1XZCcjS+a1AZQbXEIgahiEMuI4Q5b
         +3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TN8w2Z87XhhL03YQRWT3yyiumeYqLTf9mZ8uzME74gE=;
        b=Dp32tt84b17RaEWu2PyOfbXXILbNrbSYAEuSf6S1uN1ByXRaQGVzllJdJxRBO5V3zK
         Ra8HiGsOyHwmbwnYHz6IsJ3Ry/tVWSNjS1L5l2ldBsQNPhgPLj/moW83xdjbmqevhBOC
         uk6A/c5tNJeGTrA6I7FkjtqxZGBiDHCfbasOOzcsJYNH4H6L/NrRMXgXaRqHwLG5I4w/
         UUcKAgGp8ZTryYO43Hb7ULxK07BBSjMS189gdLHMBy1peyaZOQaCTPqp9NZvIy1UrTGk
         F9TlHzYyNP+hXmFhTCohpaMYtKSgScwvEs9z3xMgX6DGN4g7XZMeaAEEblGt4jdt21uA
         kDpg==
X-Gm-Message-State: APzg51DmT7cZwtsDzNlFYj3hGKv3Vt9fojsljUbjuKhEAZK771P378JL
        lkLxMqhkcEJcLv5K3unS10E=
X-Google-Smtp-Source: ANB0VdZr4pvZ0JHxlPqd9hb2g8cY0+R0z8Uzd9hRF3osQxZgvBgabCxdSzed96kSnHG4kLv2pK4Nmw==
X-Received: by 2002:a17:902:28eb:: with SMTP id f98-v6mr7295386plb.149.1535575586257;
        Wed, 29 Aug 2018 13:46:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 83-v6sm11433642pft.40.2018.08.29.13.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 13:46:25 -0700 (PDT)
Date:   Wed, 29 Aug 2018 13:46:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: How is the ^{sha256} peel syntax supposed to work?
Message-ID: <20180829204623.GD7547@aiede.svl.corp.google.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
 <20180824014703.GE99542@aiede.svl.corp.google.com>
 <877ek9edsa.fsf@evledraar.gmail.com>
 <CAGZ79kaGb_TL7SiR4CFGFzrfy2Lotioy76o6sUK4=vZK5qwqNA@mail.gmail.com>
 <20180829175950.GB7547@aiede.svl.corp.google.com>
 <87zhx5c8wo.fsf@evledraar.gmail.com>
 <20180829191232.GC7547@aiede.svl.corp.google.com>
 <87y3cpc6bt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y3cpc6bt.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:
> On Wed, Aug 29 2018, Jonathan Nieder wrote:

>> In other words, I want the input format and output format completely
>> decoupled.  If I pass ^{sha1}, I am indicating the input format.  To
>> specify the output format, I'd use --output-format instead.
>
> This is also a reasonable thing to want, but I don't see how it can be
> sensibly squared with the existing peel syntax.

All the weight here is on the word "sensibly".  Currently, ^{thing}
means "act on the object" and @{thing} means "act on the ref".  This
^{sha1} syntax is really a new kind of modifier, ~{thing}, meaning
"act on the string".

That said, we can make it do anything we want.  There is nothing
forcing us to make it more similar to ^{commit} than to
^{/searchstring}, say.

In that context:

[...]
>> Ævar Arnfjörð Bjarmason wrote:

>>> Similarly, I think it would be very useful if we just make this work:
>>>
>>>     git rev-parse $some_hash^{sha256}^{commit}
>>>
>>> And not care whether $some_hash is SHA-1 or SHA-256, if it's the former
>>> we'd consult the SHA-1 <-> SHA-256 lookup table and go from there, and
>>> always return a useful value.
>>
>> The opposite of this. :)
>
> Can you elaborate on that?

What I'm saying is, regardless of the syntax used, as a user I *need*
a way to look up $some_hash as a sha256-name, with zero risk of Git
trying to outsmart me and treating $some_hash as a sha1-name instead.

Any design without that capability is a non-starter.

[...]
> I.e. if I'm using this in a script I'd need:
>
>     if x = git rev-parse $some_hash^{sha256}^{commit}
>         hash = x
>     elsif x = git rev-parse $some_hash^{sha1}^{commit}
>         hash = x
>     endif

Why wouldn't you use "git rev-parse $some_hash^{commit}" instead?

Thanks,
Jonathan
