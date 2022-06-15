Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E4C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 13:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245312AbiFON2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243950AbiFON2K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 09:28:10 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDC1A199
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:28:09 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b142so8701562qkg.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Oip/WgnNd8bwMK8GNFDsBxtE5zAcw2kqifhgibbbL48=;
        b=Wx+T86/oVDPF31/4KnYv6A6dfoa31uEugSIMoQ67DQ7iHj1NJODHh82QkpJRq2esJA
         qxfhgPqaa64lPppxOB1U2+t1PUdoulUIy/NEXROzCu/Nplb40vEA52FnQ6JZZkoQJAjJ
         vn8MZ0G6kHcD8LznQ+5/29yCaqUzSyrJVU5oEQzOJiFjIivUKgEDJBKwsFWg6ToDEKlr
         Hab81yyNITR0E/bjDKuvX8oQiLMLx5A/xKAJW4fQb7dDiv5al1GIJxTpuvhCZNEMbvvf
         4sHO0Bfl14EGHNMkTjOHq1sHxU8MnggM4G6FViZ3oQVY6T4ALcF/v1NOa3mqtmpvscP2
         ad/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Oip/WgnNd8bwMK8GNFDsBxtE5zAcw2kqifhgibbbL48=;
        b=q5s3CsBXAEDq5kPNOWH+LCTtcZx0Hu/e5j3YJLDsQZlrkO0dcPVD8HzufbK0qp8n1Y
         yzl1w0ne8dEObZZIG/P6PsI5EusPJM4VZtrPUeof/ODclmdYE+22nCcx5DX7uZY9Smlo
         2bc24eWWDpMe1VCcyePYzXRYQLXNAVNsUpT+rOyzk59DA/iYT9Qzy9Bc/4f8al6W7jPo
         30dexbMz9JH3MWHCtnA7oOMRQtqaDmcLZ3Mqrl5iv0F8y/ARvBug4qlmo0ai5Zzz7OyL
         NQG7jk3d8k69lj7I++QRldHrqbsogUkoJAX4YGvWT07Yt4/k3poHdkM5I/wVJBcZMT8w
         K+Zg==
X-Gm-Message-State: AOAM531aqCQwLqp/t0QOFHrKKvYD0wE0yPej2p/SlfXd3Q4rCVeSi1cz
        u8omkeo8VlPpKXt4KFOWiRpX
X-Google-Smtp-Source: ABdhPJywaQXrXNvJib2sGlXSRG6m3hbyN/shmNqvRyyJ8tTwEwL1Agcn9W1ilJEMewuC67PBuP9Gtg==
X-Received: by 2002:a37:a304:0:b0:6a6:9fbf:882a with SMTP id m4-20020a37a304000000b006a69fbf882amr8128914qke.97.1655299688361;
        Wed, 15 Jun 2022 06:28:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:900f:fa9e:132:1bde? ([2600:1700:e72:80a0:900f:fa9e:132:1bde])
        by smtp.gmail.com with ESMTPSA id s22-20020a05620a0bd600b006a73ad95d40sm12528748qki.55.2022.06.15.06.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 06:28:08 -0700 (PDT)
Message-ID: <5c05094a-5563-d55a-ea12-7dd74cd22fca@github.com>
Date:   Wed, 15 Jun 2022 09:28:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 2/4] t5329: test 'git gc --cruft' without '--prune=now'
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
 <f59a0c326a01ab5f4e415a7ed03ff046b84b337b.1655242070.git.gitgitgadget@gmail.com>
 <YqkcEhQX4qm7fSer@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YqkcEhQX4qm7fSer@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/22 7:38 PM, Taylor Blau wrote:
> On Tue, Jun 14, 2022 at 09:27:48PM +0000, Derrick Stolee via GitGitGadget wrote:

>> -		git repack --cruft -d &&
>> +		# Write a cruft pack instead of deleting files.
>> +		git gc --cruft &&
> 
> These ("git repack --cruft -d" and "git gc --cruft") do the same thing,
> so this transformation makes sense.
> 
> It may be slightly clearer to refer to "objects" instead of "files",
> perhaps like:
> 
>     # Write a cruft pack containing all unreachable objects
> 
> and then replace:
> 
>> +		# Ignore the cruft pack and delete every unreachable object.
>>  		git gc --cruft --prune=now &&
> 
> with:
> 
>     # Prune all unreachable objects from the cruft pack
> 
> But I don't think the current wording is a problem, either, so feel free
> to take or leave these suggestions.

I like your suggestions. I'll update them if there are other reasons
to do a v2.
 
> Quoting from your original coverage report, this should take care of:
> 
> Taylor Blau     5b92477f builtin/gc.c: conditionally avoid pruning objects via loose
> builtin/gc.c
> 5b92477f 337) strvec_push(&repack, "--cruft");
> 5b92477f 338) if (prune_expire)

These lines, yes.

> 5b92477f 339) strvec_pushf(&repack, "--cruft-expiration=%s", prune_expire);

This one requires "git gc --cruft --prune=<time>" where <time> is
not "now". I didn't want to jump too much into the exact expire
time as I feared that could cause some issues, but I suppose
passing --prune="01-01-1980" would provide a non-zero expiration
and then lead to us testing "git repack --cruft --cruft-expiration"
as well. (It doesn't actually test the exact expiration time, but
does test that the options are sent down the pipe.)

Thanks,
-Stolee
