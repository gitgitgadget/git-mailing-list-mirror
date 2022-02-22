Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ED5C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 18:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiBVSzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiBVSzo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 13:55:44 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CB2151354
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:55:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o24so35247108wro.3
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W5QvcAeVK5WcEZUZq+2Ri9EuJDi9vGK9fcartWZTBBM=;
        b=cVi++9XDWcnGbNhScH4tc9tlzv09lDs8V5llHk1y4l9QcbOoFApAQiHVTfSV9/tC5z
         jD0r4/dPICgQmlHJQVekAUBfaMh2OezcAUW3l8JlcgnxnwjKfoeiFh63J5MLinSiGv0s
         7DmoeFV8s0RyrBUN0M+mfMIuZvzvNxEyM+Ox7a0nET5uw115Bu/+C0sbgMBNOfdMTid9
         5IMeIhlIMzgmoqyDWDDIcseEFO75RBfNuaf6vTzcBipqhovZFPSqtaaqe7bzdAGj9Rt9
         AqFQA2m9vnH2sKJx92g9ymoWuZV0YZCxJCccU++9AXIwgBEeYBZLcYJuHAzDdVx/w+2W
         kQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W5QvcAeVK5WcEZUZq+2Ri9EuJDi9vGK9fcartWZTBBM=;
        b=Wb0snritVbJ7VwGcEPqCEkKfyy7JYbv+X/S6LcGHFyshpZOVJRJMhNZzRRwjbJDpfy
         hLqmvFQR6UeaZTEjnPMp++jiO7aqC9pl6R0OTnx1xHTtT/NI6jdZ3dDBkCNoTWK61Ng4
         oX48SAlmzeoXDPae7WRMGX7T60xZUfCHw583sRXGU8Nh9Qt3wPqlbU31grHeiwDZbXAv
         Zq58U6YDaaIHuY/43zTDs94KKVskyiGkhoyeNgGVjRusM2rEz5hXlmv0Y3EXT3d5wEmu
         WGZVMOxdr44oiKsNPUuXtzLbUizOdG/0OmaiaudDAqUC2f7y5ec5YEfADoZDz4A74F+J
         vWBQ==
X-Gm-Message-State: AOAM53066s/MKvFwEg98POjGdFDx1JtMWswPA7bqIQq6rVIjMBpkbB5K
        9KbhK4j15b4ma0jv1r+8jTM=
X-Google-Smtp-Source: ABdhPJzCl+sDk3xWEq5PEvnciKQYl+xmHglzO1IkLrQQvZrq17GhMWs4mZO2qcdc6eubWBeccw/5MA==
X-Received: by 2002:a5d:59af:0:b0:1e4:a027:ce3b with SMTP id p15-20020a5d59af000000b001e4a027ce3bmr19810304wrr.318.1645556115622;
        Tue, 22 Feb 2022 10:55:15 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id p11sm29042572wrr.16.2022.02.22.10.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 10:55:15 -0800 (PST)
Message-ID: <8b95ac6e-5e9d-38e4-4729-dbbe4b671ea8@gmail.com>
Date:   Tue, 22 Feb 2022 18:55:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] Update the die() preserve-merges messages to help
 some users
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip

On 22/02/2022 10:33, Johannes Schindelin via GitGitGadget wrote:
> This small update to the die() preserve-merges messages is a response to the
> reported edge case in the Git-for-Windows googlegroups thread
> [https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM] where even git
> rebase --continue would die.
> 
> It is most relevant for Windows because Visual Studio still offers the
> option to run git pull --preserve, therefore Git for Windows already applied
> these patches. The improvements are not specific to Windows, though, and
> should therefore also get into core Git, albeit at a more leisurely pace.

I think the new messages are an improvement, I was wondering how 
difficult it would be to allow the user to run rebase --abort so they 
can at least easily start again with --rebase-merges.

Best Wishes

Phillip

> This is a companion patch series to
> https://github.com/git-for-windows/git/pull/3708
> 
> Philip Oakley (2):
>    rebase: help user when dying with preserve-merges`
>    rebase: `preserve` is also a pull option, tell dying users
> 
>   builtin/rebase.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> 
> base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1155%2Fdscho%2Fdie_preserve-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1155/dscho/die_preserve-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1155

