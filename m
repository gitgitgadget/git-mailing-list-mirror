Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151F0C433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 04:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiDEEkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 00:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiDEEkm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 00:40:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A12DFDC
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 21:36:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 5so21077227lfp.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 21:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLMgjmmN1Hbs1DB0JTHQakTOdWYHNjZU9m2a1iW6LwI=;
        b=bumzXz8MY/f2IiBMLSZ+rJ/bs97qsh8JvUciRAuWlfyY8rf7TUWjCX9Jsst5u+koKg
         Ph5DEjBDhKHjoHsp3LW9OcUU2iKfO1eydZOnLVWNpaxnJcSsaHcofcx9j7UewaAmxTqU
         Q3qrmIaFH9cyTSa/PWbkQ6Ma4xzRZioT1QBy42rfOJwW49iJwkNe9dBgE3Xnx/lytRVd
         OzklTMlIFVM5rgJE6S744Q0ZCezJcrClHTEPyZDzi2YC9hthr7mECt7mgQCpQzeiNOm1
         VnTBC7/i506Z+EwamPZZOuqeOcO4Wi9MoXyCevBlvpvrMa5R3DORvNznNXgXPgJbdb2g
         bC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLMgjmmN1Hbs1DB0JTHQakTOdWYHNjZU9m2a1iW6LwI=;
        b=rthEJHznSMIOhSEqKhsBOulBt0yKipx+5SvyvFRLoCU/VIFLmy4zDe9lWfOGdUPmpo
         KOqHa4YRC7d2FRjsMY8sm6czRTvjUTJCVAzXk6kLLhNTTWTqnFkeA9cMnsEATF7afeYd
         YDo+dg3GSMt/keQ6wXALfUTszNMTt4BgXuGllKnjvEWxFxaVK9M1mbTThAWqBL0e20I1
         ABA8b4XTgarPcokyg76/GXhmy1uFlJHNzLCsyITyZgkYddARHqS5hdTDsc/eQrDwygqb
         G6TNArZeiKRIpRCMvtSxDX2BSmcW8+dOLL0/KmQcrah1PZmj6n/J7L7qLyeOo51EVYVW
         obZA==
X-Gm-Message-State: AOAM533jINUyez4AgDO/TUbxa0XCgNRz7mYiiCaaH5zKKtwbDTos8l9L
        sNSzrvYzfnz9G0KqRH/owVkXc69IAosXGPQ0GEg=
X-Google-Smtp-Source: ABdhPJwRZtqBlf53tQ4naRQkwg6hgOwlef+AGar6bWMyrR5SxT4XeGnCCrG7WC1Gh7bxXgWf6y4Ga0AdyZ8VGINYfq4=
X-Received: by 2002:a05:6512:3909:b0:44a:2428:3ecb with SMTP id
 a9-20020a056512390900b0044a24283ecbmr1249646lfu.522.1649133358256; Mon, 04
 Apr 2022 21:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqilropo3z.fsf@gitster.g> <20220404232014.GA75@neerajsi-x1.localdomain>
 <034a01d8487c$0e067b40$2a1371c0$@nexbridge.com>
In-Reply-To: <034a01d8487c$0e067b40$2a1371c0$@nexbridge.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 4 Apr 2022 21:35:47 -0700
Message-ID: <CANQDOdemQOTLRVkEHBcWtVLPxE_ujzeO0idutD4Zi3zOPzah7A@mail.gmail.com>
Subject: Re: ns/batch-fsync (Mon Apr 4, 2022)
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 4, 2022 at 4:31 PM <rsbecker@nexbridge.com> wrote:
>
> On April 4, 2022 7:20 PM, Neeraj Singh wrote:
> >On Mon, Apr 04, 2022 at 01:53:04PM -0700, Junio C Hamano wrote:
> >> * ns/batch-fsync (2022-03-30) 14 commits
> >>  - core.fsyncmethod: performance tests for batch mode
> >>  - t/perf: add iteration setup mechanism to perf-lib
> >>  - core.fsyncmethod: tests for batch mode
> >>  - test-lib-functions: add parsing helpers for ls-files and ls-tree
> >>  - core.fsync: use batch mode and sync loose objects by default on
> >> Windows
> >>  - unpack-objects: use the bulk-checkin infrastructure
> >>  - update-index: use the bulk-checkin infrastructure
> >>  - builtin/add: add ODB transaction around add_files_to_cache
> >>  - cache-tree: use ODB transaction around writing a tree
> >>  - core.fsyncmethod: batched disk flushes for loose-objects
> >>  - object-file: pass filename to fsync_or_die
> >>  - bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
> >>  - bulk-checkin: rename 'state' variable and separate 'plugged'
> >> boolean
> >>  - Merge branch 'ns/core-fsyncmethod' into ns/batch-fsync
> >>
> >>  Introduce a filesystem-dependent mechanism to optimize the way the
> >> bits for many loose object files are ensured to hit the disk  platter.
> >>
> >>  Will merge to 'next'?
> >>  source: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
> >
> >Please expect a reroll today to address the remaining issues in that
> thread.
>
> Does this relate to why I cannot compile with the new fsync code at
> 2.36.0-rc0?
>

I'm sorry I missed the error report.  Could you please share the
compiler errors you observed?

Thanks,
Neeraj
