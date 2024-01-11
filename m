Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2930524A3
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm3fbgL2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e552dfa5dso25560585e9.1
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 08:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704992247; x=1705597047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8NGOwiIZF/z0nPqk5yFV97u/xmuG/5BydTasGdzNaVU=;
        b=Mm3fbgL26UiHPc6xhvbQ0YfQ9wEf7dv6+YiNtT0IZDnOOckBNA8LE9nm5vZ+g6kWCN
         VMQy7atWH8geOxr4LPI6nrcCN7M7/j03+oeXOoMXYF2kP2KHswwojgUQonRNiFwl0+9G
         eHD51pXmhiO85rUfQhX2OE+f1apV0iJNQCEy09hiptLtEzENm5lSYvgKNVpD2C+Oh6bH
         nuM3IFj7BZ0KyvM84j+RIy2JUdQOB+YRl16Wtu8fN0yv4R1x/+SCakCUdjUX96AD4fga
         wtFGEcn1xoM3R95UbjAUGkD9Soe7ZG39StjeZH0olyKTzeRFIIDPd1vIsaeZ3rt0+6VZ
         CL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704992247; x=1705597047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NGOwiIZF/z0nPqk5yFV97u/xmuG/5BydTasGdzNaVU=;
        b=d/617/tTBEusFBcztIU4MZ4ag59HFU3Ys/PXeKnMuBioxre25SMUHg9Xm0YDaSjzl1
         iI88hEpH6t/hw25XEUsdpg2yECcn0n5sob4jL/esapqzU894ymQ+Q16VyK1wuKTaaDQb
         4tkLOto+BorJpLm24EugZScZ4WR2LAxka88cpCO81lG356pF99OxxpOphSKrmDjH8i0C
         vS9HoP/tUkU3MK3RwrB+z+5oqzqtj7bVGbX2KtLU++8nGWmejhU/F3cX3tPx26jBzONx
         QTh1/0O3yjHkiUTLNX3faCyE9e3W6mVAaFNmmQCDpHcehKF9ZCBHFNGtd5rzpz58UWjx
         e/TQ==
X-Gm-Message-State: AOJu0Yx7jfJlILQixGK8MKUvl7B2sCDZJ9A5qwpYt2A+4PjgvsdPwN64
	+Yb7TolIzN6RY/6JonqfjNw=
X-Google-Smtp-Source: AGHT+IE5bJIXooIWfFoi48tScTpRVGQEWVktZRfdwa1RSmSmoKvx9sUV2eaZYtVS4sfI4hPe3nVH4g==
X-Received: by 2002:a05:600c:4893:b0:40e:448a:91ff with SMTP id j19-20020a05600c489300b0040e448a91ffmr61316wmp.168.1704992246984;
        Thu, 11 Jan 2024 08:57:26 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b0040d6b91efd9sm6479017wmq.44.2024.01.11.08.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 08:57:26 -0800 (PST)
Message-ID: <1ed0e249-dab9-4cf3-9b76-c8797b97c9c5@gmail.com>
Date: Thu, 11 Jan 2024 16:57:26 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] builtin/revert.c: refactor using an enum for cmd-action
Content-Language: en-US
To: Michael Lohmann <mi.al.lohmann@gmail.com>, git@vger.kernel.org
Cc: Wanja Henze <wanja.hentze@bevuta.com>
References: <20240111080417.59346-1-mi.al.lohmann@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240111080417.59346-1-mi.al.lohmann@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael

On 11/01/2024 08:04, Michael Lohmann wrote:
> This is done to avoid having to keep the char values in sync in
> different places and also to get compiler warnings on non-exhaustive
> switches.

I think this is a reasonable change, thanks for working on it.

