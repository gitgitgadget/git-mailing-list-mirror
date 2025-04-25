Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B681F17597
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745552979; cv=none; b=TvElS6reAs0DXcWkmkaQ3U21rHZ6cfBvYQaQ8Kmrigogr7SRzKVju4D5u9yuxCXicE7AK1HDgAuEe9N/fT+wdVhiNepuabOUmDnKtrDkN4aGfPd/tKrtXMHzJEMY4H9rsUXV0oCfPACbBQWavLeJnClhUi2JXy9KWAst7h3OWoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745552979; c=relaxed/simple;
	bh=vNWyAKb1nS8SLs0iywkt7S7RDgcNBWrioodVC76NXZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrD8geEO1Mdit6LnS/KHYHkMvSjZgE99YXBcSZc/t09ZvtMVepPc3jlE5FfOp2NHWgUCEi7Ewres5SjDL+1nu9xj5ulJ7XIn06zKJctnm40Qly4KtksDHVxFmHysqRoc9FPcR0w10KBM378mpxZ8ZPwhgSzU8gr3k6ohE+po0lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj4j9cis; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj4j9cis"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7082b3d2960so17391287b3.2
        for <git@vger.kernel.org>; Thu, 24 Apr 2025 20:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745552976; x=1746157776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUPBfT0FFUDtDt41wBhZhGuF9F3Vvqv5jrLqQZXt6eQ=;
        b=nj4j9cisT6cFtgGW3bnG1vV+XZLd7Q9JbDt1wXYtEHgztkqXbN95lrFZ1ezTPtFCSP
         q+m/QE7nmP3Doy7qNqw/duuJSJOgxv9XLbxHhOjecY1XCdKSSYD+xPI/4h1vXinyuFYj
         ey2HT9af1LRHuvTJe5+xqhvS0V2kwBc0jlUx6kfWmn60wwofFuMNmvwOpV7u9GvxsBxi
         SYUTQJ+Zxa4FlSCWDX71n61dgAFEmW0NezKrcDIEQqK6oAn/j9W+eOqcRzQYhMCtHIXI
         QxDX3w9Y7ycVIADSFK2fONuzcry3m0in3wKaHL98DBtGX6OZOHAbpKr1Iw4Y0yKVWio0
         xfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745552976; x=1746157776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUPBfT0FFUDtDt41wBhZhGuF9F3Vvqv5jrLqQZXt6eQ=;
        b=J/Tgps04MBXOMlPJlTjdz7QyKSkS0lFyFO87/Lk2v1dUg/rAvemqAZQ3M9b39sKw1s
         DqAZj2yq0zAPB5d2wyR7JLN66e/ZxsqhLWmmoSr0fkfA0tcRSWKaOEcfgPQOmMfL4F6m
         bzHlNAfxr/PbG0fSBDO0MQZ+Sg58MQxz2BrZ8cI9mjD68JTaHfrDqMMAvh41fQ082ykI
         peRUPSbFp56d1RymAwhEvFXd6z725yUUfQfbbs3AqmCDc8B72kDJNu1WxU3HRnsgdx9h
         CroojmzLsz/TsvJ3rlN9+Bc8lhIhR7KaLronvjjpsnVh/4KbTCYTu4grOkJMYwF4c0Fv
         oQFA==
X-Gm-Message-State: AOJu0Yzpn24t2yib3aRKAwz6s3IhSkC+Kiis1n9+CX/MvFXaEBnH3b92
	eCmcFCWHxfEhyBOmnfGjfUmGezPZzMp43jDUWpR5cRjSrAkBbtMO
X-Gm-Gg: ASbGncsHNcMKwb/6kHrvyav3RizOZf38pq3nfq9zwZxlyPIZSPW9TIqcAxUQSIPSHkD
	tzK9+oOSXphjtZEP13HNV/RG9v5nZxUr+T4TGsYhHfJfOpWGLjpSOdy3ll9qIYKwzLsmG/AXuhS
	+hPpngrMiEeTR281gWp5mJ0EEhvt3L517yBpJYAWmds/7WINy2T5h9CjLC699mBcna4/p734uDg
	jbwPGug7pMkvX3rrLMe452vfE4TCCZXjhJKXCYVTwjxwLpiwC6GSmJECO5DRkoxop64uKKLVTzV
	QOmpuJDwzCP0Ke4FJ+HztDzIVQx3uzsWUt6WcSabvGR0UBUtSee9W6JAJ+48CNZfrT0USVn8shN
	JLl3gCe7Y9vLqHOiZ
X-Google-Smtp-Source: AGHT+IFYoDOobgwbAXwlGRi/ivt7/Gzj+A2KZnMbQuFeQl41L0bF4w/0VLX3iIMr1aik5acQjPJsBQ==
X-Received: by 2002:a05:690c:f92:b0:6f9:a53b:2a84 with SMTP id 00721157ae682-70854201207mr8935187b3.36.1745552976467;
        Thu, 24 Apr 2025 20:49:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:a8a1:d0ac:ba22:7cd4? ([2600:1700:60ba:9810:a8a1:d0ac:ba22:7cd4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70841aeaa46sm6784787b3.100.2025.04.24.20.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 20:49:36 -0700 (PDT)
Message-ID: <d7313975-24a7-48eb-9626-66a3e53d4234@gmail.com>
Date: Thu, 24 Apr 2025 23:49:35 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] index-pack: allow revisiting REF_DELTA chains
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
 <27d36402fe9c8262c459d606bf4aace1919aa2ae.1745430004.git.gitgitgadget@gmail.com>
 <xmqqjz79texy.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqjz79texy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/2025 5:41 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> As detailed in the previous changes to t5309-pack-delta-cycles.sh, the
>> logic within 'git index-pack' to analyze an incoming thin packfile with
>> REF_DELTAs is suspect. The algorithm is overly cautious around delta
>> cycles, and that leads in fact to failing even when there is no cycle.
>>
>> This change adjusts the algorithm to no longer fail in these cases. In
>> fact, these cycle cases will no longer fail but more importantly the
>> valid cases will no longer fail, either. The resulting packfile from the
>> --fix-thin operation will not have cycles either since REF_DELTAs are
>> forbidden from the on-disk format and OFS_DELTAs are impossible to write
>> as a cycle.
> 
> Loosening cycle avoidance indeed is worrysome.  How do we guarantee
> "since REF_DELTAs are forbidden from the on-disk format" (it is
> obvious with OFS_DELTA only you cannot form a cycle)?  By code
> inspection and in-code comment for the code path of "--fix-thin"?
> 
> I think the most interesting question would be how, with the
> loosening of the cycle check in this patch, we would still protect
> against a malicious on-the-wire packdata that has a cycle in it
> already, where deltas cannot be resolved.

The good news is two-fold:

1. We have a test in t5309 (index-pack detects REF_DELTA cycles) that
   checks this case and did not change behavior with this patch.

2. If we don't already have any of the objects that exist in the cycle,
   then we can't _start_ expanding the objects to their full contents
   as we don't have their bases. So what is left is a list of REF_DELTAs
   that have not been processed but also a list of base object IDs that
   we can't load. We'll fail without writing those objects to disk.

Does that satisfy your concerns in this space?

Thanks,
-Stolee

