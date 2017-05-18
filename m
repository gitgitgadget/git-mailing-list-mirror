Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E171201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756124AbdERTFq (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:05:46 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34423 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755111AbdERTFp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:05:45 -0400
Received: by mail-pg0-f41.google.com with SMTP id u28so27017311pgn.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8r35UpDTTkoCXHbbjPXRMU/BzcNrAXOXtovnr3o07Hs=;
        b=EJlM9nSrTApbDftWNhdGmUzZxZr29Ln10zRmK6woBufuRUdyz4TLny7oBJQwkakhws
         ZFJ6PKm9qrO314P59ZHEanq9bQcAwVSB4IhC3cea+jbJSI+9Xn80K0KzxyL6VAelh2oE
         5rkRsSUZ1toj/h4B/sEgsIq7CgMAwfoEVSI5OR1vGojCwim+JV4zOpD2mnwAn4mtcgFd
         ihklIVAEqrpiJtvAAB2dnBInGCNR2X522JQjsWWcqZUASqah712JrNBJVx7vtYxgc1jw
         uRuwKb8dX4Z4kJS7WqzcbPE/3ts6YPfmSTmKawb9Dk6S5/jlYsuaU9jnMZltl7oHM5S6
         fQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8r35UpDTTkoCXHbbjPXRMU/BzcNrAXOXtovnr3o07Hs=;
        b=UrToxjf8k0dBrW1SARHXi4U8bTiEeEWtUw5unu/HAsNl5Yma8P5JBeczCJXfqHcNFG
         oaJ7+iJEk7ygZ0ZHqXUtVyTmG2w2V2CLk5DiI4lvmmxlouqpZh2Dzwlw+oi+7ncdk8tI
         VdW4IJBLqC0Ev1jUoqXQZxisHzRFfMSUjQpI+FK/mKumRO3ZArGW2/64Xj+y+F49k/R5
         yCF4Udk9C+oxuR3AKdEVzrlzhaWCcESMn1/P2KzElBqp9VZBzKeZhUB8+vRhs+foQ/jR
         GdDpDM76JZZCKpWUYcsZzX9D0h4JWYytR/YRLN1lVhWHKVqCclit/WFBrbA6rKiXTH0J
         KdnQ==
X-Gm-Message-State: AODbwcALMJ+7A+djH+yT32vof7O3SyU/eidUlyLhUhqzB3nLpakmuz6w
        VG1VHwpSjeXHFUiQ
X-Received: by 10.99.218.69 with SMTP id l5mr6278657pgj.88.1495134344172;
        Thu, 18 May 2017 12:05:44 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:98a0:fe87:dfcc:8fe4])
        by smtp.gmail.com with ESMTPSA id o20sm10424381pfa.96.2017.05.18.12.05.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:05:43 -0700 (PDT)
Date:   Thu, 18 May 2017 12:05:41 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] Add option to recurse into submodules
Message-ID: <20170518190541.GE112091@google.com>
References: <20170517213135.20988-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517213135.20988-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17, Stefan Beller wrote:
> In a submodule heavy workflow it becomes tedious to pass in
> --recurse-submodules all the time, so make an option for it.

I'm all for adding the config which applies to multiple commands.  I
think its probably necessary as we increase the number of commands which
can recurse.

I'm not as thrilled over the first patch in the series though.  Least
that's my first impression.  I probably need think about it a bit more
though.

> 
> Thanks,
> Stefan
> 
> Stefan Beller (3):
>   submodule.c: add has_submodules to check if we have any submodules
>   submodule test invocation: only pass additional arguments
>   Introduce submodule.recurse option
> 
>  Documentation/config.txt       |  5 +++
>  builtin/checkout.c             |  8 ++--
>  builtin/fetch.c                |  2 +-
>  builtin/read-tree.c            |  2 +-
>  builtin/reset.c                |  2 +-
>  builtin/submodule--helper.c    |  6 +--
>  submodule.c                    | 83 ++++++++++++++++++++++++++++++++++--------
>  submodule.h                    |  8 +++-
>  t/lib-submodule-update.sh      | 18 ++++++++-
>  t/t1013-read-tree-submodule.sh |  4 +-
>  t/t2013-checkout-submodule.sh  |  4 +-
>  t/t5526-fetch-submodules.sh    | 10 +++++
>  t/t7112-reset-submodule.sh     |  4 +-
>  unpack-trees.c                 |  2 +-
>  14 files changed, 121 insertions(+), 37 deletions(-)
> 
> -- 
> 2.13.0.18.g7d86cc8ba0
> 

-- 
Brandon Williams
