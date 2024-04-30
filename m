Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA87127B70
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471181; cv=none; b=tgVYQ13vAHuqJVVQuplEe4//nxs6QIA1ygS3rG/OWgMZzkw6KdqBSgCk1ezL7TUKRsYAH8nqSi5h77Apb6vguwAGAzpFdfP7RnnmqTMujWHZblZNS6ynQw52fjPDfa1oSFcKdUwXtz+D7/RBEDuzKr9jbvTS0bAbS6nYlwFav7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471181; c=relaxed/simple;
	bh=cVxnTXPlZAfVy8iLfrpT2LCWoGxWi+nZMzergbm/OrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDFK1NdNdI+7am7takqyTsn/Fh6AGbERzNpefCoMopAuPWNzmpC1uXuUW24mykTj8QA7hyOPm170vUG9UlQcB0aLipAfIp20QrW1d3DYSt+bfirswiVDS08SV9HV8uGA29cu6Hoet6raUWr6FVW8IwPxAwENNz4zlcOfKU4lblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkWOCgij; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkWOCgij"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51ae2e37a87so6704152e87.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 02:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714471178; x=1715075978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mr7Iz8vs3kqHaj0/uSoKbRHgPqh8wgnckch5nVmePls=;
        b=KkWOCgijLOtPkv1DOYyjFU5yZ+hgjdjqZysKlQTJYSBn9LrCUn0ZbMpobMoSSnvdT2
         pgfLz4zFdQqNuK2bUHzPYcGFxf/5eDIYY8YMXlc2dUjSeIFgsu5luyosbEEZPnZ/jA+/
         fF5r/viUUoj666kqao+zyQXZ0sLpPqWgSEtwn59/LYwyTrXeXZGbr5JtFxfyI5mstvtZ
         RFH64Qr2xgnisVMH/mmdcvhOnqywHZs7Ga7v3+GqfXuLDuhFRGASRHSnPKjaE2hwyeFV
         bXABfpoVPA7mMYyx86Y9xMuRZjJ22UMgGDExze/ghOeWB4kFtkcIUF6wP1sToL6SXFbB
         6iLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714471178; x=1715075978;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mr7Iz8vs3kqHaj0/uSoKbRHgPqh8wgnckch5nVmePls=;
        b=q9+/5WB9uBNyibQMD3tE7P7Gf3OQfuyr01RWz8Nkh96uhjwo9gcjgBm8b0vPDjG7ku
         HCIQRS4900dqcJuLcrTgTowbOQip8yQTrY7vvtgiAgpJypfCYBIHJTNZjiMlvKdgrF1C
         HVznVNAHUG2PbO7rlA051odINu8XFsF2cdUOz+UObKLBPdVPPHz6J9wtPc9dxFSlMfx8
         qp4UObSTHIGSEkE4bLKeUi0CI5s+OQe59TC9U5ElgvMgBF320XSSO6Q/VD7EzXAKBPkv
         0m3hPiSjkig4Aq+xZzSn7swW+c/NmLTtRezzOqmpJg+NiRa/O/oR+tK4xy5BWIEl+Q+9
         NUtA==
X-Gm-Message-State: AOJu0YwMpnkIOIu8AQ4YaOymIUFRntYZr+lFaAzoDc0BqbszlTzig7om
	384bj/iUGwGMPs9krRD77oHU72khsagVgtfVAGyPmaIgCTB/4CqO
