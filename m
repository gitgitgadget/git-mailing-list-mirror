Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E6E1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 18:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfBFSgd (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 13:36:33 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:45224 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfBFSgd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 13:36:33 -0500
Received: by mail-ed1-f51.google.com with SMTP id t6so5505437edw.12
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3QfHpN9hIY0ZA/O8LB3XiBumlqR7UrGqp9CUeSjpACg=;
        b=qXh6/1R9pXl1nrfrU65mS6exeyvfJWqj67ANeh6/ltvDIOZKTFjWG3ECR1w8nGMRJE
         6lBXya20ZQV1aMnwxRSgkUFcvC/Bi8lW90qNA7tWQ4TncEyJYbACdUlSFmxOoaY0p/kj
         loCIbJ+SZXjFiQDYieE3fAbw+zzRXiZ5UK6Eos7HEq35ASYVL76mghd/bN1jntAH5dM8
         y/yk45u1Hw88n6ifCtQrwrgji83S7qV2fFywVFA1mAPiC549Wt6kHiZ2oMCjut93nQra
         cSGk3L5JJJaDQ6CP0iWYiRK5THd3tqmwcMI/0WysnV6OZ5/o8VC0DtbPErydCFyOnrNN
         7bSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3QfHpN9hIY0ZA/O8LB3XiBumlqR7UrGqp9CUeSjpACg=;
        b=ik3JQTraXf6Uc5hi8RVUPBe1DhemU51Dcd3idviRHDWelsbZvDxweuNf+F9TEmOsYg
         j6mg6bcK9fPSZDs3gpnWwtHwfp9ruQOAz6C1UGps35dmeDLGONOPgVOVXFxOmfhPOPRp
         2GZB0wf/UdHB9M7oMz5nU+uXPHGfWQLU8k09RuelPtSMz4a+k/rJnkHQ30SR5wfG2vtg
         c5xFwlLG7fvmwbuAyJX21Zu5C9uLCqn8VYaloZvRdsjKP8nliKRfw+KZJhrtlUk6dfzr
         Pdh0YBBv70Qc9f/QM1Ae6fftNZ9lW6N1ktOWShR3TedZ9JRHI1NhrnMO5NCaiU9D8OLd
         VkXA==
X-Gm-Message-State: AHQUAuaB82y/EkR3qBDyo7JUchOpgYkp97Ys+R6QIJPGtpoo5NWmEri5
        Kp/n4t1LzWdY1GyLPenMEus=
X-Google-Smtp-Source: AHgI3IZlFm9fPzgRuFxEqvCmLGbiUtjJlkiNYbgU+4XTxs1M6qwKFaYc6pYW6pOSWR/pVNULia5bpw==
X-Received: by 2002:a17:906:12cf:: with SMTP id l15mr3650561ejb.31.1549478191349;
        Wed, 06 Feb 2019 10:36:31 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b9sm6457315ede.12.2019.02.06.10.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:36:30 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] core.abbrev doc: document and test the abbreviation length
References: <20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net> <20190204161217.20047-1-avarab@gmail.com> <xmqq36p3uxq2.fsf@gitster-ct.c.googlers.com> <20190204233235.GB2366@sigill.intra.peff.net> <87r2cnkta8.fsf@evledraar.gmail.com> <20190206182950.GB10231@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190206182950.GB10231@sigill.intra.peff.net>
Date:   Wed, 06 Feb 2019 19:36:29 +0100
Message-ID: <87ftt0lq6q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 06 2019, Jeff King wrote:

> On Tue, Feb 05, 2019 at 12:50:23AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >> As this is pretty-much a test-only option, perhaps going longer but
>> >> more descriptive would make sense?
>> >>
>> >> 	git rev-parse --compute-abbrev-length-for <object-count>
>> >>
>> >> may be an overkill, but something along those lines.
>> >
>> > You could even default <object-count> to the number of objects in the
>> > repository. Which implies that perhaps the best spot is the command
>> > where we already count the number of objects, git-count-objects.
>>
>> That's documented as reporting loose objects by default, although it has
>> a full report with -v.
>
> True, though I think that's mostly for historical reasons. It _could_ be
> part of the full report, like:
>
>   $ git count-objects -v
>   ...
>   abbrev-len: 12
>
> but from your test-script usage, I'd expect you'd want to be able to
> feed a fake count to it, like:
>
>   git count-objects --compute-abbrev-len=3D1234

Yeah for just reporting it count-objects makes more sense. I think I'll
add it there...

> or something (of course you _could_ also make a repository with N
> objects, but that's a lot more expensive).

...but yes, for the test script & to export the info I'd like to have
the "what's the abbrev length for a repo with N objects" option, which
would be for rev-parse.

>> Maybe rev-parse isn't the right place, I just picked it because it seems
>> to be the general utility belt for stuff that doesn't fit elsewhere.
>>
>> But putting it in git-count-objects seems like a bit more of a stretch
>> given the above.
>
> I dunno. It seems like less of a stretch to me, but it is true that
> rev-parse is already a kitchen sink repository. I can live with it
> either way.
>
> -Peff
