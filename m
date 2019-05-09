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
	by dcvr.yhbt.net (Postfix) with ESMTP id 615AA1F45F
	for <e@80x24.org>; Thu,  9 May 2019 23:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfEIXVB (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 19:21:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35534 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfEIXVB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 19:21:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id p26so3527107edr.2
        for <git@vger.kernel.org>; Thu, 09 May 2019 16:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=84JX7jbJcw5SD2ueaND1PIXZ8cippOZ5Jr+Rssdy+v4=;
        b=tfOjzypGG9+wsMeP4sefXX+nHYWG+EaqnHrv+7cPFgMgKQ3s2dnankE51TSDsp7DFM
         q+QO9embCQ09PQOZaZnwa1rv7paiC3V+tUKxg5yP5YmNbewX2UVFTYxK+IOMDCIVIA76
         NfxAbphwpkhQ77BlMh0Gi6n5mJVxmVo3dI5xDjBTAo5D0wFN70m9X5BfvfUWy/3qsPiE
         e3T3c/nj/WV9OSMscK+MUWXsw7RXUeXO/YqXiv5vWiaaDSCD+UKvqOglBzj3o6w6z+aX
         6J2QttP3j/FlytVZpjukm40R+DLM4q46qQ3jNlFS0mfl62zrFIY2A425+iv5rwd53Bjs
         /FHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=84JX7jbJcw5SD2ueaND1PIXZ8cippOZ5Jr+Rssdy+v4=;
        b=VS1qGUS65qSr1dRAsFpGCllx6YlR1uqO8s8qxnlAHFr4QtZITMacOinlldwyA4IE5r
         Oz5PjFtSrwS9dDwImIc/b3tXIPv0nkEpmbPihRlbUYR6CRc68nB4YpsvuBPBMDLzf+wH
         FtXR86q27i+f8cSt9Zt2uw4uSmLAezUra7zGx5gg7U/EJe9ZBDkMR0ai7zvrMoH88bLf
         dlP+ynXHn0uztAChTINtuXCqFEGb7ZQpODH0hJ9cNG0ofJQZ/CG28hY3InP7lhVeLkk2
         SI9+kWRnRaDN0oZmizhZibsyVXETsLZmopDHZf9EuLmJ6jBI9bi+WY9tCcBJGq21P40K
         8Ybg==
X-Gm-Message-State: APjAAAUciFEH46edmDeDRsX2TbnE0Bzi60fUAZgkiRhrQsbWFBte5Hrq
        KhYcZheE08ztDYewt0zKz4Q=
X-Google-Smtp-Source: APXvYqxf27T5u7+04vmgkTeW0x77xHSnIFFJn5CvZOKn6Pr4q5C5mSQtbQ6aQQsl6SRiepuDv87y4w==
X-Received: by 2002:a50:86c9:: with SMTP id 9mr7141961edu.216.1557444058620;
        Thu, 09 May 2019 16:20:58 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id q11sm965720edd.51.2019.05.09.16.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 16:20:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 0/4] gc docs: modernize and fix the documentation
References: <20190318161502.7979-1-avarab@gmail.com>
        <20190318215107.GH29661@sigill.intra.peff.net>
        <87ftrjer8s.fsf@evledraar.gmail.com>
        <20190319001829.GL29661@sigill.intra.peff.net>
        <878svjj4t5.fsf@evledraar.gmail.com>
        <20190507075158.GG28060@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190507075158.GG28060@sigill.intra.peff.net>
Date:   Fri, 10 May 2019 01:20:55 +0200
Message-ID: <8736lnxlig.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 07 2019, Jeff King wrote:

> On Mon, May 06, 2019 at 11:44:06AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Maybe there's some case I haven't thought of that makes this stupid, but
>> I wonder if something like a "gc quarantine" might be a fix fo both of
>> the the issues you noted above.
>>
>> I.e. it seems to me that the main issue is that we conflate "mtime 2
>> weeks old because it's unreferenced for 2 weeks" v.s. "mtime 2 weeks old
>> because we haven't gotten around to a 'gc'".
>>
>> So in such a "gc quarantine" mode when we discover an object/pack that's
>> unreachable/purely made up of unreachable objects we'd move the relevant
>> loose object/"loose" pack to such a quarantine, which would just be
>> .git/unreferenced-objects/{??,pack}/ or whatever.
>>
>> AFAICT both cases you mentioned above would be mitigated by this because
>> we'd no longer conflate "haven't gc'd this yet and it's 2 weeks old"
>> v.s. "hasn't been referenced in 2 weeks".
>
> Michael Haggerty and I have (off-list) discussed variations on that, but
> it opens up a lot of new issues.  Moving something into quarantine isn't
> atomic. So you've still corrupted the repo, but now it's recoverable by
> reaching into the quarantine. Who notices that the repo is corrupt, and
> how? When do we expire objects from quarantine?
>
> I think the heart of the issue is really the lack of atomicity in the
> operations. You need some way to mark "I am using this now" in a way
> that cannot race with "looks like nobody is using this, so I'll delete
> it".
>
> And ideally without traversing large bits of the graph on the writing
> side, and without requiring any stop-the-world locks during pruning.

I was thinking (but realize now that I didn't articulate) that the "gc
quarantine" would be another "alternate" implementing a copy-on-write
"lockless delete-but-be-able-to-rollback scheme" as you put it.

So "gc" would decide (racily) what's unreachable, but instead of
unlink()-ing it would "mv" the loose object/pack into the
"unreferenced-objects" quarantine.

Then in your example #1 "wants to reference ABCD. It sees that we have
it." would race on the "other side". I.e. maybe ABCD was *just* moved to
the quarantine. But in that case we'd move it back, which would bump the
mtime and thus make it ineligible for expiry.

Similarly for example #2, the "ABCD is ancient" would be moved, but then
promptely moved back on the next GC as we notice ABCD has been
re-referenced.

Maybe it's just the same problem all over again, but I don't see how
yet.

Aside from that, I have a hunch that while it's theoretically true that
you can at any time re-reference some loose blob/tree/commit again, that
the likelyhood of that in practice goes down as it ages, since a user is
likely to e.g. re-push or rename some branch they pushed last week, not
last year.

Hence the mention of creating "unreferenced packs" with some new
--keep-unreachable mode. Since we'd pack those together they wouldn't
create the "ref explosion" problem we have with the loose refs, and thus
you could afford to keep them longer (even though the deltas would be
shittier).

Whereas now you either need --keep-unreachable (keep stuff forever) or a
more aggressive gc.pruneExpire if you'd like to not end up with a
ginormous amount of loose objects.

>> I started looking at this initially because I was wondering if the
>> --keep-unreachable mode you modified in e26a8c4721 ("repack: extend
>> --keep-unreachable to loose objects", 2016-06-13) could be made to write
>> out such "unreferenced" objects into their *own* pack, so we could
>> delete them all at once as a batch, and wouldn't create the "ref
>> explosions" mentioned in [1].
>>
>> But of course without an accompanying quarantine described above doing
>> that would just make this race condition worse.
>
> I'm not sure it really makes it worse. The pack would have the same
> mtime as the loose objects would.
