Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906A86245
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036401; cv=none; b=kuL1WvckVLCae20CbHyQOmFw7p80IX681rH670E7uLFWng9CmfDss+u+VcdUzYc9l0n1nVY/nxA5vciOiyCegRLrpVs9uS9WmxJUdzNoQpA3KPD0hfjB3EmkT1ZpYT5ARmmO4FS/d+Nbem5wX3tO72vmtZKjZvEKqPyF9m621uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036401; c=relaxed/simple;
	bh=tZ1WFRkcghTeuhb8p9i/7xm8PN7H7Bosq2ezqbqNCCE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BLbMVEwstl9OeWtSiSP47QfxfekVLLc4u+JfIRkq6dpj+A2eu6hlFoQsjrNYp2ECzONm9DYiAnbTHWvG7d1dGw8u83Rza/MhKYFmeyPPBfvL7e3Pu4G78PpmLU9X5lTHkPiaFbYv7mher9Cy95RXBew4tS+XKebWiYCEkgzuq8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=nS+d8jLB; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="nS+d8jLB"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711036396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cW+vuUugC58glugDtO/3sKDAqKOERKnEsQVM6uaJZDk=;
	b=nS+d8jLBTSfRViXlJJ3cpSP75G3ArNINYgTG6N5ED6iCmvmHbaRXkV80xm1ARU9iWChgcz
	vxpw1afj0mwmqwMYmrJ5da9N43M/oNf934SJ8a8y+ROxzhQ0fdLFLXMYegsUKHciY09tpY
	wm3e9YC5slBHfbcNhXji54+qrwh6f5Mrh3WWEqHXf66H+ZZaNdMUQaUzznosMlTZWUA/Oa
	7WgtEbJ9su2TKZG+LKXXkryZMv1mN4r9d/W8M/Fey6SsvfIhGSHtzeeqaj3XVw+M1CG+Tm
	W1Vh4lKOGmgqoScj5l5Y4jSi5dLcsC4VxaEpFtIPFBsQVWOrsMXtZnfUa4cC/A==
Date: Thu, 21 Mar 2024 16:53:16 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Thomas Guyot <tguyot@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Christoph
 Anton Mitterer <calestyo@scientia.org>, git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <5752129cbefe064a10e57e1b628e516c@manjaro.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <20231012000416.GA520855@coredump.intra.peff.net>
 <xmqqh6mwipqi.fsf@gitster.g> <3946c06e90604a92ad0dddf787729668@manjaro.org>
 <xmqqr0lzhkzk.fsf@gitster.g> <a831af51b6fb46b5d6fcd9768a7fb52d@manjaro.org>
 <cfbe174f-23ac-4a35-8db4-66bdfdfdc14e@gmail.com>
 <8022dae27797bf1e1770f099ed37f5d3@manjaro.org>
 <d54eedf0-7825-44f5-908c-a51541345872@gmail.com>
 <79cf1bf35ba6c9348735685b01e0f2f9@manjaro.org>
 <5752129cbefe064a10e57e1b628e516c@manjaro.org>
Message-ID: <8289ef15266172cbfa10bb146afe9797@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2023-11-06 04:47, Dragan Simic wrote:
> On 2023-11-02 15:19, Dragan Simic wrote:
>> On 2023-11-02 14:19, Thomas Guyot wrote:
>>> On 2023-11-02 02:48, Dragan Simic wrote:
>>>> We've basically reached some kind of an agreement about the need for 
>>>> a
>>>> good solution, which turned out to be rather complex as a result of
>>>> being quite universal and extensible, which was required for it to,
>>>> hopefully, be accepted into less(1).  Also, the author of less(1) 
>>>> seems
>>>> to be quite busy with some other things, and he prefers to implement 
>>>> new
>>>> features himself.
>>>> 
>>>> We've also agreed on another new feature for less(1), hopefully, 
>>>> which
>>>> isn't exactly related, but should be quite useful.  It's about the
>>>> secure mode for less(1).
>>> 
>>> Feel free to cc me on your next correspondence. If there are mailing
>>> lists archives for the thread I'll fetch them as needed. We have at
>>> least one working term/switch combination, which IMO is a better 
>>> start
>>> than nothing :)
>> 
>> Please test the "--redraw-on-quit" option, AFAICT that's all we need
>> (plus the already mentioned other improvements to less(1), to avoid
>> the version-dependent workarounds), and the distributions will
>> eventually catch up with the newer versions of less(1).  If the whole
>> thing has worked for decades as-is, it can continue working that way
>> for a year or two until the packages get updated.
>> 
>> There's actually no two-way mailing list for less(1), the entire
>> project is pretty much a one-man show, so to speak.  There's a GitHub
>> page that allows issues to be submitted, but I didn't use that, so I
>> exchanged a few private email messages instead with the author.  I've
>> already summed up the important parts of those messages.
> 
> Good news! :)  The author of less(1) has implemented a couple of new
> features that should resolve our issues with the pagination.  The
> improvements for the secure mode of less(1) have also been
> implemented.  I'll test all that in detail, and I'll move forward with
> implementing the required changes in Git.
> 
> It seems that a new version of less(1) may also be released rather
> soon, so we might be on a good way to have these longstanding issues
> resolved in the upcoming releases of Git and less(1).  It will take
> time for the Linux distributions to catch up with their package
> versions, but also the rolling-release distributions will get the new
> versions with no delays.

Good news, new beta version 653 of less(1) has been released! [1]

Version 653 contains new pagination-related features (in particular,
LESSKEY_CONTENT and LESS_UNSUPPORT) I asked the less(1) author for,
which will finally resolve age-old pagination issues in git and
a few other upstream projects.

I'll test the new beta version, after which I'll start working on
the required patches for git and a few other upstream projects.

Looking forward to resolving those age-old pagination issues! :)

[1] https://greenwoodsoftware.com/less/news.653.html
