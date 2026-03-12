Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317740855
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773276830; cv=none; b=HCqPP+avoKYa3zlv7q96EJxI5yVcqU5/cAEzNYfl5LhHqPPIsBfQYf2Ny9gOe4PynDmSo1FUjKLssjNEIFtSGS2PTn5Ft3iYeVDdUR7x8BFB8cC4YpaxNGMPtf54Jk8nj3WJm1w5xTM3wgu6YgfOn0iG1bWgiryLlCooA+osjaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773276830; c=relaxed/simple;
	bh=xEGOYvuwD/77eOtHdTZawnPwfX9dqBQTIK53ihix7D8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gx8ycttuUXbhmwIGoF/xRCjfFgPoFhoxBVX7wSkoPaaIepmrNIXBhx2oMCRL+TzboieMCvQGYGVBZvKqmRSQHxYZ/HYFWdGB+pQ0XN1SmfJW8I8yDiMgrE73oPdnOKJ0j5TrLGA5Pt5VYBlddOXYEJrrpBAoRDFp90msKPtqXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Zv76f8Ox; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IdVPf38/; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Zv76f8Ox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IdVPf38/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23B2014001DD;
	Wed, 11 Mar 2026 20:53:48 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 20:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1773276828; x=1773363228; bh=FCfaRdnlRWb5a2nS5hwDHntbRHIsV30T
	Vbwrz7LLjlY=; b=Zv76f8Ox36CuW+k68tIrJ1M1EBZe4HQque/msOp21tR6/vsR
	KTj6JDz1kk3sLpwyjioF5stQdEcE41/3LujgwEkly8qKkkPn3MTHsY9l9IzLzfeC
	vZw6GeEcZ6NNmOLZL2pS1FuU7UUX/LHq0Ro3txgRE0ACjOo5k6Dzkknb4ODaIDiV
	GKd8CZ4cMV9dFBhvRtM4R9lqCcjXCDX9ceVn3axytsUVxl7Z24/6niDdlv9wHFlD
	AT+QUW08gdmNuOWftHVhvI3Ox3pMMv7rwbJdi+twXOxTVQv7wacLVDEE+vwtHx8E
	RyoD8XPCz6pM1XU8dNeNVuaYsy2KJShuYmhFbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773276828; x=
	1773363228; bh=FCfaRdnlRWb5a2nS5hwDHntbRHIsV30TVbwrz7LLjlY=; b=I
	dVPf38/FOrxlKJ0Iq6RrtNOOzm3n9U4ISwl1Bx+013zrhabJUd3HHmwE3kBdB0jw
	mMHpKxoHLF2zDvMt4SUYsS5PrwutFtt2a/4+S/HA2fEIHtsWxyiJsNbCoR5N+82e
	EJGw/8GvthsXmP8QzsJxRilg2bOO1R242KHuREfJrbMytc+fusLBGTVR1EqERXvz
	sNNBI1ziLTapm22Fsl01U0KNRbQj9x1sL80KRlkRZiF2ZlkqdkV33u5Viw63nhrN
	u+nPBVXY7ZwV3sblEnYIefPbc4+TPcHaEzTRN/JyIpdbuWLMySqR0uCH3aiaKXSV
	NCzBe4UOMwjqCXDNbsDew==
X-ME-Sender: <xms:mw6yaUaCNchSN-Izj9HIjOLMzZGebMaWHvrH3nXC3dHQ08ArzW3PaKo>
    <xme:mw6yaaMv6vnB2AmFYNSz4kwy3zTmZuOnKn5rYz9QFMcwHGeFBKSTbtbDOWPH8Iyud
    xmfum_8dOXZpebzqCrnbrvXn4nYm4TpQ-B8UnTJRzjEMGMziWrT8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepteekfeduhefhleefgfeuiedvleelvdejgedu
    jefgheejtddtveelgfelkeeiveevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehj
    nhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mw6yaZBK9XEKYscJDllFvp1pZXVP6h5uaDUJ4HX7TskMY0DAE2Ui3w>
    <xmx:mw6yaVUtTly-74gj4UGHck8B7-6bOdqxvEnLhImv9xt5Szce93-_uQ>
    <xmx:mw6yafDgoLf4WKQzT7VGtv9gVYt-kknHWLFHxLWG528NTDhG7nbwrQ>
    <xmx:mw6yaQ-0bYXJ4c7P2Jh4v-4Iun1u3uutzb9K2cMArVRM1XCfRTKP5w>
    <xmx:nA6yacHsehzhreEy0nlYd71ZpLZhZeWQFYOBkT7xm31z_MgepHn_Y2-6>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CF48D1EA006C; Wed, 11 Mar 2026 20:53:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Av9gkmLXsUM3
Date: Thu, 12 Mar 2026 01:53:27 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <8c57d87f-9694-4b50-955c-a446bdefeb51@app.fastmail.com>
In-Reply-To: <xmqqy0jxkgy8.fsf@gitster.g>
References: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
 <xmqqy0jxkgy8.fsf@gitster.g>
Subject: Re: [PATCH 0/3] doc: interpret-trailers: convert to synopsis and update
 options
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 12, 2026, at 01:51, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Topic name: doc-interpret-trailers-1
>>
>> Topic summary: Convert to synopsis style and update options.
>>
>> [3/1] doc: interpret-trailers: convert to synopsis style
>> [3/2] doc: interpret-trailers: normalize and fill out options
>> [3/3] doc: config: convert trailers section to synopsis style
>
> Somebody swapped %(count) and %(total)?

Somebody.

>
>
>>  Documentation/config/trailer.adoc         | 121 +++++++--------
>>  Documentation/git-interpret-trailers.adoc | 170 ++++++++++++----------
>>  2 files changed, 156 insertions(+), 135 deletions(-)
>>
>>
>> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
