Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06DAD20560
	for <e@80x24.org>; Fri, 27 Oct 2017 22:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbdJ0WLt (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 18:11:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:47782 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbdJ0WLs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 18:11:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id r196so5763492wmf.2
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 15:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=G6jQ4FlwgU0M5+y/+1qnS29xwG4qCLhQCNFolTx9DBY=;
        b=P4qXHEQhXSqJZQXLjeMqiRLpOJpOCfqy0wMs18lRsDMsKBWNQFz21gDmcOCVeAmHYM
         l7Z9L1I7pSgIm8HuW/Q+qPMvJCaV/8XhrRZrbxxybtchBH7ICliskTXDUSEvQfzb7ySl
         3WW3gOQKYbahK7tQecs132/UYNKY0RyEk25GFC/AbX283NlQMn7HWmYOmki/8h27ks/a
         VrupQpokp/ry5OGwsBhavv5tPHUyba1cwzAi9izjXFVB+bAGOIrLGsxq07Scy7+BK5o4
         O/KqZ04Umemb63qmCmISjuZ6Fw+tjDKquCIabdJ4EU5NL94c5gbrU2ChW9sMGuw0KHhg
         4jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=G6jQ4FlwgU0M5+y/+1qnS29xwG4qCLhQCNFolTx9DBY=;
        b=C1Mn6vSc4yGXZgLlr38Xo/LT8diU7+oeRIY3VuNcl87jEj4vbHARSPKxJSW1XutcRe
         Wacc0xLuO5N11Q+Ezu6/alBFSE6upn07pD/XPcECU8i6CX7yf7wCWghDzBISTl+DSQUc
         Bii4150UQ4v/wYr6CN2JLPg83NU1l1tBc9LvJI4X+FkPSYse5jRuNpzzT5DWmDlNWRaw
         xa51S28EVY/qtKU5Sb9CWbAD+/4ksYwdgt8Ne8elQyfkhRaaAVjhVRE8j32TyIGbzXv+
         RBUUapiOZeoURpHxrqZO8zY4tIIv2+9zuIoLjgkLDh05sEhN5xNRuh9jXS9qHBo9jDLD
         2+Zg==
X-Gm-Message-State: AMCzsaWaHVbvCkutwNALuYpBod7PAtyY2kmCX9iMQzgDMl+o9xzvpt8l
        dEANSlj4IF8rOzGyVVSPYnY=
X-Google-Smtp-Source: ABhQp+S4E0F3RVXDcotx99Wmw5HRSR3d4OmcYKNsK4t6jBBkoikMZkx7Z+RVtvZECHKpS15Mhgj0mQ==
X-Received: by 10.80.173.138 with SMTP id a10mr2271122edd.49.1509142307182;
        Fri, 27 Oct 2017 15:11:47 -0700 (PDT)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id v32sm5951679edm.76.2017.10.27.15.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Oct 2017 15:11:45 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1e8Cqu-0000Xb-93; Sat, 28 Oct 2017 00:11:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: grep vs git grep performance?
References: <1509030170.10651.59.camel@perches.com> <CAGZ79ka41NdzNxGAvtVW802088KydKkp3yHx=Z5q3Mc9GGa_+g@mail.gmail.com> <1509039696.11245.9.camel@perches.com> <CAGZ79kYWPunzZ2u=MtCoCadxXu_4etEK5DYnhYXo+CgeHrXQwQ@mail.gmail.com> <1509124942.1914.9.camel@perches.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <1509124942.1914.9.camel@perches.com>
Date:   Sat, 28 Oct 2017 00:11:44 +0200
Message-ID: <877evgxmu7.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 27 2017, Joe Perches jotted:

> On Thu, 2017-10-26 at 10:45 -0700, Stefan Beller wrote:
>> On Thu, Oct 26, 2017 at 10:41 AM, Joe Perches <joe@perches.com> wrote:
>> > On Thu, 2017-10-26 at 09:58 -0700, Stefan Beller wrote:
>> > > + Avar who knows a thing about pcre (I assume the regex compilation
>> > > has impact on grep speed)
>> > >
>> > > On Thu, Oct 26, 2017 at 8:02 AM, Joe Perches <joe@perches.com> wrote:
>> > > > Comparing a cache warm git grep vs command line grep
>> > > > shows significant differences in cpu & wall clock.
>> > > >
>> > > > Any ideas how to improve this?
>> > > >
>> > > > $ time git grep "\bseq_.*%p\W" | wc -l
>> > > > 112
>> > > >
>> > > > real    0m4.271s
>> > > > user    0m15.520s
>> > > > sys     0m0.395s
>> > > >
>> > > > $ time grep -r --include=*.[ch] "\bseq_.*%p\W" * | wc -l
>> > > > 112
>> > > >
>> > > > real    0m1.164s
>> > > > user    0m0.847s
>> > > > sys     0m0.314s
>> > > >
>> > >
>> > > I wonder how much is algorithmic advantage vs coding/micro
>> > > optimization that we can do.
>> >
>> > As do I.  I presume this is libpcre related.
>> >
>> > For instance, git grep performance is better than grep for:
>> >
>> > $ time git grep -w "seq_printf" -- "*.[ch]" | wc -l
>> > 8609
>> >
>> > real    0m0.301s
>> > user    0m0.548s
>> > sys     0m0.372s
>> >
>> > $ time grep -w -r --include=*.[ch] "seq_printf" * | wc -l
>> > 8609
>> >
>> > real    0m0.706s
>> > user    0m0.396s
>> > sys     0m0.309s
>> >
>>
>> One important piece of information is what version of Git you are running,
>>
>>
>> $ git tag --contains origin/ab/pcre-v2
>> v2.14.0
>
> v2.10
>
>> ...
>>
>> (and the version of pcre, see the numbers)
>> https://git.kernel.org/pub/scm/git/git.git/commit/?id=94da9193a6eb8f1085d611c04ff8bbb4f5ae1e0a
>
> I definitely didn't have that one.
>
> I recompiled git latest (with USE_LIBPCRE2) and reran.
>
> Here are the results
>
> $ git --version
> git version 2.15.0.rc2.48.g4e40fb3
>
> $ time git grep -P "\bseq_.*%p\W" -- "*.[ch]" | wc -l
> 112
>
> real	0m0.437s
> user	0m1.008s
> sys	0m0.381s
>
> So, git grep performance has already been
> quite successfully improved.

...and I have WIP patches to use the PCRE engine for patterns without -P
which I intend to start sending soon after the next release.
