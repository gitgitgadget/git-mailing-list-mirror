Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAB917BD3
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495357; cv=none; b=UYmlXFVZi21UyD28ffoir0+v6AKCddH6AHfs/sQmEoEJqPsp5LNTrLLUv0XjDhGw09gzej9xxQ3hGha5TA4M8umzgYK+xhDjeZs9yThGnqOHTtr1KT+fl0N53fCTQSaL+lSneCd8fZ5Md99mI7wqmgyTmHAy3aFcwOCeA5t2Tic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495357; c=relaxed/simple;
	bh=hJyYrM9b+yD8U9bNnMeLwTP01eKGuy28qZHIzB/YAS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iUday7GVnCq4QhTeK1NDeO6VNlAw+I83SASCL6SOrYhXAa+TyK47xwj0QxUwv8rxdsG+B42wuJ4YGdAmx74By7IFVOxc6UsaCljvC/r6pWmIAjAHmiVacu9VdXV3bT9dyvImtFQUKSry5cb1YSho5Ws/d0D2J2JVEwIGyvurMOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IjGPPh/A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mTt6QxOT; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IjGPPh/A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mTt6QxOT"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 4224B1140371;
	Mon,  9 Jun 2025 14:55:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 09 Jun 2025 14:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749495354; x=1749581754; bh=DtFj1i2rka
	KctXdVt4IOzQQg6ZYFkPxZg3E/m6PvEww=; b=IjGPPh/Ai6q0pvqtHwZAbemRlx
	d96BSJD1NsQdHNNHGBekt64FLH0fFB8OL8ZY+p4NUUlOi9F1yZdt6VqMECTDP4u6
	qiG8tfs+yhmPMSvu/zLvLCeodGKEIsjR/5NQS5bSM9iCcLVBDWlnJViiDYYhKqcN
	uZNfnPO4O0YWi7IDn7M8y6G84yZFmWBX+zvzXnW3xQhI/1758OfH7aKxGuh+zvo8
	b4pYKY0bFLv5jRpdvBt2U41qYXmUR0DtVy/Zj/hEhlciOX3sBvgODB39qDZHjR8+
	SJ4iRRuamJ6UiDCjG8TTChFg8U84TfqTnNU9R5+kbvcnKM/qjLEGxtuMqbAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749495354; x=1749581754; bh=DtFj1i2rkaKctXdVt4IOzQQg6ZYFkPxZg3E
	/m6PvEww=; b=mTt6QxOTTvlzmrmkxUwjT698+D59NknyMLCXPfo0Z9Hic8aDqey
	77/jqDm+LnPHQi6u1edppFumb+/u1bq3r2jZZ3Jw4RAm4G+XgRx9ytVUQRXUga+u
	TmOeKF6U6MMIN06gdmGbMNfbNMi2LAffiQlnl246x0ga+KQg9zetouiK+pnqj0Im
	UwRRhl728qon7TZIraqT07wFfo4pOE7jXhFzq8hg0B8jBrGfEiWK4C75GT4uX1i8
	ju4yoVuLJXapLyHfS+Ks4FndK9EnWh2Eyxr+drHCx/maM4PUunnRq5f14KAU0/zV
	NkY2LbUDd1syubFgtxNQHZ90eU8JAi8ruIg==
X-ME-Sender: <xms:OS5HaIFwN5Qs80o9TYKfpD_shdAtoD3ZxOMQLj-nuhXJOQnr95Dh8A>
    <xme:OS5HaBXpkMfQayfD4GwvlT-wJl2X3WDDIxROkdpOoKugTFoceo7MbAXJ3IAwZ_xjZ
    BgDOt4ccMwIMrCtVA>
X-ME-Received: <xmr:OS5HaCJ02DYe_GomSdDffzVHFuYykrQ80IUxKRByfM-ZTz4Nrtl6fqUSdMy7soAC0TAIeOZ3EAbgSnv2d3ZkuhwFd9GdiElAXW2V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OS5HaKFqu6K5FKYvsjahf73Rc7C5bXEgMtQySL5QqS3Vv3qgOZsWAw>
    <xmx:OS5HaOXQSNKiwVhzNSmpJVkuvHiwi78srE_LdyXyBLF8UaWqPORpTw>
    <xmx:OS5HaNNLsZ6bmqqhNW8sMqfGLpuya5ZJ0I9Wh1IXECU6DX-I1_p-JQ>
    <xmx:OS5HaF1svi4dFf0u2JoCJlm5TkyhYEBfawIhdbc4G-82RVwSIXEn7Q>
    <xmx:Oi5HaPTeluGTFR_g2R9rm9Mlblfh1NeNpPsY8ooO0SNufQKTD_W8ZGya>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 14:55:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Zi Yao
 <ziyao@disroot.org>,  "brian m . carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v16 08/10] imap-send: display port alongwith host when
 git credential is invoked
In-Reply-To: <PN3PR01MB9597AF90BA3D4B3295ECC278B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 9 Jun 2025 07:20:39 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597AF90BA3D4B3295ECC278B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 09 Jun 2025 11:55:51 -0700
Message-ID: <xmqq8qm0rbgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> FWIW, if no port is specified by the user, the default port, 993 for
> IMAPS and 143 for IMAP is used by the code. So, the case of no port
> defined for the helper is not possible, and therefore is not added.

Shouldn't we do a bit better than being so pessimistic?

If the user left the port unspecified, or if the more knowledgeable
user redundantly specified the default port explicitly, showing to
such a user :993 for imaps at the end adds no useful information.

>  	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
> -	cred->host = xstrdup(srvc->host);

Perhaps something like

	if ((srvc->use_ssl ? 993 : 143) == srvc->port)
        	cred->host = xstrdup(srvc->host);
	else

here?

> +	cred->host = xstrfmt("%s:%d", srvc->host, srvc->port);


>  
>  	cred->username = xstrdup_or_null(srvc->user);
>  	cred->password = xstrdup_or_null(srvc->pass);
