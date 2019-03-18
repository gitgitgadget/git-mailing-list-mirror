Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69A6A20248
	for <e@80x24.org>; Mon, 18 Mar 2019 22:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCRWsv (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 18:48:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42356 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfCRWsv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 18:48:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id j89so14946256edb.9
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 15:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FJAgWM8OxBqTGOkWP3Fk4Y8B+HM4r1ze8UowKqWVf0E=;
        b=pIv+4mKmzAOe7XSD3HxhBkahVaqNSYpu9Oj7n/a4SxT9vCx537JU3TFb5dRcDQ4RKr
         GnNcerLTJ0mY7MwJSIakI02BhWD+8ZJCBdcpat4khCnrxiJSFrzndRp9OoK32bGc5zw0
         VMBcDhHONXCBetKyfOCbpjikde1ZSeENHpN5NuilQchcX61jHXx9OiQ43ekI3mJRMga5
         wslylJdXZIW5AUGY4yTItewi2eBnAMmlV4eta+FmoN3W+cliUK7WihQdkoimVCf7JX4c
         7NFhhPTMdQP4m0c01C5fQM93iv0jf2AqK0Y/EQjcY6rC7AEy4m2Tn6NQUvQDh2PrzPq5
         8bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=FJAgWM8OxBqTGOkWP3Fk4Y8B+HM4r1ze8UowKqWVf0E=;
        b=YQjrfhNJmlBVLgpgHa1FxrhjMnHXpmm2gHJdfHO7sGri1IZzB2S5oWkcggQcOij3tW
         8orpaMs1BKRrIhfKpFtAvTDG1sE9CYewRJoYbUEXWxW54bu4jCkDs3D7EOjB7BOHA3ZR
         Jm+8A8ATpiIRGwf/EF3cu6iJGpVFfc0iQ/e0hTPB7HjocD55NesxDCBDRlAIPIVmePyp
         OdmtRxO2RTM7zL2ukZuDOyLCFRO+LbHP1LA5DLoGFm075ufCVJ3VwnPisR8rVDVQgrUP
         H3D6YEfI9NCa9Tr8W50gtfGlORguRYT822DuG3RX7sGRIauW9lDNUEr4TziefOxARapx
         yDrA==
X-Gm-Message-State: APjAAAWUQGixpdBPDiE+vyeAUtHQ+MnCLhA6wQEWCXMhxm4PGaVk0v1Z
        u8hA3eQFaZpwvyCKFAjHkpc=
X-Google-Smtp-Source: APXvYqw+e0HFH9QwUR8mjYfK9blM+oqUtgx1eyXl2ipFOgW4T7fd1EHPAWt1uyuJFEF6H9fQKU2I9g==
X-Received: by 2002:a17:906:3c5:: with SMTP id c5mr12266388eja.24.1552949328732;
        Mon, 18 Mar 2019 15:48:48 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id p4sm2667884eja.40.2019.03.18.15.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 15:48:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 3/4] gc docs: de-duplicate "OPTIONS" and "CONFIGURATION"
References: <20190318161502.7979-1-avarab@gmail.com> <20190318161502.7979-4-avarab@gmail.com> <20190318214905.GG29661@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190318214905.GG29661@sigill.intra.peff.net>
Date:   Mon, 18 Mar 2019 23:48:46 +0100
Message-ID: <87ef73er3l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 18 2019, Jeff King wrote:

