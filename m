Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833169;
	b=UAQgqzXkbSxUg0dKl0RO3kWY2oZLYUjwxph+8AQHCLpSbY62pRot05v+0en88ICSRTaw
	 e7oGgk+FhYUsafGtl6NMYTliKMXDx7f0uhyiLwbztjzBpE1WSGckp86oG5TfH5urq7piY
	 ltnJStCfwGISwnGLhMuNBUKPGwmcevwDG/9sQedqw1f+dCOCuPuI8AtsLhfQdM3qn36sr
	 nYC1hMjQFhBynBmVW8pYqIkFY4bSpRxMiYls1K3hwt+8rMO4bpExSEoNifsEHjKXENrf3
	 FZrQSkNOhdd+4H3eLrWIRje5wixsTi1XHNVPuCTSjjWW1TzLkqjWLAvNCWLDMWJCVUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833169;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ntSdd/7t8n0qQM26YMG8GTQqsfxcL9dJ34BERIuZrsw=;
	b=KjEASUPbdKmVY2cs56UZg7uNIjdW24qszTJeAtrOSHsZSJM2g6R1Hv1cmY5PHGk1Q/dX
	 o6LYkPUcnB2/W/2rjvPu1CS/VZJXVrC3YhEgJU9vmyhKIntaXXvqJpR4WFo4gymgDO9ih
	 Z45VUL7nVE1l074okGlNeiinoWZN5J8s0jecNy+FR/AMQaiOrA0YuMu2/bvYJOQP6zzWC
	 Iu6at0aA4g6z9owIgcOrIDNkwe2Hno91YrPxq078FsTu+0983t6JeJs4geM24Izd0vdvk
	 LiWo6kk1+u0okWDhzrF/uT2bjM10dZOdy5gLIDnk+96S/O2JWqhpSQOSn+EMoO/3tUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hZ9jitTI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=u13tecth;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E481606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 12:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E481606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hZ9jitTI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=u13tecth
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 517A81400045
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 07:46:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 16 Nov 2026 07:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794833167;
	 x=1794919567; bh=ntSdd/7t8n0qQM26YMG8GTQqsfxcL9dJ34BERIuZrsw=; b=
	hZ9jitTIdc2h+qTMNaj16bEAssQIzbPzLc+T/xC3bC4Yt28fjhwLgxIibOk5HdfP
	FJk4gUg2Qgdd4tRJ7rwY7iaL/QcOw/GLYdPZ3tGB3jbH0D2nwv1ocYdLlcO+0Q3G
	6b6kXmQRVALpMY1+kLaDlv0AuqcsZ2FuD6FbVGcXMPbIjpMr/PJtTQD9clEfBecU
	i0Bbhmu37+vg2cKmxHTnhmkN8mk2FIHJOi1fbGHvhyNYxXim8uaBzY1yaz/02wXg
	QiSWEX/E3M8X+0xbn5s3jl81qJkkyb2hDiIE+ZjZEO5XjSblfEiOWC28rO+g0F5h
	zLLJx+741C9QD0L5B+U36A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794833167; x=
	1794919567; bh=ntSdd/7t8n0qQM26YMG8GTQqsfxcL9dJ34BERIuZrsw=; b=u
	13tecthwS3c9C9QzhOV06Ra3OJ5xwgJC8GIl0YoJh/uOqHBvNK9rrCD3mDpiG+3g
	skznYaOHi2MRvp7j6eD64vgtNDx1SAyYBpeeUiby2ttmHI9XXDb7odTtGf1B748s
	p+EVOshcUdCmL/uQCMMHtyK1Ecu0zHrafeLl+HcgmBBZ9YLP8m+1emlXFuE1aIw2
	nl7S3HEX6Lc+sG19ytxqhp2cfXiDMbboNWZfrkqTLVKDKBa8j3C0Anj7SvjrYdW3
	BfX4EjqhOBwhjnaL2bwm5fYXGyiXZ5bFWZD4hOyIdKXk9q7Uh5AJ2MTp5TgTeU0B
	YsttOe7nsYNkpnrXlGgwA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794833167; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Vq8LrA/ouUApGcD9VmBD/gXjY2IaosMpuQasB/ljWZQLgIp
	xzqmO4M4GIbEJJ63mj5+WpsU8eN29Dm54/qkxVIV+ULzAtXGqDy6LslahY4mNz2+
	p/r9ecpF2WfXJV2xu1ZBbMdnmYEiXZm2rSzJAe3e12CSoysVmGF4KR8L1oEAavNL
	G6arw+FWeuriNRz1e9xBt4Hudsrq0fOr+h6MH6fGRWRKGURPjc3kKkgin1RWi8Yf
	ha9/GY6NYJU/gFjpkiAJJGqb7y773DnMgUNp+lTKlQKEK1xSqoiwaXC3UgnKcuGY
	uiJfJHTakHO3cQgnwXaLda6585jJ/PfvKR91PTQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hxfBtyOcU9nTCAaBZEPJNMtiV5kRiEii+PtbzbZCDvU=:ntSdd/7t8n0qQM26YMG8GTQqsfxcL9dJ34BERIuZrsw=;
