Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1771F453
	for <e@80x24.org>; Sat, 10 Nov 2018 15:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeKKBiJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 20:38:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43021 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbeKKBiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 20:38:09 -0500
Received: by mail-ed1-f68.google.com with SMTP id e4so4048011edv.10
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 07:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sZeNTZa9gqvMAFATKCKGpYrzrXJ1jE84BGdloYQEkyk=;
        b=CJnnMfELEMCG46OQeW1hHj7QKNsmQyh130E3b+iQw8LSDH2wqhnwI+5OPuMEtuyd9V
         SO5TSk5XSdZWFOK7EEpkNac+iZcyki7ARRfriX5/6FZFAtyQMcR/Ni1HAbc2a0zv4Zbv
         NZYuz/ft0SydObmQAlGWtOymBi6HOJE9jvh0PwEypma2/zOeenDrFFOoHd38BX0128XL
         0EV+bvPliwyOzd2VhfJbcMGHLgaOCofPfnDppRIabj0XCYstTK+hsdOhL6d/iqfz41RK
         WyzoSn1YYuZOXw4y8VXRMMWvMn3i6kO4/gELnOprUgCfDOW91AjTONRp6M6hSLj6naH8
         YHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=sZeNTZa9gqvMAFATKCKGpYrzrXJ1jE84BGdloYQEkyk=;
        b=oy4m+o4ZjYdz3byIFshVNnQLsg6+X/w9KhSpmPzpfjmoQ9irSXWtCxlv1hMLh6ms5r
         WF2YOJHXRUpC3yQfvquhjSraaG1dtDOtWdIUay/jZDs8NgEfvXfWTZvwM2tdPUjJzcwM
         6+X+gM9ACwIEnL2B7h4rmSdFeeQIpNGwGf/MJ0vU9qAGMUrwr7vAc+BSavJ+NYUQBBG0
         TYyRkIAueTz1ks0zuE9cdBMo2oohoMkpdaKgj4O06Vm6MiV4RlXYVAP511pr5UFJ0+BB
         1sBQzgb9mjDHPoNF2uPznwJO2oaCoIjUXGK+he2PfBU5sAC2rcXfhPT6MMMVmWHdOj+U
         q2HA==
X-Gm-Message-State: AGRZ1gLY+0CSdke3lEwo0CRkxG0m4aFtmeGB4xn+QECVVF67N1fgSIfO
        XDTKecZ/AZpGArbqJeyivl+qiig6
X-Google-Smtp-Source: AJdET5cSVVsTjyxgpkQ1xd/uPUlr2/w23EvFGV1QMBa9+ErGfdacinhqf5TwEEQU0XWt0F0M84y3vg==
X-Received: by 2002:a17:906:e1d4:: with SMTP id gp20-v6mr5013750ejb.221.1541865159957;
        Sat, 10 Nov 2018 07:52:39 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id f5-v6sm2977158edi.85.2018.11.10.07.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 07:52:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 10/12] Add a base implementation of SHA-256 support
References: <20181025024005.154208-1-sandals@crustytoothpaste.net> <20181104234458.139223-1-sandals@crustytoothpaste.net> <20181104234458.139223-11-sandals@crustytoothpaste.net> <87h8gv7nz1.fsf@evledraar.gmail.com> <20181107013026.GD890086@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181107013026.GD890086@genre.crustytoothpaste.net>
Date:   Sat, 10 Nov 2018 16:52:37 +0100
Message-ID: <878t2153qy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 07 2018, brian m. carlson wrote:

> On Mon, Nov 05, 2018 at 12:39:14PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> On Sun, Nov 04 2018, brian m. carlson wrote:
>> > +	{
>> > +		"sha256",
>> > +		/* "s256", big-endian */
>>
>> The existing entry/comment for sha1 is:
>>
>> 		"sha1",
>> 		/* "sha1", big-endian */
>>
>> So why the sha256/s256 difference in the code/comment? Wondering if I'm
>> missing something and we're using "s256" for something.
>
> Ah, good question.  The comment refers to the format_id field which
> follows this comment.  The value is the big-endian representation of
> "s256" as a 32-bit value.  I picked that over "sha2" to avoid confusion
> in case we add SHA-512 in the future, since that's also an SHA-2
> algorithm.
>
> Config files and command-line interfaces will use "sha1" or "sha256",
> and binary formats will use those 32-bit values ("sha1" or "s256").

Okey.

>> >  const char *empty_tree_oid_hex(void)
>> > diff --git a/sha256/block/sha256.c b/sha256/block/sha256.c
>> > [...]
>>
>> I had a question before about whether we see ourselves perma-forking
>> this implementation based off libtomcrypt, as I recall you said yes.
>
> Yes.
>
>> Still, I think it would be better to introduce this in at least two-four
>> commits where the upstream code is added as-is, then trimmed down to
>> size, then adapted to our coding style, and finally we add our own
>> utility functions.
>
> At this point, the only code that's actually used from libtomcrypt is
> the block transform.  The upstream code is split over multiple files in
> multiple directories and won't compile in our codebase without many
> files and a lot of work, so I don't feel good about either including
> code that doesn't compile or including large numbers of files that don't
> meet our coding standards (and that may still not compile because of
> platform issues).
>
>> It'll make it easier to forward-port any future upstream changes.
>
> I don't foresee many, if any, changes to this code.  It either
> implements the specification or it doesn't, and it's objectively easy to
> determine which.  There's not even an argument to port performance
> improvements, since almost everyone will be using a crypto library to
> provide this code because libraries perform so dramatically better.
> I've tried to not make the code perform worse than it did originally,
> but that's it.
>
> Furthermore, the modified code carries a relatively small amount of
> resemblance to the original, so if we did port changes forward, we'd
> probably have conflicts.
>
> It seems like you really want to include the upstream code as a separate
> commit and I understand where you're coming from with wanting to have
> this split out into logical commits, but due to the specific nature of
> this code, I see a lot of downsides and not a lot of upsides.

Yeah sorry to keep bringing this up. Your way makes sense, and I'd
forgotten the details since last time . I'll shut up about it:)

>> > +	perl -E "for (1..100000) { print q{aaaaaaaaaa}; }" | \
>> > +		test-tool sha256 >actual &&
>> > +	grep cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0 actual &&
>> > +	perl -E "for (1..100000) { print q{abcdefghijklmnopqrstuvwxyz}; }" | \
>> > +		test-tool sha256 >actual &&
>>
>> I've been wanting to make use depend on perl >= 5.10 (previous noises
>> about that on-list), but for now we claim to support >=5.8, which
>> doesn't have the -E switch.
>
> Good point.  I'll fix that.  After having written a lot of one-liners,
> I always write -E, and this was originally a one-liner.
>
>> But most importantly you aren't even using -E features here, and this
>> isn't very idoimatic Perl. Instead do, respectively:
>>
>>     perl -e 'print q{aaaaaaaaaa} x 100000'
>>     perl -e "print q{abcdefghijklmnopqrstuvwxyz} x 100000"
>
> I considered the more idiomatic version originally, but the latter could
> allocate a decent amount of memory in one chunk, and I wanted to avoid
> that.

~2.5MB for the latter, so trivial.

> I think what I'd like to do, actually, is turn on autoflush and
> use a postfix for, which would be more idiomatic and could potentially
> provide better testing of the chunking code.  I'll add a comment to that
> effect.

Okey. Maybe better to use syswrite() instead, or maybe print with
autoflush is more idiomatic, I don't know.
