Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3243E1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 14:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeINTql (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 15:46:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33841 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINTql (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 15:46:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so7630216eds.1
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CsrHwcv1lX59CfYH9JksyfMhd5zEQAHUc4Z9KVcn/hU=;
        b=shRZIjLZGgfdZV6DLEVPXGMuFcxTG1nuChQGyNtGVWkCxpHRQjPSeXm0eCWoIrSGnr
         2qZ3KLT3rmYOcqAkoB5pwDbd4XBVGdlaD98uCAQjepPm01na1HIWT3FRS+4OH3BUndDP
         bpQOD1C0taGrZDDPDqtgjM5uesYMbROld0ksMQg5krwogi1qiTEPkiALO9jPc1MSjFaX
         RbtD1xgrNv92UPxzI7DPdwSxtYJX1VpMVGcz2H3TFAZveUzaLOERci1FuyQKJsJju7CK
         Zo8ZDjfuq6NVcY++7Nc4/rOCkT6KqPKsglRuSNGHGjXv8X7o5/aO/uYwjGTfR/OnV+FW
         opZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=CsrHwcv1lX59CfYH9JksyfMhd5zEQAHUc4Z9KVcn/hU=;
        b=acRXbTWKKzHo21U99N4GrVV/d+2ElsXF2Z+kCMo2jVYm22+QDeUd/FsQO/EfriUygP
         YEtYoc81BBTs8vw2F3r7KaiPLLUZRDkg3Z+g2jUJczfAuSHXwcZVwh5HFj1u5L/VelOK
         dHuxFO/lxwAsYpSCkgQ4cBQhJBbIbMdTP6ub/pmW4CSg7y2R12NL+pvo6j/+wHySRybj
         1Jp45Zp5XtxMVK3pZoQGiUtbMjRIJs+TPDbjx22fP/QiHaBzFwWxZeVNNo8kiIDi6AGu
         KKQZGSWV3vMtZtT8IkFMFhAjlVc4GeKpORlDBwp1kE1DbjbU+FsZu3oSm2ylLSnHoOUW
         LjUw==
X-Gm-Message-State: APzg51AY7rP/EODmuObC5ExlwYGH4e1QKlBhPS8e5Pa5r/dOHvBp1weI
        yegheiUExOGwkr/09a3CuDo=
X-Google-Smtp-Source: ANB0VdbT+ih6SHBfLT5hXN+y+E5c9rONIthFpJDObkC4KSHcTbQKcIc5S4l6QmoIHUSpwI4tET/WPA==
X-Received: by 2002:a50:aed8:: with SMTP id f24-v6mr20409746edd.271.1536935512777;
        Fri, 14 Sep 2018 07:31:52 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id e25-v6sm3248224edd.35.2018.09.14.07.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 07:31:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Josh Steadmon <steadmon@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bmwill@google.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH 2/3] archive: implement protocol v2 archive command
References: <20180912053519.31085-1-steadmon@google.com>
        <20180912053519.31085-3-steadmon@google.com>
        <CAGZ79kZOTsUH=zQX3rLXvuSOx1vp8C98maSn47ssfca8c-BrBQ@mail.gmail.com>
        <87k1npkzh5.fsf@evledraar.gmail.com>
        <20180914060552.GD219147@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180914060552.GD219147@aiede.svl.corp.google.com>
Date:   Fri, 14 Sep 2018 16:31:50 +0200
Message-ID: <87d0tgkv55.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 14 2018, Jonathan Nieder wrote:

> Ævar Arnfjörð Bjarmason wrote:
>> On Wed, Sep 12 2018, Stefan Beller wrote:
>
>>> Would asking for a setlocale() on the server side be an unreasonable
>>> feature request for the capabilities (in a follow up patch, and then not
>>> just for archive but also fetch/push, etc.)?
>>
>> This would be very nice to have, but as you suggest in some follow-up
>> change.
>
> Indeed, I think we've gone pretty far afield from the goal of this
> patch series.
>
>> I think though that instead of doing setlocale() it would be better to
>> pass some flag saying we're operating in a machine-readable mode, and
>> then we'd (as part of the protocol defintion) say we're going to emit
>> GIT_ERR_UPLOAD_ARCHIVE_EXPECTED_DELIM_PACKET or whatever.
>
> I think you're suggesting client-side message generation, and that is
> one way to handle internationalization of server output.
>
> The main downside is when the server really does want to provide a
> custom error message.  For that, we'd need

Yeah you can't do it for everything. E.g. hooks will want to spew out
custom messages, and this hypothetical protocol extension won't have
codes for those. So you'll still need to pass $LANG along.

>  1. To propagate LANG to the server, so it knows what human language
>     to generate messages in.
>
>  2. On the server side, to produce messages in that language if
>     available, with an appropriate fallback if not.
>
> We've been thinking of doing at least (1) using the same trick as
> server-options use (cramming it into client capabilities).
>
> It is difficult to use setlocale for this because it affects the whole
> program (problematic for a threaded server) and affects features like
> collation order instead of just message generation (problematic for
> many things).  Does gettext have a variant that takes a locale_t
> argument?

No, its API is fairly crappy and depends on setlocale().

Keep in mind though that we're not tied to that API. E.g. one way to
work around this problem is to simply loop through all the languages we
have translations for at server startup, for each one call setlocale()
and gettext(), and save the result in a hash table for runtime lookup,
then you'd just call sprintf(hash[language][message_id], ...) at
runtime.

That's all libintl is really doing under the hood, in a roundabout way
where calls to setlocale() determine what table we're looking things up
in.

The reason I opted to go for gettext to begin with was mainly a) it was
there b) the ubiquitous availability of tooling for translators when it
comes to the *.po files.

But the API for looking things up at runtime is fairly small, and easy
to replace. We could e.g. replace all of our own gettext.[ch] wrapper
with something that works somewhat like what I described above, with
some extra build step to extract the relevant data from the *.mo files
(or parse the *.po directly).

> [...]
>>  4) Aside from translation purposes, getting a machine-readable
>>     "push/pull" etc. mode would be very handy. E.g. now you need to
>>     parse stderr to see why exactly your push failed (hook denied, or
>>     non-fast-forward, or non-fast-forward where there was a lock race
>>     condition? ...).
>
> Indeed, this is a good reason to provide error codes instead of (in
> the case where the message doesn't add anything to it) or alongside
> (in case the error message is more specialized) human-oriented error
> messages.
