Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018F1DB13A
	for <git@vger.kernel.org>; Mon, 18 May 2026 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132446; cv=none; b=BpCBLWscyT/K3YMQuOXc2NJBTESIpHBhdjNRrTNwCZsbkzfCtLIgIQhPvIqAtY3ZvbZ6ui2jR6+zLE6KLT0Y5znz8X72x+vpLMXfSpXywt8UaOefGzwY8tb+KTp7bnMra21xyytQZ7u0em8a4Dj5Eg5gDh1rANx21nCs1D0w9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132446; c=relaxed/simple;
	bh=ssxMD9LSwusCpRMheA/gWLXaaIXM9+8MJea5dB2NtQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYM1Q8ZgeQr/7b2ljeYCdbFYWkhDU7WWhclNWDTcNCkxsZMBjO4v13wTl1Ks8V+hrLhlZPwIEE5IIpusp6cDrNhu1P30vRAEqny6Gyv/NuqGWOHH2EVelJA4fgUPoKMKfI31RS39D3z+CzG86TU42ayLOm7e/uJ+8NS3DbeUlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqPl0hWT; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqPl0hWT"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-912278ed3b5so296389985a.0
        for <git@vger.kernel.org>; Mon, 18 May 2026 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779132444; x=1779737244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZTD554tELYLMIbZxrmcXw+eha0gI21+O/+XDgqBfcU=;
        b=lqPl0hWTOv2Anxvbcmn5vIJAK2woLDYt+9bHU0pKpBhWjFAADKcUGQc5jSO6RtqBB+
         cz1ecZxo5jbWxhqG8ADXJzl3D1w1Lm4oEU5f5TvruTB7ORBNdzN3SjbgqewwXfZYFesj
         E0bezGK09+nbjLaypdZ4/mGWE0DO2l101PTUmWDtogPnwlQwXjNVNIdzbYWbGzC6n9yr
         OU04o+bA6sUKQMB+BW8OYX5roX2iuV9z0RgAZOL6Ryky8s+dEB0gYvKFBVBpAWyYsRDl
         M14kP1EMSMw2vdsGRHYlmrQOw3TqsJkrAJsYrm0GLAJV52X7hwhJzOYdKmc5xMzsNeNP
         c3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779132444; x=1779737244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZTD554tELYLMIbZxrmcXw+eha0gI21+O/+XDgqBfcU=;
        b=GsB6mUiA7xz5kGqJarJJaEx7GceZdxiNX/9NgNWmdgD8cPgE7aZzu5pwFF5pn0/iI4
         0396VKbElCQd/Ek5hS0VQk8MTpEvya9jlWlOqpYFlXsws6mo4qcYPN0maI+j5FxWT19a
         ZcJvnvp1Bscz0E8CTDsJprP2ykLkOemtmM7f7Kt196gNGhNsSXsz0V54WuL+YXbr6YR7
         ahwINfD35YZW/cZUc0Mvbz7H5Rr5M+HFCPvf7EjuHB1zAlHSiJrHIpGaYVz+YWydv3qV
         z8SGgLI2RJTQ9JiIVD3EYoiiypdrpV/rL5tFV2Gce2HlJISvjCbgA03hw1C0Y50Iqvgx
         dCTg==
X-Forwarded-Encrypted: i=1; AFNElJ+sdNKmVvxV4zKTgZFdFUiTH+DlOz1Oe/THTf+B78ckfhJsXE8aI0xS5UIW1EG5qbvRi8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJeYQlV+IVkYgUFx7ubVCuhvT8v3m9NiGnHRP68jrVlumvkO0N
	2N8q5nXzbdgFyZqoaoDI60l8BjsMJcLuld2iVKFSKTtW5JKr5z28W3dB
