Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BA2C1F46C
	for <e@80x24.org>; Tue, 10 Sep 2019 13:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfIJNy3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 09:54:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37680 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfIJNy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 09:54:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id u184so14179572qkd.4
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ySIxRZLPU6GMJbucAbg27LfLtHRNqVWqlm984NKoUuo=;
        b=DtdIbwEo28WzEjxiGPykEHuoXh3KF2UiPxwx/YURs+aVCKo8H0koNsaSPFkgZNcLqq
         cmjCYPvCy04slo+4ZUtAFGB2ICSHr6bq6ZMkz5HQfxlSvQBjQ5cxwyWeSgbN1OuLJWqO
         pvkw/nYUnAs4AGJzBkJCMp9z85COCK4HwLBUz+OAhhrIgD61YJpSqqFRSd4pvNFt4nQG
         liq7un0UNAp5xmcnh+Y/g/YUpQ6PxOPu2aA9TLpoKKgbGagmTvWAXcWRAnB7/4cBGWRS
         DQM5TLPEMpFZGkBODIg2UUqP7+dYFcxRv2JoQuT4IWFEl12cWA2GwwZhQ15Lp+qI84r8
         Gaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ySIxRZLPU6GMJbucAbg27LfLtHRNqVWqlm984NKoUuo=;
        b=qatGHvc/OZFJBuWAPaZ9RMEVVlkffWtz2l1rjiNi/2iijP4Y6pqH+HIDceQK67iqZP
         rtiu88fuceclovDmfvsBzLdiIhvVmvpm5ypmNnDEVSeMK/6b6ciwrzgMR4UF09hGFm5+
         maG+SNpZa9ccHLtmsP96n7hSWb1/Vs4Ys7rK9U1/7K1SZMDVrQZrHe2qXub1Dxaz3l0k
         OeUMXfYb0pfAQQNLqHeyOQT1FQqI+8PRvNulnjynNn86ge66IdfEdTVnBpylIu+GMP+k
         Cu1wqKOBAhSGCdPjsHE9CiTNjLCFzktGUZvnyypD9fi/WXEsRgqkiSLPgTtMkWsq4VvK
         q6Qg==
X-Gm-Message-State: APjAAAWxAH5+7CDr7wEHTDCLRYMuEsLkiRudxJphY9OXD/A4wbfltbPl
        nN7E8KiMRHp4PxWxs21JTgIKXw8q
X-Google-Smtp-Source: APXvYqyzMndz2FFhpSmKY6s7IyiWMlYVcH9p7+HRk5L+w5mMV2h072whD/jHbuaccCqM/ATpC0vwVg==
X-Received: by 2002:a37:aa96:: with SMTP id t144mr17423058qke.275.1568123668492;
        Tue, 10 Sep 2019 06:54:28 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a969:10f8:f485:d375? ([2001:4898:a800:1012:5a9d:10f8:f485:d375])
        by smtp.gmail.com with ESMTPSA id q16sm2511207qkc.21.2019.09.10.06.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 06:54:27 -0700 (PDT)
Subject: Re: [PATCH 0/1] commit-graph: emit trace2 cmd_mode for each
 sub-command
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.323.git.gitgitgadget@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <6d1e51c3-64a4-0075-5c9c-3302c5d07c50@gmail.com>
Date:   Tue, 10 Sep 2019 09:54:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <pull.323.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping :) Any thoughts on this?

On 8/27/2019 12:56 PM, Garima Singh via GitGitGadget wrote:
> Emit trace2_cmd_mode() messages for each commit-graph sub-command.
> 
> The commit graph commands were in flux when trace2 was making it's way to
> git. Now that we have enough sub-commands in commit-graph, we can label the
> various modes within them. Distinguishing between read, write and verify is
> a great start.
> 
> Signed-off-by: Garima Singh garima.singh@microsoft.com
> [garima.singh@microsoft.com]
> 
> CC: jeffhost@microsoft.com, stolee@gmail.com, garimasigit@gmail.com,
> avarab@gmail.com
> 
> Garima Singh (1):
>    commit-graph: emit trace2 cmd_mode for each sub-command
> 
>   builtin/commit-graph.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> 
> base-commit: 745f6812895b31c02b29bdfe4ae8e5498f776c26
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-323%2Fgarimasi514%2FcoreGit-commit-graph-trace2-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-323/garimasi514/coreGit-commit-graph-trace2-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/323
> 
