Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297A0208EC
	for <e@80x24.org>; Mon,  6 Aug 2018 15:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbeHFRKc (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:10:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46391 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbeHFRKc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 13:10:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so6979144pfn.13
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HzOGIEaW7m4t4zdA3Xu/fqrsEcQ5fP4EkhIdkPmuQgM=;
        b=LGGltT85mMWNhVjjYMmBFOYH9QdS8XgfLD1VI2bGt38o9b6qv3gFwFTDDusCKEY9Qh
         w6oTJj6ejsbazHzU3OTWfjBRnod6Ab4X+cxqdqubWW7jeHB069OzIZAez8IRXI5JnWQh
         9arjLx6BL+Ho/jeubJiR52hGVXVry7y+yqU/UVpUslre5hX32JYG4c9oQjTYV1pquEv/
         s1UyiW+SULsMBwD3w40wZ/5JdpZCOEMRZ7uLYEJdP+XGmM76dR5Cogz0Xg3tnfBMqnq2
         YaoMljax/27kCzHEmf0PrdQFprBGpaXHW7JF746ul+bNBo4Z7rScWVhWAgFjhh+BNqdP
         ITaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HzOGIEaW7m4t4zdA3Xu/fqrsEcQ5fP4EkhIdkPmuQgM=;
        b=rk1xkEXJpWQYPxO/QIfcOHShrORrUUpYi4DsoLjhvhWUOlf/bPa4hiNdK0VFYGUbK2
         bCkCynCt50hmsvPmm+WgvjRhamXrpjoMWd9bN95vthltUh15TfQ6lk6zMAR/yvWyvf70
         iu0zQUxCVwGOdaY1GmI7KCsTzSJju9+33ySF+kJsQCV/p0330hvf6rdh1qFtWSC+tJgj
         58RVslsqgUoP7hQkAupbV/yY+7XT7k4L3JmoVn7YW5Bdry/kVjPuKTKKP3WakwKSI6AF
         d++I4lSwXtFWIyQWdQMtvrI1bI87hsRCrhlmBno9vaK8eSffMZqywaCDtOOavJn1p1Xv
         YS5Q==
X-Gm-Message-State: AOUpUlEEYe2OFV1UGg9RGJI6AXCYz014Jj0IezDwMwhSYZFgEVmyMJnP
        /PXmdLdQlOTBEw5npfPSchhK+iNf
X-Google-Smtp-Source: AAOMgpfQesozEFuGYWGVbifcbWjanHQV8cUz1VUb7f0aQl+15QnJcqgFu8x9ijQiDSHbQ6NMrf2UlQ==
X-Received: by 2002:aa7:87d0:: with SMTP id i16-v6mr17478334pfo.82.1533567662837;
        Mon, 06 Aug 2018 08:01:02 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id q25-v6sm30584836pfk.96.2018.08.06.08.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 08:01:02 -0700 (PDT)
Date:   Mon, 6 Aug 2018 08:01:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add a script to diff rendered documentation
Message-ID: <20180806150100.GC97564@aiede.svl.corp.google.com>
References: <20180803205204.GA3790@sigill.intra.peff.net>
 <20180805204930.GA202464@genre.crustytoothpaste.net>
 <20180806133954.GA31282@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806133954.GA31282@sigill.intra.peff.net>
User-Agent: Mutt/+ (31e72e18) (2018-08-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

>   3. Default to number of CPUs, which is what a lot of other threading
>      in Git does. Unfortunately getting that from the shell is
>      non-trivial. I'm OK with $(grep -c ^processor /proc/cpuinfo), but
>      people on non-Linux platforms would have to fill in their own
>      implementation.

How about $(getconf _NPROCESSORS_ONLN)?  That's what Linux's
scripts/coccicheck uses (apropos of a recent discussion :)).
