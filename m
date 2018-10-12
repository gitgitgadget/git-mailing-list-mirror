Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520C21F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 12:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeJLTl4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 15:41:56 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:34870 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeJLTl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 15:41:56 -0400
Received: by mail-qk1-f182.google.com with SMTP id v68-v6so7500086qka.2
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gfWVdM5yf9VAOvqxvJ+wWqOgQ+snaxw2jAo3T8g4Z70=;
        b=qNvIy9VuKS6xgzRqEUAS/hbAkmN1nbcKZqKgYZ7NOcp56IXVjFicM99wI0I9Usj1Ta
         2+jBrrdIP5T35uNMGVtyFB92QHrkm2JQVcmJllEW+2QTw2CTVXb0u96EbgjKMFRu8rkl
         CRsOW+wAR/GMdTH42lU8MZlo3tB997vbEodxKQIqz7HmGs56Wd7dXGWQaYI8oBff1J9E
         rgh0IqGTLhw7lq4bmrQCiganoTt6A+Y+gsLMM5ZxvAy3fOTvvZfS+Ewlkh6krF05V5Zs
         BGgUFKX72r8UxjkNk9nRDYILty76uHYy3InkJ6PDV8xxX5MuRmsIJKfdlGOOK9b55cN1
         PMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gfWVdM5yf9VAOvqxvJ+wWqOgQ+snaxw2jAo3T8g4Z70=;
        b=dBqd622P7ijmOCnyk9Q/fA+1yVDU0bRKQcPBCcN3w0iCQD4Y6bQrWKUzcujZQnJT1R
         t13q/H3PVGFX76z7FrcwOGp+7oHVQcSz4BOOyx1JUc87l7UUbKXxeCLpYUCHganASZEz
         60Q0oaLrzQlAgN6RAeE+e5TwaFxhtmy+KcolwncTwmvks9BALq1q7XVNow3C6IPSIe1E
         X5/gVgI8glzP2fxFEe/L0fNzfvsS5vej0ogpcuHC7iIvAs4BXydS08xBNPT03ZMSsaOq
         KZIMS+0Ag4QzFFZLodBLStvEFitgmoYv5rL5B4zAxg5/3lTP/kZgN31IPP3e/gHc66RJ
         TAxw==
X-Gm-Message-State: ABuFfoiqKZeDNOVAyMIraWFoU9uIoYCGAPRCZQC43slmf/b41+5JXjG5
        oBX5pARDl9j+scv4uPS1QfGM3PPp
X-Google-Smtp-Source: ACcGV633IW6GGRmn/dv71DVNpdwemz525gLokhJW+CsT1tjnpmbXWI2EdpLh4y1GyNLxZZaeFwBlBQ==
X-Received: by 2002:a37:2442:: with SMTP id w63-v6mr4478737qkg.31.1539346186025;
        Fri, 12 Oct 2018 05:09:46 -0700 (PDT)
Received: from [10.160.98.125] ([167.220.148.125])
        by smtp.gmail.com with ESMTPSA id s131-v6sm456812qke.57.2018.10.12.05.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 05:09:44 -0700 (PDT)
Subject: Re: [PATCH v4 0/1] contrib: Add script to show uncovered "new" lines
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
References: <pull.40.v3.git.gitgitgadget@gmail.com>
 <pull.40.v4.git.gitgitgadget@gmail.com>
 <xmqq5zy7eulx.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1aedfa31-33a5-ac7c-bcd5-7455a83d3f0a@gmail.com>
Date:   Fri, 12 Oct 2018 08:09:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zy7eulx.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/2018 11:01 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> CHANGES IN V4: I reduced the blame output using -s which decreases the
>> width. I include a summary of the commit authors at the end to help people
>> see the lines they wrote. This version is also copied into a build
>> definition in the public Git project on Azure Pipelines [1]. I'll use this
>> build definition to generate the coverage report after each "What's Cooking"
>> email.
>>
>> [1] https://git.visualstudio.com/git/_build?definitionId=5
> Thanks.  Let's move this forward by merging it down to 'next'.
Sounds good. When it moves into 'master' I can update my build to call 
the script from source.

Thanks,
-Stolee
