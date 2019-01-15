Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98CAE1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 12:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfAOMpz (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 07:45:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36423 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbfAOMpz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 07:45:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so3060697wmc.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 04:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HnbyotAMtmWD6b43R3lTmTtYSebJnJW2HXRrlcaML74=;
        b=Gr/QItKOlQmOtidWkRsqIjyLPxApJC3zDUH3BG7nZke07MKMTa6Z4wrvSjQiX4gP/B
         bHS2YfZhkjzfJXAs8EZvMgobe0Iu92dN3yii4vPpTmd20OItvcXqbedItK2ww1MbUG3J
         8t40P3JXs8MU7f3yPKAHHJk7D1OT4YPKJ2ZMFfMwSoIF0RLfFPZwlCPLeL8TVzbLVROk
         8fxKsKFOa6rQFlY4shfutqFM2H4S8ZLgZYORwKomdbaDcu7q342eWzbTvR1pOVXqo3K3
         XX98FxpoH7WVoUoj9RrcuE2JLmpZFculU+12ogLJojAaiHpxidfalG0IApwG5NKI4U3o
         fuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HnbyotAMtmWD6b43R3lTmTtYSebJnJW2HXRrlcaML74=;
        b=JH4FeM51zSPfoNBULL0/vAljNKulMUU6+KH6YeU9sRsNYGPfYx2uyOOVKwC7voYwRn
         daUwus4NGg6VMRpssZKJnND3QKX+6HU7xSxhd8rz0PNEQDkFosgzTitdwTzWojiazFRm
         zoYccA8BtwQFSr2RCA0vkd0jXRFDuSJBxlcR+GMMukteDHNFC34SL1Z4NsfmGbwkExQ/
         ib8q4BGCy2v5kJ6L0n+ka1COYR4JKYAAMlG3ZyWjiWbjzH0UDeVTalAGU9e2xdQFxKd0
         i9/+aklLbraV2q2Sy0fS0L+mULrfz/2h38OOghl8ctvQQY4Vu9SS4LZP253l/Q99XTtt
         sP/g==
X-Gm-Message-State: AJcUuketNeKnb9MLplr/1XjYwF5+ui+uXSqOudRashp1+uLw8QkARiEm
        YaPdwYyPaWuE3XrUH5zrxwc=
X-Google-Smtp-Source: ALg8bN566M4cRID0X50xDZJQQp51dyIJ2xNMZFBthdYl4mbMJc55uXMI2Dh6EcOi0qvNNpKtc0tIeQ==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr3470398wmg.42.1547556353515;
        Tue, 15 Jan 2019 04:45:53 -0800 (PST)
Received: from [192.168.1.7] ([31.223.156.50])
        by smtp.gmail.com with ESMTPSA id p139sm61755670wmd.31.2019.01.15.04.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 04:45:52 -0800 (PST)
Subject: Re: [PATCH 6/7] Git.pm: introduce environment variable
 GIT_TEST_PRETEND_TTY
To:     phillip.wood@dunelm.org.uk,
        Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.103.git.gitgitgadget@gmail.com>
 <86d85face8ba543fb4a03adbc42dc930ee318f74.1545307756.git.gitgitgadget@gmail.com>
 <fd6bab55-871c-4f4d-84e9-98bfe5d54f23@talktalk.net>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <5413d570-d071-2361-1ff9-6854d0d4f584@gmail.com>
Date:   Tue, 15 Jan 2019 13:45:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fd6bab55-871c-4f4d-84e9-98bfe5d54f23@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

First of all, thank you for taking your time to review this patch series.

On 14-Jan-19 12:13 PM, Phillip Wood wrote:
> Hi Salvica/Johannes
>
> On 20/12/2018 12:09, Slavica Djukic via GitGitGadget wrote:
>> From: Slavica Djukic <slawica92@hotmail.com>
>>
>> To enable testing the colored output on Windows, enable TTY
>> by using environment variable GIT_TEST_PRETEND_TTY.
>>
>> This is the original idea by Johannes Schindelin.
> I normally use GIT_PAGER_IN_USE=1 to force colored output, is there some
> reason that does not work here?


I tried that approach, and it turns out GIT_PAGER_IN_USE=1 does force 
colored output.

As for the changes suggested in the other two e-mails -- I will apply 
them as well and send re-roll.


Thank you,

Slavica


>
> Best Wishes
>
> Phillip
>
>> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>> ---
>>   color.c     | 4 ++++
>>   perl/Git.pm | 2 +-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/color.c b/color.c
>> index ebb222ec33..4aa6cc3442 100644
>> --- a/color.c
>> +++ b/color.c
>> @@ -323,6 +323,10 @@ static int check_auto_color(int fd)
>>   {
>>   	static int color_stderr_is_tty = -1;
>>   	int *is_tty_p = fd == 1 ? &color_stdout_is_tty : &color_stderr_is_tty;
>> +	
>> +	if (git_env_bool("GIT_TEST_PRETEND_TTY", 0))
>> +		return 1;
>> +
>>   	if (*is_tty_p < 0)
>>   		*is_tty_p = isatty(fd);
>>   	if (*is_tty_p || (fd == 1 && pager_in_use() && pager_use_color)) {
>> diff --git a/perl/Git.pm b/perl/Git.pm
>> index d856930b2e..51a1ce0617 100644
>> --- a/perl/Git.pm
>> +++ b/perl/Git.pm
>> @@ -757,7 +757,7 @@ and returns boolean (true for "use color", false for "do not use color").
>>   
>>   sub get_colorbool {
>>   	my ($self, $var) = @_;
>> -	my $stdout_to_tty = (-t STDOUT) ? "true" : "false";
>> +	my $stdout_to_tty = $ENV{GIT_TEST_PRETEND_TTY} || (-t STDOUT) ? "true" : "false";
>>   	my $use_color = $self->command_oneline('config', '--get-colorbool',
>>   					       $var, $stdout_to_tty);
>>   	return ($use_color eq 'true');
>>
