Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC85466C
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951429; cv=none; b=NTXviXN8mIxVywkZLb3Od/XEGuMBinXPLoYQMsrA1pBf1XtESRoxezJB9KGPJESioFzYznXqOmKP+W8Y+Xpx+8z6lf9YDVYqisH1NPQDWVm+sobJnTW9brOhn4RMFSF5MRapvunmivAlvHf8wnNJn4icoZoI0bcXQ+qmww0coGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951429; c=relaxed/simple;
	bh=YUcmBop8ZLJ4K1hIj8abyMMhvHnHgggP2eO1Nrkm5gs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=m3MeY2iPdSgz7H+tOrwcSTij8Mc9xMUhcmLI/sOsIBlA6wAk0Pou0QEMAqNKQwIhofybUs/oCRvYxHGVdcN7+39CQS2j4BJlEJIcrvGugJ1wPePlSH7/XKzeKNsCDI2jfUlNa4YEYJi0SRFqjp8Xf8Gejcop1IUOnBJhDQ1wCG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=O9yiZMzC; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="O9yiZMzC"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710951424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQbTmA0tv7njPjRW0kCzXOTEowJ8H7ET34AwQStAcMo=;
	b=O9yiZMzCR5Uqp1bwu43aB6d8xwRUydLboDPGBENndnRGbNR6ipPB3glqTi7cpAs0jKgfAR
	vZp0hsO5Pd5596wVPKaSTp/+muhcZM/d56B2IGOMmEwf3LLqe32DsvYWFWr7ri/jsnjzqK
	o2Z64EUWMz01nnNPw/sLXsWFKBJVLmvivWsQSgE797+8i1ydCFe3WVE5Q8+EYVr9rbZdZV
	2W0ymWcuZBbuzxTEYvNDQCW7L7+qWp+vGXgkS1NBbI8F0bnBCEAdorw556Yj/fBnzMGnIY
	4RMxV/AcW61tNfEafIpO7a2p/kMbpcOElJRN/dwUI1Ynm+11BZ+KBu7P9aZPKg==
Date: Wed, 20 Mar 2024 17:17:04 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com, github@seichter.de,
 sunshine@sunshineco.com
Subject: Re: [PATCH v3 4/4] config.txt: describe handling of whitespace
 further
In-Reply-To: <xmqq4jd1hsm0.fsf@gitster.g>
References: <cover.1710800549.git.dsimic@manjaro.org>
 <e389acbfacd5046a926b87346d41f9c7962e3c23.1710800549.git.dsimic@manjaro.org>
 <xmqqttl1js1o.fsf@gitster.g> <c4f0e7311edce5d4ed4a55f290de9eaf@manjaro.org>
 <xmqq4jd1hsm0.fsf@gitster.g>
Message-ID: <ce041191a245ff888b1710cdcaad9e61@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-20 15:42, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>>     Leading whitespace characters before and after 'name =', and the
>> Hmm, "leading whitespace" and "after" don't go very well together.
> 
> True.  We can drop "leading" of course.

Good point.

> I meant to refer to, in this sample illustration,
> 
> [section]
> 	var = value # comment
> 
> the fact that "\t" before "var =" is discarded, and " " after "var ="
> before "value" is also discarded.

Sure, thanks for the clarification.  I'll try to tweak the wording
a bit further.
