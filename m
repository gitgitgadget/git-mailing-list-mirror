Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176BE7081A
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 05:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782104714; cv=none; b=Dfql6Qb/uV1pBs5O/GWR5YzLzdKYyPZ4WcTcpRURK75iOuVSZGb+SJ81AHR9tCtuKrrEN8e4ZKPz5yqyhZzwtu0VBusf6nC0tNSGWCmX5DTmQxOvEzWp+VMh4fGtjDrun+LONXySZcd3tChrUu61Spvup/M0Acuyph5bwW4zgsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782104714; c=relaxed/simple;
	bh=LtKpZcse68ocdTADpIwxTKktjZhdbKJnoTTFNVmVASU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UY/GEL4NWVHx85tBCKIQO5RBSO119eJsIJ4LITIEh1a5H2ndm7YgvQKTWvHB5lgKdouuzjVGnHH9xtpmF1D1mnrY7ODSJ4goDEZ4g0GMHSwjT62O8q9G3bunikKcBFBDwSyzdbm4Ey5C7tehQXL/sxB+h75dnXGJ8N7Lmy3GDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i8uL4qWJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNTvP72l; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i8uL4qWJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNTvP72l"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2315A1D000E2;
	Mon, 22 Jun 2026 01:05:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 22 Jun 2026 01:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782104711; x=1782191111; bh=LtKpZcse68
	ocdTADpIwxTKktjZhdbKJnoTTFNVmVASU=; b=i8uL4qWJetgx5aqXFmC3CQDvJW
	Vm6K0as2BE0yznZrs5tYida/L6HussO1oKc1D77b5yLwuVANPG3/h6BIkAheSW0y
	IcCB+rkmOqZ7JjZDBAuMC5RpRP/ijeIYMMiFdxs1+0QO/f7pC3WD4oEZKE87RgSH
	Rn18CYhYNkk9NdWiS+3nfW0XdFbxdLUCfDZOea1SmVo2VqnTxU+S2o4hCedM6OCM
	acaYKt3ejQ6hJERLRUAaQihHhR7Lmp/mImX9aE5snCxm6L9q/X8Ww8YycyWAqmrG
	6qRbFCl/QZF2giNcsNqrfVmXOBGtUxCEERAFdOoJkMqCD+krmDPn0r9WcZRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782104711; x=1782191111; bh=LtKpZcse68ocdTADpIwxTKktjZhdbKJnoTT
	FNVmVASU=; b=RNTvP72lY6s4tOigWT6z3YKWJueyG5RriaExXXU3IvLgX1wXtKN
	a6U1VoCWVbpLG1WABdFe9gHaUa1XmSv/6cmbXzpqbNQ47TAaAsJfhXQEJh0QhDZU
	RkMgBPjz4fXBGPgF6VmlYUfDGwmhVTAL9Kv9Av7KUxEsv6Hz2PztjUoAI+JKSESJ
	Eghj+CoD0c59UY0DIiNVupAUb2LKA5idopKds0ofP6aaPn54pmp7gQoz81/3bSOO
	fKnjgQ5U13J8lqDpxtijlws8mstko7UPTEvZmxyATcJ1pZWoBICob6KRlpTR5S3q
	ddSzgNrcoYN2bKBdzS4dnXnA3ye6ccWfG6A==
X-ME-Sender: <xms:h8I4aiBlD39ZLP6qyIyUevYN8J0Y5X0KNyvl1Ycdjxi-lGeF91XXfA>
    <xme:h8I4aja1FQONxg7Eqzp-DCMDWw8lOopzpaVnkgFyKFMFgK0BLt3K2Mzkfg81pzC-F
    wCH1pVGLncJUU7ULPb0kb4-zWQk8NPU-lstL7GzMVWkXRICuUjLkw>
X-ME-Received: <xmr:h8I4at4-51VOTynoZW-P8IHBmk55i3miptGcGAv9GrwNY-Vuy_7DBCJCPKpoTtGqyt_ebnQZ5R6OvSky8Z7YEqn9gqPKB0pq7SwzlHo>
X-ME-Proxy-Cause: dmFkZTFsh37xzw6XUFZFPZmhjanpULW7U2nbkvAguPdBtMsab6FQccffhEKyKGCFpW8Z8u
    kijrtCWo6Nlh6rbaoarSRbTKzDNaBX1T41He8uBqnt+PxdhsqMSrIG8wYfM9z9eVu68N6T
    t8OHU5R2wbBQgtu7icTw4JueGBKTG1hg6NiKxyNZEvsXpSe8aFze59iNLiypsz4W5MqfVK
    astQhEmB3/mpe67gUOG5W9Z6CjxA5R6VKJSKRwNJmZ7neYN62SDIlCnpeqIj6DmBmBL/z9
    EELCC6N9+RtAfg18Kl6MrQzoT76wN0Oe35oKv09q6v0t7UXOnOsWZWv26Pt/Oo7urzbxoB
    VV8x6poo7XYsjJiHtDEJ07cfS44FgYPShQHVxesGS+EmbNImioPFb+TGEavITfZyyKCII8
    8RquEWkhF+BWU/esh7EABgJSRrqT+1JMIGB5YVpVr36eu+bTYZARfuRrY6S1+aBce3fbWO
    PMMmKkrmL5WDdHEByx0CORsySSkKsDBftrYzywJUw6MIGfK13hO5WNtFK4nAoOLybOudUu
    HPDnMgcEbpmRdYdqu5HWZaNibkzsk9rSWobgwRZP5Sq0SCCeO9feADz0HT3FUbzpMx8upR
    XIq8FgfEn0XrNbuzpdjf1FXN8Kez04r/qrBYrjVuOXc2GH0huXqNM7gCKiRQ
X-ME-Proxy: <xmx:h8I4asZiOlSgMNC31oYfDAm2r_pwa63tL80nM1Dhfi6Rfrt0sZMG8A>
    <xmx:h8I4akivN0lWikCOwYOZXyG-49yngRbVxeuiIYsRTOxjuG9p17m0RQ>
    <xmx:h8I4al-rjD7SxcrmKaI8Cg8XM9JPCjJuDQVI2OKFEqh1_lrjUoQW4A>
    <xmx:h8I4anqZqbc-F7Ckb9WXV6cJ4Qj6-KFOO2xk6eyCN4wn1Z3OvhRVxw>
    <xmx:h8I4ag7TpymWKYdjd4VCng2Po7BmKvNvUNfSloSm7AAw5u6CHOnAR6TA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 01:05:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Michael Montalbo <mmontalbo@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
In-Reply-To: <20260621213407.GC2297179@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 21 Jun 2026 17:34:07 -0400")
References: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
	<20260621213407.GC2297179@coredump.intra.peff.net>
Date: Sun, 21 Jun 2026 22:05:10 -0700
Message-ID: <xmqqqzlz412x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> If the problem is a racy deadlock, there is a reasonable chance that
> some jobs may simply be lucky. Even if things like packing refs help, I
> suspect the problem may still be lurking. Maybe I'm just a pessimist,
> though. ;)

I share the pessimism X-<.

> We had some HTTP/2 stalls/deadlocks in the past, and they were dependent
> on libcurl and apache (actually h2_mod) versions. IIRC some of the
> non-TLS code paths for HTTP/2 were not well tested, which led to
> 8f2146dbf1 (t5559: make SSL/TLS the default, 2023-02-23). Of course
> after that commit those cleartext code paths should not be a problem, so
> that is probably not exactly the issue now.
>
> But it might be worth checking the versions you're running locally
> versus what's in the GitHub runner.

True.
