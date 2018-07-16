Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A67F1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbeGPXgT (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:36:19 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38926 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeGPXgT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:36:19 -0400
Received: by mail-vk0-f65.google.com with SMTP id e139-v6so21121022vkf.6
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3vQix6ssOBdVEZ9zjPTQaz9T8RBYdMZDHR8TCi3gTWQ=;
        b=VNYtAjYnvCXF0TcSjeBovbdPlVmb8eQfA6p5xsdeyoIS0ivYAWMVOLyeYUEOZ7Diyj
         SLWx3f1snPatvdRO15f3iknlcIcXZC9n4MoZFAjWUqrgsgQvYukqZykpocoHqbn/Siyc
         B/54Z6WEsVD8O03+vJMe/uPtCTKRcYC1N7k47ITW4Rw27AscKY2MvBTPQzDvgsxO20Us
         ywPz3bYBcjfQFKyIs+zdVlQoEWdgMZkaaxbvESy9li05oFWH408rg5+fdCQ3MrRZDW7Y
         PbFuCEcU6a/w5LbbYr5NNmoF3l9euHhf4H1V6qs3cV90G87YknPl6boSPezm0c4lmQQu
         VD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3vQix6ssOBdVEZ9zjPTQaz9T8RBYdMZDHR8TCi3gTWQ=;
        b=BcEHmXVDa57CJxkOYT6l0M4rLOs+K5GZH4uRU/XVdhykYMy3e4gWkzxHhr829tJn54
         TYCmSfGN0kcDqD2N2j9yrpdsTadyuGZK74ZAFVDzVP45f4cLvT5I930QLF8+A90xMShi
         +sqT5fpaMJiJI0AX7h0l/+VmTZReed8kyo9O7Sz73K9jxvfaA6goTtNVRlieEg6+YW97
         ixPetkvENUz53tXEB93jyF2TFpxxVsw2rxssCt8K0f/1qNC2/PKwvq/iaOkGWUBEznOG
         TB4AYrrts4h06H47dtrUPWTgAPsKw1ObKxK1gKIqVR/ZKXl7l7sfJLvMLJFGpkOXEZ5G
         ByYA==
X-Gm-Message-State: AOUpUlFuJM/V7xQT0RHvHsCGvU/ZVeSyAuKPHOZAToqSmgyJMyQfYkO7
        qQ/z4wIXh6VHmMzBtxoMNhGlniGlj04cmf1ZAH0=
X-Google-Smtp-Source: AAOMgpflfX2FiHrh/qZ/ir6hHFJr/fZl7EcXMymeLXTzP2eec6i155kCcBJJqRdA9ipBrPJcLml544wq9zGYG5jegGE=
X-Received: by 2002:a1f:3a89:: with SMTP id h131-v6mr9770050vka.184.1531782403099;
 Mon, 16 Jul 2018 16:06:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:10e5:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 16:06:42
 -0700 (PDT)
In-Reply-To: <20180716225520.GC12482@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com> <20180716195226.GB25189@sigill.intra.peff.net>
 <CABPp-BGdzyhPkFYyocqArtMX8=cDKFuV88q3mboeaTDjt275Tw@mail.gmail.com>
 <20180716203847.GE25189@sigill.intra.peff.net> <CABPp-BEpCF9FE7eJwZWjY+bMsjDQnnDaSrHO+e3DtDDsR-=7Hg@mail.gmail.com>
 <20180716212159.GH25189@sigill.intra.peff.net> <CABPp-BHFinoE1=1bOhiwOrYpLB+kB3yAKbNg77K9kqKDH_1JLA@mail.gmail.com>
 <20180716225520.GC12482@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Jul 2018 16:06:42 -0700
Message-ID: <CABPp-BFnMLAzsHO6ksA26sOMwSCy_-LvBfe=izxFxrFVteuTVA@mail.gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 3:55 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 16, 2018 at 03:07:34PM -0700, Elijah Newren wrote:
>
>> > If we were to delete those objects, wouldn't it be exactly the same as
>> > running "git prune"? Or setting your gc.pruneExpire to "now" or even "5
>> > minutes"?  Or are you concerned with taking other objects along for the
>> > ride that weren't part of old reflogs? I think that's a valid concern,
>>
>> Yes, I was worried about taking other objects along for the ride that
>> weren't part of old reflogs.
>>
>> > but it's also an issue for objects which were previously referenced in
>> > a reflog, but are part of another current operation.
>>
>> I'm not certain what you're referring to here.
>
> I mean that an ongoing operation could refer to a blob that just
> recently became unreachable via reflog pruning. And then we would delete
> it, leaving the repository corrupt.
>
> One of the protections we have against that is that if I ask to write
> blob XYZ and we find that we already have the object, Git will freshen
> the mtime of the loose object or pack that contains it, protecting it
> from pruning. But with your suggestion, we'd delete it immediately,
> regardless of the mtime of the containing pack.
>
> Another way to think of it is this: a reflog mentioning an object does
> not mean it is the exclusive user of that object. So when we expire it,
> that does not mean that it is OK to delete it immediately; there may be
> other users.
>
>> > Also, what do you do if there weren't reflogs in the repo? Or the
>> > reflogs were deleted (e.g., because branch deletion drops the associated
>> > reflog entirely)?
>>
>> Yes, there are issues this rule won't help with, but in my experience
>> it was a primary (if not sole) actual cause in practice.  (I believe I
>> even said elsewhere in this thread that I knew there were unreachable
>> objects for other reasons and they might also become large in number).
>> At $DAYJOB we've had multiple people including myself hit the "too
>> many unreachable loose objects" nasty loop issue (some of us multiple
>> different times), and as far as I can tell, most (perhaps even all) of
>> them would have been avoided by just "properly" deleting garbage as
>> per my object-age-is-reflog-age-if-not-otherwise-referenced rule.
>
> I agree with you that this is a frequent cause, and probably even the
> primary one. But my concern is that your loosening increases the risk of
> corruption for other cases.
>
>> > I assume by "these objects" you mean ones which used to be reachable
>> > from a reflog, but that reflog entry just expired.  I think you'd be
>> > sacrificing some race-safety in that case.
>>
>> Is that inherently any more race unsafe than 'git prune
>> --expire=2.weeks.ago'?  I thought it'd be racy in the same ways, and
>> thus a tradeoff folks are already accepting (at least implicitly) when
>> running git-gc.  Since these objects are actually 90 days old rather
>> than a mere two weeks, it actually seemed more safe to me.  But maybe
>> I'm overlooking something with the pack->loose transition that makes
>> it more racy?
>
> I think it's worse in terms of race-safety because you're losing one of
> the signals that users of the objects can provide to git-prune to tell
> it the object is useful: updating the mtime. So yes, you think of the
> objects as "90 days old", but we don't know if there are other users.
> Has somebody else been accessing them in the meantime?
>
> To be honest, I'm not sure how meaningful that distinction is in
> practice. The current scheme is still racy, even if the windows are
> shorter in some circumstances. But it seems like cruft packfiles are
> a similar amount of work to your scheme, cover more cases, and are
> slightly safer. And possibly even give us a long-term route to true
> race-free pruning (via the "garbage pack" mark that Jonathan mentioned).
>
> Assuming you buy into the idea that objects in a cruft-pack are not
> hurting anything aside from a little wasted storage for up to 2 weeks
> (which it sounds like you're at least partially on board with ;) ).

Ah, I see now.  Thanks (to you and Jonathan) for the thorough
explanations.  I'm totally on board now.
