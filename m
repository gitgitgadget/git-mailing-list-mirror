Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D171514CC
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 04:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288198; cv=none; b=IPfO9TmD5+B+x3JykMbE70NNI5yVaLh2z/go0ixHTz+5EqH2xLvF52MkHMEfKikOvhKQRydZ1JrLT0njRMaS3GzJb5Uw41c9xyxg9sGBmcRlwh84H+fbzYU1gen5Jgj4q7RAooLb0bBF93oOPKF/zy30Prcc3cOno3fx8EpA3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288198; c=relaxed/simple;
	bh=xV/ZUIQ3TQBo+HNmtqYAF/iZo5tryCv/CHJG04syxF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLYH3eYjkaKCefixG+ZYl+yBHQDZsKdwkg+C6deD7EqydZDqIgSVUU5RUFhDdZGROzEYtRpc5o6dDJA5KciV3ELiAM4gF4u5eSUoxWQlwwLJlJW0tl2+AePjCSSfPtV1CFcay/WdARACWY9RzrySKIBKL0sw8YHRx7K3rP8wacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCLs/LZy; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCLs/LZy"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6eeb31b10ceso55498497b3.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 20:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733288196; x=1733892996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8Znii6fpRdga6ASGtsNBWL8Pe42WIAHYhIcy3LDU+w=;
        b=NCLs/LZyLA+T7hEsbTIDm1itkepttgQqg894gB/Tl2BdWHhBVuSnSvWRKc54bdQ82Y
         /8zlCOyXRbUPnKYrkl/OLB2KZ4kWKfa8VnfFpD6LmEjX9io3Ki4z5lQWnnYV+yPa7oob
         QwjRT2x/pm70dWw86ncjRLiqaGi/GLxO21EDvurGJ8Hq/0mtEhRpcKveDBupU3NBmZGS
         duMgBrgqSs9zZ3Q8/yYqLR2vuhbtQ7VQ7sRTs2F9TDZtu5qYlsEaWLfvw10Qnu+c3F7k
         ZOPp4n94fIrmj5edDVSUH3nmqcUau0+GECki5327KF89DvcCuoSIrnmXrWRBnUfL3AaQ
         D+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288196; x=1733892996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8Znii6fpRdga6ASGtsNBWL8Pe42WIAHYhIcy3LDU+w=;
        b=WQiNwrlgWspzL6ryQVyuNdXFMyYkPrfOoiOytMtUtGc8Ymx/17KG3Yy0o6G+sznMYA
         jc2TopykzB4pX5laEevN8hhjGPKvPr1EQJgUDZYMWX1lDAvmGCX71uePoUcMS1DVX+gz
         yp/eicvZSoqJ5gm0Fwt4wHvGA/x2rTlpRrrz3TMgg0C8Cer4sKJ4Cs1sTwXjjqUqCv8o
         5Fn81WHh8ueRrED4BZad9Mm57Yi91C0H/DfqyYjq5JmKIkcYQKOCqiqaMROsNe+RIZ+T
         DQR84JxYPjVS8SMWdiZzdICly7MzFBfuBpgqI4QGhJ74yNtKTYXvaHnGhDB4RpTmVxLs
         ckSg==
X-Gm-Message-State: AOJu0YzMY4jVo8A3IT2YmdHR+KWY4QiuvYsGan7dGMfMl7pOif6aXxS5
	dpxKD9cF40Mxp9dbTXobY6Bozz7nV9WQyJ13puQjC3aUyJZwIAFO
X-Gm-Gg: ASbGncv3d8xE+Ta3mLtWGfm6i30bCxC0BQVJkd1rJBwWHIC43Umiqu1GeuhJibK+zj3
	MNV5/89+ra2y5cB9U111EhKqUZ2BefF382iRrbELZW4nUYiJ/sQZoZcbTlm1+X+uZPBoAZwhZmu
	o9gkUOWPrR5U/d9pg//0zPH21wh6+8apCkJ22UotoKztxZCHMAX/K1IbANuztUkM3Gc7dg9T/Vz
	2/jgPrPMS0hrQXa6qpAw8BZEXPqfxsIoaedfGW9Z2I8tDcy3A9kYB/lt3QQPGGYqSVfdJzr4pOi
	ww2pY/9ELsLeXMdey7yF7fLhDzQO+SZC4L+7IQ==
X-Google-Smtp-Source: AGHT+IEQn68+jsNaDQJl14W2Ethi1Kv2hH3BNJ9C5cIQA77n7ZzIx7mrnT+PDn06kiwCXRJNDKC4XQ==
X-Received: by 2002:a05:690c:490d:b0:6ee:a81e:6191 with SMTP id 00721157ae682-6efbd360e28mr38341487b3.22.1733288195745;
        Tue, 03 Dec 2024 20:56:35 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:b135:d598:34fd:c583? ([2600:1700:60ba:9810:b135:d598:34fd:c583])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ef653a7e5bsm24615287b3.117.2024.12.03.20.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 20:56:34 -0800 (PST)
Message-ID: <b07c6b94-b1cc-4391-83fd-adc5bb5f92e3@gmail.com>
Date: Tue, 3 Dec 2024 23:56:33 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] pack-objects: Create an alternative name hash
 algorithm (recreated)
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
 ps@pks.im, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 jonathantanmy@google.com
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
 <xmqq1pypfo05.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq1pypfo05.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 10:23 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This series creates a mechanism to select alternative name hashes using a
>> new --name-hash-version=<n> option. The versions are:
>>
>>   1. Version 1 is the default name hash that already exists. This option
>>      focuses on the final bytes of the path to maximize locality for
>>      cross-path deltas.
>>
>>   2. Version 2 is the new path-component hash function suggested by Jonathan
>>      Tan in the previous version (with some modifications). This hash
>>      function essentially computes the v1 name hash of each path component
>>      and then overlays those hashes with a shift to make the parent
>>      directories contribute less to the final hash, but enough to break many
>>      collisions that exist in v1.
>>
>>   3. Version 3 is the hash function that I submitted under the
>>      --full-name-hash feature in the previous versions. This uses a
>>      pseudorandom hash procedure to minimize collisions but at the expense of
>>      losing on locality. This version is implemented in the final patch of
>>      the series mostly for comparison purposes, as it is unlikely to be
>>      selected as a valuable hash function over v2. The final patch could be
>>      omitted from the merged version.
>>
>> See the patches themselves for detailed results in the p5313-pack-objects.sh
>> performance test and the p5314-name-hash.sh test that demonstrates how many
>> collisions occur with each hash function.
> 
> These do not sound like versions but more like variants to me,
> especially if one is expected to perform better than another in some
> cases and worse in some other cases.  Is it expected that JTan's hash
> to perform better than the original and current hash in almost all
> cases (I would not be surprised at all if that were the case)?

There are some cases, such as the Linux kernel repo, that have slightly
worse compression using JTan's hash. But the naming conventions in that
repo are such that the v1 name hash was already pretty effective for
that repo. The Git repository has similar issues. See Patch 5 for
detailed analysis of these scenarios using the p5313-pack-objects.sh
test script.

It may be possible to adapt some of the collision rate analysis from
the test helper in Patch 6 to create a tool that recommends or
dynamically selects the hash function that works best for the repo.
Such a feature should be delayed until this code is exercised in more
places.

Thanks,
-Stolee


