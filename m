Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76126380
	for <git@vger.kernel.org>; Fri, 31 May 2024 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194082; cv=none; b=t43XPtb+gCfJq+IQWplZtgygwYSDAoI81oaBuRrpYWiTtqbOXIUNEYF6zBbXEdTfYX/9KR0GTNjI2PBezsqb0m8EC0bpvsywe9O6WR1qWodce9GaQspxQQTXsqUduaNntc1+gv2s1svBt3fawZtjeJ6Xfhg8J2BA+DfCGzYyVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194082; c=relaxed/simple;
	bh=fVoN2jTkhYDRdKkZNagBM1x+j0918PPjCwvFmyve1nc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qH4f7TyhiUmCpqLDLMkH3finpDhIIH2g2PvxNKTLQgJO0Tp5leGTBzDFW2sGHeg07jXSTjaQNnXk3WFILV0hPepWKZHNs0kTlG4Up/5MxlFmZ3M0uh9vVfsjLfSxyiT0ZcWK6uiYZvBeMvd8Z5RXjSmZH3ueeXv6CChJy2iXV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=n6A6ZDFh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="n6A6ZDFh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717194078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RNpPR47OlqkUH2vdFuUfYb08ypemyIvn2iUlNAjQZo=;
	b=n6A6ZDFh38cKsU2d7UMc9zfubtiaVo1U+eW63sw2+cNNP7rFh3+t4nG1qCFX9y5OP0dl75
	q72eT+kIM9FqRzekQMyiGEW9MrELodRfHDNYJV/30QvU300apfuoeYddBqwl003zl7VXFZ
	pT3WUrkVPkL9dFmfUtVEONTc9lcUWtqs9XstnXVnv1kQh5Pvf8xbLMEQayXlyaP60KeL0i
	H0RHi03mvjAPztnu6VIg2Se0MMVqGu+Be9Yc+vKfCWvK9hkhotR6sY76JGw3t220b2Y3oc
	gUbX9jSEKVAGX/UFOVrLePRmt1DrDF2EfBsuz2z9SdhwIrNdmh17ZKPwGqEOqg==
Date: Sat, 01 Jun 2024 00:21:18 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rjusto@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2] doc: imply that interactive.singleKey is disabled by
 default
In-Reply-To: <xmqq5xutgajw.fsf@gitster.g>
References: <7da73f15a018d858519eefa373001ccb3eaf32e2.1716412958.git.dsimic@manjaro.org>
 <xmqqy1811qkx.fsf@gitster.g> <673887a14c4f74deb4ef7771a331689b@manjaro.org>
 <35f5633ebf263ec743d673770eb86487@manjaro.org> <xmqq5xutgajw.fsf@gitster.g>
Message-ID: <e5eb72eeb2f8e2de9400ed9373b72236@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-05-31 19:23, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> On 2024-05-22 23:34, Dragan Simic wrote:
>>> On 2024-05-22 23:31, Junio C Hamano wrote:
>>>> Dragan Simic <dsimic@manjaro.org> writes:
>>>> 
>>>>> 1:  3141fe9f7328 ! 1:  7da73f15a018 doc: note that
>>>>> interactive.singleKey is disabled by default
>>>>>     @@ Metadata
>>>>>      Author: Dragan Simic <dsimic@manjaro.org>
>>>>>       ## Commit message ##
>>>>>     -    doc: note that interactive.singleKey is disabled by 
>>>>> default
>>>>>     +    doc: imply that interactive.singleKey is disabled by 
>>>>> default
>>>>>          Make it clear that the interactive.singleKey
>>>>> configuration option is disabled
>>>> Heh, "note that" would probably be better, as we are going to say
>>>> "Make it clear" anyway, no?  That is stronger than just to imply.
>>>> Keeping the original version of the log message probably was
>>>> sufficient.
>>> Yeah, but I felt like it needed some adjustments, because the patch
>>> itself was actually changed.  I hope I won't have to send the v3
>>> because of that? :)
>>> 
>>>>> +	When set to true, allow the user to provide one-letter input
>>>>> +	with a single key (i.e., without hitting the Enter key) in
>>>>> +	interactive commands.  This is currently used by the `--patch`
>>>>> +	mode of linkgit:git-add[1], linkgit:git-checkout[1],
>>>>>  	linkgit:git-restore[1], linkgit:git-commit[1],
>>>>>  	linkgit:git-reset[1], and linkgit:git-stash[1].
>>>>> 
>>>> The resulting text reads well.
>>>> Nicely done.
>>> Thanks.
>> 
>> Just checking, is there something left to be addressed for this patch,
>> before it can be considered to be pulled into the next branch?
> 
> Thanks for pinging, as these small things were on the back burner
> while preparing for updates to maintenance tracks.
> 
> Apparently v2 cannot be pulled into the next branch, and I forgot if
> I saw v3 already.  In general, unless I explicitly say there is no
> need to resend (sometimes with conditions), I'd expect an updated
> iteration sent to the list.

I see, but I'm not really sure is there need for the v3?  Maybe the
patch description could be tweaked a bit further, but I wasn't under
impression that you asked for that to be done?  Am I wrong there?
