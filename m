Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0252C1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 17:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbeCPRsR (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 13:48:17 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:35433 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeCPRsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 13:48:16 -0400
Received: by mail-ot0-f180.google.com with SMTP id r30-v6so11221753otr.2
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wBtP+A1QA0fiMWRt1u2/ypJi5TPqrQnpCKGhFrqUGVo=;
        b=OltJge104hNVaILYtAYq8WmelMJglGSGJsRCluoReuZ6uD6sB87L1PDZp4XBNeXxJM
         HPpyOCdcc3rTyfiy7kQXJfJ4J8tjF5cmTy1ERSjZUMRG3lsUCb5sxTxKzGE8Ea1F27rg
         wsA2TgBHN1QKRPz3vKFRH+aii/gOtpdJMjCoPA+JIDnKYvfvyLid33on2eTg9FKu3F3C
         9/mUlv/Bqiub2aTJKRppRrMlMRf8+CpMvoPveQixDOzXLgrxTpU9xPGmxBGxYskbt0Ni
         y2SbH+U0XYKwIQN1IgfkPp4WSM55Z8eqSe5K6w3Si6e7DIHzM880EPn42Jy61OrVCD0O
         GwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wBtP+A1QA0fiMWRt1u2/ypJi5TPqrQnpCKGhFrqUGVo=;
        b=A4Zox46eKw1rqRL7tdO9/l5EzYGHt+hPv6PuPmgU5nX70sH+P2fNWk1C+AeAZFDgeo
         Dw/RumIIeK8eiclpKVCuQVQwOVP8ZkZhqNHH3Aows1hDTWeEwoAzL9pGFsoMJnaJxAza
         pV1KOLWV8U/0DP1xY12iCd9h2SC+ujW2PxRvaM1kJVA1hATbz9r6xijRcp0Un6Dcbadh
         FRlyNH2AarWksdhid9SBUmZR0Z9Dt6v7Cs9sdjZHOY3B/WWEI4E/5wXoXAKfE32SmVvh
         DW7T9POwe2UQwHsD8JAxzmpfV61kjAeVzUIOA8flhmvIkZPi09uRcKJy5Kw0TjdXVd8M
         MmzQ==
X-Gm-Message-State: AElRT7EIgGdTHGAd7Q23LW3WOJ+g/8vPd2GDqpTZ3Mp6hih3iy7A6kQN
        wAFZBrQFO1nT477ghuvaNDxvE5kz+gaBbHyW/Co=
X-Google-Smtp-Source: AG47ELvIRsPPXYY/2ePIBHeuIyFuGMGvOYVUwLVlN5yH3G46r9A4bTvRcwZGdr/WUASbURoQiSj+u0fSTWnpwC4mfhw=
X-Received: by 2002:a9d:2eac:: with SMTP id w41-v6mr1856693ota.152.1521222495526;
 Fri, 16 Mar 2018 10:48:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Fri, 16 Mar 2018 10:47:44 -0700 (PDT)
In-Reply-To: <87muz9du0w.fsf@evledraar.gmail.com>
References: <20180301092046.2769-1-pclouds@gmail.com> <20180306104158.6541-1-pclouds@gmail.com>
 <20180306104158.6541-4-pclouds@gmail.com> <87a7vdqegi.fsf@evledraar.gmail.com>
 <CACsJy8DZGa8v6z6c3SUjENMd4h6Qi55iPfsT2c5-cejqv5jA2Q@mail.gmail.com> <87muz9du0w.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 18:47:44 +0100
Message-ID: <CACsJy8DCSQCAsLKx8PepyT_MbYSBuaArQc5CWBdxBM5svry56Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem to
 "repack -ad"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 8:21 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Mar 15 2018, Duy Nguyen jotted:
>
>> On Mon, Mar 12, 2018 at 8:30 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> We already have pack.packSizeLimit, perhaps we could call this
>>> e.g. gc.keepPacksSize=3D2GB?
>>
>> I'm OK either way. The "base pack" concept comes from the
>> "--keep-base-pack" option where we do keep _one_ base pack. But gc
>> config var has a slightly different semantics when it can keep
>> multiple packs.
>
> I see, yeah it would be great to generalize it to N packs.
>
>>> Finally I wonder if there should be something equivalent to
>>> gc.autoPackLimit for this. I.e. with my proposed semantics above it's
>>> possible that we end up growing forever, i.e. I could have 1000 2GB
>>> packs and then 50 very small packs per gc.autoPackLimit.
>>>
>>> Maybe we need a gc.keepPackLimit=3D100 to deal with that, then e.g. if
>>> gc.keepPacksSize=3D2GB is set and we have 101 >=3D 2GB packs, we'd pick=
 the
>>> two smallest one and not issue a --keep-pack for those, although then
>>> maybe our memory use would spike past the limit.
>>>
>>> I don't know, maybe we can leave that for later, but I'm quite keen to
>>> turn the top-level config variable into something that just considers
>>> size instead of "base" if possible, and it seems we're >95% of the way
>>> to that already with this patch.
>>
>> At least I will try to ignore gc.keepPacksSize if all packs are kept
>> because of it. That repack run will hurt. But then we're back to one
>> giant pack and plenty of small packs that will take some time to grow
>> up to 2GB again.
>
> I think that semantic really should have its own option. The usefulness
> of this is significantly diminished if it's not a guarantee on the
> resource use of git-gc.
>
> Consider a very large repo where we clone and get a 4GB pack. Then as
> time goes on we end up with lots of loose objects and small packs from
> pulling, and eventually end up with say 4GB + 2x 500MB packs (if our
> limit is 500MB).
>
> If I understand what you're saying correctly if we ever match the gc
> --auto requirements because we have *just* the big packs and then a
> bunch of loose objects (say we rebased a lot) then we'll try to create a
> giant 5GB pack (+ loose objects).

Yes. There isn't a simple and easy solution here and I consider
packing (even if it's expensive) to regain performance is better than
not packing at all. I could tweak that a bit by keeping the largest
pack out (so we have to packs in the end). After a long long long time
when your second pack gets to 5 GB, then we hit the most expensive
repack. But that should be ok for now, I guess.

I think this repack strategy was discussed here at some point in the
past by Gerrit guys. Their goal was to reduce I/O, I believe. A
perfect solution probably could be found, but I don't want to hold
this series back until it's found and I don't want to introduce a
zillion config knobs that become useless later on when the perfect
solution is found.

>>> Actually maybe that should be a "if we're that low on memory, forget
>>> about GC for now" config, but urgh, there's a lot of potential
>>> complexity to be handled here...
>>
>> Yeah I think what you want is a hook. You can make custom rules then.
>> We already have pre-auto-gc hook and could pretty much do what you
>> want without pack-objects memory estimation. But if you want it, maybe
>> we can export the info to the hook somehow.
>
> I can do away with that particular thing, but I'd really like to do
> without the hook. I can automate it on some machines, but then we also
> have un-managed laptops run by users who clone big repos. It's much
> easier to tell them to set a few git config variables than have them
> install & keep some hook up-to-date.

That sounds like we need a mechanism to push hooks (and config stuff)
automatically from clone source. I think this topic was touched in the
summit? I don't object adding new config but we need to figure out
what we need, and from this thread I think there are too many "I don't
know" to settle on a solution.
--=20
Duy
