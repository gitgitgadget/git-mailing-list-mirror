Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF761F453
	for <e@80x24.org>; Tue, 23 Oct 2018 15:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeJXAMI (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 20:12:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55296 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbeJXAMI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 20:12:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id s10-v6so224559wmc.5
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bfAQEtfoDfddoDIXKL2kuTpWI0tbA9x3GbP7SLwEdvE=;
        b=rnfcQmO+Z0/9qQU1tila49SBqYskWp2oGn0R3Bvzjhaznp6zmWNR3c2b0UchRiEaVe
         QpT8vbwDRld5rfjdSFWKNIqvTeIdR+vSkStL6fnoyqWHhk7SUXI3Z4XY4l6y8x+v3v0S
         /pSGAS+V/iAb6/HngkB2O373L+ohAKAYIpExFXGzZ+01bVcY09Xs4PYt3zVSS8O67q5o
         pM0PY6zpbqVvRHuwwzcfZogtD+7BmlJi9wf7fWSVkwUgW+ozJL0ud+aV5xxk73s6db9S
         xYX4cwkN9O09ixSJJH+RWwndzDatok8Tj48t7ZbyUMPqT3JUXmcdxKdVJ0QWYyVNiMWQ
         srOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=bfAQEtfoDfddoDIXKL2kuTpWI0tbA9x3GbP7SLwEdvE=;
        b=H+EQxaBSrj44Jr5c/rX5OsZCuP1CZf7n+acrJd3vPACZrcHpHC2JpT3m+b5TaTI/QN
         8u7iRvVyzUHxyVQ+8TzRawb03mibskh0784+JqZCxR3RWkAWmlFdk9+eqNjr7c5A/mzV
         cnq+g1gc/yXCZw3O7gsw3b2+M1rfXQ/d1b8fiRbFYrximlBMPz3q0W1SZ8t1JLcqhX8+
         IJl5iOI1p3gCQs7h1UhkV7kfCR7BTQkKC4ChJaeispLpWt24bKqeQgu7lLaUIh0CQujk
         7rCg+MHvlOS+V+x9EFbZOpPN2LaHRKS41Vs21Bg80TJdAA3+X3m6DFvZGNPQZyYXuWHJ
         PYvg==
X-Gm-Message-State: AGRZ1gKhu+RsvQAWssmGnBQYad7DQQf5nIIQPRAWUGrgjXAlZLblgoia
        ZyHsdVb2jjvO4hFi6Zg5QYM=
X-Google-Smtp-Source: ACcGV63hW6wspQi8WW3H2sqLpLf8crD0t/YtKe9Q/hVfiOIHzXSH8JuYrdU4SAhP3hTxsGUH37tdyA==
X-Received: by 2002:a1c:b20d:: with SMTP id b13-v6mr20401346wmf.141.1540309690592;
        Tue, 23 Oct 2018 08:48:10 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ekc4.neoplus.adsl.tpnet.pl. [83.21.170.4])
        by smtp.gmail.com with ESMTPSA id f18-v6sm217927wre.86.2018.10.23.08.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 08:48:09 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 7/7] t6012: make rev-list tests more interesting
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
        <a21febe1128cbaf69f2201598d9efee6f6a4b2d8.1539729393.git.gitgitgadget@gmail.com>
Date:   Tue, 23 Oct 2018 17:48:08 +0200
In-Reply-To: <a21febe1128cbaf69f2201598d9efee6f6a4b2d8.1539729393.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 16 Oct 2018
        15:36:46 -0700 (PDT)")
Message-ID: <86lg6o64w7.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> As we are working to rewrite some of the revision-walk machinery,
> there could easily be some interesting interactions between the
> options that force topological constraints (--topo-order,
> --date-order, and --author-date-order) along with specifying a
> path.
>
> Add extra tests to t6012-rev-list-simplify.sh to add coverage of
> these interactions. To ensure interesting things occur, alter the
> repo data shape to have different orders depending on topo-, date-,
> or author-date-order.

Very nice, though I have noticed (please correct me if I am wrong) that
in all cases path limited query always have the same result for
--topo-order and for --date-order; as opposed to three different results
for three different revision sorting modes for path-less query.

>
> When testing using GIT_TEST_COMMIT_GRAPH, this assists in covering
> the new logic for topo-order walks using generation numbers. The
> extra tests can be added indepently.

