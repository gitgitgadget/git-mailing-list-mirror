Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C4FC433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 02:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243599AbhLDDBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 22:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhLDDBs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 22:01:48 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB34C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 18:58:23 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z6so4659661pfe.7
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 18:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bD6d1sikXsUEJMr6te5F2uD+GsFPlMgFUugygSOVWXM=;
        b=DyqNMZ59X28wnnbyeY5DrewJsZh8Yy3TiQwsuF7GjkrCLNDBhjdyvlHGyMU6aYTOnu
         bihQwGDiOVx0S0OfefHVn5r7jhfahTdaAEJ9SW3Juh8AEdbnvR/+zmyClTkhsRrDnMYd
         5T9m5bCjInx6fPDjGgem2nfyJmecbXMMPLH/hs0bweQa+KCzOfFLDY50qrKMiCs8JihS
         iD2chFIjJQcCE7X5MYaCc7tuyura8T7A1TjEAhEXBEIXW0cqoXVP90bnQMazWvCZDkYs
         tdWCh8zHL2Y3HfNoFLRGtxGyr8ePG8/eEbBig9vNu9xGjjipGoZM/JmQD40gMVcVM+rv
         HkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bD6d1sikXsUEJMr6te5F2uD+GsFPlMgFUugygSOVWXM=;
        b=m/g1va3FNNbHYsupagmtFhLaRCZaw/wh/wbtVNhtJYRfxsuIW1rDx63QZpE20GNkqy
         XzlSDUIG5KEploJSNjvNC4NFXkQv6ryZrC5oNwkd9hEDeOjs8OgsQ+qux4auXRPybSyP
         7VWOKfY+qWmWrB7AbF3ia2YOx5kOYopm9k0lA2pOusOispu3P2IvAt8oWfBd/8X+LFgE
         0j9KrZcbo9JPxBVOJUfOvU0gV3AJvk0Mp8HbFTHff7PdCYXPBu2xDXDhTOUDIwG0k1gH
         41u+FU0eoUP0mjAxqzfahYKEPEJ66dciLchpgRj1u6AB7yd+dpNtxHigqGW+++92wh+f
         etSw==
X-Gm-Message-State: AOAM533jESdWoW+Hf6LixZR1vNK7KiyEC9cJ2FwqbAb9s/mNw2x+gMFX
        4sksqYx80aiFAqVIu1DDXRs=
X-Google-Smtp-Source: ABdhPJwe+JdbV3gubTOuivTuMHH0C8X44fA0QTDy80xDiB55lXT4yujv2H0ohfdEEdRsSHoe8MEyug==
X-Received: by 2002:a63:80c8:: with SMTP id j191mr7781960pgd.143.1638586703146;
        Fri, 03 Dec 2021 18:58:23 -0800 (PST)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id 35sm181593pgx.49.2021.12.03.18.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 18:58:22 -0800 (PST)
Date:   Fri, 3 Dec 2021 18:58:20 -0800
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: ns/tmp-objdir and ns/remerge-diff
Message-ID: <20211204025820.GA17138@neerajsi-x1.localdomain>
References: <xmqqzgpm2xrd.fsf@gitster.g>
 <CABPp-BHq4DnkCZZ+HcnGiZYKHpWJgzMBjMDuWbbTFYPesm2sXA@mail.gmail.com>
 <xmqqa6hhsdee.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa6hhsdee.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 03, 2021 at 11:21:13AM -0800, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
> > ns/tmp-objdir had a re-roll that has not been picked up, at [1] --
> > perhaps because it's an combination of ns/tmp-objdir and
> > ns/batched-fsync (it'd be nicer to have those two split).  I gave the
> > ns/tmp-objdir part another read over and was only able to spot two
> > small things.  I think you should mark it as expecting a reroll based
> > on [2] ("Good catch. I'll fix this.") and [3] ("I'll take this
> > suggestion."), but I think it could be merged to next quickly after
> > that.
> >
> > [1] https://lore.kernel.org/git/pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com/
> > [2] https://lore.kernel.org/git/CANQDOddCC7+gGUy1VBxxwvN7ieP+N8mQhbxK2xx6ySqZc6U7-g@mail.gmail.com/
> > [3] https://lore.kernel.org/git/CANQDOdd7EHUqD_JBdO9ArpvOQYUnU9GSL6EVR7W7XXgNASZyhQ@mail.gmail.com/
> >
> >>  Also ns/remerge-diff that is Neeraj's rebase of the
> >> remerge-diff topic needs Elijah's Ack at least.
> >
> > Mark it as expecting a re-roll; I've been waiting for ns/tmp-objdir to
> > settle so I can rebase on it.
> 
> I took a quick look at the rerolled one on list, and I agree that
> keeping tmp-objdir and batched-fsync as two separate topics makes
> sense, since the former can graduate much more smoothly and quickly,
> and it can have other dependant topics.
> 
> So I'll mark all three (ns/tmp-objdir, ns/batched-fsync and
> remerge-diff) as "Expecting a reroll".
> 
> As I announced, I won't be taking any new topics or new rerolls
> today (or possibly tomorrow) until I can sift the topics I've
> already seen to come up with a tested set of candidate topics to
> merge to 'next', so there is no need to rush.
> 
> Thanks.

I submitted a new PR (with a new mail thread) for ns/tmp-objdir.  Hopefully
that one can sail in smoothly now.

ns/batched-fsync will take a bit more time to settle.  I'm going to post a
new series called ns/core-fsync, which is focused on the extensible interface
for syncing parts of the tree.

Thanks,
Neeraj
