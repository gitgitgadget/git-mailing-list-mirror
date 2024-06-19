Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378415098D
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812426; cv=none; b=VjJbMXwNl/o4hZnu6KvpVyqvzHx6K/eudY6hZbVKYuM/z0PwSgYj9zVMD+rpuepePrbVTVJ8joWL59ngZE7PYkdhEUn6wpPYS4h22BxAAdVVA9pfLw22I2/bg7sAYj78LYM8mxjJZRB/dk3APzSTmA1Uu62TLvbgv18N4b6FEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812426; c=relaxed/simple;
	bh=QTj/Z5QGTPT/XGgxoQ+GKnDC6VJDbUVtriD+grY2MgI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Yj047m1T6bZMwBadOZbTjUIUPJ9hkYUXSs8hwuloTA0z4DilwnBjedLEn6ZfRUEHcaULKUzBf39QCJSmgsxtEzmCBuqKhPEG2P5ZkFngf5ZChjdOOD55Q6P1SSNEPX2j/lpESOl699OxH5QpP2F3TT1KcLCEI7wTOriD3kbKJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=d6MOrJRG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="d6MOrJRG"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718812421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4f9HxIOOxnYg9wJREWdw4nUUSOF5JxxnEQt8QCoTzQ=;
	b=d6MOrJRGnZMn4lEWy4qMEdsqN+Xjlaiz3C3pxjCWN9M3LxR9jeR87XfxgZEKzQPBH2N7LH
	B/jWuquH8VQUMbpSqNQJzWsnPBgmFLHKUydEvPSwbWxMqcTWkGvCSfpKYFWtOEwfy4GStE
	gKe9OV08/4azB7gmr0Qgt7HLlI7r7JPfXMzZrShV4p1nWyVfon3HRqFSOqIxmARxcipSxt
	7KVKZ+vkHpoT81N73SGYduW0kRMEs7TZVVIkcJMGPWym7sF9YIBOYZaDKh7jQe5quvMBTF
	Yi3h4AB5rnoroROj0sXTyx72nmP8QlUiHvpr4CY81BSNkMR+n/q1Xm9nlPoDNA==
Date: Wed, 19 Jun 2024 17:53:41 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: rsbecker@nexbridge.com
Cc: 'Christian Couder' <christian.couder@gmail.com>, 'Jeff King'
 <peff@peff.net>, git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>,
 'Patrick Steinhardt' <ps@pks.im>, 'John Cai' <johncai86@gmail.com>,
 'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Advertise OS version
In-Reply-To: <000001dac256$d804a510$880def30$@nexbridge.com>
References: <20240619125708.3719150-1-christian.couder@gmail.com>
 <0448495385b009f25a66b0712afb28f1@manjaro.org>
 <20240619134533.GA943023@coredump.intra.peff.net>
 <04b714d3e949c30bae0e26231e923fc4@manjaro.org>
 <CAP8UFD2k9YBoKf_=fj1UKNK+=J-2vMenwt8QyTXXSaf=uX6Otg@mail.gmail.com>
 <4ba6dececcfb3dcec5c8b7e64657a1ff@manjaro.org>
 <000001dac256$d804a510$880def30$@nexbridge.com>
Message-ID: <49c7b3b5607cd502e12d1aadda150d0d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-19 16:41, rsbecker@nexbridge.com wrote:
> On Wednesday, June 19, 2024 10:20 AM, Dragan Simic wrote:
>> On 2024-06-19 16:01, Christian Couder wrote:
>>> On Wed, Jun 19, 2024 at 3:50 PM Dragan Simic <dsimic@manjaro.org>
>>> wrote:
>>> 
>>>> > I don't mind if this is present but disabled by default, but then I
>>>> > guess it is not really serving much of a purpose, as hardly anybody
>>>> > would enable it. Which makes collecting large-scale statistics by
>>>> > hosting providers pretty much useless (and I don't think it is all
>>>> > that useful for debugging individual cases).
>>>> 
>>>> I agree that it should actually be disabled by default, for privacy
>>>> and security reasons, but that would actually defeat its purpose, so
>>>> I'm not really sure should it be merged.
>>> 
>>> One possibility is to send just the `sysname`, described as 
>>> 'Operating
>>> system name (e.g., "Linux")', field of the struct utsname filled out
>>> by uname(2) by default.
>>> 
>>> It should be the same as what `uname -s` prints, so "Linux" for a
>>> Linux machine, and might be acceptable regarding privacy concerns.
>>> 
>>> And then there might be a knob to deactivate it completely or to make
>>> it more verbose (which might be useful for example in a corporate
>>> context).
>> 
>> I'd be fine with advertising "Linux" (or "Windows") only by default, 
>> because it
>> doesn't reveal much from the privacy and security standpoint, but 
>> allows rather
>> usable statistics to be collected.
>> 
>> A configuration knob that would allow it to be disabled entirely, or 
>> be enabled with
>> more details to be sent would also be fine with me.
> 
> While in the code, can I suggest including the OpenSSL version used in
> the build? This came up in at a customer a few weeks ago and they
> could not answer the question of what git build they were using.
> Turned out it used the wrong OpenSSL header compared to what they had
> installed.

Makes sense to me, but only in the non-default "advertise more details"
mode of the new configuration knob.
