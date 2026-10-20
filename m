Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515128;
	b=bzTw2Tk0hzUuq59ZRQykJpgwOTQC+DBRv4DwOS2TnLaA9Z3HZjB1XACb+pWHV/UYujjw
	 qceSLCMddgX1bsgwWsxdkRf/6wERXLSyfyRJ9Ju1Vya0WXkHIwZMKWqka5m3yGyf7Ic14
	 Xn01mQdfC8RfhXDRfRcHsGJ5B611ziAE+T8XuwtB5z9nnuV0cGcTDDS2+9kdn3B8zybC1
	 /+4dApZhXl+BzdglrmaWlDvrEBVUaq5mxxKa3S3BZ7v4QyE/ItwW10zKOULV/AORu9934
	 Jo9fltD6gHt0GFqgNCpT5Z+cQ5seUH6vhWlR/3BgGJ5qvj4LWtClAsqcDcHLfYJ/nRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515128;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ylBfzR6IT5kazAOkIyC7xgqTBXQ8W4R5+ztyCeRWHtU=;
	b=UGe0+wpogAZwVKkY2OVJlw5FGzP/YYjN4wKY7YZ3GQln1EO5+ulxCxieCS3X5rFGPHKZ
	 XlzD8Trz9YXv9BNy8D+Xc/r6I1F/qrM8ApKQd6SiIci+lW68diwcLUL8jT/MCK16shN53
	 CbnIrOF3wUDW+HQwOpdE56B9oXyCyEvI38qdyoW0lAukFCuxnL4mC6sXoosBhxK7QPRTc
	 V8lQdS/fWJdbWAtlnss7boUISuU+MqrCe5oGok6eIVQFFYHtDDXqLqKlcYGGMLRC8I/9G
	 vMtfHCEpmgCi1cpaPpmJodgwW1Sgt+2fZxQ+AXMci3WcN5xgk0MBJ2MrqSTVClRHYrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=f4KfCrhU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Kzryg2E1;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D19606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D19606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=f4KfCrhU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Kzryg2E1
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DD68FEC0086
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 12:52:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 20 Oct 2026 12:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792515126; x=1792601526; bh=ylBfzR6IT5
	kazAOkIyC7xgqTBXQ8W4R5+ztyCeRWHtU=; b=f4KfCrhUoao2ml68mrSJg31RmG
	o2ZOT8Af4u+Ca5ehtF4JrUu4pxEa/TYDlpiqarYLODadryPLMRDaIdkyoaVxvZDh
	cBg01tiIM4ldQfCK5zMdyQzyj9Vt3sERy1CqAsPbE4mUrWbNkixtugvlA5EO/EFY
	Jm/zSCMgoG+3Si9lMNLeKJTRdu1BguJw6XuUJ/4nw/4p+7IWFpaA8VPmVzAAD2CV
	NSp0K+YCdxEUEO/8rp8UJrj1IWqFwMQRI2meupuBxiWO/57HvvBPhjQOWwko4ys9
	oiShIE+oGD6U4yLnw0z4xPgpRJGlwIrJi5IivQIzLljdF5nOzDz2Xaff5V6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792515126; x=1792601526; bh=ylBfzR6IT5kazAOkIyC7xgqTBXQ8W4R5+zt
	yCeRWHtU=; b=Kzryg2E1vfakXwNEjIFHuFUqaRyg1vwYCgHl9K1EsrIcy5TgRB4
	sJVw9lbWklogqOdbq8Ip0JJXFXgcO4aw22Zuy1pJi1CsCgJ7jk1/AAH+ciVZKFM/
	boBy9itaMb53kGMfO0jAGGBzCit+MHfTOh49jj12iTvGbWru9nhBsAYYht64VfAH
	hWeRu31raY47XF4oF/0oAlB4+FqGZGoXfi5MD74XEyV2oroppPqFCXbC6By1lX7h
	eiFnAlyyGc+ijZBZuLiht590oohHDDQjk549UuRpv32YvbWQFSpMrQDdZOFNQ5Ut
	lX3RQmC0WWF3sIifKGtcZPgQPVWDrObyqlw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792515126; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:SW61cYTCbCgNbe/PFzR5BlRvqF3VidpexjZ5aDnWe4AD4tW
	IaXqowBGLmvTTJcgO0GoPg3T5mWS8Zlc2gkL2dANGq2vrnTfE4+Lp6NVoSuJZOKI
	lWAOftla34v48kx9FM9894uyPVA50KkvWtHmAkmOpKH/unbsSs8mRHt3spepM5Mt
	WPV/mcqAcCmdVek74dXtMC061QT49rNbYy8cmDSf+yXQiKOZr+8NmUpA/LQluRUA
	scgxDcBH/T8V45RF8gEtuf2kGv1soqoUyJIHS7MvpYCMAojRG0gYyWxkBM5E8GkR
	2zYAUbkBLr2GT42DsBf+FDpDION+qNGyW8y5Ufg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WWxEO5R8EwNGqi2cchjP6URJJ51zQ9CWm+BdyeqzFzE=:HrDaBnbBhIvTe9r04x8Ywxc2tETcCYF1BvD+D6546wc=;
