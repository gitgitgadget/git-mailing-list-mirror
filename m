Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FBC51F404
	for <e@80x24.org>; Fri, 26 Jan 2018 12:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeAZMP3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 07:15:29 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:45886 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeAZMP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 07:15:27 -0500
Received: by mail-qt0-f180.google.com with SMTP id x27so675130qtm.12
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 04:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=C2ZCzbGQJ1HP58kywBCp6PDV4PrGrLxBkQKKJDxDVLk=;
        b=dBhdHZjbYz0sr5y7S1quvHoZnhSEWKw8cUdg09ioY1kiUfLb7qpYo/2IBSTevxUJdn
         Fi9iN+2TGMDMtj5Nc1eP3I8NwSso7CuBs791t+d3GQExU/pc0f/i+/JfUUrDNhg71BE4
         43zEhF9mN7F+wSSzBmLdZPgHQ8yMcuvxZ1s8DtAc/5lBuUG8xvJHIoW/EcBe06PrCccR
         +Jzwau5N+bm4amTmt80WHQ1cRtV8YkPv4HBKeoL28JZZM6qEFRKZaiCZSiSc1QyJx6xA
         r/2BcK49bWnennwHqxyXDiHtFjsBDN4rvoOBevLd3AQsBrwyes4M3hDtHlCEU2SwM40t
         BsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=C2ZCzbGQJ1HP58kywBCp6PDV4PrGrLxBkQKKJDxDVLk=;
        b=a6ApNrBZE3Xptrkm37dOLHFsI3trhckGwEvpzRj+BGTVyF8YITWTPLwcjdVU8pfVzx
         Zw+YVlfbweI2C85hHmzwEil+A74sM3yEa0KLSwtd5dsDaKVOgOzGVN3nwTkhvxVYQmA5
         TM1JfWEoMVzYBVc9lIlaZW0S4bGjeWYozQ7QviaRnjswNCD894Y/YiyP4SY4BsOVFvWO
         fA9HetTHDoRTDTQ+Yci+FonSJNHsZm+vAHN1p0ccIc1PdPc3Z2Z2xcThZ4REyTre7I0Q
         dHvqvOpz+FMFvwvopJY1oYwTr5uP5D4pgik0PpI8JPvAtMqjGo3ql+l5JOe8xf30cMGi
         HSOQ==
X-Gm-Message-State: AKwxytdGE6urFrQs2BY4mxycMcDYBazVRQfeobYsWY5K+8TJMvDfSSOK
        r99kPlElfQ631P5J9z8Ybd0=
X-Google-Smtp-Source: AH8x226ZP3d82Bj/tAYjYb7ME7Q/5QNJU8nUCasHhQZ7xnAXJLOpGwW5UASjOWQ5K7uPKMmQrm5CzQ==
X-Received: by 10.55.217.20 with SMTP id u20mr19163357qki.52.1516968926814;
        Fri, 26 Jan 2018 04:15:26 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id d16sm3337524qkj.47.2018.01.26.04.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 04:15:26 -0800 (PST)
Subject: Re: [PATCH 00/14] Serialized Commit Graph
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
References: <20180125140231.65604-1-dstolee@microsoft.com>
 <871siex7pc.fsf@evledraar.gmail.com>
 <fe9d20da-eb70-d725-0530-cab1c029a0c8@gmail.com>
 <87wp05wnaw.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b06bed0e-59e6-c678-792b-4fe57c849037@gmail.com>
Date:   Fri, 26 Jan 2018 07:15:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87wp05wnaw.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 6:06 PM, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Jan 25 2018, Derrick Stolee jotted:
>> Oops! This is my mistake. The correct command should be:
>>
>>   git show-ref -s | git graph --write --update-head --stdin-commits
>>
>> Without "--stdin-commits" the command will walk all packed objects
>> to look for commits and then build the graph. That's why it's taking
>> so long. That method takes several minutes on the Linux repo, but with
>> --stdin-commits it should take as long as "git log >/dev/null".
> Thanks, it took around 15m to finish with the command I initially ran on
> my test repo.
>
> Then the `merge-base --is-ancestor` performance problem I was
> complaining about in
> https://public-inbox.org/git/87608bawoa.fsf@evledraar.gmail.com/ takes
> around 1s with your series, 5s without it. Nice.

Thanks for testing this! May I ask how many commits are in your repo? 
One way to find out is to run 'git graph --read' and it will tell you 
how many commits are in the serialized graph.

Thanks,
-Stolee
