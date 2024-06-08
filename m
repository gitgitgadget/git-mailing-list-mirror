Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8F176FDB
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717840783; cv=none; b=mmSRguwYG32I5k3oR0hsTR8UkSwZ0w4lcDo35+nA/1UfMpcl7XQHYV1k875o3CfCjGRDjDNicjk9pb+heo9MdKlpn1Ku0+pZkRQmoGN0Mq6GiEo4EoXrXZWz2U+7XoAHec8ChER1s7hayq10F1KIaYK5jsJho54Wa4++cXg9t48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717840783; c=relaxed/simple;
	bh=UGzqJUGiyQM5g/487aX9ZxQTjM/rp7DD+eYu1HED6oA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=M9GfS/YDf0Hl+dvOqMaD/jMN9j5xrS8AlLRGCXKcnjGoGJnFt9VnDUUK4JWuzjoSkFJC09JfVjtbIbLYL8vbN5OKiZVnPP6YLEJL4KNEkdfLnW23f6G3mSY3HsTR0FQCx0kvPFhk2yUSotjWz5Bai/TMUVn0kWrSsA7EuPCulCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=CALVAErG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="CALVAErG"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717840778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JuIV50rgSU23rYVIFO4CC6789pBp4OaKl6EKYXYlffU=;
	b=CALVAErGvSr/m8y35XVjspfvxS/BjtUeJF10sqRKjNwm8xtmvk03ojy4JxoteB4M7lZY4O
	J1o+JpbBQptXx79LYvW5uQu70ldD7Q6CSt/DNj1dhOwYgznMnhOZcoMZcvPiS/vljCwLt/
	Spft+kroBKCqUUJwt78UihhER2SCGTQms3vCM0dM6IIxA6JLfeh511iSYns+eVClDfp103
	iSVeW5uW4eBCMa1IFI35w/qSxXERbHTEne9YYXATkZgCk8G2wb0AU8SUqQbcL1II5wxI+T
	XOXslIomaduoFDbGTyW+EqRODXivYBApUCps5Z+eaWlkHSZZvLa6+P1LGQXZ9A==
Date: Sat, 08 Jun 2024 11:59:38 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rjusto@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2] doc: imply that interactive.singleKey is disabled by
 default
In-Reply-To: <xmqqbk4ce6w3.fsf@gitster.g>
References: <7da73f15a018d858519eefa373001ccb3eaf32e2.1716412958.git.dsimic@manjaro.org>
 <xmqqy1811qkx.fsf@gitster.g> <673887a14c4f74deb4ef7771a331689b@manjaro.org>
 <35f5633ebf263ec743d673770eb86487@manjaro.org> <xmqq5xutgajw.fsf@gitster.g>
 <e5eb72eeb2f8e2de9400ed9373b72236@manjaro.org>
 <61f46d925e89b6a574d84970089f3c50@manjaro.org> <xmqqbk4ce6w3.fsf@gitster.g>
Message-ID: <0a3e229942b314947b3a301a85cfef8c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-06-08 00:15, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> On 2024-06-01 00:21, Dragan Simic wrote:
>>> On 2024-05-31 19:23, Junio C Hamano wrote:
>>>> Dragan Simic <dsimic@manjaro.org> writes:
>>>>> Just checking, is there something left to be addressed for this
>>>>> patch,
>>>>> before it can be considered to be pulled into the next branch?
>>>> Thanks for pinging, as these small things were on the back burner
>>>> while preparing for updates to maintenance tracks.
>>>> Apparently v2 cannot be pulled into the next branch, and I forgot
>>>> if
>>>> I saw v3 already.  In general, unless I explicitly say there is no
>>>> need to resend (sometimes with conditions), I'd expect an updated
>>>> iteration sent to the list.
>>> I see, but I'm not really sure is there need for the v3?  Maybe the
>>> patch description could be tweaked a bit further, but I wasn't under
>>> impression that you asked for that to be done?  Am I wrong there?
>> 
>> Any chances, please, to have a look at this?
> 
> I _have_ taken a look---as I said, "I saw v3 already".
> 
> Unless you were asking other folks, that is, but the message was
> addressed to me with others CC'ed, so I am not sure what the true
> intention was.

Ah, I see now [1] what you asked for, which was a slight rewording
of the patch subject and description.  That's what my intention was,
to check was rewording the patch v2 subject and description necessary.
Sorry for the confusion, and thanks for putting the v3 [1] together.

[1] https://lore.kernel.org/git/xmqq4ja4e6d6.fsf@gitster.g/
