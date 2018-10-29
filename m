Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DDA1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 19:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbeJ3EMS (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 00:12:18 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35084 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeJ3EMS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 00:12:18 -0400
Received: by mail-ed1-f54.google.com with SMTP id d6-v6so274103edi.2
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 12:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zuNMXoSVNjHQs+WZfOAvN8+MmdF/9cZ3cWU8rtkcYqw=;
        b=gFFKZBqQ5KSjJcFebfMvATo8wQLH5EzfByBm6H3I8OkSK8zK4e/SNy3y4RW55S/50I
         ImPryF5CZNarfzF1viLJ3I9KthVpmsejx9HIsQ/Ci5E03H2SC5bnt9xrkhyZTkD2I9T1
         7oQeGtrMfPmRwL41BkrP1bQTPgFeW13mjHueM07YIB1fzm0UwTdV4TcrB7bcZ6WuArHo
         VjVMiGYCeJ69tkHJy9VG7moARrOxu2w/vj3tulJ2y3u6BBlD754hrJB5t6MocoCwnOtZ
         30JfIGbDTNg7MSLPW6adqAKJU398MuTb1vrFe6S250M8Zg72UwFcK5O2C93y4WthW6nv
         nHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zuNMXoSVNjHQs+WZfOAvN8+MmdF/9cZ3cWU8rtkcYqw=;
        b=IBgedmS8djfXIjw0YIUC5ZuaQY84IKVWOr/y7ufDPa4NDVAreNgo6Bz4jtL+ISpMAD
         8tOY8Iyd7idZfZW6xqmKNAn2vw5qUqbQNfcV+uTyLBAQayFgXueSn3I64CKfbJjUMa43
         mkGfZtLMIqd+e9PLVgbKT2U7bWoEccXcx85aTKQgR8o0FueiKn/lWn/LSphhVUvZ6cIe
         Djep7qx5sxltXU5275YHIsmg47PPngogpqCnKtg5gY+sYIIO2gdVS5Fr6WYQgfSFwA/h
         RrB5LdmlewkVxrJ8Ux8JGnZIbZfDyF/BGt+LBc1IiIg7JpNQG6FKO4Bf4aC/815rwDr4
         M7/w==
X-Gm-Message-State: AGRZ1gIMhb8i6PH2oleSuRs3f+lvnoUtnoF9J+rPZ2Bru2j1R58JkgnT
        xJdi2tahVuUbKaSvQVrZBL4U27Y1sQhAg4EIEA9UWg==
X-Google-Smtp-Source: AJdET5cARTtIah8GSnoGBkJoS2jYlga4Cv5CB5MdlhEn+l3+UOWOvMFfkkFRiT+mnV0aWgBsX8i7f4TZnTQHLFIRHKA=
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17-v6mr11219757ejb.70.1540840934423;
 Mon, 29 Oct 2018 12:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
In-Reply-To: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 29 Oct 2018 12:22:03 -0700
Message-ID: <CAGZ79ka-FTqaXdrMixjUp2THJ3L0YvEnkKxs3XFgB3WEEy2-Tg@mail.gmail.com>
Subject: Re: [RFC] Generation Number v2
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Based on the performance results alone, we should remove minimum
> generation numbers, (epoch, date) pairs, and FELINE index from
> consideration. There are enough examples of these indexes performing
> poorly.
>
> In contrast, maximum generation numbers and corrected commit
> dates both performed quite well. They are frequently the top
> two performing indexes, and rarely significantly different.
>
> The trade-off here now seems to be: which _property_ is more important,
> locally-computable or backwards-compatible?
>
> * Maximum generation number is backwards-compatible but not
>    locally-computable or immutable.

These maximum generation numbers sound like the reverse of
the generation numbers as they are currently implemented, i.e.
we count all commits between the commit A and all heads.
How would this impact creation of a commit?

The current generation numbers can be lazily updated or not
updated at all. In my understanding of the maximum generation
numbers, a new commit would make these maximum generation
numbers invalid (i.e. they have to be recomputed).

Are there ways out by deferring the computation of maximum
generation numbers while still being able to work with some
commits that are un-accounted for?

When recomputing these numbers, the current generation number
(V0) has the property that already existing numbers can be re-used
as-is. We only need to compute the numbers for new commits,
and then insert this to the appropriate data structures (which is
a separate problem, one could imagine a split generation
numbers file like the split index)

For the V2 maximum generation numbers, would we need to
rewrite the numbers for all commits once we recompute them?
Assuming that is true, it sounds like the benchmark doesn't
cover the whole costs associated with V2, which is why the
exceptional performance can be explained.

(Note: The table as read in
https://public-inbox.org/git/6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com/
seems line broken, using gmails web interface is not good
for ASCII art and patches, git-send-email would fare better)

>
> * Corrected commit-date is locally-computable and immutable,
>    but not backwards-compatible.

How are these dates not backwards incompatible?
We don't have to expose these dates to the user, but
- just like generation numbers - could store them and use them
but not tell the user about it.

We would need to be really careful to not expose them at all
as they look like the real dates, so that could make for an
awkward bug report.

The approach of "corrected commit date" sounds like we could
have a very lazy approach, i.e. no extra data structures needed
for many commits (as the corrected date equals the real date)
and only need to store the corrections for some commits.
Such an approach however would not make it easy to know
if we operate on corrected dates, or if we even checked them
for correctness before.

So if we'd have an additional row in the generation numbers file
telling the corrected date, then we should be able to be backwards
compatible?
