Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2141F403
	for <e@80x24.org>; Sat,  2 Jun 2018 22:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeFBWa0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 18:30:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56161 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbeFBWaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 18:30:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so2420502wmh.5
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DR6mj+8XBIKbq317yLaktiaOCuoJzoCQ33/WXWSPrwM=;
        b=FxM4H5mWJlZIUpyGwrEZVB9wvMnAF7gDDBZNBR65ymuXCZ2e+hx3IhrL16fT6BSg7p
         +A71ru+Xq8LVM0rf1v8UPigVEItHovDTZkT7dNOIA9jZ2iSK2AF23QvH8Z0wo/YjuSSq
         fIFl0zXtD31VQslZL+QGqM/3cNnMWxp8LHuF8XludxSWTxUoZzX64eCjOYiKtv0A57gn
         Yxlldl3Q21ez25wP0mBNo7LTWrl6/e/JLvSo8Tb1Y7hAyOOsRNEuRbMDej9o4ExW0up/
         F4WQek1q9mh+01yvDlTF6Bie7nhy9ZJElLDkFupTeerBlb8e2eHbayuL6HOr5vmZ10zH
         MLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=DR6mj+8XBIKbq317yLaktiaOCuoJzoCQ33/WXWSPrwM=;
        b=ghJjfQVpKIj24tUy3rbE5uP7P8rZW9EAxoWG1adUUJS1lq3hk3IN8DRZCgXO5O7Idx
         PF7YlAkULVxwIWrl763iVIjL17yLXl9iaUwowq6w4X8mltywcX80yX93ib4pFDHRqFHw
         arzKhfIXi2Pw3L2zwVqTQZ/hsPAhC0zCuLt6Q/KKUXjDJUrOMvD0lt8HB+H1aeOverlj
         mHRmjAEWvoFEoMoWzkHGL95i7+CqtkeqI6IJ9oS9xGjqdZ8a6mA9JDYQbJGNXHeksow9
         yQ6lX/28EOq18UiRqGqd4OxdaJ22kAWLKQyHOfM4AYJWeB/+MhEcyMY+AnIecEyq/uaS
         DIDg==
X-Gm-Message-State: APt69E0IfeDLmXmbCyaZJVafAWbMesy5CWPnP43YJCxTLeCIyQzNlo45
        sCucTpA76UiCBTyWu/Q8NsM=
X-Google-Smtp-Source: ADUXVKI8uF4iQo+e+/6zE1IdW8zcJTbUUr17SAK+PJdw+t2J7E4CuwacOYgUrDKW9zAnKUsif9IKZg==
X-Received: by 2002:a1c:e055:: with SMTP id x82-v6mr370759wmg.155.1527978624608;
        Sat, 02 Jun 2018 15:30:24 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri112.neoplus.adsl.tpnet.pl. [83.8.102.112])
        by smtp.gmail.com with ESMTPSA id g75-v6sm7803811wmd.15.2018.06.02.15.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 15:30:22 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 07/20] commit-graph: verify catches corrupt signature
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-8-dstolee@microsoft.com>
        <86muwjyixo.fsf@gmail.com>
        <6d9d346c-b178-26f2-fdeb-bb0ffb070774@gmail.com>
Date:   Sun, 03 Jun 2018 00:30:19 +0200
In-Reply-To: <6d9d346c-b178-26f2-fdeb-bb0ffb070774@gmail.com> (Derrick
        Stolee's message of "Tue, 29 May 2018 08:43:48 -0400")
Message-ID: <866030rfd0.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 5/28/2018 10:05 AM, Jakub Narebski wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:

[...]
>>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>>> index 6ca451dfd2..bd64481c7a 100755
>>> --- a/t/t5318-commit-graph.sh
>>> +++ b/t/t5318-commit-graph.sh
>>> @@ -235,9 +235,52 @@ test_expect_success 'perform fast-forward merge in full repo' '
>>>   	test_cmp expect output
>>>   '
>>>   +# the verify tests below expect the commit-graph to contain
>>> +# exactly the commits reachable from the commits/8 branch.
>>> +# If the file changes the set of commits in the list, then the
>>> +# offsets into the binary file will result in different edits
>>> +# and the tests will likely break.
>>> +
>>>   test_expect_success 'git commit-graph verify' '
>>>   	cd "$TRASH_DIRECTORY/full" &&
>>> +	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
>>>   	git commit-graph verify >output
>>>   '
>> I don't quite understand what the change is meant to do.
>
> This gives us a constant commit-graph file to work with in the later tests.
>
> To get the "independent test" structure you want for the tests that
> are coming, we need to do one of the following:
>
> 1. Write a new commit-graph file for every test (slows things down).

Or check if correct graph-file exists, and if it doesn't only then write
a new commit-graph file (like I have proposed elsewhere in this thread).

Barring this, I think it would be better if the preparation step was
separated into a 'setup <something>' step, so that one can easier select
which tests to run, at least by hand.

> 2. Do all corruption/verify checks in a single test (reduces the
> information from a failed test, as it only reports the first failure).
>
> I don't like either of these options, so I went with this "prepare" step.

These are not the only possible options.

>> Also, as I said earlier, I'd prefer if tests were as indpendent of each
>> other as possible, to make running individual tests (e.g. only
>> previously falling tests) easier.
>>
>> I especially do not like mixing running actual test with setting up the
>> repository for future tests, as here.

