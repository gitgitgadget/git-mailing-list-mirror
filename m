Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599920;
	b=KSAkx6qv1HgxHFBnviNwkfOEvKGUn4kEms/5Y5N+XCk+xaMlDcFosfej5zAPZI/hu1cK
	 JI3Jk8lD+zp9ymUTyrgUOjyJfx3Ugbi1983DQWj95NRxKEWqrc5+VGk6aLwqSLKa5JxNr
	 z4PpPlJocDw6U3jZmf0S1jOjXeInvcfaVYt63wKlEqzZspjHyAamsM8UQUy8CLA9S8fiQ
	 qtbuhz9Ks7ascc4TD/20mfHbj+fF7nlOV3FOfU2RZlCujN7He40UTkl7/yp73eMIkOyZ6
	 5FUzkLuTHZ5UtB8aBU1DHrWE4X1zl0094nV1zlqhMzb8UKf/7O01GZmTmho5ON8gxdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599920;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bSiaL9tHI8FJe6y4Gx0hZTCZpc3M3NSOkuUf9BWfa70=;
	b=5DAtFXK6ooUcuaj8EWArTDOyHilSQiVGtrT0f2e/sYht0RNe/gjlVQSeCYo5CK55qj7A
	 w5auiHUDDP74WfFg2+EgoifyeDI872QnXL0wTtu1bIiu9EEM9MUxE+KSQyRb/kMtjV1Kt
	 V1Ho7w3xaXBqnEcznyd+/1+Iim4W1/9dQuwIaAsYnaPd12H8K9QNhxUPufax1RjOCreDE
	 5IWYWO5Du0vkUFvRJPiJgYhpvSOBJvreR8f3PJWshSaG38cFEjDoNBP/Kjz84HCrAMo3S
	 UnWKhm75R9aj5IUQ0rUFUihYmgkz+pMo3LcDhA/tA1HzyfxyRQtfTPlRLpsjf27c3cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Us9hA5EV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pMWiH42E;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B099606A8B4
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 19:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B099606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Us9hA5EV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pMWiH42E
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9B0957A0100
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:58:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 13 Nov 2026 14:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794599919;
	 x=1794686319; bh=bSiaL9tHI8FJe6y4Gx0hZTCZpc3M3NSOkuUf9BWfa70=; b=
	Us9hA5EVsYuK0v+WTcJa4x88JHG8YiGcfs7LSxsza4wtK4BuZH/H4nBU4sFUUj+U
	NWV3rZcmETUSR1iwMhPcLtNihwpCt7cEJ/EgpUoCaXlTQo83pBXHPzGXtDJFNBZY
	4VDHz8O0Mvo0gCpr4/hcMajtBvZFz0AEwyg+8Zr2B2OJYZ31ZieFSkAI0NAGRdCm
	d5o9YVQf9+pElylEL546TxmKxeW9z5qxZgjEHI5WlZ+3jQbiHB1DKi625JHrbWHE
	wNpC3pnWYTrTLmPHp9Cp7B9s917RtLdfn0VIU1RpYYd5zWzeYRgP4lhDTAgMDNOQ
	yuTn2HcMb2piS1SieknOMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794599919; x=
	1794686319; bh=bSiaL9tHI8FJe6y4Gx0hZTCZpc3M3NSOkuUf9BWfa70=; b=p
	MWiH42EYHUQ4mF6+cP5EhDTypkThiwhTKe07avwH7vTrEKYw+kGj8SOF6T0/BbSl
	oyP0YZJdsvfunvgMz+dDuH6oInDIqFNht5lSMQn/vp6xqtV0OdnhG24qOESz/2Fz
	GXSiUXARHU6wizydNSjan6unLmWj0m5q6E2FsXocXKfRUWCxjgy2mO6tn1T/hLCv
	ogSx+fRaqrIvX1puL2NO8FmUJPh/fHXnKtPFVb6ZKDbeM/v52YYGoq80M6eIUICz
	CQIFEWe7nlpMYluwK4nuMlfjdh5elIdLIQ/jFeSXJrQi308Ht0A5LYHoOO2HWkVU
	EW6xC8edjDDlJdTnEZJiA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794599919; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Lfn80513QNl+nKMHx/88TxzvZQIaYSGtKyIg9ugw7mc5z1D
	2S6ROyumryrwYmSffqbkibp9OMgzSVRyKcDqiRaMQ0OwsVaDMdgV9tBMvHnBU0KX
	tgqYQui9L8Fh09dwUopgsSyrAR6eqJydzT8pmxeBR38O0KYQhmtPyD13N2Ww2XyT
	2vz+3v68ez0oaVMnWdivJvLnz0IgwY2y9aix7R/xchg7lPeebqMa2GBkA6A7fXVK
	ML5Lp84MhNZFFBfMEwVjKOs7oRgRgI4Pqz87QxzpKiJAT879U31h0aVWeBEVeHvg
	8UMNBoQ0fwp4vKPisHVdSyO2vBD2T0iPrLBsOcQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:NQIz0u2SSM0QBkR1l12IPG2qYkwYOlBfDGA/brJGmyk=:Eikfr5gzS33h3zmXrRG/PqTNoLiAJmdQUa1ZZ/usHH8=;
