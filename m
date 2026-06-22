Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99FB399000
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135366; cv=none; b=d4/WzYEWuXVRoJkY1771L7aPbyapfXdVU3Cajn95pVN1G3U4PPsKnmogYMykJ/lrSeoFOFOyWjbd9QWVT82czAy3abZpwcgosxEszT/iEwR6dJlYpm7yPGCCtVUmQ5UI5lGXTN/vn5QTWsXkSXZnoqLRqbdu42yXs9a9MhIB8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135366; c=relaxed/simple;
	bh=czIIwMqIK+LPq0g45HSlxsFwyMa44bNuCtqsWwzX0zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4WLBSOKc02evUrByJejeSR+8r084JHXEtMMBCYA/WLQuDw+khEGXhoWTEBMr6ogwBVOmWL3Ag3FH5kQEUylUC8gdsa6k+brKIQclugIr4+zhcsXKw12BUoo05LJECuCv/koA8YK22F9vGfbeen9vBdynRYlIqDlB5S1CTNwgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpZk3j/9; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpZk3j/9"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7fd6b4d5d49so34658967b3.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782135364; x=1782740164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdfrSl6dyd2JDSpWKHvmxcLnXgSv5VdwRgf48OJHUuA=;
        b=EpZk3j/9mI7t1vDJy42hI/+ks8uAAazqeYwpsCCHt0/xyRIxQkmqXv0VmwEh1gAngW
         Q9p3MqmQ1v4diUnWMT5MkoAM82lBGJALM0F77q3OuPvTpBWL8fFQTjMiXsu0+/tBKUWa
         5oAUnu1AM/1YcCLE4R7fEqvG6OhXpmmkPbWcHLbSSayAhrq0XQ4fOCqQEWPfuDRjJ8L0
         GZc7JKzeP64AfGhGdVOcZSoxkg9avfBoPBt+lQx62uPIuKv4/DTLTl4Q1pPKZ8Lhe++R
         TzoufUKFXYUbs3wzMQFW1T+Te3y/RzjB7bksDfblmKmat/4jdmQNQNJpVGWZ2ppB5alI
         RMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782135364; x=1782740164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdfrSl6dyd2JDSpWKHvmxcLnXgSv5VdwRgf48OJHUuA=;
        b=j/1svchauqiyKBFdcdr+fiS4sJWc2NyiyKHl6GqlLSXFZ2lS2+i6qWlXoysw3D3Jfv
         bJYjXo52knNSGiVmZkJd8BrRppvE86m//7HZaXMMFEXUK2hRH/rcz/x6sUmPP1tI2Yo5
         hpe9CQ4YhoK99ghxVplifEAvwHFZbxLyUG1QFQHKvVTazQESDUUBW6vbAx5Vm4CBFnSU
         ueqVSNYAjtak8c8vRgbNw7JhyhrNxeUkEnyyGuqJQ3UX+f2gPMGvmH4vzUxqxF9lJxif
         77k9aCDlCGkuvUqmq/e0DtQgswijMxEj5VsC+kw3MBz8LeFSmVn7cHpPTn5MFoTS9lGL
         DvAQ==
X-Gm-Message-State: AOJu0YxHAvPl/1VSQoxDxVzlwMF+6cIqAISCbeta2/chl3JLzLj3JNU8
	hTcQwVqE4R/3kOXGGsSnsXUawqEaxJ0EkEr0zOPO5sli40sQ+uCsEK6r
X-Gm-Gg: AfdE7cmLh7y0i/Jam2ohOhWzk4cTBJGQomuBmVKwBMH1JORKgv4iSqOa9yACYuy192v
	TMzsJQi6sZki0/O2S/FhTju0vSFHi1fle9BimBTHKdWeCCPJC6WrYRjxb6jmay+cHtEK4gtIH8A
	3mYyf3e1EhQonBlpxEo64xoWjnEZo2haY+p2W4ORooLdhBcvk7vSZR9zNi+UsMAnIX5/0JX4Mlv
	j5C9g5GtmI8UBpZ7lLOK3aUj3Bw3oxfq1RAGV9VVGgyjbs/rpG5fhVnbGrj4vvuNwI73qIxpX/f
	VwCEZhaNpUZ0PJsX5G6UQdSCEo1MdXd98jrcbddc1Ix4qfgR6t61i+G2vM620p2eIARktT31zD3
	/symfgYZSveFUMAPyUNX3DQXEOIgYogwfbhyzN8vPzvLtyRGidNCxaJHFUld1um+PCTTzMsLhY7
	vMUsGc+RQMDQDgx0CXcBAQP+Go8FzPasGq6D196XILvwz+acqyWFt/dCeHRA==
X-Received: by 2002:a05:690c:4:b0:7c6:e377:1dc6 with SMTP id 00721157ae682-8011d9f6712mr119130727b3.0.1782135363948;
        Mon, 22 Jun 2026 06:36:03 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf6432dsm31373207b3.14.2026.06.22.06.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 06:36:03 -0700 (PDT)
Message-ID: <b6ed816c-030b-400a-9fb6-6671fd3cb0b0@gmail.com>
Date: Mon, 22 Jun 2026 09:36:02 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] pack-objects: support bitmaps and delta-islands
 with `--path-walk`
To: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1782082975.git.me@ttaylorr.com> <xmqqmrwn3u4x.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqmrwn3u4x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/2026 3:35 AM, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:

>> Outside of the above, the series is functionally unchanged.
>>
>> Thanks in advance for another look.
>>
>> Taylor Blau (4):
>>   t/perf: drop p5311's lookup-table permutation
>>   pack-objects: support reachability bitmaps with `--path-walk`
>>   pack-objects: extract `record_tree_depth()` helper
>>   pack-objects: support `--delta-islands` with `--path-walk`
> 
> Very cleanly implemented.  I am not confident that I have followed
> the detailed logic around delta islands in the last step but the
> earlier three patches looked trivially good.
I've been happy with the code, subject to the new data that is presented
with this version confirming the expected performance benefits. I also
lack confidence in the delta islands features, but based on my weak
understanding it looks correct. I believe that Taylor has the right
expertise here to make up for my lack of context.

Thanks,
-Stolee
