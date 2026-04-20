Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F90C2D7DDD
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685281; cv=none; b=NEG5tJu2lzt0spFujeSQJLVxInjA2SzXrDOp/RenYe7pQ39a58lJVgLm1LkQZDZOuPg2mX2ELstBfXODuiBrhgQkBkk87Atwc3j/FBD01uXVsG96zMqTuS3YnYiVXti+25L0lPUW5OCr5hFpAzp3wZDhOIK73I1DfXcPubPVRl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685281; c=relaxed/simple;
	bh=nj2XcsdSrwBRELcvq9v+g8+njKmwz6uKoL/7M9Skt40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HU2B62sfMEv8k5p/nz3nVa4dvFucg6ED5OeIKbbplgIdoL/BHJtZEvMokJacOaekH1gJKYdIViZC1JOsK2gaE1M6hxvshLjGT6LvkJkBjfogMKi7+pGU9MORQrb8hAC4Yk0qPBu7+0fchPSpM2sbZshXuozDoT354QgT6hfaTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE7huyjH; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE7huyjH"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d7e7f48499so338357785a.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 04:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776685279; x=1777290079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUfnQP3wRHi9IoQNU4qVb5gx8JYHMlzrKLP0ObK2D4k=;
        b=gE7huyjHRU2oso+IX+/PQzXLYdzER29BQoJccwVdGdrfNju9/0zAZuSNQZGbjfYNll
         AHAc8XyHfU35ZMSm3de4Az1kV0U6PJqnNq8cdYUqEht3OzaQjrBg3kndm/2mpkl0FWVM
         /ypOlDtAXM23X7vJzXzaniIZtATwiZ+eK1qZYfoUEw8lVbphDdDmZ6UI+R9X7JYQQCB+
         4LmL/bqwDxoBfXcPDuRmIGUcH70dyna1cOKtbhqAcrBsVBHES1RM9X+f8Xik3+sohjyL
         9Ahcy2h3pPmgZSK+vWq55/JOuT7PbP6rPdzptNWmz/hVG4WBHYh3UUNaEtvRNXDUkR5h
         1JJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776685279; x=1777290079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUfnQP3wRHi9IoQNU4qVb5gx8JYHMlzrKLP0ObK2D4k=;
        b=AwFFa7ZebPI1bOOzEmeNcnNbIEtggTEAfnJFk4lguR03PgPy0/gSIVYS1mplI7AD33
         Bslu70gemb6Y2BOg1/Mw0b//x2wLXJTfvghC2Ies2L0eedP/QKtm5hQZ/3gHz7329KNp
         z/kB30oCFika1LhCGnnYWnqrUYBpss1Et8B8C62XY15B4E9gge7Ea6y1hRA5OM0dvVnm
         gxo0ethELaEI9S0P4irrzCLF2GcZv9V87R5dcZwB4braANjsjW7PccX365SzMX7wYvNa
         OPY70rgoEIEu+6S1uzTODKIUqCi6nmJRqDqiWQSb/6VL3wfRb8At7k4dyeU4eauWJdMX
         Bsrg==
X-Gm-Message-State: AOJu0YxxnrxTrZQOOfpKCYkoT4B1MRIXF/A72IQFnEibBkfiiRCoE1gW
	M4VnX/rXy+1DcOAI9UEFwnYAGIE/RngS8xRBoXNW0mLndKDVgmUuEPiGLsbzVI9O
X-Gm-Gg: AeBDiesDDn2aYfTERiwgJqr4V8DXAYPG20IgMrjfebKB9K8zfbYkpvV+nH5dYhEkPnM
	rC0igYHdKkGWlwhmlvl/exxR4vifa1LmGp5mpbzuQx/fJKdxm65HWRXLLStn0y/GY5yRRzlpLn0
	dafshrFTGmIPjGpC+mfr+XVYPiP5BfT4HXyFmXJPwZ431ma93PTi6SoP5a1Rirv0pqJVkl9OogA
	5SRxDZmEi2hDuwd2/AONuxKyDej+h/qyNoWI7Gk2nsYucpSyXuKr82N9NZ3s/7DVQ6Azglc8LPI
	woR5EeDS1ELXpdmnOSyo1FaliurG9sTvgkvvVpQS0Y1db8SuByT4L/YDM1lc5I8ajvWBipQ5HSz
	uq6XGMuTWxhSQYcMxE3s3Ia+RH2RVon6JIlfjdun2tZxmh2uq6YIuBaaNqjTGOjdvxtzjMwa8iL
	uf8PLw00s/VRU8P5Es4YEzyAQupJWzcSU9/N4/w6odohfsPuPzJB8KeS1bvE817rk7h8bnlIyl2
	TYs5KhN
X-Received: by 2002:a05:622a:28a:b0:50f:783d:8cb3 with SMTP id d75a77b69052e-50f783d8fa8mr11505231cf.1.1776685279210;
        Mon, 20 Apr 2026 04:41:19 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3bf260fbsm93482691cf.10.2026.04.20.04.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 04:41:18 -0700 (PDT)
Message-ID: <83b88782-96cd-443c-9a44-379a0e1b9275@gmail.com>
Date: Mon, 20 Apr 2026 07:41:18 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] fetch: add --negotiation-require option for
 negotiation
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
 <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <49c80cef2e25ecadf894cf42661d39dc82493f47.1776266066.git.gitgitgadget@gmail.com>
 <aeXfwnHvfnujAiqF@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aeXfwnHvfnujAiqF@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/2026 4:11 AM, Patrick Steinhardt wrote:
> On Wed, Apr 15, 2026 at 03:14:24PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> Add a new --negotiation-require option to 'git fetch', which ensures
>> that certain ref tips are always sent as 'have' lines during fetch
>> negotiation, regardless of what the negotiation algorithm selects.
> 
> When reading "--negotiation-require" my mind immediately shifts towards
> a mode where we require the remote to have a specific reference, and if
> not we'll abort. That's of course not what you're proposing here, but I
> would think that I may not be the only person making that connection.
> 
> Would an alternative like "--negotiation-include" or
> "--negotiation-expand" be better?

"include" does sound good to me. I'm open to it. I'll let this idea
stew and try prepping my local branch in this direction.
 
>> +	/* Send unconditional haves from --negotiation-require */
>> +	resolve_negotiation_require(args->negotiation_require,
>> +				    &negotiation_require_oids);
>> +	if (oidset_size(&negotiation_require_oids)) {
>> +		struct oidset_iter iter;
>> +		oidset_iter_init(&negotiation_require_oids, &iter);
>> +
>> +		while ((oid = oidset_iter_next(&iter))) {
>> +			packet_buf_write(&req_buf, "have %s\n",
>> +					 oid_to_hex(oid));
>> +			print_verbose(args, "have %s", oid_to_hex(oid));
>> +		}
>> +	}
> 
> Okay, so here we now unconditionally send our requested object IDs.
> 
> One thing I was wondering is whether we need to flush eventually. It can
> happen that the user specifies millions of refs, either intentionally or
> by accident. But I guess the answer might be "no", as the intent of the
> feature is that we indeed want to send all of those to the remote side,
> and the remote is being asked to consider all of those OIDs.

The idea is indeed to send all of the requested OIDs, but this does
present an interesting behavior where the Git client can allow the
user to misconfigure themselves to send larger-than-normal negotiation
requests. Previously, the client would protect the negotiation with a
maximum set of haves.

Is there any concern about this becoming a vector for increased load
on servers?

Would it be good to have some kind of advice message when the config
matches a set of haves that we think is too large? That would maybe
be a way to help users get out of a self-made problem.

Thanks,
-Stolee

