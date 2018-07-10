Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B77F1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 00:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeGJAaS (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 20:30:18 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34934 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754648AbeGJAaO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 20:30:14 -0400
Received: by mail-qk0-f193.google.com with SMTP id u21-v6so10710805qku.2
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 17:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8N0sPX6KMQgLXhk1whlX7s6+WZRBuPKeEeU4BZfijh4=;
        b=L1JBqec/Z6EGsbHGiLxrIePiGDZVMMdNj9r7zCkZMmcAR9+AEAzeHOAqWZ/0xJBrLD
         INQWQCKO7ZvLB1anDhw6UVt7HWnORqmL5fA8sFJbg999efaSSULgSHHtLbmyNPQOQ39D
         S5xmNmAdhsZL/mU8UCdPDGH9ChwpjzvKCL8LLO9sMpXKGvm5fxWpmDhOOx5AuKnERKJR
         plmAhGGEhuoX15g6Ua9aWxW1peQNPvbE99HZQWSTeqXQMMk1KbOOva5zpuM7ZQATNRaK
         ZVTLDcVeVKcdM8kE49sqfIuOldfIBl8Xfc8P9nmOXVaHLg2B3gR8m8hqEMBWB+Ygit1w
         ARdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8N0sPX6KMQgLXhk1whlX7s6+WZRBuPKeEeU4BZfijh4=;
        b=bwkfKXeQWcOzgOyBa4WiI8RG47gLKbpTTiUZ66LcRcQKu8J4u0W/J5mncuQ0Ifsaml
         35QuYnCrAXxRUUdGwxZskB+2g0GjzWWWPGN9PfE+4BkOgw04x2TAt4XIvaWhepKJbQu2
         775MFVP8+JL38quucxm8eAbx1E/sGxNjb+IkxuRKN2gawlrjQMLF7kHNUYo2btoqLSKB
         mEfn/fp2i3G3sSt6jPciy0Q29iMLGnI0WTcz3lHoBfNOFdrqYmcq0YgEA77iBNsNIcPR
         uSXgyhooaWN2mEuodz5Qj95MnRpHu+yc1qS2upo178BUkBYW44g8W2OoPHYe8TwRLKG2
         q33Q==
X-Gm-Message-State: AOUpUlEvX5a4phsVAw9ExYSp5+5dJ/Q8h++P/LT0wt8qPW4J1apYlsHK
        9HXj/CWueEiV0pHlvxPzYVCXJCnD
X-Google-Smtp-Source: AAOMgpfm5Qs+VFG5atIEJT9IZBL5SWYRFa6U23k6bxA832Y545WtrdfU7l3yMIZ3d2g5c/GOE+Y+xg==
X-Received: by 2002:ae9:df81:: with SMTP id t123-v6mr2471946qkf.55.1531182613575;
        Mon, 09 Jul 2018 17:30:13 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id p78-v6sm13673524qkl.38.2018.07.09.17.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 17:30:12 -0700 (PDT)
Subject: Re: [PATCH v2 on ds/commit-graph-fsck 0/6] Object store refactoring:
 commit graph
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <cover.1529616356.git.jonathantanmy@google.com>
 <cover.1531168854.git.jonathantanmy@google.com>
 <xmqq4lh8avus.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3ced0e1e-1312-2f3b-bb67-fad3525e5500@gmail.com>
Date:   Mon, 9 Jul 2018 20:30:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq4lh8avus.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2018 6:27 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> This is on ds/commit-graph-fsck.
>>
>> I saw that ds/commit-graph-fsck has been updated to the latest version
>> (v7, including "gc.writeCommitGraph"), so I've rebased my changes on top
>> of that branch. There were some mechanical changes needed during the
>> rebase, so I'm sending the rebased patches out.
>>
>> I've also added a patch (patch 1) that removes some duplication of
>> implementation that Junio talked about in [1].
>>
>> [1] https://public-inbox.org/git/xmqqefgtmrgi.fsf@gitster-ct.c.googlers.com/
> While attempting to merge this topic to 'pu', I noticed that you and
> Derrick are perhaps playing a game of whack-a-mole by you getting
> rid of core_commit_graph global and making it a per in-core
> repository instance, while Derrick adding core_multi_pack_index,
> making it necessary for yet another round of similar clean-up?

We did have collisions with Jonathan's v1, but this v2 is on my latest 
commit-graph things so should not have conflicts.

The core_commit_graph variable appears to still be global (do we have 
config storage in the_repository yet?) so core_multi_pack_index is similar.

I do put the multi_pack_index pointer inside the_repository->objects, so 
the equivalent of this series will not be necessary for the MIDX series.


This series looks good to me, so please add "Reviewed-by: Derrick Stolee 
<dstolee@microsoft.com>"

I think we are set for another series on top of this one that lets the 
commit-graph feature handle arbitrary repositories (pass a 'struct 
repository *r' in all of the functions).

Thanks,

-Stolee

