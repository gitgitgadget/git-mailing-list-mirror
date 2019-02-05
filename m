Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8AFE1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 21:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfBEVRk (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 16:17:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37677 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfBEVRk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 16:17:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so5306785wrt.4
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 13:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HTn3AX6NEc5svpi2XeF9gDEeTy+JU2wZBzQ9dMNfimc=;
        b=umTglPwO3o7UUhOpvLKF91DEbrDYa2eHgiX1OXL4H+DFXWrg7bjAXMLAtoySfSkbUW
         VS3YT+m713SCfVl5Mfr4c9ERQOWMUCntqRPYQgX+/nFKuY5v2rfGKYm5ajLOvAA0ztBs
         eYYqQVenJmqUNcqCMuKWvz2SxzyDqKSEZ2tNbqPzDa2bIwuMJefTz6cHLmuUy+Ysqwow
         Dl0p+PKWUGP3O7WkEb0ezKwHHITrd+yeFaBpChz91bTfidMtPqNJ0s5ZUcdsfGZnxPkg
         Os/UHwLhfYyipPCbz6D1z3deqbtEKDNzNhdMhfCQZCWr+VFrUGduKUtSuvpf+JwaCBQN
         tGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HTn3AX6NEc5svpi2XeF9gDEeTy+JU2wZBzQ9dMNfimc=;
        b=kqSDFdiHpNg/Y23RFSezZy4gp0eHudP4Pq0yR8pCO5AIQIE6O22dMxK58p+qEoBoAd
         Oe+tmwy6jG1C9SzgySjj9JOaBaIV6u0z3ucqU7QL6j57xZyuUppr/31WGlfDIuVVA92r
         ZInvvzbP+MwA/RO9rc4ZSatOR2gQpyqH+OjiAL54V5iqzs7cX3HAJmwBum82YRLu68O2
         buvkGpjSIBu8lHrTUYC2muUL3E4sY53i4SyBtFXtQOoCvm+CNnBE2PnOfSVi8ooNaHnl
         SMWTe1IjoibGsWoJUsVm7FPW9f/4JjD8URDqNnHJ09EjLaHCNfXZvyYeZazWF28EN8y3
         471g==
X-Gm-Message-State: AHQUAuYhyJVQR0/6jFol6Ym11x0b0PjCEesLZtD5AqUevwZIJil8XMaj
        buClkgpOAVbHZg6SLPcL44YDQnAu
X-Google-Smtp-Source: AHgI3IakAEqtjs2TZf6+dGy/slVpaaE4d+t97dFSrdy4tPccSSrQNypTOPr1AriUPTFJSOzUyXB6dg==
X-Received: by 2002:adf:c7cc:: with SMTP id y12mr5348545wrg.52.1549401458562;
        Tue, 05 Feb 2019 13:17:38 -0800 (PST)
Received: from localhost ([109.180.252.133])
        by smtp.gmail.com with ESMTPSA id a14sm8800071wrr.13.2019.02.05.13.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 13:17:37 -0800 (PST)
Date:   Tue, 5 Feb 2019 21:17:36 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC 2019: Git's application submitted
Message-ID: <20190205211736.GD6085@hank.intra.tgummerer.com>
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204215251.GB6085@hank.intra.tgummerer.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Dropped Stefan from the Cc list, as his email bounces]

On 02/04, Thomas Gummerer wrote:
> On 02/04, Christian Couder wrote:
> > It would be nice to have a few more project ideas.
> > https://git.github.io/SoC-2019-Ideas/ currently lists only 2 possible
> > projects:
> 
> Thanks for putting this together.  I'm going to have a look at the
> project list over the next couple of days.

Here's an idea, that I think could make a good GSoC project.  Dscho
mentioned this to me at Git Merge, and I liked the idea, but I'd like
to get some feedback on the list first before adding it to the project
list, to get others opinions on the feasibility.

The idea is to add an option to 'git stash push', so it can stash
merge conflicts, and restore them with 'git stash pop'.  The various
stages of the files could be represented as commits, and the stash
commit would be an octopus merge of those commits, so they could be
re-created later.  The same idea can also be extended to store staged
vs. unstaged changes, so we can re-create the index state as it was
before creating the stash.

Thoughts?
