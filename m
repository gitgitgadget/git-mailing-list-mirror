Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F7F1F461
	for <e@80x24.org>; Fri,  6 Sep 2019 16:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405921AbfIFQsX (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 12:48:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33529 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfIFQsX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 12:48:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id t11so3432579plo.0
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uj/qftR6yrt0IHyj4Tt2gi6sDPHKmKVoVwBx/EgDmIE=;
        b=DkJjA5uQKSHWnSu5mPnM3WOyfZdkk3eheFET40iSeg/pc4mpt6GFU4ud7/XX47pAtM
         S+k3a/RwxIT7mEz/rNvI2Ifq/pNxJDK7kWxSjMJJe9L1YeFWYtctVtQzRUbmxa1yDXkI
         s5qiD8fyveGQuYIIrFcfaPtZoWw+R12mNkxa4TSMmRLmldTjVrvGoEJep6s2Tm45elsX
         4b0WmEl/sCjZe8sZpjulqh9YrJYT+vXIkgclZqCoQn/9XKpCsTtqfTQW/rCiyDS3mdwL
         9tLxe7NI4/TLcilFGKy6jgtydJdwh7gJ3kHeABLZ1yp/qv/V5btWlMW7ucnal5gsarYj
         gtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uj/qftR6yrt0IHyj4Tt2gi6sDPHKmKVoVwBx/EgDmIE=;
        b=tuqloy7Gy5HK3U181KJN2HYx1Px5KKI0S2ZReoIR0HvNuqfCACoDwTuTg92mUsdDa1
         m5jpReBr9gVJdwh5Dd4flukRjVre9Vp5spFxKrNc/U43StCXls4QGd5Js+JPFRGpGMCr
         u2VWJ4yzFvaMZUhuuZYph4WqdfyVRuDtMFBvkTGzlOr3yQYeWYO1RG/24yLfsPYUBlzs
         MjZJ7whYhNDQx6hKtuL/lpUDc+LokiWlKKtyIGFURg0i/PBggYjHCN8F1jvsL0pere21
         g/31HtTwerodVBcA3HDcWiVsQqC7XBNvm9OmnvGbDZIzJMEP8Q/VeTeIEytv/4XwyUj3
         Vu7g==
X-Gm-Message-State: APjAAAVwGPIJU9k0IwhiVnW9oDexB8ckZRBLaTvJfw2AhkPNd+0U7oTE
        ZgpNWGc2CXPjQC9EOY+QXPA=
X-Google-Smtp-Source: APXvYqzdeOG21b97dhNeGgLDB3V24SwuJUifnk5bRYIdt8Wle6O4wLNXI7mPOaBOi5NYwkMjy3h6zQ==
X-Received: by 2002:a17:902:6b43:: with SMTP id g3mr10243213plt.124.1567788502473;
        Fri, 06 Sep 2019 09:48:22 -0700 (PDT)
Received: from ?IPv6:2603:3023:803:400:4c28:4024:4b1c:1fde? ([2603:3023:803:400:4c28:4024:4b1c:1fde])
        by smtp.gmail.com with ESMTPSA id s1sm13188859pjs.31.2019.09.06.09.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 09:48:21 -0700 (PDT)
Subject: Re: [PATCH 1/3] t/t5318: introduce failing 'git commit-graph write'
 tests
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
References: <cover.1567720960.git.me@ttaylorr.com>
 <042a8ba8b2a98c269f9cd1a8e88488b80d686f0d.1567720960.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6035f5bf-3d09-f454-f9f6-c882bc0604c9@gmail.com>
Date:   Fri, 6 Sep 2019 12:48:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <042a8ba8b2a98c269f9cd1a8e88488b80d686f0d.1567720960.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/5/2019 6:04 PM, Taylor Blau wrote:
> When invoking 'git commit-graph' in a corrupt repository, one can cause
> a segfault when ancestral commits are corrupt in one way or another.
> This is due to two function calls in the 'commit-graph.c' code that may
> return NULL, but are not checked for NULL-ness before dereferencing.
> 
> Before fixing the bug, introduce two failing tests that demonstrate the
> problem. The first test corrupts an ancestral commit's parent to point
> to a non-existent object. The second test instead corrupts an ancestral
> tree by removing the 'tree' information entirely from the commit. Both
> of these cases cause segfaults, each at different lines.

Thanks for the tests! And marking them as "test_expect_failure" avoids
issues with 'git bisect' in the future.

-Stolee	

> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/t5318-commit-graph.sh | 43 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index ab3eccf0fa..c855f81930 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -585,4 +585,47 @@ test_expect_success 'get_commit_tree_in_graph works for non-the_repository' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_failure 'corrupt commit-graph write (broken parent)' '
> +	rm -rf repo &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		empty="$(git mktree </dev/null)" &&
> +		cat >broken <<-EOF &&
> +		tree $empty
> +		parent 0000000000000000000000000000000000000000
> +		author whatever <whatever@example.com> 1234 -0000
> +		committer whatever <whatever@example.com> 1234 -0000
> +
> +		broken commit
> +		EOF
> +		broken="$(git hash-object -w -t commit --literally broken)" &&
> +		git commit-tree -p "$broken" -m "good commit" "$empty" >good &&
> +		test_must_fail git commit-graph write --stdin-commits \
> +			<good 2>test_err &&
> +		test_i18ngrep "unable to parse commit" test_err
> +	)
> +'
> +
> +test_expect_failure 'corrupt commit-graph write (missing tree)' '
> +	rm -rf repo &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		tree="$(git mktree </dev/null)" &&
> +		cat >broken <<-EOF &&
> +		parent 0000000000000000000000000000000000000000
> +		author whatever <whatever@example.com> 1234 -0000
> +		committer whatever <whatever@example.com> 1234 -0000
> +
> +		broken commit
> +		EOF
> +		broken="$(git hash-object -w -t commit --literally broken)" &&
> +		git commit-tree -p "$broken" -m "good" "$tree" >good &&
> +		test_must_fail git commit-graph write --stdin-commits \
> +			<good 2>test_err &&
> +		test_i18ngrep "unable to get tree for" test_err
> +	)
> +'
> +
>  test_done
> 