> On Mon, Mar 18, 2019 at 05:15:01PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> In an earlier commit I started including the "gc.*" documentation from
>> git-config(1) in the git-gc(1) documentation. That still left us in a
>> state where the "--auto" option and "gc.auto" were redundantly
>> discussing the same thing.
>>
>> Fix that by briefly discussing how the option itself works for
>> "--auto", and for the rest referring to the configuration
>> documentation.
>>
>> This revealed existing blind spots in the configuration documentation,
>> move over the documentation and reword as appropriate.
>
> Nice improvement. A few comments:
>
>> diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
>> index a834a801cd6..605e14bc80b 100644
>> --- a/Documentation/config/gc.txt
>> +++ b/Documentation/config/gc.txt
>> @@ -19,13 +19,27 @@ gc.auto::
>>  	objects in the repository, `git gc --auto` will pack them.
>>  	Some Porcelain commands use this command to perform a
>>  	light-weight garbage collection from time to time.  The
>> -	default value is 6700.  Setting this to 0 disables it.
>> +	default value is 6700.
>> ++
>> +Setting this to 0 disables not only automatic packing based on the
>> +number of loose objects, but any other heuristic `git gc --auto` will
>> +otherwise use to determine if there's work to do, such as
>> +`gc.autoPackLimit`.
>> ++
>> +The repacking of loose objects will be performed with `git repack -d
>> +-l`.
>
> I know this last sentence came from the existing documentation, but I
> wonder if we should be more vague here. We'd pack with "repack -dl" when
> we have just loose objects, and "repack -Adl" when we have too many
> packs. Or "repack -adl" if we're pruning now, and "--unpack-unreachable"
> otherwise.
>
> I think the point of git-gc is that you don't have to care about that
> stuff. It works magically, and if you are implementing your own custom
> gc scheme, then you are probably better off reading the output of
> GIT_TRACE or looking at the source, rather than this documentation.

Yeah I can just drop it while I'm at it. Was just losslessly trying to
port the existing docs.

>>  gc.autoPackLimit::
>> +
>>  	When there are more than this many packs that are not
>
> What's this newline for? I'm not completely opposed if that's the style
> we want, but it seems odd that just this one has a blank between the
> variable name and the text.

Mistake, will fix.

>>  	marked with `*.keep` file in the repository, `git gc
>>  	--auto` consolidates them into one larger pack.  The
>> -	default	value is 50.  Setting this to 0 disables it.
>> +	default value is 50.  Setting this (or `gc.auto`) to 0
>> +	disables it. Packs will be consolidated using the `-A` option
>> +	of `git repack`.
>
> If we do revise the "-d -l" bit for the loose limit, we'd probably want
> to adjust this to match.

Or not mention it either?

>> @@ -35,13 +49,18 @@ gc.bigPackThreshold::
>>  	If non-zero, all packs larger than this limit are kept when
>>  	`git gc` is run. This is very similar to `--keep-base-pack`
>>  	except that all packs that meet the threshold are kept, not
>> -	just the base pack. Defaults to zero. Common unit suffixes of
>> -	'k', 'm', or 'g' are supported.
>> +	just the base pack. Defaults to zero or a memory heuristic.
>> +	Common unit suffixes of 'k', 'm', or 'g' are supported.
>
> I'm not sure how to read this "or". What's the difference between "0" or
> the memory heuristic, and when is one used? Or is that what the "if the
> number of kept packs is more than..." below is trying to say?

That by default we don't use gc.bigPackThreshold, unless we find that
you're under memory pressure. I.e. "it's off by default, unless your
system has too little memory".

> If so, I wonder if it would be simpler to say "defaults to a memory
> heuristic", but with a note for "but under these conditions it is not
> used".
>
> Or am I totally misunderstanding how it actually works (which seems
> likely to me)?
>
>> +If the amount of memory is estimated not enough for `git repack` to
>> +run smoothly and `gc.bigPackThreshold` is not set, the largest pack
>> +will also be excluded (which is the equivalent of running `git gc`
>> +with `--keep-base-pack`).
>
> I had trouble parsing this first line. Maybe:
>
>   If the amount of memory estimated for `git repack` to run smoothly is
>   not available and ...
>
> I guess a lot of this is just being copied from elsewhere, but it's
> probably worth cleaning it up while we're here.

Will try to make it suck less.

>> --- a/Documentation/git-gc.txt
>> +++ b/Documentation/git-gc.txt
>> [...]
>> +See the `gc.auto' option in the "CONFIGURATION" below for how this
>> +heuristic works.
>
> s/CONFIGURATION/& section/?
>
>> +Once housekeeping is triggered by exceeding the limits of
>> +configurations options such as `gc.auto` and `gc.autoPackLimit`, all
>
> s/configurations/configuration/

*Nod*. Thanks.
