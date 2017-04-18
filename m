Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9923C207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 21:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbdDRVkT (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 17:40:19 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35356 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdDRVkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 17:40:17 -0400
Received: by mail-wr0-f194.google.com with SMTP id l44so770900wrc.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rTUDpQXpmHYSnmrRCc9ua6dwI5+z6/NWjpNE1ZSru4Q=;
        b=lRGCFf23cKKx+V8wDleMjCcBhLDuX5ijwucuu6jrQ8zjk2uYYXgDIsnuYrGQwcQRQU
         +zKng1uGG7XZ8THzu/Kxs5V7tj42vZ8K2vcCQ0dO/6p6KZyP/yEA6e8e5DshT837V0Kk
         2xuYAP7sXs0qh2thbT3Eeg8kusge7unkUEafdMi2JqrdQd29qckPIo7sbZnbPU9dFlKe
         U/7TfVv/Dj5Dmv/+6wIPrHDHMfV8JJV/wceWwLwbg/uqwYswVkVXvhBBEk1brymdu2kL
         VY1ENwunKEw/EKmtA7Z89uA8EOsB8r5jzChgAreYaT0ND9hEwyBRuPgrp2fr724QF3sQ
         96vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rTUDpQXpmHYSnmrRCc9ua6dwI5+z6/NWjpNE1ZSru4Q=;
        b=RqQ2/XcusiAa9RhQZ8keO3Ij7RaeTKfeFqRTHEmS1Gl7EZl3/WeSwhTIZpfPCd9qG3
         H0LniEH8XbdAzHTDBZnIsjIBFbDBw8VZvuHs+jBrerSgsZy8dUffUPp6ytIPlRRKGwXp
         AA5CvLisx4l1zED8vASORpLaAWsMKDnNfUrN2daX8S65iXhyEpSxRFqpym7cVGv2fkKl
         hW2Nuoble9nW12ForNpDjJvS5mIe4Nh5E8MmhA1eE3lZjceXqHa1et/yWE1izsjxNIsQ
         V5OKPWtZbhOAgFoF3WLS2+faeZEvnEaEdGJbS4n1N+RcfhamuT+V5vbzPxPQdobcI3/U
         zoGw==
X-Gm-Message-State: AN3rC/5+sADPLsBlc8cG7Zu05bNCBsXIjpiivpU1OFbAJpLdLEnX4l9V
        uh8W7adBuL6NJfuQGCU=
X-Received: by 10.223.169.205 with SMTP id b71mr23249586wrd.80.1492551615413;
        Tue, 18 Apr 2017 14:40:15 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id s49sm536821wrc.5.2017.04.18.14.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Apr 2017 14:40:14 -0700 (PDT)
Date:   Tue, 18 Apr 2017 22:40:25 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v11 2/5] p0006-read-tree-checkout: perf test to time
 read-tree
Message-ID: <20170418214025.GA4989@hank>
References: <20170417213734.55373-1-git@jeffhostetler.com>
 <20170417213734.55373-3-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417213734.55373-3-git@jeffhostetler.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/17, git@jeffhostetler.com wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Created t/perf/repos/many-files.sh to generate large, but
> artificial repositories.
> 
> Created t/perf/p0006-read-tree-checkout.sh to measure
> performance on various read-tree, checkout, and update-index
> operations.  This test can run using either artificial repos
> described above or normal repos.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/perf/p0006-read-tree-checkout.sh |  67 ++++++++++++++++++++++
>  t/perf/repos/.gitignore            |   1 +
>  t/perf/repos/many-files.sh         | 110 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 178 insertions(+)
>  create mode 100755 t/perf/p0006-read-tree-checkout.sh
>  create mode 100644 t/perf/repos/.gitignore
>  create mode 100755 t/perf/repos/many-files.sh
> 
> diff --git a/t/perf/p0006-read-tree-checkout.sh b/t/perf/p0006-read-tree-checkout.sh
> new file mode 100755
> index 0000000..78cc23f
> --- /dev/null
> +++ b/t/perf/p0006-read-tree-checkout.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +#
> +# This test measures the performance of various read-tree
> +# and checkout operations.  It is primarily interested in
> +# the algorithmic costs of index operations and recursive
> +# tree traversal -- and NOT disk I/O on thousands of files.
> +
> +test_description="Tests performance of read-tree"
> +
> +. ./perf-lib.sh
> +
> +test_perf_default_repo

