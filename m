Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E181F463
	for <e@80x24.org>; Thu, 12 Sep 2019 11:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfILLGb (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 07:06:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44563 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730923AbfILLGa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 07:06:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id k6so15810639wrn.11
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jI9wh9FkCy1zbEIh3onF4+F+p26qi/D0e7GyWe/BDNc=;
        b=BrjzbEgYhk9KYesDk3vm+hzRy45GsfJUUS9wG53trVZ/EBv+JiBMXy30R3OqleLlRf
         sLxlehsZSEb9GZqEc7+r7I1nWROpkzstoQCJyaxsT3tmbxJ1oEl+3VXLD84E2WnxC+I/
         6U3GZDv+g8ok2cx+eI6gU+wsBXviZMTFTSPEoZMpVObgN/VMM0TDfaz4dtJI1ZqNlyTU
         7VD5tREgtuKCv/2m6IYK7dBUTP0HZ9XkrCTPL6cRmZFsKXuaDSQO9edcqAlilCtjtwXP
         AaohDBPw1uE1jGL4MRKAfuO79RaYdGXbtk9SplFlthgAW8STh/OpqrSXeQG99N4Ju3cB
         Bplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jI9wh9FkCy1zbEIh3onF4+F+p26qi/D0e7GyWe/BDNc=;
        b=H19VwX5CdjRT7LN3+yhePuUKEPWBcVKeCk2+ua85jEBkcRJREJfCe+GobJFXULuSGo
         QZvAGS1jhJbzw0a4hKq5cDJzp+xGFBMttHoHDyPmsoFWpJ0n4Pq9fkG1kiBLBsjPROTp
         l0mFqjConiZNivR7zqUemmwyGw/tPiEMnqvMx72D4VrGZVbvI6ktDszpTgJNJyVz1CMF
         vaoVa7syn2e5oxwDW1wmmxON7y0xLVq9LRQgjKfdjz0RFlV8kDc7M0CXYkPRpnFj26T2
         zCLWNXTWrY+x2LUxKt0amwALtt0uQlZI9Ww+FyNpIvvs1aTWXTcXrgs4e9lWLgBJiF3b
         R3xg==
X-Gm-Message-State: APjAAAWyRKGR97MzA2enKkBKwM+YgLhx5apP2Iq9FYhb4Iyrm9HWzijH
        c6TCNEm0VvZFR5t6fymN2ok=
X-Google-Smtp-Source: APXvYqxVllEePQ/I/hwTii9/jqQUEKC2PIO+oWN4EebmXKDHc9eZ8kepJZi2FnoQTdOcEQMbHaDj0Q==
X-Received: by 2002:adf:ed44:: with SMTP id u4mr5007581wro.185.1568286388899;
        Thu, 12 Sep 2019 04:06:28 -0700 (PDT)
Received: from szeder.dev (x4db4440a.dyn.telefonica.de. [77.180.68.10])
        by smtp.gmail.com with ESMTPSA id e9sm969210wme.3.2019.09.12.04.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 04:06:27 -0700 (PDT)
Date:   Thu, 12 Sep 2019 13:06:20 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] upload-pack: disable commit graph more gently for
 shallow traversal
Message-ID: <20190912110620.GA3729@szeder.dev>
References: <20190912000414.GA31334@sigill.intra.peff.net>
 <20190912020748.GA76228@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912020748.GA76228@syl.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 11, 2019 at 10:07:48PM -0400, Taylor Blau wrote:
> > diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> > index 8210f63d41..7601664b74 100755
> > --- a/t/t5500-fetch-pack.sh
> > +++ b/t/t5500-fetch-pack.sh

> > +#  - we must use protocol v2, because it handles the "have" negotiation before
> > +#    processing the shallow direectives

s/ee/e/

> > +#
> > +test_expect_success 'shallow since with commit graph and already-seen commit' '
> > +	test_create_repo shallow-since-graph &&
> > +	(
> 
> I'm not sure if this same-level indentation is common, or you're missing
> an extra tab here. Either way.
> 
> > +	cd shallow-since-graph &&
> > +	test_commit base &&
> > +	test_commit master &&
> > +	git checkout -b other HEAD^ &&
> > +	test_commit other &&
> > +	git commit-graph write --reachable &&
> > +	git config core.commitGraph true &&
> 
> Another nit, but do you have any thoughts about using 'test_config' here
> instead of a pure 'git config'? I don't think that it really would
> matter much (since none of the other tests hopefully have anything to do
> with commit-graph, and doubly so if it is enabled by default, _and_
> since you're using your own repository), but anyway.

We can't simply replace that 'git config' command with 'test_config',
because it is implemented using 'test_when_finished', which doesn't
work in a subshell [1].  What we could do is:

  test_create_repo shallow-since-graph &&
  test_config -C shallow-since-graph core.commitGraph true &&
  (
     cd shallow-since-graph &&
     ....

Or we could entirely avoid the subshell by passing '-C
shallow-since-graph' to every single command... [2]

However, since this repo was specifically created for this test, it
doesn't really matter in what state it's left behind, so I don't think
it's worth it.


[1] 0968f12a99 (test-lib-functions: detect test_when_finished in
    subshell, 2015-09-05)
[2] Or bite the bullet, and declare that every test case shall start
    in $TRASH_DIRECTORY.

