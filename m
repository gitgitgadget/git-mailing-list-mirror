Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4147351C42
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505389; cv=none; b=Z/eDa0bb68zD5s9jBMOVMm1CScgoXgt1QDVhXAo2EE2bNKJwmmKjRYaAyX36u58ezZDffW+FcAtcON4H67YYDwZ205FKC3CaWmtTP8oWjQrB1vuyJuNvFsX0Q0Mbr/lKoZe8IDlE/vePB05kaCuRS7mllDot4MGez6qqm4VoZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505389; c=relaxed/simple;
	bh=3nu0OwIvvxOzvuM9EnBe/j9atGPBAo28xAMxCZuL2g4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KB1p6WNF3PYULIgVvQVybnqp7kC88+/uykEbf/4AtMt2OKB5DqZU6h8moMMyV2ygiHXFgpkhhAH869b/D8u2wCONAEVhXDOMvFWzhgX2vJpNUSVITwvjzu2y6Zv69PT8PHsVdm6nZdt5FHmF8mHPNjG40bRxW0VOhon15fYkk6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=qjJBwhXj; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qjJBwhXj"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716505383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19am++TD8X5Sfr8VDf6s47ofLP+sikGm40uKBz0gimo=;
	b=qjJBwhXjXF5cXkG3SQBdqNSf++JTa7KPuhhuVeOxkTPa7vxakk4qjhfeItNlhjFZ4DQK21
	gFkQR4EwaokI43p+hRYl3vBNOV2VnoLgEurgNMbrA6Zmzu+spBtmAZ3Gk+Rviuukgc0/jQ
	heH9/0R8ExvnQ8y+geuVJJ96vo/DrTbiXWWQ2JvWIue5uTEq0TJdB+6ugjZCDuNmuxgBm+
	GXvZJg2GMVffFvnWU+Q5Eg3qCEDDBCG+Y7z/t9u0J3UzldFTqkGoKOUFHOcmc5lmZ+7ov3
	iBU9B4oP6U1sJEdVXwkFVbFvoMYttIz9lbnTtZTJkd6NpGxVr/gtyP4cXtzaHw==
Date: Fri, 24 May 2024 01:03:03 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
In-Reply-To: <9d25b8af-a865-4535-b8fb-d518768e00b4@gmail.com>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
 <xmqqh6esffh1.fsf@gitster.g> <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
 <20240521070752.GA616202@coredump.intra.peff.net>
 <5f6f3ce7-a590-4109-ab8a-1d6a31d50f3c@gmail.com>
 <20240523090601.GC1306938@coredump.intra.peff.net>
 <9d25b8af-a865-4535-b8fb-d518768e00b4@gmail.com>
Message-ID: <0b43d5df031aabec48c5ab4fe6436c36@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-24 00:25, Rubén Justo wrote:
> On Thu, May 23, 2024 at 05:06:01AM -0400, Jeff King wrote:

[...]

> In addition to that, I have two use-cases that make sense to me:
> 
>   - avoiding a huuge but split-able hunk to go all through my terminal
>     before I can say: split, 's'.  For this, perhaps the '-P' suggested
>     by Dragan is the way to go.

A possible UX issue with the "-P" option is that the menu wouldn't
be displayed right after executing "git add -P" if the first displayed
hunk is longer than one screen, leaving the users wondering what
actually happened.  Though, that perhaps could be addressed in the
documentation.

>   - a lot of mid-sized hunks that I only need to see, to decide, the
>     result of "head -3".  Here, the pager would be acting as a 
> 'filter'.
> 
> Perhaps I am stretching the meaning of 'pager' too far...
> 
>> I do still think it would be useful to be able to configure its pager
>> separately (in my case, I'd use "less -FX" rather than my default
>> setup, which doesn't use either of those options).
> 
> A new "interactive.pager" setting?  Perhaps with higher preference than
> "add.pager"?  Just questioning, do not take this as an intention of
> scratching that itch :-)

Huh, I see some possible issues with separate pager configurations,
resulting from the upcoming rework of the default less(1)-as-pager
options, so perhaps it would, in addition, be better to wait until
those changes settle first.

I intend to get into that rather soon, not only for Git, but also
for a few other projects that use less(1) as their pager by default,
such as util-linux.
