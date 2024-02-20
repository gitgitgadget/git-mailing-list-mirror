Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63509135A7F
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457550; cv=none; b=lhctPB/aABNfLFHgFDxBPPNjcCA7z59HQ1PelXDsREWUSqkaqXDesvyNI9B2CaJSE/NyjGRqO43s0tylX+hgBaV9ZqOA+KNlHQyUFY2mkTvLiKVT006lbmXzE45ZrjtNrFv5MVEwA0WxCo0D8rU1DWYU3wVqrt/SauUtWSABRyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457550; c=relaxed/simple;
	bh=khPchM+Z5ZltuZGYei2VpWJzdIwWlVb929YU4bJekfg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=olAduZlXTzEPIWMM7dlaik/YRKBtvDeFJ5rOsIp8iH4jPqDuDh+Il59vxkN+9v52q2uC6TIzzlw3m1u05tSkGtLfiFzP9pmB1PZx4FQlRmyEO38/Tb8L/zE6yKTiiCGHlaJAfqCBer1nLUmkN6IGJAWagWnZvnPEQ4qibctXyMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Bjg/n34g; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Bjg/n34g"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708457543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThN/AJZ76CBxGe/XZidhIGAEeCoxX4j6b+vfRUkZ5fQ=;
	b=Bjg/n34gbR5VoRfFLP0O5wbF7c/s94kZc9CQIjspkgeF0JZz1voNgxEqTr36uy7s3g1tIY
	qRJ4hUMhHDA7IRJLPl3cuXliDnWrUQKJ6Q5QLR6dH/Ic9SMVmIZawcjvSan7uT7Ew8H8UM
	DdBlCVA2YqIqyQPSZN9P/Q2VzUjbzW5YnT9LZeh318fDpUiFo+e1H8TafqJB5tEXuriq9S
	m7M3am18UDuYKR9Hn90zbauOGyaxdYoXKFRxgZxUn3YVqu4/1uFVUj1hbaZC503z+1437I
	wXmMWu/jUpgEm7P0nlVdssuo5KOwMrUJwm0pnIePdV6BBR+b3FjGIrXAhjorFQ==
Date: Tue, 20 Feb 2024 20:32:23 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <xmqqttm3ouxy.fsf@gitster.g>
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
 <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
 <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
 <be91f3ad9305366c1385c2da4881537e@manjaro.org> <xmqq8r3g8caz.fsf@gitster.g>
 <35738a93f5cbace5b3235ce614b7afbf@manjaro.org> <xmqqttm3ouxy.fsf@gitster.g>
Message-ID: <95b86d73f934b486171c7e169080f43e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-20 19:24, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>> My advice would be to stick to <old> vs <new> that contrasts well.
>> 
>> I appreciate the directness and honesty.  How about using 
>> "<oldbranch>"
>> and "<newbranch>" instead, which, although more wordy, would be more
>> consistent with "<branch>" that's used in a number of other places?
> 
> I have slight aversion to non-words like "oldbranch" (not
> "old-branch"), but not that much.
> 
> Quite honestly, in a document whose primary topic is "branch", I
> doubt that repeating "branch" all over the place would be the
> consistency we should be aiming for in the first place, when it is
> clear from the context that we are talking about branches.
> 
> The updates we are making to Documentation/git-branch.txt that (1)
> slims wordy description of different modes in the DESCRIPTION
> section, (2) make option description of "-m" mention what
> argument(s) the option takes, and (3) rmove standalone <newbranch>
> and <oldbranch> description are all about making the necessary piece
> of information easier to find in one place (namely, the option
> description where "-m [<one branch name>] [<the other branch name>]"
> is described) without having to jump around all over in the
> documentation, so in that sense, I would think the way to go is to
> aim for brevity that takes advantage of the local context.

It's hard not to agree with the way you laid this out. :)

In a nutshell, the way I see it, using "<old>" and "<new>" is also fine.
It's also fine with me to use "<name>" instead of "<branch>";  in fact,
if we go with "<old>" and "<new>", we should go with "<name>", too.
