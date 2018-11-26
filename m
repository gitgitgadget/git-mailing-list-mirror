Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC301F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 21:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeK0Inb (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 03:43:31 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40347 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeK0Inb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 03:43:31 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so19468969qtf.7
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 13:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+XbfV2Ff7siyp8HFCs86w6/UFQNZHnYxq8CwM41nxsw=;
        b=gGTUA4gLzfgTOjkJ7Y1vhZ7zdHmwV78qxS9AkPni5rEznI1HaB3bL2DckoOul6LxOW
         u1r7u6Lk9Qam5U/tgMMeXhWqi2E8QR6isoXnQV54f2FGLLCcmjN9WH4Od9QIhZ/MhYKs
         /AYZVPpaeMBeEa4J007/P6MGwdzG8GmwJhQLdnadY2X6NI2eZJqX6Zkle3lF4vGldHuy
         zy+rkd2MGMchrXAUvxzhyPIayo0H12EKW9MFlrGZMM0t4AbTp6qKKrHZiOkENd3CFCgv
         qr1QGaAc8PWE2WbsJnslq+Hrr3Hq/BnYsqo4sThowGD/3c1ZxfT7nEZBEu8UMReHrPy1
         hZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+XbfV2Ff7siyp8HFCs86w6/UFQNZHnYxq8CwM41nxsw=;
        b=oqFf9GTMWQISI3P6FwOfPW/6tsa/HLQ2od9goJ+yyijGRTm2FhxzrpNdz6XO/Akkj/
         a/4UYu1Aq1KbwHd6yZxWtHeQUa6QniR+uPq8xetPYqMqD5vznlcDbJoXKFEsy6K8HdMn
         cJhS18Kx+GGoDaq3SmKbnWezlsRw8jePLL6rjwXq8bBc1ztzjfcfZSetWfOlKbH4BfGj
         LOoE6cjiLhi14OoJhTOJ5wBc33MnaJHdSgbkoiVazatQ2DM5eXfXuQEe1795SF4yRqXE
         5f1K7hZiUttF0EDdD5WvggqDFXI9kYrGeSnxEIsDCGbHCsKn3p5HYlrZWOrif/xUEJIV
         Rb6g==
X-Gm-Message-State: AA+aEWYG0/TC+k4yfemk2IIjwXugYo8WdZw9WZHslx+SWZcCPCVASPrx
        LkmUQxAydgE1t4HwbdyGgyc=
X-Google-Smtp-Source: AFSGD/Wm4q59vcX9wHH7JpSwsyQZap5issC4TRKtgJG+dgvFAtw+KUKcb1qie/X5IFGrx3LG1RHo8g==
X-Received: by 2002:a0c:cc8c:: with SMTP id f12mr28597470qvl.102.1543268879785;
        Mon, 26 Nov 2018 13:47:59 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id f14sm1008749qka.18.2018.11.26.13.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 13:47:58 -0800 (PST)
Subject: Re: [PATCH 2/5] ieot: default to not writing IEOT section
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com> <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com> <20181120061221.GC144753@google.com>
 <05e7df80-0dfc-c1ec-df14-c196357524f4@gmail.com>
 <CAGZ79kbaPKaCFGGXnbNchvk=1Q4Q5Hgt2hXOhcGo6pVwquhaEg@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <7e06ec44-a3a0-fa38-75a7-7b875ae0679e@gmail.com>
Date:   Mon, 26 Nov 2018 16:47:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbaPKaCFGGXnbNchvk=1Q4Q5Hgt2hXOhcGo6pVwquhaEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/26/2018 2:59 PM, Stefan Beller wrote:
>>> +static int record_ieot(void)
>>> +{
>>> +     int val;
>>> +
>>
>> Initialize stack val to zero to ensure proper default.
> 
> I don't think that is needed here, as we only use `val` when
> we first write to it via git_config_get_bool.
> 
> Did you spot this via code review and thought of
> defensive programming or is there a tool that
> has a false positive here?
> 

Code review and defensive programming.  I had to review the code in 
git_config_get_bool() to see if it always initialized the val even if it 
didn't find the requested config variable (esp since we don't pass in a 
default value for this function like we do others).

>>
>>> +     if (!git_config_get_bool("index.recordoffsettable", &val))
>>> +             return val;
>>> +     return 0;
>>> +}
