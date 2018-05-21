Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 237811F51C
	for <e@80x24.org>; Mon, 21 May 2018 18:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750977AbeEUSdO (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 14:33:14 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:44649 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEUSdN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 14:33:13 -0400
Received: by mail-vk0-f51.google.com with SMTP id x66-v6so9333767vka.11
        for <git@vger.kernel.org>; Mon, 21 May 2018 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z7sF/lPg/VVlaWMwd67BAhq8LU+gkhaqYd5aR5fNLX8=;
        b=ieYQvUhkqpBLkDbk/cMfon22cSeJa6/xMR32ZXQcT0H3JUSZSkl9VqlpFYaaLBOgWA
         s4asAo+ogIqgcE/Rqr55ZlsCZKUbBb1V+Bjz6sL5ZM6SBvzUPD7hGI7E3o3T82y0Y5cy
         EqtNHTj5I02cVSC5nE9Uqd647dh+ciJ9sYkAx5mpwzSYirbaaiGFsmSAoU3vy62aNxJF
         3zEgqswq6u08cpEZaOV81fTIp05V7CMWmFZq/oHMMmJXgPbqRio2JicAxA5H65sxmZAW
         I4fEzwsNuHVvGvLH4APah2MR2jjWP9Z36IQcet3k/6rMSmWtuSvaXZLhMPk+l+kAXUY0
         izQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z7sF/lPg/VVlaWMwd67BAhq8LU+gkhaqYd5aR5fNLX8=;
        b=Aa3OkcGvlehCSa40uqBEaMnKF6DLNph8eE29n0obbqsSsgUETdAav3pJtTkVTIrzim
         dYFqm5zxqws+UIw4j8+tye+zEKB05qP4w6PM9Q9dhYqlBrZpEVmRptqmuqQGpJRVst01
         3WRbt0zjIDfifcQCxwTrtMFC/JTVpIvnoq8AZhY7QHB+/8GicnfQwMvn7PWOXPkF8slO
         Dvxu3yJe+S9r4gElv0cqacRHaCSfXwT4KtxmeGftvJu1pJjk9yejJmNkkA3F/aF7FNvh
         g/wkiC9thNOZdZ0MiuEgB5HQoHSN3sV6t9ihuNjhudVgU0I+oBG9XTPBG5lH7L1evG2k
         V+MA==
X-Gm-Message-State: ALKqPwejNkvWk4e+vwM/5nOb+7pH3B8S1p1W8JIGbssEhB5Vej6x1Yxr
        JeJk8CxpmQRtxu5pfZ98DL5PleT3C7NRD9/whTY=
X-Google-Smtp-Source: AB8JxZoII7LPVX8Qlgt9I8Pwoest6E0UdWie6A/+khsYpD/ZRVjKJd0wNVzIfvNk7joEiwKW6UoYGM+/lNhrJPvtSzQ=
X-Received: by 2002:a1f:c155:: with SMTP id r82-v6mr13974970vkf.76.1526927592450;
 Mon, 21 May 2018 11:33:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 21 May 2018 11:33:11 -0700 (PDT)
In-Reply-To: <e78a115a-a5ea-3c0a-5437-51ba0bcc56e1@gmail.com>
References: <e78a115a-a5ea-3c0a-5437-51ba0bcc56e1@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 May 2018 11:33:11 -0700
Message-ID: <CABPp-BFEd+fK_i3qoYWudYS5mhWE1jsXR_xcSCZoJ=4Vd61LAQ@mail.gmail.com>
Subject: Re: commit-graph: change in "best" merge-base when ambiguous
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, May 21, 2018 at 11:10 AM, Derrick Stolee <stolee@gmail.com> wrote:
> Hello all,
>
> While working on the commit-graph feature, I made a test commit that sets
> core.commitGraph and gc.commitGraph to true by default AND runs 'git
> commit-graph write --reachable' after each 'git commit' command. This helped
> me find instances in the test suite where the commit-graph feature changes
> existing functionality. Most of these were in regards to grafts,
> replace-objects, and shallow-clones (as expected) or when trying to find a
> corrupt or hidden commit (the commit-graph hides this corrupt/missing data).
> However, there was one interesting case that I'd like to mention on-list.
>
> In t6024-recursive-merge.sh, we have the following commit structure:
>
>     # 1 - A - D - F
>     #   \   X   /
>     #     B   X
>     #       X   \
>     # 2 - C - E - G
>
> When merging F to G, there are two "best" merge-bases, A and C. With
> core.commitGraph=false, 'git merge-base F G' returns A, while it returns C
> when core.commitGraph=true. This is due to the new walk order when using
> generation numbers, although I have not dug deep into the code to point out
> exactly where the choice between A and C is made. Likely it's just whatever
> order they are inserted into a list.

Ooh, interesting.

Just a guess, but could it be related to relative ordering of
committer timestamps?  Ordering of committer timestamps apparently
affects order of merge-bases returned to merge-recursive, and although
that shouldn't have mattered, a few bugs meant that it did and the
order ended up determining what contents a successful merge would
have.  See this recent post:

https://public-inbox.org/git/CABPp-BFc1OLYKzS5rauOehvEugPc0oGMJp-NMEAmVMW7QR=4Eg@mail.gmail.com/

The fact that the merge was successful for both orderings of merge
bases was the real bug, though; it should have detected and reported a
conflict both ways.


I'm not sure where else we have an accidental and incorrect dependence
on merge-base tie-breaker or ordering logic, but if it's like this
one, changing the tie-breaker should be okay.
