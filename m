Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85A0C1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 22:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfARW0e (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 17:26:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46933 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbfARW0d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 17:26:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so12326633edt.13
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 14:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=/W+fcm5C5w57tYG0wo3P1UnYqgnf24paj81uZd7M1Ac=;
        b=knsVDFw3/IduTNL1yHaeUuen6VUH7Jy0vqHysO97N+2x8TqbTWWu1W3Dj0ARPvi0sY
         MMC0w2rUiZFz/PTXPuOiQHrNVyYQbBHhl78EdFd26J/CROJMO5lFyuQKXCVQbmL+hGL/
         rr9qsIn2dpjJJepK/nHclzSyEtI6PD2KGrlxDkD+XFdH+51lP/EFatxpvQR4bdeieaRJ
         vx6RnTL3pl39tSj3AhTHBLLV/M0DdvXd4QOyhBpf1/ZM+owd0I9DWuBUiZmerb2pDAzY
         Fux21K/kPWzfYDMCm/+GVbEO7+03+OrrVI44t9eKSLJZECBZtthvrPjx91/G1CQxo20W
         cC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=/W+fcm5C5w57tYG0wo3P1UnYqgnf24paj81uZd7M1Ac=;
        b=WX3CLISYMUVF357eYQJ1CJ1KzvAqkvtx1/4ArJ7lWlK3F4o35xdLqeNt/93FlPAT9e
         bttqi9dce4FvklGZ6K1jIO0GkrMe4h4+YkdNAOm/JRluKKH3/VMqQfg8EdFgMHxvgk8S
         yzxYCGYuUXJkH8s6jRYU5yHCpeGdCIt5D3NNtmO5uohEWoiwCwU7EfF0ll8rR8O5uxAw
         sFd2hHzEzQr/5QNM3T/MzBg+B1uQCuyvgBQHAKYjmNMADkWUTVFm0BD2EazGNg0hGxhX
         H7h5qaDOIVxHejMO0LXWhfHgWsv0KjBoFPlPq/FNcvmw+GzYmSuiZiCZ76KMHDtjL1Ba
         dFtQ==
X-Gm-Message-State: AJcUukfVBsO6HUrAeAafAsPGh3UUJFgWJw/ZkaX0ReZg3C7iNWjl7TBG
        kT8wDEy0w5NV2Jw/N2TzNv4=
X-Google-Smtp-Source: ALg8bN4JI0B5eP6Do1F9/R/x4GVshIwBVyAC/sVkYX4iUbCJD2gVq+Bt5lbApZJYEsSAj0IoL61hWg==
X-Received: by 2002:a17:906:5a11:: with SMTP id p17-v6mr15792040ejq.43.1547850391395;
        Fri, 18 Jan 2019 14:26:31 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id n3-v6sm3948215ejd.35.2019.01.18.14.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 14:26:30 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Barret Rhoden <brho@google.com>, git@vger.kernel.org,
        David Kastrup <dak@gnu.org>, Jeff Smith <whydoubt@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 1/3] Move init_skiplist() outside of fsck
References: <20190107213013.231514-1-brho@google.com>
        <20190117202919.157326-1-brho@google.com>
        <20190117202919.157326-2-brho@google.com>
        <87k1j247ui.fsf@evledraar.gmail.com>
        <xmqqzhrxlvfj.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1901182155020.41@tvgsbejvaqbjf.bet>
        <20190118213018.GA28808@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190118213018.GA28808@sigill.intra.peff.net>
Date:   Fri, 18 Jan 2019 23:26:29 +0100
Message-ID: <87h8e54n6y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 18 2019, Jeff King wrote:

> On Fri, Jan 18, 2019 at 09:59:21PM +0100, Johannes Schindelin wrote:
>
>> By that reasoning all the preparatory work for switching to SHA-256 and
>> making the references in the Git code base less tied to SHA-1 would be
>> irrelevant now, "because we can cross that bridge when we reach it".
>>
>> You are suggesting to incur technical debt here. Let's be smarter about
>> this. We do not *have* to incur said technical debt. Nothing (except
>> mental laziness) makes use do that.
>>
>> Instead, we can make our load "when we reach that bridge" a lot lighter
>> by already doing the right thing.
>>
>> BTW I totally disagree that the skip list is bound to be SHA-1. It is
>> bound to be a list of object names, that's what its purpose is, and just
>> because we happen to not yet support other hash algorithms but SHA-1 does
>> not mean that the skip list is fixed to SHA-1. It'll always be whatever
>> hash algorithm is used in the current repository.
>
> Yeah, I agree with this. In particular, the code has already been
> modified to use "struct object_id" and parse_oid_hex(). So it is not
> even like somebody will have to come through later and fix the
> implementation here, and while they're at it change the "SHA-1" in the
> message. It has literally already been fixed, and is just waiting on
> parse_oid_hex() to learn about the new hashes behind the scenes.
>
> IMHO the conversion to object_id probably would have been the time to
> fix that message so we would not even have to be revisiting the
> discussion now. But that conversion was such a monumental pain it is
> hard to fault the authors for not picking up every scrap at that moment. ;)
>
> That is no excuse not to do it now, though.

I stand corrected, I thought these still needed to be updated to parse
anything that wasn't 40 chars, since I hadn't seen anything about these
formats in the hash transition document.

So fair enough, let's change that while we're at it, but this seems like
something that needs to be planned for in more detail / documented in
the hash transition doc.

I.e. many (e.g. me) maintain some system-wide skiplist for strict fsck
cloning of legacy repos. So I can see there being some need for a
SHA1<->SHA256 map in this case, but since these files might stretch
across repo boundaries and not be checked into the repo itself this is a
new use-case that needs thinking about.

But now that I think about it this sort of thing would be a good
use-case for just fixing these various historical fsck issues while
we're at it when possible, e.g. "missing space before email" (probably
not all could be unambiguously fixed). So instead of sha256<->sha1
fn(sha256)<->fn(sha1)[1]?

1. https://public-inbox.org/git/87ftyyedqd.fsf@evledraar.gmail.com/
