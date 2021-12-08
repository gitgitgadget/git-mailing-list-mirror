Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DF3C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 22:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240876AbhLHXCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240729AbhLHXCT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 18:02:19 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E79C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 14:58:46 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so4349962otg.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 14:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JxI40YmGGiSMUtWXCeB+uRDhGx7E4fD75OVGdANI3Eo=;
        b=WkVo7pIV4lHVBvo6UfvQmnrVK/N4Ysv2nenw63omadaaAgjEOvEGbVimh8MwdAbVgy
         r2UNZwBEwA34SwqbYWbZWgab8kurvdmAGkBYXGpYPM/a5kawP645IG9ap2nFk5Dx2aLf
         TrNuzPx0VtjEaN8FJ/WOFiCNF0OEacO3SWPJ81CkUin+NU9IygAHGxWBhEvRjovQYP/Z
         xlz0hoHVJVsGuuUQp4KQLjjwdv+kFEQzzGHpJ1TOzYmibuKq8QxTOs8+nJhAits8hgtY
         R5/CWvGx7GwqQXALFOg7k1kp3E6dHS4tsT1kR1PY+Q9QT/XEcA3HjM/4Vz4S+JvCYiHE
         Z1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JxI40YmGGiSMUtWXCeB+uRDhGx7E4fD75OVGdANI3Eo=;
        b=Ht2yasawCwVJ5wCRa3Imm3xf4DqkK39VVNIrD/nDx2N8x7DRYdQedC7GxSI7s3owgs
         kgLGFPp+jjBEJSDGjByKeBYgBPGZ3dflHtmVH+0NrId3ZbUwronf1TM+0ZrqFzk1fF9j
         ncFhH1fsBXAySfE3B1EwvvXbAKFxY+8njeAsbQCe5uqF1Het7i3yRNNswr71hoyOomqP
         asQ6llIliHWlc09qgej3lj45X20ik+fshiv4RTG4sONcKzVvswn2RnIKcGcpI7nkhYWc
         zLEFJVvsFg2vwUarSR5n1T64iGvL6qzTKVzM83NWs3AjCD5KIkgxrucrJ9GhaBiRQ7Oi
         DAwQ==
X-Gm-Message-State: AOAM531vmiIENtre+y1TTeqgrpGTTJaY88OPefCxKJRZ9VN4Zczdsxib
        2hov/X3hyvy1AOZc/MOGe5m+uEUnwlo=
X-Google-Smtp-Source: ABdhPJy2skcwBWFlmLpag3PqyiJGmfKgOQcd0rccEJ6WIMmspPSlrolkj4KIrOTfVNBBYxj2cvgK9A==
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr2149071oti.269.1639004325951;
        Wed, 08 Dec 2021 14:58:45 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id i29sm730902ots.49.2021.12.08.14.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 14:58:45 -0800 (PST)
Message-ID: <3478ff65-b1ce-5b5c-2053-90b927b66779@gmail.com>
Date:   Wed, 8 Dec 2021 16:58:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: ld/sparse-diff-blame, was What's cooking in git.git (Dec 2021,
 #02; Tue, 7)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <xmqq8rwv6e0a.fsf@gitster.g>
 <a4968ff2-17c6-faa8-e9be-0c1880e870dd@gmail.com> <xmqqtufiztp9.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <xmqqtufiztp9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/8/21 1:13 PM, Junio C Hamano wrote:
> Lessley Dennington <lessleydennington@gmail.com> writes:
> 
>>> * ld/sparse-diff-blame (2021-12-06) 8 commits
>>>    - blame: enable and test the sparse index
>>>    - diff: enable and test the sparse index
>>>    - diff: replace --staged with --cached in t1092 tests
>>>    - repo-settings: prepare_repo_settings only in git repos
>>>    - test-read-cache: set up repo after git directory
>>>    - commit-graph: return if there is no git directory
>>>    - git: ensure correct git directory setup with -h
>>>    - Merge branch 'vd/sparse-reset' into ld/sparse-diff-blame
>>>    (this branch is used by ds/fetch-pull-with-sparse-index; uses vd/sparse-reset.)
>>>    Teach diff and blame to work well with sparse index.
>>>    Will merge to 'next'?
>>>    source: <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
>>
>> This series has been reviewed at different stages by:
>> ...
>> I believe all comments have been addressed (either in the form of a
>> re-roll or a patch or explanation in my reply) and that this branch is
>> ready to merge to 'next'. I have cc'd all reviewers, though, in case there
>> was something I missed.
> 
> I think the patches in this series are in good shape.  The other
> topic this series depends on is already in 'next', so we can mark
> this for 'next', too.
> 
> Note that "explanation in reply" does not count as much as an
> improved version would.  If the code or the log message puzzled a
> reviewer during the review, future readers of the code and "git log"
> will be puzzled the same way.
> 
> Thanks.
> 
Thank you for the feedback, I will take that into account for future
series.

Lessley
