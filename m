Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E840C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 15:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiBXPLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiBXPLk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 10:11:40 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC475D5C2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:11:09 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id x6-20020a4a4106000000b003193022319cso3854856ooa.4
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1qn4X58QHsPXhrpaBwmPJQxuGoxu7R4k426eDNpgwYI=;
        b=GFxJmVDn/XScBnbmhmAwKhVgYwN+u7sjz11cE7pxEblVMyyRd019MGX/4KWx+KWezk
         ylTemMPXgJLno8cy3xWRFamNANAEwaeukFfefucuoUARi6kK68daEwL9DUQSpADWGKMr
         kn6/SIJi5igoESuMTpQGkahvcYnecF9e4YMYu2aV1s72gC5Avwczi9ZiyIgG4s+Fi59G
         YXHA6SGPbhclSmfvmxnsV2U/scjiA9HcPnW7HLFgryZwcCfFnZRKmkSXj91gewMf1zvX
         2pgpEc/kBPLcirl4bEpqA+9tymC4u0O/q4kzY0iL5DdvQeFXo9GCmcpu4Nje/QRYStoD
         dwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1qn4X58QHsPXhrpaBwmPJQxuGoxu7R4k426eDNpgwYI=;
        b=7bjPZ2+xfM7aO8hS42hx3pMQsnVLuaNebTCxFYNB77Ha4Y3zjPho2IQXeqpS6/kf0u
         mNkDSy2xennkNuMgew0UbnymvgpOkq4Aqoe5VNf4Q26m66qBhpsIItOqojYxD5V2nMnf
         DegZyLtBETWZeTuPmliTc57xo4MbBpBEHfOkfK4W98UgDz5Avxilhz7SRruyZC1pDfVL
         1vmpTOIzX4RC/eh2an2/bpzAjCsMkEULamqchIuxutb14ssPyKeuYYkqfeBOGsnUudCl
         5qz3nmuISrbwBELwJmHrlvGx0scQmsls2AEbW2WouRkj0dVAMWBHntE+ytgNgy6Wh1zj
         Xtyw==
X-Gm-Message-State: AOAM532IKg6zD2So4TTgPBMAb7Nwn3sqASaiAKz+gn89L4RUWUVsew24
        Oi8WZurZju7jEMlz8ZX4b57MFfgmkbDV
X-Google-Smtp-Source: ABdhPJyurS0NPY6T6j7h//tWeenY2sFWhnb6hl1wkSkonptmovis/ZcHdZ3PfqSv7ElK0+BB4geUVA==
X-Received: by 2002:a05:6870:ea02:b0:d3:5691:f0ea with SMTP id g2-20020a056870ea0200b000d35691f0eamr1356523oap.22.1645715469235;
        Thu, 24 Feb 2022 07:11:09 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id h16sm1257536otg.35.2022.02.24.07.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 07:11:08 -0800 (PST)
Message-ID: <05747ff2-f839-5408-e25b-698b147ef158@github.com>
Date:   Thu, 24 Feb 2022 10:11:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 07/23] fsmonitor-settings: virtual repos are incompatible
 with FSMonitor
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <4e856d60e385d64158f17ec1226f97eb323bc55e.1644940774.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <4e856d60e385d64158f17ec1226f97eb323bc55e.1644940774.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Virtual repos, such as GVFS (aka VFS for Git), are incompatible
> with FSMonitor.

I would swap all of your "GVFS (aka VFS for Git)" for just
"VFS for Git".

> +/*
> + * GVFS (aka VFS for Git) is incompatible with FSMonitor.
> + *
> + * Granted, core Git does not know anything about GVFS and we
> + * shouldn't make assumptions about a downstream feature, but users
> + * can install both versions.  And this can lead to incorrect results
> + * from core Git commands.  So, without bringing in any of the GVFS
> + * code, do a simple config test for a published config setting.  (We
> + * do not look at the various *_TEST_* environment variables.)
> + */
> +static enum fsmonitor_reason is_virtual(struct repository *r)
> +{
> +	const char *const_str;
> +
> +	if (!repo_config_get_value(r, "core.virtualfilesystem", &const_str))
> +		return FSMONITOR_REASON_VIRTUAL;
> +
> +	return FSMONITOR_REASON_ZERO;
> +}

This reason seems to be specific to a config setting that only
exists in the microsoft/git fork. Perhaps this patch should remain
there.

However, there is also the discussion of vfsd going on, so something
similar might be necessary for that system. Junio also mentioned
wanting to collaborate on a common indicator that virtualization was
being used, so maybe we _should_ make core.virtualFilesystem a config
setting in the core Git project.

The reason for the incompatibility here is that VFS for Git has its
own filesystem watcher and Git gets updates from it via custom code
that is a precursor to this FS Monitor feature. I don't know if vfsd
has plans for a similar setup. (It would probably be best to fit
into the FS Monitor client/server model and use a different daemon
for those virtualized repos, but I don't know enough details to be
sure.)

CC'ing Jonathan Nieder for thoughts on this.

Thanks,
-Stolee
