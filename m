Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D9641FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757563AbeAHU1r (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:27:47 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35252 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757547AbeAHU1p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:27:45 -0500
Received: by mail-qk0-f175.google.com with SMTP id w184so7633166qka.2
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 12:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qdtM9LPEa8b9k+7POWt5zwHUf3h5X9nf5dIIhmF0O2s=;
        b=Cpb1wiXSpX7eEGMl2QG1O4C+hVobotbE9+YwZneBCfewbaQswgUGHd9YBycI3GLFdW
         7rz+ntJ3ylZ5ZOMcoHHpfJICvHFSpbvYPvU7wUK2yc76SpkhWjL5NKcFxfdPj3rYXFzq
         m0Xb1Rl7RSOSJKgb8qZ5wzVUCHiaxg1YUGXhQuwC8HTgNYW1cVpDjS7nIyTHawcClYU6
         g5b+6pH9cjHZrgqoEBeM8i0VhC6MeyR2u0dGUggRkN0w7wZOFblpgqE6y4DHi1BKzWfK
         0ENeq6K7NETfuclU1LIAPhTDsfBfyAOsFwfT0bGxHqb3J7ll5WS2R1aV6FLLqSZ8xJud
         PSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qdtM9LPEa8b9k+7POWt5zwHUf3h5X9nf5dIIhmF0O2s=;
        b=Q1ONwBBhl6j8mL09WS0ztqHN8kWXGMxosUnGT1lenDEJW9KPF64wFg+be8QhDkigRy
         MZUKJBAoRuR1BRVbMQPxUpE55wAH2WvOFnERjmYFhGepJocOQm/tE7WXiKp/48uW9owp
         YJInzmVt0Lobz6kw2aDNN+ZIQwoq6ODMsnlchlBu3JDcOOlltJzzybzopXTPKZWwQhHS
         lN9OZDTKQ3Gvgz4GgP5IR/TGE+nSYIH/XFxcitVukDwOZe9AihA3LjjK5wvNxCBJScK5
         rAPQNlFs3fVkpHEQZD8T9JLK8D423vF+si09oMYHzmyNnJyrYYYWfO2sLN+nKZEOq9LB
         Lr0A==
X-Gm-Message-State: AKwxytdvUm1UpgcFJo8iqr6dvNcfkhHL8uKYoBqe9dVJruhNkYCGG8F4
        kRCIt4BiB9HR+78JDz72rc7vdVM1
X-Google-Smtp-Source: ACJfBouGpUiuOs8yzTE0a8xF/n5WJUAGBZi2kHcERylYxmZu3pbGx/UhzTH+5J9G790JcHGtsKsWPg==
X-Received: by 10.55.87.71 with SMTP id l68mr17728872qkb.331.1515443264444;
        Mon, 08 Jan 2018 12:27:44 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id l52sm8091084qtc.43.2018.01.08.12.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2018 12:27:43 -0800 (PST)
Subject: Re: [PATCH 2/6] fsmonitor: Stop inline'ing mark_fsmonitor_valid /
 _invalid
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org
References: <20180103030456.8181-1-alexmv@dropbox.com>
 <9bb36cea369530b980f6542e3e0f24dc142a20a8.1514948078.git.alexmv@dropbox.com>
 <alpine.DEB.2.21.1.1801042326581.32@MININT-6BKU6QN.europe.corp.microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <01ad47b4-aa5e-461a-270b-dd60032afbd1@gmail.com>
Date:   Mon, 8 Jan 2018 15:27:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1801042326581.32@MININT-6BKU6QN.europe.corp.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/4/2018 5:27 PM, Johannes Schindelin wrote:
> Hi Alex,
> 
> On Tue, 2 Jan 2018, Alex Vandiver wrote:
> 
>> These were inline'd when they were first introduced, presumably as an
>> optimization for cases when they were called in tight loops.  This
>> complicates using these functions, as untracked_cache_invalidate_path
>> is defined in dir.h.
>>
>> Leave the inline'ing up to the compiler's decision, for ease of use.
> 

I'm fine with these not being inline.  I was attempting to minimize the 
performance impact of the fsmonitor code when it was not even turned on. 
  Inlineing these functions allowed it to be kept to a simple test but I 
suspect (especially with modern optimizing compilers) that the overhead 
of calling a function to do that test is negligible.

> As a compromise, you could leave the rather simple mark_fsmonitor_valid()
> as inlined function. It should be by far the more-called function, anyway.
> 
> Ciao,
> Johannes
> 
