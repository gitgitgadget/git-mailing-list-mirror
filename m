Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD25FC433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 13:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiGVNPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 09:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiGVNPi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 09:15:38 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F41D0EB
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 06:15:32 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10bd4812c29so6215429fac.11
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=jHTLH+LqqiQgRjUAKNTCiOdDEC05tWYCARixJpLZSYo=;
        b=ItuJivVCfFcTc0UT775JK6Y7u/lqDtDbsLqxUfrGEDSR97aS1lvRoCN5hodpXzgBnI
         x9SShLnV49zLVpMJYoQSNFB9YsZSGiDInsroNJQTkQArL5oYRIhDJ4jiVBx2g1510x/j
         sX/dpXujjgnKJ8W+HbgNxmvjoMzHOuUGYoP3Y0LIxdt0KggxH/7YofdtXDUU2mLnmA2i
         0ciYEh5klaY6+63wdyVuhWxjVjRW8mD16qwodrXKqzNVrmHpazVpArympTXnAg/3Ct2f
         im0by4Jf+y8UnG5YJLfsVXP0KhlaXkVjCEJa9VIg89e6Ex3vHp0lNvMtEmCQIQi4mFwq
         1m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jHTLH+LqqiQgRjUAKNTCiOdDEC05tWYCARixJpLZSYo=;
        b=ACha1bTRbO0xpO0lG+VChfMhuQXDmUXSKXSqs/djnxcOENTw/Z218k32Ye55cZSSlB
         X8IBoqhXPS6n2kZA+ZUouycp1l5O5Ciq4gnF7K2MWOmu5nfBNjQbkWwDXQFPCd4vJqQ9
         bBNSY6WjufzmZ8A7Wv9zf+zc36CXeABMAmQnBD9zajsa+1AqkLz5OI6Z3f2b23Cjcgnz
         h2vyJifdSA+z0q3NAsl7H/lVqysuzcC8C+OdVWmRJXxo4TO1eyVSZe+02ULjXlBgeGAc
         q3zKZQKrfh1I+UHM9mWVHqKKXyTzUBHsgPbjN8orJ+Iq6xIN2qvHA5uqbQ1M3dwSVMsN
         QLRA==
X-Gm-Message-State: AJIora8+8KQyhI9Q02flRjyYsgQweuIqHh18TUVXZsci2QtLVrWoGH1A
        GOfkDwd0EnhSw9X/mOKL5M6I
X-Google-Smtp-Source: AGRyM1vHMohq29sT0s8fRb05i6EveSVLv9BwCIkiYAiQSOVoNC3LMPrfMC06iBhRBTFpFOC4ca8jZA==
X-Received: by 2002:a05:6870:4210:b0:f3:20cd:7904 with SMTP id u16-20020a056870421000b000f320cd7904mr7866151oac.284.1658495731301;
        Fri, 22 Jul 2022 06:15:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:89e1:7440:c819:d192? ([2600:1700:e72:80a0:89e1:7440:c819:d192])
        by smtp.gmail.com with ESMTPSA id w66-20020aca6245000000b003357568e39fsm1738307oib.57.2022.07.22.06.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 06:15:30 -0700 (PDT)
Message-ID: <5a6a687d-4543-f375-13dd-b60b37ddce18@github.com>
Date:   Fri, 22 Jul 2022 09:15:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/6] docs: document bundle URI standard
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <d444042dc4dcc1f9b218ca851fcf603a3afce92f.1656535245.git.gitgitgadget@gmail.com>
 <YtnHeUUnaLn6mSYK@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YtnHeUUnaLn6mSYK@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/2022 5:39 PM, Josh Steadmon wrote:
> On 2022.06.29 20:40, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>

>> +bundle.heuristic::
>> +	If this string-valued key exists, then the bundle list is designed to
>> +	work well with incremental `git fetch` commands. The heuristic signals
>> +	that there are additional keys available for each bundle that help
>> +	determine which subset of bundles the client should download.
> 
> To be clear, the values of `bundle.heuristic` are keys underneath the
> following `bundle.<id>` segments?