X-ME-Sender: <xms:72v3aqVLvWKFI6WikTtQezFK0GJ8NCji2dqGUTLuASPcBqzOEsZJyQ>
    <xme:72v3aqS0HObSvXhWP6C4jYq95dRsQQsxgV5B7XpDRZKVuztAzfXWlZQ7JPDaWbLxP
    txKaKnNp5m5BJ35qPVhHxE-L4hIF3Hhjb3bT_zNbm-nZmFTHqplhg>
X-ME-Received: <xmr:72v3aoOcd8zzy2gvZRCZpX29DV21BQaS20iVkOkN3kLgZLEyi_hIdPMTd6kSV8qFqpTBXig4UAkLt7vuQyjDr-qyxpjV9XJuIOp4>
X-ME-Proxy-Cause: dmFkZTFIgiIU2kcH96hiv+NIVGCAsqZlqIv9KRUPToj7MtNZn30Q4it+YMzvCUpGDMjGDT
    RLq+Wy/ausPI8ctDOj8+VlKpy3WOhufUtjrWTtJ3ngL1HXDDmAwIL8NLPwVyT+RpbArNuZ
    75pfSIoaDFzQdfLFJOVrA2ynNdxUKMyQHFG1Evp/AJZ8t+3PxyVXgelU28GSNJMo428FHt
    LLu5ebw+5r487VJOBLtyq93/GtfeCbP76nIrw9cea9LkRpncvrEelmlLQkoZJdngVm8nV3
    yjIWooXkHokED3dhZV9kjMfUKm7meIdpEUb5VJkJabU6RlsCXJao4E9Ts7OLpSCIt6H6pK
    Cv18c2wtwtbJSGd6OG+d39pqp5K1ACT7xppejW0YMAlhzpfjJRKQB1GmlyDYeYjpMSOlXZ
    WtHfvT2db5I3rc+vSdbJxf04B4sjO8TKAd0xEov6qWr5VPMYa4ez2VawFwXl83N8HmX5ul
    5rS1QMaMmawMgyb4dWGZpidUXOQhoUAtjn7b1Q4aHC8Z3B2wqGXxvASS4uSEhw+DXBn3m1
    GhOYDU3wUsYXDAhjX1oYWII83snHN62/8lsqSJgwU4fY9wrD3keHK2OPu96fXT2SNJM21B
    J08sq9z2rpsGpZ1pcmeYthjzSMpk6RnJty4wGs0nzfOpKsXV0VTFcUnxMa2w
X-ME-Proxy: <xmx:72v3aoTFPEwqFW2o9AlT9zCm3wvcf3pjnBY5Sl8ZqSJTT1aoo9B3_w>
    <xmx:72v3amiAegO1zy4FMjrBd6EMoJ4-DBkT22xN8op4eZPpdojY0Zgvxw>
    <xmx:72v3ah87lqmAOfvpqWI4GCnCM9CF80j4m9B8uOGi-r7QmprGn9MEdg>
    <xmx:72v3atF8sZ6KM3abwQxoCAVIqkJaO2o-iA22WQ3O4nVhj_GSYjiK8w>
    <xmx:72v3ao622Vgwp7zUCIggIafUeGVBXGFrKZrtKvfKstsgkTMul6yEumDz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 14:58:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Yopa Nelly <yopatatchou@gmail.com>,  git@vger.kernel.org,
  tangajoris@gmail.com,  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy][PATCH v2] promisor-remote: honor
 promisor.fetchOrder when trying remotes
In-Reply-To: <CAP8UFD0zMp-e3Fp5SjXuHiu25718=vf+qetzwpRZmBPMJ8Vb0Q@mail.gmail.com>
	(Christian Couder's message of "Fri, 13 Nov 2026 18:10:43 +0100")
References: <20261104172434.691381-1-yopatatchou@gmail.com>
	<20261105225223.1163975-1-yopatatchou@gmail.com>
	<xmqq8q36q3il.fsf@gitster.g>
	<CAP8UFD0zMp-e3Fp5SjXuHiu25718=vf+qetzwpRZmBPMJ8Vb0Q@mail.gmail.com>
Date: Fri, 13 Nov 2026 11:58:37 -0800
Message-ID: <xmqqy0awa4gi.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> First in https://git.github.io/General-Microproject-Information/ we
> have a "Don’t work on a proposed project right away" section, but
> unfortunately this patch is addressing the main issue of a project we
> are proposing.
>
> In general I think that there should be a design doc or a long
> discussion before we start implementing something, because the problem
> could be complex.

Thanks for clarification.  Perhaps you would want three tier set of
projects next year?  Microprojects to help you get your toes into
the community, middle sized projects to let you demonstrate how
capable you are to help you get chosen as an intern, and the real
projects?
