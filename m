Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BF231F51C
	for <e@80x24.org>; Sat, 19 May 2018 04:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750783AbeESEod (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 00:44:33 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46068 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeESEoc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 00:44:32 -0400
Received: by mail-pg0-f66.google.com with SMTP id w3-v6so4121940pgv.12
        for <git@vger.kernel.org>; Fri, 18 May 2018 21:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3bh4HpUujOHoCrLciG0xjvwBdLmfRGnaN00Xp2yRwko=;
        b=T2VA5BnT/gCHRsT5wcISilRKiMk5AnucV2TS73C9M2ZPKtSS3uXxmU48ZO9ragxXie
         UZ4xEEclxFn/hTuKlNg4X2TZwlQC23TN4Cyd+qhrcm4JaztF+JlBWVcfFgJv6wJG0Fcd
         M5Eifhg06o/G1I+C6oimGEg5cuTLzue7/EvA9Z9TrTqC9ajxEFb4lqu7xXGddHa+k9Wc
         Opg9hmCkZs62UOOOQJgwUBbHFbAfhYs+nT80qhtT4NhPyACQsxzV+Nkfvbmva2lfmxLX
         UfYz5pgxSbKmu/YuHMQ5GpJonP4sY61prZp1saYucIrywecpN/NZB6cehOtQGZoNpuPN
         gYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3bh4HpUujOHoCrLciG0xjvwBdLmfRGnaN00Xp2yRwko=;
        b=UkY/xtzfDB6KKhk9nkgF24azQ6UloVtNLyA6yZPZeotSTi4fbTa7rXFY7kFhg0EkxQ
         bdeHvhXleP7VU5fgaa1c3iFM4IhVTyvejQ/c3NgfrDmrwp9UJA220bZ7Ef/1303fg37L
         khM1yZZeKPgzSisheVhuhAkpxRWD3kcp1FDC00VOaR8lwQunEmfE3ea2VhB67aHfUbvz
         uvOpvn8F6qVW083xIQ3MVc69Vx/gojdWQShTMFp8f7wAhjQ5f6e1+fYQ0i/jErvAw9Ys
         hLTkke5kYjV4TLQxbPIQ/iBb4CJk0+mfOvS7GeMMYPqWtidvLGupMVAyVx8J/lawYbTL
         IFCg==
X-Gm-Message-State: ALKqPwdlXPClOpKJ5/uZQ2BTJLjgBhLMTVorv98KaFSj4znaGAV7Hg7a
        bOw7OgCWN2ooL1DoewomPAaSeg==
X-Google-Smtp-Source: AB8JxZolzWGrW0Bk/4MIMzsu3dHYx3n61exbK/PPgcgEipDIH7KmUJRrNxJsIse1xolAY9XQSQWR8Q==
X-Received: by 2002:a62:e04c:: with SMTP id f73-v6mr12072160pfh.88.1526705071305;
        Fri, 18 May 2018 21:44:31 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:75fb:b3b2:8793:31ee])
        by smtp.gmail.com with ESMTPSA id c7-v6sm22983539pfg.81.2018.05.18.21.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 21:44:29 -0700 (PDT)
Date:   Fri, 18 May 2018 21:44:28 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to
 'git-grep(1)'
Message-ID: <20180519044428.GA81936@syl.local>
References: <CAN0heSpXCajyDKwOrXuQHWRODsVnFewUWTMitOoRQueFV4eSiw@mail.gmail.com>
 <20180509235251.GC68889@syl.local>
 <xmqqefikl6jx.fsf@gitster-ct.c.googlers.com>
 <20180512032733.GA65308@syl.local>
 <xmqqbmdlfokf.fsf@gitster-ct.c.googlers.com>
 <20180512051902.GA70598@syl.local>
 <xmqq7eo9flvb.fsf@gitster-ct.c.googlers.com>
 <20180518033817.GA61335@syl.local>
 <xmqqh8n54gwv.fsf@gitster-ct.c.googlers.com>
 <20180518215021.GA36543@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518215021.GA36543@syl.local>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 18, 2018 at 02:50:21PM -0700, Taylor Blau wrote:
> [...]
>
> > Another might be to pick "foo" in the first and "bar" in the second
> > line, as that is the "first hit" on the line, which is consistent
> > with how "git grep -e foo" would say about "a foo b foo c foo" (I
> > expect that the leftmost "foo" would be the first hit).  So there
> > may be multiple, equally plausible answer to the question.
>
> This is the largest fact in my mind pertaining to this discussion: there
> are probably many different interpretations of semantics for this, all
> equally valid in their own way. I am partial to the minimum substring
> interpretation (which follows naturally from the minimum-start,
> maximum-end idea), accepting the shortcoming that `--or` sometimes
> doesn't ``do the right thing.''

Ignore this last part. `--or` _does_ do the right thing, as noted below.

Thanks,
Taylor
