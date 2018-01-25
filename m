Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DDBC1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 20:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbeAYUkP (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 15:40:15 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44835 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbeAYUkO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 15:40:14 -0500
Received: by mail-qt0-f195.google.com with SMTP id l20so22567257qtj.11
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 12:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=f2qUEn+6PuRFdwdCH4/FeOuI1keQncivdwdJGUJ1Rwg=;
        b=umEz6MqdgFkg0xjChanKcJhXl23hU/j6kvLBcZAo4rCxaP3Prxj5m5E/PB6kwSLcW/
         Z1WdAxPkv1EkmTiRx0qyw0kqEw/9IZ0O26WzeG6cPzORbsMDB+VVTfamlmrm5IE5jve0
         vmJRD7QOzVuvb8YGO46IxOsxsGPJetc5cjZXqIgNgw1GBECqHpgoMfIAomWD8Zvx/p6k
         8WrxuCtfk/fTgbrJoQBuIVq7BA08t4wcQw+JmCZ4A3AC9RrqSQU/wiO7RDsF7pfudaRh
         ojCuJC834IvsimlSPm7eRGGImuJ2DX00oV5AeWoI6uClwB1AXCWfkSgH6fbee+AFPvVH
         16Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f2qUEn+6PuRFdwdCH4/FeOuI1keQncivdwdJGUJ1Rwg=;
        b=V+lbUCbaHwScB46GHhZx3SAr96Uh6h8XjlfCuJoqjZCCJCTLXJQVNg3sVt2iQ29MTL
         VjXseAA0MDvaJSnEmbW0kW//u505+5YdOsg+esI/ScM+nmrs8J5NYOUvSYK5QKOXDK6c
         YOvjUIlYOydwR7xhjI6ABXa2kHqYIw3lhudfR0gQxLe+FlOP4lOFdi7dpX4fFsUXwPga
         bG0bm9W6NHT6FYxR8Tjnp2eaLtdWS2hUii7eYg8uaID+j75Dd3EeojeIGNB9IFBLwl+M
         trghGAObcvWdLXQ10FuK3DwnsXOaxTKRYLDxOb/1onnAi6qjEzgcWzre/RnON2A4Vu7h
         aaoQ==
X-Gm-Message-State: AKwxytdffsfIEaRPQBMFdWaA8DJzmbN0OGMlWEqiHAECphJu7wpRzy/O
        8EFa1ggyeDYl2/v04PS/xC4=
X-Google-Smtp-Source: AH8x227jkYaFox8LyXdqV+GaRsCg7C1vXylrYfao2y5l/8z2JHadIURpo1itRJ1rR1fY0DmcysDVNg==
X-Received: by 10.233.239.205 with SMTP id d196mr16478902qkg.139.1516912813987;
        Thu, 25 Jan 2018 12:40:13 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id m92sm2623137qkh.13.2018.01.25.12.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2018 12:40:13 -0800 (PST)
Subject: Re: [PATCH 02/14] packed-graph: add core.graph setting
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
 <20180125140231.65604-3-dstolee@microsoft.com>
 <CAGZ79kbUr-iQghL8qXxCq7noiYR9-MrxmTB4_v3D7WyXLPwUjA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d69b7eab-0aa2-6fed-7750-2fdf1ac8269f@gmail.com>
Date:   Thu, 25 Jan 2018 15:40:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbUr-iQghL8qXxCq7noiYR9-MrxmTB4_v3D7WyXLPwUjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 3:17 PM, Stefan Beller wrote:
> On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
>> The packed graph feature is controlled by the new core.graph config
>> setting. This defaults to 0, so the feature is opt-in.
>>
>> The intention of core.graph is that a user can always stop checking
>> for or parsing packed graph files if core.graph=0.
>>
>> @@ -825,6 +825,7 @@ extern char *git_replace_ref_base;
>>   extern int fsync_object_files;
>>   extern int core_preload_index;
>>   extern int core_apply_sparse_checkout;
>> +extern int core_graph;
> Putting it here instead of say the_repository makes sense as you'd want
> to use this feature globally. However you can still have the config
> different per repository  (e.g. version number of the graph setting,
> as one might be optimized for speed and the other for file size of
> the .graph file or such).
>
> So not sure if we'd rather want to put this into the repository struct.
> But then again the other core settings aren't there either and this
> feature sounds like it is repository specific only in the experimental
> phase; later it is expected to be on everywhere?

I do think that more things should go in the repository struct. 
Unfortunately, that is not the world we live in.

However, to make things clearer I'm following the pattern currently in 
master. You'll see the same with the global 'packed_graph' pointer, 
similar to 'packed_git'. I think these should be paired together until 
the repository absorbs them.

If other 'core_*' variables move to the repository, I'm happy to move 
core_graph.
If 'packed_git' moves to the repository, I'm happy to move 'packed_git'.

However, if there is significant interest in moving all new state to the 
repository, then I'll move these values there. Let's have that 
discussion here instead of spread around the rest of the patch.

Thanks,
-Stolee

