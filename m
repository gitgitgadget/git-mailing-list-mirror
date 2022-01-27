Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5837DC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 14:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbiA0OPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiA0OPp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 09:15:45 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A9C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:15:45 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q186so6066627oih.8
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rWe9S35iVmIdkfslvhlskubbeMamJjcMBRcUgw+/sJ8=;
        b=dm5Y4DUMj0YKxO6ZVesAfnbADzEPRthS6xKqkygdSbydUyFZk58TNOUXZ4jqxrB5CN
         akP8VwoY7hgsDh0c+e7+nm3QMnUiVnx16Yfg4tp+Bw4Pjfn7ndkDl4zzh+0TP8WcGta3
         oDm6G5AWpPB8m63XbLlhs28O46CIqw+Bi4OQ2s3lcAXtYTyIk5+hSXF8n1qrmibAsGGG
         086If1RleYBgeAK3qq86yqZCK7SaTLoMtu0OL66pTmYo5cGgSrXGvloiHJ6ryuz5qcCC
         vBTGIddCyKG4OSbdrwJaRWy7oWog1mwi0Qe2KC2XYct8tjhRplbHUvfPigHNcboUddxP
         EhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rWe9S35iVmIdkfslvhlskubbeMamJjcMBRcUgw+/sJ8=;
        b=xp9POBWtC3OcpRng587AINtKR28f/AK62ukOQKo6JqPrZSpf6XK2NOaVaTydI+EKyB
         oLQSSYX41JHHZYPUBXrqxRGkd0q/natuS3UQcs9GH/qZjZOQlK4CPThDHvdv1EsM7ef9
         JXonGKUHHB9Nu6aR/c232zgj7Q0E/XLUu4u40R1UcNtdikmFn7Fs+YobgQNnModEaqOD
         gn5F172q1SnBL3hK4ETYLOGnxcYMh8VSmOZ9nlgChCxq6rb0uiZDJu8QcV0zEJoNuFye
         pPor9JHqA7vXMoci/lhXKH8b3yJ3gJSMniwvUqB8m1TVObPb4SPhTQ+rebV6Ti2Ddlom
         KV8g==
X-Gm-Message-State: AOAM532SbWmjAaqbcZ+AmkGsiAd2uRW2gZ+JHToa5NWleauW7/RL+WxC
        LZVD1sLmat2uGlIlX25QxOXUV2PI8ys=
X-Google-Smtp-Source: ABdhPJy84hMwMSC7tbQIDs0tZCEmQ8+qCtHdDxlk+tTHJO2GT8IrRA6Sr87JLtRyUGiqcFOAp2djCQ==
X-Received: by 2002:a05:6808:f8d:: with SMTP id o13mr2367435oiw.250.1643292944535;
        Thu, 27 Jan 2022 06:15:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d9cb:250e:9ea6:f8? ([2600:1700:e72:80a0:d9cb:250e:9ea6:f8])
        by smtp.gmail.com with ESMTPSA id g4sm3506798otg.61.2022.01.27.06.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 06:15:43 -0800 (PST)
Message-ID: <8ef22055-081f-9c52-e290-5284ee4017e5@gmail.com>
Date:   Thu, 27 Jan 2022 09:15:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/5] Documentation: add extensions.worktreeConfig
 details
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     sunshine@sunshineco.com, allred.sean@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <459e09dedd71fcb64b9796bac52c3812d78f2405.1643136134.git.gitgitgadget@gmail.com>
 <0e8ef47b-7bb7-df38-1d97-90fda4471bbb@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <0e8ef47b-7bb7-df38-1d97-90fda4471bbb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2022 1:59 AM, Bagas Sanjaya wrote:
> On 26/01/22 01.42, Derrick Stolee via GitGitGadget wrote:
>> As documented in 11664196ac ("Revert "check_repository_format_gently():
>> refuse extensions for old repositories"", 2020-07-15), this extension
>> must be considered regardless of the repository format version for
>> historical reasons.
>>
> ...
>> +For historical reasons, `extensions.worktreeConfig` is respected
>> +regardless of the `core.repositoryFormatVersion` setting.
> 
> This implies `extensions.worktreeConfig` become integral part of every
> repository format version, from the past until now and to the future,
> right?
 
Right. What I'm saying is that this is already the case. I'm not
changing it. The commit message in 116664196ac discusses this in
depth. I'm pointing it out carefully because it is news to me
(hence why the sparse-checkout builtin updates the repository
format version before this series).

Thanks,
-Stolee
