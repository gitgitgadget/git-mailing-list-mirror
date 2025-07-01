Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FB1917F1
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353532; cv=none; b=gD1pq8EhxOZvWamB4k/a2L+//QcjgiYt9912dQZYBTjtwSC+7C3H4j7et55jkLnC5z+XkiDbXy5mriCG2WKIi/ceZsetvOcCvEEzv3lnc7TjziAuxv2h/aZj4YeLaHO0txSqBDxp+GtFlNAfEKXoAjqANu3GpZtoiUVQVQUeiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353532; c=relaxed/simple;
	bh=UGwo1/b82QbA0wJDKF74ayfrLbkUXn251X/Mf8To+sA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WhPN/LZDrzLxb9HLCktXuSgFPKvAGiG6S3vAv5KTceZdPH2Iy189NyuiR9N32lcSeWBSC2PurWldl+1eMFx0yoWR864WvrheSgRwgbSkDZDSGGLoIGErk+ZJxSwfyrhb7mh2fVqpGNo+oNVvwP2TKi/KGcdIYZMwqWFvbymX9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=OmdIUplb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGDlYQNJ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="OmdIUplb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGDlYQNJ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 96EE57A0221;
	Tue,  1 Jul 2025 03:05:28 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 01 Jul 2025 03:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1751353528; x=1751439928; bh=UGwo1/b82QbA0wJDKF74ayfrLbkUXn25
	1X/Mf8To+sA=; b=OmdIUplbWzp581/aN1MhqUIGeFIF2F5QGYw417XhbHQ+alc2
	jhPd8+L/vW3tAoLr27R6bMvZOTSDGKSvCqIL01a0yxi1oUMz5ThWl+Zv4FY+NMYi
	T9p6wHdLkWqw+qMjAsd1tz6/yLD+Ol5qWj83IcLnfvdSh0/m0AXqVk/iB8ks0jtw
	U7rzrbK08w2ekC7aA9TrvElJVNHSD9EV4t+32K+0W0tP8/4grBSi+B5Lf9P+RAWr
	Ify7l/iMWpTDKNEkAjUGSWp+2o8WGQm3NG2DhNsF14i9fHjgQgyFlITrHmUKs9Ia
	1D1PLzjFE0f9GIykU2g9RkZ0oBawmpN5tpkYaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751353528; x=
	1751439928; bh=UGwo1/b82QbA0wJDKF74ayfrLbkUXn251X/Mf8To+sA=; b=H
	GDlYQNJaeHk6dCdG9viBWzORJwWQFzMh5WWTYuXNFbfrtOfPgHA2dHp3whtoh2Eu
	GtVsO80MB4uJAGryZbjY0v1ODWXt1WJIKejMSmY3OU5LXlKfhHftxqr5pSOQ4siC
	TQpg0wcPa4olVD/IItBy8or7Oz2sdxSXVwl8uGBQuLu7E4Fva45VGPVgBlfFOE9h
	izPei0b+uP/0PeynuIcJXrbivTDSHmV9MMaDF1SKLUkH+md9D8c9LqD/MhofP+5F
	PSOUdaRtquVe2ht+MJeZYtSxS9gdx6AdypXYV7e5M1K3Ubcb3HRbaJ6UKhJuLspe
	uGFI7s9fWPlSVEkJqNajw==
X-ME-Sender: <xms:uIhjaHTZDJPIequXAouDIJ9DUV4lL-pJ-CGYQ74_hYykdYF9Pai9tGA>
    <xme:uIhjaIzqvH57EIH3l-eRs_C9rRylcX2kgt_0tm45cKzF-_JP97AcbYhABhjv3TtT_
    7ZEH_WOBf5E9eKBTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeetkeefudehhfelfefgueeivdelledvjeegudej
    gfehjedttdevlefgleekieevveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhn
    rdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uIhjaM39mUl9T5ZJJgh74NFP-Ixa0h_qZVjLmb3EbeMVpyALcUuPCA>
    <xmx:uIhjaHCqdrQO1x5Lo7LgK4ngVMjV7j0vP2yJgZ7lEM42qWnT9G8uzg>
    <xmx:uIhjaAj2Ku9a5VKm4LWx-GrzX-DpsI6gCvH1OVD0jIXQK-Vk0WkTew>
    <xmx:uIhjaLqNnK6AL2pIk19PSQxpg7fmslft-r_VSgaC5l5kDnor7DZf1A>
    <xmx:uIhjaLDeBirhc7bCYhEjrm1-tU3tElpstzbs4R_jrbezttD7hOKtwMnq>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1DB1C1EA0066; Tue,  1 Jul 2025 03:05:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tec469262b87623db
Date: Tue, 01 Jul 2025 09:05:07 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <01ef5e34-66d3-40bb-aca9-8f12ad95c000@app.fastmail.com>
In-Reply-To: <xmqqwm8sltbc.fsf@gitster.g>
References: <cover.1751310455.git.code@khaugsbakk.name>
 <xmqqwm8sltbc.fsf@gitster.g>
Subject: Re: [PATCH 0/5] doc: config: update for the ps/config-subcommands series
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 1, 2025, at 01:10, Junio C Hamano wrote:
> Have you run tests with this series, especially t0450?

No. Sorry about that.
