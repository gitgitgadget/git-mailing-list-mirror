Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17551FBE8B
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920947; cv=none; b=cGWnWKBXgEGZmDDKPz4s0PnDL+gjkRsivbn3TRbb4Yws0ewhVYBMC6TCidnSp6TqLHIJpcVMiQoQUoYAnaObFayMagtXWfP+a7tntpWisfKi8HH3ZgBTI1fdPnLd5/J09vMDDGZruiFkBHampNRJYAqDU4df37jm43XeIw6ouG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920947; c=relaxed/simple;
	bh=U1FXTL8oWOQiIviJ/ZrY7Hab5gUqE6/RUAH1V462Jtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOpACj2B1qPZzeh8eCsAt7Acf1hx1YcD209LsM/8i5WH8B82gwlLqfWbAKb/60SzODPhBRR0vlq6odAzLE+ZxEkp/a4P5or+BKyNL9G4mSXtXGjBFmgq5AvgTfmuuL2MveeJXTkF9OxKt37eRPk990TJZTZbFTqoRFuWsB50N/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=C9SOEp6u; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="C9SOEp6u"
Received: (qmail 9467 invoked by uid 109); 7 Jul 2025 20:42:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=U1FXTL8oWOQiIviJ/ZrY7Hab5gUqE6/RUAH1V462Jtc=; b=C9SOEp6unzf2cnkYYDzGTtMaNO3EBX94A+aDmh2Ap+8glpuKrJ611myImGr1LNntky9o4YyH/jHItTQwp8lgh5fmRLM0+yTN723hPmdlFNhOJLkpHcYNSDbhpKBjh6BHSL6uSzbYtari0Owf4aUJyXAIF+e1e6uqWmhe6vc4HDZMHdRqb+CACyw2FUWmVK1DseYQSMbA/r4j3SqZHjrjUp7QH+99OXKmVafFT0+Z1SK33OLzzN2wYzEP3J8IoJ8FxkJKGT36GWX/XKyuZ040jOgboXG25HB+uisC33+yzS+Wj4ARg9Tq5jBxH6nDndExriqSK8G0ICQKmcoCBXl/GQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Jul 2025 20:42:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9353 invoked by uid 111); 7 Jul 2025 20:42:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Jul 2025 16:42:26 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 7 Jul 2025 16:42:24 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	redoste <redoste@redoste.xyz>
Subject: Re: [PATCH] SubmittingPatches: allow non-real name contributions
Message-ID: <20250707204224.GB3115893@coredump.intra.peff.net>
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250706163009.335780-1-sandals@crustytoothpaste.net>

On Sun, Jul 06, 2025 at 04:30:09PM +0000, brian m. carlson wrote:

> Our submission guidelines require people to use their real name, but
> this is not always suitable for various reasons.
> [...lots of reasons...]

I certainly don't disagree with any of those, though IMHO it is not even
our business why somebody would not want to disclose their real name.
What is much more interesting to me from the project side is this part:

> Retain the prohibition on anonymous contributions that the Linux kernel
> has to ensure that we have some line of provenance to a known (if
> pseudonymous) author who might be able to respond to questions about it.

I.e., why are we sure that it is OK for us to loosen this requirement
(without jeopardizing the legal status of contributions). And I think
the answer is along the lines of "the kernel did it, and they checked
with lawyers, so we can piggy-back on that work". But it would be nice
if we could cite that source, and maybe even lift some of their
language.

Looks like the kernel commit here:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330

cites CNCF here:

  https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md

I don't know if there's any public discussion or statement from the
Linux Foundation or other legal folks on the kernel's wording. So there
might not be anything better to cite. And possibly we could run it past
Conservancy's counsel. I'll leave that up to PLC folks to decide on.

I kind of like the CNCF wording, which seems clear (though naturally,
IANAL).

Regardless, thanks for keeping this moving forward.

-Peff
