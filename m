Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A58881F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 12:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeFBM3W (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 08:29:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52885 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeFBM3V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 08:29:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id 18-v6so7541931wml.2
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KG515haZSgFLHjt1D4FfUrHHcZjA32KyV6+6Kjoy2dI=;
        b=C8FYFPmOv1eXAoxwT3ea8lhqdEf959AGL9lvUaBKvr03UxBbjmwPrwrLLgGHqqSirz
         ++m1yl6hRj0+ecvEcYJf8RDl6GUkZ9F47bh3pp8x/w++P8U899cu8+mtzmk8isM2m6ws
         ReodgQ7NZqP89XuGCupBtvrsPgryjtuXUniehrMgGA3oYrgyNS32sLyvB9zSqhV+5vo+
         Dzmx47ooUs9JlR/+RkCPAg1xn6x7TqiYlasgaSvl2pRz/oGyNmra4NiRcYn6icjFr3Ig
         0xV7ZhyloB81nB2P3jEqXbTM83Am9Ph3UJAaX+c1J/gPdsjZiQT/Gjkb7BPMC6C+ku8S
         7JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=KG515haZSgFLHjt1D4FfUrHHcZjA32KyV6+6Kjoy2dI=;
        b=Ehdgu6EfnjTOiGyqL1RcYmptjgU+vpm2fUGrbNwbTvTqdXyX1QDWfDCfael5L7UTuc
         +ZSPNd3SMl8GMMz17Fu0CogvFHdnt/SU2LgQ1YE8rJKHRyl9GpWCFFVJucbU4OU7EJ0T
         n4N9EcZiAES3TEzbkbNBIJ/WyKPYPWw4Kgpc3R2J5M4frJtC5sxIuVMbFSFf4RRTQpYB
         KiREznUE5Y2hDHEdChFcNOz1DI6XAe8oJ5HoG6mMd6Fm410N43SdSljsu8/ajYidOseV
         lHs/Re1I52txy882tX+p+z5OIB5C/4My47Wyng2/SXJK1sKJrjkjpHHiJzUpzKrGVeza
         UXfw==
X-Gm-Message-State: APt69E2cHZGmTj5SoWXRoe9kEYkiiUF8fo1d/viqYsYHsBxHHxY1JvBF
        9Wh4wYud4nrna6v2NCfmdZE=
X-Google-Smtp-Source: ADUXVKJ8UaUANpUKHeMiQcQVW6CQWAqNtvdX+CoN0TcBBkLGBbe5ghrV/Cj+ZCAqrO42XDQGqakouw==
X-Received: by 2002:a1c:9788:: with SMTP id z130-v6mr5279331wmd.88.1527942560437;
        Sat, 02 Jun 2018 05:29:20 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri204.neoplus.adsl.tpnet.pl. [83.8.102.204])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3291286wmc.42.2018.06.02.05.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 05:29:19 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 14/20] commit-graph: verify commit date
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-15-dstolee@microsoft.com>
Date:   Sat, 02 Jun 2018 14:29:16 +0200
In-Reply-To: <20180524162504.158394-15-dstolee@microsoft.com> (Derrick
        Stolee's message of "Thu, 24 May 2018 16:25:57 +0000")
Message-ID: <8636y5v0bn.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

Nice and simple.  The only possible question may be the ordering of
patches in the series, namely whether this change should be before or
after test checking generation numbers.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c          | 6 ++++++
>  t/t5318-commit-graph.sh | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index ead92460c1..d2b291aca2 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -981,6 +981,12 @@ int verify_commit_graph(struct commit_graph *g)
>  				     oid_to_hex(&cur_oid),
>  				     graph_commit->generation,
>  				     max_generation + 1);
> +
> +		if (graph_commit->date != odb_commit->date)
> +			graph_report("commit date for commit %s in commit-graph is %"PRItime" != %"PRItime,
> +				     oid_to_hex(&cur_oid),
> +				     graph_commit->date,
> +				     odb_commit->date);

All right.  Very straightforward, good.

>  	}
>  
>  	return verify_commit_graph_error;
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 673b0d37d5..58adb8246d 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -273,6 +273,7 @@ GRAPH_BYTE_COMMIT_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN`
>  GRAPH_BYTE_COMMIT_EXTRA_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4`
>  GRAPH_BYTE_COMMIT_WRONG_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3`
>  GRAPH_BYTE_COMMIT_GENERATION=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 8`
> +GRAPH_BYTE_COMMIT_DATE=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12`
>  
>  # usage: corrupt_graph_and_verify <position> <data> <string>
>  # Manipulates the commit-graph file at the position
> @@ -372,4 +373,9 @@ test_expect_success 'detect incorrect generation number' '
>  		"generation"
>  '
>  
> +test_expect_success 'detect incorrect commit date' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATE "\01" \
> +		"commit date"
> +'

All right.

> +
>  test_done
