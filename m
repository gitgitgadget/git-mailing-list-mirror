Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3F41F404
	for <e@80x24.org>; Thu, 13 Sep 2018 21:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeINCvT (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 22:51:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42530 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeINCvT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 22:51:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so8226742wrr.9
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=H+tmjpr10TSCfKysqk/AuYfmr3cRKZBGUpAE9e9bX/M=;
        b=ISxN6aWV4MwvchYkPbk6er99YhIbBUOQDQ2lu8KEU1YVoLYAkU+C6Jyp9saOfWj4j0
         Dejtz2mCRpS2ULFSmCSgldyos9yBrl14QFFY/zhl2xbEgLbV9BRh423p1x2lElWD8wY7
         rX0q+6Eccoviuwi/U6uFgnsV3dygWYJCYR/PrPQtWJdzYBp0S1bLG1zDFZJYIgDGOSpE
         qj9YlqiSgB1g9mj1zy2ezfx0zHMDKcIYFs3VFzd/cy386p8E0Oaxcdnxh7WsBT/eiJ9E
         +SeJbYZHfGXmYVkIyUoyIt2ObDdtOVyiEFJY3CmsI6CKUBzeNvv6BLYrJu2aQi+YJrf8
         zEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=H+tmjpr10TSCfKysqk/AuYfmr3cRKZBGUpAE9e9bX/M=;
        b=flLp7RJvUW7fr1V6RaxhVKcVjWfI3sn8GpRsZUdVXaD60zddCvgVfaB5b4/EeVsLEu
         F03YcYuvvG0Ao2rF/p2rtwWm40bex7W9idzwIBgAHKNRd1gmMuU3+vipznTT1CBbdrXz
         A3z2U85mxE2S9EqLjFjXg1rInQexXx1MBIBpDJ/LUw/HeWp7hDKGzMlvBJqUFtADLIsC
         gDq/qyzW0mZ5a6sU920Naet/KhFR/5sfXeKkV4/zFVVwbCjxM8XsYeQGWVGgTlzLugzE
         b1VbYjLTlI1kwX47HluIeg5kI5kD8TN8vqFCwwutCqNTH9ZQyzGtd73pNywU3Bjfl2CS
         lSBw==
X-Gm-Message-State: APzg51B3UYh0OuzbAW0T+MI8ujou1X+GdLQbNKVjpvsyv4A2ikCCwCtW
        BIXGss+zszYxe3JdgoaiSwxp2ct1
X-Google-Smtp-Source: ANB0VdZGNnOjri/tI0INFN5I5MzTDM3D+ekSmpn+4fbow7ZurWPhKbm1P9TPPRvQKcYjJ8qP2+NeIQ==
X-Received: by 2002:a5d:6103:: with SMTP id v3-v6mr7483565wrt.265.1536874799074;
        Thu, 13 Sep 2018 14:39:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u40-v6sm8771049wrc.43.2018.09.13.14.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 14:39:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v1] preload-index: update GIT_FORCE_PRELOAD_TEST support
References: <20180913180054.29720-1-benpeart@microsoft.com>
Date:   Thu, 13 Sep 2018 14:39:58 -0700
In-Reply-To: <20180913180054.29720-1-benpeart@microsoft.com> (Ben Peart's
        message of "Thu, 13 Sep 2018 18:01:12 +0000")
Message-ID: <xmqqtvmtdqkx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> Rename GIT_FORCE_PRELOAD_TEST to GIT_TEST_PRELOAD for consistency with the
> other GIT_TEST_ special setups and properly document its use.
>
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---
>

Among the two unrelated changes that are not mentioned in the
proposed log message, the change to the test to use sane_unset is
probably OK, but replacing a call to getenv() with git_env_bool()
without making sure necessary header file(s) are included would
break the build.

I _think_ config.h is the header to include; I didn't try it,
though.

Thanks.


> Notes:
>     Base Ref: v2.19.0
>     Web-Diff: https://github.com/benpeart/git/commit/dcd201b920
>     Checkout: git fetch https://github.com/benpeart/git git-test-preload-v1 && git checkout dcd201b920
>
>  preload-index.c             | 2 +-
>  t/README                    | 3 +++
>  t/t7519-status-fsmonitor.sh | 4 ++--
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/preload-index.c b/preload-index.c
> index 71cd2437a3..cc8a7333c2 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -84,7 +84,7 @@ static void preload_index(struct index_state *index,
>  		return;
>  
>  	threads = index->cache_nr / THREAD_COST;
> -	if ((index->cache_nr > 1) && (threads < 2) && getenv("GIT_FORCE_PRELOAD_TEST"))
> +	if ((index->cache_nr > 1) && (threads < 2) && git_env_bool("GIT_TEST_PRELOAD", 0))
>  		threads = 2;
>  	if (threads < 2)
>  		return;
> diff --git a/t/README b/t/README
> index 9028b47d92..73fb09560f 100644
> --- a/t/README
> +++ b/t/README
> @@ -319,6 +319,9 @@ GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncomon pack-objects code
>  path where deltas larger than this limit require extra memory
>  allocation for bookkeeping.
>  
> +GIT_TEST_PRELOAD=<boolean> exercises the preload-index code path by
> +overriding the minimum number of cache entries required per thread.
> +
>  Naming Tests
>  ------------
>  
> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index 756beb0d8e..9b703d49b5 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -245,9 +245,9 @@ do
>  		git config core.preloadIndex $preload_val &&
>  		if test $preload_val = true
>  		then
> -			GIT_FORCE_PRELOAD_TEST=$preload_val; export GIT_FORCE_PRELOAD_TEST
> +			GIT_TEST_PRELOAD=$preload_val; export GIT_TEST_PRELOAD
>  		else
> -			unset GIT_FORCE_PRELOAD_TEST
> +			sane_unset GIT_TEST_PRELOAD
>  		fi
>  	'
>  
>
> base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
