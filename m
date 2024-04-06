Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D233848D
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366281; cv=none; b=NVa7O2DRjzKHEWWTVwUyYm7cNxnb+duiPytjEzA2Fga+8TlhsC8cfnc+CSP+6Zkg8DSa9dYif0xQGMZ8GHskGY2aOL57icesG+Ijx5+3XFxWyJCmr2M80gzRktKYADNuzl7Ug6FTZh7WyuPd/xbwwuBOyKwZWNo/zo7ea3gdSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366281; c=relaxed/simple;
	bh=EkvcaWV+VKQgwOwbVDB/MohU76w04mmzCdj4sEoZ5i4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ifq34Z/LHNe/nq0pw7kExSjq23hDpxHj6pZzhsBR0gl8jUjdGlFZXOlCYxBeoT59nz8y2eU6Z1UG8hGoATJxavJGF4QeKzz1wEG2cZbDPxqCgKsXWwTkUknl7wDygv0Tn/mSUZYv12NQjnCfwp9LewMAgaJRdL1Q5rJ9k4ICMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=l1kMO+uZ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="l1kMO+uZ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712366276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXSRauiLLWfM22PpjUElVH3YEMFTr2MwheOljbgZoL8=;
	b=l1kMO+uZDq9KdTiH1zZk+F6nWNb6Cs5eiTunOMcFp8Qj5Ev1HlkcDoy//XILgRmMiCpbb6
	WUZAobLYwIvvDwt0DYfYSZj3Y8TlT2G1Ucv+uGy2GeKiuTN+G294cqxtTA/ksoqDBhPevu
	r/J/T0ryTaaYUVC86f/H/ts+q8TznB8fCNV4jsbfQwmVvVQvQVFLzhIzYVF2V0uFu+UEO6
	cfhya5shBUCqZfgTmf13kAk9tXUVFQhwJCghK2Q8Ymt47/URNvCH/MrLiSfwUKanEtgB5W
	dFqQpII0IK/c8efpoIOh7OwgNmijfYPJ7Z3XpgRhDOhpvn3HY60Az3Hd/O5Qsg==
Date: Sat, 06 Apr 2024 03:17:56 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v3] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <xmqq8r1rs39g.fsf@gitster.g>
References: <e3212c0a4ad331685c68c13afcdbced20982ab32.1712364420.git.dsimic@manjaro.org>
 <xmqq8r1rs39g.fsf@gitster.g>
Message-ID: <235fa26a0803f7a8868fe908e4689bda@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-06 03:12, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> As the final touch, make the above-mentioned prompt emitted without 
>> using
>> underlined text, which also applies to any other produced prompts, 
>> which made
>> them somewhat hard on the eyes, especially because the prompt's 
>> tailing space
>> character was also underlined.
> 
> Don't do this, or at least don't do this in the same patch.
> 
> Another lesson to learn: resist temptation to grow the scope of the
> topic.  Especially with ascetics, your preference may not be shared
> by other users, which would easily hold up the main part of the
> patch you wanted to improve and the reviewers have already spent
> effort on to polish to be ready.

So many lessons to learn. :)  Makes sense, here comes the v4, and
an additional follow-up patch.

> Also are you sure in everybody's
> environment that ->ornaments() call is available and effective?
> That is another thing that can hold up the rest of this change.
> Don't waste your effort so far and build it as a follow-up patch
> and do so after the dust settles.

According to my research, the "->ornaments(0)" call should work in
all environments as expected.  It's also officially documented. [1]

[1] https://perldoc.perl.org/Term::ReadLine#ornaments
