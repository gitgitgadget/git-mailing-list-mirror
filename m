Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3797C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 15:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbiBXPyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiBXPyO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 10:54:14 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A016DADC
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:53:44 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id v18so4236195qvh.11
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/RWkmAscLqln1M1rz/EF4s2kmcwjPOoGJjdFo78wCSA=;
        b=bLICUs2XBtJQIBFQhSAsatVEOXaztB6oxTDXGT3+Bc4ZBHQBdzyvemYP61wYR5ee+Z
         JM794DtQk1bmRNG/GBJ8lYACStt50StuXXsqcU4jFSd6g7YyZ1s8WQyVYXuABzWD3xgY
         ywa3YIOdxFb9iVvfF0FxNmqI2Y6i+/sxF/aWaNMYhT5A+25FIl9WMaX27edlUYUMbzgA
         /DP9H94sk5oapp34HncpPOP60hOi/2qlq1SEfa9mAMiBuuSmMH+hxWgp4j59Q2RpwGvF
         i+G24uxow7K8gZhPDONFpDAN1p0yPegBDWDtA9TR/USGxG91HK3ggkr5HqeF1TxaBtdi
         ReBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/RWkmAscLqln1M1rz/EF4s2kmcwjPOoGJjdFo78wCSA=;
        b=j+xxK508n1gZZbBEQQmxK5laCtKeLFeltkFgeDK/y+GR6ftqpDQm8M9P036R+VSqDz
         h9N0v8a0y9Sub1UIgbgBF2hmzNskIy1ZGMAV4TyoQbHAAviSxAGN512HTMoS7+sxxyCU
         KXhWE/om1wxPj1a9vpRCU0SnHLg1+lgW5GcJ7rkW77Q8AvwszC73qOm83DFqbcCZGt8d
         YS+ubeP/3liBOcLE4IwOrvgu0d+h1y4gPodI/5jhTqemzihxyIm+PervTXSPJvEuaahD
         p09cvO6ADEmD4oCf86bCbyKybWCL3cGL6URlCILCwKJGAC0hqz9n9l+Box+K/f0+QRwu
         lGgg==
X-Gm-Message-State: AOAM5308Y5NVtc7Md9V/vnIo31Ogloq5ZZpNQsF12Mc7eHK4Dt/L8xnU
        +ALVqynGcQyqaqjUcXwtPisl
X-Google-Smtp-Source: ABdhPJwk7btlm3e+fe/9073GpaWSDKLGd3KRXTGEatZTYEkbihcsLCDzVJi2xEbf8vCQ32rMjOdbxw==
X-Received: by 2002:a05:6214:2484:b0:432:a1eb:6f63 with SMTP id gi4-20020a056214248400b00432a1eb6f63mr1774098qvb.104.1645718023329;
        Thu, 24 Feb 2022 07:53:43 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k11sm1383849qkk.83.2022.02.24.07.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 07:53:42 -0800 (PST)
Message-ID: <545f0248-89ad-3194-02ae-2f1a47f949db@github.com>
Date:   Thu, 24 Feb 2022 10:53:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 05/11] worktree: use 'worktree' over 'working tree'
Content-Language: en-US
To:     Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "Elijah Newren [ ]" <newren@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA_=5b_=5d?= <jn.avila@free.fr>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <a6a8eb8e7bb4520bfe37d3a79329cce7886af59c.1645379667.git.gitgitgadget@gmail.com>
 <d9394947-f545-2dd9-b788-38fd7202243d@iee.email>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <d9394947-f545-2dd9-b788-38fd7202243d@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/24/2022 9:33 AM, Philip Oakley wrote:
> On 20/02/2022 17:54, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> It is helpful to distinguish between a 'working tree' and a 'worktree'.
>> A worktree contains a working tree plus additional metadata. This
>> metadata includes per-worktree refs and worktree-specific config.
> Doesn't this need a clear call-out in the text to highlight the
> distinction, so that it is obvious at first glance to the casual reader?
> 
> I'd ended up with something like:
> - worktree
>     A directory whose files and sub-directories are (selectively) under
> Git revision management.
> - working tree
>     The working tree comprises Git revision management meta-data for the
> worktree,
>      and the worktree itself.
>     The meta-data may be independently located away from the worktree's
> data.
> 
> The key feature is to have a layout structure that shows the distinction.

See below where I mention that the first paragraph points out this
distinction. Your use of bullets makes it even more clear, and I think
that would be more valuable if this wasn't the very first thing in the
document.

> Or are we trying to remove all references to "working tree"? Or have I
> misunderstood?
...
>>  A git repository can support multiple working trees, allowing you to check
> Are we removing the above "working trees" phrases as well?

This one is important to keep. The worktree feature is how Git manages
multiple working trees.

The reason for switching most of the other references is because the
discussion applies specifically to worktrees, not working trees.

>>  out more than one branch at a time.  With `git worktree add` a new working
>> -tree is associated with the repository.  This new working tree is called a
>> -"linked working tree" as opposed to the "main working tree" prepared by
>> -linkgit:git-init[1] or linkgit:git-clone[1].
>> -A repository has one main working tree (if it's not a
>> -bare repository) and zero or more linked working trees. When you are done
>> -with a linked working tree, remove it with `git worktree remove`.
>> +tree is associated with the repository, along with additional metadata
>> +that differentiates that working tree from others in the same repository.
>> +The working tree, along with this metada, is called a "worktree".

This first paragraph is all about the distinction between working tree
and worktree, so it hopefully handles the concerns you had above.

Thanks,
-Stolee