> The newly introduced `revert_action`-enum aligns with the
> builtin/rebase.c `action`-enum though the name `revert_action` is chosen
> to better differentiate it from `replay_opts->action` with a different
> function. For rebase the equivalent of the latter is
> `rebase_options->type` and `rebase_options->action` corresponds to the
> `cmd` variable in revert.c.
> 
> In the rebase `action` enum there is the enumeration constant
> `ACTION_NONE` which is not particularly descriptive, since it seems to
> imply that no action should be taken. Instead it signals a start of a
> revert/cherry-pick process, so here `REVERT_ACTION_START` was chosen.

I think ACTION_NONE was intended to covey that the user did not pass one 
of the OPT_CMDMODE() options like "--continue" as there isn't a 
"--start" option. I don't have a strong opinion between "_NONE" and 
"_START".

> +enum revert_action {
> +	REVERT_ACTION_START = 0,
> +	REVERT_ACTION_CONTINUE,
> +	REVERT_ACTION_SKIP,
> +	REVERT_ACTION_ABORT,
> +	REVERT_ACTION_QUIT,
> +};

The "REVERT_" prefix is a bit unfortunate as this is used by cherry-pick 
as well but it does match the filename. As this enum is only used in 
this file I'd be quite happy to drop the "REVERT_" prefix. (I don't 
think we need to go messing with the "action" member of struct 
replay_opts to do that)

>   	/* Check for incompatible command line arguments */
> -	if (cmd) {
> -		char *this_operation;
> -		if (cmd == 'q')
> +	{
> +		char *this_operation = 0;

style note: we use "NULL" rather than "0" when initializing pointers. 
Ideally this would be a "const char *" as we assign string literals but 
that is not a new problem with this patch.

> +		switch (cmd) {
> +		case REVERT_ACTION_START:
> +			break;

I can see the attraction of using an exhaustive switch() here but as we 
don't want to do anything in the _START case it gets a bit messy with 
the extra conditional below. I wonder if we'd be better to replace "if 
(cmd) {" with "if (cmd != REVERT_ACTION_START) {". Alternatively if you 
want to stick with the switch then declaring "this_operation" at the 
beginning of the function would mean you can get rid of the new "{}" block.

> +		case REVERT_ACTION_QUIT:
>   			this_operation = "--quit";
> -		else if (cmd == 'c')
> +			break;
> +		case REVERT_ACTION_CONTINUE:
>   			this_operation = "--continue";
> -		else if (cmd == 's')
> +			break;
> +		case REVERT_ACTION_SKIP:
>   			this_operation = "--skip";
> -		else {
> -			assert(cmd == 'a'); > +			break;
> +		case REVERT_ACTION_ABORT:
>   			this_operation = "--abort";
> +			break;
>   		}
>   
> -		verify_opt_compatible(me, this_operation,
> -				"--no-commit", opts->no_commit,
> -				"--signoff", opts->signoff,
> -				"--mainline", opts->mainline,
> -				"--strategy", opts->strategy ? 1 : 0,
> -				"--strategy-option", opts->xopts.nr ? 1 : 0,
> -				"-x", opts->record_origin,
> -				"--ff", opts->allow_ff,
> -				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
> -				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
> -				NULL);
> +		if (this_operation)

The extra indentation here is unfortunate as some of the lines are 
rather long already. In the current code it is clear that we only call 
verify_opt_compatible() when cmd is non-nul, I think it would be clearer 
to use "if (cmd != REVERT_ACTION_START)" here.

> +			verify_opt_compatible(me, this_operation,
> +					"--no-commit", opts->no_commit,
> +					"--signoff", opts->signoff,
> +					"--mainline", opts->mainline,
> +					"--strategy", opts->strategy ? 1 : 0,
> +					"--strategy-option", opts->xopts.nr ? 1 : 0,
> +					"-x", opts->record_origin,
> +					"--ff", opts->allow_ff,
> +					"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
> +					"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
> +					NULL);
>   	}
 > [...]
> -	if (cmd) {
> -		opts->revs = NULL;
> -	} else {
> +	if (cmd == REVERT_ACTION_START) {

I was momentarily confused by this change but you're reversing the 
conditional. I agree that the result is an improvement.

Best Wishes

Phillip