X-ME-Sender: <xms:D_v6atbotOQm66Pqcek8s4JqX2JBRJzwzeo_S2wT8r0UJiuGfG5u9g>
    <xme:D_v6ar1eUdWClLLOV8yk6QiLk0Iwthx6-a5ipV4CuzpMxwODQYH-dpNcah7JEbt9f
    -nIicNUWUoxH0vbGoBTvA2wtNmmvrR9sYVJs1ZmQqXkyV3uhDBjA3aT>
X-ME-Received: <xmr:D_v6atUsfV8vzgjZhoinUOW-0udYJgJ9madEDppPfISgaT3dcVXVzmIOtQ49jvEcOI916fg>
X-ME-Proxy-Cause: dmFkZTFcsIJNHKjfk6iVxsZOg4/thfxRT/OM0uYzoluMXrX8fkb83Ku/QzT3/l7swFEarV
    w/HNI8oc8KXDJoi3OSqk1vh9buLoIIJuExWk7obqLvthhwB/sklvH5PSGXn09ZXo9BmYg3
    dH8neE9xy4iLh1OrURalNbZjCu+9Uj1AEs48SvWCg2fK1FaxwGbeL8O9uYSC4MiI1dpGvm
    986DS/hQvlZfyaM+Mu7LxaDNZIl/MpiRXq5uI7t7gscF0h9GtycKLLRHgB12yscXKGGChe
    lCCkb/e6bq3xP6G7fOBAKfRHVm4jJhnjv9AiyiVGRt7ULuw+QbTzI1KF0RX6UUApy/YrpV
    dnOx8KlxxsM+5p7HXyb3UJIdwCrFOdT1O6imDYIrbjXHjI+X4UvZ8e4LZtyMm62jYWtTTg
    /G3qfUGTMJ0ZICI3J7B9OehmDqeVPEfj+ZjrS2IsS1VQM7vPdGnMGEu8bKq7Gpgzu7mUCW
    ++QpXJ9b3D4Ff0jPBhSnbwb9raHlHGlaUjRa7lYkunW/TuhFCTLFKlB5CjyvuHB/QCHzwz
    xSRl/l7WpsycyazOw3iM8tZbs7J1fgGUWykXVvaIqvzn/K9HL1xPVASpjI/434Xw3tJFty
    pq7kDUpAFHlJ9aeffPlCodn0ePBD9hirdR4nVwW2sf/SPX9Y2xBce84QSMCA
X-ME-Proxy: <xmx:D_v6alX4uRHCgkXWQ8OHmJvU-PYglzUR3BGpyVY5bbAwT0MdRbzg7g>
    <xmx:D_v6aseVCLDN44_2uZeSG8qRKliYcDsjo8TNXHvMBdor4bcC0KFcTg>
    <xmx:D_v6auUQPlqM_q-v8fiBqpt3RcKnPAeMZPWXd_SbGbfvd-TUfTEgHQ>
    <xmx:D_v6alf5icaTs050y8XaXl8-QIhRZfduppiRrors2ZiPxp8BL2_9bw>
    <xmx:D_v6aj33hAiBPltMNEHkJWEGlydtdcu6hRYFHP4Rudd6-P8K007nbKM8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 07:46:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 474a0ea4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 12:46:03 +0000 (UTC)
Date: Mon, 16 Nov 2026 13:46:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Google =?utf-8?B?4oCU?= Mergify <remy.duthu@mergify.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] partial clone lazy-fetches a blob it just wrote (bisected
 to 5946a564cd)
Message-ID: <avr7CP29sPOdS5DE@pks.im>
References: <69EF6B53-E153-46CC-B7EC-536BEBE8CF52@mergify.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69EF6B53-E153-46CC-B7EC-536BEBE8CF52@mergify.com>

Hi,

On Mon, Nov 16, 2026 at 12:45:52PM +0100, Google — Mergify wrote:
> Since Git 2.54.0, a cherry-pick in a blob:none partial clone can try to
> lazy-fetch a blob that the cherry-pick has just written to the local
> object store. The server never had that blob, so the fetch fails and the
> command dies:

I think this is a known issue and there's a fix in-flight at [1]. Could
you please test that change and verify that it fixes the issue for you?

Thanks!

Patrick

[1]: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