I like that it's possible to use a real world repository now instead
of forcing the use of a synthetic repository :)

Is there a reason for this being test_perf_default_repo instead of
test_perf_large_repo?  It seems like generating a large repo is what
you are doing with repos/many-files.sh.

> +
> +# If the test repo was generated by ./repos/many-files.sh
> +# then we know something about the data shape and branches,
> +# so we can isolate testing to the ballast-related commits
> +# and setup sparse-checkout so we don't have to populate
> +# the ballast files and directories.
> +#
> +# Otherwise, we make some general assumptions about the
> +# repo and consider the entire history of the current
> +# branch to be the ballast.
> +
> +test_expect_success "setup repo" '
> +	if git rev-parse --verify refs/heads/p0006-ballast^{commit}
> +	then
> +		echo Assuming synthetic repo from many-files.sh
> +		git branch br_base            master
> +		git branch br_ballast         p0006-ballast^
> +		git branch br_ballast_alias   p0006-ballast^
> +		git branch br_ballast_plus_1  p0006-ballast
> +		git config --local core.sparsecheckout 1
> +		cat >.git/info/sparse-checkout <<-EOF
> +		/*
> +		!ballast/*
> +		EOF
> +	else
> +		echo Assuming non-synthetic repo...
> +		git branch br_base            $(git rev-list HEAD | tail -n 1)
> +		git branch br_ballast         HEAD^ || error "no ancestor commit from current head"
> +		git branch br_ballast_alias   HEAD^
> +		git branch br_ballast_plus_1  HEAD
> +	fi &&
> +	git checkout -q br_ballast &&
> +	nr_files=$(git ls-files | wc -l)
> +'
> +
> +test_perf "read-tree br_base br_ballast ($nr_files)" '
> +	git read-tree -m br_base br_ballast -n
> +'
> +
> +test_perf "switch between br_base br_ballast ($nr_files)" '
> +	git checkout -q br_base &&
> +	git checkout -q br_ballast
> +'
> +
> +test_perf "switch between br_ballast br_ballast_plus_1 ($nr_files)" '
> +	git checkout -q br_ballast_plus_1 &&
> +	git checkout -q br_ballast
> +'
> +
> +test_perf "switch between aliases ($nr_files)" '
> +	git checkout -q br_ballast_alias &&
> +	git checkout -q br_ballast
> +'
> +
> +test_done
> diff --git a/t/perf/repos/.gitignore b/t/perf/repos/.gitignore
> new file mode 100644
> index 0000000..72e3dc3
> --- /dev/null
> +++ b/t/perf/repos/.gitignore
> @@ -0,0 +1 @@
> +gen-*/
> diff --git a/t/perf/repos/many-files.sh b/t/perf/repos/many-files.sh
> new file mode 100755
> index 0000000..5a1d25e
> --- /dev/null
> +++ b/t/perf/repos/many-files.sh
> @@ -0,0 +1,110 @@
> +#!/bin/sh
> +## Generate test data repository using the given parameters.
> +## When omitted, we create "gen-many-files-d-w-f.git".
> +##
> +## Usage: [-r repo] [-d depth] [-w width] [-f files]
> +##
> +## -r repo: path to the new repo to be generated
> +## -d depth: the depth of sub-directories
> +## -w width: the number of sub-directories at each level
> +## -f files: the number of files created in each directory
> +##
> +## Note that all files will have the same SHA-1 and each
> +## directory at a level will have the same SHA-1, so we
> +## will potentially have a large index, but not a large
> +## ODB.
> +##
> +## Ballast will be created under "ballast/".

I think comments should start only with a single '#' in the git
source, as you already have it in p0006.

[...]
