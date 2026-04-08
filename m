Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248839DBCA
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665632; cv=pass; b=hNv3qLz15cR8dNGAVDzYNAJ7S1FqSYVe2KRYyWjs5sKR3lwxQUorYhuUn+YHQmarg7IMcCyMEUMyPp5DqHObPsudbwRT5G63RVlcVQvPcomt2IsI3HdtlVzaxIrjOcHnxh29c7eSa49BXp70aaKAbUnS2DxW13LDlRgd1UdTJAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665632; c=relaxed/simple;
	bh=GfR+n4gi+FsdoTs6xw13kp21rSq/b3V4pg2yW0qsyg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gWHe1ZPEKDlYFJR9Nhthk8z840fmnyWddwfYRXhIIUJdI7drL5utTHQVsmpciqL+sWeF5tsHqOftWmkKvOyhssFaEDLUUpyxlHeBosR8klq9mRshY56r4i4EOABeU7G3/1xAU+oyO4hBwayvH/6gsNJW9ifDQRhI8oIke0CYHYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=OM3zHVzh; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="OM3zHVzh"
ARC-Seal: i=1; a=rsa-sha256; t=1775665624; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eiDrIWxJ+dS3aDfUrl3JMfVR+qyl8xa7UJiHhrx3+14jgbKgKoYmRwetAD9jzPWeKYsQgn0VMSwLqfWnm1W+6pn4FDlrM8NvxcOGmMKK5n7IAmSS4+dntdbL+P94qT9T9tWrh3VYArvo+9TzWQOgVqhwcw4aZvmHi85D4AaGLrU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775665624; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oCWYtzgpPM7oaTPMRJondRnFAOOjUUKpSdI33h+rRjs=; 
	b=ET2Hm/PQE/RUswUsB1psexDeRyxq9PLg099wa8WyH2+r/uB3flcmknDdiRam0PxGO1CYWLLx/zrIDLpXyYcizamtQF+2cRhiw0+0fDt9pLkTL8TdNnDipQunJ8BVAvfmbSliWrdhdLH18A2nhr9GK13ifsX4moTqa5UBlOTYCd4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775665624;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=oCWYtzgpPM7oaTPMRJondRnFAOOjUUKpSdI33h+rRjs=;
	b=OM3zHVzh8zKT3zgMcKGBKTyu/+BQGd7KD2xch6Dwh135QqxQAMAAMTMhCXMg8bwm
	bEJl34dE8hVqZrLzn0hl7rOThh4AKe7xwiyenumKVDszkHBTY73YDZiShsoMQRzT1Bx
	t+X2cL6V/N4SNrd96YRXqXdXHLUSyilUze8cypNI=
Received: by mx.zohomail.com with SMTPS id 17756656229811010.5714132579644;
	Wed, 8 Apr 2026 09:27:02 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: Help needed on 2.54.0-rc0 t5301.13 looping.
In-Reply-To: <xmqqpl491mfd.fsf@gitster.g>
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>
 <20260408052031.GB1324339@coredump.intra.peff.net>
 <xmqqpl491mfd.fsf@gitster.g>
Date: Wed, 08 Apr 2026 19:26:59 +0300
Message-ID: <87y0ix1kq4.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 08 Apr 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I think the root of the issue is that we should not be trying to
>> propagate SIGPIPE to the child in this case at all. Our handler is
>> pushed there only because it's part of sigchain_push_common(), which is
>> sensible: in general if we are dying to SIGPIPE we want to do our
>> cleanup. It's just funny in this case with the ordering of our SIG_IGN,
>> because now that SIG_IGN isn't on top of the stack anymore.
>>
>> I.e., I think we want to reorder like this:
>>
>> diff --git a/run-command.c b/run-command.c
>> index 32c290ee6a..8a95f7ff1e 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -1895,14 +1895,19 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
>>  					   "max:%"PRIuMAX,
>>  					   (uintmax_t)opts->processes);
>>  
>> +	pp_init(&pp, opts, &pp_sig);
>> +
>>  	/*
>>  	 * Child tasks might receive input via stdin, terminating early (or not), so
>>  	 * ignore the default SIGPIPE which gets handled by each feed_pipe_fn which
>>  	 * actually writes the data to children stdin fds.
>> +	 *
>> +	 * This _must_ come after pp_init(), because it installs its own
>> +	 * SIGPIPE handler (to cleanup children), and we want to supersede
>> +	 * that.
>>  	 */
>>  	sigchain_push(SIGPIPE, SIG_IGN);
>>  
>> -	pp_init(&pp, opts, &pp_sig);
>>  	while (1) {
>>  		for (i = 0;
>>  		    i < spawn_cap && !pp.shutdown &&
>>
>> Does that make your problem go away?
>>
>> I suspect we could construct a related case that does fail on Linux
>> without the patch above. Imagine we actually have two hooks running in
>> parallel. The first one is fast and does not read its input, and the
>> second one is slow. We'll get SIGPIPE writing to the first one, and then
>> kill _both_ children. But that's wrong! There is no reason to kill the
>> second hook, as our intent was to ignore SIGPIPE.
>
> Oh, I am very much impressed by this analysis.
>
> As -rc1 has already been tagged (but not pushed out yet), we would
> probably want to apply a fix before -rc2, I suppose.

Yes, that is fine.

All my local tests also look good with Peff's patch
(including the parallel series).

@Peff

Please let me know if you wish me to send a patch or if you wish to send
it yourself, since this investigation is your work & effort. :)
