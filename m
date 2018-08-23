Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D361F42B
	for <e@80x24.org>; Thu, 23 Aug 2018 20:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeHXAa7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:30:59 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:47006 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeHXAa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:30:58 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so7878751qtn.13
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 13:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Xvbp2DEtrbvMExuqBp9USKazY0jF24WBoruRKJ/IKIU=;
        b=vghUobJsOaafqURRjkyGwKTNwsKdcWaGv4BknKf281jryMJdtZhFD0x1EuCuPPv3OG
         2kHshONL5bk5/vASHRKByI8eZvagKIzyV7GJeK+1L5W0CjtlVRsSjeeEB/ewofGkwTgO
         UVpkto4C1Yby0wo5cuP26SydqW7sucyuh1bKSqHabq1DcmVeTk+cmLd/N57C8lWeNO9I
         3cGCZy58l8cJjq+TuyZy1VmcItxpXs9rqaB+stLYnNPLKVSrVv0+UYWpn8aQ1Ik0kOLF
         b/LSzTSWMyS/2lqblzl12sXIwjS4n1GIdVPiWyD9eyfS5/a4o92Qr2beJejFL/HOqiT5
         sIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xvbp2DEtrbvMExuqBp9USKazY0jF24WBoruRKJ/IKIU=;
        b=b+etkDuQQvCKkmxQPSxWBxKq/kv0YrMPwnq8mlb73cFRyoYwLI+O47HF9TE7dpsyxF
         P/TMpXzss/lZIk+bb+9xqf/GYiKv977NUAXYkb7P53JqRluk9Eg6XDniN3In0/SR9zk5
         3ycrfZdE1JWnixG8v0q6xzHUvyG4VEQAl/D/im7so8zfRS8D9GHsujtRRHj79/eZyeOG
         M8F85sbXAgAswOjsI4mQlNKzr6n72A+scMQDZQ1/uRlhcwoLlVc36Nie9gm4qNHV8oy4
         /hHC9pPg043DxXl0OcGaUoOr64YETOUKZL9daDMaOG/k15jZ2Sgi2c76XZaqxV+zatIt
         x1tA==
X-Gm-Message-State: APzg51CbTePs1ddc3T49oys2HA/N04GoebMBOn19KJ9dOtw7HLI458xb
        juDGziZpBkwlu1fZ0r+O2WA=
X-Google-Smtp-Source: ANB0VdZ7wx3I35ZJiSkOsTHKcgdhoMaPi7shRoQRvv5t/uQtw2/1tsUxPxbjGwkkNnQwwr1xQGA71Q==
X-Received: by 2002:aed:22a4:: with SMTP id p33-v6mr8480432qtc.48.1535057970722;
        Thu, 23 Aug 2018 13:59:30 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:9512:56e4:62ca:d61c? ([2001:4898:8010:0:7e48:56e4:62ca:d61c])
        by smtp.gmail.com with ESMTPSA id k32-v6sm3864589qtb.80.2018.08.23.13.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:59:30 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net>
 <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
 <20180823185317.GA12534@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4b0168ee-4826-1f14-fc83-04c4cec18687@gmail.com>
Date:   Thu, 23 Aug 2018 16:59:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180823185317.GA12534@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2018 2:53 PM, Jeff King wrote:
> On Thu, Aug 23, 2018 at 06:26:58AM -0400, Derrick Stolee wrote:
>
>>> I think you can safely
>>> ignore the rest of it if you are otherwise occupied. Even if v2.19 ships
>>> without some mitigation, I don't know that it's all that big a deal,
>>> given the numbers I generated (which for some reason are less dramatic
>>> than Stolee's).
>> My numbers may be more dramatic because my Linux environment is a virtual
>> machine.
> If you have a chance, can you run p0001 on my patch (compared to
> 2.19-rc0, or to both v2.18 and v2.19-rc0)? It would be nice to double
> check that it really is fixing the problem you saw.

Sure. Note: I had to create a new Linux VM on a different machine 
between Tuesday and today, so the absolute numbers are different.

Using git/git:

Test      v2.18.0           v2.19.0-rc0             HEAD
-------------------------------------------------------------------------
0001.2:   3.10(3.02+0.08)   3.27(3.17+0.09) +5.5% 3.14(3.02+0.11) +1.3%


Using torvalds/linux:

Test     v2.18.0             v2.19.0-rc0               HEAD
------------------------------------------------------------------------------
0001.2:  56.08(45.91+1.50)   56.60(46.62+1.50) +0.9% 54.61(45.47+1.46) -2.6%


Now here is where I get on my soapbox (and create a TODO for myself 
later). I ran the above with GIT_PERF_REPEAT_COUNT=10, which intuitively 
suggests that the results should be _more_ accurate than the default of 
3. However, I then remember that we only report the *minimum* time from 
all the runs, which is likely to select an outlier from the 
distribution. To test this, I ran a few tests manually and found the 
variation between runs to be larger than 3%.

When I choose my own metrics for performance tests, I like to run at 
least 10 runs, remove the largest AND smallest runs from the samples, 
and then take the average. I did this manually for 'git rev-list --all 
--objects' on git/git and got the following results:

v2.18.0    v2.19.0-rc0   HEAD
--------------------------------
3.126 s    3.308 s       3.170 s

For full disclosure, here is a full table including all samples:

|      | v2.18.0 | v2.19.0-rc0 | HEAD    |
|------|---------|-------------|---------|
|      | 4.58    | 3.302       | 3.239   |
|      | 3.13    | 3.337       | 3.133   |
|      | 3.213   | 3.291       | 3.159   |
|      | 3.219   | 3.318       | 3.131   |
|      | 3.077   | 3.302       | 3.163   |
|      | 3.074   | 3.328       | 3.119   |
|      | 3.022   | 3.277       | 3.125   |
|      | 3.083   | 3.259       | 3.203   |
|      | 3.057   | 3.311       | 3.223   |
|      | 3.155   | 3.413       | 3.225   |
| Max  | 4.58    | 3.413       | 3.239   |
| Min  | 3.022   | 3.259       | 3.119   |
| Avg* | 3.126   | 3.30825     | 3.17025 |

(Note that the largest one was the first run, on v2.18.0, which is due 
to a cold disk.)

I just kicked off a script that will run this test on the Linux repo 
while I drive home. I'll be able to report a similar table of data easily.

My TODO is to consider aggregating the data this way (or with a median) 
instead of reporting the minimum.

Thanks,

-Stolee

