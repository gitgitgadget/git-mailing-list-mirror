Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477FC3803EA
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381213; cv=pass; b=t3N4GgAqDM/2BFcTk2hRx3lbMTLj7ESYsm2uL5fRHrLdDlvYm4i6IWciJ36xpSTjQUOKRlF9RlFUGoRq/Fg9hk4WcW/TPrlkCg1zFl0ZcLXMcbtlbPjbuNxgOmao2TAy9ZG3u5ZZkI7tP79aVP3NKQ0uELSghVhlVb6/ItP6Dbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381213; c=relaxed/simple;
	bh=fDjbo/495rQp+b18fzB92NH5eunU/XYkNEVqAcE2WIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M6jm2nMGl6lWm6ZTiMlnuS2RVhzPpT7xIImwbveqezo5NFemYfRLF9im7+Lt5B0xOJCCWQV6fItQcEwkdWQ8Fo7rmfhewLtmRoaffiCrc+BFxfp/r/pU2Er/bWV5q8575Kmal/ryERJ34ZJZHK/egovspau4v8NMh1rXohMA4ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=QkJ8zqat; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="QkJ8zqat"
ARC-Seal: i=1; a=rsa-sha256; t=1768381188; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Bij7YOqmuc+GIOwWDFViM5yAJKWayPU5b0a2RrcUmiOlPbAE28tEFwfB5H1LAw/0f3HbOisHpCFX3SZGRUteTsOOUHslpbZ5Hz6BMpEz0NRlztH/jqm8iUTRHKdaaoeOT5M0wYvW8svS9ZokHHEF0R3WbQ8cc1Np48+X5yNvaUA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768381188; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JH8t6wGu6QohwjXfa+QgoYuUq7qnl68KQkGmdg8kpCU=; 
	b=KW+sdjaxcjbvVhTLSscFS9zBF6HbmCBrEx2oVrNB5EsxWJlWMkghCTx8+/6p/Wukc+BJT21GZiJahBr739qH6Z8cw98TwHNdrH6VjHx/bI8HR6sCCVST0V3V49mQgZUcyxSn3vRsrtX1rt3vuEZcWh5aXjk10LM9wSNbDDHjV3I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768381188;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=JH8t6wGu6QohwjXfa+QgoYuUq7qnl68KQkGmdg8kpCU=;
	b=QkJ8zqatjQ4g3lauU45/Y+dT/rEegz/QRK/VHZN4rsLT5t0BxNJQCzhMM8A5zjCd
	ezJ8LOMA/MNUFO1sEvIO1DUSDgdved4kOBfXIQRT8o1c6mDsiyjU0G8drotfO+wJtzK
	2d/sDpdq6YMZmpGz1sFOB2aJ942kTjh6M3MiRv2Y=
Received: by mx.zohomail.com with SMTPS id 1768381186289438.04044114842986;
	Wed, 14 Jan 2026 00:59:46 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick
 Steinhardt <ps@pks.im>, Emily Shaffer <emilyshaffer@google.com>, Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>, Chris Darroch
 <chrisd@apache.org>, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] hook: allow hooks to disable stdout_to_stderr
In-Reply-To: <878qe0zimo.fsf@gentoo.mail-host-address-is-not-set>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260113234528.1749921-1-adrian.ratiu@collabora.com>
 <20260114031257.GA858646@coredump.intra.peff.net>
 <878qe0zimo.fsf@gentoo.mail-host-address-is-not-set>
Date: Wed, 14 Jan 2026 10:59:42 +0200
Message-ID: <875x94zi0x.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 14 Jan 2026, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> On Tue, 13 Jan 2026, Jeff King <peff@peff.net> wrote:
>> On Wed, Jan 14, 2026 at 01:45:28AM +0200, Adrian Ratiu wrote:
>>
>>> Changes in v2:
>>> * Extended hook test coverage to detect future regressions (Junio, Patrick)
>>> * Reworded commit message and added explanatory comment (Junio, Patrick)
>>> * Set ungroup = 1 because grouping overrides stdout_to_stderr (Adrian)
>>
>> I have not really been following this topic, but I did read (and
>> reproduce) Kristoffer's earlier report about reading stdin. The fix here
>> was not quite what I expected.
>>
>> In particular...
>>
>>> @@ -93,6 +98,7 @@ struct run_hooks_opt
>>>  #define RUN_HOOKS_OPT_INIT { \
>>>  	.env = STRVEC_INIT, \
>>>  	.args = STRVEC_INIT, \
>>> +	.stdout_to_stderr = 1, \
>>>  }
>>
>> ...I expected to see:
>>
>>   .ungroup = 1, \
>
> Good catch. I actually missed this in v2.
>
> I will drop ungroup from this patch in v3 and add another patch fixing
> Kristoffer's issue (rationale below).
>
>>
>> here. The stdin issue goes back to 857f047e40 (hook: allow overriding
>> the ungroup option, 2025-12-26), where the "ungroup" field was added,
>> and various code paths set it to "1" to match the previous behavior. But
>> any paths that were missed, including run_pre_push_hook(), would see a
>> change of behavior (and in this case, a bug).
>>
>> My reading of 857f047e40 is that it meant to give callers the _option_
>> to switch the ungroup behavior, but not actually change anything. So
>> wouldn't we want to leave the default as it was by initializing it to
>> "1"?
>
> That is correct: my mistake in v2 was assuming Kristoffer and Chris
> reported the same bug, when in fact there are 2 separate bugs requiring
> separate fixes, so I will create 2 separate commits in v3 for each.

Minor correction: I think we need 3 commits for 3 separate bugs we
uncovered (ungroup should have its own commit). :)

Please wait for v3, I will code, test and send it ASAP.
