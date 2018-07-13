Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48DA51F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 00:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbeGMBCq (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 21:02:46 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42999 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387827AbeGMBCp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 21:02:45 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so17287958qto.9
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 17:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=utpK3xDMJsirZ672FkNlrFxXdOcdPHYfec8RS0jk8ZA=;
        b=QwA0dlfBlmhhShifZJ5f5t5UlOVtEgHkPKNdraVai9sEOcrOYDVElGVTO+tjbH45PX
         mQMI7lr1GBa2RYdG1UOR3S/Sj8xptA8ckC6UvF9LiyGfmUk08sOozNKrxx/ryU9KBfJT
         ut2YUEECr7ZzuE/TvYimZSXx7jQ64aPKVsZsQImIVVBMvqdO8d3SNldgd3E3vh3oCAOn
         YoHdClguWWQcVBd3HORidCMsykl+t4kGY9bxbGDGvjBRABVny2K0Hja+hg75XM71nRAT
         O7Xm+XnK5mfFcycUwdqzgdJAQ0U9WbjtbpLcA1JPYhKY78IOBuHgkjIJK3gEN7f9PzCy
         CYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=utpK3xDMJsirZ672FkNlrFxXdOcdPHYfec8RS0jk8ZA=;
        b=X2JDRTY2jklqmhLkBMOrRXSH0dSKTjnU5QQeY4XHvaEy3t43CDODcbvQIqA6hlMsnp
         qlXh+qUS1bauq/iQMmjuuSFr+Q7fqv4p52muxRmbK/MDgQJhDF7dRQ5nkYs81Pa7HxXn
         Tn8fKslKXoBSrfWBwzGgbCzhoTryAPnZcvTV5iQOfPx3ggJZ8WcNLWJ8SRQRMd24ZK0p
         JkTxZX7adXQZG/Yq3XVJs+Aq4O3/BxmGQK8AFguk+DKJP5V9OxMoQZVPfBX1ub/fiRBc
         CzUNmvBlCBafxgAG47XICoCQji1l/ybZzwozQKU4YjaMYn7GVNg0yI/y/j3ICGP5H/Lf
         YGRQ==
X-Gm-Message-State: AOUpUlGD0Z0vILYP04PE3hc8uBumSsxEzRF3AhAl7Kx//dxevLalkId1
        VPCal6rg9TbGxiy/oUttpxk=
X-Google-Smtp-Source: AAOMgpclO6tfMAT5DpHzeodJxcALKlps4uRoKBHyl5iSjcTb0ClaoLMVGPhA5UQ+RxVC9P2htYBazw==
X-Received: by 2002:a0c:f04e:: with SMTP id b14-v6mr4934824qvl.20.1531443039836;
        Thu, 12 Jul 2018 17:50:39 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id y142-v6sm1600800qka.5.2018.07.12.17.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 17:50:38 -0700 (PDT)
Subject: Re: [PATCH v4 16/23] config: create core.multiPackIndex setting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, sbeller@google.com,
        pclouds@gmail.com, avarab@gmail.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
 <20180712193940.21065-17-dstolee@microsoft.com>
 <xmqqin5kupu3.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <61de4c01-daeb-2fad-491e-aa06facc3db8@gmail.com>
Date:   Thu, 12 Jul 2018 20:50:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqin5kupu3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/2018 5:05 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> The core.multiPackIndex config setting controls the multi-pack-
>> index (MIDX) feature. If false, the setting will disable all reads
>> from the multi-pack-index file.
>>
>> Read this config setting in the new prepare_multi_pack_index_one()
>> which is called during prepare_packed_git(). This check is run once
>> per repository.
>>
>> Add comparison commands in t5319-multi-pack-index.sh to check
>> typical Git behavior remains the same as the config setting is turned
>> on and off. This currently includes 'git rev-list' and 'git log'
>> commands to trigger several object database reads. Currently, these
>> would only catch an error in the prepare_multi_pack_index_one(), but
>> with later commits will catch errors in object lookups, abbreviations,
>> and approximate object counts.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>>
>> midx: prepare midxed_git struct
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> What is going on around here?
Sorry. I squashed the commits, and intended to drop this second commit 
message.
>
>> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>> index 4a4fa26f7a..601e28a2f0 100755
>> --- a/t/t5319-multi-pack-index.sh
>> +++ b/t/t5319-multi-pack-index.sh
>> @@ -3,6 +3,8 @@
>>   test_description='multi-pack-indexes'
>>   . ./test-lib.sh
>>   
>> +objdir=.git/objects
>> +
>>   midx_read_expect () {
>>   	NUM_PACKS=$1
>>   	NUM_OBJECTS=$2
>> @@ -76,18 +78,35 @@ test_expect_success 'create objects' '
>>   '
>>   
>>   test_expect_success 'write midx with one v1 pack' '
>> -	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
>> -	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
>> -	git multi-pack-index --object-dir=. write &&
>> -	midx_read_expect 1 18 4 .
>> +	pack=$(git pack-objects --index-version=1 $objdir/pack/test <obj-list) &&
>> +	test_when_finished rm $objdir/pack/test-$pack.pack \
>> +		$objdir/pack/test-$pack.idx $objdir/pack/multi-pack-index &&
>> +	git multi-pack-index --object-dir=$objdir write &&
>> +	midx_read_expect 1 18 4 $objdir
> Hmph, so we used to run tests as if $cwd were GIT_OBJECT_DIRECTORY
> but now we are running them from the top-level of the working tree,
> just like all the other tests?  Interesting.
This is the first time we _need_ them in the .git/object directory.
>>   '
>>   
>> +midx_git_two_modes() {
>> +	git -c core.multiPackIndex=false $1 >expect &&
>> +	git -c core.multiPackIndex=true $1 >actual &&
>> +	test_cmp expect actual
>> +}
>> +
>> +compare_results_with_midx() {
> Style: "compare_results_with_midx () {", just like mdx_read_expect
> near the top of the file, but unlike midx_git_two_modes we see
> nearby.  Please keep "git grep 'funcname () {'" a usable way to
> locate where a shell function is defined without forcing people to
> type an asterisk.

Sorry that I missed these two.

Thanks,

-Stolee

