Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41DEE1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 15:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbeFHPLH (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 11:11:07 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35308 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbeFHPLG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 11:11:06 -0400
Received: by mail-qt0-f194.google.com with SMTP id s9-v6so13755700qtg.2
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 08:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xneOGN9W82bqs60A3+uUOqKGlhf8nWrz2Er1zx+Moyk=;
        b=VCHVA4oS1YxTN13D1PM2vgSkFjBPStlo0y9rAdxNJq4hWEfaIIcTZDlf23ROYGS2L5
         qT2T8FOyTk27FZ5qPkgydQd5p/eGXEmpRu9qfzQCRAz6njfUYMJ6NEiKNzug0P/BmLak
         FWGw+ceBoCNqQkoAbKVPrd2MrrMtfohHVMX4tkuwxV/VVBMy0LfAlwIooOlnNo8nptBt
         Btk33rBwHiI4y37f1qIs5XeTB2BP3oTOhnxDAnme28Y9vrCpUmiCEsuQCMeK90SMo0D/
         ibX2z3R24+rq6wfykMzUb8iBOgcNaZ9IKjCBCjVmnNlW8JU0znDOjA/+9n1gVpDN49u8
         NQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xneOGN9W82bqs60A3+uUOqKGlhf8nWrz2Er1zx+Moyk=;
        b=W54T/PZElodLZjkqJ1kHpt+SnyGqHrBpVYSpM4A/b7VDAS0wrj5zgFl2KU25UM4uWr
         FxxZCLrGti8QrD2QsGQZRl5LqED7AhqkvPOm5QwbuJA9jhpL+J02YpYUaBaHTKBVab9y
         vfTh6EvpmDpIUBNAX0e0GED9SQ54NnyjWTiEuYmT4oN4pby1cpFaB7Fxze2ItFuwuAdZ
         0sQ3WphvqsUPZZSddDS/wue/dO60sFXUXb7cWoRf9aOiDYGkPCmGLj7c3yKKTXTBWHwk
         pNfZAx8u6JlsAHy0ECJWWpi4zsNrTm6bBocexzOvx6+W37fS3DdMWjqU9186h0avAb4J
         qssg==
X-Gm-Message-State: APt69E0GS8muaUi7jjDD6DdaOh+5wd3SERE9joOf3pmRX0zU7+OU0ouN
        Vm0deIOjtvJC3t6lM+Z9Jjo=
X-Google-Smtp-Source: ADUXVKJsKsdvdrYuthNrH8ORfgOn5TgmKAUd7JexbrXkwam1Ce4jls+lSLTbUTPQXYTeFfbyVgtE8A==
X-Received: by 2002:ac8:241:: with SMTP id o1-v6mr6180947qtg.39.1528470665866;
        Fri, 08 Jun 2018 08:11:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:5dc2:24cc:4e85:52e? ([2001:4898:8010:0:46f8:24cc:4e85:52e])
        by smtp.gmail.com with ESMTPSA id d72-v6sm24269291qkj.17.2018.06.08.08.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 08:11:05 -0700 (PDT)
Subject: Re: [PATCH v6 00/21] Integrate commit-graph into 'fsck' and 'gc'
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <marten.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180606113611.87822-1-dstolee@microsoft.com>
 <20180608135548.216405-1-dstolee@microsoft.com>
 <CANQwDwdRUFnqYva+mvPh8fijcYNGNDRac857aHMhzHUOLeASpw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2d50791e-f957-077e-a5a8-b2a8882f90c5@gmail.com>
Date:   Fri, 8 Jun 2018 11:11:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CANQwDwdRUFnqYva+mvPh8fijcYNGNDRac857aHMhzHUOLeASpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2018 11:05 AM, Jakub Narębski wrote:
> On Fri, 8 Jun 2018 at 15:56, Derrick Stolee <dstolee@microsoft.com> wrote:
>
>> [..], the following
>> diff occurs from the previous patch:
> [...]
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index b24e8b6689..9a0661983c 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -33,8 +33,8 @@ test_expect_success 'create commits and repack' '
>>   '
>>
>>   graph_git_two_modes() {
>> -       git -c core.commitGraph=true $1 >output
>> -       git -c core.commitGraph=false $1 >expect
>> +       git -c core.graph=true $1 >output
>> +       git -c core.graph=false $1 >expect
>>          test_cmp output expect
>>   }
> It seems that you have accidentally removed the fix from previous version.
> It needs to be core.commitGraph, not core.graph.
>
>

I didn't rebase the fix that I sent as a separate patch [1] (we want 
that change applied to 'master' while this one targets topics in 'next' 
and 'pu'). So this specific diff is unfortunate noise.

Thanks!
-Stolee

[1] 
https://public-inbox.org/git/20180604123906.136417-1-dstolee@microsoft.com/
     [PATCH] t5318-commit-graph.sh: use core.commitGraph
