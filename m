Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA501F42D
	for <e@80x24.org>; Wed,  9 May 2018 10:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934677AbeEIKsa (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 06:48:30 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53122 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934458AbeEIKs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 06:48:28 -0400
Received: by mail-wm0-f45.google.com with SMTP id w194so23723346wmf.2
        for <git@vger.kernel.org>; Wed, 09 May 2018 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1B7OlIt8Lpd5Ps/BXvKp52V8cV8qSJtapdCKhJgSkvs=;
        b=uZVAps5KFGr2drntHs1HrhMZ6unv4Y+jDVS4wfVa72MBWrEt8yGlsH7zOYsa9feDIP
         hikpIsvTlPwEzlGRPnHe9zy3JetOszZ+06ii+r15FEGPaQfYr8mxCr20Evo2tj/kyes1
         F9r5n3x/HrVYioC/uppGoziBIetrChHBRwSUzoYqLg0IoHe8Ek6smhxCnVCSsqUIoqSG
         ECSm6ZaXqvSi4j4BVxK1vI+9NVidPBdCI+TMoOFcbRBWr+8T/MVmg0cAHU59YUx/1F9X
         D3VG17ZpCsBXiOglEV+OftkJZQt2VL1YsZHacNAe4m1UrabiFt0kfCjJPxw/i7+mPzsP
         lH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=1B7OlIt8Lpd5Ps/BXvKp52V8cV8qSJtapdCKhJgSkvs=;
        b=JS9UzUp+zMITcZFXbQBhIXB4GZN2/Rnd77q4VRhtGEVy6U/4Va36/JQ93uZVcZa20v
         Jhv9ljwqB6kK7s1WncggMVb7fuNuFr0aUHlCZxrn6IB5uLHlCaLARV88brIGvjise3os
         7NNs+JjNTiajH9iGwhGLJBsAd+V3uSayI+xSHOz+TAQf2m+UIp8b7OPzQCkfDsSou4IY
         Ub0xsPOSWTpYw3jKYFSakPL5gO/xiszalWy8M36ZsEZiPrCfXK4moHjj99xkTkwwd/hp
         H0pAEYqeGuk/voUZtu2J5lXSDbloevnYybaN3OxscHyM3N7UvJ+Bpj1jl9R0N1Tg8ZhI
         2Jmg==
X-Gm-Message-State: ALQs6tBD9/DjFgI/2arODH5hzV+K3TgsIT3uIjcqP5EHGWt/A3g2WWdC
        Z5+3clCRwGsoiCqCdA3vR6I=
X-Google-Smtp-Source: AB8JxZqIyfPtCJ2xPpFYp7Drf/hEl8xwiyeMT6wD6vXYL4ijGg8UzdT7An9vKnUK2z3pTTiJU3CXQg==
X-Received: by 2002:a50:b946:: with SMTP id m64-v6mr42000666ede.32.1525862906895;
        Wed, 09 May 2018 03:48:26 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id a2-v6sm11886604edn.25.2018.05.09.03.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 03:48:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 09/12] get_short_oid / peel_onion: ^{tree} should be tree, not treeish
References: <20180501184016.15061-1-avarab@gmail.com>
        <20180501120651.15886-1-avarab@gmail.com>
        <20180501184016.15061-10-avarab@gmail.com>
        <xmqqzi1htij7.fsf@gitster-ct.c.googlers.com>
        <87wowlxko8.fsf@evledraar.gmail.com>
        <xmqqvac4tb64.fsf@gitster-ct.c.googlers.com>
        <87lgczyfq6.fsf@evledraar.gmail.com>
        <xmqq6040qf8x.fsf@gitster-ct.c.googlers.com>
        <20180508143408.GA30183@sigill.intra.peff.net>
        <87a7tax9m1.fsf@evledraar.gmail.com>
        <20180509075632.GA3327@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180509075632.GA3327@sigill.intra.peff.net>
Date:   Wed, 09 May 2018 12:48:24 +0200
Message-ID: <878t8txfyf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 09 2018, Jeff King wrote:

