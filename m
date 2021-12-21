Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408EAC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 14:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbhLUOU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 09:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbhLUOU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 09:20:29 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E72CC06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:20:29 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id k21so17875308ioh.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VRr/3Yt+OCL1W5ijMI/X2h/xDvjs46wPVnz8XKwlf5I=;
        b=iBQ/1am9tRymAk6wMTyBbg2AH8bmfE0n96II47AC4+I7MtiZDrHJARtJHor9sCDsUy
         UKZQCNoAjzqtj5F+6/Le1maNIvFkgc7Y5eGLcOXTOAgQrkCbERHfHcs6awPRR9cMrnB+
         dCvP4tFsNGH9Ut128tBKMbcdsfJScH5aIVEUkj3bJuSufFdMxWCvWgkOaBT6p2IQKKt6
         ACslrO0TnoU1QIHGBHdxThTG0QaUpVUI0GLDiga3LaAIMOD4sFnv0kvUKk6xUbv9gygV
         7pb4rjlbhpIOZk/wEJuSCQXCjy30EjrGzDIbN/vyGCvhuu9B4DdWBDkpdCkMpZYCsD1F
         MTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VRr/3Yt+OCL1W5ijMI/X2h/xDvjs46wPVnz8XKwlf5I=;
        b=ISa71coAbDmNliI9CFpNuVH+UZYJD/uhQYAv3/Dwt7FuGKWRwBkOuBi+LlVV4KN6JN
         ezeF3ta7meXcFjnh2Iuk3+/T0er8R4Q/Y6NYjTGpwv3xu0zbsaODlBnjGIH+jBkLZQ0q
         kmKsvnXzv1v1VuB2p/Cj4GCSArWwyq0pifWZ5Aw1uc65X7ZPnj9fzxzly6Q9iWPsLZ89
         PNLDsys/ROK8rzeVL/LTNR51xZXMYCL27vgAJmkaOnQThGFE0MEL4JMCq5S0XuscXrS8
         QfesqHpcVpapwbQpfGoeYJfdyZgsvys2eWQbgxsN/bWNQRon1R1qDhpI4lkY5AQPFNpt
         tm1Q==
X-Gm-Message-State: AOAM533d6EkIm4k+rVS02ZXFTOTFiDfxoNieckBglGLerBL62aJzXAe1
        B4xs1FiNtsmbLwTM/Qpkqi0=
X-Google-Smtp-Source: ABdhPJzZApPP8xi4EpRt+gUO0oDv5HurU+YzdyUcHE+MjY58J0vue1okpnJ0QTo0ECfGPRkE4crzlw==
X-Received: by 2002:a05:6638:378e:: with SMTP id w14mr2038855jal.219.1640096428423;
        Tue, 21 Dec 2021 06:20:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c11c:699d:989:f926? ([2600:1700:e72:80a0:c11c:699d:989:f926])
        by smtp.gmail.com with ESMTPSA id t2sm7184843iob.1.2021.12.21.06.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 06:20:27 -0800 (PST)
Message-ID: <8f62bae5-0026-c2c8-baa0-fd50b8d1668c@gmail.com>
Date:   Tue, 21 Dec 2021 09:20:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 6/9] trace2: add timer events to perf and event target
 formats
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <c5d5ff05e6ca5729993133ce0b6b94af2503808a.1640012469.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <c5d5ff05e6ca5729993133ce0b6b94af2503808a.1640012469.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2021 10:01 AM, Jeff Hostetler via GitGitGadget wrote:
> +`"timer"`::
> +	This event is generated at the end of the program and contains
> +	statistics for a global stopwatch timer.
> ++
> +------------
> +{
> +	"event":"timer",
> +	...
> +	"name":"test",      # timer name
> +	"count":42,         # number of start+stop intervals
> +	"t_total":1.234,    # sum of all intervals (by thread or globally)
> +	"t_min":0.1,        # shortest interval
> +	"t_max":0.9,        # longest interval

Could you specify the units for these t_* entries? I'm guessing seconds
based on the example, but I've seen similar timers using milliseconds
instead so it's best to be super clear here.

> +/*
> + * Stopwatch timer event.  This function writes the previously accumlated

s/accumlated/accumulated/

> + * stopwatch timer values to the event streams.  Unlike other Trace2 API
> + * events, this is decoupled from the data collection.
> + *
> + * This does not take a (file,line) pair because a timer event reports
> + * the cummulative time spend in the timer over a series of intervals

s/cummulative/cumulative/

> + * -- it does not represent a single usage (like region or data events
> + * do).
> + *
> + * The thread name is optional.  If non-null it will override the
> + * value inherited from the caller's TLS CTX.  This allows data
> + * for global timers to be reported without associating it with a
> + * single thread.
> + */
> +typedef void(tr2_tgt_evt_timer_t)(uint64_t us_elapsed_absolute,
> +				  const char *thread_name,
> +				  const char *category,
> +				  const char *timer_name,
> +				  uint64_t interval_count,
> +				  uint64_t us_total_time,
> +				  uint64_t us_min_time,
> +				  uint64_t us_max_time);

> diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
> index 4ce50944298..9b3905b920c 100644
> --- a/trace2/tr2_tgt_event.c
> +++ b/trace2/tr2_tgt_event.c
...
> +static void fn_timer(uint64_t us_elapsed_absolute,

(I was going to complain about the generic name here, but it's static
to the tr2_tgt_event.c file, so that's fine.)

> +		     const char *thread_name,
> +		     const char *category,
> +		     const char *timer_name,
> +		     uint64_t interval_count,
> +		     uint64_t us_total_time,
> +		     uint64_t us_min_time,
> +		     uint64_t us_max_time)
> +{
> +	const char *event_name = "timer";
> +	struct json_writer jw = JSON_WRITER_INIT;
> +	double t_abs = (double)us_elapsed_absolute / 1000000.0;
> +
> +	double t_total = (double)us_total_time / 1000000.0;
> +	double t_min   = (double)us_min_time   / 1000000.0;
> +	double t_max   = (double)us_max_time   / 1000000.0;

Looks like seconds here. At first glance, I thought this large division
might cause some loss of precision. However, the structure of floating
point numbers means we probably don't lose that much. It might be worth
_considering_ using milliseconds (only divide by 1000.0) but I'm
probably just being paranoid here.

Thanks,
-Stolee
