Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C52561FAA8
	for <e@80x24.org>; Tue, 16 May 2017 14:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbdEPO2R (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 10:28:17 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33865 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753775AbdEPO2O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 10:28:14 -0400
Received: by mail-qk0-f194.google.com with SMTP id u75so23043424qka.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DD7sQ7zzDkwJc55HFmguX7R10Y7rf2qzW5NN+cqFtzs=;
        b=Ggf4QHg3O1IMHi2MmEB+O3MpTJWWFbm5AJLHm93FDHJ6FVJdgm/hQeGipEUtYN8swA
         Klz3moa6kJTD7FMqbFRT2PTcdcG3uzYC1JXSzCqcSabbV6AYFvhXhqYvLwL+SB04/L8s
         hZC9spjNfkpFKhdJfvTVGfb5g6ETCJWRGtC6WVgKdWeLwFUPF3Trwpyywu9F3tcH+qhi
         GDpP+WLAqgib7NdZU6Yi+XWHn5A9bLIV4GxWgiEhxXoTj/JCtnUC7yrBdsGg+U+anUz2
         l0bcpmKDRU/XyYbu3sQeZhtuoDtZZkldNZ1waSao5wKOonfG2cEWi548e2ESz21IcJIK
         oGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DD7sQ7zzDkwJc55HFmguX7R10Y7rf2qzW5NN+cqFtzs=;
        b=IaTy0CGrx6ZwsA1lP0z91rP8vwI4/p/ilA6OFNwR9LRZ+Ia2if88NFMjnoITsARQkt
         qFNZUZbWKpmDED8K8zsRDLuMxcFkEAckSk1AgyK4lKpuI+BPu5kb1Ds5O0R3S1M6dEEP
         H7iyvY+9LxXzbzmYpuy8Xn/+D9u8qu5RDyCaznt0xoJ2toiztSen+jqx81tjY5nyKfKg
         lWsd6dGi5kvHN1OGfz9Xpk1GDiYgBfvV9Gz62bd8VdOAQv7S7sV51eimm5RntnuYd1Y9
         LJsnFe4mmJ76HDfzmJuhTknEBJZdg5FjJrGCPKAKKMqKhFM21XWTKJfqESU+HqSSVtwy
         HPpA==
X-Gm-Message-State: AODbwcDMLKBKk84vBN0JeS4VjVvj9FzLF6BERg65kOB/7ShjSXGLP1oT
        TAr35C/alzmEAw==
X-Received: by 10.55.131.198 with SMTP id f189mr9715991qkd.187.1494944893743;
        Tue, 16 May 2017 07:28:13 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 83sm11359956qkq.26.2017.05.16.07.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 07:28:13 -0700 (PDT)
Subject: Re: [PATCH v1 3/5] fsmonitor: add test cases for fsmonitor extension
To:     Junio C Hamano <gitster@pobox.com>
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-4-benpeart@microsoft.com>
 <xmqq60h12y94.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
From:   Ben Peart <peartben@gmail.com>
Message-ID: <db527b7e-350a-751a-89e8-5e3312bf3610@gmail.com>
Date:   Tue, 16 May 2017 10:28:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq60h12y94.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/16/2017 12:59 AM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
>
>> Add test cases that ensure status results are correct when using the new
>> fsmonitor extension.  Test untracked, modified, and new files by
>> ensuring the results are identical to when not using the extension.
>>
>> Add a test to ensure updates to the index properly mark corresponding
>> entries in the index extension as dirty so that the status is correct
>> after commands that modify the index but don't trigger changes in the
>> working directory.
>>
>> Add a test that verifies that if the fsmonitor extension doesn't tell
>> git about a change, it doesn't discover it on its own.  This ensures
>> git is honoring the extension and that we get the performance benefits
>> desired.
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> ---
>>  t/t7519-status-fsmonitor.sh | 134 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 134 insertions(+)
>>  create mode 100644 t/t7519-status-fsmonitor.sh
>
> Please make this executable.
>

Sorry, long time Windows developer so I forgot this extra step.  Fixed 
for next roll.

>> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
>> new file mode 100644
>> index 0000000000..2d63efc27b
>> --- /dev/null
>> +++ b/t/t7519-status-fsmonitor.sh
>> @@ -0,0 +1,134 @@
>> ...
>> +# Ensure commands that call refresh_index() to move the index back in time
>> +# properly invalidate the fsmonitor cache
>> +...
>> +	git status >output &&
>> +	git -c core.fsmonitor=false status >expect &&
>> +	test_i18ncmp expect output
>> +'
>
> Hmm. I wonder if we can somehow detect the case where we got the
> correct and expected result only because fsmonitor was not in
> effect, even though the test requested it to be used?  Not limited
> to this particular test piece, but applies to all of them in this
> file.
>

I have tested this manually by editing the test hook proc to output 
invalid results and ensured that the test failed as a result but adding 
that to the test script was kind of ugly (all tests end up getting 
duplicated - one ensuring success, one ensuring failure).

On further reflection, a better idea is to have the test hook proc 
output a marker file that can be tested for existence.  If it exists, 
the hook was used to update the results, if it doesn't exist, then the 
hook proc wasn't used.  A much cleaner solution that doesn't require 
duplicating the tests.
