Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10675C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 15:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378609AbiDDPgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244310AbiDDPgU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 11:36:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7AF2A246
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 08:34:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k23so2529481wrd.8
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+miT7A/76HIqIrg9H9U05GRwWskE0Eh06CpBOXUW9DA=;
        b=aimwzmWUliRjDNWYUWrNkAzorvk8bguX80r6Ew9njZKqzuCQcvfTG4SR3FzfCds3Py
         U4Xh1bpRa02I8fr+egYmZ5G42V0ssyN9uQ36EuuSCo2HW5g2HLZfVPV7xfrRiKBP7EAg
         5GJWen34RUhSKy+KZuaLUqlmra4PwTbPR0Seuh+uQXXqgVRyS8xcw0cii09pm7t1AudO
         NEz0fOFsDL3CYaLFHIWCjNPCTt0WPE3vJ/aeO9Oi/x7sLbuhtrEKMeQXHMmTGYbE0F/U
         xZs1/v/fbx7B5MDiAjltwxyIkLl4tVeyoqHkpTmHJe5ZJ1RMMQdIPj8WB8W+eNktj1qx
         6Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+miT7A/76HIqIrg9H9U05GRwWskE0Eh06CpBOXUW9DA=;
        b=lcEnVXfUR9Fj1yHjygLRg4V6dP5/3GOHFwBXNy/4R3MAAS7n4aVD1YBj9YdKKe9+4e
         dtNKcbuPZWKeIUiBL81TBO9CA5T3/k84JENKBrFzpMoFJEIQYlUJRMKYp00G0RqnZ6f5
         DHNbeBpJ9VQ55lm6egPjCbgfInH8R6uCKSHE99R+qjQ4HafpO/Nyyx1XSDqGCVIK/QP1
         0lfvEyFtEnM/y+6n4IOZisrOERhcUBsvhjN3G0GsZa7c6KHOljWwP08iphk5/BAJPFNE
         uDcoDcEWoNInm0MX4kYadZOetombUylMCsfa+djkaupD/pa7gHsugFUPTtsE3hBOeS3m
         AHEQ==
X-Gm-Message-State: AOAM533SDpY9e4O1euEktwKYWLjQa4FUjNEQSQpbaMyYfx7UJ0fIZ+f2
        SWY7konUQdodPYVNyauetneGV9n+T9c=
X-Google-Smtp-Source: ABdhPJw527R/RZ8Fm7THtLpuLsw5sLNZNNdz7xWt7mxo45YbyedcRjIYaMWZ3CuE16oHrABPgaohNw==
X-Received: by 2002:a5d:4885:0:b0:206:a05:232 with SMTP id g5-20020a5d4885000000b002060a050232mr221228wrq.253.1649086461627;
        Mon, 04 Apr 2022 08:34:21 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id d13-20020a056000114d00b0020617a5b437sm1537962wrx.16.2022.04.04.08.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 08:34:21 -0700 (PDT)
Message-ID: <64cae3bc-e1b9-d118-2d78-208dc772f74a@gmail.com>
Date:   Mon, 4 Apr 2022 16:34:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Review Request (was Re: [PATCH 0/7] rebase: make reflog messages
 independent of the backend)
Content-Language: en-GB-large
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If anyone has time to review these patches I'd be very grateful. I've 
cc'd this message to some list regulars who have reviewed rebase patches 
before but if anyone else fancies taking a look at them that would be great.

Thanks

Phillip

On 21/02/2022 11:10, Phillip Wood via GitGitGadget wrote:
> This is a series of rebase reflog related patches with the aim of unifying
> the reflog messages from the two rebase backends.
> 
>   * improve rebase reflog test coverage
>   * rebase --merge: fix reflog messages for --continue and --skip
>   * rebase --apply: respect GIT_REFLOG_ACTION
>   * rebase --abort: improve reflog message
>   * unify reflog messages between the two rebase backends
> 
> This series is based on pw/use-inprocess-checkout-in-rebase
> 
> Phillip Wood (7):
>    rebase --apply: remove duplicated code
>    rebase --merge: fix reflog when continuing
>    rebase --merge: fix reflog message after skipping
>    rebase --apply: respect GIT_REFLOG_ACTION
>    rebase --apply: make reflog messages match rebase --merge
>    rebase --abort: improve reflog message
>    rebase: cleanup action handling
> 
>   builtin/rebase.c          | 144 ++++++++++++-----------------
>   sequencer.c               |   5 ++
>   t/t3406-rebase-message.sh | 185 +++++++++++++++++++++++++++++++-------
>   3 files changed, 214 insertions(+), 120 deletions(-)
> 
> 
> base-commit: 38c541ce94048cf72aa4f465be9314423a57f445
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1150%2Fphillipwood%2Fwip%2Frebase-reflog-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1150/phillipwood/wip/rebase-reflog-fixes-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1150
