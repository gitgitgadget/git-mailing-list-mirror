Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370F310785
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776639615; cv=none; b=sHBPsXpx454C6NdPLofR89Rwdcc7gzwHKD0aR6UUwR5c4+RSaz9/GjRKX/O1/qJEciuhRAkLnBlM95+zwsdTSYV3jozIMOXS+ibNb009Y/WANnokPYAg4N//iRdVcGOHCbKT2NN0lTrWZibLtAcfEVKHRwn0ZEkCRGwkOtmcbZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776639615; c=relaxed/simple;
	bh=7fPrNsZlueKqDi8OBCkjBn9at163/DNF9vKhhl28Zuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qB15bWw9MnUe878PEF5XChSH9FhkYXVex9pnuM8wnqyqps05jR5QQzeFBwboH0szRY4eZnZCY7/p8mJVhpvnXSDHanZZ4us0f6Rm7fDSpHQF8Nc+Zfs2dEYwIufMo81Tl5Is2+wXKcaZIBKXfcnAIOxNS2aZjeoDT5CjzzVMOSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQgQbACC; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQgQbACC"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8dfb9139008so156209085a.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2026 16:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776639613; x=1777244413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7QZ59Nv44F4l4ARZYjf+6hwO6ZTtQWg3lRWfAhR/94=;
        b=BQgQbACCZfDEKMXyFOBBkQYFXU4v9FIxo089mN6fUeOBgLlcYuv7R3NeHAyYrABL7n
         l8jPV6nFgsm70qA3aCLtLWrUnv9gaKYN96Anti2HgUOFWebC9NN9+Er9yZh1AXzEOuGB
         DNZ5Jpjus7CxKdVExqQ8y58awrizGD0oEk6CDKfpzACIiI6n7AZWsRPWVad+GrhTTq7I
         k2wtCGLyDSKAfRrOoTIVaeVJmXfZl5wz2//5I6B2FzfLlB3nxGtqiXsWktg+s9WvBYkc
         0+PulobSgyxQqTK+RVnXAmrYyF2vaD7LXiJKKJzMunE4P0WXzJ/gk2gmEQGC+DNxy9P0
         yiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776639613; x=1777244413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7QZ59Nv44F4l4ARZYjf+6hwO6ZTtQWg3lRWfAhR/94=;
        b=l6cdCrgoG4uLEAbBjQ2AMVY7jU0ODlcH9JkRN6CmUK30eWfYChGA3Eime/Us9s5fBf
         ls7jw8kMe3JAZFaFmAfGwuoXbbWnlijITgvt0RytlbklSMx5l/O5bepS65uFbTTr/fGs
         yoF/oeVYf9jJSJS8PmGwnjSk3bENKregcFbebzweNb0mr28cGsW3XP4m4WH/EoTPEnyG
         85kJeBovBWpy8imh4/EyxIPC0Q2EdgMIUDP+u3Sexi8k1Dj6I2pO9JOZOaJEjVE2gRVx
         RgtzJnTJNS82MKchuigk3yiEcIng0jPWw3XjYVdjth8CG5cCzH7Ij+ejOX96+mFjt9LQ
         5jVg==
X-Gm-Message-State: AOJu0Yxq7Nu5DH/eDKxBQIHLikafvxw8NXIZLX0Ehb4SNVKB7orQvqS4
	IM8CcNqhSRXqf3TpyT81EFi4smmu9mFbyfBqwF8gJTCqBQ2pjTyPwglDGyY79YKu
X-Gm-Gg: AeBDieuWX5/L9yOKUwm+iGuT+76AEDQ3KiGi5taR/c2/FiP6KuDH3ReQEgoWfA3KnPn
	grA3aoFNzYpC0yh05BdeYiztF2zIKV1xJ6MegOCKQhW1dTNgvme5ZR7tW4KW8RHLGyrUBC5LAkF
	Yd7sHbL3CVDZGFIcmcfOClP3iA1wRtEu6HN7DpssKO3EiSM8Xd5S+KJ2gPYJZ4Ly5XwJlBXw5nm
	0qtxRofuUKbtqopKDOO8Eql81dpq03CBCOCJs8NkBM+dqGoI2vtnGLxANtTmm3HbHAmJe4dRN1F
	dqr9rYTXG2qKo5cUooJLATmoezyf7lXtUkE7RSJTE9EgW/MlmMfbGA5gc5Cp9/sYdnyvUD/H5II
	tJ9ewcxSIPzreDAkB94vxENtiWgZeOH2+3bPw8lEJnXHbIZ4dvt08/CeLLGZAKY5V3mWvByitAp
	hT6BM2DSNiEIuSDnyZ7nEp+8rb14tWNlkIHe3a/DM6KGm+3RkRpne5vNWCKd/2gamzZTemsy9x9
	NaUqCXya8Ne6iiD9QH/oshNacnBgjmpAe7XmpH4tPXw21D8n26dVVbf
X-Received: by 2002:a05:620a:4443:b0:8d5:e4a7:9b0c with SMTP id af79cd13be357-8e79236c284mr1595763585a.43.1776639613050;
        Sun, 19 Apr 2026 16:00:13 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:84d:e5ce:d94:dc76? ([2605:a601:9b88:8300:84d:e5ce:d94:dc76])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d93c2fffsm636209685a.36.2026.04.19.16.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 16:00:12 -0700 (PDT)
Message-ID: <5370b884-30e8-44a9-a52e-4c518556fa24@gmail.com>
Date: Sun, 19 Apr 2026 19:00:11 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] fetch: add --negotiation-restrict option
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
 <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <9a25b0fadebb5f0219ceeca9496fc6f84abd020c.1776266066.git.gitgitgadget@gmail.com>
 <xmqq1pgf6g5g.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq1pgf6g5g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/26 5:57 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> -			warning("ignoring --negotiation-tip=%s because it does not match any refs",
>> -				s);
>> +			warning(_("ignoring %s=%s because it does not match any refs"),
>> +				"--negotiation-restrict", s);
>> -			warning("ignoring --negotiation-tip because the protocol does not support it");
>> +			warning(_("ignoring %s because the protocol does not support it"),
>> +				"--negotiation-restrict");
> 
> These are nice touches to make sure translators cannot possibly
> botch these option names that must be given verbatim.

 >> @@ -2657,7 +2660,7 @@ int cmd_fetch(int argc,
 >>   	}
 >>
 >>   	if (negotiate_only && !negotiation_tip.nr)
 >> -		die(_("--negotiate-only needs one or more --negotiation-tip=*"));
 >> +		die(_("--negotiate-only needs one or more --negotiation-restrict=*"));
 >
 > OK.  Shouldn't this also do the "%s" thing?

I think I had focused on adding "%s" to strings that were not
previously translated, but adjusting the string under translation
is enough to require retranslation. I should make it easier to
translate, too.

>>   	}
>>   	return transport;
>>   }
>> @@ -2567,6 +2568,8 @@ int cmd_fetch(int argc,
>>   		OPT_IPVERSION(&family),
>>   		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
>>   				N_("report that we have only objects reachable from this object")),
>> +		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
>> +				N_("report that we have only objects reachable from this object")),
> 
> Is OPT_ALIAS() suitable for this?

I was not aware of this. Thanks for the pointer!

I do plan to make "negotiation-tip" an alias for "negotiation-restrict"
based on the new preference for *-restrict as the "real" option now. Is
that the right way to do this?

Thanks,
-Stolee

