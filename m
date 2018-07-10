Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7FE1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 00:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933255AbeGJAc7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 20:32:59 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39146 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932847AbeGJAcz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 20:32:55 -0400
Received: by mail-qt0-f194.google.com with SMTP id q12-v6so16974351qtp.6
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 17:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0612Z1vsa9ZQkA2Po7NWGkauZKAito2VCNVkhp7BKiQ=;
        b=VLAao2psLd7GbA+vDi9mhiuOHub5wZLqNpNdp2kd/h/54qkKCiTm84iOuZ31qb0cnh
         cW0DwsPHeGaF68Dfn0QkSTPAFo8chBJZZM9OJeopDa9IrpNSSrGYd+DkKeBJaIP03qEJ
         tnUjgxfwJBuD9n4/R28tf079STrv2JmDlBiyyLY/Q/l3/VWtjcRy57unDSqSPiKBpsCx
         WaVC/JYw81fRKPOA0mcIyZmYzHuyryF7Z+x/GEq0rJUkUGM5567yIPBf2TWjheirCa7p
         P/TaHoxzu2Nn47N1VPOi5bQT85ZyEB7XhXmP0ftYCBvb6w4lh4MM8y81HJ45LppS9rz2
         gTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0612Z1vsa9ZQkA2Po7NWGkauZKAito2VCNVkhp7BKiQ=;
        b=i9MpsxmNxfsZ/wpa6Znh1hrAiXGGVpx4BuajqrjDTt51ezFXdt/oGVTTG5FeVHFDi/
         QMzQX+QQi0fO3+u2/7rj5QTTVXd82ur075SVWHK5Mlr8gsdtZQEkmrNbc4q6s7GPkzj9
         bQ0RWn0KB5Dki8oa+rJZPuvLDr14t/tXH4MjhPpA06OXypb0PLxUIQmPJUJ8IWx8KQTt
         cDabzwhAnpbw7bVRwKfMvvWK6g9yxqV6T6UBLbZFK/SzFb8eRD+AAY4oy/CfN8rP8gdJ
         g8svS9jOdrifaQnxZjBCOrFtK0xw08cSa9KBwOx+MEZqTRCLscbwi4kIDexQbPl05o6z
         ZlMQ==
X-Gm-Message-State: APt69E2wQSXu9nf2GCO7o/wX4jmqFyqccUFQIOxVjj6k6+3mWuvT3KLV
        GFdd7+yAh/t9DKCVBlJuMuCXI3Z2
X-Google-Smtp-Source: AAOMgpcPdqXpjijtN3KmE/riEO6NRDTLGsJ25BddcoIMKbgznj1MFq6BHe6d23+CXtDBunQL/IRQlA==
X-Received: by 2002:ac8:1c63:: with SMTP id j32-v6mr20298600qtk.242.1531182774479;
        Mon, 09 Jul 2018 17:32:54 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id n24-v6sm16741480qkh.39.2018.07.09.17.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 17:32:53 -0700 (PDT)
Subject: Re: [PATCH v2 on ds/commit-graph-fsck 0/6] Object store refactoring:
 commit graph
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <cover.1529616356.git.jonathantanmy@google.com>
 <cover.1531168854.git.jonathantanmy@google.com>
 <xmqq4lh8avus.fsf@gitster-ct.c.googlers.com>
 <3ced0e1e-1312-2f3b-bb67-fad3525e5500@gmail.com>
Message-ID: <b5733625-29c8-4317-ff44-d27c2fca11ce@gmail.com>
Date:   Mon, 9 Jul 2018 20:32:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <3ced0e1e-1312-2f3b-bb67-fad3525e5500@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 7/9/2018 8:30 PM, Derrick Stolee wrote:
> On 7/9/2018 6:27 PM, Junio C Hamano wrote:
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>> This is on ds/commit-graph-fsck.
>>>
>>> I saw that ds/commit-graph-fsck has been updated to the latest version
>>> (v7, including "gc.writeCommitGraph"), so I've rebased my changes on 
>>> top
>>> of that branch. There were some mechanical changes needed during the
>>> rebase, so I'm sending the rebased patches out.
>>>
>>> I've also added a patch (patch 1) that removes some duplication of
>>> implementation that Junio talked about in [1].
>>>
>>> [1] 
>>> https://public-inbox.org/git/xmqqefgtmrgi.fsf@gitster-ct.c.googlers.com/ 
>>>
>> While attempting to merge this topic to 'pu', I noticed that you and
>> Derrick are perhaps playing a game of whack-a-mole by you getting
>> rid of core_commit_graph global and making it a per in-core
>> repository instance, while Derrick adding core_multi_pack_index,
>> making it necessary for yet another round of similar clean-up?
>
> We did have collisions with Jonathan's v1, but this v2 is on my latest 
> commit-graph things so should not have conflicts.
>
> The core_commit_graph variable appears to still be global (do we have 
> config storage in the_repository yet?) so core_multi_pack_index is 
> similar.
>
> I do put the multi_pack_index pointer inside the_repository->objects, 
> so the equivalent of this series will not be necessary for the MIDX 
> series.
>
>
> This series looks good to me, so please add "Reviewed-by: Derrick 
> Stolee <dstolee@microsoft.com>"
>
> I think we are set for another series on top of this one that lets the 
> commit-graph feature handle arbitrary repositories (pass a 'struct 
> repository *r' in all of the functions).
>

Of course, after I send this message I see that my inbox had poorly 
threaded this patch and item 6/6 was below these messages. Patch 6/6 
does convert this variable and passes an arbitrary repository.

I'll update the MIDX patch in v4 to use that model for the config setting.

