Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0C366548
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774298359; cv=none; b=BN0rPALSkSgviAHBcIYGl/XIFYnzODSIGY93TCOod1TNi0tQS5FXP6UhTMSrAC0oQetCRnFXZiaYC+I5jxzrUz9YWNvKFmx85yo94iQLApX6f3ZnFVtequLCZ7/GyvzQEATRRWxDFjeQIh92VZwqrhHRPKmMDjhJkZSrHXeDHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774298359; c=relaxed/simple;
	bh=IRMgHMkOVRydTd79IKEfbZXC4u/yLxay+A8L37QDt6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O187i3egT3v8+9gzYi9+kS5ja0OAM7289PoGTOOD51SBFtKqxleF7zY/kZRHB5QUj8hP3KygXj2zPBfO2ZbpqnwW8lsD09YIyM3jnPUt5Yp10GYjErQDZyh3yWZ3gRv4zFE9/7BMcBjou3aNcClZaS7RWyL2UPymoiGo5N3qdC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEJn9QQg; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEJn9QQg"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50b268fba9aso4761611cf.3
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 13:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774298357; x=1774903157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8c1SU55Fb8BKrVUM987kgFBbxdUrktY9UJJME8h03kM=;
        b=AEJn9QQgUD0PIJxY5cZvZ4jgWSSgKFhqXgiQJNpg0qphih3x52RXSvFLy5UW9Gu+ur
         T7fccckhrzupf/s+5mi1Pz7WdXcWm72LVqZMU1vaUSSz7+UoaTg2v2LImB/A4jiKhNVG
         qrhNFKrseWGcAVbfC1YVf/0TXtoTSyRvUeuGpx1I+SaQnj01l3ZyxUanWOd0sC1Dd605
         CGIWVS4qnhdWTrRdHd/gWPTCOtHT9L0rHSUD/Tp0FhjnM2jO9QNo7mwdk7hc3ndE4pVk
         w8BQey+bT4irvN3qQzXOBKDar1+ERb1SuobbYzTBEXRJjXhDbHEcWvnR+kuxrzoxMWBh
         JVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774298357; x=1774903157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8c1SU55Fb8BKrVUM987kgFBbxdUrktY9UJJME8h03kM=;
        b=GU5EwB3pe6HSBPzQW5MDwxxz19RnYiiy3NZ2EX6fw4J+UArGMlhBth3cFcEzG+piOg
         oy1AUeIMXbcrmNVl64dtqYE3geKLDcdFCxPMF6k8v0lYCz5iIbArtDAIfQyfzS6XeLYb
         bE/qpQ4+cEVYh/mBDi0rz1R/FFgTORYpv1P2tgqRwrkmD6d6EvNLXcGkIj/kr897xi05
         qvX9/WuS42c9U3HtZCfmO5pdrlpyVeQRBWsBD0FPO9ZQEk4Vu2E77lIy+a4sQldQ8R0X
         OrzRTQiZADhMnoLM5ZpBhvqqhDpC/jl1nTSVP/l4UGoqVTPHEgJTzpjDdHJ5KmLveeM9
         DIEQ==
X-Gm-Message-State: AOJu0Yy3IXZa8BA1Fv/DKhbOiWXXXSorbEctWxKH80OBA6vwUI1uYcLH
	4nTjNOMcpedpU718ZsaBFTrrTX6gf1xNHRu8IDSiV8SUcqs4TuU09//L
X-Gm-Gg: ATEYQzwOwlOZTknMS3vVNRgRhs4Ca1qBZZFkln25OL8rirzF1G6YUVkbfWbZuYtouTQ
	/HHDkaMztlgJCN3WCcCZE0uJGlD9lx/lflozLWQbsjwWahZlXpEU+0WFluHilrZ0i5+2An2yhnD
	c2fhYxvfYSS1WG4WgUDCoHRpX7yOyIO9VTTXlSFFB8T7zu2tc6bmwx56x9+ypalVqHVmoq8D0lh
	CZur6gmofltvs0ELCFRFGZMFKhojZDDWioFcudJS6X/gtweVvug45Xso3JlG4AlZwoX4JbbYDQa
	Ojl8dkrgflC7+6kWynMea9jj9wlBMovuIkRPPpepQti3vf+SMCCKD9KstO41EhlCTJdsCL+8H2t
	fy6OyShgCpRSWvd51M/p4Q1M2Z+lMKUHmTPt8JyIpoBFC8jpHYJgB5ShaoFzZRWQkjJF2dRxwGT
	5zs/PnJg26I3mMWJQK8Ucycah8NDA+qucLdgO6eAO1nxH4knqMBYb0X0LOABcatvB1nGsWuw==
X-Received: by 2002:a05:622a:5c7:b0:50b:34b7:fd62 with SMTP id d75a77b69052e-50b37448bd2mr204207561cf.25.1774298357068;
        Mon, 23 Mar 2026 13:39:17 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36cb2c63sm95237541cf.6.2026.03.23.13.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 13:39:16 -0700 (PDT)
Message-ID: <7279f449-7bac-4364-bda0-5115980fa717@gmail.com>
Date: Mon, 23 Mar 2026 16:39:16 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] t5620: test backfill's unknown argument handling
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 r.siddharth.shrimali@gmail.com, ps@pks.im
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
 <9699650aa7dc04cf1cdc26803caa8304b29c1662.1774266019.git.gitgitgadget@gmail.com>
 <xmqqzf3y5zu2.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqzf3y5zu2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/23/2026 11:29 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> Before the recent changes to parse rev-list arguments inside of 'git
>> backfill', the builtin would take arbitrary arguments without complaint (and
>> ignore them). This was noticed and a patch was sent [1] which motivates this
>> change to encode this behavior in test.
>>
>> [1] https://lore.kernel.org/git/20260321031643.5185-1-r.siddharth.shrimali@gmail.com/
>>
>> Reported-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
>> Signed-off-by: Derrick Stolee <stolee@gmail.com>
>> ---
>>  t/t5620-backfill.sh | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
>> index c6f54ee91c..85740f1f13 100755
>> --- a/t/t5620-backfill.sh
>> +++ b/t/t5620-backfill.sh
>> @@ -7,6 +7,14 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>  
>>  . ./test-lib.sh
>>  
>> +test_expect_success 'backfill rejects unexpected arguments' '
>> +	test_must_fail git backfill unexpected-arg 2>err &&
>> +	test_grep "ambiguous argument .*unexpected-arg" err &&
>> +
>> +	test_must_fail git backfill --all --firt-parent unexpected-arg 2>err &&
>> +	test_grep "ambiguous argument .*unexpected-arg" err
>> +'
> 
> Hmph, I would have expected that an earlier --firt-parent on the
> command line would trigger "unknown option" instead.

Interesting that my mistype has demonstrated an interesting
behavior here. It turns out that random options starting with
'--' are accepted here, including --unexpected-arg.

This means that we actually have room here for some improvement!

I'll see what can be done to make even these arguments be seen
as failures.

> Having said that, if the code lets the setup_revisions() parse the
> command line, the usual "unless disambiguated with a double-dash
> '--', stop at the first non-revision and take everything as paths
> but for safety all of them must refer to an existing path in the
> working tree" behaviour should trigger, and it is not specific to
> "backfill", and may already be tested centrally (if not, I do not
> object to such a new set of tests).

Thanks,
-Stolee

