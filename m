Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E231F597
	for <e@80x24.org>; Fri, 27 Jul 2018 16:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbeG0Ro5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 13:44:57 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39611 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbeG0Ro5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 13:44:57 -0400
Received: by mail-qt0-f194.google.com with SMTP id q12-v6so5601961qtp.6
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 09:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wDbOJPymOKGjky2AiVjqEj7bhIcAm2DIFjGZHXhd0k8=;
        b=k/y1D5OacFtL0CKm16Vjk/gRh0Rhlio0gqUjDOsKl3QfaqiBX9EqiSsMCYUDSTcJC5
         ph/Gip0fMABOgQOeLkXL0ff/lY+bJBOcFZAYosvXeLzjLibSUyrpjodmd8/vXuZzGlKd
         tjZP30OXbm7gAFHT+zGUb4zAcE4+OnVg5HWynlQ09Wbq4Mo8mp82YDoiOXHWPaIVm67v
         FDo51008ORWn+t2bjR8VDe3zt9ocOClaoEcoATVbGxFNQS/i47ZM8YYocycqDujtSm1b
         G3MVBHw+wsfaAdG1UDRV/WTi8LZdqnH+1FooS3MIKJzdAlMrpdN9AbiJz79FtEq43w9w
         CK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wDbOJPymOKGjky2AiVjqEj7bhIcAm2DIFjGZHXhd0k8=;
        b=gM/clayHkbw2LGqruVar4txgg2urRc1cofB84QJ2fSxSwJZJI4EQ5WxMs0+AKEBnqc
         ucpyo1SPPxmtWOqWfHKQ1JWUpBUqYmcDLB6t6Z9MSxiurMvGWKSAYH1upVAjxHqeOGkB
         0+LEt6YIvxR2kg54b/Cu/S2dQJS/k6wvabTbc8+JNO4doiB54zqIdY0xCDFfzliS9Lkn
         u65fIwA/a5q8k2Y9QEQrM8+ZEboqYjWFUsupMtajijkRDzCVomqnvQeTYUuDNdTjh410
         U2gAiJvUCFAZ1XUGV2wVVy5W8deLx73nVnO6dN4glDwMCkGmVgDtdL4QBXbit5LFS8+y
         9Qtg==
X-Gm-Message-State: AOUpUlGRHQQT0S6PYvduk9X9Kx3cDuXQ/drzlzNP0FYBcVdPUV+aMexH
        2ps907ZYUxzO1MosiP5TNDCu8lje
X-Google-Smtp-Source: AAOMgpcdo8BohERWyQ5sUDP4FYjoKd9uCeyQ+Lr+/ITyniw5Gx3gO4nrXbHODdDj6UOH01gXg/GKCA==
X-Received: by 2002:aed:3534:: with SMTP id a49-v6mr6474248qte.244.1532708539387;
        Fri, 27 Jul 2018 09:22:19 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id h6-v6sm2200775qtn.51.2018.07.27.09.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 09:22:18 -0700 (PDT)
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
To:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180718213420.GA17291@sigill.intra.peff.net>
 <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
 <20180724042017.GA13248@sigill.intra.peff.net>
 <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com>
 <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com>
 <CACsJy8AWcHVYNBZGRUTdcg8FmwOGz3MSUHH+3uVSGrg6MMZMng@mail.gmail.com>
 <20180726163049.GA15572@duynguyen.home>
 <xmqqd0v9pyzu.fsf@gitster-ct.c.googlers.com>
 <20180727154241.GA21288@duynguyen.home>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <434074a8-1045-8c8f-da0c-873436acf40e@gmail.com>
Date:   Fri, 27 Jul 2018 12:22:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727154241.GA21288@duynguyen.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/27/2018 11:42 AM, Duy Nguyen wrote:
> On Thu, Jul 26, 2018 at 12:40:05PM -0700, Junio C Hamano wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> I'm excited so I decided to try out anyway. This is what I've come up
>>> with. Switching trees on git.git shows it could skip plenty entries,
>>> so promising. It's ugly and it fails at t6020 though, there's still
>>> work ahead. But I think it'll stop here.
>>
>> We are extremely shallow compared to projects like the kernel and
>> stuff from java land, so that is quite an interesting find.
>>
> 
> Yeah. I've got a more or less complete patch now with full test suite
> passed and even with linux.git, the numbers look pretty good.
> 
> Ben, is it possible for you to try this one out? I don't suppose it
> will be that good on a real big repo. But I'm curious how much faster
> could this patch does.
> 

Thanks Duy.  I'm super excited about this so did a quick and dirty 
manual perf test.

I ran "git checkout" 5 times, discarded the first 2 runs and averaged 
the last 3 with and without this patch on top of VFSForGit in a large repo.

Without this patch average times were 16.97
With this patch average times were 10.55

That is a significant improvement!

I really have to run but I'll be back next week to dig in more.

Ben
