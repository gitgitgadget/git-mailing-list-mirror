Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCC0C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 17:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiHDRjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiHDRjI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 13:39:08 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CBEDED9
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 10:39:07 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h22so354772qta.3
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gceeF5CTL+BGQSeyc1KV1Swk9GLmrhYmcA2Ml9t20p8=;
        b=RywHwyqo4oHYdRhi2TRvUgzqiC5ikrVt7Y4U18KK7jHwyLowUrgPzdBT0YO1pPWy09
         c1TKMeNTtOUZ9rtL1RG714jQaY/1JcxlRpXsJoXRhh+HcxtjUGeTXibBluVajy/HyN/P
         EYsMXogCtz9aXvubGoVY1BUSLaZJuY/++4MC3Luc9l5kY+FrhtpKz/eeaVJOxasGuC57
         jJmuFj6/qAgojEZljjCQw6qdcknS1k8CjYLJ7JeW+Ojr1sK3UUxq3sNCjS9vV5YUyjsx
         vGtfgefqGQNZEOPbKTAY0wqA9W6oh+s/KblRe1dcTX8f9+DxfocAA3PiFmtta4KiavWd
         wImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gceeF5CTL+BGQSeyc1KV1Swk9GLmrhYmcA2Ml9t20p8=;
        b=Xw7BbjIpcWuXjcXT7SWJBCYi2wZRmcphvVFOaFC1faSlddxqNszj3Hs5N6W5Jx4FLb
         xcS+m4LqDjxFiVDMm7L4+UIq2CjUeWnrT1I6DEOaG5/ok5oA9YsZr4OxvMyR4rQcWmGL
         yGMX9OFBjCUBCGX5LrYyg0HhfB8eUo4Vafg6HOuXKfvJ1LtewGqJdl74Gh7yyhb0pgIT
         kMHvPyiBZU5amxEr849Afuw7peyE6UfPOMPR6DL0wK8NSP8oS3Ax/lxTl4TZGG3T1lui
         oLJS2ud8iYd1k6hwVqhVj8lWbwu/4kWQe1+lng2XeRVeZ64s6PtMJLJ6CTYoE3Imsqa2
         BeEg==
X-Gm-Message-State: ACgBeo0ZfQxW6EDJmGCB0vAMGSNmHgZQmH2cC5C7xpYnCrt5oNGApBLQ
        1mHfyf0d82j/DQwJXJaLIpZj
X-Google-Smtp-Source: AA6agR7Eg4H5sbra+/BWqM2gdU86Mh3E6R0MAfv7Dm2KRyHu2nwVYVkiDUGcAdcWKD9bFg6XAF7WLA==
X-Received: by 2002:ac8:7d51:0:b0:340:81b1:e32c with SMTP id h17-20020ac87d51000000b0034081b1e32cmr2475323qtb.639.1659634746689;
        Thu, 04 Aug 2022 10:39:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id o13-20020ac8554d000000b0033b6f4895afsm1016467qtr.42.2022.08.04.10.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 10:39:06 -0700 (PDT)
Message-ID: <9b1cf24c-dfa9-0a5b-06f7-8942a8ba72ec@github.com>
Date:   Thu, 4 Aug 2022 13:39:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] bundle-uri: add example bundle organization
Content-Language: en-US
To:     Matthew John Cheetham <mjcheetham@outlook.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>
 <a933471c3afdd2c95d4115719c24d79e5e430b4d.1658757188.git.gitgitgadget@gmail.com>
 <AS8PR03MB86898A2F7156918A390296CAC09F9@AS8PR03MB8689.eurprd03.prod.outlook.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <AS8PR03MB86898A2F7156918A390296CAC09F9@AS8PR03MB8689.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2022 12:09 PM, Matthew John Cheetham wrote:
> On 2022-07-25 14:53, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The previous change introduced the bundle URI design document. It
>> creates a flexible set of options that allow bundle providers many ways
>> to organize Git object data and speed up clones and fetches. It is
>> particularly important that we have flexibility so we can apply future
>> advancements as new ideas for efficiently organizing Git data are
>> discovered.
>>
>> However, the design document does not provide even an example of how
>> bundles could be organized, and that makes it difficult to envision how
>> the feature should work at the end of the implementation plan.
>>
>> Add a section that details how a bundle provider could work, including
>> using the Git server advertisement for multiple geo-distributed servers.
>> This organization is based on the GVFS Cache Servers which have
>> successfully used similar ideas to provide fast object access and
>> reduced server load for very large repositories.
> Thanks! This patch is helpful guidance for bundle server implementors.
>> +This example organization is a simplified model of what is used by the
>> +GVFS Cache Servers (see section near the end of this document) which have
>> +been beneficial in speeding up clones and fetches for very large
>> +repositories, although using extra software outside of Git.
> 
> Nit: might be a good idea to use "VFS for Git" rather than the old name
> "GVFS" [1].

The rename from "GVFS" to "VFS for Git" is made even more confusing
because "the GVFS Protocol" keeps the name since it is independent of
the virtual filesystem part (and has "gvfs" in the API routes). In
particular, "the GVFS Cache Servers" provide a repository mirror using
the GVFS protocol and can be used by things like Scalar (when using
the microsoft/git fork).
 
>> +The bundle provider deploys servers across multiple geographies. Each
>> +server manages its own bundle set. The server can track a number of Git
>> +repositories, but provides a bundle list for each based on a pattern. For
>> +example, when mirroring a repository at `https://<domain>/<org>/<repo>`
>> +the bundle server could have its bundle list available at
>> +`https://<server-url>/<domain>/<org>/<repo>`. The origin Git server can
>> +list all of these servers under the "any" mode:
>> +
>> +	[bundle]
>> +		version = 1
>> +		mode = any
>> +		
>> +	[bundle "eastus"]
>> +		uri = https://eastus.example.com/<domain>/<org>/<repo>
>> +		
>> +	[bundle "europe"]
>> +		uri = https://europe.example.com/<domain>/<org>/<repo>
>> +		
>> +	[bundle "apac"]
>> +		uri = https://apac.example.com/<domain>/<org>/<repo>
>> +
>> +This "list of lists" is static and only changes if a bundle server is
>> +added or removed.
>> +
>> +Each bundle server manages its own set of bundles. The initial bundle list
>> +contains only a single bundle, containing all of the objects received from
>> +cloning the repository from the origin server. The list uses the
>> +`creationToken` heuristic and a `creationToken` is made for the bundle
>> +based on the server's timestamp.
> 
> Just to confirm, in this example the origin server advertises a single
> URL (over v2 protocol) that points to this example "list of lists"?

No, here the origin server provides the list of lists using the 'bundle-uri'
protocol v2 command. Using the config file format was an unfortunate choice
on my part because that actually uses "key=value" lines.

This could be more clear by using that format:

  bundle.version=1
  bundle.mode=any
  bundle.eastus.uri=https://eastus.example.com/<domain>/<org>/<repo>
  bundle.europe.uri=https://europe.example.com/<domain>/<org>/<repo>
  bundle.apac.uri=https://apac.example.com/<domain>/<org>/<repo>

> Remote -> 1 URL -> List(any/split by geo) -> List(all/split by time)

Adding the final link to each individual bundle, it would actually be:

  Remote (any/split by geo) -> List(all/split by time) -> Bundle

I can definitely update this part of the doc to be more clear.

Thanks,
-Stolee

