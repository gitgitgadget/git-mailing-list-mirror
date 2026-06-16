Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D3037C0EB
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592029; cv=none; b=OdwIVAIudbzD0UJA/TICQMj2Y9DddYdtVqMNbMdxk8+Jwehk4tbE5KL0NSVI7Ogc+eBDuS0eVeE/3zhXOsIH6b6KHxcwDBzGL2y9/EaV0JPv4FeCRQ9Wlv0ZA/DAtvlBugcqAU5N+FOB8QsDYqxuIF9t09g+PA1h5QxbI05L3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592029; c=relaxed/simple;
	bh=w4MTsa6Gu/CNnNCETFyXj+tqKWH6MBtUbOKVd383Vc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XAz3j7FAbclNUB1fiMCTb8GQ2ixPC3TiMTBX7DPSTk3J/aDBXVZ2f6RhBL8KD3OUMgPdMvNQBJDyYQYdzivqf+UeBLNVqgt82Y6+8nep6s2GFHCpnhLaOS/GC4kddGCbvCVQ1/lKpbfZjdPohYnPksBziDGZXUxcJdnqEOE20jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=TSNWqsgL; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="TSNWqsgL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781592024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLaZgfjh1g0l9DtV5JpupIf3LP9ZIPcn1z/x+ShVT2Y=;
	b=TSNWqsgL17dqoVAAdAuJQjz3+hWxEwDIN+/ZNXUC8GopdosTcegjETMpnYC3w1XlXWaave
	pXggrGEg1aGKcIk4lbkYe2KyH1mGmmHT/QREBMgojZT16hp0WJ+4dvt7rOBKr2tbPCFwdI
	Uv91jFkc5r4NKq8a5m20R/IAx6cxaa8=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, Weijie
 Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, SZEDER
 =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 0/3] Documentation: recommend the use of b4
In-Reply-To: <20260615-pks-b4-v4-0-22cfca8f19c5@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260615-pks-b4-v4-0-22cfca8f19c5@pks.im>
Date: Tue, 16 Jun 2026 08:40:14 +0200
Message-ID: <87eci7yomp.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this small patch series wires up b4 in Git and recommends the use
> thereof via "MyFirstContribution", as discussed in [1].
>
> Changes in v4:
>   - Improve a commit message.
>   - Link to v3: https://patch.msgid.link/20260608-pks-b4-v3-0-f5e497d10c56@pks.im
>
> Changes in v3:
>   - I wasn't really able to judge consensus one way or the other
>     regarding the deep vs shallow nesting of cover letters, so I still
>     have the change to shallow nesting of cover letters part of this
>     series. If we continue to be split on this one (or if we favor the
>     current status quo) I'm happy to drop the first patch and adapt the
>     last patch to use deep nesting of cover letters instead.
>   - Hopefully fix some confusion by saying "shallow/deep threading of
>     cover letters".
>   - Fix some more instances where we recommend deep threading of cover
>     letters.
>   - Link to v2: https://patch.msgid.link/20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im
>
> Changes in v2:
>   - Reorder commits so that the b4 docs are added first.
>   - Add a section that highlights how to configure b4, and that points
>     out that the per-project defaults can be overridden via Git
>     configuration.
>   - Add a patch to MyFirstContribution that recommends shallow
>     threading. I mostly intend this to be a discussion starter so that
>     the `.b4-config` file matches our preferred threading style.
>   - Fix a typo.
>   - Link to v1: https://patch.msgid.link/20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im
>
> Thanks!
>
> Patrick
>
> [1]: <xmqqik81xpqx.fsf@gitster.g>
>
> ---
> Patrick Steinhardt (3):
>       MyFirstContribution: recommend shallow threading of cover letters
>       MyFirstContribution: recommend the use of b4
>       b4: introduce configuration for the Git project
>
>  .b4-config                             |   6 ++
>  .b4-cover-template                     |  11 ++++
>  Documentation/MyFirstContribution.adoc | 100 ++++++++++++++++++++++++++++++---
>  Documentation/SubmittingPatches        |   6 +-
>  4 files changed, 114 insertions(+), 9 deletions(-)
>
> Range-diff versus v3:
>
> 1:  1aec56f76c = 1:  b6b488e6a8 MyFirstContribution: recommend shallow threading of cover letters
> 2:  f2036769bd = 2:  1a68b993d2 MyFirstContribution: recommend the use of b4
> 3:  fb522c7d90 ! 3:  5bc8fba96a b4: introduce configuration for the Git project
>     @@ Metadata
>       ## Commit message ##
>          b4: introduce configuration for the Git project
>      
>     -    We're about to extend our documentation to recommend b4 for sending
>     -    patch series to the mailing list. Prepare for this by introducing a b4
>     -    configuration so that the tool knows to honor our preferences. For now,
>     -    this configuration does two things:
>     +    In the preceding commit we have extended our documentation to recommend
>     +    b4 for sending patch series to the mailing list. Introduce configuration
>     +    so that it knows to honor preferences of the Git project by default. For
>     +    now, this configuration does two things:
>      
>            - It configures "send-same-thread = shallow", which tells b4 to always
>              send subsequent versions of the same patch series as a reply to the

No further comments based on the range-diff.

-- 
Cheers,
Toon
