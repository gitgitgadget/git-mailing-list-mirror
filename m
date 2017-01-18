Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790CC1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 20:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbdARUep (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 15:34:45 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36446 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbdARUen (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 15:34:43 -0500
Received: by mail-pg0-f48.google.com with SMTP id t6so7199702pgt.3
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 12:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4k0U62tG+hvvtsFMz6VhKGLgYriKJkbMYXK3NKh1Po4=;
        b=oguPT0HZ3eCAakHiwMuMHe9JyYTyIWqq4MbA40MTv7N1kjhql7Dwv5+qaaNDrUNvxe
         amOnPz3a6HwTOMouN8MAhB0PbkKlE1PMNd1RsAn46+0vufJA61XdLXRL6N908jDTFK8D
         pZFUGtMO4egihhm8qqmc+pNqrYRccCG1e5IlFAhtx87AxyVZNb2YC0bxNMGiVaxUdL3y
         yQA1pkCjDfKXvxm6tHnbKAjd4Bz6PxJ8CR6vb90pzM1AeId73upNsbrzBd2zDwuhxmK4
         WkoO/yMI8Oiy1PJVQVrNVWmCF+dIk45VlplWot0Nb+Ero68eVE1MCTGdHpVfmKoy5vE6
         bDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4k0U62tG+hvvtsFMz6VhKGLgYriKJkbMYXK3NKh1Po4=;
        b=n5BXpsJHxTAxbB71w+hgsk2FV2Gs62zTOvG9yOtjBLHqo5B7tT/xVQg/tpNnlQH0SR
         +BcfatkY8uXjdtzdhtTUeT43mQ/V6s1A7PNfoX5CNYFODIU/kbBojVWf/J9WYrE1UOw/
         fYm0tLSFz8GnvNqfoY606VkvtLnM6a6KUxlj5HiOMAOzUIEA1VoCo2AlBdmTmb/XHfGq
         eF3H8QeaJe7sjbc3cnR2q87HLDY06EOqBXbyjF30Fafl1kMIGrhB9D5+XhjZCLx2E0FP
         V4cDxV3GzUOBcDYUwbYKEkSSu8/krFmbZqrk3E4UWglauzqU/tQ6f31jP/H0wyw6IHJd
         2mIQ==
X-Gm-Message-State: AIkVDXIRrpn07ZCpfizprdMr8dg/4qtfoGaRaPWHLZ/E+dn1xcxECXPZjVcFGSOM0LDJpLgk
X-Received: by 10.84.143.233 with SMTP id 96mr7820603plz.124.1484771682674;
        Wed, 18 Jan 2017 12:34:42 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:1d68:bc5d:3a1b:2ccb])
        by smtp.gmail.com with ESMTPSA id m12sm681123pgc.46.2017.01.18.12.34.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 12:34:41 -0800 (PST)
Date:   Wed, 18 Jan 2017 12:34:40 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, sbeller@google.com
Subject: Re: [PATCH 25/27] attr: store attribute stacks in hashmap
Message-ID: <20170118203440.GB10641@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170112235354.153403-26-bmwill@google.com>
 <xmqqshomejwt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshomejwt.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/13, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > The last big hurdle towards a thread-safe API for the attribute system
> > is the reliance on a global attribute stack that is modified during each
> > call into the attribute system.
> >
> > This patch removes this global stack and instead a stack is retrieved or
> > constructed locally.  Since each of these stacks is only used as a
> > read-only structure once constructed, they can be stored in a hashmap
> > and shared between threads.
> 
> Very good.
> 
> The reason why the original code used a stack was because it wanted
> to keep only the info read from releavant files in-core, discarding
> ones from files no-longer relevant (because the traversal switched
> to another subdirectory of the same parent directory), to avoid the
> memory consumption grow unbounded.  It probably was a premature
> "optimization" that we can do without, so keeping everything we have
> read so far in a hashmap (which is my understanding of what is going
> on in this patch) is probably OK.
> 
> I suspect that this hashmap may eventually need to become per
> attr_check if we want to follow through the optimization envisioned
> by patch 15/27.
> 
> Inside fill(), path_matches() is called for the number of match_attr
> in the entire attribute stack but it is wasteful to check if the
> path matches with the a.u.pat if none of the a.state[] entries talk
> about attributes and macros that are eventually get used by the
> caller of check_attr().  By introducing a wrapping structure, 15/27
> wanted to make sure that we have a place to store a "reduced"
> attribute stack that is kept per attr_check that has only entries
> from the files that talk about the attributes the particular
> attr_check wants to learn about.
> 
> I need to think about this a bit more, but I do not offhand think
> that it makes future such enhancement to make it per-check harder to
> move from a global stack to a global hashmap, i.e. the above is not
> an objection to this step.

If we want to continue through and do the optimization you originally
envisioned then I may need to rethink this patch.  One thing we did talk
about offline was doing another check prior to the path_match() function
call which looks through the list of state structs to see if one of
those states would actually have an affect on the array being used to
collect attributes.  Though that may be an optimization which can be
done in addition to creating a reduced stack.

The one difficulty (which you pointed out in comment form) is if we have
a reduced attribute stack that is stored per attr_check then handling
the cleanup when the direction is changed may be messy.

-- 
Brandon Williams
