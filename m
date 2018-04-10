Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BEA21F404
	for <e@80x24.org>; Tue, 10 Apr 2018 14:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbeDJOeJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 10:34:09 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:43534 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754161AbeDJOeI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 10:34:08 -0400
Received: by mail-qk0-f177.google.com with SMTP id v2so13581592qkh.10
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Hw0jWRVNuTBhDjb7x++PYMeks6sJRrV05AFKgX4KlU4=;
        b=uw138DDPKbYIN1omF8LhRrWPOo6Rc42wmeGLBdLhkNOGdJUuNYYJ5fXWpKqX8xHwFT
         C5pVSUkCUGVrxYe0AARx3Q8x5/BlTMo1ZCiwPV+tg98629CtQjesenYorXlYU++sf+fk
         EzmsZKUlHwIsEPOYbgbmZB1YmXlTaAmG78Mx8p3oEBRIGzATGZcuvPtxVs7EbZmuGPnq
         ShacYQr+kKWhxyoRLzfHxjWFWPFu+4xv3IyzsOraBQWsmFdsoUpeRWjK/DptLXmuv745
         vyXUfOnO3UHCno7WjTOOt5Ke5UJl0YzmeOyyD6tZMKn2p0XnuRXWLFBeB7RnHdD1zT8U
         gIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hw0jWRVNuTBhDjb7x++PYMeks6sJRrV05AFKgX4KlU4=;
        b=c92LWE2lEdRAwcVXBhGmCCB8a2hiV/AVNJgi7oxG7EeypsnLEM9QPchQ8KAz8371qa
         vZN86U/QtU2AxplNUz5TwKFBsumXkhK/qifu7eGwm1V7quWoHBB2o9HzumRshnO8KdO4
         3ew5pNc1Wjspq6/Gw1u4PW7VzaK/PVsn/RIlGAtaVU/+I3IzVMJckqGfk9YlW8ajmNls
         rVWRS2sorraVoq8yuJSqrr9lA/HGszSH+2OfBNWqNl/q3MtpLRhFZsVH2kKITvg7H+pm
         zRzFIIl/AQap0lm++7kdAoa6TulfFv764dgWhGJz7rdm+0bv2nbpJ91MRG1FdVJK5Xmm
         5kYw==
X-Gm-Message-State: ALQs6tB1+8Xcmg5mWHGFjGz9eSIFnXsF/eJf2rP3BT4LYJNEB70tXrUc
        Bvn9VF2G9rAelqBDytwOhh6c4Qgw
X-Google-Smtp-Source: AIpwx48Oza2aAPQ7qoJBzsy/3x3Cvi65E28KongUuld3JmtMsby5ExWlMHP62iE1u00bD8kGqtJmxg==
X-Received: by 10.55.139.197 with SMTP id n188mr971217qkd.212.1523370847194;
        Tue, 10 Apr 2018 07:34:07 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id i188sm2246417qkc.16.2018.04.10.07.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 07:34:06 -0700 (PDT)
Subject: Re: core.fsmonitor always perform rescans
To:     Tatsuyuki Ishi <ishitatsuyuki@gmail.com>, git@vger.kernel.org
References: <CANqewP332-+esYWDPBtPif==wnb4PiNd89R1qTZsuWZAFSV0ew@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <53251802-5c5e-6fd2-25d0-40d534e6bd6f@gmail.com>
Date:   Tue, 10 Apr 2018 10:34:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CANqewP332-+esYWDPBtPif==wnb4PiNd89R1qTZsuWZAFSV0ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/26/2018 12:41 AM, Tatsuyuki Ishi wrote:
> Hello,
> 
> I'm facing issue with core.fsmonitor.
> 
> I'm currently using the provided watchman hook, but it doesn't seem to
> record the fact that it has queried the fsmonitor backend, and as a
> result the timestamp passed to the hook doesn't seem to change.
> 
> As it always pass a timestamp before watchman has crawled the
> directories, watchman will always return all files inside the
> directory. This happens everytime I run a git command, resulting in
> slowness.
> 
> Is the timestamp not being updated an intended behavior, or is this a bug?
> 

As a performance optimization, the fsmonitor code doesn't flag the index 
as dirty and force it to be written out with every command.  Can you try 
performing a git operation (add, rm, commit, etc) that will write out an 
updated index and see if that fixes the issue you're seeing?

I'm considering adding a special case to force the index to be written 
out the first time fsmonitor is invoked and am interested to know if 
this would have avoided the issue you are seeing.

Thanks!

> Tatsuyuki Ishi
> 
