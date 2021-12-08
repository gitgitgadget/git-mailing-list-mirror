Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59924C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhLHVdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbhLHVdm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:33:42 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AA0C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 13:30:09 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 132so3241121qkj.11
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 13:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/m+JiIWSPKHyTTDtHcs/KdrMIcU8Lb+PzaQUtHYUoZE=;
        b=nTNJEgCnakYVfGZVjn7P9YsNYuc0YdYyDX5G1wnVt0ChmNX5LYHi/ElK05OVsyD2OV
         FU4NhKIUXscC3w7wNr7VUAKrYpzriwf4vuKy1MdLu97qRXj/LEF/GFQWEcDHgjKy2X9b
         bCIpQwo1ufkZ+OK18ydyVVetdEeO2cD41XGRVKW4f4oKyqp4ebFD+t3FPkLzrcn1m57o
         +5Ku1qFaKXUtB1r2QNg6r/zeBn9wEsTrjHNZy0G7S3awNrrlBfpRE/hxDqH+gQCRSbzn
         DKz71ymRYJKWFhCWcBW5Y0oqSvnVsIxREHJzIZuqB6z+kWbhG9VuJmQsy0YjFa/4+T/e
         LHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/m+JiIWSPKHyTTDtHcs/KdrMIcU8Lb+PzaQUtHYUoZE=;
        b=z1A9iwpMq2NlCCNGelvt+R5F1hLyHXfXp6FSeIJS5WYXFOpeZNnZgtecm+EvWXpDUw
         qVJ9CTrcj3UrF9ASRB1EfrerAzRhpfBfpAyBdGEzlKxdkm+1AA/GJDZhzH1cRH5hYP1y
         1lOpwwdXoQcqwD7MtkoykTe5z2JUIDl9c6rEkv5Ds/d9krZ3UhKOZZfO9STGIgcybx1j
         xIRp2ln/QFhmRrIsuh8LkRA4jrqlOwHlKwIfTUcekek2Wk6KYd2z1di578KySG0YFqFw
         /8Wu17Toav5mAAgwViWlfi+INoU+Vn2XG5yQUro+NgEpP95KZrvAvUunmFRKr92HUIKz
         cFyg==
X-Gm-Message-State: AOAM5306mBqm/x2IFdNeFS1XnYlYaACCN4lNjWjI6lwczhM9OgnAodYx
        7urbdwRKODVzICCDqNGdMfs=
X-Google-Smtp-Source: ABdhPJw0gq9s0czT6CbcQqWp5iML4Y6QncE+PJbI9Ef7qqsdZHozLZ24nMsGsi+/bgl30Ss2xyoR4Q==
X-Received: by 2002:a05:620a:24ca:: with SMTP id m10mr9202235qkn.635.1638999008977;
        Wed, 08 Dec 2021 13:30:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5056:be20:f10c:bfd5? ([2600:1700:e72:80a0:5056:be20:f10c:bfd5])
        by smtp.gmail.com with ESMTPSA id c22sm2311658qtd.76.2021.12.08.13.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 13:30:08 -0800 (PST)
Message-ID: <4dbca719-a1df-27e9-6e07-dea3f2e2638b@gmail.com>
Date:   Wed, 8 Dec 2021 16:30:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC/PATCH] Makefile: add test-all target
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
 <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
 <xmqq4k7nmksi.fsf@gitster.g> <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
 <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq8rwu278d.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/8/2021 3:04 PM, Junio C Hamano wrote:
> We ship contrib/ stuff within our primary source tree but except for
> the completion scripts that are tested from our primary test suite,
> their test suites are not run in the CI.
> 
> Teach the main Makefile a "test-extra" target, which goes into each
> package in contrib/ whose Makefile has its own "test" target and
> runs "make test" there.  Add a "test-all" target to make it easy to
> drive both the primary tests and these contrib tests from CI and use
> it.

> So, how about doing it this way?  This is based on 'master' and does
> not cover contrib/scalar, but if we want to go this route, it should
> be trivial to do it on top of a merge of ab/ci-updates and js/scalar
> into 'master'.  Good idea?  Terrible idea?  Not good enough?

> +# Additional tests from places in contrib/ that are prepared to take
> +# "make -C $there test", but expects that the primary build is done
> +# already.
> +test-extra: all
> +	$(MAKE) -C contrib/diff-highlight test
> +	$(MAKE) -C contrib/mw-to-git test
> +	$(MAKE) -C contrib/subtree test

I like how this is obviously extendible to include contrib/scalar
in a later change, then remove it when Scalar moves.

> +test-all:: test test-extra

And this test-all implies that test runs before test-extra, so
libgit.a is compiled appropriately.

I think this approach looks good to me.

> diff --git i/ci/run-build-and-tests.sh w/ci/run-build-and-tests.sh
> index cc62616d80..9da0f26665 100755
> --- i/ci/run-build-and-tests.sh
> +++ w/ci/run-build-and-tests.sh
> @@ -19,7 +19,7 @@ make
>  case "$jobname" in
>  linux-gcc)
>  	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> -	make test
> +	make test-all

Since we are now building and testing things that we have not been
testing recently, it is worth checking that we don't have any work
to do to make this pass. I assume that you've run 'make test-all'
on your own machine. It will be good to see what the full action
reports (probably all good).

Thanks,
-Stolee
