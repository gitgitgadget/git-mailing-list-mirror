Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB59155C97
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895906; cv=none; b=ANYYrZwCemSPQEdfrFDMc4Nans0A0uEKQSZI/8Srd0LTvGBpo6RALe6gT8ipKyk6COjJr1VqUblX2dPKdRm6G0MBtHiWn1qyHR5wJ2mDSLv3sScUvv4k3ziUetEyaRORUc8R3ih+gFZvN9fzqQMlsDAEvsnw1UkCdTZFT44+gaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895906; c=relaxed/simple;
	bh=Q6Vl9QeI4CaR/e4OEhfL9Hs1ArjQoRnWFHu91mY2xnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gByUwdN+zI1MvrECSASE4rl3X4apEyKgL6bWZEq8g4LJnNKYrUs8jxaIVzWjXppaiQEjnk/j4S2rfLy0SUpe33fpyvJLCQqKXF1Zjk5+dRTiYjMAWDN3/RWaFccJtLMRZHe4CFO+GGYpbzGP0qZFIbcZzqHCr0uT/qheW+Z7IL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDKKy1Cm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDKKy1Cm"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so2300109f8f.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758895903; x=1759500703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GrJnr3VIAm2K6MUfnZNcDYeRczMAHQeBtCWgMqw+KoM=;
        b=FDKKy1CmxRwOuX0BkA/O7Sw9v/CFaopkz6zlV7NK4HGJsBCjpC4CEOfyfZUtgpOI6I
         RCbH+2+qHv+EsjJW9SsPSsU8fHA+lko35Kcy/sbNGgfMEibflpvI/tOpZMDsLeovXMmz
         9uJ+Hn35ChGqKIWWzAcmr77HjWxSG/BIj5T+v+Q2LU6U1uHtMpkjukff8OJyWlAZGzH5
         OdY/RpLKb0sCkCl2tzX3/s5rOJL0CvZGBfRt/hxY849J7LUwyGrqYuo3VLpx5swr1kmp
         edLAUAu5gSFlV9ojm8qchz5BvN14EYnqZ7eKw4lYK5SG4zCcKd658QmBazuBNQYyLz0j
         K7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758895903; x=1759500703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrJnr3VIAm2K6MUfnZNcDYeRczMAHQeBtCWgMqw+KoM=;
        b=EHJgBf37VlD3jCxMj418GR1pigZ1PzZ1DkQLpRLlAW3IuFEGs1Db+pUJkwOQs0WEzR
         bKjWe6UzIT+D5wWxN9Hj18b61BdKOIkMw2gDJNS4gz7BfCnNo+4zI+pscnolZoIMsLrf
         ZlcH7g1x174dhTtJwJcnR7+el7FCbIhfp8n9zsUQoBfC1351o7niOC8hRhD9hG5OiXs2
         kWKFyC31Vj+UoTguN+TXSS8TR1EasSmz+SCarNLpRYSiq79aazkRbNtIJufTgPCMQFMt
         g5Q1V1ZWX6BzIRpSI3KFpDMlsLtCDD4KJRJ7k7qkHVfUSpYXCQXd6VAxB7JNi1KFZGoE
         biOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7I1Zqu7NWyhuaRuCxvxCol9bdDdzWTGjNiXXxPdQm9cvFNLFPZhTJTMI32+0SrulQSHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBayHiSB7eiJ8ayFA0SfhLsGntyujl9aZ8m1NCpdrAGYIwh9wa
	aN9aJKnL/fXfCWdCtRPXUikymMf5YJJftinugeemawRjkk4XAjygYiZa
X-Gm-Gg: ASbGncvYbJoLzcgbO/hlN9pyobR+8+tL7fDvFepjD028cxLgSGpxO+6rDkExqveD014
	1qnKklKIKy4acQ83Ipu7bbJtf1Dv2s74qe2fwe0br+DfUwRysAjN4oheFoJOOcH3bWD+BjEEHvs
	ycg38RtJTbmoVo1j0oXNHgaE/qj3jYiWRR0bu0pVuMatfcNQgBv6f/GekKXJuNDolmveRYmOQjH
	8345PX7ebDGkgQwyd2sRFdkH6WJP7E80aYN6BdGaWuUnzM3ELKzwgqYVYarlU6gV+yrNpwrgoj3
	2n1ra7FyToqHM6ps6leV2YZ/O70db8RUkPFepnlInr/d50QhTCAMwE2E4METTHRdFOGxk1LCDEC
	7L14IIW9qI8WYO7TxqGomJhDemu2K6/IsDQos+oyKQBrxov7746mIZGuNJ0/ILBWfrcMI/uc0FI
	g=
