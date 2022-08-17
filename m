Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26412C28B2B
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 14:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbiHQOkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 10:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbiHQOkI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 10:40:08 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380B774372
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 07:39:32 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id a13so3440938ild.3
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 07:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jWhrzTZbcBWbFWc1qb/ig4RbrlFuB/RJecXPiafhVJI=;
        b=RJilWWGYFWBQhUJcJt65pVQku7MAOYM/UaWu+z9+tcIAjcql9eIb2AIXsNhG0AKiXM
         krpASZC6AkC28OFi/VeKPkxnBFjYcHAAlcmWNamMIKC6Kv7Uw+lWZo0anjnO3jInV4vW
         EZRTi0opNgtXiC+0236FBRGhW/YgzD8PQ9TJZkknp/MN3kDqnYbcdkEh0T7pRVYNpaGc
         rxSKbmV/7hNn8mVfSELz2vIlCV0Jm2oMO/Vwkip6cCn1fWvryJpiSYCTKmYhsOSBqN39
         0inBANTkqXMKa/84fnX1cA+3OF2Q2Uv1DUYcI7bb1eA301rZbRHs7wmcBMkKJKc06k42
         yiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jWhrzTZbcBWbFWc1qb/ig4RbrlFuB/RJecXPiafhVJI=;
        b=b2tA2Yx+n2vUkGjeQDO9tQKeDJbJgoJ8BAi8p9hZqTYxJQDB4J978mm0EN6drexBNA
         HUtfXaDjuiWJB/YYJG7w07u0R0W9sOKTP+gx30IYcRQEVd/b1AJ5OtkPo69tSRQUFmFw
         +8iKJe0ofmRM4WqjJWeiF9k4ymWg1wVTVc5iir+VhQFXts3zV7Ia8UdgYL+gi0vo6bNP
         qGuzbR0FGzvff6ZgVOFcXsrA/FLyx6+6+SlZi7+YAJnxLShwj2jnLOesFccsqaTj6wb6
         UoNvPVJVw9tmpvO167TnSUN3eqS8HI51BhdQ7zZK/0LQtl2xjgT01TDj6kGskBxfaoCl
         aaNw==
X-Gm-Message-State: ACgBeo0yoCp86baMJ27oEEMMQgd0iSJqx0n+MJlaPfRz6mt2H07/F6AS
        JDyo21/HWIRYRytgNbg8pxI/
X-Google-Smtp-Source: AA6agR4ry6LJN37GzyZ5rMp3sVoZnB7sKr0RQGBrhcf30g2H+l0x7NjJTga6Q4QUq6EWVz8/xw659g==
X-Received: by 2002:a05:6e02:16cf:b0:2e7:1bfd:2bd0 with SMTP id 15-20020a056e0216cf00b002e71bfd2bd0mr2743664ilx.319.1660747171439;
        Wed, 17 Aug 2022 07:39:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f8cc:7049:fd75:5ebd? ([2600:1700:e72:80a0:f8cc:7049:fd75:5ebd])
        by smtp.gmail.com with ESMTPSA id m8-20020a924b08000000b002e8cae157adsm575150ilg.2.2022.08.17.07.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:39:31 -0700 (PDT)
Message-ID: <2cbbd732-b9e7-fe8b-9c77-f86a856d06c7@github.com>
Date:   Wed, 17 Aug 2022 10:39:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 4/5] scalar unregister: stop FSMonitor daemon
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
 <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
 <fc4aa1fde31fa0726cde2c1d4e41f3f140fff6f6.1660694290.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <fc4aa1fde31fa0726cde2c1d4e41f3f140fff6f6.1660694290.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/16/2022 7:58 PM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Especially on Windows, we will need to stop that daemon, just in case
> that the directory needs to be removed (the daemon would otherwise hold
> a handle to that directory, preventing it from being deleted).

> +static int stop_fsmonitor_daemon(void)
> +{
> +	assert(fsmonitor_ipc__is_supported());
> +
> +	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
> +		return run_git("fsmonitor--daemon", "stop", NULL);
> +
> +	return 0;
> +}
> +
>  static int register_dir(void)
>  {
>  	if (add_or_remove_enlistment(1))
> @@ -281,6 +291,9 @@ static int unregister_dir(void)
>  	if (add_or_remove_enlistment(0))
>  		res = error(_("could not remove enlistment"));
>  
> +	if (fsmonitor_ipc__is_supported() && stop_fsmonitor_daemon() < 0)
> +		res = error(_("could not stop the FSMonitor daemon"));
> +

One thing that is interesting about 'scalar unregister' is that it does
not change config values. At that point, we don't know which config values
are valuable to keep or not because the user may have set them before
'scalar register', or otherwise liked the config options.

Here, the reason to stop the daemon is so we unlock the ability to delete
the directory on Windows.

Should this become part of cmd_delete() instead of unregister_dir()? Or,
do we think that users would opt to run 'scalar unregister' before trying
to delete their directory manually?

Thanks,
-Stolee
