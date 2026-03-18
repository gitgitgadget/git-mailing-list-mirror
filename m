Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82BB366577
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860444; cv=pass; b=NedFwPuPGLy+v0fepmEc2YOfkYr0W8VTLRtS5jpoK9iDLGFTmXDOQsX/82iDRH4r442oLuGjTZFWaKtjmjqmnfytfM+7HSg8hdrd+z3svGELp4RsNXEy3lacTO+WC9RRYvh1MSeaZGgBxWfaq73/SQ2l9MIhhRMNiVcSRFp+w8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860444; c=relaxed/simple;
	bh=lN4Lz2M0tBHaEvHtDiYrc713SnwzMzzZ7ZmE4bvihXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uHNjq0Tlz13j5LA9USO638uAsI3iWvsMjcQ8UA+0OfJzQMNsMWsmFcyypNR2gWkJrravy+bZq1KvwKCfWEvXi5jlZkha521+3iMaqf1PiEwsLGcbmwhKhi+jbi0bPbXRoJE5ulUFEOwaERFcRGE3WwpG+WCQomP+mW3vdh9aQrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=f40mYveQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="f40mYveQ"
ARC-Seal: i=1; a=rsa-sha256; t=1773860421; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GIOUN6dZNN49G3Uhk33thoV+X+NN2Q7PsbT3WxKUgzjYopIobNjO6G+vlHmPtp8pP+1zboky3Y2Qz+44+7XzwFuFAxvHiBbLQ/GSD91cg7FPxFrt4BU5O35omRd0REybEOHFTgC5LrYWPCDfRubOh3WU6zgAY78AXAgzuWNSNL0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773860421; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=s4UnoFA55BIMN+kQt2vkNMGD7bd9VydadJchtJ8SAFs=; 
	b=GprVDSwLKWqoH1N1qz0CVFjWYsPRCeUK3qUQYUu8jkazObZr6hpUsB1Fu5ctZH+7WAXT9uPI06BpyjOcWXWEPfbkwML8/ocplTNjvqOcaltmewarF6h07EJ8K0NfizxiB75gtCyjt2jWAbZn8f3KeyPfdHeYUFU5cXC1wBtuNCo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773860421;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=s4UnoFA55BIMN+kQt2vkNMGD7bd9VydadJchtJ8SAFs=;
	b=f40mYveQzbr2qF1EOWabd/sLhr3L85hMla9vQgvzfC2GIJBlJqBDTINl9pmiIGrX
	ga9x3qfSX0O2S1nGnOmTCoNSy6Htc78lZYLXXfKkfWjHM/DAsQnQ2EGEdGneH/Waa5i
	/30GMYx3/8VSHiVoAyxltD5Y+GJENrckLOGipsA0=
Received: by mx.zohomail.com with SMTPS id 1773860419634757.981411114912;
	Wed, 18 Mar 2026 12:00:19 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 6/9] hook: add -j/--jobs option to git hook run
In-Reply-To: <xmqq7brcst9o.fsf@gitster.g>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-7-adrian.ratiu@collabora.com>
 <xmqq7brcst9o.fsf@gitster.g>
Date: Wed, 18 Mar 2026 21:00:14 +0200
Message-ID: <87v7et0xq9.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Sun, 15 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> diff --git a/hook.c b/hook.c
>> index 815b299bf8..299cbf9e97 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -567,15 +567,17 @@ static unsigned int get_hook_jobs(struct repository *r,
>>  	if (!options->stdout_to_stderr)
>>  		return 1;
>>  
>> -	/* An explicit job count (FORCE_SERIAL jobs=1, or -j from CLI). */
>> -	if (options->jobs)
>> -		return options->jobs;
>> +	/* Pinned serial: FORCE_SERIAL (internal) or explicit -j1 from CLI. */
>> +	if (options->jobs == 1)
>> +		return 1;
>
> Hmph, puzzled.  
>
> Shouldn't just -j1 but -j12 from CLI also trump configured
> parallelism?  Which was what the code before this step already did,
> no?

Yes. I think I was a bit unsure of the -jN priority when writing this,
whether the -jN arg is stronger than for e.g. if the hook is marked as
parallel = false. What to do in this case? :) 

As you noted on the other patch, the user's intention is clear when
passing -jN, so maybe we could bring back the old code and issue a
warning, something like:

"hook X is not marked as parallel=true, running in parallel anyway due
to the -jN flag".
