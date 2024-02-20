Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D031EB3C
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411301; cv=none; b=XR/5W57D2vO4J821nuNANWIkZVx+7DJABwjkNEqCb4yckEHiVDeQ8/PvoCtiwg/YgM5tQGzHkRrhTakY9ph8DZe9cDp3vvmvdNyr5PT7PN62YqZ69FBRtuldZbMgccaJXUd16+TchFA2m1iRh7veN7mL433SEMcIcoNMFV9R2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411301; c=relaxed/simple;
	bh=PqThjOgi3zgICpamnnFL+sLWx1vT+gJyCaWI72YY2mA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=f7UxkPaC9K+rydXEO3hpTGBi60c2RjnLRcZgocNVeISeV6rm0YJXP5G5P03b9b0zfA+KS1hcW2dHHCQETsGfA+Ct7v793mllH4gzObD3uS4fc9s/5TohVVZaQX2Lv1YeL03W14LUIXmQK1CYtIb4i9v1ezrbhffqYiSvdXY6aTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fKeb8bpG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fKeb8bpG"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708411290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6c8X1h9+SY0VkEXSsUGtfN0VxvhDem2L4aGHriqXroc=;
	b=fKeb8bpGVXBGpfNTBxOrYNXkgJAiLifidCTY0pTeARCDwpMDtXFmixYwfx6oMEgUovfrcE
	MOxZ8A5KJ+zdzVDwh+FbYQoKkjrnEZmrEQY7Y4yX+dXIyOZDdwFbbeJ47KLvEJK/aXzL+E
	ZX1PqfNftTP9f9CHiZWAVsofngHSWV5MyFO+ZpD4vi1tdWKiRQ0YljLgGal/PQnpMiLOOL
	5RQvnMWJiYMXH2oq/yAzi1HvS+2BuUEstep34QNYkUmxgcZFJ1PAV4nTi/ZtMSSFORn4t9
	eWiv8SxOSOCEBbLljfmt0p77a5VCFEIsyFnWXUpwYxsbOlGC+6VDyRSqpem1zw==
Date: Tue, 20 Feb 2024 07:41:29 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] documentation: send-email: use camel case consistently
In-Reply-To: <xmqqv86kx8h0.fsf@gitster.g>
References: <b0577267402f6177d8ba5646e12d7691437e6e8f.1708060779.git.dsimic@manjaro.org>
 <xmqqv86kx8h0.fsf@gitster.g>
Message-ID: <33abb630c1d089e39ff48f04e586b1c0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-02-20 01:52, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
>> There's only one "Fixes" tag, while there should actually be a whole 
>> bunch
>> of them to cover all the patches that introduced the configuration 
>> parameter
>> names fixed by this patch.  I think we're fine with just one.
> 
> I suspect that we are even better off without any.  The only reason
> to have them is if we plan to cherry-pick this patch down to a
> separate maintenance track that the "culprit" was cherry-picked or
> merged to, but we typically do not do so, and if we want to do so,
> we'd need a much better coverage.

Agreed, will drop the single "Fixes" tag in v2.

> Anyway, checking the output of
> 
>     $ git grep -n -e '^[a-z]*\.[a-z]*[A-Z][A-Z][a-zA-Z]*::'
> Documentation/config/
> 
> and comparing it with the output of
> 
>     $ git grep -n -e '^[a-z]*\.[a-z]*[A-Z][a-zA-Z]*::' 
> Documentation/config/
> 
> I think we should spell "SSL" (which is an acronym) full in capital,
> and possibly do the same for "CC", too.

Agreed about "SSL", which I also though about doing that way initially;
will change in v2.  There are already instances of "SSL" being used,
such as in various http.proxySSL* configuration parameter names.

Though, "CC" should remain written as "Cc", because it's the way email
headers are capitalized, which "Cc" refers to.
