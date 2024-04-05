Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD716171061
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337542; cv=none; b=ikB+z7g4C3MkcinNMajVuoCUAP3IQDZGbIKGNIMq4ImkRGfEd2bdaRrd9zzIkihVG8TrUaEdFUYMS506izvXsDYVEWqQmBH2ncmA6YPKxNn4bQvrD8en5b9d/zLc1jRNzC6ixMYCbMkuxlxdgUE/mrz8yu70PSrasyMStnzu0Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337542; c=relaxed/simple;
	bh=aP5dEYhbPUgR8KbUdtiIIpaiJfZnbzUD9ED5EXgF3Rk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GlUHZKQ9lRSSK+onViZOSxJuFFu1ggWj5lkRU8MELVEt0qOgZ1saYauJHSzGPA5P/IzMlh9tnbSWy3yfGmHzU1brNWLe8mTPV7keCPTCMwXjIB17akQMtszyB7NsB0yB1mWhR0ZVMKcoCDpiOIb085agyq9OW15HPPpmdQWYwF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jTsOAljr; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jTsOAljr"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712337532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBj49rdBVP8VOJxbDyAyI3EO9G5HvZCEaQU/3rxckiM=;
	b=jTsOAljrzAdmrtgn61T5jhMyQIVLMLGEiX565LAkvmoDY4XNHMj9/7saxOaK6xTRjCugqJ
	cyweTtmcPIM5eLIhRKiR7G/YKinQJp4NAvv6AKLy92chd9Bp3RLP1M4EB5+52ZiY7czIKM
	bKQRy37UnGUVuThe2sQ1PBJlOsVlIC71HPpdJrOd9dgIZ3w9r8j2WMkBJXVMTBzkzKZMEP
	84F7PBQLsTCdg57xv9GF0fww7RLSTX7uk/MiujnhlOP6HMPN16kj9/NbFpntODLfKxi/c2
	/jgp4Jdl77uOjym/pZncdpDURuRsgejlqPQ6+ilByKnAJuDeB84bKB1WqjoC2w==
Date: Fri, 05 Apr 2024 19:18:51 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <xmqqplv3vijx.fsf@gitster.g>
References: <0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org>
 <xmqqzfu8yc40.fsf@gitster.g> <8d47bd687f2ad80bbc1e1c86ae337327@manjaro.org>
 <xmqqjzlbwyhr.fsf@gitster.g> <fa91b134e6cb18578d9c499f584ae3c5@manjaro.org>
 <xmqqplv3vijx.fsf@gitster.g>
Message-ID: <fd70ae57ab668e6789210ad6d1ff0e80@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-05 19:13, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> However, making the vertical whitespace a separator also follows
>> the Git's general approach of not wasting the vertical screen
>> space whenever possible, so taking the separator route is actually
>> better, if you agree.
> 
> Of course.
> 
> If the topic came from a contributor with a longer track record and
> used terminator semantics, I would have insisted to consider
> separator semantics a lot more strongly.  With only two commits in
> this history of any tagged releases, you are getting a bit more
> lenient treatment ;-)

Ah, makes sense, thanks. :)  However, please don't hesitate to be
more strict, and I'll also make sure not to take any "shortcuts"
in the future.
