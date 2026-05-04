Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ECA3C9EF3
	for <git@vger.kernel.org>; Mon,  4 May 2026 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896068; cv=none; b=r2lt+M2Sf5L1ZUb4cwXClHqTD9HZ0OpX4R6HftdCSVcnHyjeNP1rO89PPmaitkFoOS/5Mi6VyWh9RaL59XH4iPOBtmOS6g7wUf4ogeMZYkKJDsqLIEg3je0IOXmhQOXJ9koexrDOK8eTc/xFTkEDTk4OAhcRyPezOSaQ4Tsmnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896068; c=relaxed/simple;
	bh=/NreMssttUYKRucPmYLSaSP0fHzcariR/36Zu1/e82U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9Swinr/jolRlieFRUJt3Cfd2TYYIOuGEZUnfJuqVJnDitWmjyFDjRj9c0uvI/l1tE0CnspB9GE8kFT/CZSx16OigSTWxT5fulH7QSExFHuXIGeggibpjfgCmFlW0a9ZIkihnwOC7E0WBy6xW41KY+FWTeLes3gvFI9+Eiby7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqwGhzWx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqwGhzWx"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e5eb0fabaso47329051cf.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 05:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777896064; x=1778500864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xC9cKCBF0Rpg2eHzLJPbhYsLYFDsZl9rgTS0uhMO55Y=;
        b=OqwGhzWxkVt14LnWlQeG3LmwjOzYPamjX+42YwuhodWVA1oEJ1K2sUbZWEPzK1XAkE
         RtvfOSbRlou3GfIk6AWHM9N5muS7rBmfuis9/PRAU6hKQnPfP/c1rBYS89R3YXY6arvX
         4ueWseIAJ5Mm07PgIyCaBBggeJCMpoAKv9wrnjfEBRXfYpSOomQYHpHtctMfz9Hb0is8
         XT3YTqIdUmyFylZfHaT5i++wFephR8NTuKMOWCzoa6JcVhqmJH34N01Ebs0TwQlhMk1L
         WkxaBUhlw94/JLAXrIDoeTesPnaF8Zdel87ij1VzAKtXZsuF9RpOQOtBawz1w2E5J/8H
         cOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777896064; x=1778500864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xC9cKCBF0Rpg2eHzLJPbhYsLYFDsZl9rgTS0uhMO55Y=;
        b=EidWYeI6bvJzk0dKqACST1MWUYIDGvjcTIEaWeAKbOLUKd/hnCQCiLw44Fa2LSF8M0
         RKvnfckVg0SqP1cZOG5+vORVZDU6Krz4fVSUzcVYz4ez3ZCLzTXJYXGn/rVkoTyHODXQ
         4JEv1jG8SrPcbqjjX26dljYanG8QStbVgkAMROwOI48ldjMgIpP5/N7//DwGeDXb1Yhv
         Hrv4jCFWzRoEEHCMpHq1xw/Ek0lQK4PGU4AWaUHH7AuzBS3WquaAkAp9aYExJU7+LUNm
         dj2KTXpPT0YV5g98QPHS0PgGdgNStbmHtZF2Yl1tC1DgFYA7tFxlcxMPk0issl6BGTBc
         7jPg==
X-Gm-Message-State: AOJu0YwG7rCbnq0gBmdNQddXZ8dIEq8JioxuymtEOH4s7XvfzzYrl7tn
	4ERl/tn+sE/LRi4aead0vQ+9JBC36lal0eFJ2SJQ8ds0Q/l4Mvif1q60
