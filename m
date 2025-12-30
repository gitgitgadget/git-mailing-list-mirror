Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00302777FE
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105230; cv=none; b=DhxezB9E2R1g64pY9HUOXBfIcsfGsX9XDcnV21IpC+ir42OATRKiqp/gZaQ8wzWSjcC6Ng3aUtUF8pMAc6u0VLPi04hNHgvc1hM2goSo2BuLiOUgYjoSzXQU4Qw0B2ssE1gzWa3pkemUypCGflq9NQPEdutvcboy6mI/5iu1rWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105230; c=relaxed/simple;
	bh=tvhnabIY2yieZROLbwH2NY5GJ5j3HGsG49/T9s8f/Qs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uRHuiyfRauHi+8B4DtKABwQCfP0278WkCfLPEfNQiEqR2I35sHRwc8+N8Wuawx/6JTxP/GJcKZqBGU0HZlKudrgtTd7BYcTSk6jpj+rd1oEbbEA4vWWSHb0GB8repVGLiFhG5bhTXfwSMaqE/hWPPloQkJsqjqfgBqG6GC7Epd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=BGxqD1TL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ke0um6gx; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="BGxqD1TL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ke0um6gx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 09C827A00C1;
	Tue, 30 Dec 2025 09:33:48 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 30 Dec 2025 09:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1767105227; x=1767191627; bh=tvhnabIY2yieZROLbwH2NY5GJ5j3HGsG
	49/T9s8f/Qs=; b=BGxqD1TLsjZKsGvCbgfen2dG6IGe8yWsUV+TSVwn6PZ3qWVP
	gnXvsQlrDlma/ssxds7q60IMnjys0lK/QqLHAuetypx6PN0glCa8Oc47uq8fmis2
	oc4dBS64se8//DzSH7/EjcRlEj6IwnAU/cgSRmyd7dtQwDuO+Ns1PA3+3eeG/mO/
	d7NOrf8Vz9dfSbHqu3ONv/bzrxRKzGdiCEFb3l7VwZq5II+28sNbFgZzVcfjWhhX
	xQKOGMmoDIrcbTiNLzLQup5OWA23vENcSOcjp+SxzOCkkO5ght6kU1M9vV4kIM0d
	9VapKTd0My2uLh6lb+/ow9MX5IDnzc68NbY/gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767105227; x=
	1767191627; bh=tvhnabIY2yieZROLbwH2NY5GJ5j3HGsG49/T9s8f/Qs=; b=K
	e0um6gxOTBaq34pryXiyEtZQwY9DhKORckHD5Io1wwrURfoS6L4iJU4EZQsYhDiQ
	25Mg+TXYbi3ZYlhi2dqLUm/slq4UEmREL9pXj+xOjohLpBv8apQP3MHLinfcF8Zs
	nvVBfY7n5Lx/O8Dk84oUoE5Fi0v2wmYRX/3VHyeY7ck6vaEatW532rTejxPe2FnJ
	lUTKpkO/tJikvMn3NzmcGv65XB64QLIZVIa3bL0kkpwcrit9AYYwsNsvlpvQIjd1
	17QPd+9vlq48l5X018wHh/F0jsRGpKCYRcpjPevuZYxKQBqhPQGEwkMFSMmp2EPo
	VWNqnTAR28Aa9JzO3fK5w==
X-ME-Sender: <xms:y-JTaaL7AMG1QwJKE7rmNiPD8KGA2bp-YAp3rJd33B_9c3ia8rhDUxg>
    <xme:y-JTac-DZWBpKfJkHA2lfC8T-D-ULUQFum9IS5RhouCAfB9lZkoX7aB1L-VSWsTRh
    TxDqpEIG5sPv83uKBgq4lgQIPYPqGS6WLou08nAPicDDvZ4_d3E5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheptghh
    rhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgr
    nhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:y-JTaZ1LRlOIFG_uPQwgf-K-n-6xbXUsIvNDta8x7nu_eCJA6_JPkA>
    <xmx:y-JTaZavhlujySG7SjKnGpffoot8WJwC2Qmho8mcie-_gptHohXS3A>
    <xmx:y-JTaRJW11JES0LuZNMPwuM434L8Uea5wBa5iDFIECoOzlAxsskf1w>
    <xmx:y-JTaYHwy0ACw-Lm_TYGJ_d5HxQ6XOSNexb8tb6eVRZs_oUu2wc6TA>
    <xmx:y-JTabiEkDiZR38JAcXNVgjZ7WiJHUoAToomNC8w51dSfSkkLmBDYmWM>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BB4941EA0066; Tue, 30 Dec 2025 09:33:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AkV22KuyfT4B
Date: Tue, 30 Dec 2025 15:33:27 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <bed6fed8-b89b-4c1e-beb6-abfaee1c71f9@app.fastmail.com>
In-Reply-To: <xmqqecolrip7.fsf@gitster.g>
References: <CV_replay_die_descr.13f@msgid.xyz> <xmqqecolrip7.fsf@gitster.g>
Subject: Re: [PATCH 0/2] replay: die descriptively when invalid commit-ish
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025, at 04:16, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> Subject: Re: [PATCH 0/2] replay: die descriptively when invalid commi=
t-ish
>
> "... is given" or something?

Sure thing.

I=E2=80=99m a bit paranoid of the soft 50 character max that git-commit(=
1)
recommends (and that might practically matter for email-based projects).
