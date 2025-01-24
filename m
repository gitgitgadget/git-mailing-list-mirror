Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E5F1D5143
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740091; cv=none; b=Bm61D9hWm8F38EKIbsM799QLUoAN5I2VOvK8DISl47/rkc/CMQCe0zvzyNO6tJQ/W9O6oFz6IsRZtysdsBBHgba4o7afOTD+D2zFVF3IZfbmgO4FIdVirYc44EuM5zk4aylLMS/HtqqfQ9QOiqKY/rHHLraH7ZGMXyvAbhAPEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740091; c=relaxed/simple;
	bh=Pkv2j4apFFqT8GlxeuESXY8g5SJo718rA+cJ1nvhbSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hun0QBPAvFrl/3eOsZnUJRKghhE7mwU2SL+qb5oHVlIlb4ZiUSTBXzxgpeiV49DiiJOhYtRD54UyBhRpNnHyRKXS6NoPddSsvsyzM22KVCrTqmmCfqIHW2IImUcROkCpoWanTVzsCoZYAZzJAyBxQ7HCYCRDdq1F6o9aRjGFY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8WiB/0u; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8WiB/0u"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e398484b60bso3729763276.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 09:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737740088; x=1738344888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xU/AUFv88Etv6TahKAvEztobQncvcFoLep3l+fATjnA=;
        b=I8WiB/0uz2//PnMSKW2oe1qALzomlvK2raogc+IAo+CB+hQJZnEjPIkFvRpKd3teaP
         9tHw4FHgc+F2zuHA2N5yZDLWTFVemI8p9S7/1/GaIDkvgrEf/FSCS1b6Q+mag41L+bNm
         i8ziVTW1zv3t5MgzYkZu/kM3D9suIsudMDDpS7H9/KapyMLSnKpwXa8AU58qLP24hM2P
         vs7syvIbPyUMxK5LFlFIA0jS5Q8GOyi4E9rHlVg3x1m9ho7/qchYytaS/eSYwosz/+Hi
         zONxqu22PDnYXPsuug3p7Ws5RUG73oRlxRNoQDJubbOVHBGzOKw+8DwIYcwKo9D4d2MG
         w8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737740088; x=1738344888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xU/AUFv88Etv6TahKAvEztobQncvcFoLep3l+fATjnA=;
        b=Qm1WWX4E8Ib4dD6ktfBk8+NO4hCT/3K69a9b/bgSOBJsi4eJMMqUc/QLHwNT+3RmfH
         KB51oC4AD7mX0kFQR5rnJDW++hZMHY4wDZImiK6MTFaw7r1xZZMGBDuXEhBlb/bpD/r0
         tCnbaTfCyE7gubDcMSGovlU9xf36BMjlfKCNGhzJNcy0a3Iy9gjTsCoRpkMzBBUQQwIX
         YojSPzRQ5oXXgkJwDFHj72js5jh9lUH1KXbRumkwZPgr1KyYdDItez+pcHgieYp1TufH
         WsNfpTn/tR1oHBUvJk7dUYBSdaEB4mWeNCSE+diI1Ez/oEqiw0gvudNPPevxAeNKCyT+
         0Jqg==
X-Gm-Message-State: AOJu0YxhrZFVaZO+luetVRVer9BbunreLABFwHLcnErN6PmUI66zmp1o
	fAx00Jj252/kLkP7R8k21n53Xl0aYN3Di2wNTWxYrVQUy4zPpy2Y
X-Gm-Gg: ASbGncve7n3AWMi8UAYPGcQDU42B8tuMoKAfQ0LbEEgh+xdGdrqximkun2wvqn8VTFH
	ugbIxgIpm83KeprA0rVHk9RGzUc7dZJY10U3QM/4tpOQ7ylsf90wjX2BEr2h8tgZ+r8DpBSHGO4
	UCLvm+Al8rIjMj/3hSqjUSRzok921nY+jQadDETSYuzc/rXRum9ckEhRb0F2q33kuonGBmRa0mV
	C6BQaCEsYdClzU4RkSCDJH7tjJCWcS3djE1fvUQD8+RvRQd0cwpQs9MdZhv/zN7c/a1NPVyk3uK
	u8sykrtZxItex7YXhmiV/vGa/PLkauvqbL8gYMcx2MTJYlSrMXek61/idTxS3B5msINB
