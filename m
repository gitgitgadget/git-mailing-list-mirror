Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C015C14F
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796938; cv=none; b=Q1M/WZYhg0x4W4LS0Vhcrpvyt0Ijp9N+OkOfWdf1Q7EQ3Phwu4AJBBJNOyGrhj+JE4xF/4azpiTtdfy46hOMBl+7b6C3AvkxbHr7bJ9MIVWuDo+Zsc5SLuLsiFSUAHhm4qnuAeoEQcAUVCNIMEl8JX6f8quhPz42RVOoxEvwS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796938; c=relaxed/simple;
	bh=s/dl4RA2+P5u9Z+j7q5UZY+SKXRzvtVYGElK6O5EUBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kS7V/YqDh9xfhRdQQY3y6EWCVxhIgQymMB68DUURY1KSMlp2jDyuRcm/LlvX8OiBEY1ijKo5G43LI7aGntIWs6UFtsC2PUrAR3HU636+gN8N3cCHRgD/Ao68ke97BFEmYx5TgGEH+pKcwLLKw0LYAIjWUJMhQNrmc2otH8FTjHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EGBsuQhy; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EGBsuQhy"
Received: (qmail 35909 invoked by uid 106); 18 Mar 2026 01:22:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=s/dl4RA2+P5u9Z+j7q5UZY+SKXRzvtVYGElK6O5EUBg=; b=EGBsuQhygcmrv8aaB6b4NuqAU6ACSGxX+fMDiTOE3C7DY7HNMICuUXyu1dXK41HrqYyVygHAql4yXJKB+vO2d/W01+gsFpffmtmdTBN0Z7dp/guoxA7GiDc7rdTZo62ExpZ6ml77WbWd/xl3qxDgT2Q7u+Nlo0R4TPv2Q6xPNaqT4gx2+IITxQJ7aNaob/VGIQEku51NAvu9rAKXxFbKYG6x4bvdBh7WHvH/1HvgZahLbOD7ncnMceHQ3KulF2FCuqXhgb9xUfFiLGKkPEkpKqfWWxZNgaVd7evJYrkZw40f+GUI+X9gs4rZjtssEcxfdvX+RM7ih41p3ITyS9fahg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Mar 2026 01:22:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 54108 invoked by uid 111); 18 Mar 2026 01:22:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Mar 2026 21:22:15 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 17 Mar 2026 21:22:14 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] rev-parse: have --parseopt callers exit 0 on --help
Message-ID: <20260318012214.GC720335@coredump.intra.peff.net>
References: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>
 <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <xmqqcy13mgdk.fsf@gitster.g>
 <ablCBkmOdoourCnO@fruit.crustytoothpaste.net>
 <20260317145543.GA1828@coredump.intra.peff.net>
 <xmqqv7eul71y.fsf@gitster.g>
 <20260317184441.GA574291@coredump.intra.peff.net>
 <abnwxmoOw-ZLT858@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abnwxmoOw-ZLT858@fruit.crustytoothpaste.net>

On Wed, Mar 18, 2026 at 12:24:38AM +0000, brian m. carlson wrote:

> None of these seem like they're likely to care about the exit status and
> I suspect that if they do, they are probably using `|| true` to ignore
> the unexpected 129 exit code.

Yeah, I'd venture to say that moving from 129 to 0 would be a strict
improvement for the cases you outlined.

> So I agree that there's unlikely to be any sort of backward
> compatibility issues.  If the consensus is that this is shipped only in
> 3.0, then we can do that, but I think many people are not going to care
> and those that do will welcome the change, so I'd just rather treat it
> as a bug that we fix.

Nah, I think everything I have seen points to treating this as a simple
improvement / fix that we can do in the regular way.

-Peff
