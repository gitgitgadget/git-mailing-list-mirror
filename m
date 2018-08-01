Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 662721F597
	for <e@80x24.org>; Wed,  1 Aug 2018 18:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbeHAUEt (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 16:04:49 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42838 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403902AbeHATEt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 15:04:49 -0400
Received: by mail-pl0-f65.google.com with SMTP id z7-v6so9095056plo.9
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1QhpuLHAQI40Wt/vf5dQ9uDvWtKsslFoG1kCSJf1/UE=;
        b=tS9otAa0cw+Zlbn1xuzlY5uoMgoJhSd5QaquFmFnvXEj4JQVbbxNT7PcXGsmEfoHaF
         HR8PXmy9GJsWUAzWtfy+KFBIKRyngI6rj8e2QljKPaKZ6Ok9v4UL034+K6xI5CzCdZlx
         RBXunVn0SlkAz6XdHqw3YPx7IN5tWAQlyl80OJYWgEeJy7/DMUPSyK2ToDy27fgGmhfl
         dk+6miX7elyAkTGj6Gbum2RJDB+9/eycJzkYgLE0ic7x2BkgxRKYJBlHYC/2tUv8BJRF
         8KbBvEEuOijUOynUCLb4Yc90XfMcGpSBjyrcViv/FBF55K8TI+bEacpZU+uVzBAlR+TY
         QzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1QhpuLHAQI40Wt/vf5dQ9uDvWtKsslFoG1kCSJf1/UE=;
        b=HF0cptnIqzKhSo7ug7xgHRLfVj5LP3nj7Z+MhMTS9fAoXocfJfAWKXwQRZleVjPH5G
         Or5agjqHahl+/iXlxD08itSI7EoM5ZZk78cVYnCGrcV4e+NZtnrfM85uiaSz5GWAyHsK
         b1WqDt+MhTLD3s8GR5Caz6yJuWxHgMEPZHsWBRislH6c2HRYd72Lmi/xeh8fBIiBbTK1
         mqrBxXCLXp2OJw3hHz+g7Y3+EVG8eg6XAZzUu5+9By11nox9mPzr4PqTfv+R08BIRGC+
         gabEYkObQWdmNX+d6mQAU94TpYqmiZqD2YhJd4EgWLLkP43dpNrEgLb8sUNNcRdtEzSz
         hRNQ==
X-Gm-Message-State: AOUpUlGIVUtoi32eh96xxb7jJbz3MAC1eZt8og58I6sOSsnn3iRzvv4L
        WIz3TRmnGMbyTqj6ZopyTkXcKv2hjN8=
X-Google-Smtp-Source: AAOMgpe4eFPgaqepDr+BUdzAB2vVBoAsoGz6HuzJhxtvciSXgynVFc5PCKgQIClk1hrxJZPkItTKhg==
X-Received: by 2002:a17:902:904c:: with SMTP id w12-v6mr5881082plz.95.1533143888997;
        Wed, 01 Aug 2018 10:18:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id w13-v6sm19215293pgs.89.2018.08.01.10.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 10:18:07 -0700 (PDT)
Date:   Wed, 1 Aug 2018 10:18:06 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH] transport: report refs only if transport does
Message-ID: <20180801171806.GA122458@google.com>
References: <20180731192415.GC3372@sigill.intra.peff.net>
 <20180731232343.184463-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731232343.184463-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/31, Jonathan Tan wrote:
> > On Mon, Jul 30, 2018 at 03:56:01PM -0700, Jonathan Tan wrote:
> > 
> > > Commit 989b8c4452 ("fetch-pack: put shallow info in output parameter",
> > > 2018-06-28) allows transports to report the refs that they have fetched
> > > in a new out-parameter "fetched_refs". If they do so,
> > > transport_fetch_refs() makes this information available to its caller.
> > > 
> > > Because transport_fetch_refs() filters the refs sent to the transport,
> > > it cannot just report the transport's result directly, but first needs
> > > to readd the excluded refs, pretending that they are fetched. However,
> > > this results in a wrong result if the transport did not report the refs
> > > that they have fetched in "fetched_refs" - the excluded refs would be
> > > added and reported, presenting an incomplete picture to the caller.
> > 
> > This part leaves me confused. If we are not fetching them, then why do
> > we need to pretend that they are fetched?
> 
> The short answer is that we need:
>  (1) the complete list of refs that was passed to
>      transport_fetch_refs(),
>  (2) with shallow information (REF_STATUS_REJECT_SHALLOW set if
>      relevant), and
>  (3) with updated OIDs if ref-in-want was used.
> 
> The fetched_refs out param already fulfils (2) and (3), and this patch
> makes it fulfil (1). As for calling them fetched_refs, perhaps that is a
> misnomer, but they do appear in FETCH_HEAD even though they are not
> truly fetched.
> 
> Which raises the question...if completeness is so important, why not
> reuse the input list of refs and document that transport_fetch_refs()
> can mutate the input list? You ask the same question below, so I'll put
> the answer after quoting your paragraph.
> 
> > I think I am showing my lack of understanding about the reason for this
> > whole "return the fetched refs" scheme from 989b8c4452, and probably
> > reading the rest of that series would make it more clear. But from the
> > perspective of somebody digging into history and finding just this
> > commit, it probably needs to lay out a little more of the reasoning.
> 
> I think it's because 989b8c4452 is based on my earlier work [1] which
> also had a fetched_refs out param. Its main reason is to enable the
> invoker of transport_fetch_refs() to specify ref patterns (as you can
> see in a later commit in the same patch set [2]) - and if we specify
> patterns, the invoker of transport_fetch_refs() needs the resulting refs
> (which are provided through fetched_refs).
> 
> In the version that made it to master, however, there was some debate
> about whether ref patterns need to be allowed. In the end, ref patterns
> were not allowed [3], but the fetched_refs out param was still left in.
> 
> I think that reverting the API might work, but am on the fence about it.
> It would reduce the number of questions about the code (and would
> probably automatically fix the issue that I was fixing in the first

If you believe the API is difficult to work with (which given this bug
it is) then perhaps we go with your suggestion and revert the API back
to only providing a list of input refs and having the fetch operation
mutate that input list.

> place), but if we were to revert the API and then decide that we do want
> ref patterns in "want-ref" (or expand transport_fetch_refs in some
> similar way), we would need to revert our revert, causing code churn.

I haven't thought too much about what we would need to do in the event
we add patterns to ref-in-want, but couldn't we possible mutate the
input list again in this case and just simply add the resulting refs to
the input list?

> 
> [1] https://public-inbox.org/git/86a128c5fb710a41791e7183207c4d64889f9307.1485381677.git.jonathantanmy@google.com/
> [2] https://public-inbox.org/git/eef2b77d88df0db08e4a1505b06e0af2d40143d5.1485381677.git.jonathantanmy@google.com/
> [3] https://public-inbox.org/git/20180620213235.10952-1-bmwill@google.com/

-- 
Brandon Williams
