Received: from olivedrab.birch.relay.mailchannels.net (olivedrab.birch.relay.mailchannels.net [23.83.209.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4FC64A8F
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729150; cv=pass; b=pRISOAjlwQj2mgv5MCcyewuYwhbBF3Ceel3S87thUXe7MqCwMCNuojIkJWe8CREZdSPRjCzya2Nk4LWf+9EeX+bC/FStooKGYhshIwJBOzxPZOvgLJTsfu94qokAckwcwFOj0uWgce1KPXLB7mZrcEGKhkZ8OtjRMzFYDz6UU3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729150; c=relaxed/simple;
	bh=nOSh4wI7ZXpgkPFkxuep7O1dPkH1XHJYPriDgvPfWZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwyU/NsRmWl2M/oUv1naDav8Ndsn2iztLq/dSW50AjM7L/JMltcUPeB99f9LUfGF/nNVSVDuYdJ8HsGGS/eNh79GAumBHzE+SPmgGSGpYHEBF1SPntMEHIBozf5A+i+H9w/HaOrcus2sHCOiozU44BKgS+UY13r1OSGTgOZshI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=ScDjaTG1; arc=pass smtp.client-ip=23.83.209.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="ScDjaTG1"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8D9CC42164B;
	Wed, 24 Sep 2025 15:43:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a255.dreamhost.com (trex-blue-9.trex.outbound.svc.cluster.local [100.111.81.63])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7A7A4421A0B;
	Wed, 24 Sep 2025 15:43:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1758728611; a=rsa-sha256;
	cv=none;
	b=N+MqNdgwEaXM3LGhIiKyxwNj4qNXYyo50qToDZqDrqb1lbEzrmHNoeCfbSqFlCFLhv9++S
	nmqqfaB4qQQRvowfcVrY6jjWT603YMkobnE2Z5pC/XpLydw9sv/47st0etp34mmXBY1b9O
	bjB8TIF2Fw+4p/sk0XD7/H2XsA5DxNW3JxwoaQSNLukqP0x7hK/LIN5y4ake5Re5BWacQT
	IaK80+tM9/w2b20u5ROWwbuaclEhxo5TgKojd6qQ/B7eQavAKzn/O89tp0eQUGJERQaquA
	FjxDLrG0oX0++b0DSlCpcnsJ8naUyAOwRyOIv+iVrgaRfecpZc0xsn2z8JhHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1758728611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nOSh4wI7ZXpgkPFkxuep7O1dPkH1XHJYPriDgvPfWZU=;
	b=pt+9MROi4W3cTKamNZ7I/Z36xYqh9J9ftwJRC4emYqcbHlfiJzzbqsdLsJ9e3gkeX7tKDw
	fvK4ZIXu3mVG8ArnzuEJInn/FmM8mhoXd8SUlusibPI+kbTzDSUoHt7/xBcepbYADmKg2T
	vQEWRHt1f222GyQUN9R9HXn++TPeVaHl/FMT2BHYqqxyE0/+N5z2chdQPZuGjQxRdCK8z4
	lP641RNxdLMCj76jbTPg717cb31FVfzU7KVN6GwesJp1J9mYCAP5MhTkD8YkVgHCHv6V9b
	NDzddf5r3Ja4HCe6gfPkOjD4fsNhIcbeorwOOp/knLlr9Tq0z1f1ajk4WKtExA==
ARC-Authentication-Results: i=1;
	rspamd-58f8c88f6c-prf72;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Reign-Snatch: 34e3bfa5713450bc_1758728611833_394591273
X-MC-Loop-Signature: 1758728611833:2259449683
X-MC-Ingress-Time: 1758728611833
Received: from pdx1-sub0-mail-a255.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.81.63 (trex/7.1.3);
	Wed, 24 Sep 2025 15:43:31 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a255.dreamhost.com (Postfix) with ESMTPSA id 4cX1N26XsVz8Q;
	Wed, 24 Sep 2025 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1758728611;
	bh=nOSh4wI7ZXpgkPFkxuep7O1dPkH1XHJYPriDgvPfWZU=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=ScDjaTG1MF2vOSTn/iB3qIZJhKPqPJQpBUqZ7KKEHFCxUVm5S74U+oBiLVzdbAJcg
	 Yy7S8hqgId3lSioxrt49DlhnW0/6NU0Ski2/7fxuFK5iqGvdGtW2GC0kj4nYQWsSw/
	 o6k/47X9ZyL8e3gaflmhL8zLfsQbA68UEpRke1FvOHQbDR/BD49EPYODeZn7gDKzWA
	 Qc0b0MqrifjRX2c1JpUbBibI0rdtJGGOA8AGOsIIvWNCsBGJQSL4HC73QiAChPwjHr
	 wAz2zEbomuwTQHcDpY3OLqpJS0XcwwSKMJphSFv5b1KgUz29qpqB+BVYKIXYTKWGIH
	 YbpDkWe/6uNeA==
Date: Wed, 24 Sep 2025 10:43:28 -0500
From: Nico Williams <nico@cryptonector.com>
To: =?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?= <velocifyer@velocifyer.com>
Cc: git@vger.kernel.org
Subject: Re: 0-Based indexes for git log
Message-ID: <aNQRoMgSRVvNtStG@ubby>
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>

On Tue, Sep 23, 2025 at 05:15:46PM -0400, 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣 wrote:
> In git log it uses a 1-based index for the date instead of a 0 based index.
> So it says "Fri Sep 19 14:23:24 2025 -0400" when it should say "Fri Sep 18
> 14:23:24 2025 -0400" (or "Friday 2025-8-18 14:23:24 (-4:00.00)"  to get a
> better format)

Day of month numbers are 1-based.
