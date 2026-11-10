Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329129;
	b=em8so38C0mNybcl2EZUqD0/ClvGuUbOunYBG395+VwxaUZ3SSsPswWhhlPdbHtJae3Ao
	 ykaqvDErqfkX9aNTA6fNxwuhnl+dHn/4mB/T6Ze1rbNiYFqVt3BTpz5kd5FreEEXEw2AG
	 btomBP9dNT1lFyUy8cpn0Yvc5A/6qic6nlCIvZhDTjYxuL0xmWeZAA0+03QnF7EBLBdzq
	 zWBHkqZk8YblgGrhDu44oYbmsN8Pn7tTYO0bL3Ax2I2fSjluRVx1KxTgnkkaIW0EF+v6H
	 K/Ub9rLWcDxnyUyKhGdAgWf1DxNb5i+cW3NgRcN4tYt3PccX2erA4DMzoxpsbygX2IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329129;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=9jH24mtF8WCjadP09XsT34NM7pFf5eTGrK9geMzUo1A=;
	b=po8luUfDn5CQXmRDNP5wYwqqUileiQbJZOltXFXpNEqNmfGoRj9j/wjvAbis+y5YVfvb
	 z4VyO8y/VL7HOoz8PYw1TwWkzJbfPvJu5AYXbzWCLEq7AZiZcujbXi+x0O/ec4z8zyIPr
	 w/ks1agIVodQI6w/FfggJvpmKDdZqtB3SI7T+48lyqbDj0ITQ8vuGpfaaub53Lca63Aug
	 VYIMeOPEc1uI7xi1/VkO+hikLbgdK52ses1vkNO/0mLslPz0oQf15D0v2VhP9Gtdjl5ER
	 xLhsqv4rIuZTVfI5xwJFAdFt+xZLBppXQrUavcVQdMxmh0UhROka84undMj0mEZJu8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hNI8A89K;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0lNpojN5;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CDB606A32A
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55CDB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hNI8A89K;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0lNpojN5
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8AE6E7A02BF
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:45:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 11:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794329128; x=1794415528; bh=9jH24mtF8W
	CjadP09XsT34NM7pFf5eTGrK9geMzUo1A=; b=hNI8A89K4HDGpRNFYr3bfQYtWu
	MzkzWBL8WHY0worC1VkrvjAMDx6eR6DNiTEvrfPaN3c3leFj+2I3yjVFUrl/Y/U3
	eoK1uXak1I/yQhvE3PvA5fBK0gJ/AVZr9jfcPJXqo8Dq1qcDZoAkZXKC0rzfRl6c
	KjeZCChZfJTxb+dha+hVp/b0dlrd88PayvYve2GYhjROl/9uQAmhDMl5g7+jMkG2
	jws6mSAauTLScmOE+EVuUyYUEJuWnFV09ZH+Ajo8fJRef9N33uhn+jmoYu/17JRB
	/BOzguil/hm/OZnH+WHaPDbieIx5n9ERERkSUIyhB9MI8LnRCb7vgwf1N35Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794329128; x=1794415528; bh=9jH24mtF8WCjadP09XsT34NM7pFf5eTGrK9
	geMzUo1A=; b=0lNpojN5CfxLKvRtPbZ4hG9g0vdNuWi7lcgc/yhbFRI8e/1d4Xa
	h6GRNtispuGF6GaEE2Zo0h+zQDfbn+6r2smUWyV8JCah8o6SzBeUGjaTtQtD41F4
	QbFF4tYsiXHqIe8How3YBHVQX9+xH/IgnZLNhMklBhJrLYODnR93bxAFYFmCorFt
	l7ao4LAhMSdLPGO/cnKuXLENtp3iX/Qn31+W5Hb76U+besjywb6bZrR3PRscTKsy
	NlzSkDRRoXK5QRCAUu+6ZuMdgvjcYp8BMii4DdB7NizfnskUWN+co0AzSyBViz8R
	Q69I4lf0QCcS2r5Q74rmJH5CZnR1aXs3dCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794329128; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Bz9WxN8KUPeXshcL3GE1uRVcA7LF1b7mAx5pLeF9qHYFcGn
	JsuRAfG7Z7OEJzltXEF47QW8pzzHnO9MI4yWC7elyPAtRYaz9PJ5Yv5kJ8gU4At5
	lY2Mr8hRTCSV4lmkrdOQfvg4Px2KAJS71bEh1GTXat454zRv3ftEUY0Jd08bHUEN
	J9bJ/5n37AiUB3lpMCfAs0AVk91ci44ueOjpAotKtlMNqPeglj0oZIsFyFfoL/F7
	Q++IepIPNQT9sw/GrXP9QZirJv99OckInDIl4LP6pB3Jn8QURNDgYMNvWaqUoQH5
	PVfXbTNMNSlALp8QDHn/BreuNxuo7UA1UrZcQTQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:B3E6bhH116NlgCp/xQQ49V26bjyLOSKLry9vaXeLBwY=:YFwgTUQ7iFr5EHgMOhGbwG6oG38xsfw3ruVokHtPv+U=;