Good.  I guess we are mainly interested in tests without limits and
exclusions, i.e. A or A B and not A..B or A...B walks.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t6012-rev-list-simplify.sh | 45 ++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
> index b5a1190ffe..a10f0df02b 100755
> --- a/t/t6012-rev-list-simplify.sh
> +++ b/t/t6012-rev-list-simplify.sh
> @@ -12,6 +12,22 @@ unnote () {
>  	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g"
>  }
>  
> +#
> +# Create a test repo with interesting commit graph:
> +#
> +# A--B----------G--H--I--K--L
> +#  \  \           /     /
> +#   \  \         /     /
> +#    C------E---F     J
> +#        \_/
> +#
> +# The commits are laid out from left-to-right starting with
> +# the root commit A and terminating at the tip commit L.

Do I understand it correctly that it is a visualization of history
created by existing code (which is a very nice to have)?

> +#
> +# There are a few places where we adjust the commit date or
> +# author date to make the --topo-order, --date-order, and
> +# --author-date-order flags produce different output.

Sidenote: it looks like "a few places" is "one place" for now...

> +
>  test_expect_success setup '
>  	echo "Hi there" >file &&
>  	echo "initial" >lost &&
> @@ -21,10 +37,18 @@ test_expect_success setup '
>  
>  	git branch other-branch &&
>  
> +	git symbolic-ref HEAD refs/heads/unrelated &&
> +	git rm -f "*" &&
> +	echo "Unrelated branch" >side &&
> +	git add side &&
> +	test_tick && git commit -m "Side root" &&
> +	note J &&
> +	git checkout master &&

I see that this fragment is moved earlier, but I don't know what
consequences it does have.

> +
>  	echo "Hello" >file &&
>  	echo "second" >lost &&
>  	git add file lost &&
> -	test_tick && git commit -m "Modified file and lost" &&
> +	test_tick && GIT_AUTHOR_DATE=$(($test_tick + 120)) git commit -m "Modified file and lost" &&
>  	note B &&

Nice trick, though I think it produces slightly unrealistic history (at
least in absence of the clock skew).  Author dates are ordinarily
earlier or equal to commit dates, and commits can be authored in
different order that they were committed.

>  
>  	git checkout other-branch &&
> @@ -63,13 +87,6 @@ test_expect_success setup '
>  	test_tick && git commit -a -m "Final change" &&
>  	note I &&
>  
> -	git symbolic-ref HEAD refs/heads/unrelated &&
> -	git rm -f "*" &&
> -	echo "Unrelated branch" >side &&
> -	git add side &&
> -	test_tick && git commit -m "Side root" &&
> -	note J &&
> -
>  	git checkout master &&
>  	test_tick && git merge --allow-unrelated-histories -m "Coolest" unrelated &&
>  	note K &&
> @@ -103,14 +120,24 @@ check_result () {
>  	check_outcome success "$@"
>  }
>  
> -check_result 'L K J I H G F E D C B A' --full-history
> +check_result 'L K J I H F E D C G B A' --full-history --topo-order
> +check_result 'L K I H G F E D C B J A' --full-history
> +check_result 'L K I H G F E D C B J A' --full-history --date-order
> +check_result 'L K I H G F E D B C J A' --full-history --author-date-order
>  check_result 'K I H E C B A' --full-history -- file
>  check_result 'K I H E C B A' --full-history --topo-order -- file
>  check_result 'K I H E C B A' --full-history --date-order -- file
> +check_result 'K I H E B C A' --full-history --author-date-order -- file
>  check_result 'I E C B A' --simplify-merges -- file
> +check_result 'I E C B A' --simplify-merges --topo-order -- file
> +check_result 'I E C B A' --simplify-merges --date-order -- file
> +check_result 'I E B C A' --simplify-merges --author-date-order -- file
>  check_result 'I B A' -- file
>  check_result 'I B A' --topo-order -- file
> +check_result 'I B A' --date-order -- file
> +check_result 'I B A' --author-date-order -- file
>  check_result 'H' --first-parent -- another-file
> +check_result 'H' --first-parent --topo-order -- another-file
>  
>  check_result 'E C B A' --full-history E -- lost
>  test_expect_success 'full history simplification without parent' '

More tests, looks good.
