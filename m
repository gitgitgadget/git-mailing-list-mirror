Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DEF91F404
	for <e@80x24.org>; Wed, 18 Apr 2018 14:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeDROqb (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 10:46:31 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45212 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbeDROqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 10:46:30 -0400
Received: by mail-qt0-f195.google.com with SMTP id b13-v6so2032647qtp.12
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 07:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2qLKkRrsWllVgh4UbD+63F028tGazFLDoVnc/tx5SDY=;
        b=XC04iP0LEdcHLOvc3cOLU4GielGpghAGbxMhwqNk28qvcTyjSM/pi3Nxyr1cOnPKoU
         xG7Z4YFIS4Wj4Sn5+pXgdOlqsGTAmANUIxOS3/y3iu+zf8kyeBAsR7xKxPBM4ROiak04
         W2DWVQFOWlhNTRa07cg92VR6loCFYIqdqYeE9Th3spF6M/0wlf8VdNBROE3PTeCCto/4
         g3COwNVp2wLCv0SbxYA0JDhryoccO/hB7TGWP32YNefB8ULkhEiKcYIyAJRWbX2JUzBJ
         X74BZXIs4ynIkfn4PUreCPBBiWPlp3f2sSg3JxzZRQ8OjSTDlmtuzxzoNCrdhCxbWy6a
         X+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2qLKkRrsWllVgh4UbD+63F028tGazFLDoVnc/tx5SDY=;
        b=UaoHHyx/m7UILb9KonLJWmyQTvo/+TLiy4R2ymhUbE5T4KeTYUT6EpUYMaY6WPRXrJ
         mAgVnC4kK59fHkpxuHCgt0Oi4weJVqqr59XoA8vFYliMQNmdnQyP3q8oxlGiaucs8olL
         1V6z2/U9e6G9Id5ff2Vn4hHRmNjTH+TmrcEGvw7UlWo7Gb4xnxU+yWVzlu75Ovj2s2M1
         IAuQmFCAieLZp/bApGSTTfuD0FGCd/bRZMu7+PnRiS5ks7/o/oYvvnZqA3JlSnGGY3Op
         wYo286Z7KUe7IvEx+o54wdk/ajGMMT3wvmhXhOUsl5M77gtd/r7BW6msfjUBSkGtiTaL
         mv5Q==
X-Gm-Message-State: ALQs6tDiyZbLC23y5gexuc2aHLyQef2zatMwl7qNAtWrTT/CrfZ+u9Id
        ybwcDSIvRlDF23nRxCMoCNo=
X-Google-Smtp-Source: AB8JxZpsYhkIOuJv3o0nUJ6FzCCXyhAWs09SjUwfIb991Qw1hBNDn/RSrDCj+VmW5BVqYytg+dhRdA==
X-Received: by 2002:aed:2904:: with SMTP id s4-v6mr2561416qtd.52.1524062789293;
        Wed, 18 Apr 2018 07:46:29 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id h21-v6sm1002347qtm.4.2018.04.18.07.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Apr 2018 07:46:28 -0700 (PDT)
Subject: Re: [PATCH v3 3/9] commit: use generations in paint_down_to_common()
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
References: <20180409164131.37312-1-dstolee@microsoft.com>
 <20180417170001.138464-1-dstolee@microsoft.com>
 <20180417170001.138464-4-dstolee@microsoft.com> <864lk8io21.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d4095ab6-fca2-8ed5-0185-1f961c5d1168@gmail.com>
Date:   Wed, 18 Apr 2018 10:46:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <864lk8io21.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2018 10:31 AM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> Define compare_commits_by_gen_then_commit_date(), which uses generation
>> numbers as a primary comparison and commit date to break ties (or as a
>> comparison when both commits do not have computed generation numbers).
>>
>> Since the commit-graph file is closed under reachability, we know that
>> all commits in the file have generation at most GENERATION_NUMBER_MAX
>> which is less than GENERATION_NUMBER_INFINITY.
>>
>> This change does not affect the number of commits that are walked during
>> the execution of paint_down_to_common(), only the order that those
>> commits are inspected. In the case that commit dates violate topological
>> order (i.e. a parent is "newer" than a child), the previous code could
>> walk a commit twice: if a commit is reached with the PARENT1 bit, but
>> later is re-visited with the PARENT2 bit, then that PARENT2 bit must be
>> propagated to its parents. Using generation numbers avoids this extra
>> effort, even if it is somewhat rare.
> Does it mean that it gives no measureable performance improvements for
> typical test cases?

Not in this commit. When we add the `min_generation` parameter in a 
later commit, we do get a significant performance boost (when we can 
supply a non-zero value to `min_generation`).

This step of using generation numbers for the priority is important for 
that commit, but on its own has limited value outside of the clock-skew 
case mentioned above.

>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   commit.c | 20 +++++++++++++++++++-
>>   commit.h |  1 +
>>   2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/commit.c b/commit.c
>> index 711f674c18..a44899c733 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -640,6 +640,24 @@ static int compare_commits_by_author_date(const void *a_, const void *b_,
>>   	return 0;
>>   }
>>   
>> +int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused)
>> +{
>> +	const struct commit *a = a_, *b = b_;
>> +
>> +	/* newer commits first */
>> +	if (a->generation < b->generation)
>> +		return 1;
>> +	else if (a->generation > b->generation)
>> +		return -1;
>> +
>> +	/* use date as a heuristic when generataions are equal */
> Very minor typo in above comment:
>
> s/generataions/generations/

Good catch!

>
>> +	if (a->date < b->date)
>> +		return 1;
>> +	else if (a->date > b->date)
>> +		return -1;
>> +	return 0;
>> +}
>> +
>>   int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
>>   {
>>   	const struct commit *a = a_, *b = b_;
>> @@ -789,7 +807,7 @@ static int queue_has_nonstale(struct prio_queue *queue)
>>   /* all input commits in one and twos[] must have been parsed! */
>>   static struct commit_list *paint_down_to_common(struct commit *one, int n, struct commit **twos)
>>   {
>> -	struct prio_queue queue = { compare_commits_by_commit_date };
>> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>>   	struct commit_list *result = NULL;
>>   	int i;
>>   
>> diff --git a/commit.h b/commit.h
>> index aac3b8c56f..64436ff44e 100644
>> --- a/commit.h
>> +++ b/commit.h
>> @@ -341,6 +341,7 @@ extern int remove_signature(struct strbuf *buf);
>>   extern int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
>>   
>>   int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
>> +int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
>>   
>>   LAST_ARG_MUST_BE_NULL
>>   extern int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);

