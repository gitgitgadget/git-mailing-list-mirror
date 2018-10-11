Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67CE1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 17:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeJLBUn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 21:20:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37824 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeJLBUn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 21:20:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id c22-v6so9080243edc.4
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+yAIMgKgZ/gfJ7H3W8ec63yy8gWl0riIipH8gJmx0Q0=;
        b=qaRnGjiBn7pt9Z9Y4OP/d19PEDba+jbtWgKIKMRBqEbboGSI8eBjuvNilJ1oB1KVz4
         qcMWA7xcO5fP1W09g8rUA1Ix7zHFunCuYlD8TArPk8v4kU7brZ+VOn1dbsTpXA3fEdqE
         1rjoWiu9451g70Cy7nV7RMZ/VhEr62aKMzmrYbkP0qxMsyWnpiDsFoBFBSP9cCSnMJYB
         3nvYn9k/PRsjxPPwmZqBNk9Ir8vnGt+LI7ZxIbOVzYKQitMYTEDeualJi8BKaYSetyaX
         Ap0OuCmFxm3Fm5L3QW4THJ0iN/husOyI0hTQqdogSysNcWGDlrs5jcWsvzfBwQJEXDiN
         pStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+yAIMgKgZ/gfJ7H3W8ec63yy8gWl0riIipH8gJmx0Q0=;
        b=sPNB6qeNOuM+dy/+fBBF6Cgszhz2zBtFDLS2iNeP7vICUIAwr7a9pgwhrQVIHj7Fpa
         ZL9ayS+E1rJ+aAtIAH2LiTTGWwioFSZeeWTeppJRo8wKPO8PzB6Sp7OItdNG2GGZo/xw
         imSA9GX6SE+7TLa5gac5WlTGoUBD1gZkoiXoBtH7VBCREiA9ivT+cAh7C7op1Y03I38c
         N5G1E5S/SRp5FHLjsls60wzLkG9ufIC6MZveQch3UJ3KduG3G+zaHydL0hpesEDb0Uap
         6BuqDLDfVDYRrJ2I/dJtbTB37ZN8k26v90U25rziZtVgMYIps7k54jssSTtZFTbzNohS
         9cBA==
X-Gm-Message-State: ABuFfoh5UaDT2eniJtjMHtPWPPV0aPnwxW483qat602dDCiwncp0Vz3+
        8IFENTD9UaJt1aJG5FiyfzgBMTOXzs0=
X-Google-Smtp-Source: ACcGV632Kl2yoGANPQALKSmuDMqBWyDMYHkHmzx9NqW+SuEvDYIaYoDqcZGsor0E2tY4iuxZt+nYIw==
X-Received: by 2002:a50:8142:: with SMTP id 60-v6mr4314724edc.204.1539280343902;
        Thu, 11 Oct 2018 10:52:23 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id z33-v6sm9300643edb.85.2018.10.11.10.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 10:52:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/2] commit-graph write: add progress output
References: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com> <20180917153336.2280-2-avarab@gmail.com> <20181010203738.GE23446@szeder.dev> <87pnwhea8y.fsf@evledraar.gmail.com> <20181010221951.GG23446@szeder.dev> <87murle8da.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87murle8da.fsf@evledraar.gmail.com>
Date:   Thu, 11 Oct 2018 19:52:21 +0200
Message-ID: <87a7nke5gq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Ævar Arnfjörð Bjarmason wrote:

> On Wed, Oct 10 2018, SZEDER Gábor wrote:
>
>> On Wed, Oct 10, 2018 at 11:56:45PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>> On Wed, Oct 10 2018, SZEDER Gábor wrote:
>>
>>> >>  	for (i = 0; i < oids->nr; i++) {
>>> >> +		display_progress(progress, ++j);
>>>
>>> [...]
>>>
>>> > This display_progress() call, however, doesn't seem to be necessary.
>>> > First, it counts all commits for a second time, resulting in the ~2x
>>> > difference compared to the actual number of commits, and then causing
>>> > my confusion.  Second, all what this loop is doing is setting a flag
>>> > in commits that were already looked up and parsed in the above loops.
>>> > IOW this loop is very fast, and the progress indicator jumps from
>>> > ~780k right to 1.5M, even on my tiny laptop, so it doesn't need a
>>> > progress indicator at all.
>>>
>>> You're right, I tried this patch on top:
>>
>> [...]
>>
>>> And on a large repo with around 3 million commits the 3rd progress bar
>>> doesn't kick in.
>>>
>>> But if I apply this on top:
>>>
>> [...]
>>>
>>> I.e. start the timer after 1/4 of a second instead of 1 second, I get
>>> that progress bar.
>>>
>>> So I'm inclined to keep it. It just needs to be 4x the size before it's
>>> noticeably hanging for 1 second.
>>
>> Just to clarify: are you worried about a 1 second hang in an approx. 12
>> million commit repository?  If so, then I'm unconvinced, that's not
>> even a blip on the radar, and the misleading numbers are far worse.
>
> It's not a blip on the runtime, but the point of these progress bars in
> general is so we don't have a UI where there's no UI differnce between
> git hanging and just doing work in some tight loop in the background,
> and even 1 second when you're watching something is noticeable if it
> stalls.
>
> Also it's 1 second on a server where I had 128G of RAM. I think even a
> "trivial" flag change like this would very much change if e.g. the
> system was under memory pressure or was swapping.
>
> And as noted code like this tends to change over time, that loop might
> get more expensive, so let's future proof by having all the loops over N
> call the progress code.
>
> When I wrote this the intent was just "report progress". So that it's
> counting anything is just an implementation detail of how progress.c
> works now.
>
> This was the reference to Duy's patch, i.e. instead of spewing numbers
> at the user here let's just render a spinner. Then we no longer need to
> make judgement calls about which loop over N is expensive right now, and
> which one isn't, and if any of them will result in reporting a 2N number
> while the user might be more familiar with or expecting N.
>
>>> That repo isn't all that big compared to what we've heard about out
>>> there, and inner loops like this have a tendency to accumulate some more
>>> code over time without a re-visit of why we weren't monitoring progress
>>> there.
>>>
>>> But maybe we can fix the message. We say "Annotating commits in commit
>>> grap", not "Counting" or whatever. I was trying to find something that
>>> didn't imply that we were doing this once. One can annotate a thing more
>>> than once, but maybe ther's a better way to explain this...
>>
>> IMO just remove it.

Hrm, actually reading this again your initial post says we end up with a
2x difference v.s. the number of commits, but it's actually 3x. The loop
that has a rather trivial runtime comparatively is the 3x, but the 2x
loop takes a notable amount of time. So e.g. on git.git:

    $ git rev-list --all | wc -l; ~/g/git/git commit-graph write
    166678
    Annotating commits in commit graph: 518463, done.
    Computing commit graph generation numbers: 100% (172685/172685), done.
