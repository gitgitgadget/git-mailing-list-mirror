Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC471F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 14:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404361AbfJWOSV (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 10:18:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54092 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392077AbfJWOSV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 10:18:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id i13so6181320wmd.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hIsXMjihAeurmF8DuCsRE6Tf2rWlIF7LgOq1ebpDTM0=;
        b=IjnQneyOCM5A1a4LJehkNbAvt8IucpfvLFGAkIhBXC/utW62+1t4jF9u/J8c0kOr+U
         69iJwXeEuCWWrc/3+Et7vpavRmyrq2HlA6zgVC1O/0dU675CO4BjEWJise9CTXEB8jYb
         FANq92c91EaYwEINRdpHQuLhWww0ecpQ9dE4xALRCg6GSzAWxhxlaTT1nPEUq4L5gmwj
         BrGPRkQcHlC1oG0IIvd1G2UAjFm4HC3HWgQyuI6rwKBYSiNg4fG1sqdwFrgE6WOqP6Yr
         VfVn/poipnrjJfecXJKJtITGzwMuBRBKgzhEUiIcsbP1fXvekbu9r+T0AFJsVcYuiLed
         rG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hIsXMjihAeurmF8DuCsRE6Tf2rWlIF7LgOq1ebpDTM0=;
        b=rsMHHih7VE4Zkbo61NA+38B7mLYUd9ffwWwCa1X45sVE9yHUcm8mfQfapZHZvFAcHk
         RPH/yPCp1qHmHLlAE2c+ssYkD/9ZdkX5M28jiL7NfaVE2ntOrNJc3V/9sTRMWqaR992X
         Ot2acu7s4OztPd5nQFNG8uVpCxwX6F1QHaJqccHqTOlvzrYWfW5rQXWrlHbW2RZolSOm
         FnwM2mSaqanWT+u6EFgK9EZ5Pc54GXVUfkrc5N0e0ZeMJRLIZYZKirZRIKp8WiVe6nXX
         qq+cyAnHfCMvs4K4j/W6yfTLb3Eih2FxIqv4fi6DYfwC/E+r7+95ynkrW1y4A9aAGIyu
         QuMg==
X-Gm-Message-State: APjAAAVn0JkciRoRoKRpjDmZL2AR/Vu2wpUmN8Khzez3gF1M1LLndDTv
        2JPbIoVWdfZJePzVrcILFzs=
X-Google-Smtp-Source: APXvYqztaSqHRr1MMsskb+kd+cvccA+4SAcu5PEgsRQUEPXbzJnwZCXjXwy2e9rijiRRZqOBCB6PDQ==
X-Received: by 2002:a1c:1f4b:: with SMTP id f72mr164185wmf.22.1571840298889;
        Wed, 23 Oct 2019 07:18:18 -0700 (PDT)
Received: from szeder.dev (x4db97b71.dyn.telefonica.de. [77.185.123.113])
        by smtp.gmail.com with ESMTPSA id d8sm8629901wrr.71.2019.10.23.07.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 07:18:18 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:18:13 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] t5510-fetch.sh: demonstrate
 fetch.writeCommitGraph bug
Message-ID: <20191023141813.GA26017@szeder.dev>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
 <pull.415.v2.git.1571835695.gitgitgadget@gmail.com>
 <6ac0a05746df8ac3b1dd788f525b2620bc4d9a08.1571835695.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ac0a05746df8ac3b1dd788f525b2620bc4d9a08.1571835695.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 01:01:34PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> While dogfooding, Johannes found a bug in the fetch.writeCommitGraph
> config behavior. His example initially happened during a clone with
> --recurse-submodules, we found that this happens with the first fetch
> after cloning a repository that contains a submodule:
> 
> 	$ git clone <url> test
> 	$ cd test
> 	$ git -c fetch.writeCommitGraph=true fetch origin
> 	Computing commit graph generation numbers: 100% (12/12), done.
> 	BUG: commit-graph.c:886: missing parent <hash1> for commit <hash2>
> 	Aborted (core dumped)
> 
> In the repo I had cloned, there were really 60 commits to scan, but
> only 12 were in the list to write when calling
> compute_generation_numbers(). A commit in the list expects to see a
> parent, but that parent is not in the list.
> 
> A follow-up will fix the bug, but first we create a test that
> demonstrates the problem.
> 
> I used "test_expect_failure" for the entire test instead of
> "test_must_fail" only on the command that I expect to fail. This is
> because the BUG() returns an exit code so test_must_fail complains.

I don't think this paragraph is necessary; using 'test_expect_failure'
is the way to demonstrate a known breakage.

'test_must_fail' should only be used when the failure is the desired
behavior of a git command.  (I used the word "desired" here, because
you just used the word "expect" above in the sense that "I expect it
to fail, because I know it's buggy, and I want to demonstrate that
bug")

> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Szeder Gábor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t5510-fetch.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index ecabbe1616..e8ae3af0b6 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -583,6 +583,23 @@ test_expect_success 'fetch.writeCommitGraph' '
>  	)
>  '
>  
> +test_expect_failure 'fetch.writeCommitGraph with submodules' '
> +	pwd="$(pwd)" &&
> +	git clone dups super &&
> +	(
> +		cd super &&
> +		git submodule add "file://$pwd/three" &&

Nits: couldn't the URL simply be file://$TRASH_DIRECTORY/three ?

> +		git commit -m "add submodule"
> +	) &&
> +	git clone "super" writeError &&

There is a write error now, because we have a bug, but after the next
patch the bug will be fixed and we won't have a write error anymore.

> +	(
> +		cd writeError &&
> +		test_path_is_missing .git/objects/info/commit-graphs/commit-graph-chain &&
> +		git -c fetch.writeCommitGraph=true fetch origin &&
> +		test_path_is_file .git/objects/info/commit-graphs/commit-graph-chain
> +	)
> +'
> +
>  # configured prune tests
>  
>  set_config_tristate () {
> -- 
> gitgitgadget
> 