X-Google-Smtp-Source: AGHT+IFPWHz9mtqGObvmCMlD7VwWTnvjaKc8+xhoFEGOuXNAnhCS7sljtZmrJqjEWlZvStGp0zZ8mg==
X-Received: by 2002:a05:690c:6510:b0:6f5:393f:cf27 with SMTP id 00721157ae682-6f6eb6b5526mr256383507b3.20.1737740088222;
        Fri, 24 Jan 2025 09:34:48 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:c52c:1d3e:3dc2:a210? ([2600:1700:60ba:9810:c52c:1d3e:3dc2:a210])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f757a372fbsm4032517b3.117.2025.01.24.09.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 09:34:47 -0800 (PST)
Message-ID: <3a9b10f4-95b4-466e-9214-dff54d2e2123@gmail.com>
Date: Fri, 24 Jan 2025 12:34:47 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] pack-objects: add third name hash version
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
 jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
 <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
 <3d63954f318e5133630b1f579a399a123e434cf8.1734715194.git.gitgitgadget@gmail.com>
 <Z5FzE1XpBlEyhK2T@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z5FzE1XpBlEyhK2T@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/25 5:37 PM, Taylor Blau wrote:
> On Fri, Dec 20, 2024 at 05:19:54PM +0000, Derrick Stolee via GitGitGadget wrote:
>> Create a third name hash function and extend the '--name-hash-version'
>> option in 'git pack-objects' and 'git repack' to understand it. This
>> hash version abandons all efforts for locality and focuses on creating a
>> somewhat uniformly-distributed hash function to minimize collisions.
>>
>> We can observe the effect of this collision avoidance in a large
>> internal monorepo that suffered from collisions in the previous
>> versions. The updates to p5314-name-hash.sh show these results:
>>
>> Test                               this tree
>> --------------------------------------------------
>> 5314.1: paths at head                       227.3K
>> 5314.2: distinct hash value: v1              72.3K
>> 5314.3: maximum multiplicity: v1             14.4K
>> 5314.4: distinct hash value: v2             166.5K
>> 5314.5: maximum multiplicity: v2               138
>> 5314.6: distinct hash value: v3             227.3K
>> 5314.7: maximum multiplicity: v3                 2
>>
>> These results demonstrate that of the 227,000+ paths, nearly all of them
>> find distinct hash values. The maximum multiplicity is 2, improved from
>> 138 in the v2 hash function. The v2 hash function also had only 166K
>> distinct values, so it had a wide spread of collisions.
> 
> I had a little trouble reading this section of the commit message. I
> think the framing makes sense (v2 has collisions which can impact pack
> generation time and/or size), but this section explains v3 I think one
> level too deep.
> 
> This comparison (and the one below it for v3) shows a reduction in
> distinct hash values and the maximum multiplicity (I'm assuming for
> colliding hash values, in which case I might suggest renaming it as
> "maximum collisions").
> 
> But I imagine that many readers will primarily care about the effect of
> the new hash function on pack generation time and size. You show that
> below, but I think that it should potentially appear earlier in the
> commit message.
> 
> Alternatively, you could consider leaving the time/size table alone
> where it is, and devote an extra sentence or two to explaining the
> impact on repacking time/size that the two metrics above (distinct hash
> values, multiplicity/collisions) have on the repacking time/size.
> 
>> A more modest improvement is available in the open source fluentui repo
>> [1] with these results:
>>
>> Test                               this tree
>> --------------------------------------------------
>> 5314.1: paths at head                        19.5K
>> 5314.2: distinct hash value: v1               8.2K
>> 5314.3: maximum multiplicity: v1               279
>> 5314.4: distinct hash value: v2              17.8K
>> 5314.5: maximum multiplicity: v2                44
>> 5314.6: distinct hash value: v3              19.5K
>> 5314.7: maximum multiplicity: v3                 1
>>
>> [1] https://github.com/microsoft/fluentui
>>
>> However, it is important to demonstrate the effectiveness of this
>> function in the context of compressing a repository. We can use
>> p5313-pack-objects.sh to measure these changes. I will use a simplified
>> table summarizing the output of that performance test.
>>
>>   | Test      | V1 Time | V2 Time | V3 Time | V1 Size | V2 Size | V3 Size |
>>   |-----------|---------|---------|---------|---------|---------|---------|
>>   | Thin Pack |  0.37 s |  0.12 s |  0.07 s |   1.2 M |  22.0 K |  20.4 K |
>>   | Big Pack  |  2.04 s |  2.80 s |  1.40 s |  20.4 M |  25.9 M |  19.2 M |
>>   | Shallow   |  1.41 s |  1.77 s |  1.27 s |  34.4 M |  33.7 M |  34.8 M |
>>   | Repack    | 95.70 s | 33.68 s | 20.88 s | 439.3 M | 160.5 M | 169.1 M |
> 
> OK, now we get to the chart that I demonstrates the effects of each hash
> function on the most externally visible effects. Are these measurements
> taken from the fluentui repo, or somewhere else? In either case, it
> may be worth mentioning.
> 
>> Here, there are some performance improvements on a time basis, and the
>> thin and big packs are somewhat smaller in v3. The shallow and repacked
>> packs are somewhat bigger, though, compared to v2.
>>
>> Two repositories that have very few collisions in the v1 name hash are
>> the Git and Linux repositories. Here are their stats for p5313:
>>
>> Git:
>>
>>   | Test      | V1 Time | V2 Time | V3 Time | V1 Size | V2 Size | V3 Size |
>>   |-----------|---------|---------|---------|---------|---------|---------|
>>   | Thin Pack |  0.02 s |  0.02 s |  0.02 s |   1.1 K |   1.1 K |  15.3 K |
>>   | Big Pack  |  1.69 s |  1.95 s |  1.67 s |  13.5 M |  14.5 M |  14.9 M |
>>   | Shallow   |  1.26 s |  1.29 s |  1.16 s |  12.0 M |  12.2 M |  12.5 M |
>>   | Repack    | 29.51 s | 29.01 s | 29.08 s | 237.7 M | 238.2 M | 237.7 M |
>>
>> Linux:
>>
>>   | Test      | V1 Time  | V2 Time  | V3 Time  | V1 Size | V2 Size | V3 Size |
>>   |-----------|----------|----------|----------|---------|---------|---------|
>>   | Thin Pack |   0.17 s |   0.07 s |   0.07 s |   4.6 K |   4.6 K |   6.8 K |
>>   | Big Pack  |  17.88 s |  12.35 s |  12.14 s | 201.1 M | 149.1 M | 160.4 M |
>>   | Shallow   |  11.05 s |  22.94 s |  22.16 s | 269.2 M | 273.8 M | 271.8 M |
>>   | Repack    | 727.39 s | 566.95 s | 539.33 s |   2.5 G |   2.5 G |   2.6 G |
>>
>> These repositories make good use of the cross-path deltas that come
>> about from the v1 name hash function, so they already had mixed results
>> with the v2 function. The v3 function is generally worse for these
>> repositories.
> 
> I appreciate you sharing some counterexamples as well.
> 
>> While the fluentui repo had an increase in size using the v3 name hash,
>> the others had modest improvements over the v2 name hash. But those
>> modest improvements are dwarfed by the difference from v1 to v2, so it
>> is unlikely that the regression seen in the other scenarios (packfiles
>> that are not from full repacks) will be worth using v3 over v2. That is,
>> unless there are enough collisions even with v2 that the full repack
>> scenario has larger improvements than these.
> 
> This is the paragraph that I thought most about (both while reading the
> above sections, and then again after seeing my internal thoughts written
> down here).
> 
> It seems like the general conclusion is that v2 is a strict improvement
> on v1 in almost all cases. v3 appears to be an improvement on v2 in some
> cases, and a regression (as you note) in others. But I think more
> importantly (again as you note) is that the improvement from v1 to v2 is
> so pronounced that it's unlikely that the regression from v2 to v3 will
> matter or even be noticeable in most cases.
> 
> Are there easy ways to detect when v3 would be an improvement over v2?
> If so, then I think exposing those detection mechanisms to users (either
> as an automated tool or through documentation, perhaps in
> git-packing(7), which is perfect for this sort of discussion) would be
> worthwhile. Then users could make an informed decision about which hash
> function to use for their repositories.
> 
> But if there isn't such a mechanism, then I wonder what would drive a
> user to choose v3 over v2. I suspect the answer is that curious users
> would try repacking both ways, and then stick with whichever one has a
> bigger impact on the metric(s) they care most about.
> 
> If that's the case, I suspect that v2 will be the dominant choice,
> especially if we consider changing the default from 1 to 2 at some point
> in the future. Given all of that, I share your feeling that it may be
> worth dropping this patch entirely. It is true that some cases will be
> worse off (at least compared to v2) without this part of the series. But
> it gets us out of having to support v3 forever, or go through the
> process of deprecating it. I'd like the project to avoid both of those
> if possible, especially if we don't anticipate many users will select v3
> over v2.

Thank you for these detailed considerations. The most important one, in my
opinion is this:

 > Are there easy ways to detect when v3 would be an improvement over v2?
 > If so, then I think exposing those detection mechanisms to users
 > ...would be worthwhile.

I agree that having those detection mechanisms would be good. The test
helpers can provide some of the information that helps make that
decision, but doesn't form opinions or recommend thresholds for one
over another.

I agree with your overall thought that we should eject this patch (for
now) and focus on the v2 as something that will help most users. We can
learn from that and use that to inform any future iterations built on
this framework.

Thanks,
-Stolee