X-Google-Smtp-Source: AGHT+IFOuc3iDxgJNB8yzkq6t2SPBYxQZKh0kB9i1RhgF1f6lut19qLo90xuQqoIRkfEYqo41bHS4A==
X-Received: by 2002:a05:6000:2885:b0:407:4928:ac82 with SMTP id ffacd0b85a97d-40e4accc857mr7057959f8f.53.1758895902953;
        Fri, 26 Sep 2025 07:11:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603381sm7810062f8f.31.2025.09.26.07.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 07:11:42 -0700 (PDT)
Message-ID: <1f942894-9393-4b5c-8d7f-2d0aaad594f1@gmail.com>
Date: Fri, 26 Sep 2025 15:11:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 04/10] transport: convert pre-push hook to hook.h
To: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
 Rodrigo Damazio Bovendorp <rdamazio@google.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-5-adrian.ratiu@collabora.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250925125352.1728840-5-adrian.ratiu@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adrian

On 25/09/2025 13:53, Adrian Ratiu wrote:
>   
> -static int run_pre_push_hook(struct transport *transport,
> -			     struct ref *remote_refs)
> +static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
>   {
> -	int ret = 0, x;
> -	struct ref *r;
> -	struct child_process proc = CHILD_PROCESS_INIT;
> -	struct strbuf buf;
> -	const char *hook_path = find_hook(the_repository, "pre-push");
> -
> -	if (!hook_path)
> -		return 0;
> +	struct hook_cb_data *hook_cb = pp_cb;
> +	struct ref *r = hook_cb->options->feed_pipe_ctx;
>   
> -	strvec_push(&proc.args, hook_path);
> -	strvec_push(&proc.args, transport->remote->name);
> -	strvec_push(&proc.args, transport->url);
> +	if (r) {
> +		struct strbuf buf = STRBUF_INIT;

If we passed the strbuf in as part of the context and called 
strbuf_reset() before using it each time we'd avoid allocating a new 
buffer for each ref just as the current code does.

Thanks

Phillip

> +		int ret = 0;
> +		hook_cb->options->feed_pipe_ctx = r->next;
>   
> -	proc.in = -1;
> -	proc.trace2_hook_name = "pre-push";
> +		if (!r->peer_ref) return 0;
> +		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) return 0;
> +		if (r->status == REF_STATUS_REJECT_STALE) return 0;
> +		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) return 0;
> +		if (r->status == REF_STATUS_UPTODATE) return 0;
>   
> -	if (start_command(&proc)) {
> -		finish_command(&proc);
> -		return -1;
> -	}
> +		strbuf_addf(&buf, "%s %s %s %s\n",
> +			    r->peer_ref->name, oid_to_hex(&r->new_oid),
> +			    r->name, oid_to_hex(&r->old_oid));
>   
> -	sigchain_push(SIGPIPE, SIG_IGN);
> +		ret = write_in_full(hook_stdin_fd, buf.buf, buf.len);
>   
> -	strbuf_init(&buf, 256);
> +		strbuf_release(&buf);
>   
> -	for (r = remote_refs; r; r = r->next) {
> -		if (!r->peer_ref) continue;
> -		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
> -		if (r->status == REF_STATUS_REJECT_STALE) continue;
> -		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
> -		if (r->status == REF_STATUS_UPTODATE) continue;
> +		/* We do not mind if a hook does not read all refs. */
> +		if (ret < 0 && errno != EPIPE)
> +			return ret;
>   
> -		strbuf_reset(&buf);
> -		strbuf_addf( &buf, "%s %s %s %s\n",
> -			 r->peer_ref->name, oid_to_hex(&r->new_oid),
> -			 r->name, oid_to_hex(&r->old_oid));
> -
> -		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
> -			/* We do not mind if a hook does not read all refs. */
> -			if (errno != EPIPE)
> -				ret = -1;
> -			break;
> -		}
> +		return 0;
>   	}
>   
> -	strbuf_release(&buf);
> +	return 1; /* we ran out of refs: no more input to feed */
> +}
>   
> -	x = close(proc.in);
> -	if (!ret)
> -		ret = x;
> +static int run_pre_push_hook(struct transport *transport,
> +			     struct ref *remote_refs)
> +{
> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>   
> -	sigchain_pop(SIGPIPE);
> +	strvec_push(&opt.args, transport->remote->name);
> +	strvec_push(&opt.args, transport->url);
>   
> -	x = finish_command(&proc);
> -	if (!ret)
> -		ret = x;
> +	opt.feed_pipe = pre_push_hook_feed_stdin;
> +	opt.feed_pipe_ctx = remote_refs;
>   
> -	return ret;
> +	return run_hooks_opt(the_repository, "pre-push", &opt);
>   }
>   
>   int transport_push(struct repository *r,

