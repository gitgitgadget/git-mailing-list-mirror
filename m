Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E98C433FE
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 16:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346940AbiARQJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 11:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346599AbiARQI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 11:08:26 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF17DC061755
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 08:08:22 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id i7-20020a9d68c7000000b0059396529af8so18131552oto.4
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 08:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Izuux5JIelQeXrlh4FF7o2jxwtG6vCYd5iUspiy53wg=;
        b=F86I5EdlU8yYMev3D1BHNEUZrJmviacLtwP+9o+W7t49X3xlKvuV4gk4KJOCT/xFRA
         uBMvpjT/PRGEL0VIupInTtNRejgJHzrY/tM/hr/DuDXaQ+laOO1/sQLRfP/mknz2sxCb
         qiqcQmESTpbzXLS7WWaYTgY6B7bhS7XfEvrW1t3T0Mznt+HohDWENjpazErp+7i74sYb
         E77cVzxvicHejbT9nx8WcpGIofXCfEHNEnRZeT5HcChKvuPQp32CoL0JPViSanYMvrn4
         At2cUrqZ96w6Pugiyy6caRRdI2GC5YSrNuuvh48Jt1aFXEshrZ4XRgJLziw1Qv+nUtTz
         nGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Izuux5JIelQeXrlh4FF7o2jxwtG6vCYd5iUspiy53wg=;
        b=npcmoeNPKbqUTWH7pG4sENorsIcCZ4N7pkP5qn+439lFOlwOUq2iCuVcVUTpSIioKL
         jNOx6bgPYq5oZrCu1VfI/sceK5crjGW/NAL1bWcpzjY9kThfxLwNsA8PtVCpAIH0wFwQ
         B4K3RCLsxkCqAgNqQV3wLvcgzXFVIuB6+rxjHmuGxh0fn+FyUTQUzOSkLtKVxGIATzGn
         0id7l0E1BhKunndVcJWLdm7yrMK1xBDa6Xp+wZIv/MnkcZF/+auL7t3BqXUC/5y9o4Nd
         CGvV5bGL2aIqNWPg5Ded4ahDFPwFHOGVUKwmncXVknk9BB8OcfE4tdssvpdof9pWoFno
         XZpQ==
X-Gm-Message-State: AOAM533iIodboVh4I9NVKYJ+giN0tI7A24txeHoLRmuvO3zYv2o/Jvb0
        BVV3nV0zu7kbS5dx8cKncDZeDz767BU=
X-Google-Smtp-Source: ABdhPJxDpWxvR2MpV4hv0zeYh5ou5OdiblZIxaHi9zGJ3d8wvGXn/a2XhkB0XNdCYbHbtsAiuZNGig==
X-Received: by 2002:a9d:1b0f:: with SMTP id l15mr20508622otl.38.1642522102194;
        Tue, 18 Jan 2022 08:08:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:113f:db67:413a:89ca? ([2600:1700:e72:80a0:113f:db67:413a:89ca])
        by smtp.gmail.com with ESMTPSA id t13sm7032518otq.54.2022.01.18.08.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 08:08:21 -0800 (PST)
Message-ID: <a876f4e0-e3b3-d3a3-e469-927669622119@gmail.com>
Date:   Tue, 18 Jan 2022 11:08:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: ds/sparse-checkout-requires-per-worktree-config (was Re: What's
 cooking in git.git (Jan 2022, #04; Fri, 14))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqy23h4nss.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqy23h4nss.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/14/2022 11:37 PM, Junio C Hamano wrote:

> * ds/sparse-checkout-requires-per-worktree-config (2022-01-14) 6 commits
>  - worktree: copy sparse-checkout patterns and config on add
>  - sparse-checkout: use repo_config_set_worktree_gently()
>  - config: add repo_config_set_worktree_gently()
>  - worktree: add 'init-worktree-config' subcommand
>  - config: make some helpers repo-aware
>  - setup: use a repository when upgrading format
> 
>  "git sparse-checkout" wants to work with per-worktree configration,
>  but did not work well in a worktree attached to a bare repository.
> 
>  Expecting an update.
>  cf. <1db0f601-4769-15c0-cd58-ecddfa1fc9d5@gmail.com>
>  source: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>

Sorry for the delay. I've spent the last two weeks with my
family under quarantine for COVID.

I will update this topic this week.

Thanks,
-Stolee
