Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB8A920A28
	for <e@80x24.org>; Wed, 20 Sep 2017 14:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbdITO6P (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 10:58:15 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:46762 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbdITO6O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 10:58:14 -0400
Received: by mail-qt0-f179.google.com with SMTP id s18so3059816qta.3
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FSrUEm/GUnZkjuETDCsUWPRZ5u8o8erZecPAkJYgJqY=;
        b=SG7anuh2aUNbE7sOQ5eQbVmFu3kA45aXOBNscJQj9VMTBRlI9Pb03kaXcgZYBl5SfO
         HmPg5V7HcVjUfg6xXMNTryHwdthioDZkr59PDKUoyecKi4IrY9Yg2dlfg4sOzZlkXqgi
         wDjGDgTsOVJ2TWCYG3ZAfYRAGAp5yRjMkB1KMG8cQtE7AiwMGxYOjEXlni3LdwYLOfbl
         4S/D7u1h0JHNVt1lfrGDsUcKjGBOzcVMuJ5Cj4DexgYPMYsEXG+v9vdaSgLCr9GdbAeT
         0MMf12KbhV9j/958kgOBdCQtXSv6DJzRAzOcHBRO2teAqUWjfrKMU97Cupn2vTlZIyBk
         XOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FSrUEm/GUnZkjuETDCsUWPRZ5u8o8erZecPAkJYgJqY=;
        b=Bl9/6AXSnD0Lu5LH3doi377llAmNNtQO8yaqI2z+VUZzBTslL9KMA4gEMFkFQ9/jzQ
         tPkazROQ7jcm90RnwxiYuEE8WX2v1q/+hhajLGM1lH8ujkDVpZrx5G6NJ/Ysl4yIOeqJ
         nE+eGbO5p7OnnxRz+FHMlmM9S9x1Ofgk8cMdXUjoYnmz1hcGT74OjyuargqUG4fjU/U6
         f03HPEGvd2AWintCEJNghbN1YQGbZWKLazFlMA4ih7BETuzS4xjxL/wUTlDCdI7jYoO0
         ioCey5H/z4EL7C8vm6BZ2+w2/WOa3aQuQQJ9YYHUewWWYyV9Q2IHLWOumaTOCTPToI2d
         ki2A==
X-Gm-Message-State: AHPjjUggszLJvsAX1MUq4daLqqYEwEagAEUYORHBIYsX67XZ1xJkIFVY
        bjYaRK0Mb9Vqh4URd3jalqc=
X-Google-Smtp-Source: AOwi7QApRaDIWTDl1jc4T1uvZSHu5si4QSCf4+GgyvjS0yQDJD4ZtBMxSPYtf/yVplOOsFr8oS1nIA==
X-Received: by 10.200.53.67 with SMTP id z3mr8175651qtb.145.1505919493432;
        Wed, 20 Sep 2017 07:58:13 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id q51sm855791qtk.18.2017.09.20.07.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 07:58:12 -0700 (PDT)
Subject: Re: [PATCH v7 03/12] update-index: add a new --force-write-index
 option
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-4-benpeart@microsoft.com>
 <xmqq7ewtor9u.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <682237f1-4747-5712-e95b-285379eb1b69@gmail.com>
Date:   Wed, 20 Sep 2017 10:58:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq7ewtor9u.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/20/2017 1:47 AM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> +		OPT_SET_INT(0, "force-write-index", &force_write,
>> +			N_("write out the index even if is not flagged as changed"), 1),
> 
> Hmph.  The only time this makes difference is when the code forgets
> to mark active_cache_changed even when it actually made a change to
> the index, no?  I do understand the wish to be able to observe what
> _would_ be written if such a bug did not exist in order to debug the
> other aspects of the change in this series, but at the same time I
> fear that we may end up sweeping the problem under the rug by
> running the tests with this option.
> 

This is to enable a performance optimization I discovered while perf 
testing the patch series.  It enables us to do a lazy index write for 
fsmonitor detected changes but still always generate correct results.

Lets see how my ascii art skills do at describing this:

1) Index marked dirty on every fsmonitor change:
A---x---B---y---C

2) Index *not* marked dirty on fsmonitor changes:
A---x---B---x,y---C

Assume the index is written and up-to-date at point A.

In scenario #1 above, the index is marked fsmonitor dirty every time the 
fsmonitor detects a file that has been modified.  At point B, the 
fsmonitor integration script returns that file 'x' has been modified 
since A, the index is marked dirty and then written to disk with a 
last_update time of B.  At point C, the script returns 'y' as the 
changes since point B, the index is marked dirty and written to disk again.

In scenario #2, the index is *not* marked fsmonitor dirty when changed 
are detected.  At point B, the script returns 'x' but the index is not 
flagged dirty nor written to disk.  At point C, the script will return 
'x' and 'y' (since both have been changed since time 'A') and again the 
index is not marked dirty nor written to disk.

Correct results are generated in both scenarios but in scenario 2, there 
were 2 fewer index writes.  In short, the changed files were accumulated 
as the cost of processing 2 files at point C (vs 1) has no measurable 
difference in perf but the savings of two unnecessary index writes is 
significant (especially when the index gets large).

There is no real concern about accumulating too many changes as 1) the 
processing cost for additional modified files is fairly trivial and 2) 
the index ends up getting written out pretty frequently anyway as files 
are added/removed/staged/etc which updates the fsmonitor_last_update time.

The challenge came when it was time to test that the changes to the 
index were correct.  Since they are lazily written by default, I needed 
a way to force the write so that I could verify the index on disk was 
correct.  Hence, this patch.


>>   		OPT_END()
>>   	};
>>   
>> @@ -1147,7 +1150,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>>   		die("BUG: bad untracked_cache value: %d", untracked_cache);
>>   	}
>>   
>> -	if (active_cache_changed) {
>> +	if (active_cache_changed || force_write) {
>>   		if (newfd < 0) {
>>   			if (refresh_args.flags & REFRESH_QUIET)
>>   				exit(128);
