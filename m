Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0080FC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 13:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJLNXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJLNXs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 09:23:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A406D57C
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:23:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b4so26236015wrs.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nMBXPHu2BQh0g/Dr62BFyeieMs4MvxABQixadjuYiz8=;
        b=GS3sb5zM1GckaPL+zVPbSoXw3e8yLQBf1AwftsPisU+c4Q+TOS5hc/mfo3GWGGUPCj
         e33+0nDqLPPDgsHq5fyHqOBzONYQlRCIp1+9py6vzO/NJUYX8WLwjRjv3zljoF3VGQop
         cOe8TLqkVZC5enDb9SizkO6yL/bUPIVvbLNSlI6lyRNHnG83PtHhM5d4Dj/VygHHfbj2
         gYnAmVNxG7llCqgoSmQ7ocgh62se7849ShuNEKICLUZeEvX7CFTbP+zRAwXGInu9lGXW
         L0C0SSvy8UAEUl0TFUQAYRaavKtnPcbu3BcIseEUgKJscFn/qgQcyQZIs6djwvYuw7W9
         sdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMBXPHu2BQh0g/Dr62BFyeieMs4MvxABQixadjuYiz8=;
        b=XBOiqF83/80wCnf++3u4LFICcHJafehxK7LK6APlBd9+l/bBd/70LuK+SrzuJhhK/9
         QqzlKpCosqin+w8MkqwgmpfmN5pYX+78MZUP+WggIw0oR7FWDInfzIoC9UW3EAsM4QFm
         LwoL0riilwyy1RnlemcEIhnAAk7fRFR5soQ6Z+UyII1ltyqzDDtMAbs/4TV4WkHjc6VJ
         Jeye6eMYjblRxIra9mqyoGZmeDUhEQ/w8Zj3wTkOgaKRmOFhFz4lisIWB+026tzCmbQX
         pQKe1DDATWuVLZkf5NNPOcxuHU9P3sANah4cXS+MEH2xouv4VsLsdCpmHvTBFh8fR++9
         uhNw==
X-Gm-Message-State: ACrzQf08qQ3+Bcl86a8TAo9+Vsubj/hqTQDvwVVIeZiFasbK0SEp8L/c
        1dsly+lijT7p/rQ5lT8ykWU=
X-Google-Smtp-Source: AMsMyM71oh1RFUqgR4iwk4GdPHkWtCS+Zc2oQ0wKm8Rl24GbxdR4T82xUW6sCwC06v7sXxRYM6jGIA==
X-Received: by 2002:a5d:5585:0:b0:22d:f0cd:e3b9 with SMTP id i5-20020a5d5585000000b0022df0cde3b9mr17835417wrv.347.1665581022890;
        Wed, 12 Oct 2022 06:23:42 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id g17-20020a05600c4ed100b003b4ac05a8a4sm2469979wmq.27.2022.10.12.06.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:23:42 -0700 (PDT)
Message-ID: <9b5346b6-157e-b323-1d49-19322793d05d@gmail.com>
Date:   Wed, 12 Oct 2022 14:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 13/22] run-command API: make
 run_process_parallel{,_tr2}() thin wrappers
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
 <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
 <patch-v2-13.22-01e894bed90-20221012T084850Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v2-13.22-01e894bed90-20221012T084850Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2022 10:01, Ævar Arnfjörð Bjarmason wrote:
> -	const struct run_process_parallel_opts opts = {
> -		.processes = processes,
> -
> -		.get_next_task = get_next_task,
> -		.start_failure = start_failure,
> -		.task_finished = task_finished,
> -
> -		.ungroup = run_processes_parallel_ungroup,
> -	};
[...]
> +	const struct run_process_parallel_opts opts = {
> +		.processes = processes,
> +		.ungroup = run_processes_parallel_ungroup,
> +
> +		.get_next_task = get_next_task,
> +		.start_failure = start_failure,
> +		.task_finished = task_finished,
> +	};
> +
> +	run_processes_parallel_1(&opts, pp_cb);
>   }

I complained before that this is moving things around that you added in 
the last commit, but not only are you moving the designated initializer 
added in the last commit you are rearranging it.

Best Wishes

Phillip

