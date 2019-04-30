Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 016791F453
	for <e@80x24.org>; Tue, 30 Apr 2019 09:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfD3JB4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 05:01:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34443 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfD3JB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 05:01:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16so17648683wrp.1
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7wOj98r4NOUfV4S/KjJnx2cBNLtBbjs3eR4bgHO2JFU=;
        b=WRlP21QcfzrPP6/jolzS4ZlbTHldJiRCiaYzsQ7q4mk+Y63NCQlEC2o9uVi9rERO1l
         K+Ifi+sNhxmj/p5gUNH5r8AbgMSTU9lpiHj1A2i2sqJiukCdjZi4N8uJTilmDE7vbig5
         GMcw89tOI4XsiHUp2EQmP+rzYcM1VG/3l8OCkYCNew9dFHSViGb1oB1g4OIl6xvs2yms
         L9uDBJprm7bUor7053C5rSdBRrrAduo3e4WT62NUg2pwo1peaSipuxuBHvbpAlkf3z9Z
         6DaoJAqSLPRaTjU+SeVtYDkLifYBvz2gkCdelFL9sAJrRB5h41Po8OoRiOWTGmuD9ekg
         G8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7wOj98r4NOUfV4S/KjJnx2cBNLtBbjs3eR4bgHO2JFU=;
        b=IHqvF/tAJ5nxOUfydRM3R8WNXWtledaJeBBeXDbYHUv7AAg7aR4/sF6HOWIcHLRF+P
         9ZcxIfhyvqfzbzeJbNQyZocP8d3LGyDXG4CzhSa1Cm0pcZPzXzEUa1ciFC7jjTFk9khP
         qKlss2kuZCxYWHefUWKvTCMnlbSTvMi9Aq0K7RJBZ+N7315K60IqhqzG82Jt1oYBlKaH
         9/JJWhG9STQ780uAAffTtYYG88PN7wVchYYuyViCHYr1s4atjEqfj81ZCkS8IA6ylqoC
         MfbYhUo1Zo3idgNXeTzde55WqzEMiF9axPT4A+GJmpQDvcTY1lLeCdOqfQ8FPat8xIyH
         ikvQ==
X-Gm-Message-State: APjAAAW4z9yvfpwIyhTWYWdVMqlwg1yoMgQTwBNDpFghBFNRlgiOtrrU
        +CwEDFqoNhyLtygGdTcc8VM=
X-Google-Smtp-Source: APXvYqzmU91ENvPpzVECrO3X1tV4wLkG2qie8IZFZP5dgnJjKd/gmSXJs/hZOQDuBwZJdfglh8gHSw==
X-Received: by 2002:a5d:4392:: with SMTP id i18mr13421080wrq.239.1556614914602;
        Tue, 30 Apr 2019 02:01:54 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id c9sm9652578wrv.62.2019.04.30.02.01.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 02:01:54 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -r: always reword merge -c
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20190426103332.9036-1-phillip.wood123@gmail.com>
 <nycvar.QRO.7.76.6.1904291208210.45@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a226ffff-212b-d81c-11fd-bb496b84a78d@gmail.com>
Date:   Tue, 30 Apr 2019 10:01:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1904291208210.45@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 29/04/2019 17:14, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Fri, 26 Apr 2019, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If a merge can be fast-forwarded then make sure that we still edit the
>> commit message if the user specifies -c. The implementation follows the
>> same pattern that is used for ordinary rewords that are fast-forwarded.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
> 
> OMG I was bitten twice by this very bug in the past week, and planned on
> looking into it next week. Thanks for beating me to it.
> 
> Two comments:
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index 0db410d590..ff8565e7a8 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -3248,6 +3248,10 @@ static int do_merge(struct repository *r,
>>   		rollback_lock_file(&lock);
>>   		ret = fast_forward_to(r, &commit->object.oid,
>>   				      &head_commit->object.oid, 0, opts);
>> +		if (flags & TODO_EDIT_MERGE_MSG) {
>> +			run_commit_flags |= AMEND_MSG;
>> +			goto fast_forward_edit;
>> +		}
>>   		goto leave_merge;
>>   	}
>>
>> @@ -3351,6 +3355,7 @@ static int do_merge(struct repository *r,
>>   		 * value (a negative one would indicate that the `merge`
>>   		 * command needs to be rescheduled).
>>   		 */
>> +	fast_forward_edit:
> 
> It is *slightly* awkward that this is an `else` arm of an `if (ret)`, but
> I do not necessarily think that it would be better to move the label
> before the `if` than what you did; Your version comes out more readable,
> still.

I did wonder about adding braces but I'm not sure that makes it any 
clearer. I agree having the label before the `if (ret)` would be less 
clear as the reader has to then think what ret will be in that case to 
work out what will happen.

>>   		ret = !!run_git_commit(r, git_path_merge_msg(r), opts,
>>   				       run_commit_flags);
>>
>> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
>> index 4c69255ee6..3d484a3c72 100755
>> --- a/t/t3430-rebase-merges.sh
>> +++ b/t/t3430-rebase-merges.sh
>> @@ -164,6 +164,16 @@ test_expect_success 'failed `merge <branch>` does not crash' '
>>   	grep "^Merge branch ${SQ}G${SQ}$" .git/rebase-merge/message
>>   '
>>
>> +test_expect_success 'fast-forward merge -c still rewords' '
>> +	git checkout -b fast-forward-merge-c H &&
>> +	set_fake_editor &&
> 
> set_fake_editor affects global state AFAIR (setting and exporting
> `EDITOR`), therefore this would need to be run in a subshell, i.e.
> enclosed in parentheses.

The other test files are not very consistent about that. I'll re-roll. 
Note that I do not export any FAKE_* variables, so later tests should 
not be affected even if the fake editor runs.

Best Wishes

Phillip
>> +	FAKE_COMMIT_MESSAGE=edited GIT_SEQUENCE_EDITOR="echo merge -c H G >" \
>> +		git rebase -ir @^ &&
>> +	echo edited >expected &&
>> +	git log --pretty=format:%B -1 >actual &&
>> +	test_cmp expected actual
>> +'
>> +
> 
> The rest looks good, thank you!
> Dscho
> 
>>   test_expect_success 'with a branch tip that was cherry-picked already' '
>>   	git checkout -b already-upstream master &&
>>   	base="$(git rev-parse --verify HEAD)" &&
>> --
>> 2.21.0
>>
>>
