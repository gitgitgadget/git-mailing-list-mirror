Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97738B99C
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747124; cv=none; b=N3G9oz0HY4UQiKCLeADSxUad4AO1/rQSi7IsBPjAki/hZ732Q8Pu4Ru73C0suDuSQ1kOGtsmurrHOsTaf1UzdckOqTow2MuQwhOnqQoAvWQuo2zVETlZbTn6MyP3XTJl/nSgW8o/a3Fe+MX8vYjyHG/AZ/8FTCjoLm0yhaPN2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747124; c=relaxed/simple;
	bh=JsFDE/SZLJ11or9jK1/IVx0l/fFHlHpOVHpY0AjF2zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuQg4eerSIeyZp2wBlz4ZrTF4TADd4aCcJIUkI8pXM94/8SQzYHO+Ir5aRPTf/7ri5A0/BRJV0OkzrfNmoSwy+dV6MPrwPpsCYaFNdSsIRFBp64m2a0IB+4Sj/jIQkd1mhO9R7bY4u74xGFhtCSCSEebI4qJ6n+DBcIXDidrewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXQyig41; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXQyig41"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89549b2f538so22791416d6.2
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 10:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770747122; x=1771351922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrKLBU2OpIRHnL+7iwbKlEs4TBYmpVV8zwbGtpVdB+8=;
        b=hXQyig41hm91zAJOoDjMlL5nExCa4yuoLfw8WDHDhaIkyxm5rM03I6CMGMeZGxxLBH
         DBIu2JPhcOY2b+p1WennceI5bW0R+r1eVY/dKV8SZZZs3cL2kg9pnipq0a9LAw7jyiBh
         cotag2LQT2AuStZxsg6LxKR5OsJZyDVfw3u/opQFRttYiBCjbTdrR8B3kEGKwph2P1bH
         CJFxgDqrqmu/kYrGI0rNoksgxGiRAvh/ToQS2CN/vS5Kc3k/2ZaSBA9vmJRqRafQcBfo
         XSOlpa7l+A9v4i9kqHvTDpY/z+KK3cxa45duEc2b2cinGmikTvjB4Xeyk/W0zgYOdWiT
         wAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770747122; x=1771351922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrKLBU2OpIRHnL+7iwbKlEs4TBYmpVV8zwbGtpVdB+8=;
        b=FjHYeDcKpng+EI0R2p0uWhn+NihYFWjBHL6wgtdTt5woiHwkHU0YRmzVUAhzyQS1ld
         FIouBuY9nlujQImIjVWN0uWX1dDA6JDzCJs4FrZUn7yIPbF5N3lsBH8kjKwmzkbi4haT
         4TcDYnfLBFyyb7EH/NgyMNdndFicHw+WwG0ezKLAtIxSoLHs2fSlIKdF8CJ3qHmGZQor
         EeIbKJ547s3w28IoxYOT6VZlk/tdLWezupkdF/UFLAFncENMpCXgufi+erOXyhxklooB
         kFvUvNAikFOjVLPPUF4SgKi3Jty8VLczHW5Igmvj/8JVsl4klEpRNz7do5U92FoHj3XS
         mvNw==
X-Gm-Message-State: AOJu0YyN0Jmd3jD75BvS3A+r1Mi6pntrC6JlHP+eV6yvGhBD6p0CT1RQ
	8GUee5PDkkCmgETac7Th50ZAOSFzf1I52SBqEOHa1B5Jq3qzqI2kmV6w
X-Gm-Gg: AZuq6aIesOjbgJfR4eIeWLI2Jk5rV4yexRoOcq1J2FBXVaurqYHP5F1OCC7QFkSQ/ty
	UJsobBeEScZWImlrB87djEqnqZGuqeJmtFRy2ZyybSCcGGZKacmNiEqv3jpFPJsMxToXOQgrWmI
	9hbgAMI5FsOSmMrvHDEmkxYNeg1iXsoElmeAMQrRr1PNEPbEakTiGopGCgyBTq8DqKs63ZR6f0a
	6u/PMTXpvHUm1sf1El02d+Bew7FULKbwJxqSAezQLXSKgGIsfWYJhpYp/QiXYfn88f3xtKXQIhi
	dYCsoCMe8SYZdDtAMdTBu1yckDdCiKOspwNgq6POPWJQC3+QqhnYg4tDYIp01IjsvORTRctY6mz
	85oI3qSUoGT1mqcdnOMNlzgjAZMVi0wc+nH6xk4w6Lw8nAjl2m6BtiuhRDZXv44AOCkDhn1uOEL
	acfiQx8kqwz+5F0C19RqKn2pclVAVXMdLBof3l6qWQux7z+F+a+2aJY5G1o9XbKx8ewChRMA==
X-Received: by 2002:ad4:5aad:0:b0:894:6d0b:502 with SMTP id 6a1803df08f44-8953cd98884mr246526036d6.59.1770747121750;
        Tue, 10 Feb 2026 10:12:01 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf3c740sm105186846d6.11.2026.02.10.10.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 10:12:01 -0800 (PST)
Message-ID: <91fb7d01-cc6a-47b5-a23a-45b0fb31134a@gmail.com>
Date: Tue, 10 Feb 2026 13:12:00 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] config: allow format_config() to filter
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <d9e04240100afb4188d32c5ce784f189f59348b4.1770698579.git.gitgitgadget@gmail.com>
 <xmqqfr791957.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqfr791957.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/10/2026 12:04 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The format_config() method in builtin/config.c currently only uses
>> git_config_*() methods for parsing. This allows parsing errors to result
>> in die() messages appropriate with keys in the error message.
>>
>> In a future change we will want to use format_config() within 'git
>> config list' to help format the output, including when --type=<X>
>> arguments are provided. When the parsing fails in that case, that
>> key-value pair should be omitted instead of causing a failure across the
>> entire command.
>>
>> This change is formatted in such a way that the if/else-if structure
>> allows the default die_on_error version to appear first and then be
>> followed by the gentle parsing mode immediately afterwards.
>>
>> The only callers right now have die_on_parse set to 1.
> 
> Certainly you meant die-on-parse-errors, not unconditionally die
> when asked to parse ;-).
> 
> I wonder if a "bool gently" like everybody else takes would be
> easier to understand by more developers and readers, though.

'gently' makes a lot more sense.

>> +		if (opts->type == TYPE_INT && die_on_parse) {
>>  			strbuf_addf(buf, "%"PRId64,
>>  				    git_config_int64(key_, value_ ? value_ : "", kvi));
>> +		} else if (opts->type == TYPE_INT) {
>> +			int64_t v;
>> +			int ret = git_parse_int64(value_, &v);
>> +
>> +			if (ret)
>> +				return -1;
>> +
>> +			strbuf_addf(buf, "%"PRId64, v);
>> +		}
> 
> So, this follows the typical layout that was described in the
> proposed log message.  I wonder if it is too much to break the set
> of helper functions further down so that this part of the caller can
> say something like:
> 
> 	switch (opts->type) {
> 	case TYPE_INT:
> 		format_config_int(buf, key_, value_, kvi, gently);
> 		break;
> 
> and similar case arms for other types?

I had a similar feeling that such a refactor would be necessary.

I didn't want to go through that careful work if it wasn't
justified by positive reactions to the RFC. Thanks for calling it
out, and I'll definitely put in that effort if we find this worth
a v2.

Thanks,
-Stolee


