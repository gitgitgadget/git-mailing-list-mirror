Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8891BBBC6
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510613; cv=none; b=EyacPp/xjUqTqU4Axzd317+AtRqS5LIQpiqbcEEdSak4kn/GALb8ewNXPaBWyHVsehuMDUT+rvpvaSYJZY62n6LiFwERaxlsU3jjSXcM2FNOyeAOJoSAeObSj9gFZoW/KB0Cy4yx7jCbB5h7qN3YiJQ79xkDXT970nKID1tV2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510613; c=relaxed/simple;
	bh=PS9l84e+xoi0lrifBv3TQkEH/jwfVZaMoN2Oe7B5TGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuKbmSpLfu76feYQBhW8Uqq+j0sMbs+pNKc5jHsbg4xBbvfEdHYrD1zySINzdGYD2WwNvt2GXUqD1ZRa+ol8Ha73mwBSRkmd+79Lx/XOMH2SqUBxYOxMhpKG6ftM410j0zuAlD923CqkVNtPpaTVXQHfbrU4XYP/JAZOynIkJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BOLKOXuc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BOLKOXuc"
Received: (qmail 4550 invoked by uid 109); 10 Jan 2025 12:03:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PS9l84e+xoi0lrifBv3TQkEH/jwfVZaMoN2Oe7B5TGw=; b=BOLKOXucw2bi4XHCsjO5PaDFjSycrSCryqM2YM9N0jxLo4XEANRS6eUIAfjBpI8R4Dry2V9ayJOPO4HiRDVHij7X4Pb3+IitfUtZyEAr4LsFzcWHB9Rh9VFpfL+ziJ5enXTR+McHDVCpPJP9V9XAw1hDwF8j098e8LOAhM+ty0DZNdhuaZ0ZIU4gadRQEmDq8fNso1Kg7jFWlGWcVZAQjnD2Rc1Eg18qlIHtg1/Llyqht0zm9/J6IOGQmT//GiZoQQrIZGqFHECeKNpuldxeUruktPE0MWC29Z2hhupNE/R6rtKLU1Jqrt8edF9uTL6CisiJKwEt7Lk7l8MjRnk7Ew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Jan 2025 12:03:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5380 invoked by uid 111); 10 Jan 2025 12:03:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Jan 2025 07:03:30 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Jan 2025 07:03:30 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 00/10] A couple of CI improvements
Message-ID: <20250110120330.GD1014503@coredump.intra.peff.net>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
 <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>

On Fri, Jan 10, 2025 at 12:31:56PM +0100, Patrick Steinhardt wrote:

> Changes in v4:
> 
>   - Improve the commit message of the SIGPIPE test commit to more
>     accurately describe the race.

Thank you for addressing my nits. :) The result looks good to me.

-Peff
