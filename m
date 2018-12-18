Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580561F405
	for <e@80x24.org>; Tue, 18 Dec 2018 13:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeLRNKZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 08:10:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35259 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeLRNKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 08:10:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so2757938wmh.0
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 05:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RcnWGl6R35LGOTrq7q9U5v4YNsrviE1DyTgxMONVUGo=;
        b=e6fOfRe4yHl65e62CxMBkwzeTiJMYKQ23AiyMX1ERnexolxPSC3udwHwCO/uQgcNDA
         3eP+Mby0Ce4ncXVG6WzLgGV+soGAI6lZyI5WU/Z1h3cUs44NMuHu9hcXxik1/l+k0MI7
         GIHgw+43IZSpwcJDz3lRuLgFCJS4gYxCukr+/x5NZ0fwqAiEDfrKmlrJSV7BXHfY0NeU
         Ah+L+GybBF5WtE0Td1tE/AL7uuT7bcA9PJYc7sLS4DuEvLUWWt134ej+EteZhr+5/Mco
         Ls4s0TolSWWjIWJJOZKscMF1QdXGGNH9Kw6ZQdX88z7wNXHiQ9NpvF4FisdNG6QASS5B
         LpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RcnWGl6R35LGOTrq7q9U5v4YNsrviE1DyTgxMONVUGo=;
        b=frPcWdLmrxM3yhd05DoiqsfRogR11nKJqdop3MGADnnx6K+wsd1jHbvs0K163oKurC
         xHGlmxHyB8RDA+mdcwaoRD457t+1WkkR8d22z/ZRQzfNNVMyeef6rfg9LwlsnxsE9gzD
         5h1qKfJrfBb1XQg+XgbRLh3AZR6+JreHyb1P9QD6ld8BVo+JgAynJ6+ACxizhki3x/8W
         HbywZctJn12j1HOz9PXc6L2G0vshgubwLSC3XuMoaoYkL/wlV3Wqd8G178AkeeJKUW4/
         o/Wh77noo/uxIEzfedkFajGiudaHbrXWpckaZTSSjpj/HZ1fG1nJLLswFCJ0cKv7yqge
         W5xw==
X-Gm-Message-State: AA+aEWb6ArK14TKmRq2OSAUElh4YNtyds0ilm4uu2sraYVCD88sWhEWe
        WA8dC+Eo3zRFmlFHkzfyDOqOah8PGSg=
X-Google-Smtp-Source: AFSGD/Wxus4vEynIqRG1i8Q80TRqj8BTWgIouJKVZnsm7JRYIM4ouOohr2IuVJUk9WpAsshOA1BnUA==
X-Received: by 2002:a1c:7c0b:: with SMTP id x11mr3167137wmc.20.1545138622604;
        Tue, 18 Dec 2018 05:10:22 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id x81sm2429794wmg.17.2018.12.18.05.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 05:10:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com> <20181213155817.27666-9-avarab@gmail.com> <87pnu51kac.fsf@evledraar.gmail.com> <20181214101232.GC13465@sigill.intra.peff.net> <87o99o1iot.fsf@evledraar.gmail.com> <20181217195713.GA10673@sigill.intra.peff.net> <20181217231452.GA13835@google.com> <20181218123646.GA30471@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181218123646.GA30471@sigill.intra.peff.net>
Date:   Tue, 18 Dec 2018 14:10:19 +0100
Message-ID: <87d0pzf0as.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 18 2018, Jeff King wrote:

