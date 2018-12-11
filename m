Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E3720A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 21:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeLKVuX (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 16:50:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34388 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLKVuX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 16:50:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so15685464wrw.1
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 13:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uf1P32P+FhY+naRr178R5Z2cVc1pIh+CqxmWtg1pEmI=;
        b=b+F4CZ/JbB3wmVThb08yVe1CwdDAVhFK5JduVC3xBiY0tdk1CRCVcqpRLO/qF11H4j
         TDipGvT/122UEsSGKnW8q4Sp0BRj8+/sEeH3cgKWfIRs5dn0xWi+UnAPYADM/rwho5+0
         0Mm2jWpiU9mQYyjFCo2zRHsczHmaCfY1UkJQHbSHVw1tjOGKW//zllkQY6bBY1aNuJzL
         ucEhz/YdoiAilcjjloHzK2jkR7B++qLbKVwqS89eUfrtLK5jROq0+rdOEMhg6V8q5eMY
         OB1yUSOplCA3l+CQsi3EJpx7TaXJiqpWNYvy3IoG937HC4jAohG4B89MR5rMDf6UfYem
         tGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uf1P32P+FhY+naRr178R5Z2cVc1pIh+CqxmWtg1pEmI=;
        b=Mob1D6eLlMo9WxMcQ5SLmIRT7d8zWDgXbZixzcmMW6Qcwx2kwiBIc+ZJL8vvef8C1E
         QfTgXk5shFbTIfSoV2AC4MevcZiSW4s81Xrvm51K2rk3IIaHVc2/Q1tbOT0VnE1VLoSl
         tMrm24AzZ37Oi0uQW/tCcbUFNyam2vPpL+5TNL26N+Baj5OLoEVFrf3vDT9ANow0KH7K
         538jdPjxsUqmJvhhTlOV+BK4P3UEUH/N//V4b33nw462v6Ac0a+ngiU/KNX4JKRJrrLj
         0hZuIxxIH0GgIT0uWLBKj6wfavdEwfu+kBjSY9lRQRNMd7Xn+C/EBBAQi+5QZBTrcERY
         /GiA==
X-Gm-Message-State: AA+aEWZSWHLMyAKh7jStWEVqv+H42RUvpBg5cx2pceG+JvBoPZS8zSvq
        3RSXTtwL0H4p2SSkkbDUcJI=
X-Google-Smtp-Source: AFSGD/UyPYb5gYDtg3egKlLCaCW3fxQG5NOjm5XyXmvLwtbDdFZDM3yFCTIwl5kSnMXOYGA7cdZ+Bg==
X-Received: by 2002:adf:aac6:: with SMTP id i6mr14700323wrc.216.1544565021510;
        Tue, 11 Dec 2018 13:50:21 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id m15sm11616244wrr.95.2018.12.11.13.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:50:20 -0800 (PST)
Date:   Tue, 11 Dec 2018 21:50:19 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/8] move worktree tests to t24*
Message-ID: <20181211215019.GO4883@hank.intra.tgummerer.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181209200449.16342-2-t.gummerer@gmail.com>
 <CACsJy8AgbU9YyMHXdp=bkMncBO_Mu0FOQ4kSRkgacHzTJ0DrdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8AgbU9YyMHXdp=bkMncBO_Mu0FOQ4kSRkgacHzTJ0DrdA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10, Duy Nguyen wrote:
> On Sun, Dec 9, 2018 at 9:04 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > The 'git worktree' command used to be just another mode in 'git
> > checkout', namely 'git checkout --to'.  When the tests for the latter
> > were retrofitted for the former, the test name was adjusted, but the
> > test number was kept, even though the test is testing a different
> > command now.  t/README states: "Second digit tells the particular
> > command we are testing.", so 'git worktree' should have a separate
> > number just for itself.
> >
> > Move the worktree tests to t24* to adhere to that guideline. We're
> > going to make use of the free'd up numbers in a subsequent commit.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  t/{t2025-worktree-add.sh => t2400-worktree-add.sh}     | 0
> >  t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh} | 0
> >  t/{t2027-worktree-list.sh => t2402-worktree-list.sh}   | 0
> >  3 files changed, 0 insertions(+), 0 deletions(-)
> >  rename t/{t2025-worktree-add.sh => t2400-worktree-add.sh} (100%)
> >  rename t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh} (100%)
> >  rename t/{t2027-worktree-list.sh => t2402-worktree-list.sh} (100%)
> 
> Heh.. I did the same thing (in my unsent switch-branch/restore-files
> series) and even used the same 24xx range :D You probably want to move
> t2028 and t2029 too (not sure if they have landed on 'master')

:)  I unfortunately didn't have time to read the
switch-branch/restore-files series in detail, but good to know someone
thought the same way.  I started this work before t2028 and t2029
landed on master, so I failed to notice them.  But I'll rebase on
master and move these two tests as well, thanks for noticing.

> -- 
> Duy
