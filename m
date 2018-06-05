Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 431D51F517
	for <e@80x24.org>; Tue,  5 Jun 2018 21:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeFEV2d (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 17:28:33 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33521 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeFEV2c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 17:28:32 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so1999420pfi.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 14:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hR0SLo1WHcQ7qj5pocC6sFf1t12q95Rqa/5OEYmON50=;
        b=YekbZ1+5Hmsj/4yqch4nmFQi1+b1IqCwW72wKf+Uq8gacHxJeOLN6QE5NYeJJkYRg6
         6ApCZPYdZy+zNv91FryLNmdMRFdPRS7gqFW9SWBYQF+H1vr+MP8OUymlAL1U7cyRuDkH
         I50K6mWk4HGYPwEtyNNGjD36GKEDrtSPCGo+KYVLQ8Z8INSFIpiUdXiZNw0aJXoqulJ4
         glgNNirXtH19I1dCNXSouvl8FjWHXAksEVLi115f812IznR6REdizm5KdXgpV2KexhQD
         aQRobPq8lgLp0BOnTVHeCT9jWPR9jaHbkU0db3M7DfODV3EUB0kS4hnP09myd3k44Ptd
         MAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hR0SLo1WHcQ7qj5pocC6sFf1t12q95Rqa/5OEYmON50=;
        b=JaJNyKuQb5ObkfRiaDhw3z56IrKDhGLpqg1WCbfMEn6TTRzojTKwLWxbIBnVDSWDgG
         /pESgL7QU6F3HEyMOuOnQO2GB6y9doz+xEOFur5OGm6oNl713KLNA9brrHJ/EcEofwu7
         WTb26gGJgiw1/R+J1H1JrdkSE1MF+qZ4QPRpV5ymP1VgDGvl1bznElBCSPsgGEzYzMg+
         yL1hGk5dGTGMUKLAxPiS2FhRDxZr+Lqm6EndSoiVj+8CFnVLqkG9ZMPbsscRV8Z1Jq+y
         qWUYpehbo6SaBrVY1fXWsQg6t2okXn0p/mqwcmbSZUAGpWkYh+4oo/IHUwVsyVJLwMQ4
         wg2Q==
X-Gm-Message-State: APt69E1SqasJuIURYZ8KxfVsSkYVc5jXYbxh0xWXaglFU0NtXlnoOAIn
        IGOqr5rYssdSIPRuBW2zmufg2CaybfU=
X-Google-Smtp-Source: ADUXVKKEhomNYJ1KRxJ3KZPd8QkUxmTrz9qyBs45dQb8BQBWwWntjhMnxkNufD4HnjsqYShpK2n9SQ==
X-Received: by 2002:a62:5004:: with SMTP id e4-v6mr272117pfb.71.1528234111721;
        Tue, 05 Jun 2018 14:28:31 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id o72-v6sm18722015pfk.76.2018.06.05.14.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 14:28:30 -0700 (PDT)
Date:   Tue, 5 Jun 2018 14:28:29 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
Message-ID: <20180605212829.GG158365@google.com>
References: <cover.1528233146.git.jonathantanmy@google.com>
 <4d69aa14dadbbc53defa6d7d6c9a62f2b02a0bfb.1528233146.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d69aa14dadbbc53defa6d7d6c9a62f2b02a0bfb.1528233146.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05, Jonathan Tan wrote:
> When performing tag following, in addition to using the server's
> "include-tag" capability to send tag objects (and emulating it if the
> server does not support that capability), "git fetch" relies upon the
> presence of refs/tags/* entries in the initial ref advertisement to
> locally create refs pointing to the aforementioned tag objects. When
> using protocol v2, refs/tags/* entries in the initial ref advertisement
> may be suppressed by a ref-prefix argument, leading to the tag object
> being downloaded, but the ref not being created.
> 
> Commit dcc73cf7ff ("fetch: generate ref-prefixes when using a configured
> refspec", 2018-05-18) ensured that "refs/tags/" is always sent as a ref
> prefix when "git fetch" is invoked with no refspecs, but not when "git
> fetch" is invoked with refspecs. Extend that functionality to make it
> work in both situations.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/fetch.c        |  2 +-
>  t/t5702-protocol-v2.sh | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ea5b9669a..1f447f1e8 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -359,7 +359,7 @@ static struct ref *get_ref_map(struct transport *transport,
>  		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
>  
>  	if (ref_prefixes.argc &&
> -	    (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
> +	    (tags == TAGS_SET || tags == TAGS_DEFAULT)) {
>  		argv_array_push(&ref_prefixes, "refs/tags/");
>  	}

This is difficult...Really I don't think the default should be to follow
tags.  Mostly because this defeats the purpose of ref filtering when a
user only requests the master branch.  Now instead of the server only
sending the master branch, you get the whole tags namespace as well.

>  
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 261e82b0f..6733579c1 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -406,6 +406,24 @@ test_expect_success 'fetch supports various ways of have lines' '
>  		$(git -C server rev-parse completely-unrelated)
>  '
>  
> +test_expect_success 'fetch supports include-tag and tag following' '
> +	rm -rf server client trace &&
> +	git init server &&
> +
> +	test_commit -C server to_fetch &&
> +	git -C server tag -a annotated_tag -m message &&
> +
> +	git init client &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
> +		fetch "$(pwd)/server" to_fetch:to_fetch &&
> +
> +	grep "fetch> ref-prefix to_fetch" trace &&
> +	grep "fetch> ref-prefix refs/tags/" trace &&
> +	grep "fetch> include-tag" trace &&
> +
> +	git -C client cat-file -e $(git -C client rev-parse annotated_tag)
> +'
> +
>  # Test protocol v2 with 'http://' transport
>  #
>  . "$TEST_DIRECTORY"/lib-httpd.sh
> -- 
> 2.17.0.768.g1526ddbba1.dirty
> 

-- 
Brandon Williams
