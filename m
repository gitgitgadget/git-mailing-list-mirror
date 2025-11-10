Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346EE2EA755
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786468; cv=none; b=BiyJOI4ulW/aommfE2JcW/O+zi1LeZ6ox001xioWC+dTNw2fdHQAh9zt/56EyM+mDp+rWp8JNMa9NrHE+Fx7OG/Dytecj10/nMslqtoErOFGo2BTdEXgAH7JUtUIw0ACR0guIs6f1MfCoejFQTBAWpf26iej34EVlL2DV9dBau4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786468; c=relaxed/simple;
	bh=DQT6os0Ezq7cY1+JbVsRnlO9HsaohucjBZd0sgYY/PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=pCVxZTHFTadGRwBd4GA/FXFfrnr8mMHupaGB7xxuAO5Naj0JVEoAJDUZjX+LBsgxgx2c+RbBp83ysaDUz3NXShWt+lFOEXksSQMNhX5Nrycnt0exhYNzrMAvA7Rt6HZXGpM09tGluAK2T5nJ1NcAfUWaGX1U8AlZJULhSPRxl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1vwo6t7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1vwo6t7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477775d3728so15172585e9.2
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 06:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786464; x=1763391264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qiQ6CP1l/hgorpMfnVGC4nldKmilQWfovSg5NDhA114=;
        b=Q1vwo6t7WlNnaxbgCzLP7Sf+rbaGu82invK0jwt7/eOmN6/zYASiJ0wudGTXTfqFho
         QZ3lkXykgpoIM/gzFLSfzdoN/I8A5Xg3NF6yke+1BIEDHmbKlykqmX4v302AXOlLzUVF
         6laf71GBdCSNCrKUn3CCK1EgEU8K2L3nqcNgCoB5SeCsjDifuggiCZP623O8r6uoj73U
         UN3yrJNZhOUgLPJXeaQk+tFYh8RNhsp1RItA0aI2n87g/7F5IKNo83ghrTePSjwuEEry
         aKYGElCqEC6Txee3VFP8PNyFBDqgNE/l6W9U2l5hoaZlDIp63gkSrGlbDe0mWAQNRKzZ
         R6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786464; x=1763391264;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiQ6CP1l/hgorpMfnVGC4nldKmilQWfovSg5NDhA114=;
        b=RImGyv8tDLtDtPf3mZ+8h4j7vWVhM9eiB4kkopAysCq0pTvMmpMSf4z1KMNSVqIjOv
         AVsIQWcPEzK/3JRY7iaTY6YFQt9yaapqxSJ7URYkyRdZ/8Eg7uWaPlVdbQIMOmA2ZCXq
         n2wZeGBbCbH7SoL5KI37zPsLK+MbhxiOcRtQDqHEeexOE2dM5wBarYkHsGmnvSZQwXaG
         +e2vTQ04jlGBisG9NoOE9vx4bsAVomBtIagwSe6gNNES/wXIdaw3BLtJsB3KJhy6y3Gf
         /d2hF4jrMP/5oSc/G3A0VQuTQWYIQpkQfu2oB6IUkhCTvz6aER0t1JdrUBOojt/1LdKd
         0lRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKoKQ21rOK621ynoO4eGqRfYy1x4ngdxa/BNUaFFD13HSXFKqIRwR5wUAJQtAfWM6qPyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJvL3C7lrapH/EnpzdZOiOSaSqkyRCUrJWbRlgy6Yj/t7iUi0S
	ZrRRG7TyiJDxmPlV6sw0AKZ73udmAMJsBRj/kDQ9FHAo7qDEkbA/Mb8A
