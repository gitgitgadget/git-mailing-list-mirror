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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ED9E1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 07:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJKPDp (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 11:03:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35804 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKPDp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 11:03:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so8461493wrt.2
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 00:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XgdYq0AAv7UCQGh+BGpW6LhSgXbp+11nvdxidLCucaA=;
        b=YaJ8Ck0Qhhpr37S6Sy/Rs1xEgeymNImlWx3rsSfJZDSd2LsMbpmGrREamIkyeFkWf2
         2emTkaJn51FHgYsHBhRWM7f3gM2XA7rmcPtKNwbIdTo8ig0JvHSz+LT64zJhwl3MdI1g
         JWcv0AhD6DOM0pxIvR86OvtBg7TTnsNujZn6WD/xp8EYcF/UbYfTmo99hmN3GAtNhdyG
         1TmJhezJisQbbSakzLgOCB8U0SKAsftcvuad9W6H+Se5WRYxjXLDErq9OASGGn4Mm6It
         +19x02eSB2ZrY3k6XhohmA8HW22+lBm4nvvfjMJnG8ppJqHJHl4PaCGLjzk3SCi1dE+D
         Z2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XgdYq0AAv7UCQGh+BGpW6LhSgXbp+11nvdxidLCucaA=;
        b=uC7tEz0F8WcuPqSqX6h+7LiVmBt43v3zBc/dlaa2UQSmXRAUisXOh9b1kePCaVdib2
         rKt9OiszsrNvmsvX0bA52cLKsq+9HTBJYjFmB3k6Azru6PPxvfXABHZb4Zx3Z7bqvcCD
         sYLE6KC04cuW6Ex6s9W0oYaFoGN12KT5NxxUP77PJT8h9Y43Zs/U6aaW7MjhaH2SDugl
         F5CLoRytRo2qSMaZquBGAU1N5DJygrP1AAuNKnGwnuv4KlBmHstkfwQj8M7VT35bIvGT
         BrZYxFqfiaj4Sr8wiTeKmr7MdqcCijPQpCuuaGWkpkPUbUXQvWufB4WLmJi5TyXQ2AuU
         XrUw==
X-Gm-Message-State: ABuFfohHM8v1QrFKw9l34Vc16mTSD7Q/iZhG8unAU2QCiJ4vNPbB19Eg
        79IbvxwOWgO4zcOpuAuyjMY=
X-Google-Smtp-Source: ACcGV63+isK5RjgfJSY0/o7SDiq+du4tmBLhDNrflNn7RI6JtF3Mvv07cqnEh7CzxDeaunrFgsuMYQ==
X-Received: by 2002:adf:e7cb:: with SMTP id e11-v6mr471364wrn.27.1539243462352;
        Thu, 11 Oct 2018 00:37:42 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id l67-v6sm47532175wma.20.2018.10.11.00.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 00:37:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, stolee@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH 0/2] Per-commit filter proof of concept
References: <20181009193445.21908-1-szeder.dev@gmail.com> <cover.1539219248.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <cover.1539219248.git.jonathantanmy@google.com>
Date:   Thu, 11 Oct 2018 09:37:40 +0200
Message-ID: <87k1mpdjcr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 11 2018, Jonathan Tan wrote:

> Using per-commit filters and restricting the bloom filter to a single
> parent increases the relative power of the filter in omitting tree
> inspections compared to the original (107/53096 vs 1183/66459), but the
> lack of coverage w.r.t. the non-first parents had a more significant
> effect than I thought (1.29s vs .24s). It might be best to have one
> filter for each (commit, parent) pair (or, at least, the first two
> parents of each commit - we probably don't need to care that much about
> octopus merges) - this would take up more disk space than if we only
> store filters for the first parent, but is still less than the original
> example of storing information for all commits in one filter.
>
> There are more possibilities like dynamic filter sizing, different
> hashing, and hashing to support wildcard matches, which I haven't looked
> into.

Another way to deal with that is to havet the filter store change since
the merge base, from an E-Mail of mine back in May[1] when this was
discussed:

    From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    Date: Fri, 04 May 2018 22:36:07 +0200
    Message-ID: <87h8nnxio8.fsf@evledraar.gmail.com> (raw)

    On Fri, May 04 2018, Jakub Narebski wrote:

    (Just off-the cuff here and I'm surely about to be corrected by
    Derrick...)

    > * What to do about merge commits, and octopus merges in particular?
    >   Should Bloom filter be stored for each of the parents?  How to ensure
    >   fast access then (fixed-width records) - use large edge list?

    You could still store it fixed with, you'd just say that if you
    encounter a merge with N parents the filter wouldn't store files changed
    in that commit, but rather whether any of the N (including the merge)
    had changes to files as of the their common merge-base.

    Then if they did you'd need to walk all sides of the merge where each
    commit would also have the filter to figure out where the change(s)
    was/were, but if they didn't you could skip straight to the merge base
    and keep walking.
    [...]

Ideas are cheap and I don't have any code to back that up, just thought
I'd mention it if someone found it interesting.

Thinking about this again I wonder if something like that could be
generalized more, i.e. in the abstract the idea is really whether we can
store a filter for N commits so we can skip across N in the walk as an
optimization, doing this for merges is just an implementation detail.

So what if the bloom filters were this sort of structure:

    <commit_the_filter_is_for> = [<bloom bitmap>, <next commit with filter>]

So e.g. given a history like ("-> " = parent relationship)

    A -> B
    B -> C
    C -> D
    E -> F

We could store:

    A -> B [<bloom bitmap for A..D>, D]
    B -> C
    C -> D
    D -> E [<bloom bitmap for D..F>, F]
    E -> F
    F -> G [<bloom bitmap for F..G>, G]

Note how the bitmaps aren't evenly spaced. That's because some algorithm
would have walked the graph and e.g. decided that from A..D we had few
enough changes that the bitmap should apply for 4 commits, and then 3
for the next set etc. Whether some range was worth extending could just
be a configurable implementation detail.

1. https://public-inbox.org/git/87h8nnxio8.fsf@evledraar.gmail.com/
