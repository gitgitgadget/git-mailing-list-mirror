Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FB3D566B
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047009; cv=none; b=fJJXqw0bTXCO3Pkh6Ir6elhWwmstqhzNRCCHCYrp+gc2FgGehTyfi+PiacngMh/NHqXRoukh4OHjLuJ5MAdduJLrohhdCsV6wre/NYKLRRxa9lq+ibQrF0D9ijWrRDuU946bX3EutToUwZp/xcHfCbF2nZX8Pqbp+V8z1LMjyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047009; c=relaxed/simple;
	bh=/cOj0qPX+R+VeZG+q4OBAHmbkHA1Otq7WdD7OoYf84I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=izIJhzey7g1T/3iqOkO5ry/sOIwf+5pjMA0CeKiN+9lpDl1PFl9hvRfZ3ytdXJ1mzkkGTL5Q8+TVaDiTd5WF25E+DfnIGVN0CRiw/Xz58G8XPgJHX0GTDe7K85o1MTcln5dhUY2McOxzDrDJPbUxX6tX/dLLDnvt/XMI5ooYo6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PctLcEVA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KZoZ/6nD; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PctLcEVA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KZoZ/6nD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9773114000FC;
	Fri, 24 Apr 2026 12:10:06 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 24 Apr 2026 12:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777047006;
	 x=1777133406; bh=/cOj0qPX+R+VeZG+q4OBAHmbkHA1Otq7WdD7OoYf84I=; b=
	PctLcEVAiF0/NrJB5WVJhu/dQ3L2JFCOEja7eA2jGYYU7vY7dx9yEip52B3X+e6C
	Y8vRa1MTuLPoXzEAwqwrkDAChl1bVXgEvylUAJlm0KOflNJh+zDnFZ0KKM2ARTyW
	tz1vme2FnaHVix2yabY/P+yuc24Sjq8gdF7tRNujgJqH27vCLdXUiCwm5Xp/Q0/f
	LNPzO/N/sEy1YRrIeCdsPH2yNXlGRY2M0agaUPJuAFAiQOLvIKmkg25qBomTUna1
	66MbaL2E0vmQGy4rVwG3gbPJr/3854z0NZ9kV1RCzzyrG4WFaTxvsURDfPL4wc/8
	aXyvl0d3olWAj44fWpjCPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777047006; x=
	1777133406; bh=/cOj0qPX+R+VeZG+q4OBAHmbkHA1Otq7WdD7OoYf84I=; b=K
	ZoZ/6nDyk1NutykpGWkAyblX7nWvUWdHfTIIHQ5+DNFzf2k0ddTd2V4Rtnau0Wgx
	iT/zcUscAuqWxnBeTHWuHPoNqRCnJko8vbxKH5qlY6fV1HJqYnJGXtpCUeNRO68/
	YQ0D4+7Sn26ilU9g+eWaCnyzGYBTHAtuElcrnlotFSYvAOgmld8XvFyCPIlFcHc9
	FoSJ7CIvvOcdWTXqQrCjr7pcftHnEG/0okBwsNp9HdP/IV+4ddTAKmCPsbwDNBhZ
	YDDuXdQ4JZ77gke3/vkURlmoXaeOT3DVHu60hgVAm/SCG3F4HimD/u7Iyd2DY0nF
	ZcxpGRm+jz9X1e7OE419A==
X-ME-Sender: <xms:3pXraVboqx3PxOUpruhnwgEC3_1-_sxX1PUEyU2T8y1AU8kBhTpqsM4>
    <xme:3pXraXMExrO4hQJnN-5F9JwswWirl8Xq5hcV9ndleEVdvlhbUjTfUdd_gI2MW-NK-
    ax_B_zdy-nPyRyeXvaouaDTbV3IgE2GBJ53iZE9zBE2bo598pU72Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitghhrggvlhdrghhrohhsshhfvghluges
    rghmugdrtghomhdprhgtphhtthhopehjohhnrghtrghnsehjohhnthgvshdrphgrghgvpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhstghhseifvggsrdguvg
X-ME-Proxy: <xmx:3pXraZc-6VyhoOkgzob4ic7EuBbspLmtFeODiDQZ1nxTFn6dTKxMqA>
    <xmx:3pXraYt6YEgUZLww5OaQPpUab7IR0bGvKAJUHipEp8KCQXuLqs2_yw>
    <xmx:3pXraSnMZjbEb5UTiJypI8BzOGi4shRsWeCpJiDrFADd5KBGN5UoPw>
    <xmx:3pXraSwd-kwKnRXLKVM-LNjsGbZgaDAi3GWI21EyA4o9I28v85qLsA>
    <xmx:3pXraXzy_RA0HQPN_pXTo0GMZJWLF9BNo4LMXjdzyRml4z4MUexSyuC9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5E6F41EA006B; Fri, 24 Apr 2026 12:10:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ao1-gErK46Ro
Date: Fri, 24 Apr 2026 18:09:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jonatan Holmgren" <jonatan@jontes.page>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, rsch@web.de, michael.grossfeld@amd.com
Message-Id: <38188193-e6ab-40bf-950a-c516aec71d5d@app.fastmail.com>
In-Reply-To: <20260424151053.917066-1-jonatan@jontes.page>
References: 
 <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
 <20260424151053.917066-1-jonatan@jontes.page>
Subject: Re: [PATCH] alias: restore support for simple dotted aliases
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Apr 24, 2026, at 17:10, Jonatan Holmgren wrote:
> Historically, config entries like alias.foo.bar expanded the alias
> "foo.bar". The subsection-based alias syntax introduced in
> ac1f12a9de (alias: support non-alphanumeric names via subsection
> syntax, 2026-02-18) broke that behavior by treating such entries as
> if they were subsection syntax.
>
> Restore support for the old dotted form by falling back to the full
> name when the final key is not "command". Add tests covering execution
> and help output for simple dotted aliases.
>
> Reported-by: Michael Grossfeld <michael.grossfeld@amd.com>
> Helped-by: Jeff King <peff@peff.net>

Missing signoff.

> ---
>[snip]
