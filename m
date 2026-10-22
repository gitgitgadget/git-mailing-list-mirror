Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672806;
	b=AfQn49BylhVbiiqlacnjczQeGXz3LCOYIfTK7/1HaVe7DYtl+Zbgq+ToGvPUl1G2roRn
	 nEXghupkXw/mC5NpLPUySeoc2/d+Akoz2EfOFTpVp7874UIzZKZYmqHqammVRNJ2JSpKz
	 6NkyYeVXOm4RisM/wyOGYd4PZDDGqvDOaoh5O6bPUf5DdxbeOandPyXzTbT1NUPZuHX1W
	 a2+ASewFVVdkCZIfQZotqY/doQyh2F0RRyhWeo/kGhMaAO1UXGkzQUQyZQucGdWUiDFNp
	 MSkqYh2+ffeT1giTvPWX2RuyLAOknnWrzIybirmulqnyg4OLQ3eZIOW7VFa7NrMgwDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672806;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:To:From:
	 Subject:X-Mailer:References:In-Reply-To;
	bh=zNrIaSl95UP7QTgprMVlwf58/VWAeHP8HMzg/q/d/Tg=;
	b=febHw7WlyDunCDk5249DSwqcK/PA7uDPdUqRMsNTCzwi6ZoRK8LRTgZIuPUCrxFYOL60
	 yFPEer6WmkIjEsupawAyuqDVUmU1Tb4qhOLIjUCNg8M8acpAfVPHZT8Do0ULeACyDjZWH
	 k98wZ3DRCrpokCYyrVIcY5ur03txDv0aVt7UFbFmM9CO3e6w96A4kuq9z8P8DissBq0DI
	 jX+Mu/nT2hU4ip7D3vSM2qkU6q2TdF8V8PMdT8fRWUFtXunVWCkRYBzUwveePK4U2zTQ2
	 tQ/qdam4wDbPgZI95k3HB/adMqxmkAnGbOFCuELnkTF5TD8m3gBPnMoM9uySaLllW8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=OAIKamW5;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9B606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 12:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE9B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=OAIKamW5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1792672805; bh=zNrIaSl95UP7QTgprMVlwf58/VWAeHP8HMzg/q/d/Tg=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=OAIKamW5DCoTwWGsvEcrsn5MLL5XJV2UPfogTxqJdCNVxmxFRUgdtjRJo6Yf/UMBw
	 BvxXRX/8CEsYam5dSR5KypIkwQGoQ5miXNIWXMGkhMu3Cx0oX0HGajCqoTqAIVB8WE
	 ScZskl+5x1OzqL3VnNr3qSJ3AUcFk4mttLnsXkTI=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 1B39662AB0;
	Thu, 22 Oct 2026 12:40:05 +0000 (UTC)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 08:39:53 -0400
Message-Id: <DMBDGW6SDQSS.2QROT2GXP0R28@lfurio.us>
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: "Colin Hinton" <colinlewishinton@gmail.com>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: [PATCH v1] remote.c: defer remote.<name>.followRemoteHEAD
 validation
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261018235508.848-1-colinlewishinton@gmail.com>
 <DM94QXU2Y6J7.39IGDUTB5XN1L@lfurio.us>
 <CAHeTm9N4s744v0bgJJSbPoc4=1omKrhAXNuoY4Wey7FZBw-48A@mail.gmail.com>
In-Reply-To: <CAHeTm9N4s744v0bgJJSbPoc4=1omKrhAXNuoY4Wey7FZBw-48A@mail.gmail.com>

On Wed Oct 21, 2026 at 12:30 PM EDT, Colin Hinton wrote:
>> I like the style change from $branch to <branch>
>>
> If I am reverting the change to fetch and warn-if-not, I will need to
> revert the .adoc changes too, but I can make this change back in the
> remote.adoc if we believe this is an improvement.

It's more consistent, which is why I'd be in favor

thanks