X-ME-Sender: <xms:NpzXaiaCHrWpxGhaYt4zyIAZ6ulK86IcL1JxBwpqTsn94LIfW9vfTQ>
    <xme:NpzXai9qN2HYK4tJTAFP8MDHsBLHGjSG4oI40_IGT35EdR8SaRWjhARL8Naj05Vpz
    st-23oN2xonZ7uVeBv_0cBTpUutNuHneVt4ueS6qyNnt2dsd2wSSZM>
X-ME-Received: <xmr:NpzXajbeAWJAPQHGqx-hFV7YbDyj1bM_ATugL9U4QDSJeO7j427d5np3XpBLvafA4iC3bmpAqolL5eQ8xSXe0gvLi1qqV6rKqhvf>
X-ME-Proxy-Cause: dmFkZTFALXuwqgIZTh/4KOCDaCSp4S5mezl6Lp1n8TIaXXTHAbmaHadaykY+pM2u6X/Ou8
    4dfQE4X+hYzQEDBJWQsSDWAbYVUnejo6ohOIyxvayGWyZ3d982dbGjJNigL1XnGd+3/tWv
    OuSiJNarqRnm2xTAsIqyOdfkPM4h8LDWL0SX88m/NAIjsKmPN9HZDkkXWLPu9s1XhjWI9n
    B8hMKfItZEXG04eCiy/DHW9uUp1Sx6wJTsml7o0BBaM2VLb3ccrrN+sVfdNjRQYITBYLcM
    wCfgIu1Sx4rJdf/lc2kmGIATjfRo4xxTbSYGbQyDglsgRZarOuJLgxWDK00QYLQb9EWTAm
    ie85iV4OLXXquyEFjZpGZDAhdykkHCnizc1z8aukFxTtmC3IhLqjRQiklHkk9YwfwMnPlm
    EGebNI0FVIweawHPiO4GqFvnmmZITa2Yg90+8cESdUJ34peAmtv9p6uW4qWZvmwHBaYudU
    8kdY2VOjA76vRhoj47p+LFZVie1Qw5uZyGX1m66Kay9Gp4WSdhej9QuaGdnRHNIEpougkM
    2Eqqt0fK3EqWIeOsIOZ36PZSoNHhxt8lprlkUpev7uHO53xq/qhNVtEMs/WpL6dwCFaK7k
    NAou9sO8t0woVOy7jtQDBAv5mXn2UXld6TeFjTULDskU0PHen8KMGzkPCxsQ
X-ME-Proxy: <xmx:NpzXamP17F0qkjAMkcMo9wyooSA6MLqCwqw-qeYiWJePo0qgpeLz_Q>
    <xmx:NpzXavDM7EWvhiISeuU40pUq10PdqFp4pTLoZZJyTQle4uKMTrk4KQ>
    <xmx:NpzXatI9DQdKEANerPY09sk5CcRhB5z7aJZZZkM8huApSU9hWWSEZA>
    <xmx:NpzXaoP5Lo5Hdvp767KbZiJUSuOUVdkD6U6U3wmzmbsJQLvt810m0w>
    <xmx:NpzXavkdmPYMHgVeLTt0OeGmtehfBElZQgus7AT0fOkuLm1tlHnosGYl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 12:52:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Shardul Natu <snatu@google.com>,
  Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Makefile: pin cargo --target-dir to ./target
In-Reply-To: <CAHWeT-Z5OhJLYx21V417DoL3xOQJj6viUzCm+04iDe0zu=jVWw@mail.gmail.com>
	(Andy Koppe's message of "Mon, 19 Oct 2026 20:43:24 +0100")
References: <20261018205305.2634339-1-andy.koppe@gmail.com>
	<xmqq33u165dp.fsf@gitster.g>
	<CAHWeT-Z5OhJLYx21V417DoL3xOQJj6viUzCm+04iDe0zu=jVWw@mail.gmail.com>
Date: Tue, 20 Oct 2026 09:52:04 -0700
Message-ID: <xmqq7bjcxqkr.fsf@gitster.g>
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

Andy Koppe <andy.koppe@gmail.com> writes:

> The problem I see with that approach is that CARGO_ARGS looks like it
> is intended for build preferences similar to CFLAGS or LDFLAGS that
> could be overridden on the make command line, whereas the target dir
> is a hard requirement of the subsequent link step.
>
> I suppose `override CARGO_ARGS += --target-dir target` would avoid
> that concern, but also set a trap because any subsequent modifications
> of the variable without `override` would be quietly ignored.

But we are already tweaking it with += in the Makefile, aren't we?

    # Rust flags
    CARGO_ARGS =
    ifndef V
    CARGO_ARGS += --quiet
    endif
    ifndef DEBUG
    CARGO_ARGS += --release
    endif
    
