Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82C21F597
	for <e@80x24.org>; Fri, 27 Jul 2018 17:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbeG0Sme (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 14:42:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40071 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbeG0Smd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 14:42:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so3599841pgp.7
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 10:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=soFJ3mfSrtbrtiVktAdEkXumO7pjnhNjEmsvD9LjGEM=;
        b=cM+8fSOGs/eHwV2byhsuZ7ZV/KRyldemLfJkrk8jR9QsC4m3p5ZdsvzYyFTrBRUBck
         MoVFroLFipNKph6ctq788RnKJp8DywUVd1kcde13pWU9f2Wfw0tC/7lyVskpqn7v+8GF
         T697Ab4o5DGwcE0tKos+3L8wbgRxHjccVCtRq4ulYNQ9LRFcLn1CnEMTvwSOTCBcUK+S
         kLwPTdqtsS1XlOMlaZUR8HUrM3m5TXV8RBotOtBWWq36RbSNeVTHjasx6wwdS55I3RMP
         a2xDbEZWHpD+BcquyKy2Yly9pj9iWULDnPd/+vkfvBy/cuaGNWC6aWdRUxVvKdv+ZIBG
         vczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=soFJ3mfSrtbrtiVktAdEkXumO7pjnhNjEmsvD9LjGEM=;
        b=mOMjd5I/rg5Tscdj9dldE+S+VKvjwK7MPsd7TK7sYBV5XA5xSh7EQ5k5CU4QPki+r0
         5kPlVUtu4hVOhbLv9/zO+7DLYM6xEpboIxGA88bYavsqnxA1qWcyyQgtPFuqUpFVGvWv
         rphWFyImgVb8e5zPiX6jxOQeoDI4EhPn2xl2tV4c+3k5It3S6tsietoNVWKYbhBmM6zV
         rdBZl1yL+ISzgWvpz/52BG2Uag+fJ9i/vwNdyNa1SjxNtTwZ4YUgaL15FKrhPbdkgexn
         cBiyqwwNneH+bZSpj0zv9sXg9wFwgVRDoGvH094pfIPbmhIoNRtbSvtAhzMXRvw03Ojn
         ZWPg==
X-Gm-Message-State: AOUpUlHcq4pY4DLI1iTQq1aoR9ilrM6muTIaIfiZ1OYQHMdFrsQjc5MS
        V5lAqaMm2bqiD6vM+8FOp8bAFA==
X-Google-Smtp-Source: AAOMgpcldRQa8ZTz8dH0HmoukHnCRZQstnhNS/9uhVl+lFMqICWqB2LhhjEF6E10vkQqW6E9CjM6LQ==
X-Received: by 2002:a62:ccd0:: with SMTP id j77-v6mr7532969pfk.22.1532711983178;
        Fri, 27 Jul 2018 10:19:43 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id r22-v6sm8699104pfl.112.2018.07.27.10.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 10:19:42 -0700 (PDT)
Date:   Fri, 27 Jul 2018 10:19:41 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/3] refs: introduce new API, wrap old API shallowly
 around new API
Message-ID: <20180727171941.GA109508@google.com>
References: <20180727003640.16659-1-sbeller@google.com>
 <20180727003640.16659-3-sbeller@google.com>
 <CACsJy8Ae3sZvOQ3irQM+hv0fCRchGi8995kvLZBadbaphRo-3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8Ae3sZvOQ3irQM+hv0fCRchGi8995kvLZBadbaphRo-3A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/27, Duy Nguyen wrote:
> On Fri, Jul 27, 2018 at 2:40 AM Stefan Beller <sbeller@google.com> wrote:
> >
> > Currently the refs API takes a 'ref_store' as an argument to specify
> > which ref store to iterate over; however it is more useful to specify
> > the repository instead (or later a specific worktree of a repository).
> 
> There is no 'later'. worktrees.c already passes a worktree specific
> ref store. If you make this move you have to also design a way to give
> a specific ref store now.
> 
> Frankly I still dislike the decision to pass repo everywhere,
> especially when refs code already has a nice ref-store abstraction.
> Some people frown upon back pointers. But I think adding a back
> pointer in ref-store, pointing back to the repository is the right
> move.

I don't quite understand why the refs code would need a whole repository
and not just the ref-store it self.  I thought the refs code was self
contained enough that all its state was based on the passed in
ref-store.  If its not, then we've done a terrible job at avoiding
layering violations (well actually we're really really bad at this in
general, and I *think* we're trying to make this better though the
object store/index refactoring).

If anything I would expect that the actual ref-store code would remain
untouched by any refactoring and that instead the higher-level API that
hasn't already been converted to explicitly use a ref-store (and instead
just calls the underlying impl with get_main_ref_store()).  Am I missing
something here?

-- 
Brandon Williams
