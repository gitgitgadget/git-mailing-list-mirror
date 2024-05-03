Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C653372
	for <git@vger.kernel.org>; Fri,  3 May 2024 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731227; cv=none; b=LT4EjmGdN3lNcZRoHzz9UlsqEyltXk3Th+MsEXa7kA3oaFIK5Q/mIJt+xae0A0Vvr4wu2Qce/laDwL/ua+I3KqeWh5lKh2QqQ7Tn6fAM9HolvuXWw1H1c6H/sOYCLZbTCe/Nuuhpcc6nweVMZWRJKZfi8Q60RoYNFxEW3g23bG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731227; c=relaxed/simple;
	bh=rnIxOKYDM/C9NLsRlkq+YjDHkcwenr232IH1bZx+k7U=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PGF2vcg7eCLG7pT9n6IxMJm/+G3k06mGvsIWgaZBpLYBlQV8Y1wSSivAT0sS4Fo5os9gYf12/xUJjY4F+2l5N9DP9mNFucGIXjAHbd7fhAdqn/9bALJI9OfYISBW98yJCXBKb4aBm59RBuZxCeh/COA7fynhTmQ7Neix/FV9StI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=brRFZ0lJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UBE5/PXT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="brRFZ0lJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UBE5/PXT"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C1F0111401AF;
	Fri,  3 May 2024 06:13:43 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 03 May 2024 06:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1714731223; x=
	1714817623; bh=a0cdfW/5oKG2SdOq7wVp6VWdVdYiNVn6ZYy8gQJQBYY=; b=b
	rRFZ0lJMhnVK1ZivKm0JGhCu+17Vsr4PjwaYL0Wgh+J6xYsPCGJmX3+qVUcqo9+l
	OJYBNprVizmzolHGFWoOHzSHCj6vTXwgnQCb3FvYJD/IR6X8uyok/+f42w2xcMYF
	fgS2OPXI1yCg36sf5hVkh///lT8KMgtasw6qgEMC0BWA/1kM6aWWN53SfF4T+B5Y
	/tdvhw9ksxDjL720tFCLqs4KcEC22TOt9f3K41sF+/LZtXDdvhUJgfuTNT4hJBiD
	bKZ7ePWCzU6gVSOsJyUJMOev8UuBmB7v152HnC8XOTIUbc5GZyyMjldOK7REvjoN
	JsBTC6yRhafQTs/kqRQOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714731223; x=1714817623; bh=a0cdfW/5oKG2SdOq7wVp6VWdVdYi
	NVn6ZYy8gQJQBYY=; b=UBE5/PXTLRUtCE/JtowZV8ksn2o0CP3xirQUtb/viMdM
	qleEqTq8lA85Oxj23ph39f40AVJ0A0yu2G4icL9rV+9GqJg8ro697atBogFLTpwv
	zRb14i8ilsilemri3ggR2losUmvSUJRLoTOMMWS1YbFXY8NYvzSUATqtuR2rzNgU
	O7bP45VrS0yQmb1Bx8RT62WZ/nxskTuRs6rjcKNtZgnKn2eHLQ4WnrcGTfHqW38U
	OKnhjXAo5EjLUzPuCPZzKXUTsx3PsQZVZZe6i5JnoRyT2TxVHC4EoqPCxoU3MOvm
	c5S9MgI+uM0hx3aYcXr0rwAobWOOl6icr08iDhSryw==
X-ME-Sender: <xms:17g0ZvhJNqm1C7sR769KbusbrYekm6AFxwWz9ARgyuQlYZPnoXil9_U>
    <xme:17g0ZsBqKFuer-YHvkzyIL_ygEX3xkpyIEpmUmlSk4Ouw6izg7ym0JQlufByjXnub
    CWTZPOxSt1SBHLQww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:17g0ZvFLfgDvx6iGiX62mumg2vCOsQ75eITajhLgmY6R6fhZG8W0BQ>
    <xmx:17g0ZsRHEPOAp2d-i2NO4FQnaRagv5epQVnb4-d4aqgYoXPyET_yEQ>
    <xmx:17g0ZsxqXHvC_FNcQB6z_3Bit6buy-hyF03asNHyuSckzqVIe0KCLA>
    <xmx:17g0Zi5dQ2sDK2osZN8O0i1pqIaWdjxGnKpPjClcXghQD7hwoWoOIQ>
    <xmx:17g0Zrpt5ExKGZF3FBnL6MZLIrtdNW1RfKD_5fk-k9XXxfijEEjzMsGs>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 67C0015A0092; Fri,  3 May 2024 06:13:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-417-gddc99d37d-fm-hotfix-20240424.001-g2c179674
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6d8af89c-614d-43a1-a8b5-83a0fc17ad94@app.fastmail.com>
In-Reply-To: 
 <3aa26d5bff21e0b93736b1502fa90694f6b2cedc.1714730169.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im> <cover.1714730169.git.ps@pks.im>
 <3aa26d5bff21e0b93736b1502fa90694f6b2cedc.1714730169.git.ps@pks.im>
Date: Fri, 03 May 2024 12:13:17 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Taylor Blau" <me@ttaylorr.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Eric Sunshine" <sunshine@sunshineco.com>,
 "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 01/14] config: clarify memory ownership when preparing comment
 strings
Content-Type: text/plain

On Fri, May 3, 2024, at 11:56, Patrick Steinhardt wrote:
> The ownership of memory returned when preparing a comment string is
> quite intricate: when the returned value is different than the passed
> value, then the caller is responsible to free the memory. This is quite
> subtle, and it's even easier to miss because the returned value is in
> fact a `const char *`.
>
> Adapt the function to always return either `NULL` or a newly allocated
> string. The function is called at most once per git-config(1), so it's
> not like this micro-optimization really matters. Thus, callers are now
> always responsible for freeing the value.
> ---

Missing a signoff on this one. The only one in the series.

-- 
Kristoffer Haugsbakk
