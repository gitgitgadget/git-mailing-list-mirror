Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551E4169AE6
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099146; cv=none; b=Azb4nbqTsshywdBTMeCQuJdf+Tv99VyzDvxeps4ogdkT8IjQ7z5ezNdGuHqIaaQgVRJd62Ein22YCS/6+RpvyUET2v8vKb5gSbFvSleSfFhY/6ligfh7J/X2KeCBHksgWWXvHZK1xnJxrH/mJlRvN0hTVVwtImzYAIexqEMjuJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099146; c=relaxed/simple;
	bh=/UmDbXB2XcCVEVuya2ZJdS1lQdHxkLQlql1F7wiMFIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roSCJpdcIpDJkHmOm0OPaWzJBm3d0Ugm/zn8d16XANn4SxNs4TdMbNeblpNd4LvRhgLG5SAc4YGgPbqUrGYqeI279+OojJKRmewMxdFJGuTjPWsCcJEz7vIGaCW+h0sxn2qE8Bo3o+PmAS3yLMo5OAD+fzmZt2NzBU+bt/qIehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbyeeByj; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbyeeByj"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b38d4de61aso33213131cf.0
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099144; x=1757703944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7RlUw3/cCW7TgoB3IIOk795QhV+F9Z0hfTm/yW3/AE=;
        b=LbyeeByj+35UhDc7mZPuAzKNRgoZAPcWlkWAy14GGT15HoPyz26DJjgcOZfx4jfqFk
         QgZzSpkZAWTzwhBtTw+hh4XeMtQ4qkg41NSk3YF2trE92yzYj4VKVNU7TbDQgfx6v1Gr
         4weVIa1Fri7alypSgMyirpUb6ZwkfMiot3WtcveAGA7lh3z92ugShNWwKyKKIJBzpBGs
         gGo0vMVSTcBG0asZ0djxVPr1FFWs0FbxVSV1LHOnfTzlh0eZWkQUkaHr0LTfdFdRwVx6
         6+RVU33L0Uz65Cdpkj5307qs2Ft6Wp2UYJne1v+qWCoIu4qNqSBTEKqQSq9dUuEVvh/v
         N6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099144; x=1757703944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7RlUw3/cCW7TgoB3IIOk795QhV+F9Z0hfTm/yW3/AE=;
        b=fIyGqg+FO5TPeMsgfa2X69Xk/XoC4O1OLMi2c8qtlIDPVw2B65ZPqShUfUF2GcYFVx
         DwKQE0kTevCdsTxF97MiPZRle3zIHcsd2xE+jZPWMY5Ns+ocz3zpKlLioHLfdUeg88w/
         eIh3Yyx14kdOOD7oO7b1zDpdbS8n7qGMZ8r95CfST83DpKUSFlLRuIZ0+bFcH3aACCYa
         hA+4AyiRKgqgZBMBVCUmA2uQLiXlVOHScTfK5R8U3O54XY4KFodV/HwYmUFx/dUzemkH
         +32cDiWpABq60xMJHZ20W/3Nj2TfH/sEmP2Eh7yLr/EcKmT4DAk5pYiOouqJ8cZYFsbU
         I48Q==
X-Gm-Message-State: AOJu0YyOd07HlpnxzOw1S/ueSPdX1SqasoRYeSFxrjo/NtasJf+PWeoF
	uymF9dhR82k5jALqOguC8qds8akWUQ4fdok1K8gBxBSRC25WBGV2sqkR
X-Gm-Gg: ASbGnctqV+mDPiJpS+v5t7mU6anURL33KuU73urS1NGSvEEbFsfCoVRHbuE3b8Y1giD
	sUW9smwTFX+egStZNeXROJKjSzkn6HWdJI+3IOeWlDv92SzZDTdQH0KgvxbRfkYFuMKJCEWJWqF
	KfWvxs0MbbDo1Kfgd9C5zzK2+j+FSTSoUfbn3/8d/ieOu9RHWuo1KyxkTNz30uRDBFooMnrgyJ5
	QqKp6AFFt8aMndkg8RDDU/X+mOre0OD5FK4uv02m+YexFJMlsdz8rbISb+1OMqBhoZ5Wy1Ipiol
	ZEcc8MO8Pa1L+skOwkvE3FzsaZ685tmDjg3zu0u82yaJGFN6b7a2RW6P/pDi9fMFVfa3q+j7Yld
	p9ZCxYjyzUXGGlraBbIIsVi4KR9rP407iCmM=
X-Google-Smtp-Source: AGHT+IEWvsHBBaj4lZLyds4mCp8P7N/TJAE+KTNQJ/fRBCwQgYJP5BoTyw1nuOJkB0TD2+TTCqYBXw==
X-Received: by 2002:a05:622a:4d4c:b0:4b5:f6fa:83b6 with SMTP id d75a77b69052e-4b5f6fa8763mr3235171cf.84.1757099144057;
        Fri, 05 Sep 2025 12:05:44 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80af4b3bda6sm507399185a.39.2025.09.05.12.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:05:43 -0700 (PDT)
Message-ID: <4c6468d6-02c1-4c79-8ec7-4d250341ca81@gmail.com>
Date: Fri, 5 Sep 2025 15:05:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] midx-write: use uint32_t for preferred_pack_idx
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
 <2290e27ded03866cb816be5fb6e08b83a75a6f07.1756589007.git.gitgitgadget@gmail.com>
 <aLgVOa96grWC3G0Q@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aLgVOa96grWC3G0Q@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2025 6:15 AM, Patrick Steinhardt wrote:
> On Sat, Aug 30, 2025 at 09:23:25PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> midx-write.c has the DISABLE_SIGN_COMPARE_WARNINGS macro defined for a
>> few reasons, but the biggest one is the use of a signed
>> preferred_pack_idx member inside the write_midx_context struct. The code
>> currently uses -1 to indicate an unset preferred pack but pack int ids
>> are normally handled as uint32_t. There are also a few loops that search
>> for the preferred pack by name and those iterators will need updates to
>> uint32_t in the next change.
>>
>> For now, replace the use of -1 with a 'NO_PREFERRED_PACK' macro and an
>> equality check. The macro stores the max value of a uint32_t, so we
>> cannot store a preferred pack that appears last in a list of 2^32 total
>> packs, but that's expected to be unreasonable already. This improves the
>> range from 2^31 already.
> 
> Tiny nit: the last sentence reads a bit funny. Maybe something like
> this?
> 
>     Furthermore, with this change we end up extending the range from
>     2^31 possible packs to 2^32-1.

That is better.

>> @@ -1040,7 +1042,9 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>>  	struct hashfile *f = NULL;
>>  	struct lock_file lk;
>>  	struct tempfile *incr;
>> -	struct write_midx_context ctx = { 0 };
>> +	struct write_midx_context ctx = {
>> +		.preferred_pack_idx = NO_PREFERRED_PACK,
>> +	 };
>>  	int bitmapped_packs_concat_len = 0;
>>  	int pack_name_concat_len = 0;
>>  	int dropped_packs = 0;
> 
> Why is this change needed? We didn't previously initialize
> `.preferred_pack_idx = -1` either.

I think the previous lack of initialization was incorrect. It happened
to work because it became initialized to -1 later _or_ its value of
zero was implicitly used when searching for a preferred pack.

I thought it prudent to set this value as the default instead of
implying that the 0th packfile was preferred.

Thanks,
-Stolee

