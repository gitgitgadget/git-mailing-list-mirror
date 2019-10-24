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
	by dcvr.yhbt.net (Postfix) with ESMTP id 629431F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 12:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439661AbfJXMS1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 08:18:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35437 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439651AbfJXMS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 08:18:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id v6so2391632wmj.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 05:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dxCuwXQ7HI/yi9PTfXuL8SVkY7BbJHojvjFZGjdlJpM=;
        b=kOx+Gjao+k4i0s5PKItnlw8MzndTOB6rKH5QPw/ojy1tsLRcvj4EIT2gPr+Zr/fedQ
         xbf4J6AtghRnBZlkMpXpR4cu0UIScYUbDCmoB5yStfJ20HeMq3CYt8e2DcK5pbce4W+S
         g/Cm+mYKjLGSlyh27y1zgkZpKSIBmTQdHwe2iwboo2dGURuvUnc8pI+zYUv5XXQJcE0I
         XaoOe7d3CEqcdHaoM9F5bQCpXqVzgIefBlXPjwGUGXihbMUN0U89dKqT/xBBF40rQWW9
         1AF7XWHb0WQy/usn/ZeL1aGoc3SmkX3K6Wk+4N1tv9fuIuLmUKJCa1RrKWxf6gYZoTSR
         EeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dxCuwXQ7HI/yi9PTfXuL8SVkY7BbJHojvjFZGjdlJpM=;
        b=sdqFaqBOhV5qzjQykM9e+UWQzg6TGM0qtsA5+8SdxTrfHg7Jp4h/wlitaZBxFh20xD
         FHmXok0MZSTtunSYXjwpMO7qIPDpZoX45eRgOg2estpNARcqBhIcFMgZDUNxy4XiEJ4o
         RuaFrkW53lO/snhGFoUjiODNhA7R1S64W5XH2m9KuFhKV2sm56eGTKiM316dSJKRllal
         5TKbSZn3w9C+h23eBHfJ8LBAQIJoSv7aDBJ54E+rEuSzRo/FdM6YHv9tDhSnUaHNB/hL
         NnkZuFlXMw9IQPZ4lVUcD1Jw36DDxgmBEwXFENrD+LQnT6sAejUqFeogG+JAuCTAOIMZ
         U/0A==
X-Gm-Message-State: APjAAAVeotu9YRpPr6XJ+ljKTGkUCn8fLSTxade+cPCCUpHp56iGJlMs
        z2onA+edGBsOwDpKNbrCK4KczX22
X-Google-Smtp-Source: APXvYqyc2N0IgKuDy2PGuM0W6knd4ky7EMUuJjh8k844CFcmOQOZqhPCF1IYKkCd6uU6WtS8wnlp2A==
X-Received: by 2002:a1c:41c1:: with SMTP id o184mr4929725wma.81.1571919505183;
        Thu, 24 Oct 2019 05:18:25 -0700 (PDT)
Received: from szeder.dev (x4dbd3359.dyn.telefonica.de. [77.189.51.89])
        by smtp.gmail.com with ESMTPSA id d2sm2803761wmd.2.2019.10.24.05.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 05:18:24 -0700 (PDT)
Date:   Thu, 24 Oct 2019 14:18:22 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] t5510-fetch.sh: demonstrate
 fetch.writeCommitGraph bug
Message-ID: <20191024121822.GL4348@szeder.dev>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
 <pull.415.v2.git.1571835695.gitgitgadget@gmail.com>
 <6ac0a05746df8ac3b1dd788f525b2620bc4d9a08.1571835695.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ac0a05746df8ac3b1dd788f525b2620bc4d9a08.1571835695.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 01:01:34PM +0000, Derrick Stolee via GitGitGadget wrote:
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
> +		git commit -m "add submodule"
> +	) &&
> +	git clone "super" writeError &&
> +	(
> +		cd writeError &&
> +		test_path_is_missing .git/objects/info/commit-graphs/commit-graph-chain &&
> +		git -c fetch.writeCommitGraph=true fetch origin &&
> +		test_path_is_file .git/objects/info/commit-graphs/commit-graph-chain

With the fix applied this test fails when run with
GIT_TEST_COMMIT_GRAPH=1:

  + cd writeError
  + test_path_is_missing .git/objects/info/commit-graphs/commit-graph-chain
  + test -e .git/objects/info/commit-graphs/commit-graph-chain
  + git -c fetch.writeCommitGraph=true fetch origin
  + test_path_is_file .git/objects/info/commit-graphs/commit-graph-chain
  + test -f .git/objects/info/commit-graphs/commit-graph-chain
  + echo File .git/objects/info/commit-graphs/commit-graph-chain doesn't exist.
  File .git/objects/info/commit-graphs/commit-graph-chain doesn't exist.
  + false
  error: last command exited with $?=1

I think GIT_TEST_COMMIT_GRAPH should be unset for both
fetch.writeCommitGraph tests.

> +	)
> +'
> +
>  # configured prune tests
>  
>  set_config_tristate () {
> -- 
> gitgitgadget
> 
