Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E91222565
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842778; cv=none; b=G//m4yihsRJDfinLIrDo4jjDR5kTQ8Lq1ULgyMVsQctkO1MZg+prsRQWpjVWqwmr2u0jJS45Vv3CVOlrEyIiHs/8PdMf8S3Je+/pm+Orj0+acWXISnuDbQinun5fZPuV2b5s/d7ti1AH/d/CqbLq1gGeveJ1d/9rX2JC6j5j5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842778; c=relaxed/simple;
	bh=+0TIkQxWUVT6yV/DxgHnI22/X5Wl79zP6e7P+9cJDyI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FY3KOYSfNs4yGLhLNPZdujYLKXKIiA9g5K8gRVi6kYA/NFVNofkcV8oamyQWCpULLALtT/GRjUkajPm7hMVmmkrV5OB2W6sifTPhxq/X9GzO2ZtW1SjXelXwZ6ii1+ph2UPWazNGaHC1nyy7uW4S8050HxXMtf8wwbiyWO2uP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GykGuivs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GSRIuT3e; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GykGuivs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSRIuT3e"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E5E61380438;
	Wed, 21 May 2025 11:52:53 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Wed, 21 May 2025 11:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747842773;
	 x=1747929173; bh=wXXCDbFjkLVPO0ZBe49IbR1hyL4UkSnZnPesWBPz3Pk=; b=
	GykGuivsm6HRyVUG3fL70gqMTbivdiykIrBFefPaO5YA7+EKR7St+XOFRpMdwK79
	3G9Rd2ZAjBtkhy9HirQKPYt/6qpcd3q+L4SQ7rT8n57/n7PWnlFxJPScDNxHt0NM
	a8xULNJCBfp01y6Fmic2HWSNomAtVgEkWB66jEdlcYEoGsAl0NfENXqhbvAwxqjF
	OrgvQtkyqWj7HX/rp+k5SimRez7Tb+AWcAOts1RdboT8pXdZEyOt8hTcCJZF4Mx0
	3ybwM5jARE88KDNyBACvM9LfnMiiPVHWaoX6TX7Qb6kx3xhMZLc/KzQgtDT4s4H0
	VWaeqrRp7dHHlzRm+cjNUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747842773; x=
	1747929173; bh=wXXCDbFjkLVPO0ZBe49IbR1hyL4UkSnZnPesWBPz3Pk=; b=G
	SRIuT3e9zH/zYgrZLuClpEsTBwOjcbbZlWwyZOn7iNStVayobmO6TkuMFRU9XkHj
	nZQlcNOqAuvQeyIA230gzy39vyT+TwC5ZUiA7SlmMtOqrBQIQiLUPcG6+OqYBLuH
	wBZRh6ZkeQtxd+ZWBc3e2hTN4kpbZoObMA2RSw2UajVqbdQx/nMKtI/xLeMJY4Dl
	lL98+m3AgtP5zRHrwOzvSHbUA7jqWpk2TzDI1oBPW4Auci2ugMEHj/JaUMCOZ5E/
	ECbAnrWml02IF8W4/S4BijPa/DJ1idYGQlfMKLnw9/JyoQfFTfw+05Vh+LilZ0PF
	Shap0w+iriLZbLRfxZ6Ng==
X-ME-Sender: <xms:1PYtaKTAnNG_bi82Fvx1v5Sz5MFe6I1o47RdpgGPnh3gtZ_SooTHg9s>
    <xme:1PYtaPx59yvf2FgunoX-YaoJRaNbPI3SqCugOG8tcM2OZBiy__ERd9RurRl7Bj36t
    YHI_wCry7jlhAbtCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefgeelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhep
    fdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeg
    tdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    ephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepugihrhhonhgvthgvnhhgsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:1PYtaH2wpwNhSGFtv_qicnvtKBSWpZ4atTFdMmRiugJVGanmioSQ_g>
    <xmx:1PYtaGDfFZV2IbAzixvE6wvSv9WQ5e3_J8G7ho6Web094FRaq2Ckhg>
    <xmx:1PYtaDggxIn5ZIQtNrRLYGKx3SBXISNE6e5IkU8rqQqdbw7rU-hVSA>
    <xmx:1PYtaCqk-qF2dv3fyBL6zpKAcLKzdYh1QGPHapfRpO6ORPzDEEVYrw>
    <xmx:1fYtaGbrxcXhr5DcDbwYGX2z5BrgL0avBxCeFyaKquYNhMrPlmNUak1e>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BE7FD302005F; Wed, 21 May 2025 11:52:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tcf134e764ca1e58c
Date: Wed, 21 May 2025 17:52:32 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>,
 "Teng Long" <dyroneteng@gmail.com>
Message-Id: <accfdb7c-c31b-460c-b720-df0d1ee210ff@app.fastmail.com>
In-Reply-To: <xmqqwmaaartw.fsf@gitster.g>
References: <cover.1747763769.git.code@khaugsbakk.name>
 <d2b6864b7072faa2c804c98ce7758b666e11f00b.1747763769.git.code@khaugsbakk.name>
 <xmqqfrgzhzbp.fsf@gitster.g> <xmqqsekyds2e.fsf@gitster.g>
 <d4491de5-9482-4bd1-9fca-dd960a815f51@app.fastmail.com>
 <xmqqwmaaartw.fsf@gitster.g>
Subject: Re: [PATCH 3/6] doc: notes: split out options with negations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, May 21, 2025, at 17:47, Junio C Hamano wrote:
> Heh, that was one of the things the article you cited stressed on [*].

I promise that part was fresh in my mind at that point. But apparently 
the mind itself was not that fresh.

-- 
Kristoffer
