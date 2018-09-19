Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53771F453
	for <e@80x24.org>; Wed, 19 Sep 2018 19:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbeITBKr (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 21:10:47 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:53872 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbeITBKr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 21:10:47 -0400
Received: by mail-wm1-f53.google.com with SMTP id b19-v6so7477409wme.3
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=O2DPo0Z/y9NR0pmozxfUeSAk9qro4/lLjbgeqzumo+0=;
        b=DbknYlg8IkMeAHPfJhp4eo0J1wyUPjYpuTxf3t3vGDYF032Snx0J0DaFdaaHKNTcep
         0HgQAliLhjmcF8mXTGiYsEqaxQoYccr5xHRZ3ng1EGqrl0FgbON/5/Pk8tCp8hvVFibO
         9jbse5kzf7LZuMzFfjhQFHokBF6/a9D7xQX4v6KyVai9eWheQfdYU5on4FMxjNuM1BAp
         mK61YZIzcw9Ssyzufmb2Jt4rXLUv9eCVIfaMsB8JeaziLR5VbKy+t3m1jeDaC5yLcYd9
         DAg243mIBqcn02zG3jsBcEz0XXDxJZs/jHXikE17QuqMk7gj8JKlEXkLDeCiDWKxs1gK
         B/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=O2DPo0Z/y9NR0pmozxfUeSAk9qro4/lLjbgeqzumo+0=;
        b=jZhuozSOjEuwPMWsIkMcRYFBiyhd4awIuYyAStAa3r8+0VrfnuZrnxiehEUe7R4Wqe
         VyKWXRO1EsnnR4PONridaspC4VQYxNRFhOv4WFiD6cAtWvSi/qnq4+1Hht3Y094PZexV
         RyoA9wMWRBZNmtgZtkvf/FCyHLJJqgANfR8VziLvhN3bYTcZhBH0lcGEjOoV43e2suTT
         jQFbcGEbGIIsc4yY612ozAXRqXxMfg7USqayR4fOxQzBqX9NPml4h6i3WrmgDrYhmq8/
         F7PBBNFFXqItUPUeBSsTAPw4eoseea2EcQ4EfLWgv/HPJIiL6G4vfRo7+glJ3ftDYzQt
         5A3w==
X-Gm-Message-State: APzg51CcnnVhTRHiPaWHaOfXAxJPG8AUNxgSXTFJYt1c55P7Rl6JqH/a
        trMzKFZAiuIpZpsHxM1w2SEGVoh9
X-Google-Smtp-Source: ANB0VdaaDB3WDEM4JQ7Hgbvv/IN9xukenBDetQmFA5L6weNobRukUFY9K5aWeEXx09knsHDjbzcIPA==
X-Received: by 2002:a1c:398b:: with SMTP id g133-v6mr23529464wma.5.1537385482577;
        Wed, 19 Sep 2018 12:31:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n5-v6sm3666994wmh.1.2018.09.19.12.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 12:31:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/6] test-reach: add run_three_modes method
References: <pull.25.git.gitgitgadget@gmail.com>
        <pull.25.v2.git.gitgitgadget@gmail.com>
        <404c9186080ecee6c1cc39a6dcd17deaaa7a620a.1537243720.git.gitgitgadget@gmail.com>
        <20180918180200.GD27036@localhost>
Date:   Wed, 19 Sep 2018 12:31:21 -0700
In-Reply-To: <20180918180200.GD27036@localhost> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Tue, 18 Sep 2018 20:02:00 +0200")
Message-ID: <xmqqbm8t473q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> While inspecting this code, I realized that the final test for
>> 'commit_contains --tag' is silently dropping the '--tag' argument.
>> It should be quoted to include both.
>
> Nit: while quoting the function's arguments does fix the issue, it
> leaves the tests prone to the same issue in the future.  Wouldn't it
> be better to use $@ inside the function to refer to all its arguments?

IOW, do it more like this?

>> -test_three_modes () {
>> +run_three_modes () {
>>  	test_when_finished rm -rf .git/objects/info/commit-graph &&
>> -	test-tool reach $1 <input >actual &&
>> +	$1 <input >actual &&

	"$@" <input >actual

i.e. treat each parameter as separate things without further getting
split at $IFS and ...

>> +test_three_modes () {
>> +	run_three_modes "test-tool reach $1"

	run_three_modes test-tool reach "$1"

... make sure there three things are sent as separate, by quoting
"$1" inside dq.

I think that makes sense.