X-Gm-Gg: ASbGncsG3IrL7qZY82EFnxJkWqjfUdfsyMZU4qu/TGQKcuB4qo6U0nTNTjsZNd0kAnM
	/FDHQg09UJbZndWn6SEpKpOmEGN1s9psWFYpVUWKYBE7n7QZlGElGxql3rlJKr1GKpJA1oMdkMD
	z3lXArAk1o+68b2lzN8AQyORykwo4dx1KrBHQP03LAINwxlB/xXwP/ZXKrjgZFbU08h106miP1w
	6Yambm+lymtfsrBxtEo2vDG01XDPSRJoEiVPnTNUxHA2J4J6gKUMK6Wi03Bwki9oyMOPWu+mNJ6
	IaUBfZMIQSjt7MxzA7nEt829Z/GrKEzNaxirRJoxSdM7uamDyKFWA5sB+1bOH/q6s4mOLHON5Fm
	/atNsVTIcEH+Ipftjal4Z2vHb39Zj3OtH7cY+ighb1msX9/FqGZeoE5LhqCTsFD9gIVjBDI7BZA
	4/0YAK4eo0VPb44Fdht46PaqWA9dcpHGqpk9UCDYlAyTSuf1jESNjC8sxNikFUISo=
X-Google-Smtp-Source: AGHT+IHFdU73VJUmlfrRtigHSAEkKsAYvE93nL6Z4wSMUzQICB1CJcZ6fvcVtH/jlIPxrJIAOtnrew==
X-Received: by 2002:a05:600c:1d1c:b0:471:115e:624b with SMTP id 5b1f17b1804b1-4777323ec6dmr68284155e9.17.1762786464336;
        Mon, 10 Nov 2025 06:54:24 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47774d3557csm135787995e9.8.2025.11.10.06.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:54:23 -0800 (PST)
Message-ID: <c41f3c65-d7ef-4e73-a1e0-03540df0b212@gmail.com>
Date: Mon, 10 Nov 2025 14:54:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 04/12] diff: fix incorrect counting of line numbers
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251104020928.582199-5-gitster@pobox.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: Patrick Steinhardt <ps@pks.im>
In-Reply-To: <20251104020928.582199-5-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2025 02:09, Junio C Hamano wrote:
> The "\ No newline at the end of the file" can come after any of the
> "-" (deleted preimage line), " " (unchanged line), or "+" (added
> postimage line).  Incrementing only the preimage line number upon
> seeing it does not make any sense.
> 
> We can keep track of what the previous line was, and increment
> lno_in_{pre,post}image variables properly, like this patch does.  I
> do not think it matters, as these numbers are used only to compare
> them with blank_at_eof_in_{pre,post}image to issue the warning every
> time we see an added line, but by definition, after we see "\ No
> newline at the end of the file" for an added line, we will not see
> an added line for the file.
> 
> Keeping track of what the last line was (in other words, "is it that
> the file used to end in an incomplete line?  The file ends in an
> incomplete line after the change?  Both the file before and after
> the change ends in an incomplete line that did not change?") will be
> independently useful.

The "\ No newline at end of file" line is an annotation on the previous 
line in the diff so why are we incrementing any {pre,post}image line 
numbers here?

Thanks

Phillip

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   diff.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/diff.c b/diff.c
> index b9ef8550cc..e73320dfb1 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -601,6 +601,7 @@ struct emit_callback {
>   	int blank_at_eof_in_postimage;
>   	int lno_in_preimage;
>   	int lno_in_postimage;
> +	int last_line_kind;
>   	const char **label_path;
>   	struct diff_words_data *diff_words;
>   	struct diff_options *opt;
> @@ -2426,13 +2427,28 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
>   		break;
>   	case '\\':
>   		/* incomplete line at the end */
> -		ecbdata->lno_in_preimage++;
> +		switch (ecbdata->last_line_kind) {
> +		case '+':
> +			ecbdata->lno_in_postimage++;
> +			break;
> +		case '-':
> +			ecbdata->lno_in_preimage++;
> +			break;
> +		case ' ':
> +			ecbdata->lno_in_preimage++;
> +			ecbdata->lno_in_postimage++;
> +			break;
> +		default:
> +			BUG("fn_out_consume: '\\No newline' after unknown line (%c)",
> +			    ecbdata->last_line_kind);
> +		}
>   		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
>   				 line, len, 0);
>   		break;
>   	default:
>   		BUG("fn_out_consume: unknown line '%s'", line);
>   	}
> +	ecbdata->last_line_kind = line[0];
>   	return 0;
>   }
>   

