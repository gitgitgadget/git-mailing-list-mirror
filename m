Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971D91F404
	for <e@80x24.org>; Wed, 12 Sep 2018 22:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeIMDhl (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 23:37:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36251 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbeIMDhk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 23:37:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id j192-v6so4094025wmj.1
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cQgb9kDNEVR94w2O9FGBvnONgfOQanNU5Bbx9ZW/W5A=;
        b=NqzgJdWjTd2G6+KkF1dMof1Hke9Re54G8ZENGS50RfXStio2IQJQwe3isEHygRt96e
         x6ZdJrJisr89sL/ZvQUipOOPD1NMTJwBFaMsSEW3PLQ0nbgh7i0oyNzm/TgYfvsIdn47
         le35K2r78X0DqhEJz4Mu2m1AdKwueJfTBgLwbDfAsPSIhoidqRHPghcHLqjlMit0uQ9b
         nOPemPUKXqABvyNrGMyqKKKqm+eTOjKjQJsuqcAJVKUNlemdiZ/4C3DK/5noS7ZuxtLg
         6VxJqNmkdX6bDm3OviNjnwMN/ztoli2ZhRGXoy8zX8E1gSYPpJ2n9MuQJYAEcFAy7QCE
         lRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cQgb9kDNEVR94w2O9FGBvnONgfOQanNU5Bbx9ZW/W5A=;
        b=ff8jr/4/9Lr7wh0kZiJKGadKOgJ57Pfy3HEOBXl/dh+0Yg+Q2Bqusru1mFT6E8V83u
         xIz/VX8SOl9ZHzkhpLabGx6k1OiJigz/CvmarNVoBNLtyrgPor0WdrZkK1y5aenVxQEN
         wGGiMZWv/0wf7AcYsidWzbZSrdyvC1kaGQp1zTvLE1JtVenQ2/XlLzjTSpbnibH2RMzm
         8UzXqHpG5RyHlDNDSMZp0tUpR04kJ9oFi2gk442KCJ0gfrnArB7LF6D/Cg4xy5pW1mrw
         gQSMOAoMxL+aUJxst08XlBQnHSY7grlXLu6ksMb933rzML0fHP1dscOpCESb/BB4+yVJ
         TBVQ==
X-Gm-Message-State: APzg51AOQ3WE04TKWS8F8RtcYjPofuRjKAJ+Udigtx4j3Y0gSWn2B87p
        9W14L2o8mj8SAwt7WlAdWCE=
X-Google-Smtp-Source: ANB0Vdb0jZtKvH4uPd6KUUO08AVtLOWT9grAPkasCcpsmnSBAn260s9kWRI7D1qYTKN3oVbePFXUig==
X-Received: by 2002:a1c:4007:: with SMTP id n7-v6mr3227411wma.108.1536791463135;
        Wed, 12 Sep 2018 15:31:03 -0700 (PDT)
Received: from localhost ([2.29.27.208])
        by smtp.gmail.com with ESMTPSA id j6-v6sm1438937wrq.25.2018.09.12.15.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 15:31:02 -0700 (PDT)
Date:   Wed, 12 Sep 2018 23:31:01 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v1] read-cache: add GIT_TEST_INDEX_VERSION support
Message-ID: <20180912223101.GA1719@hank.intra.tgummerer.com>
References: <20180912212544.33624-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912212544.33624-1-benpeart@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12, Ben Peart wrote:
> Teach get_index_format_default() to support running the test suite
> with specific index versions.  In particular, this enables the test suite
> to be run using index version 4 which is not the default so gets less testing.

I found this commit message slightly misleading.  Running the test
suite with specific index versions is already supported, by defining
TEST_GIT_INDEX_VERSION in 'config.mak'.  What we're doing here is
introduce an additional environment variable that can also be used to
set the index format in tests.

Even setting TEST_GIT_INDEX_VERSION=4 in the environment does run the
test suite with index-v4.  Admittedly the name is a bit strange
compared to our usual GIT_TEST_* environment variable names, and it
should probably be documented better (it's only documented in the
Makefile currently), but I'm not sure we should introduce another
environment variable for this purpose?

> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---
> 
> Notes:
>     Base Ref: v2.19.0
>     Web-Diff: https://github.com/benpeart/git/commit/52e733e2ce
>     Checkout: git fetch https://github.com/benpeart/git git-test-index-version-v1 && git checkout 52e733e2ce
> 
>  read-cache.c | 47 +++++++++++++++++++++++++++++++++--------------
>  t/README     |  6 +++++-
>  2 files changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 7b1354d759..d140ce9989 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1570,26 +1570,45 @@ static unsigned int get_index_format_default(void)
>  	char *envversion = getenv("GIT_INDEX_VERSION");
>  	char *endp;
>  	int value;
> -	unsigned int version = INDEX_FORMAT_DEFAULT;
> +	unsigned int version = -1;
> +
> +	if (envversion) {
> +		version = strtoul(envversion, &endp, 10);
> +		if (*endp ||
> +			version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
> +			warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
> +				"Using version %i"), INDEX_FORMAT_DEFAULT);
> +			version = INDEX_FORMAT_DEFAULT;
> +		}
> +	}
>  
> -	if (!envversion) {
> -		if (!git_config_get_int("index.version", &value))
> +	if (version == -1) {
> +		if (!git_config_get_int("index.version", &value)) {
>  			version = value;
> -		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
> -			warning(_("index.version set, but the value is invalid.\n"
> -				  "Using version %i"), INDEX_FORMAT_DEFAULT);
> -			return INDEX_FORMAT_DEFAULT;
> +			if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
> +				warning(_("index.version set, but the value is invalid.\n"
> +					"Using version %i"), INDEX_FORMAT_DEFAULT);
> +				version = INDEX_FORMAT_DEFAULT;
> +			}
>  		}
> -		return version;
>  	}
>  
> -	version = strtoul(envversion, &endp, 10);
> -	if (*endp ||
> -	    version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
> -		warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
> -			  "Using version %i"), INDEX_FORMAT_DEFAULT);
> -		version = INDEX_FORMAT_DEFAULT;
> +	if (version == -1) {
> +		envversion = getenv("GIT_TEST_INDEX_VERSION");
> +		if (envversion) {
> +			version = strtoul(envversion, &endp, 10);
> +			if (*endp ||
> +				version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
> +				warning(_("GIT_TEST_INDEX_VERSION set, but the value is invalid.\n"
> +					"Using version %i"), INDEX_FORMAT_DEFAULT);
> +				version = INDEX_FORMAT_DEFAULT;
> +			}
> +		}
>  	}
> +
> +	if (version == -1)
> +		version = INDEX_FORMAT_DEFAULT;
> +
>  	return version;
>  }
>  
> diff --git a/t/README b/t/README
> index 9028b47d92..f872638a78 100644
> --- a/t/README
> +++ b/t/README
> @@ -315,10 +315,14 @@ packs on demand. This normally only happens when the object size is
>  over 2GB. This variable forces the code path on any object larger than
>  <n> bytes.
>  
> -GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncomon pack-objects code
> +GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncommon pack-objects code
>  path where deltas larger than this limit require extra memory
>  allocation for bookkeeping.
>  
> +GIT_TEST_INDEX_VERSION=<n> exercises the index read/write code path
> +for the index version specified.  Can be set to any valid version
> +but the non-default version 4 is probably the most beneficial.
> +
>  Naming Tests
>  ------------
>  
> 
> base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
> -- 
> 2.18.0.windows.1
> 
