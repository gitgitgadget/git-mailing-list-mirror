Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01229C43334
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 18:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiFSSMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 14:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiFSSM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 14:12:28 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422B6338
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 11:12:27 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d123so9120655iof.10
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 11:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=9S66o0o4gezkhNOiKBeE5EHiRs6KZwikKwr0qZxrgp4=;
        b=Z80c8s/wUZ033jpdFHqRcUvn2eScaLXQAI2c/UB7Bdc2nWpa9/nPVlW5NSnXMPANNM
         gxpLovK3yusOnxXVslj6jjajB44OAHNClLVJgeasXGasrrsROuR+lMFJMEG5AxLVybwq
         7Q1aXQxuPO2+jxyDMip7tRT/5qpjuQKpTyfBBqoibOmpZ0TpRX+8QBlaJ9ml7fz/jV9g
         NGiMuu994bik8wW8wdfRZKirf5KwE211/qBOkHDtBIxTyp8GHr8q/dTW+8O+fBF5I6Rn
         oyC4E6BJoyLJHTBz11gjEeyFnx5BqHMhDWcvM9KC+yRIfls5K7OjH6w3oJF6W9+e4HBY
         jrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9S66o0o4gezkhNOiKBeE5EHiRs6KZwikKwr0qZxrgp4=;
        b=a6PMWwcZ1T4xpaLOENeV8nArbki9b6odfZFOCufzDE5b9XjlLVdeT5z3Lt+onFRCM3
         QUaylkq1K+nBiJGxhm9VUlOB7klgG7YMBzCHoTSTi8RcP8VQSXHjqLFNnb5YxfqVdAhu
         hd/NatLnsWg0k/RtZJkrLoxhR4BHQYAdpyPN3cXUdVW2GBYDT5GJMqCXTRDtumwI2Ty6
         EXMJb65KE+AzOGnv8Dd4FDLVRXuzFAa8xJvP1C/5KYeRZjugTV6W20B21rRY/U7jyoFQ
         SglNJBDkDPTgH9D1ZVCacrQcYku51zQ3rx+0C/u3E5hqOW6b6EY9ssV74pl1gFNyGWnS
         /LKQ==
X-Gm-Message-State: AJIora/r0EfqewZPnTvSRjZwDksaPZoKfXzxlC3dIfqCMPsnGFO8bBBG
        EUqge4UA4J2cpIp6tF6cdo4iNgA3UDFF
X-Google-Smtp-Source: AGRyM1sLGjDDDRmGsc/mn5nV6I7dxxrmyVmWPs5lMdjksBPO9jaj44/PfIV7RG6el6f2LGWYcq4w3g==
X-Received: by 2002:a6b:ba0a:0:b0:669:bd01:88de with SMTP id k10-20020a6bba0a000000b00669bd0188demr9594240iof.36.1655662347270;
        Sun, 19 Jun 2022 11:12:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a8ae:8ab5:fe57:13bf? ([2600:1700:e72:80a0:a8ae:8ab5:fe57:13bf])
        by smtp.gmail.com with ESMTPSA id o14-20020a056e0214ce00b002cc20b48163sm5193948ilk.3.2022.06.19.11.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 11:12:26 -0700 (PDT)
Message-ID: <b23d209f-80bf-c741-dc47-68af48fa3220@github.com>
Date:   Sun, 19 Jun 2022 14:12:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] extra cleanups on top of ds/branch-checked-out
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <Yq6deQf96g8M5wdg@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yq6deQf96g8M5wdg@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/18/2022 11:52 PM, Jeff King wrote:
> Here are a few extra cleanups on top of ds/branch-checked-out; that
> topic made some local "worktrees" variables obsolete, but didn't get rid
> of them.
> 
> The first was detected by my local -Wunused-parameter topic. The second
> is a similar case that the compiler doesn't happen to notice, but which
> I went digging for after seeing the first. I think that should be the
> extent of it. There's a third caller in validate_new_branchname(), but
> the series already got rid of its worktrees variable.
> 
>   [1/2]: fetch: stop passing around unused worktrees variable
>   [2/2]: branch: drop unused worktrees variable

Good catch. Thanks for identifying these. You are right that it would
be nice if a compiler could identify these "create and free, no use"
situations.

Thanks,
-Stolee
