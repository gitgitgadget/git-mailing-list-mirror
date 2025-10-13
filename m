Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CB130F55F
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367851; cv=none; b=BWT0ZwbRzJJMnrc+rT7z7w3Dn8ML8xeAvHb+j2jGoKtq2l1kr+n43oXcT0aJszqClrEKWsvzIZRe8yYH9y/+kXTkMsIiJK2TCxYHsQO+Nlk4ixK60wKwEteNb/rcFayd7g5OMJ2E1yVH/97qCDDPb/D+qt7AoEQpuwV51N5wuyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367851; c=relaxed/simple;
	bh=DV0irisWAfMRXfYIGS2uXW3HuoZ2Fgx5MS7F6Ep8E2E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hnkYwBonEqVVGymKEFuGs3oHjTfz5ruWZ/gfx+wWs3d8R1FBs8wtCsbMPU7l42OpVuKir3h98zYwIQuvhh6ysClLLOnxihJQm9hXxeYbKSLpUAJ2He0CyYDcWvDjlQ3/0wC2oLxo4WXw2WEybtymshLkTe6WHWFjfHjhsQrizUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=cPEg85Gm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wele6rrV; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="cPEg85Gm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wele6rrV"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B0C57A052A;
	Mon, 13 Oct 2025 11:04:05 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 13 Oct 2025 11:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1760367844; x=1760454244; bh=VjoLgR0nulPzPXKmbSC3y3RDOSk/A9gv
	0ycrVYuPhj0=; b=cPEg85Gmv90mx4vLF56D1Wgc5l7/5qNjlK0lOllJ4RTAf+w5
	AiDWWjM9rSgW+h3YNMAJ5IC5QNtPyXftEC+L9UrglgjwXwXYq5I1Dq5TeOXgVorY
	2i8mMXXAPmaQqos5CABM7AGPiK4UvsUVITvSd8bF1kbJcrm1Iu0tKePIlqSa0z34
	epn09anSYpIA2ab7eVC1IH63gOZBx1ch5kWwM85qeQSzodrtjH539UwJxdu31M2i
	kiDAFskJvcmR1jHuP9fU35ORp4lElQ9WuYlrYF9dZ6RYVsYNAVREWDHu7Xznr1ur
	TQfvT8gQs3k++KZFvzElFNSuIWBaXXUy/s/1dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760367844; x=
	1760454244; bh=VjoLgR0nulPzPXKmbSC3y3RDOSk/A9gv0ycrVYuPhj0=; b=W
	ele6rrVosubnqIH/ryvZsa5a+1h0oSx22TzCqyItNVUzxTfW1afwisPVsaLXLQVh
	L+TNQkKLa+oj2xCZe6KhuaSnSYFetQI4aj86cgWkyVltbjFwfoUtakmZuF4UrVCO
	2URmoGK/ciiTFt+Kc8iNDE4k0SWrjoF2f9yXslSBwrvn6wNu9xCwuP+rO4JL3ueQ
	Vj8+nrqiUPCBoDU4+U2Xbnp0Fplxfu3UBi+Uher1ohw67XobyhoNnvm7cbUN0FUW
	BPw8gE0MPP5We92XDTPyiL54+2O3iSFSnGZgvcStpL49fkYbd5hXN2weKLxAfZX0
	U5C7+NAqinWP6Fbtlb3oA==
X-ME-Sender: <xms:5BTtaE4puoXlhWF1_v1YofWIYv0LQcb63Nm1X8VUQM5o0a-GS1AR3y4>
    <xme:5BTtaAt-1sTKRfAcZSgiruFKMFQio0lIzh-vE_shpZu_rI_oqH2WU_bSkvzxiRVfe
    VMiw9NBWgm47A-OBR8zVYhv4wgrSY6uhg5a3qloC1ELj3RSZmgjUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdu
    jeelgfduffffjeelffffledukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehj
    nhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5BTtaBj1_hKX4UOujoGC9DluaTWn-UJJ8LoWA21lBBDE7DGC7Wkfuw>
    <xmx:5BTtaD35AcK4P42WEVS8wUJDlghrzq_YAT5PWMHPLCN2m_OmH9TdPQ>
    <xmx:5BTtaLgiQbgLPubnsQGAzT8zz64S__D4pDHufQgG7yF7DzZMU_8yLw>
    <xmx:5BTtaDdmI9ktg_8S5Zf6kWxIFDYWr1foK6xQ9EdBqkfkdRP3FWILgw>
    <xmx:5BTtaA2Id8e7Rw1OzcpDa0_Pi_8FoKpGVvuO7OoqMgZaCALvGE82Hj1q>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 718291EA0066; Mon, 13 Oct 2025 11:04:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvBFpqMSI4bk
Date: Mon, 13 Oct 2025 17:03:43 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <932d3fd8-7fd3-4d1c-b3a7-644fb04ef47d@app.fastmail.com>
In-Reply-To: <20251010050628.GB1897715@coredump.intra.peff.net>
References: <978261e3be4.1760043036.git.code@khaugsbakk.name>
 <20251010050628.GB1897715@coredump.intra.peff.net>
Subject: Re: [PATCH] doc: patch-id: convert to the modern synopsis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025, at 07:06, Jeff King wrote:
> On Thu, Oct 09, 2025 at 10:53:53PM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>
>> Convert this command documentation to the modern synopsis style based=
 on
>> similar work.[1] Concretely:
>>
>> =E2=80=A2 Change the Synopsis section from `verse` to a `synopsis` bl=
ock which
>>   will automatically apply the correct formatting to various elements
>>   (although this Synopsis is very simple)
>> =E2=80=A2 Use backticks (`) for code-like things which will also use =
the correct
>>   formatting for interior placeholders (`<orderfile>`)
>> =E2=80=A2 Use backticks on options
>
> These all look like strict improvements to me. Sadly doc-diff doesn't
> show much here because the changes are mostly typographical, so I
> eyeballed the HTML output (which does look much nicer).

Thanks for testing!

--=20
Kristoffer