> On Tue, May 08, 2018 at 08:53:10PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> >> "X^{tree}" should *RESULT* in a tree, but it should *REQUIRE* X to
>> >> be a tree-ish.  It is unclear "should be tree" is about the former
>> >> and I read (perhaps mis-read) it as saying "it should require X to
>> >> be a tree"---that statement is utterly incorrect as we agreed above.
>> >
>> > FWIW, I had the same feeling as you when reading this, that this commit
>> > (and the one after) are doing the wrong thing. And these paragraphs sum
>> > it up. The "^{tree}" is about asking us to peel to a tree, not about
>> > resolving X in the first place. We can use it as a _hint_ when resolving
>> > X, but the correct hint is "something that can be peeled to a tree", not
>> > "is definitely a tree".
>>
>> Maybe I'm just being dense, but I still don't get from this & Junio's
>> E-Mails what the general rule should be.
>
> Let me try to lay out my thinking a bit more clearly, and then I'll try
> to respond to the points you laid out below.
>
> Before we had any disambiguation code, resolving X^{tree} really was two
> independent steps: resolve X, and then peel it to a tree. When we added
> the disambiguation code, the goal was to provide a hint to the first
> step in such a way that we could never eliminate any resolutions that
> the user _might_ have meant. But it's OK to take a situation where every
> case but one would result in an error, and assume the user meant that
> case. Sort of a "do no harm" rule.
>
> By disambiguating with just a tree and not a tree-ish, that hint is now
> eliminating possibilities that would have worked in the second step,
> which violates the rule.
>
> Does thinking about it that way make more sense?

Okey, so to rephrase that to make sure I understand it. It would be
documented as something like this:

    When the short SHA-1 X is ambiguous X^{<type>} doesn't mean do the
    peel itself in X any way, rather it means list all those objects
    matching X where a subsequent X^{<type>} wouldn't be an error.

    I.e. X^{commit} will list tags and commits, since both can be peeled
    to reveal a commit, X^{tree} will similarly list tags, commits and
    trees, and X^{blob} will list tags and blobs[1], and X^{tag} will
    only list tags.

    But core.disambiguate=[tag|commit|tree|blob] is not at all like
    ^{[tag|commit|tree|blob]} and is unlike the peel syntax only going
    to list the objects of the respective type. The config synonym for
    the peel syntax is committish, treeish, and the nonexistent blobish.

>> I think a response to the part after "leaving that aside" of my upthread
>> E-Mail
>> (https://public-inbox.org/git/87lgczyfq6.fsf@evledraar.gmail.com/) would
>> help me out.
>
> I'll quote that bit here:
>
>> But *leaving that aside*, i.e. I don't see why the use-case would make
>> sense. What I *don't* get is why, if you think that, you only want to
>> apply that rule to ^{tree}. I.e. wouldn't it then be consistent to say:
>>
>>     # a)
>>     ^{tag}    = tag
>>     ^{commit} = tag, commit
>>     ^{tree}   = tag, commit, tree
>>     ^{blob}   = tag, blob (blobish)
>
> Yes, that makes sense to me conceptually, and would follow the rule I
> gave above. And I think that's what we do now, with the exception that
> there is no blobish disambiguation. Presumably nobody ever bothered
> because probably because tagged blobs are pretty rare (and obviously
> though trees point to blobs, you cannot disambiguate that way since
> there's no one-to-one correspondence).
>
> So I doubt anybody really cares in practice, but I agree that it would
> improve consistency to write a patch to introduce GET_OID_BLOBISH and
> have "^{blob}" parsing use it.  And possibly add "blobish" to
> core.disambiguate (or is it "blobbish"?), though that's almost certainly
> something nobody would ever use.

Yeah, I'll introduce it for consistency. To clarify I wasn't trying to
make some argument on the basis that we didn't have it, but I was
confused because I couldn't see how the general rule would apply to
^{tree} and not ^{blob}.

>> My understanding of what you two are saying is that somehow the peel
>> semantics should be preserved when we take this beyond the 1=1 mapping
>> case, but I don't see how if we run with that how we wouldn't need to
>> introduce the concept of blobish for consistency as I noted upthread.
>
> Yeah, I think the lack of blobish is a bug, just one that nobody has
> ever really cared about.
>
>> So it would be very useful to me if you or someone who understands the
>> behavior you & Junio seem to want could write a version of the patch I
>> have above where the last paragraph is different, and describes the
>> desired semantics, because I still don't get it. Why would we 1=many
>> peel commits to trees as a special case, but not 1=many do the same for
>> trees & blobs?
>
> I'm not sure I understand the mention of trees in the final sentence.
> AFAICT tree disambiguation is consistent with the peeling rules.

Yeah nevermind that, I was imagining some semantics where because we
dropped the 1=1 mapping ^{tree} would list blobs, but in the worldview
you describe above (if I got it right) that doesn't make sense.

1. Not currently, but I should amend my ^{blob} patch to work like that.
