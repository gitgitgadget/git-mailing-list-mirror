Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B20E1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 19:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbeITBSF (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 21:18:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54434 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732220AbeITBSF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 21:18:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id c14-v6so7487133wmb.4
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1FNn+pt6wD0Q8IZ/Ydky8ReWbmK93Nm+p4k0IyYUgcA=;
        b=eVdNIXC+6Da1EBp7vWFhXD4OxKqmg8r66GmN5sTI+oEkFxj4ocLrF92pbE0fN2x4wO
         qacdOXdT0XfcxKVrAQO62mwPXh8R7P3Mg5+XL+YqfYVgz3jBHUDQ3NhGwJMugPhk4Nml
         480ZQxc1LDnMZtXOaj9pD6gJ3P8ls1cLfucq8V+fQq7MeXcS2Ua+VRtTT3AoJ7eCchZz
         dhjIaPktI2vffgM0ZGzo9qMhPV1NzMBDGJm08FXyMcIr0Iw8k+pHnnFEcd9B40VkSayW
         W+5WDt8jP8NTL6xpg7VRxeAqyof8POV1j0XntN1iiuC+48FD5f676Q6Yb9NaZ8nBIFkt
         31Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1FNn+pt6wD0Q8IZ/Ydky8ReWbmK93Nm+p4k0IyYUgcA=;
        b=l8KXiN8KoMS8pFkCSZOjmZ50gVAEnN7Zg0IacxMspy4XKw6qrC13hAT7DF41vWWLPz
         SdrAOD8i50lYwHe3IizLrk5DS/Ra+Kh7+qpdvzW71zPhKBvtK5+qG6a7CGkMrLCDnWZi
         E3AUxykqCB6Cn92jXGEPpZaiw7DzGYGPvB4ZlK4l79MdATjzk9kQMjH/OEebMXpO9Or6
         CADnEwYOFI4kF1SSkxCMpsAegenJXuecYF+6/fKNwacq1TnOodMiTEnW+eHg4RfLSDCU
         pxH6qcUlvQFZgp5og/OWSRzvC8Ijo6dL2slee76VIPavhikpvtxN13SXZDhJdmfu6cdg
         /MCQ==
X-Gm-Message-State: APzg51A/ROzMJssdIo05oN49T3DNnJ5XX23YssByWZbwReFmhzRIWhg4
        B/c8FElLcMjS7Xa6pPqXPTIX+gwW
X-Google-Smtp-Source: ANB0VdbkDiag4RucoZJuemHwfGlQk389nK2zJq7f2A0Wp3AlhNYpSfJvDxHQX+1jCF+nknGaD7CZmw==
X-Received: by 2002:a1c:b157:: with SMTP id a84-v6mr20075981wmf.18.1537385918268;
        Wed, 19 Sep 2018 12:38:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z101-v6sm44792412wrb.55.2018.09.19.12.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 12:38:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/6] test-reach: add run_three_modes method
References: <pull.25.git.gitgitgadget@gmail.com>
        <pull.25.v2.git.gitgitgadget@gmail.com>
        <404c9186080ecee6c1cc39a6dcd17deaaa7a620a.1537243720.git.gitgitgadget@gmail.com>
        <20180918180200.GD27036@localhost>
        <xmqqbm8t473q.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 19 Sep 2018 12:38:37 -0700
In-Reply-To: <xmqqbm8t473q.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 19 Sep 2018 12:31:21 -0700")
Message-ID: <xmqq7ejh46rm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>>> While inspecting this code, I realized that the final test for
>>> 'commit_contains --tag' is silently dropping the '--tag' argument.
>>> It should be quoted to include both.
>>
>> Nit: while quoting the function's arguments does fix the issue, it
>> leaves the tests prone to the same issue in the future.  Wouldn't it
>> be better to use $@ inside the function to refer to all its arguments?
>
> IOW, do it more like this?
>
>>> -test_three_modes () {
>>> +run_three_modes () {
>>>  	test_when_finished rm -rf .git/objects/info/commit-graph &&
>>> -	test-tool reach $1 <input >actual &&
>>> +	$1 <input >actual &&
>
> 	"$@" <input >actual
>
> i.e. treat each parameter as separate things without further getting
> split at $IFS and ...
>
>>> +test_three_modes () {
>>> +	run_three_modes "test-tool reach $1"
>
> 	run_three_modes test-tool reach "$1"
>
> ... make sure there three things are sent as separate, by quoting
> "$1" inside dq.
>
> I think that makes sense.

I also noticed that 2/6 made "commti_contains --tag" enclosed in dq
pair for one test, but the next test after it has the identical one.

Here is what I queued in the meantime.

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 1b18e12a4e..1377849bf8 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -55,18 +55,18 @@ test_expect_success 'setup' '
 
 run_three_modes () {
 	test_when_finished rm -rf .git/objects/info/commit-graph &&
-	$1 <input >actual &&
+	"$@" <input >actual &&
 	test_cmp expect actual &&
 	cp commit-graph-full .git/objects/info/commit-graph &&
-	$1 <input >actual &&
+	"$@" <input >actual &&
 	test_cmp expect actual &&
 	cp commit-graph-half .git/objects/info/commit-graph &&
-	$1 <input >actual &&
+	"$@" <input >actual &&
 	test_cmp expect actual
 }
 
 test_three_modes () {
-	run_three_modes "test-tool reach $1"
+	run_three_modes test-tool reach "$1"
 }
 
 test_expect_success 'ref_newer:miss' '
@@ -223,7 +223,7 @@ test_expect_success 'commit_contains:hit' '
 	EOF
 	echo "commit_contains(_,A,X,_):1" >expect &&
 	test_three_modes commit_contains &&
-	test_three_modes "commit_contains --tag"
+	test_three_modes commit_contains --tag
 '
 
 test_expect_success 'commit_contains:miss' '
-- 
2.19.0-216-g2d3b1c576c