> On Mon, Dec 17, 2018 at 03:14:52PM -0800, Jonathan Nieder wrote:
>
>> > IMHO those security guarantees there are overrated (due to delta
>> > guessing attacks, though things are not quite as bad if the attacker
>> > can't actually push to the repo).
>>
>> Do you have a proof of concept for delta guessing?  My understanding
>> was that without using a broken hash (e.g. uncorrected SHA-1), it is
>> not feasible to carry out.
>
> I think we may be talking about two different things. I mean an attack
> where you want to know what is in object X, so you ask the server for
> object Y and tell it that you already have X. If the sender generates a
> delta against X, that tells you something about what's in X.
>
> For a pure read-only server, you're restricted to the Y's that are
> already in the repo. So how effective this is depends on what's in X,
> and what Y's are available.
>
> For a case where X is in a victim repo you cannot make arbitrary writes
> to, but you _can_ make the victim repo aware of other objects (e.g., by
> opening a pull request that creates a ref), then you can iteratively
> provide many Y's, improving your guess about X in each iteration.
>
> For a case where the victim repo has fully shared storage (GitHub, and
> probably other hosts; I'm not sure if it's available yet, but GitLab is
> clearly working on shared-storage too), you can probably skip all that
> and just push a ref pointing to X with an empty pack (Git just cares
> that it has all of the objects afterwards, not that you pushed them).
>
> None of those care about the quality of the hash (they do assume you
> know the hash of X already, but then so does fetching by object id).
>
> And no, I've never written a proof-of-concept for that. It would depend
> largely on the data you're trying to extract. E.g., if you think X
> contains "root:XXXXXX", then you might hope to ask for "root:AXXXXX",
> then "root:BXXXXX", etc. You know you've got a hit when the delta gets
> smaller. So the complexity for guessing N bytes becomes 256*N, rather
> than 256^N.
>
>> > But I agree that people do assume it's the case. I was certainly
>> > surprised by the v2 behavior, and I don't remember that aspect being
>> > discussed.
>>
>> IMHO it's a plain bug (either in implementation or documentation).
>
> Or both. :) The behavior and the documentation seem to agree.
>
>> [...]
>> >> I'm inclined to say that in the face of that "SECURITY" section we
>> >> should just:
>> >>
>> >>  * Turn on uploadpack.allowReachableSHA1InWant for v0/v1 by
>> >>    default. Make saying uploadpack.allowReachableSHA1InWant=false warn
>> >>    with "this won't work, see SECURITY...".
>> >>
>> >>  * The uploadpack.allowTipSHA1InWant setting will also be turned on by
>> >>    default, and will be much faster, since it'll just degrade to
>> >>    uploadpack.allowReachableSHA1InWant=true and we won't need any
>> >>    reachability check. We'll also warn saying that setting it is
>> >>    useless.
>> >
>> > No real argument from me. I have always thought those security
>> > guarantees were BS.
>>
>> This would make per-branch ACLs (as implemented both by Gerrit and
>> gitolite) an essentially useless feature, so please no.
>
> I think Ævar's argument is that those are providing a false sense of
> security now (at least for read permissions).
>
> Let me clarify my position a little.
>
> I won't claim the existing scheme provides _no_ value (especially the
> pure read-only case above is less dicey than the others). It's mostly
> that the protections are very hand-wavy. I don't trust them _now_, and I
> have little faith that other innocent-looking changes to the object
> negotiation and the packing code will not significantly weaken them.
> There's no security boundary expressed within Git's code, so there's a
> very high chance of information leaking accidentally. A trustable system
> would have boundaries built in from the ground up.
>
> Enough people seem to believe otherwise (i.e., that the hand-waving
> arguments are worth _something_) that I've never pushed to actually
> change the default behavior. But if Ævar wants to try to do so, I'm not
> going to stand in my way (hence my "no argument from me").

FWIW I don't really care about this, I don't rely on
uploadpack.allow{Tip,Reachable,Any}SHA1InWant=false I'm just on the
side-quest of:

  1. Try protocol v2
  2. Discover that v2 implictly has uploadpack.allowAnySHA1InWant=true
     enabled
  3. Some people (including Jonathan) can reasonable read our docs /
     seem to have understood this to be a security mechanism
  4. What are we going to do about that v1 & v2 discrepancy? [You are
     here!]

The genreal ways I see forward from that are:

 A) Say that v2 has a security issue and that this is a feature that
    works in some circumstances, but given Jeff's explanation here we
    should at least improve our "SECURITY" docs to be less handwaivy.

 B) Improve security docs, turn uploadpack.allowAnySHA1InWant=true on by
    default, allow people to turn it off.

 C) Like B) but deprecate
    uploadpack.allow{Tip,Reachable,Any}SHA1InWant=false. This is my
    patch upthread

 D-Z) ???


I'm not set on C), and yeah it's probably overzelous to just rip the
thing out, but then what should we do?

>> I would be all for changing the default, but making turning off
>> allowReachableSHA1InWant an unsupported deprecated thing is a step too
>> far, in my opinion.
>
> Yes, I agree if we were to go down this road, it probably makes sense to
> flip the knobs and let them be "unflipped" if the user wants.
>
>> Is there somewhere that we can document these kinds of invariants or
>> goals so that we don't have to keep repeating the same discussions?
>
> It's not clear to me that there's consensus on the invariants or goals.
> ;)
>
> -Peff
