Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7981F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeIMXOH (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:14:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37687 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeIMXOH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:14:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so7295752wrr.4
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7TlgsFyhA6OoWkYdpekyTrVz6aZgtpxYC05vsStFpwg=;
        b=OMG2FWYTY6orhiun/k8xW76YuHmHbhSFaG7fsgiT4GsPR1qvK4bzInkC3DkybA8viw
         horUNT0ims+1HG9tWXQE5a4k/QnRmdQvB8EW6FcdHE42fnPKZfe7mxeaE/5aLiwOQ1m4
         Hmr/xVtU1xTD8pbfGbbOpbEVJAAXN0Ss7y0yUFhv5XkhRujegbLfVx+mANLMqu+RR1fL
         NpEYsuUYIXnh24tT0xF2wLh1St3yF2jg8rLPPQuo9kn4nrOY0U6pCXYfJM+5Op8qmRGP
         lJmiAmSxMIsR5o/ev1Qh23oDgs6llE9fY1tfDhtEiDuYDofIh/W83NDiknlhth97g737
         VfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7TlgsFyhA6OoWkYdpekyTrVz6aZgtpxYC05vsStFpwg=;
        b=mIxutqk+LgeS3DK8+hjdIDr7ihinnNMPxk4bZ57T+5zYrwNkx5w3dsAGdPFsHnTE0T
         O2jOjxLUeWLTzHmeZ56jGp+fa4T+yiED/t9WitaJwyykdIPvgU7dnV+UoNtyGxWBCciu
         8afOrydtnLn0na7ksTYOjWSW7ZhpSc8LwutQORv9qtCi29t05VblhXb8LKqMveEEox/g
         dNNPtjUTeqIKVWNBrXkT1Qd1Ge3UZ6udPhWdDW1mF3+IA/yauObsCyDgHNWL/KLKAUWu
         dDkF2VVUvIkNFK/9+9OiaA24cQiO1IkN0g4Xjb3lIMkUjnJTebl2g1IBYGhgea4ZHkPT
         6mCQ==
X-Gm-Message-State: APzg51CYHM4we9MeMLlUMjwsOQq9eU3tLL+5eXGiaVq95YTCje2KRqwx
        krCY62iT8fvWn4O4JkpJf/M=
X-Google-Smtp-Source: ANB0VdYBFr1Rs4Yj8Fhi88+j+3pI99oFAV0bLlzor5lEM3qT3qj+kUzhu+iqBQoqvyWe0Ibz6UgE2Q==
X-Received: by 2002:adf:9e93:: with SMTP id a19-v6mr6796719wrf.70.1536861810806;
        Thu, 13 Sep 2018 11:03:30 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 200-v6sm7763903wmv.6.2018.09.13.11.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 11:03:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v1] fsmonitor: update GIT_TEST_FSMONITOR support
References: <20180913174522.53872-1-benpeart@microsoft.com>
Date:   Thu, 13 Sep 2018 11:03:29 -0700
In-Reply-To: <20180913174522.53872-1-benpeart@microsoft.com> (Ben Peart's
        message of "Thu, 13 Sep 2018 17:45:42 +0000")
Message-ID: <xmqqo9d1ff66.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> Rename GIT_FSMONITOR_TEST to GIT_TEST_FSMONITOR for consistency with the
> other GIT_TEST_ special setups and properly document its use.

Makes sense.

Thanks for such an attention to detail.

>
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---
>
> Notes:
>     Base Ref: v2.19.0
>     Web-Diff: https://github.com/benpeart/git/commit/311484a684
>     Checkout: git fetch https://github.com/benpeart/git git-test-fsmonitor-v1 && git checkout 311484a684
>
>  config.c                    | 2 +-
>  t/README                    | 4 ++++
>  t/t1700-split-index.sh      | 2 +-
>  t/t7519-status-fsmonitor.sh | 2 +-
>  4 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/config.c b/config.c
> index 3461993f0a..3555c63f28 100644
> --- a/config.c
> +++ b/config.c
> @@ -2278,7 +2278,7 @@ int git_config_get_max_percent_split_change(void)
>  int git_config_get_fsmonitor(void)
>  {
>  	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
> -		core_fsmonitor = getenv("GIT_FSMONITOR_TEST");
> +		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
>  
>  	if (core_fsmonitor && !*core_fsmonitor)
>  		core_fsmonitor = NULL;
> diff --git a/t/README b/t/README
> index 9028b47d92..545438c820 100644
> --- a/t/README
> +++ b/t/README
> @@ -319,6 +319,10 @@ GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncomon pack-objects code
>  path where deltas larger than this limit require extra memory
>  allocation for bookkeeping.
>  
> +GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
> +code path for utilizing a file system monitor to speed up detecting
> +new or changed files.
> +
>  Naming Tests
>  ------------
>  
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index b3b4d83eaf..f6a856f24c 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -6,7 +6,7 @@ test_description='split index mode tests'
>  
>  # We need total control of index splitting here
>  sane_unset GIT_TEST_SPLIT_INDEX
> -sane_unset GIT_FSMONITOR_TEST
> +sane_unset GIT_TEST_FSMONITOR
>  
>  test_expect_success 'enable split index' '
>  	git config splitIndex.maxPercentChange 100 &&
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
>  #
>  
>  # Note, after "git reset --hard HEAD" no extensions exist other than 'TREE'
>
> base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
