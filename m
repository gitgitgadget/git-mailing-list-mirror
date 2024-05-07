Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F4D1854
	for <git@vger.kernel.org>; Tue,  7 May 2024 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040119; cv=none; b=stqPJLxbdd6GTYNJUJKF9UDXuSsJPeuEOc7EGUt+uK34fG3cZ5sbuJgJMtGAUR6yaqJUmv7wXHTeL0+YJPfHCXpCYjtR9wM/hqKpt4KrY0qBFvFtrDEle4bmyGCcFnk8ggknMkahBoRNNkIrcQfAtQ316ucFr03A0ranb8vwPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040119; c=relaxed/simple;
	bh=xqdPseWoJuL/Az6q2ZNa3wUR2vnW3OvxIOZGm58Q4m4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Skn5LxVMpE9fTRJU8nkDcLMG+EDKG+wzBJiYQVrm4HkvcBu0U6Kl1ddlALkyHMKCBFId+8nS594k5ZjuRXtoaVhsDEOA0g50KOsG7n+HHqdCbbdxrn5kDgMtDJ6fIeIdnRXnVnGI2XeqzbEp5uuYSm6BHgB90s8aIYU2sq+qH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=gdRH13UY; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="gdRH13UY"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1715040113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y62hHsrTb5lsW6mQQlLI5VV86dUmkeSGO5ewKDOJZWA=;
	b=gdRH13UYczfBu1dce55uGmQfbYRrGHn15302Q92TvgT0MbOMLq+4gUD8eCWpFtu+1URe9f
	FNznN+6ao/ewykm+dQJ2pq9QyYFllAHxmAPGyv9DLVPwXo7FRgz5uwLA2lQqcgOBTWANUn
	bv4rN64JPLXUzr0vaR6Bb/EuVOVBCaVH78YF1jM+H1aYwQqZ2rqea/vtVn2sTpp67X+row
	ecrMUc8r9waqdju7qqLTRZl6bWHX6KlQm06Zzu8j0AJ4TcnbH7uaevn9uwnxCzE8zboWCg
	E0FAgea5NLEsd/ujsKMTARMlARTfD6nPMli+yUxvwWWYZJSogaZUrzzEgl4QlA==
Date: Tue, 07 May 2024 02:01:53 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, James Liu <james@jamesliu.io>,
 git@vger.kernel.org
Subject: Re: Re* [PATCH v4 0/3] advice: add "all" option to disable all hints
In-Reply-To: <CAPig+cT-xk13jGEUmpT5QmwVYTxKNUZsu9xJ=Ph3h4AzKHg6pA@mail.gmail.com>
References: <20240430014724.83813-1-james@jamesliu.io>
 <20240503071706.78109-1-james@jamesliu.io>
 <ab604f4b73eab1d9aae4e2a20ba0630e@manjaro.org>
 <xmqqjzka7p2t.fsf_-_@gitster.g>
 <CAPig+cRZEQjwhnMYvQ_0BjvXaR=3x=LQeJHzFOxC+ZPyOy9yJQ@mail.gmail.com>
 <xmqqbk5m65i8.fsf@gitster.g> <xmqq4jbe64l9.fsf@gitster.g>
 <CAPig+cT-xk13jGEUmpT5QmwVYTxKNUZsu9xJ=Ph3h4AzKHg6pA@mail.gmail.com>
Message-ID: <8dca4ecbf85f36e4264d7587fde4b0d5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Eric,

On 2024-05-03 23:24, Eric Sunshine wrote:
> On Fri, May 3, 2024 at 4:08 PM Junio C Hamano <gitster@pobox.com> 
> wrote:
>> So, yes, --creation-factor=<value> is messy, I think a very high
>> value, much higher than the hardcoded default of 60, is more
>> appropriate for use in format-patch, but we do not know what bad
>> effect it would have if we used much higher default everywhere.
> 
> At this point in time, I'm not particularly against giving `git
> format-patch` its own default creation-factor.
> 
> My only worry (and perhaps it's very minor) is that separate default
> creation-factors for `git range-diff` and `git format-patch
> --range-diff` could catch the unwary off-guard when invoking `git
> range-diff` to manually check the difference between an old an new
> version of a series before finally invoking `git format-patch
> --range-diff` to actually create the patches for sending. (I've done
> this myself on a very few occasions, but perhaps not often enough to
> warrant the concern(?).)

I agree that having two different default values for the creation
factor in "git format-patch" and "git range-diff" is a valid concern,
but I think that the resulting benefits, in form of patch submissions
that don't lack the range diff contents, outweigh this concern.
