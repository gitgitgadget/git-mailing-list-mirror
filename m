Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749444C97
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111191; cv=none; b=Dw/x84u29Li1OKXQbAsw5kQqsKu4YGhY+S2bBpk8OFLGIRu8QxNhTRoEKRxOaZWuqaHhnTEBaFg22si8pg1Di6dTyKqpf4kV8HRHb2N3yYOBbu8e9fd3oUQhE4Gmc0rbH2DWMNLjxzLq2Cq6fuzKRqmH8KtiSGwaEKg6MbesTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111191; c=relaxed/simple;
	bh=m/+POcL0m1X1ANdOOAWWiXnp9wI91V3BOX/TsFXIWbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1u0C+36qmqrFWTwAzEz/TcWfk+3NUwQonoydc2zy4l02q/nHbKvKVG3YSFbuVXxc4Kok4s2jJon/7ROjUax0PCuFHpPDdSdDNPcHx4lGW11Dx+MprMMSTcaUEzY6GSHFDpvzI7qgSGNd/wPB82Y3Z/XfFXFB9J2bhtfi/Z6JcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=DHINNIGM; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="DHINNIGM"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:d89c:95b4:46ca:4d14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id CEE4A60373;
	Fri, 22 Mar 2024 13:39:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711111180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fUCOKCDpu7xjjEMOLJs5cGMNPiXpk42yNo3ghQz9v4k=;
	b=DHINNIGMvH2ae2OvOGOGXzGjKFEOFHB4mnYe0tXzyD7Dbwe5pVTSR1ZIVPiJxuh3R9jUKC
	DqxWULqmWHhVEE7vC3kuPuiyu/uV1hu1coybfcQn1R5/vFDkAAL+Y4MYl84ldkY/yLjE/C
	dPkTbTjjaAyaXwQvh6ksxX/cx6k2P/NVvnq4hdVnDGerpXH26kGuTXnsv2WVRwirScpCKc
	E1h5PLxIy3rkXdQAWPcA4ylLFgLNTALOlHkBdDd1yU8sSf5NsPawDnpH379+Q3F7Z8gtUd
	Rt7uwKxfFevwYVcAGrKNlAQ3ynzEP1zYbkViUfEDQJgPJuSpLlULeA2hV1v32g==
Date: Fri, 22 Mar 2024 13:39:40 +0100
From: Max Gautier <mg@max.gautier.name>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Brian Lyles <brianmlyles@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, phillip.wood123@gmail.com,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
Message-ID: <Zf18DEHen_K_HWvo@framework>
References: <17bef643ca4eabab.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
 <c62a14c7de6ff487b1f66f149d685126@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c62a14c7de6ff487b1f66f149d685126@manjaro.org>

On Fri, Mar 22, 2024 at 06:14:37AM +0100, Dragan Simic wrote:
> On 2024-03-22 03:47, Brian Lyles wrote:
> > I would agree that it would be hard to advertise without some change
> > there. I think that documenting an optional opportunity for now before
> > considering if it should be a requirement later makes sense.
> 
> IMHO, making it a strict requirement would only raise the bar for
> contributors even higher, and increase the "do this, do that" kind
> of traffic on the mailing list.  In other words, I think it's the
> best to start slowly and see how many new patches will include the
> additional summary.
> 
> > Would it be beneficial to request some specific heading, phrase, or
> > other structured text such that this summary is obvious, or even easily
> > extracted with some sort of script? Or is that perhaps overkill for now?
> > I could see relying on any sort of automatic extraction being unreliable
> > even with such a recommendation so perhaps it's not worth pursuing for
> > that reason, but I could imagine it may be useful to have a standardized
> > way to separate this release notes/what's cooking summary from the rest
> > of the cover letter (which also acts as a summary of the series).
> 
> Of course, it would be nice to have a strict format in place, to
> allow automated parsing and extraction, but I'm not sure how many
> patches would actually adhere to that requirement.

While not every patch would use the format, proposing one might be a good
idea nevertheless, because "clearly marked as such" is not necessarily
clear for everyone. At least that way if you don't have any idea you can
use the format.
For instance (inspired from the k8s project):

```RELNOTE
Your release note here
```

-- 
Max Gautier