At the moment, the only planned heuristic is associated with a single
key (bundle.<id>.creationToken) but future heuristics could be more
complicated. The general idea is to say "these bundles were organized
with this heuristic in mind, so either take all of them (ignoring the
heuristic) or apply a specific algorithm to download a subset at a
time." The creationToken heuristic uses the total order on the bundles
to do a greedy algorithm for downloading the most-recent bundles until
the required commits are all satisfied.

>> +Related Work: Packfile URIs
>> +---------------------------
> 
> Thanks for including this section; my very first question before I even
> started reading the doc was "How does this compare to Packfile URIs?".
> 
> 
>> +
>> +The Git protocol already has a capability where the Git server can list
>> +a set of URLs along with the packfile response when serving a client
>> +request. The client is then expected to download the packfiles at those
>> +locations in order to have a complete understanding of the response.
>> +
>> +This mechanism is used by the Gerrit server (implemented with JGit) and
>> +has been effective at reducing CPU load and improving user performance for
>> +clones.
>> +
>> +A major downside to this mechanism is that the origin server needs to know
>> +_exactly_ what is in those packfiles, and the packfiles need to be available
>> +to the user for some time after the server has responded. This coupling
>> +between the origin and the packfile data is difficult to manage.
> 
> It was not immediately clear to me why bundle URIs would avoid these two
> downsides, but after thinking about it and discussing it, I believe this
> is the reasoning (please correct me if I'm wrong):
> 
> Bundle URIs are intended to be fully processed before negotiation
> happens, so the server can rely solely on the client's reported Haves /
> Wants to determine its response, as usual, and therefore doesn't need to
> know the bundle contents. Packfile URIs are not processed by the client
> before negotiation, so the server needs to be aware of the packfile
> contents in order to determine which additional objects to send, and
> can't rely solely on the Haves/Wants from the client.
> 
> If that's accurate, then it seems fine that when the bundle URI is
> provided by the user on the command-line, Git can download and process
> the bundle before even attempting to contact the server. But in future
> series, when we add the ability for the server to provide a URI via a
> capability, the client will have to pause after seeing the server's
> advertised URI, fetch and process the bundle, and then proceed with a
> fetch command. This seems fine assuming the bundles can be handled in a
> reasonable amount of time. And even if the connection breaks before the
> fetch command can be issued, presumably the client would not need to
> attempt to re-download the bundle a second time when the client makes a
> second connection to re-attempt the fetch.

After the server has advertised the bundle URIs, the client should
consider disconnecting while downloading bundles, then reconnect to
the server after that is complete.

For stateless connections (https) we need to reconnect every time, so
this isn't a problem.

I anticipate that in the long-term view of this feature, the server
advertised bundle URIs will usually point to an independent bundle
list at a static URI. In that situation, we can store the chosen
bundle list URI in Git config and check that bundle list for new data
before even connecting to the origin Git server. We would only
"rediscover" the URIs when either the bundle URI returns 404 and/or
the origin server lists new URIs.

Of course, there is the option that the origin Git server wants to
track and advertise the individual bundles directly, in which case the
client can't do this opportunistic bundle pre-check.

> For the point about the packfiles needing to be available for some time,
> this makes sense because the server's response is processed by the
> client before the referenced packfile is downloaded, but the response is
> incomplete without the packfile. But with bundle URIs, the server's
> response doesn't depend on whether or not the client actually processed
> the referenced bundle, only on what was negotiated. So the server's
> response is still valid and useful even if the client is unable to get
> the bundle.

You're pointing out the critical feature: the bundles are completely
optional. If the client fails to download the bundles due to something
like this race, then it will just negotiate for the origin Git server
to provide the data.

What's perhaps not entirely fair about this point is that the bundle
provider should keep this race in mind between serving a bundle list
and having the client request the associated bundles. Something like
a 24-hour window between updating the bundle list and deleting an
unreferenced bundle file should satisfy the vast majority of clients.

Thanks for the close look. While I removed them from the context, I've
made note of your smaller comments on things like typos and will fix
them in v3.

Thanks,
-Stolee
