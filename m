Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA853C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 23:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiB1X1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 18:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiB1X1m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 18:27:42 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9FCDE2E6
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 15:27:02 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id u16so12460548pfg.12
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 15:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G127K9UotDH2nDl033nOQHc3v58n2USF62dEsGtdc0A=;
        b=gjZv3MZIJMHKa0T7zg7Q5YTmMGROsxSmeEx8gdK4ocT86+uOaUkj49FnBubxgKo3DI
         TwHbQcIo7PCkpPSeIvy3S5vlqHqj5m16pcmybOs/2mJpn1ac2fWK+6hYV9CsTScQGG8m
         QeItvCaCc2zqAbpymWQhoRBSh1KFfBWtTIBVSUNLZrJ2LHYV9gtOQCoy/WzojqcY9zdS
         8SaHK3zMvtQVON5714flpLVgA6sPC7VVP/7dXRsyTLiJGzZuzhPW5nJCcf9CW/sVm4uT
         PdLnGzYxyiWIf73l5oT2JXZZCRX9ycewXsdb4R3/1XVWqud3kH6AuO1HI5YeDCkUJxIR
         t7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G127K9UotDH2nDl033nOQHc3v58n2USF62dEsGtdc0A=;
        b=ApxzthrN37qmlQoIGVGKyzYZIf0ixoOgpgLgkEUuuVRN4a22eFhQzS2m4zBlg2RqJM
         1Z0m3FW4pLREjUs2VOfqVXLDYDBo/f9HPIoLC2ef5azfm3a4AB+DCWgIukm1+yQpNrS0
         KSopDsVqP8pr3QvGPw5UTqGmUSiLrIsqxEF/nmEkeVlctazbuGuKP0JShTUMlA8ayQ/9
         ekgIoiuNNrqqzxWKRnpBSi7dFoKhT8MWYtMDX+1PDKB7gtuhUGtL+Ps5vVd+hnXISbGc
         C18OzX6fCetn7qkZoWtI31HTtl2s8nac9FbYaXKP5YXSq8k/DkXU8SzMrfMFtTogoDcg
         BzWw==
X-Gm-Message-State: AOAM532sPWxWBBB6thIln92tPKMtJGdYLctErQU0cpnpN1jQ92LD7a2G
        5k7IehpRJaWJzCkgYK846mbY
X-Google-Smtp-Source: ABdhPJxmpQwXoo2CYVgEoEV65Pd32dVcictPkBXUFJSU2hdCekY5dWjpDV8oYTMDojKXM2B4Z8vt8g==
X-Received: by 2002:a05:6a00:2301:b0:4e1:5842:48d7 with SMTP id h1-20020a056a00230100b004e1584248d7mr24268814pfh.14.1646090821873;
        Mon, 28 Feb 2022 15:27:01 -0800 (PST)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id t41-20020a056a0013a900b004e167af0c0dsm15401745pfg.89.2022.02.28.15.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 15:27:01 -0800 (PST)
Message-ID: <509e860c-5bda-b92f-96c5-39f9a54f1e9b@github.com>
Date:   Mon, 28 Feb 2022 15:27:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 3/7] read-tree: expand sparse checkout test coverage
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
 <ffe0b6aff2baee238f77ae57561a62ea5473321f.1645742073.git.gitgitgadget@gmail.com>
 <220301.861qzm37qt.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <220301.861qzm37qt.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Feb 24 2022, Victoria Dye via GitGitGadget wrote:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Add tests focused on how 'git read-tree' behaves in sparse checkouts. Extra
>> emphasis is placed on interactions with files outside the sparse cone, e.g.
>> merges with out-of-cone conflicts.
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  t/perf/p2000-sparse-operations.sh        |  1 +
>>  t/t1092-sparse-checkout-compatibility.sh | 85 ++++++++++++++++++++++++
>>  2 files changed, 86 insertions(+)
>>
>> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
>> index 2a7106b9495..382716cfca9 100755
>> --- a/t/perf/p2000-sparse-operations.sh
>> +++ b/t/perf/p2000-sparse-operations.sh
>> @@ -117,6 +117,7 @@ test_perf_on_all git diff
>>  test_perf_on_all git diff --cached
>>  test_perf_on_all git blame $SPARSE_CONE/a
>>  test_perf_on_all git blame $SPARSE_CONE/f3/a
>> +test_perf_on_all git read-tree -mu HEAD
>>  test_perf_on_all git checkout-index -f --all
>>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>>  
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index b1dcaa0e642..9d58da4e925 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -819,6 +819,91 @@ test_expect_success 'update-index --cacheinfo' '
>>  	test_cmp expect sparse-checkout-out
>>  '
>>  
>> +test_expect_success 'read-tree --merge with files outside sparse definition' '
>> +	init_repos &&
>> +
>> +	test_all_match git checkout -b test-branch update-folder1 &&
>> +	for MERGE_TREES in "base HEAD update-folder2" \
>> +			   "update-folder1 update-folder2" \
>> +			   "update-folder2"
>> +	do
>> +		# Clean up and remove on-disk files
>> +		test_all_match git reset --hard HEAD &&
>> +		test_sparse_match git sparse-checkout reapply &&
>> +
>> +		# Although the index matches, without --no-sparse-checkout, outside-of-
>> +		# definition files will not exist on disk for sparse checkouts
>> +		test_all_match git read-tree -mu $MERGE_TREES &&
>> +		test_all_match git status --porcelain=v2 &&
>> +		test_path_is_missing sparse-checkout/folder2 &&
>> +		test_path_is_missing sparse-index/folder2 &&
>> +
>> +		test_all_match git read-tree --reset -u HEAD &&
>> +		test_all_match git status --porcelain=v2 &&
>> +
>> +		test_all_match git read-tree -mu --no-sparse-checkout $MERGE_TREES &&
>> +		test_all_match git status --porcelain=v2 &&
>> +		test_cmp sparse-checkout/folder2/a sparse-index/folder2/a &&
>> +		test_cmp sparse-checkout/folder2/a full-checkout/folder2/a || return 1
>> +	done
>> +'
> 
> Nit: Isn't this nicer/easier by unrolling the for-loop to the top-level, i.e.:
> 
> for MERGE_TREES in "base HEAD update-folder2" [...]
> do
> 	test_expect_success "'read-tree -mu $MERGE_TREES' with files outside sparse definition" '
> 		init_repos &&
> 		test_when_finished "test_all_match git reset --hard HEAD" &&
>                 ...
> 	'
> done
> 
> It makes failures easier to reason about since you see which for-loop
> iteration you're in right away, and can e.g. pick one with --run.
> 

I like how this separates the test cases (while not adding any
redundant/copied code). I'll update in the next version, thanks!

> And we can do the cleanup in test_when_finished instead of at the start
> of every loop.

Because `init_repos` completely resets the test repos, this actually lets me
remove the extra cleanup steps completely.