X-ME-Sender: <xms:KErzaiiFHGBCAwlX1BckAeDScZJtjjKlqZqDToXx02LXbSZ1drU0DA>
    <xme:KErzaqeZeK6vYB4918wWMHD4yBaIDwQz2KuLaNUlhZ-OgTiXuQgLBuqwYNZIUTWXt
    WNzYqTSSBc16Y4ZWirnQbxnmQY0hSAuZXzGdLXb5b3EYZ-Qbhu9c8g>
X-ME-Received: <xmr:KErzand-109PEi6aaZZ6I5JkBkDTGbzgVGfwWSziyaag7NFFyQze_K5ozyVW8d_N6BTHQZ03pJWjV-DAz70CRboWHTtAS3-BLjAP>
X-ME-Proxy-Cause: dmFkZTEDrH35uuVJMAFzHiLttNIu66Qjiz5cRgO+UyeCCxGb92O8tenawawWMkV3a3zBUY
    ig7cFAm/02NsVNMOdC5b/U3uH+37QZAEWWaT5gsp8YkpZgK28LEvnfHn5iVSWGjmbUvsyK
    wnq77ZWRabSJWmkUMw3ERcDQIV4owwo+ws3tYzr+rfnsedH3+9jlNeyh+grLqz+3yMUV0D
    rb+Lg9znyKqDKT9mTbVcJ12xGprcrjwPFFqx+lJw2EhrlbjKTv1GP89/WSFVYXHdZPK8k0
    48N6ef8XJvzTXE23IyvJ1lJ0ICanf1LN5F7XMDQnG7sbooc7MuG953k+YpQQxUKI5DeKrg
    gDTxq7cgWryZkOI9Z4wlhOIsZuUwaYzAb4Wr61sgIEkRWpNoYAXIsD4jEyJ5MqUeppt62h
    qlYblSDozasRpdd4PaoDdjCxXaE7rA2HsYxvUs+dQ/JkzsnAEsFk6Xyb7QzgLO3vexi3YQ
    p59nCXxUWhgUd/NZ1316lcYkvYYi1R63o3+sRX/VWqBF1XeFf8ko2GSq1uCDIOLPEHozRj
    IxqNsjNnaUH79hwlEXdUMmvu9XSOSUZPDKQiaW8SPPmrCiKNOt5GMydR8Xb53IuujmAheh
    yCxsYoLxY2SvzjoEa7ZNUFi1fXM3zAkaYrZ++Hg6JhHN6g3iYeDvG9Y8zw6Q
X-ME-Proxy: <xmx:KErzak9G3kpAJmTvWHWQtG-wI1_8Z9e6d_BZr7YROOMsxJCTo76QLg>
    <xmx:KErzajllBFFHwssaFoBhI_DKfY4-y_hYzHW_X3YzAO0iwrQG4HK9iw>
    <xmx:KErzam_Q7TqlGO22eEz74ih1BJyLZW1MI7iUd8Q2fYUTXPZ3t9NZlQ>
    <xmx:KErzahmDrJbQhlLiwxNfch8MrblFFnLvEXnWvrCGDMrvKI84LuKU-w>
    <xmx:KErzaqc6wYOTvsoeKV7os3tDCJIXvDostE1x0BUuyK_n-U_aVzeKRh65>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 11:45:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/20] t9300: group and move tests to other files
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
	(Karthik Nayak's message of "Tue, 10 Nov 2026 12:49:45 +0100")
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
Date: Tue, 10 Nov 2026 08:45:26 -0800
Message-ID: <xmqqik24tz2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> While reading the git-fast-import(1) code, I stumbled upon t9300. The
> test file is around 4000 LoC and each test has some dependency on the
> state setup by previous tests.
>
> This long series unwinds some of these tests and moves them into
> new/existing tests based on what they exercise. This leaves t9300 in a
> better state. I think we can do more here, but I decided to stop before
> this series got even longer. Based on the reception of this series, I
> will follow up with more cleanups.

Wow, cleaning up this script is long overdue.  Thanks for tackling it.