X-Gm-Gg: Acq92OG27U7ecir5JFo3ORb3vwcf1sTQh+Jkt+8j8QfnIx3mbb6g16EFq1XWINMacnU
	AxbPjBVP7ku3Unhw/gjaTNW0rVUCxIxcrNWx4e0U2KlGWrfujp0Gv6riWa8d4FkNN5+n60LxrRP
	EHdu/N8BE9RSpZLosySN2gZVwDqQLWXUjssKkAZphpyGybxxkhgXsxoxkJwYWZG+5YQWyIYez0j
	C3QqHu5Asjz9yqH0LSI97ielDBR+QaWD+iqDY7tV5ee72ali+8npxf6kRTOUpXkkbeulcGqsr/V
	/n7F/0+4Xr1iV8kz8W7pzeiVOG4jKwLAHXHPPlXviOKG379dFXbKCLmSmFvFe/lqpGcEWEz12SM
	Cqb5jOiBCnRUA9hcGXlbhpGaJvQxhIcXy7isVBPn3Ulijj+iL6HrUGluist+df380Gd3xZWeQ2+
	jw3Ehpd9NWBG1KfQf9bigq4a9xMj6LbNs70MrIQAkhKFh00Qi4wacQLRrSJcbWBJYemFEaJw==
X-Received: by 2002:a05:620a:7087:b0:90c:2032:7634 with SMTP id af79cd13be357-911cdd563bdmr2344964685a.22.1779132444302;
        Mon, 18 May 2026 12:27:24 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83b18dsm1583565485a.31.2026.05.18.12.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 12:27:23 -0700 (PDT)
Message-ID: <b65e500e-ec9a-4dd9-8267-3e7843e410cd@gmail.com>
Date: Mon, 18 May 2026 15:27:23 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] fetch: rework negotiation tip options
To: Matthew John Cheetham <mjcheetham@outlook.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
 <VI0PR03MB116343A44C3D5E2562FBBEEEBC0032@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <VI0PR03MB116343A44C3D5E2562FBBEEEBC0032@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/18/2026 1:24 PM, Matthew John Cheetham wrote:
> On 2026-05-14 13:41, Derrick Stolee via GitGitGadget wrote:
> 
>> Updates in v4
>> =============
>>
>> Thanks, Matthew, for the detailed review! There are some big changes in this
>> version.
>>
>>   * Expanded commit message to cite the commit that introduced the bug
>>     (3f763ddf28).
>>   * Renamed --negotiation-tip to --negotiation-restrict throughout docs/code
>>     (including send-pack.c, transport-helper.c, builtin/pull.c). Added
>>     OPT_ALIAS in git-pull.
>>   * Switched config parsing to use parse_transport_option() helper. Removed
>>     git push from docs (not implemented yet). Restructured --negotiate-only
>>     validation flow.
>>   * NEW Patch 5: Added have_sent() interface to negotiators, so included
>>     haves can be de-duplicated properly by the negotiation algorithm.
>>   * Replaced COMMON flag hack with negotiator->have_sent() calls. Moved
>>     ref-pattern resolution into builtin/fetch.c (add_negotiation_tips()) so
>>     fetch-pack receives pre-resolved oid_array instead of string_list. Added
>>     test for --negotiation-tip ignoring missing refs. Added
>>     duplicate-avoidance test for v0. Accepts commit hashes in addition to ref
>>     names/globs.
>>   * Use parse_transport_option() for config. Updated docs to mention commit
>>     hashes. Removed git push from config docs. Fixed test to use correct
>>     restrict/include combinations.
>>   * In the last patch, add doc notes that remote config values also apply
>>     during git push with push.negotiate, now that they are integrated by that
>>     change.
>>
> 
> Thank you for going through the comments on v3 in detail. This is a nice
> improvement overall.
> 
> The main thing flagged (the COMMON bit confusion) is resolved by adding
> the new have_sent() API on the negotiator interface, which is much
> clearer and cleaner. The hoisting of the ref resolution to the same
> layer and reuse of add_negotiate_tips() is also done and appreciated!
> 
> I've left replies on each patch, with only a small number of easily
> addressed comments.
Thanks for your review, including a confirmation that I properly
responded to your earlier review. Soon, I'll send a new version with
the few minor edits included.

Thanks,
-Stolee

