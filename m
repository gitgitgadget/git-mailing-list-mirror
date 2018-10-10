Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566431F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 11:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJJTKJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 15:10:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52814 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJTKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 15:10:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so5132788wmw.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 04:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yzFqUiokXD2FU3F6NloKU1bI1OsH+T/yZfkGqnVOVzU=;
        b=IQAAXfS0f874i1gXWGAuLPD924zgwKz/Y3gHylmcfqOkSfipOhYTHAkoAaJdqGc3jm
         XP3IVacgsLGTkHr9LDA2/ZER1NBMldx8y09Ubs5Zrb5OlMuXQXp/x8OTI6FH+aQJWCR6
         Ci43pmIRvqiU4nbKoRm2Gk/Zu9nUJc3Fwc5tEm3L0tipVLJMLzWInsFgVc/eN2YMVS1N
         6qHwpVu+jNMV3VPTLRKrTXIMdexjhMDqng3RD0Qm5vkYQTOFnaYW24ywHRKxNBUu6/fx
         dhHPsQLf1tXPOurO8Ey5nanL80VsK34HCih+E9iGbdc9qS+inYjcffWQZtd0wQRr5BwS
         Y21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=yzFqUiokXD2FU3F6NloKU1bI1OsH+T/yZfkGqnVOVzU=;
        b=C03ia/HR6t6YUjYWDUpfVCFc+bLPiYAwduX+DGKhd4pvrlLQbE7fs0bY46dMCi23XC
         CpZQBHWirJKWA5TFCE3zGY1XvUHPGhSnCZG2t+LOcyuBEfk6hPbWlUCMcDW2ruFbvdvY
         ieP4Teg/tZRqGEj8AAUNWXv9i5BvTZumzi1+nNG4mRAwaMeSqnOvxD5uYGTYriUsT3r7
         o9O3KjxL83rV7azmcMLN76qlvK4pTVWLjS9SZGu6A6uAYNhrLh20UMXjyAn/kWLfBidn
         as5JvOckLgClM3FLhJL2nHAw3bhtWUGNq7TKJeIYLPvpoeSV8J9fDWy4WNqzvPojgYhN
         GQ5Q==
X-Gm-Message-State: ABuFfoh07nJf9Wj05aPLmQBXCQqfKzr8w3tTHZa08uHFjOQlnKKzgbxb
        bHKCSZbfYzEdYcndBYJFcmOgKA8nZg8=
X-Google-Smtp-Source: ACcGV63SB/q+OL9Q0vJL/kXtiIZLn1i/3LYy3cneomTm4Fklhli4rTBgvGnQFcL8vDzFhiGqM3KaBA==
X-Received: by 2002:a1c:578c:: with SMTP id l134-v6mr620888wmb.135.1539172100218;
        Wed, 10 Oct 2018 04:48:20 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id 12-v6sm21458326wms.11.2018.10.10.04.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 04:48:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, e@80x24.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git svn clone/fetch hits issues with gc --auto
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com>
        <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
        <20181009234502.oxzfwirjcew2sxrm@dcvr>
        <xmqqd0sims6s.fsf@gitster-ct.c.googlers.com>
        <CACPiFCL0oTjN+-aYgKEDtKC0gYwkv6RLMwakdJV85PJ5XQej6g@mail.gmail.com>
        <878t36f3ed.fsf@evledraar.gmail.com>
        <CACPiFCKMF2di=waQ5reRtjUFEjuE6DkxxLcN-YnF-SqgE_m=_Q@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACPiFCKMF2di=waQ5reRtjUFEjuE6DkxxLcN-YnF-SqgE_m=_Q@mail.gmail.com>
Date:   Wed, 10 Oct 2018 13:48:18 +0200
Message-ID: <875zyaf2f1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Martin Langhoff wrote:

> On Wed, Oct 10, 2018 at 7:27 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> As Jeff's
>> https://public-inbox.org/git/20180716175103.GB18636@sigill.intra.peff.net/
>> and my https://public-inbox.org/git/878t69dgvx.fsf@evledraar.gmail.com/
>> note it's a bit more complex than that.
>
> Ok, my bad for not reading the whole thread :-) thanks for the kind explanation.
>
>>  - The warning is actionable, you can decide to up your expiration
>>    policy.
>
> A newbie-ish user shouldn't need to know git's internal store model
> _and the nuances of its special cases_ got get through.

Oh yeah, don't get me wrong. I think this whole thing sucks, and as the
linked threads show I've run into various sucky edge cases of this.

I'm just saying it's hard in this case to remove one piece without the
whole Jenga tower collapsing, and it's probably a good idea in some of
these cases to pester the user about what he wants, but probably not via
gc --auto emitting the same warning every time, e.g. in one of these
threads I suggested maybe "git status" should emit this.

>
>>  - We use this warning as a proxy for "let's not run for a day"
>
> Oh, so _that's_ the trick with creating gc.log? I then understand the
> idea of changing to exit 0.
>
> But it's far from clear, and a clear _flag_, and not spitting again
> the same warning, or differently-worded warning would be better.
>
> "We won't try running gc, a recent run was deemed pointless until some
> time passes. Nothing to worry about."

Yup. That would be better. Right now we don't write anything
machine-readable to the log, and we'd need to start doing that. E.g. we
could just as well be reporting that gc --auto is segfaulting and that's
why you have all this garbage. We just "cat" it.

>>  - This conflation of the user-visible warning and the policy is an
>>    emergent effect of how the different gc pieces interact, which as I
>>    note in the linked thread(s) sucks.
>
> It sure does, and that aspect should be easy to fix...(?)
>
>> So it's creating a lot of garbage during its cloning process that can
>> just be immediately thrown away? What is it doing? Using the object
>> store as a scratch pad for its own temporary state?
>
> Yeah, thats suspicious and I don't know why. I've worked on other
> importers and while those needed 'gc' to generate packs, they didn't
> generate garbage objects. After gc, the repo was "clean".

I tried to find this out in my reply-to-myself in
https://public-inbox.org/git/877eiqf2nk.fsf@evledraar.gmail.com/

But as noted just looked at this briefly, and I don't use git-svn for
years now, so I don't know and might be missing something.