X-Gm-Gg: AeBDieuXR9ZJZpABUOIxhrBPpuuA6teYVwJ9boxfDO+getKBMw0XO+bYeqXZB78dfNt
	srlwEe9NOEhn7g9Gl9kOP1I422HtZuJl+byIiIJ0ASBPE/f0kQp4P+6cq3XmmV4OcGo18Irvo7q
	6mODDwUJ1Rw4MnKuLrV1k8W39928TEW84dksFxp30gS3o5++THDFgfGRWWs0c+SSXlwx63FVeeQ
	OKXVrmOyzdcXUJFbCRQ1aIFQddQWzDRAQzx/URsVLEjSYyRh5X6hpvMd7fq59xB1uT+ybnNRDix
	fARZGXEKEm7VRn3MAIQeS++Te3rrBnQD/Icg+0+/TLMbFg9hk4WOHejqtog/kdJ++NbYVi0oln2
	Cx1Y5ku7kIHuMF/c/AIzjuTASxGC0RqOiTjekyZNnyZuP7GArMvZnEo08JjB4rAgtUiKB/Y4tie
	QBn8MtTaTdVNuEeIfBJaIs0mD/DSBsYi7x5pS3fm7CajzTNDf0XSZiCptTi36Eh9LmJs0Mluh7o
	Z7I0z9SsU3mDFIXHmU=
X-Received: by 2002:a05:622a:993:b0:50d:9aff:8b43 with SMTP id d75a77b69052e-5104bddbd2dmr150195191cf.10.1777896063970;
        Mon, 04 May 2026 05:01:03 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b86535sm102645961cf.27.2026.05.04.05.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 05:01:03 -0700 (PDT)
Message-ID: <79609516-ea40-447f-a1e8-5ee71d309208@gmail.com>
Date: Mon, 4 May 2026 08:01:02 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] pack-objects: pass --objects with --path-walk
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, newren@gmail.com,
 peff@peff.net, ps@pks.im
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
 <29d2797440412bfec85be7b6a6439350b9ebf5e8.1777731354.git.gitgitgadget@gmail.com>
 <xmqqo6iwq9qs.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqo6iwq9qs.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/2026 8:49 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> When 'git pack-objects' has the --path-walk option enabled, it uses a
>> different set of revision walk parameters than normal. For once,
> 
> "once" -> "one" (or "instance")?

Yes, "one". Sorry for the typo.

>> --objects was previously assumed by the path-walk API and was not needed
>> to be added. We also needed --boundary to allow discovering
>> UNINTERESTING objects to use as delta bases.
>>
>> We will be updating the path-walk API soon to work with some filter
>> options. However, the revision machinery will trigger a fatal error:
>>
>>   fatal: object filtering requires --objects
>>
>> The fix is easy: add the --objects option as an argument. This has no
>> effect on the path-walk API but does simplify the revision option
>> parsing for the objects filter.
>>
>> We can remove the comment about "removing" the options because they were
>> never removed and instead not added. We still need to disable using
>> bitmaps.
> 
> In the old code, there was a valid reason why bitmaps were not used
> (i.e., "--objects" not enabled), but that no longer holds (i.e., now
> we add "--objects" ourselves).  Do we need to give an updated
> rationale to keep bitmap disabled?

>>  	if (path_walk) {
>>  		strvec_push(&rp, "--boundary");
>> -		 /*
>> -		  * We must disable the bitmaps because we are removing
>> -		  * the --objects / --objects-edge[-aggressive] options.
>> -		  */
>> +		strvec_push(&rp, "--objects");
>>  		use_bitmap_index = 0;
>>  	} else if (thin) {
This old comment is perhaps confusing things. The important thing here
is to disable bitmaps with 'use_bitmap_index = 0;' (though perhaps not
for long [1]).

[1] https://lore.kernel.org/git/f50f8df01a9f216d5b4388b2fe4ff58077b574f3.1777853408.git.me@ttaylorr.com/

The path-walk API itself disables the objects walk for the revision
machinery in walk_objects_by_path():

	info->revs->blob_objects = info->revs->tree_objects = 0;

This allows the path-walk API to rely on the revision walk for a
_commits only_ walk and then have the path-walk API handle the trees
and blobs.

The reason we need to add "--objects" now is to allow for parsing the
"--filter" option without the revision logic complaining.

Thanks,
-Stolee
