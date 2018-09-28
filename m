Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37661F453
	for <e@80x24.org>; Fri, 28 Sep 2018 10:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeI1QYv (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 12:24:51 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37205 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeI1QYu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 12:24:50 -0400
Received: by mail-wm1-f49.google.com with SMTP id y26-v6so1577756wma.2
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=asOjnYeL4/GzUG1SmpElQLCtj+3dqKMKmybEN2pcrSE=;
        b=P/PcqD2asrvf+NIN7z1WK7Chi+0q4zyWPe0SJG1r5pPlvmjVI7zFEhATIXbDHuV7jt
         u9Dow0wVWBtasXNrYvg/ZdPayOb7QGIi1jY4smiyc0kzWuqAZtyGpXs7f6G3US3ghyvt
         xYHIME5fpu1NEsjuSmiSRxDoDntYoRAGUot1ow1Ro+Y+sclA7nqXDMb5WYoaOcvdCKuw
         qarVWZkWfIYkcp3IolOZ+KDbjrIuE+4YgIPLAiiGJrcNYVsDea1S5jcL2nDzmm/+0zli
         m0QoxPdpdwJ5I2Fd+d8P12t9R22pBw4SaVoSfAQGEHBSrKm05ffzUqUy1Zwa1Im8LjGd
         xv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=asOjnYeL4/GzUG1SmpElQLCtj+3dqKMKmybEN2pcrSE=;
        b=ELpT0ZOeBr8g7BbylTDCSuIYbvFCq51Tvps3FdS/YFldTeOcwKTPZmJOIlmxyxNSM6
         TYlLm7lpHn77oh5gR6y6bvMoE6+wjyZRGgpVUkmlTersY/Sf+Q+LcnqLHscZOOTTX5Xv
         hxEsLWGUcLNV/4YjQIipW6kJ8rw9Fa9ng4OcpVWUv4i1CvJbBHFzi1felwpUn4jFvEWB
         NIo0m8jaUxuvqiKdURmOoc111b9/mgRqcllVAOh5CDhjE5uUPGY+7z9mDE318Wy9yYmZ
         BdArl9tFqZNlIDNxZodaU01YKkH4GvUz4uCysqXZmuZBwMzWl8oPIxHdXt0WgTR2fzyQ
         9eAQ==
X-Gm-Message-State: ABuFfojJK/AIOsZlbPiOm5W5ssjh9i/VpZBxfC7NA786K9VpYNC0LIqv
        Jng7VuhDiKp8gGYmFbMxPqA=
X-Google-Smtp-Source: ACcGV60+0SJGSjvmH69V31rpzxgfHbCPxesjEykJcT7cWpUYk6Ev7fhC3uaiAI+tApoC4TXbdpKPDw==
X-Received: by 2002:a1c:1d45:: with SMTP id d66-v6mr1154611wmd.107.1538128910391;
        Fri, 28 Sep 2018 03:01:50 -0700 (PDT)
Received: from localhost (x4db1ef73.dyn.telefonica.de. [77.177.239.115])
        by smtp.gmail.com with ESMTPSA id a105-v6sm11267308wrc.23.2018.09.28.03.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 03:01:49 -0700 (PDT)
Date:   Fri, 28 Sep 2018 12:01:43 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v3 3/5] fsmonitor: update GIT_TEST_FSMONITOR support
Message-ID: <20180928100143.GA23446@localhost>
References: <20180914143708.63024-1-benpeart@microsoft.com>
 <20180918232916.57736-1-benpeart@microsoft.com>
 <20180918232916.57736-4-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180918232916.57736-4-benpeart@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 18, 2018 at 11:29:35PM +0000, Ben Peart wrote:
> diff --git a/t/README b/t/README
> index 56a417439c..47165f7eab 100644
> --- a/t/README
> +++ b/t/README
> @@ -319,6 +319,10 @@ GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncommon pack-objects code
>  path where deltas larger than this limit require extra memory
>  allocation for bookkeeping.
>  
> +GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
> +code path for utilizing a file system monitor to speed up detecting
> +new or changed files.

Here you tell us to set GIT_TEST_FSMONITOR to an absolute path, and we
are good to go.

> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index 756beb0d8e..d77012ea6d 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -8,7 +8,7 @@ test_description='git status with file system watcher'
>  # To run the entire git test suite using fsmonitor:
>  #
>  # copy t/t7519/fsmonitor-all to a location in your path and then set
> -# GIT_FSMONITOR_TEST=fsmonitor-all and run your tests.
> +# GIT_TEST_FSMONITOR=fsmonitor-all and run your tests.

But this old comment is different, suggesting copying that script to
our $PATH.

I prefer your instructions above, because it's only a single step,
and, more importantly, it won't pollute my $PATH.  I think this
comment should be updated to make the advices in both places
consistent.  Or perhaps even removed, now that all GIT_TEST variables
are documented in the same place?

