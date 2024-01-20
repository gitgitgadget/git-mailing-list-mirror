Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D30FBF0
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705760593; cv=none; b=G+gUXprl2yrFN/Ae7cI9rCLzBFjvklwtvs+B2aMTgPZUEokt3R5JmtTaoTTg/s3EkJuFjTlfEd+Qo3s6nN4fVVWQUAJ5XLdxZrjx4BTwdR28hWuaGOcAf/uqMyWoGPVqy/lEfIMImee+TZ8y9mOy5P3YdOJ9A5FRH+zkESWim6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705760593; c=relaxed/simple;
	bh=QkRc2o5CkIoE2D5AYta4UVbEgk81Wjux7Kt6Bn8hAGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HguemlYf6Wv4tiBGvW7k2zK9fbISkUMtf4dXsd9dtMW+9HFBf89vB18QF8FVltc/Wwcz49hUCbYrEtRVlXCA8RBLsRqm33BJEeSQ3xPfusWVtKznxV2Vl2lUTC1HVid2I7sblsd4OHZPhJtKJFFjflFmTO78ZuuBNUQ9j1fXi2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSPHfEjf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSPHfEjf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ea6304f19so3274795e9.2
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 06:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705760590; x=1706365390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=irzo+a5JXOAzYJH83UhWr3fA+SCNUz/keeVDw7BJ/Do=;
        b=YSPHfEjfxFfOBaRS8iWSMBznn/ECA7CosmwTizxASFJgcwqgRexc1qWaJRqkz6RFo/
         GeQKLp7YbNFUCODtchyGf9ZNRHIeshW7lzziubuBz4/5yHFMNSvEKcZcov96jbbk03lH
         84a4883RT5ZmzWQXKOj8RYtMbwIiFI7c0b7Lo8iEtgN2ms2nGxhyU6MfsMxufohw3VDM
         0VO05nqOXcnffnoyUGUIz1e+giKsQO4Gh/hf2Vzij6YEBStU96Axf9C2msqOSfmRRetg
         F+3Pm2YEiYVZgyiS9sPZqqN8jsDrNGJo3JH7rZ1D2+hXgV27kXTGuWZDKorlRAJgozdh
         5eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705760590; x=1706365390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irzo+a5JXOAzYJH83UhWr3fA+SCNUz/keeVDw7BJ/Do=;
        b=QS6tYEnqip9jHYgb2TGBmP5y7f3xvElx9yBHL1kIG/KBEg4037ndyGwpgSzhH2NV3s
         Zxfi9kSB2zO8opbfplG3pWrBFF5L890fMfYnuoyQC6JUJwrOuf9LKlbkHcREZnSvccbu
         wPQlFktnJdfXRXOVwotk0nnSx+YiwpO0YNrjH7b0xloznLNZtPsZ5cu7qWnf7jiZidnQ
         S8+7Hb05phiKr30sxIP7ffjtAiV2z1xt/xQ+h+fw+OMgLD88BebI47i4o8mUnq0DFy+9
         I/PQp1ECPObZBBYE1Hs3vq1DDpE7Bb98KPQfyObCfBY7/Ko89nhpemMB1r3OsL1w9/pe
         9l7Q==
X-Gm-Message-State: AOJu0YxDncgMZqAXpsjH7x9FfSddQTxHOWx/PZelzSCH5J52EDVLIhj4
	OBlSczgQsnIRfbak6ABsG+Td+jnVN8sYleJXakjdGFIkxRqaVKbqzGI5fX1q
X-Google-Smtp-Source: AGHT+IGEK9fN5pI4dW5N+Qr8fDLkwckSFQqtr2pn5jvL93AF6b7wa5cCG9WJemor7Dzw5AJYRDjzKw==
X-Received: by 2002:a05:600c:a02:b0:40e:8d72:ddd9 with SMTP id z2-20020a05600c0a0200b0040e8d72ddd9mr1065308wmp.95.1705760589896;
        Sat, 20 Jan 2024 06:23:09 -0800 (PST)
Received: from [192.168.1.101] ([84.64.64.237])
        by smtp.googlemail.com with ESMTPSA id l34-20020a05600c1d2200b0040e89ade84bsm12283335wms.4.2024.01.20.06.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 06:23:09 -0800 (PST)
Message-ID: <611378dc-dfe7-446b-803d-ee933b50fdbf@gmail.com>
Date: Sat, 20 Jan 2024 14:23:09 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] tests: move t0009-prio-queue.sh to the new unit
 testing framework
Content-Language: en-US
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
 Chandra Pratap <chandrapratap376@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <pull.1642.v2.git.1705220304781.gitgitgadget@gmail.com>
 <pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2024 14:38, Chandra Pratap via GitGitGadget wrote:
> From: Chandra Pratap <chandrapratap3519@gmail.com>
> 
> t/t0009-prio-queue.sh along with t/helper/test-prio-queue.c unit
> tests Git's implementation of a priority queue. Migrate the
> test over to the new unit testing framework to simplify debugging
> and reduce test run-time. Refactor the required logic and add
> a new test case in addition to porting over the original ones in
> shell.

Thanks for working on this, it is good to see people exploring the unit 
test framework. I agree with the points that Junio and Peff have already 
made, I've got a couple of additional comments below.

 > [...]
> +static int test_prio_queue(int *input, int *result)

This function does not need to return a value.

> +{
> +	struct prio_queue pq = { intcmp };
> +	int i = 0;
> +
> +	while (*input) {

I agree with Junio that a for() loop would be better here, but I think 
that rather than testing for '0' we should just pass the length of the 
input array to this function.

> +		int *val = input++;
> +		void *peek, *get;
> +		switch(*val) {
> +			case GET:
> +				peek = prio_queue_peek(&pq);
> +				get = prio_queue_get(&pq);
> +				if (peek != get)
> +					BUG("peek and get results don't match");

If possible avoid calling BUG() in unit test code as it aborts the whole 
test program, not just the current test. You can use check() and return 
early instead

	if (!check(peek, !=, get))
		return;

> +				result[i++] = show(get);

I agree with Peff that it would be safer just to use check_int() here. 
If you switch to a for loop with an index you can also print the current 
index with

	test_msg("index %d", i);

Which will help diagnose which item in the queue is failing.

Alternatively we could grow result dynamically using ALLOC_GROW() and 
add a function to compare two arrays of integers. Such a function should 
take the two lengths, one for each array.

Best Wishes

Phillip

