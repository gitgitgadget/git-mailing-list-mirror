Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC3C145B3B
	for <git@vger.kernel.org>; Wed, 22 May 2024 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411044; cv=none; b=DGgNc65F6F8nKdKwIfFhr/mlJgPBgYgr7alUi80cSBOJ1NQ6fEUZALNIEoegTHW7ahjlQwf3eLavu6oswTgSaijKph53drSVT5D5m8RwNbm/ofQn9/q3lgIHDzQnvIrJ04Aog+HToP+vhCsNLUSPr9XQ7b9wV1IWfMd2XRE04ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411044; c=relaxed/simple;
	bh=oSLCdF3pz3phU12Gd7T+HYjKkPHTlZrgIGloC/df9L4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=V7HhJ9scNBt1WoiJyfpWwrKXEtYFcjZsau1zxoc//RoLj39o4MO0/YuvAi2iibOkfgAX+BKHhm2tBi5x6tjNxcPcriVCAakWlyHpRoDRssRmCwuwkPImXrmxe8MYxZ7ybwqnRLOfmS0HZk/LKEZa0vzBgDshgAIpsvf+mN6u+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=kucx80ST; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kucx80ST"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716411039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltdJPKkpmvWLEIJ3PbXR4NyHSLmyGzSos48ETK/KCRw=;
	b=kucx80ST/fh5GAFiGK/jvSKq34SHPDWCSmmRad0GM65TThA9KnOGmPUzf6lKnQGXgQGWuW
	krB6cOfEH5r67oq5RGk7BGfnuKO/Jr7OsQBcpzclQd8klOOlJrCcSBUP1OMRzS+KjAtcQO
	VBd+nX3Ta7Vgwfjx1/auYhN422I51ndZGiMc6kQA9gjSFI70DUYPhke+aCHrU5KMjGzaOA
	L557TJ48fEEgdfwxSyCaodhP31I7ObQ1oB8jDsSHDEEbkLkixdE9OSEuU2wtKnRDuQzKjG
	kd7ie7oPLQHfj9KqnsijwBC885c83kpmcSy91issd011clekMijLxy4A9Ib3Gw==
Date: Wed, 22 May 2024 22:50:38 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: note that interactive.singleKey is disabled by
 default
In-Reply-To: <xmqqttip379x.fsf@gitster.g>
References: <3141fe9f7328a97bf3818748421f6ae929120626.1716363167.git.dsimic@manjaro.org>
 <xmqq34q966qq.fsf@gitster.g> <54c318f42ce63f0575ea48f3dc1e8361@manjaro.org>
 <xmqqttip379x.fsf@gitster.g>
Message-ID: <a04bc0c38ad287b892c7dde37d782f12@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-22 22:45, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>   interactive.singleKey
>>      If true, allow the user to provide one-letter input with a
>>      single key (i.e., without hitting Enter key) in interactive
>>      commands.
>>      [...]
>> 
>> Thoughts?  It would be more consistent and a bit more clear, without
>> putting too much stress on the actual default value.
> 
> "When set to true" or "when configured to true" is much better than
> "defaults to true".
> 
> I am ambivalent about "If true", though.  It still leaves it open
> for some mysterious "default" mechanism giving the value true
> without user doing anything explicitly.

Makes sense.  I'll send the v2 of this patch with "when set to true"
in use, possibly with another patch that addresses already existing
instances of "if true", for consistency.
