Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D8B01F461
	for <e@80x24.org>; Tue,  2 Jul 2019 15:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfGBPyO (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 11:54:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50317 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfGBPyO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 11:54:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id n9so1378365wmi.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cUfeQBGbLIKoDJLDEE0Zfo78SH1eDATQhEocb+0fi/k=;
        b=m6agON+AoUSPFerLkWvmtfPg7B1vAiyXLRRVnT1NmAWYJKLDV82ZfX+/JKqspSaAXP
         qN7JVoZyOCFVucraH2WmHw0yoyW3VAf1NuBm8zGx9Ynu4FqIBMPt+AcfnwVMnz92hGQx
         mq9ZFMSLa3PiJIaoNYAozVKHI+lP4mcuFMTvs7nSSNzsPp662/1PZ3POA4/71iEVMQ0g
         TYJXhY3lpcblvEqGHf/R388/yU1fAX8olupuHbrAByjmDUChJb/24laq9TzHYiP+GIlv
         WN576n45Qgj3+9mwoNDhq7W0bX2x/kVmxZ02v2h0MfgX0p2ipY/PlW+uReaVirOnyB8G
         LYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cUfeQBGbLIKoDJLDEE0Zfo78SH1eDATQhEocb+0fi/k=;
        b=IQK2z9B6OaVzQ+WTlM//y+tLVm03xWkeNgJe52wh7BzRDUhzWKfl29sUBa25P/XRAo
         gjjOv09i0puRvGjLad9ezlY1BRedSc/+le7qEABockAHT2HmfMIwcJloeY3sPN0RF3kM
         4eUxNO1Mhf/CoqiBUwSCEX0YpRTj+0nxQFOjOhF0+AdnHkiy+cTcys901j0KY4cHeJri
         yG5D6WCiwXHPcqfD7IEs+jxhgRWtdBX743US6Lzu45hpaqLcrkvFSHh60Utm42G3u/sr
         HK6oezb/gMTKj2gIQP6ZKVSPFQiEow2Rrs3BIu99o3W7YtTtGokAlhVeykmW0HoY6zj8
         IfmA==
X-Gm-Message-State: APjAAAUlkJ9DB+0VdYUDq1RiwaattjkIa/4qKYzIIwySJ0HCSYmLUcDd
        KyOnpYPAwJJyPFIzLDoueXc=
X-Google-Smtp-Source: APXvYqzCR8dTRhhqFxE5CevYFEPpuAGp7OVWLBOCFLK3vVwxLGeUHEevtDlnr4n1dQ/mJBdqoUXAuw==
X-Received: by 2002:a1c:6641:: with SMTP id a62mr3747707wmc.175.1562082852508;
        Tue, 02 Jul 2019 08:54:12 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id r5sm27722421wrg.10.2019.07.02.08.54.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 08:54:10 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] t3420: remove progress lines before comparing output
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.276.git.gitgitgadget@gmail.com>
 <52501623f6b47447ce5da283ec11e378413899b7.1561986710.git.gitgitgadget@gmail.com>
 <xmqqimsl5v1u.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2a0a968e-6929-71eb-77cf-ec3ee28fd734@gmail.com>
Date:   Tue, 2 Jul 2019 16:54:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqimsl5v1u.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/07/2019 22:01, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> progress output before comparing it to the expected output. We do this
>> by removing everything before the final "\r" on each line as we don't
>> care about the progress indicator, but we do care about what is printed
>> immediately after it.
> 
> As long as sed implementation used here does not do anything funny
> to CR, I think the approach to strip everything before the last CR
> on the line is sensible.  As I am not familiar with how Windows port
> of sed wants to treat a CR byte in the pattern, I am not sure about
> the precondition of the above statement, though.

I wondered about that too, but it passes the CI tests under windows.

> I also have to wonder if we can/want to do this without an extra
> printf process every time we sanitize the output, though I do not
> think I care too deeply about it.

I could add 're="$(printf ...)"' to the setup at the top of the file if 
you want

Best Wishes

Phillip

>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   t/t3420-rebase-autostash.sh | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
>> index 9186e90127..0454018584 100755
>> --- a/t/t3420-rebase-autostash.sh
>> +++ b/t/t3420-rebase-autostash.sh
>> @@ -48,8 +48,8 @@ create_expected_success_interactive () {
>>   	q_to_cr >expected <<-EOF
>>   	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
>>   	HEAD is now at $(git rev-parse --short feature-branch) third commit
>> -	Rebasing (1/2)QRebasing (2/2)QApplied autostash.
>> -	Q                                                                                QSuccessfully rebased and updated refs/heads/rebased-feature-branch.
>> +	Applied autostash.
>> +	Successfully rebased and updated refs/heads/rebased-feature-branch.
>>   	EOF
>>   }
>>   
>> @@ -67,13 +67,13 @@ create_expected_failure_am () {
>>   }
>>   
>>   create_expected_failure_interactive () {
>> -	q_to_cr >expected <<-EOF
>> +	cat >expected <<-EOF
>>   	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
>>   	HEAD is now at $(git rev-parse --short feature-branch) third commit
>> -	Rebasing (1/2)QRebasing (2/2)QApplying autostash resulted in conflicts.
>> +	Applying autostash resulted in conflicts.
>>   	Your changes are safe in the stash.
>>   	You can run "git stash pop" or "git stash drop" at any time.
>> -	Q                                                                                QSuccessfully rebased and updated refs/heads/rebased-feature-branch.
>> +	Successfully rebased and updated refs/heads/rebased-feature-branch.
>>   	EOF
>>   }
>>   
>> @@ -109,7 +109,8 @@ testrebase () {
>>   			suffix=interactive
>>   		fi &&
>>   		create_expected_success_$suffix &&
>> -		test_i18ncmp expected actual
>> +		sed "$(printf "s/.*\\r//")" <actual >actual2 &&
>> +		test_i18ncmp expected actual2
>>   	'
>>   
>>   	test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
>> @@ -209,7 +210,8 @@ testrebase () {
>>   			suffix=interactive
>>   		fi &&
>>   		create_expected_failure_$suffix &&
>> -		test_i18ncmp expected actual
>> +		sed "$(printf "s/.*\\r//")" <actual >actual2 &&
>> +		test_i18ncmp expected actual2
>>   	'
>>   }
