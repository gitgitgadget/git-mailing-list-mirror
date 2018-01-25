Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3481B1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 16:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeAYQKA (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 11:10:00 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38625 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeAYQKA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 11:10:00 -0500
Received: by mail-qt0-f194.google.com with SMTP id z10so20469293qti.5
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 08:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/hrAbI+mwhBzpdzuu9BBA+J097iR42E2lzZafVKFhhk=;
        b=SpHYp6ESOM+wWpE9jyfLZbGDGIiA9EkowEe9SyF+lch6Faa3GKPaMm21mbqYMKJeNE
         BO0OQ5FqWMVh++HVWYXCullwCUYkCuv/GVrnPXYdU0/6bK8hILUWI8JbdQ270gFu/pOe
         G31UJ0yHOM0tRLkskvynygMS+M0CoBTMSRqchutzdaB1u3vKAk+vEpOoZ5O1ZcTa7K0G
         qf6dX7ynC9ta+zZeYweD4o8ssvKnsVhSbLuFDUEbWxkeOh9IKf8GAj5RqYFEQAwRaebm
         8O5h1DJPtf/UhHomPrlSWpk1izQ9tNquK0IS4Qr0zHOWj7ywL+ByE+lgFTBugpTeP0YP
         yqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/hrAbI+mwhBzpdzuu9BBA+J097iR42E2lzZafVKFhhk=;
        b=UqevXyIFblCRAazNIBPEVB/2uCrqpJxyz9gzU/liV5KPiZ5icmaBxwMVpVvOKIBvD9
         OGO7roUPyvCDQ/Lu5pTu+ayZS/h2MhbQoOVF16tmHLLhbd2LSf9CiVMv0MPBJvzyMqW1
         YFS5r9H/TCTuAVZhRfu8WIZoLZoUo4x7sbgxEFDd8KVRjSHju1A6670Qmb2wBZRcQGZj
         ApBO2ojB+pl+VEBYTJVqvNNZhJlV0ec+LkjsBx0b+6IlPLlR+KIjf/LfHlDyBIzdW1Bj
         sOpB0GLNre1Ln1vHjD61JthyZpzSssjZ5+5Dx6cOwa+ggtHhr/GTBzkP75HSMq/lpMja
         p4Og==
X-Gm-Message-State: AKwxytc+0bK5vLjY7+uWqrpbg+n1b0U3Ak5ewXrDMgYkEWbMrujkF33h
        I7ppwepcgRoUZcgj/gJJVig=
X-Google-Smtp-Source: AH8x2241F+APJ3ESj5XT5oVD7VwYvGwA5aCuvqYaPN0W0fwSvAqHuOg8YeYRKJ1rjubC+1dBTXMZjA==
X-Received: by 10.233.216.3 with SMTP id u3mr10945587qkf.283.1516896599112;
        Thu, 25 Jan 2018 08:09:59 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 24sm2132905qkv.64.2018.01.25.08.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2018 08:09:58 -0800 (PST)
Subject: Re: [PATCH 00/14] Serialized Commit Graph
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
References: <20180125140231.65604-1-dstolee@microsoft.com>
 <871siex7pc.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fe9d20da-eb70-d725-0530-cab1c029a0c8@gmail.com>
Date:   Thu, 25 Jan 2018 11:09:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <871siex7pc.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 10:46 AM, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Jan 25 2018, Derrick Stolee jotted:
>
>> * 'git log --topo-order -1000' walks all reachable commits to avoid
>>    incorrect topological orders, but only needs the commit message for
>>    the top 1000 commits.
>>
>> * 'git merge-base <A> <B>' may walk many commits to find the correct
>>    boundary between the commits reachable from A and those reachable
>>    from B. No commit messages are needed.
>>
>> * 'git branch -vv' checks ahead/behind status for all local branches
>>    compared to their upstream remote branches. This is essentially as
>>    hard as computing merge bases for each.
> This is great, spotted / questions so far:
>
> * git graph --blah says you need to enable the config, should say
>    "unknown option --blah <help>". I.e. overzelous config guard.

This is a good point.

> * On a big repo (git show-ref -s | ~/g/git/git-graph --write
>    --update-head) is as of writing this still hanging for me, but strace
>    shows it's brk()-ing. Presumably just still busy, a progress bar would
>    be very nice.

Oops! This is my mistake. The correct command should be:

     git show-ref -s | git graph --write --update-head --stdin-commits

Without "--stdin-commits" the command will walk all packed objects
to look for commits and then build the graph. That's why it's taking
so long. That method takes several minutes on the Linux repo, but with
--stdin-commits it should take as long as "git log >/dev/null".

> * Shouldn't there be a pack.useGraph option so this gets auto-updated on
>    repack? I understand this series is a WIP, so that's more a "is that
>    the UI" than "it needs now".

This will definitely be part of a follow-up patch.

Thanks,
-Stolee
