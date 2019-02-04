Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CFC51F453
	for <e@80x24.org>; Mon,  4 Feb 2019 19:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfBDTif (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 14:38:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37576 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfBDTie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 14:38:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so1214063wmd.2
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 11:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wBoT2n131taE4KG3hltPx6SDJIVrlhokG4PVQ1sva0g=;
        b=UvbiFufhzukbKJU0nD8/2LpjFtHF3yHiFwDy96dTCtIIuTCQREDLc1EE7yMRI2EFi0
         FBvWU2YJsX/P/XCN6K2pqsSScxplD1gHvTpJFTVAIsO5qJBfaVG0S3MtVn531xwEkRyO
         qRam3SAqD7BDT+/Hd9yu5iamVhLp8+8TTr496KtKsAqe5eqhL36h7pezeElqD5DulKBn
         QWkgCsZIsQbQnwJPve/GZdNKuXhLGuNpwthZAwqRk28R/K7+0j1QY39tdraRAe5r5IVO
         T9IA1VN9FftThldG72ajbfmsJxWQHpda61626kSZ4jxNH6GyvVQs2MTFhfRF7WpQCBm/
         mNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wBoT2n131taE4KG3hltPx6SDJIVrlhokG4PVQ1sva0g=;
        b=Acd0bveayScePJYJbK4rqvPY9nxtgIlxhfyJkbJirLADGqkATVvQSwE0BinGydakcQ
         ulmYbGZzpn0kxYDVm18DfO3o3LOiKh/9Gf/UzQKoXnWYCtTR5lHRnkXaCy+MXBXaLSK2
         eVO2t/WaO13oxnz240neeUvo7RQGHcGcWaN0UxIG+NaCgo6qAfCAp1aJ5T4NNaWxQfAN
         fwB+OTCvweNoypaFk5D9by2s9r4oPrt3+XMwyGp/I2dTb3hbVWygHMZqV81cEZ22UFtD
         r9kiyewnHMVJSisczaEYx4KsrpTle1lUsM5RoVTzhPs5QhzmN5y5/vHWB3W9djD4rJJd
         IITQ==
X-Gm-Message-State: AHQUAuah3aZpVnaMb1+C4QPIC0n44LRlTWNmSeqsh8fTa1Vn/oUF17aS
        1C/d6R/qflkx9AZIkDeeMJRK/SuA
X-Google-Smtp-Source: AHgI3IY0H6APxWIWIXJidwJEuk70f0ALsxnyMJWY2iDnqbZQY69sgFfYFKUN5Q/Tghj7DAwvbeJyvA==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr712406wmb.98.1549309111965;
        Mon, 04 Feb 2019 11:38:31 -0800 (PST)
Received: from szeder.dev (x4db609fa.dyn.telefonica.de. [77.182.9.250])
        by smtp.gmail.com with ESMTPSA id s3sm9485557wmj.23.2019.02.04.11.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 11:38:31 -0800 (PST)
Date:   Mon, 4 Feb 2019 20:38:23 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: make the OSX build jobs' 'brew update' more
 quiet
Message-ID: <20190204193823.GA4511@szeder.dev>
References: <20190202163421.19686-1-szeder.dev@gmail.com>
 <xmqqk1ifv296.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk1ifv296.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 04, 2019 at 10:26:29AM -0800, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >   - This '--quiet' flag apparently broke overnight, resulting in
> >     errored builds:
> > ...
> >     I belive that this breakage will be noticed and fixed soon-ish, so
> >     we could probably just wait a bit for this issue to solve itself,
> 
> Yuck.  Well, an external influence that can break the automated
> build job overnight should be capable of fixing it overnight ;-)

> If this is truly urgent, I could merge this to 'maint' and merge the
> result upwards to 'pu' and it would hide the issue on my four
> integration branches.  But one thing that makes me wonder is if we
> can (or want to) do anything to help other people who test build
> with pull requests.  I guess they need to rebase on top of whatever
> commit that has this fix?  That sounds more like a tail wagging a
> dog, though.  I dunno.

Contributors don't have to rebase to make their PR builds work.  When
Travis CI builds a PR, it doesn't build the branch on its own, but the
merge of that branch into 'master' (or whatever the default branch is
called), assuming can be it merged cleanly.  So as soon as this fix
lands in master, the PR builds should be fine.  I suppose.

However, they will need to rebase their WIP/not PR-ed/not upstreamable
branches on top of this fix if they want to run Travis CI builds in
their own forks.

Unless, of course, the external influence does manage to fix itself
overnight :)  Under Dscho's bugreport it looks like they already
merged a one-liner fix, but how long will it take to tickle down to
Travis CI, I have no idea.

