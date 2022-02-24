Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4727C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 15:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiBXPGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbiBXPGM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 10:06:12 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77AE18DA97
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:05:42 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id z7so2810017oid.4
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5CNkRAg9DJw84c7bLPNA3hWxAkbrXH0WE0Erk5tY8EU=;
        b=Rh4niomY+8SA+Bg39Cshj3IEYYtFl0ncyreqEliGd40L7xRyDVjKId3lTP87dwx604
         TFk6ozTv8VuJpJV0upwpp/RhaZ3uKDl/trK4MP/lgpIUsPvdD24wIRk3u/OvYodfWVS1
         vw2RdKwu7RlgT8wJ3VuUFCG9OAEdL2kDy6tpxtTd4CEieujDP2ldO6ku85mGi9gVFSAQ
         cvfAPuF+1cpzuc8PVMsfGBgjxLDDjp90M+Kp6Jkaqy+/uQ9cQZaVfvJts/s9mIFxoMRg
         eNk6dgtRDj32T6vuHiszCliPp+zNXxI9QtQYyWa8sCWOoS7LXPVc2nbaXVN45Ql+elwN
         gouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5CNkRAg9DJw84c7bLPNA3hWxAkbrXH0WE0Erk5tY8EU=;
        b=owTR/Umshj/8vLocAgN9ephGp4HxxRL6qD/ESh07UCJR1EwbKscyb91LrwDcbJbpj0
         1ic6ceinW0O0GpsFVvuczG0/idQmrMO9uPWiIK9td7ed/rJV0VgUJ84AF2IxsDt2rMbY
         XXbc/jBBPX6DVn24hBdZYBGz4OTv8bSdFeUmNEiAy/2nGz+UQ/CquaCrk25FhjfsqHrM
         zj9dm5cJq6NS3mRwFD4Uw9PR4dB4ke4nkJrenhOv1CN9JKgawiDkkebkTmqgU6pvMZgY
         pbx/EIz9xrH5Jd8KoHlvydjpWSaylQPj++b9/D61zR73JHmNev81H2692d81NZDT9Bma
         MzjQ==
X-Gm-Message-State: AOAM532w/gU4hPQs6DtwxTTif7S074vJlbLTyUxr8Ia1RUbt1bEdpeFs
        LnW5rE590O6ByrvO2HQitp28
X-Google-Smtp-Source: ABdhPJxERA7D8hNeteZwty79rrpc7qQWDMucGRK0c4NTi4q1uCZ/AADREIy0vPD8WhkkJzRc6wZjWg==
X-Received: by 2002:a05:6808:1904:b0:2d5:80d:b7eb with SMTP id bf4-20020a056808190400b002d5080db7ebmr7584711oib.321.1645715141735;
        Thu, 24 Feb 2022 07:05:41 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m11sm1633769oiw.3.2022.02.24.07.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 07:05:41 -0800 (PST)
Message-ID: <b459111d-a536-b4d7-44d5-7f5aeb9ffb08@github.com>
Date:   Thu, 24 Feb 2022 10:05:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 06/23] fsmonitor-settings: stub in platform-specific
 incompatibility checking
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <4715677f85ff3f47b437f82e2b82a8b5dd371c99.1644940773.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <4715677f85ff3f47b437f82e2b82a8b5dd371c99.1644940773.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Extend generic incompatibility checkout with platform-specific
> mechanism.  Stub in Win32 version.
> 
> In the existing fsmonitor-settings code we have a way to mark
> types of repos as incompatible with fsmonitor (whether via the
> hook and ipc APIs).  For example, we do this for bare repos,
> since there are no files to watch.
> 
> Extend this exclusion mechanism for platfor-specific reasons.

s/platfor-specific/platform-specific/

> +# If your platform has os-specific ways to tell if a repo is incompatible with
> +# fsmonitor (whether the hook or ipc daemon version), set FSMONITOR_OS_SETTINGS
> +# to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
> +# that implements the `fsm_os_settings__*()` routines.

nit: It's just a comment, but I think "OS" and "IPC" should probably
be capitalized.

> +#ifdef HAVE_FSMONITOR_OS_SETTINGS
> +	{
> +		enum fsmonitor_reason reason;
> +
> +		reason = fsm_os__incompatible(r);
> +		if (reason != FSMONITOR_REASON_ZERO) {

A naming nit about FSMONITOR_REASON_ZERO. It seems named ZERO
on purpose so a non-zero reason signals incompatibility. That
would mean you could use

		if (reason)

here. Alternatively, FSMONITOR_REASON_COMPATIBLE would signal
the meaning better here:

		if (reason != FSMONITOR_REASON_COMPATIBLE)

> +			set_incompatible(r, reason);
> +			return 1;
> +		}

Thanks,
-Stolee
