Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1E1CF9B
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054204; cv=none; b=NwZQnHyyqr2C25M4JAS0mjAlGim7ZQlknuTPCQr0AbHIpcirLtcO/jVczi3nR/erfDRtO+++lOng4/F3BSodNAMUveTRPmfuO9tnDbA8Mp5t7gjTnJ0oeZTdqQm9ryXofTMyrJwN6nd0KSJfBxa6rFZsVCIjJsdfDtxIilYFlUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054204; c=relaxed/simple;
	bh=YC7syzavv27A9Viz0I35UzDnu6Jq+xWnBXxhwCuwbIQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Np6AGlf1hgZy7gE+8T6CL66yLcElbJWbzZ8JMAxYeJAf027rieidWRjUSthHnFrMnMjEJHhzAstjCOoJIEAVI1NSK0g0V3y7ay/LYUlwgaRc66vrzgXFvU6v5oS+8xt5GpEg2u6h7E3uOpVx21mrZOfd9+p3zGPo9QBVTFYTBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=WEhPZIy8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="WEhPZIy8"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718054200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPl/k0I021iPnIA9GK7JFYye72cdGGBZaiZVuryj8Uw=;
	b=WEhPZIy8VEbwWyGDKCoMt8qrMpgjcYR162vPAIB3VjUGlYTuWqF9FJakbPehphl783sgon
	4mxLBw80gl1c0CCr6AVzhcZ4tfiLstw3DKXAsZ9piSmc4d1IwWeaJEMMy27y5q+zGc+MLo
	od7Q3Oof25IUFKgs0VbIxVmCJRdgC7qdISgio5/2s2I4rZv0Eu6d1xvqgtAlIlG1afYzXv
	Kk4UKss0iYRdd2GPfNcJjnzGsx+J0JWUVa4qVmmB4HzQTWwV/IUDd9bLvd3AMgyCboGQ1h
	N/z8v4+qt/ppTi1VXLfVv4v/TCKNA7QAuebcFJEuM5MPnU9ZLhXiuT7dw7zi2A==
Date: Mon, 10 Jun 2024 23:16:40 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Jeff King <peff@peff.net>, Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <xmqqle3c1ryz.fsf@gitster.g>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
 <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
 <219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
 <9f1884ae-0f9f-4d9f-a262-b6929b81d7d8@gmail.com>
 <1a9f8385377d3aadfeb07ad62810b2df@manjaro.org> <xmqqle3c1ryz.fsf@gitster.g>
Message-ID: <e2c07b0cd0a47b9b9cf5736571f19d2f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-10 22:08, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> If you want to see an example of the garbled output, as a result of 
>> the
>> coloring escape sequences not being processed correctly, just "cd" 
>> into
>> your favorite Git repository and run the following commands (assuming
>> you're using bash, if not, please adjust the first command):
>> 
>>   export GIT_PAGER='less'
>>   git log --patch
>> 
>> I hope that will make more clear why I'm "advocating" for three 
>> separate
>> new commands for "git add -p", i.e. "P", "|xyz" and ">xyz".
> 
> We are talking about folks who use a pager in the context of Git,
> and to them, your example is totally made-up and irrelevant one.

Ah, that wasn't my intention.  I just wanted to provide an example
that shows what a garbled output looks like, because I was under
impression that Phillip asked for such an example.

> Either they use a color-enabled pager (like "less -R") or they have
> configured color.ui to disable coloring.  So I do not see this quite
> as a safety issue.

Agreed, but only if we end up honoring "color.ui" and "color.diff"
in the new "git add -p" command(s).
