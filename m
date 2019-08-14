Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63EB91F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 18:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfHNSit (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 14:38:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32840 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbfHNSit (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 14:38:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id u16so80728wrr.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pG1K7MUH+uGnanSGIt1ZPd3MqpQ0WqLg/Mpv4X6SrO4=;
        b=B7c3cRaSm5w+pKIF6g0sICuvAhSUI6Uij6/YV2GZAYDiLWIEEerr1qKscgDzEhbNeK
         ICmuTcZgjSch1NuZw2PTn+URh0LO1qk15pgUIDukjDmI3Rr5NFYmIctH38Dka1acCrxB
         HMxQd6D90ZO0F1MDqiDV7k3PsGrId7Y903vsG2ICx9epD5fd0DMQMsNZN73HomVZQw21
         T0Ma77geuuwJi6FRDnn7/QsVhou2b3hvZvjIwzfwfr1G93+o/QpeQiUt4uXf8tOH1jmh
         ktkL9TCaEgVv9t3AZOQVWIahWG8J2fw8TLp21WOPQTHj561qd6Y6+tS3kTfmWjVDFszX
         kLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pG1K7MUH+uGnanSGIt1ZPd3MqpQ0WqLg/Mpv4X6SrO4=;
        b=fopYpN93ggDAIHssMupCo8db2XBHncwUwdXCKWV9bbh2zNu6J1GG6krNoTDRF5iPrN
         dHPFkhNKz8zN1uWwPOtPRONROJAZav0aV5UyJ1MV1BRHZCL6sEuI6+A2bcID9mJwinlC
         OESk8gk+ADGbdmPe53nkr/ycLqpbjD0kEqKqd6f6iqUONAbRShr4wk0qAleMpPx3CLNE
         VYbpXXNHmWE8TC5oQECIhoTeYrROUCozojbzIu03GNN+jWi8DV0T9C0U9LHsz5ddypKO
         xmDnL4JWCq2oDZfM/9V/bENGON7/VX30+1knpLL9lvjhpbPPP74mCFDUln7SKc2khCUo
         ZiXQ==
X-Gm-Message-State: APjAAAV1RRCdIcHva5hUPWPoztJn9X+HsGKYdZq3eNW+YR2B0L0x2v5Z
        D5YsHcNxGePcHlMmMZZEufM=
X-Google-Smtp-Source: APXvYqyrFnZvL6ocHuBZgjjUFcmJP8BM0ZinHFSZMiUzBmj6Jz19CklmRQQE0XtBatcs+GbZSITSBQ==
X-Received: by 2002:adf:fc81:: with SMTP id g1mr1237178wrr.78.1565807927299;
        Wed, 14 Aug 2019 11:38:47 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id 24sm328086wmf.10.2019.08.14.11.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2019 11:38:46 -0700 (PDT)
Subject: Re: [GSoC][PATCH v2 3/6] rebase -i: support
 --committer-date-is-author-date
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-4-rohit.ashiwal265@gmail.com>
 <7274e753-f75c-ad9a-9c2c-7ba8abc32971@gmail.com>
 <xmqqsgq5805u.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0a0a6fd3-933e-c0a4-03c2-8c1c69e5ffca@gmail.com>
Date:   Wed, 14 Aug 2019 19:38:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqsgq5805u.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/08/2019 18:06, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>  [...]
>>> +
>>> +		strbuf_addf(&date, "@%s",ident.date_begin);
>>
>> I think we should use %s.* and ident.date_end to be sure we getting
>> what we want. Your version is OK if the author is formatted correctly
>> but I'm uneasy about relying on that when we can get the verified end
>> from ident.
> 
> If the author line is not formatted correctly, split_ident_line()
> would notice and return NULL in these fields, I think (in other
> words, my take on the call to split_ident_line() above is not
> necessarily done in order to "split", but primarily to validate that
> the line is formatted correctly---and find the beginning of the
> timestamp field).

I just had a read through split_ident_line() and it looks to me like it 
will ignore any junk after the timezone. So long as it sees '+' or '-' 
followed by at least one digit it will use that for the time zone and 
return success regardless of what follows it so I think we want to pay 
attention to the end data it returns for the date and timezone.

> But your "pay attention to date_end" raises an interesting point.
> 
> The string that follows ident.date_begin would be a large integer
> (i.e. number of seconds since epoch), a SP, a positive or negative
> sign (i.e. east or west of GMT), 4 digits (i.e. timezone offset), so
> if you want to leave something like "@1544328981" in the buffer, you
> need to stop at .date_end to omit the timezone information.
> 
> On the other hand, if you do want the timezone information as well
> (which I think is the case for this codepath), you should not stop
> at there and have something like "@1544328981 +0900", the code as
> written would give better result.

Good point, I had forgotten that split_ident_line() returned separate 
fields for the date and timezone. I agree that we want the timezone here 
too. I  I think it would be a good idea to beef up the tests to use a 
non default timezone to check that we are actually setting it correctly.

Best Wishes

Phillip