X-Google-Smtp-Source: AGHT+IHG9VCP6ptJbfw7FRzqYqTUvpYIkYNYoTTtErwdJSlt+3cUmx3AlaQI4U1XE2xS2lFt4wRG/A==
X-Received: by 2002:a05:6512:36cf:b0:519:2a88:add6 with SMTP id e15-20020a05651236cf00b005192a88add6mr7437310lfs.55.1714471177779;
        Tue, 30 Apr 2024 02:59:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8e01:d2c6:37ff:fef6:7b1? ([2a0a:ef40:64f:8e01:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id v17-20020a05600c445100b0041c130520f3sm9133917wmn.6.2024.04.30.02.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 02:59:37 -0700 (PDT)
Message-ID: <e9c70778-3414-48ae-8a7d-6b6f0dfaad63@gmail.com>
Date: Tue, 30 Apr 2024 10:59:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] refs: do not label special refs as pseudo refs
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Karthik Nayak <karthik.188@gmail.com>
References: <cover.1714398019.git.ps@pks.im>
 <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
 <e57ed591-5006-453e-bc93-6c53fcab2aec@gmail.com> <ZjCd_drNT6kyjNa6@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ZjCd_drNT6kyjNa6@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 30/04/2024 08:30, Patrick Steinhardt wrote:
> On Mon, Apr 29, 2024 at 04:12:37PM +0100, Phillip Wood wrote:
>
>> This changes the definition to allow pseudorefs to by symbolic refs. When
>> is_pseudoref() was introduced Junio and I had a brief discussion about this
>> restriction and he was not in favor of allowing pseudorefs to be symbolic
>> refs [1].
> 
> So the reason why pseudorefs exist is that some refs behave like a ref
> sometimes, but not always. And in my book that really only applies to
> MERGE_HEAD and FETCH_HEAD, because those contain additional metadata
> that makes them not-a-ref. And for those I very much see that they
> should not ever be a symref.
> 
> But everyhing else living in the root of the ref hierarchy is not
> special in any way, at least not in my opinion. We have never enforced
> that those cannot be symrefs, and it makes our terminology needlessly
> confusing.

I agree HEAD not being a pseudoref and having special refs as well as 
pseudorefs refs is confusing. I do have some sympathy for the argument 
that pseudorefs should not be symbolic refs though as AUTO_MERGE, 
CHERRY_PICK_HEAD, ORIG_HEAD etc. are all pointers to a commit and it 
would be a bug for them to be a symbolic ref. It is unfortunate that in 
the move away from assessing those refs as files we lost the check that 
they are not symbolic refs.

> I think I'm going to reroll this patch series and go down the nuclear
> path that I've hinted at in the cover letter:
> 
>    - Pseudo refs can only be either FETCH_HEAD or MERGE_HEAD.
> 
>    - Refs starting with "refs/" are just plain normal refs.
> 
>    - Refs living in the root of the ref hierarchy need to conform to a
>      set of strict rules, as Peff is starting to enforce in a separate
>      patch series. These are just normal refs, as well, even though we
>      may call them "root ref" in our tooling as they live in the root of
>      the ref hierarchy.

That would certainly be simpler.

> I just don't think that the current state makes sense to anybody. It's
> majorly confusing -- I've spent the last 8 months working in our refs
> code almost exclusively and still forget what's what. How are our users
> expected to understand this?

The current state is confusing but arguably there is a logic to the 
various distinctions - whether those distinctions are useful in practice 
is open to debate though. I wonder how much users really care about 
these distinctions and whether it affects their use of git. I was 
unaware of the distinction between HEAD and pseudorefs until I reviewed 
Karthik's for-each-ref series a couple of months ago and I don't think 
that lack of knowledge had caused me any trouble when using git.

>> Are there any practical implications of the changes in this patch for users
>> running commands like "git log FETCH_HEAD" (I can't think of any off the top
>> of my head but it would be good to have some reassurance on that point in
>> the commit message)
> 
> Not really, no. We have never been doing a good job at enforcing the
> difference between pseudo refs or normal refs anyway. Pseudo refs can be
> symrefs just fine, and our tooling won't complain. The only exception
> where I want us to become stricter is in how we enforce the syntax rules
> for root refs (which is handled by Peff in a separate patch series), and
> that we start to not treat FETCH_HEAD and MERGE_HEAD as proper refs.
> They should still resolve when you ask git-rev-parse(1), but when you
> iterate through refs they should not be surfaced as they _aren't_ refs.

That's good

Thanks

Phillip

