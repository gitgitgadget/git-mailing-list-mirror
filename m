Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233C220A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 01:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbeLKBy3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 20:54:29 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:41214 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeLKBy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 20:54:28 -0500
Received: by mail-ed1-f53.google.com with SMTP id z28so11176590edi.8
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 17:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtWy0b3a+EA+XimGMbRCTn0r50fF5u2HUaecJi0h3zU=;
        b=ufh0hHNGGhh6aDFchVS7RL3k5YouUAvXKKbz1zz193gh1Yh2n7XCzeWBGnP29xSXrQ
         mvFQ3FLQFNWfsjvV5WYsMGb9T0y+BRbR3oIZZwNryhBRfBQucVOOmRwVX7bN+Yw4HWE+
         rqOyU1ylALLqm0nsg54k3+jaSzxM24zcIQ63lT+B1/x2PC+6Rn+f7v66biviHr3m2a/V
         DOnIE0ouGUNMGxgybeZmLDI0m92MswOfxD/Dxcn51aKRR/ZqEzb4m6K9W5ALcEMfsfdK
         B9H6ZwRK2y6+lP6TuK25s5TtcKYUdJK6bwtFGR483vhYlsL7wEo0Wg+96bz/I/yvsofz
         QvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtWy0b3a+EA+XimGMbRCTn0r50fF5u2HUaecJi0h3zU=;
        b=o1J71foF+FBvvtHP7+mmWdl6jWbTG40AmJIR44ECAaR3dchAymdySw58b4IIhlJRg+
         Br2W8rijHFbFDamKlp8gdDLMvwgE/e1ZQ4UkOkMFLSs326cIlfGt2nsksEnpN6Vzxl0/
         epycZ5iQYLqiFEJIJF8cAjZSMSMMjDhIOkCol2a6viVjPhAEUbeH1kca1uXgzI1tIrsf
         7ZMHH3tqpkQf9L/y8jGk5vCtDpG/sEjHGZ+bzZ8b82I8tKETkbGhwUzr+tx/03ndGdDG
         fGL/btvbF2C0l4fdYSm/ve4iqf5z7KzLFiEd974En8oWPAmRnxV0pPJiZYuCfb7R98h7
         1quQ==
X-Gm-Message-State: AA+aEWZK4HRM27F6RELknLN2FmBdfMGcc4SOWnWtJr6AKPNeKkIkS5YS
        2JSOgwJNfRdrjGmijRdKs6SYumGBOUOHHS6XRlH7mg==
X-Google-Smtp-Source: AFSGD/VC0BTh1ZqJdQ3MhuCLXEE7BxPkuLnsEnFnxzADDscrmH2YApdWV60zjmH3AMIH4ILbQR+a+GmE0o0XW9yRAkk=
X-Received: by 2002:a50:8343:: with SMTP id 61mr13552894edh.154.1544493266651;
 Mon, 10 Dec 2018 17:54:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.92.git.gitgitgadget@gmail.com> <72b213959171af3bfe4d849b925920ddbfb3d4b7.1544465177.git.gitgitgadget@gmail.com>
In-Reply-To: <72b213959171af3bfe4d849b925920ddbfb3d4b7.1544465177.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Dec 2018 17:54:15 -0800
Message-ID: <CAGZ79kaNJ8=iCunkeeHnMcOwFik9D-V4g9o7SuvLnnM0vvfBnA@mail.gmail.com>
Subject: Re: [PATCH 4/5] multi-pack-index: prepare 'repack' verb
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 10:06 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> In an environment where the multi-pack-index is useful, it is due
> to many pack-files and an inability to repack the object store
> into a single pack-file. However, it is likely that many of these
> pack-files are rather small, and could be repacked into a slightly
> larger pack-file without too much effort. It may also be important
> to ensure the object store is highly available and the repack
> operation does not interrupt concurrent git commands.
>
> Introduce a 'repack' verb to 'git multi-pack-index' that takes a
> '--batch-size' option. The verb will inspect the multi-pack-index
> for referenced pack-files whose size is smaller than the batch
> size, until collecting a list of pack-files whose sizes sum to
> larger than the batch size. Then, a new pack-file will be created
> containing the objects from those pack-files that are referenced
> by the multi-pack-index. The resulting pack is likely to actually
> be smaller than the batch size due to compression and the fact
> that there may be objects in the pack-files that have duplicate
> copies in other pack-files.

This highlights an optimization problem: How do we pick the
batches optimally?
Ideally we'd pick packs that have an overlap of many
same objects to dedup them completely, next best would
be to have objects that are very similar, such that they delta
very well.
(Assuming that the sum of the resulting pack sizes is a metric
we'd want to optimize for eventually)

For now it seems we just take a random cut of "small" packs.

>
> The current change introduces the command-line arguments, and we
> add a test that ensures we parse these options properly. Since
> we specify a small batch size, we will guarantee that future
> implementations do not change the list of pack-files.

This is another clever trick that makes the test correct
despite no implementation yet. :-)

> +repack::
> +       When given as the verb, collect a batch of pack-files whose
> +       size are all at most the size given by --batch-size,

okay.

>  but
> +       whose sizes sum to larger than --batch-size.

or less if there are not enough packs.

Now it would be interesting if we can specify an upper bound
(e.g. my laptop has 8GB of ram, can I use this incremental
repacking optimally by telling git to make batches of at most
7.5G), the answer seems to follow...

>   The batch is
> +       selected by greedily adding small pack-files starting with
> +       the oldest pack-files that fit the size. Create a new pack-
> +       file containing the objects the multi-pack-index indexes
> +       into thos pack-files, and rewrite the multi-pack-index to

those

> +       contain that pack-file. A later run of 'git multi-pack-index
> +       expire' will delete the pack-files that were part of this
> +       batch.

... but the optimization seems to be rather about getting rid
of the oldest packs first instead of getting as close to the batch
size. (e.g. another way to look at this is to "find the permutation
of all packs that (each are smaller than batch size), but in sum
are the smallest threshold above the batch size).

I guess that the strategy of picking the oldest is just easiest
to implement and should be sufficient for now, but memory
bounds might be interesting to keep in mind, just as the
optimal packing from above.
