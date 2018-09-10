Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031A11F404
	for <e@80x24.org>; Mon, 10 Sep 2018 20:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeIKBVS (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 21:21:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34457 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeIKBVS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 21:21:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id j25-v6so6385907wmc.1
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tC+Q5xEymI4rGMY89SwoY4KnNFeCioPGt7fMTb60nxg=;
        b=MB6G6DreEaw2HJ5LXU5LbWkZK13/jBY089BM9OEFHJak4Khno7TeSqiDbg54a/O80c
         mXpAR9xHpkUIkt+wTXt0/lkrIecXy2/ldxKWxE2bjNbsgXFdWqOGN03cq+zUHdbDc2Go
         pk953wCkEl8QY58AF1lWohlt0xoDl0fYQ68zr8O6RmPBBbmFfvntd4fCJ7oo/k9f+6eN
         LlaosUgZOrlmlL+A8pbq20TekpJtqOgsVhbQbaymdWoqNFqNPTd1N9MEwOwuTfVNmT0g
         SXyAPqBJW1CC9zCb9X3EJHTyaR1APSP+1HjnuhNxGCR8jTDxnV4lB/xWx/3qOi9bOQCl
         QOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tC+Q5xEymI4rGMY89SwoY4KnNFeCioPGt7fMTb60nxg=;
        b=C+e/LZuG+CyNTMdLmVZ/bIct3ZT/kAIzjvrI/3GwSIyzWAER61wiI+7ly+aBtR7SYW
         Nif+ouXcVfuxqa+lEI+NwWjilUZMEOHJkoZJ05bDphIv0uvrflluCaYU5IkELrAIiwLd
         Rf+ABEwwyW7stmEHLUNyke2InQ9QGWHUptUBSkQOMK+FbZGm2jBb72mpEhm4QIG+qGmv
         JP8ZvbkokKv9rknICeUwA+CacYPmtXmIC2FvkoPVvjleCflR9x7QNO9JIwa6YAKZ2+80
         EDqSXIOCyCJMNzURBFVCLuCSTvqhnIc7vkIN1J+4xMLOQMoIyrLL0wjJe5Scz/uqlPOL
         p6Rw==
X-Gm-Message-State: APzg51A8jp+F7JtvfNCLal2l04VQ3DLa6KTEgNPS8z4MxHsqSWGVjJgX
        lPg8DfBxV1EMIgRLQ4Trvdg=
X-Google-Smtp-Source: ANB0VdZj+jwZpUGIQ4Nz7Ndv6EeuouBuqWTBisgIf4pYqximVXVLsMX+DRMPNsR1m1TPWcZisWNbww==
X-Received: by 2002:a1c:a187:: with SMTP id k129-v6mr1893742wme.111.1536611130084;
        Mon, 10 Sep 2018 13:25:30 -0700 (PDT)
Received: from localhost (x590d3ee7.dyn.telefonica.de. [89.13.62.231])
        by smtp.gmail.com with ESMTPSA id l18-v6sm21083755wru.75.2018.09.10.13.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 13:25:29 -0700 (PDT)
Date:   Mon, 10 Sep 2018 22:25:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pratik Karki via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 10/11] builtin rebase: only store fully-qualified refs
 in `options.head_name`
Message-ID: <20180910202527.GC17224@localhost>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
 <pull.32.v2.git.gitgitgadget@gmail.com>
 <aab01f0b8e15db37bc17630b4298148aeacf41e2.1536096424.git.gitgitgadget@gmail.com>
 <20180908085207.GB10370@localhost>
 <xmqqva7dthq5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqva7dthq5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 09:55:30AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >>  		} else {
> >> -			options.head_name = xstrdup("detached HEAD");
> >> +			free(options.head_name);
> >> +			options.head_name = NULL;
> >
> > Please use FREE_AND_NULL(options.head_name) here.
> 
> Good; did contrib/coccinelle/free.cocci catch this?

Yes.

But now that you mention it, I see that it didn't catch it in 'pu' or
in most of the later 'pk/rebase-in-c-X-...' branches, even though they
all have these lines.  It bisects to 0073df2bd3 (builtin rebase:
support --rebase-merges[=[no-]rebase-cousins], 2018-09-04), which
doesn't touch these lines at all.

Strange; I have no idea what's going on.

