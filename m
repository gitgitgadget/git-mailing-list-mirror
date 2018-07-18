Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D44E1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 23:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbeGRXwC (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 19:52:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39847 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbeGRXwB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 19:52:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id h20-v6so4401826wmb.4
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 16:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oiRzG9OPyn+VdLcvOj9cpcFXH96SZUhm9IHp6LsL5Dc=;
        b=L4nUUU5v8qmnzXg1s2REZMQatiY+9jhVc3vAH581OwS5Zi+WM96vSB4ImaexDztJtW
         lr4ovFKSiE3A3Vuw8wO41Q1MoQqPlIl/CdyWhNG1WwCqHLz81LISb/yv/aCfrKJ+rYKc
         iCCrpckqa0Y08zYkjgvTHFJE3GbzZzvrROSDhefoQvR6zRm62mKz8YrNZ2iXU3rY+vju
         NrIJICeZRMBrI7tiKlV2jDQFPvdtnvR9R9bg2dktyLgqOPwzQB1/MWBu05cYtvQvJOEB
         mH1A11AJitEIyR+Q7vk3LsI5IEurniYllD3/ASCfDOUqa1huyPJfASmRU/uStmtH/Hc1
         OYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oiRzG9OPyn+VdLcvOj9cpcFXH96SZUhm9IHp6LsL5Dc=;
        b=Z1p/zPZ0v7522E2XeTZmMTViV0ZKrkXD1zYo0cHFbld3YVRcwoLOhp5snwU2YAk56L
         1wSVcpAPNbRO7ZaXvowVOUidaXkGgzay9l58AN/tRWmUVYLz6ADIvlBjqpmWy5g4iD1k
         YTTBSbX+SGVo1Jb7GKDD0eeBoimSZ6zyqd77DPoX0yRleFjHltBNf5JIfWdduV7tjMSH
         u13Vs3eSVUKbukhZu/xp6DzL9kyEjzErm/cj2yYxhbAAEKeGnDF0K1mKGguLXKFNK4T8
         r5g0TvQ59SI6RBxd3I4fkfojEEQGWbXhH8Xu4R0LQVhGbGT0iieDzDP0jOc2pYI822Eg
         kjtQ==
X-Gm-Message-State: AOUpUlHcyw7jvIuFUN7o1bxr0HtRhQTA/SGZRT31+4KqLqpA1AOvJ4XI
        /Bw318WXpWKWnXPMOdzndhedvMIl
X-Google-Smtp-Source: AAOMgpdpPjDQDS4mfJXek8fCnFPSxFMi3iCevjzmbrHpcDYh6usHWNMIfum7AoRTW6UgwcI6KMzyCg==
X-Received: by 2002:a1c:f906:: with SMTP id x6-v6mr2715802wmh.63.1531955511245;
        Wed, 18 Jul 2018 16:11:51 -0700 (PDT)
Received: from [192.168.0.137] ([82.78.255.161])
        by smtp.gmail.com with ESMTPSA id 189-v6sm5031321wmd.17.2018.07.18.16.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 16:11:50 -0700 (PDT)
Subject: Re: [RFC PATCH 2/6] tree-walk: Add three new gentle helpers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
 <b1f385105f790cafc65c26699282919a2735d4bd.1531778417.git.ungureanupaulsebastian@gmail.com>
 <xmqqin5dofor.fsf@gitster-ct.c.googlers.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <ba38bdd0-c1c3-cded-0e18-f21e0d7fd9a8@gmail.com>
Date:   Thu, 19 Jul 2018 02:11:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqin5dofor.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 17.07.2018 21:55, Junio C Hamano wrote:
> I wonder if the GENTLY option should apply to update_tree_entry()
> the same way as it would to the other codepaths that currently die
> to express "we were handed this string by the caller and told to
> give back object ID the string represents, and we found no good
> answer".  In this one (and the "bad ref" one), the existing failures
> in these two codepaths are not "we got a string and that does not
> resolve to an object name", but "we didn't have the data to work on
> to begin with (either a corrupt tree object or a corrupt ref").
> 
> In other words, it's not like "We were given HEAD:no-such-path and
> there is no such path in that tree"; it is "We tried to read HEAD:
> tree for no-such-path in it, but the tree was corrupt and we couldn't
> even tell if such a path is or is not in it", no?

I can definitely say there is a clear difference between these
two cases, but I am not entirely sure how `GENTLY` should apply to
`update_tree_entry()`.

On one side, even before this patch, there was the gentle version
of this function, `update_tree_entry_gently()`, which could still die.
And it makes sense. It should be ok to call `die()` when there was
detected a "bigger" issue.

On the other side, in some cases like `read_ref_at()` I think that it
could be useful if the caller could handle any error (which is what 
patches 3/6 and 4/6 try to accomplish).

I really do not know which way would be the best in this particular case.

Best,
Paul
