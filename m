Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C317591
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660993; cv=none; b=JjvTZrhLe5DD2+aLjBXRufAhLT6s5Lu4ey5dJ/9WJ2ZAZc0qNnuXVaICVmASlSmzgY7+EM+6ID62o0E8zoUb0eUXwgAGoKGSpSiMNLGvS6BKyh6PAgsNVWTbd6ECVTth+/dbKskvULtOZzpG0GH0H6duMnw6sVU3gVtCnd50MXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660993; c=relaxed/simple;
	bh=/GN0Mc1GDBtevxy4ckby+D52N/a8doSVedv6XnfEPqQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZUnwV7F3tuH9BfhLc/XZ7rXDIQhhpa6EeP1RttBwal+BDPsgtFueIWixcrW3IO1tG7XhMcEZNCd0wm+ioIdslXgV5SN7sDFAwPqyrCakcu47f6Fes5/FzbNoCiAFHZI+c7TV7N2X/OJGxEp2PKMXkquBoNP3iUWLMMT+rjBg2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=vg9qh4qP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OsTe/Zre; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="vg9qh4qP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OsTe/Zre"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id A18FA18000A7;
	Tue,  5 Mar 2024 12:49:50 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 05 Mar 2024 12:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1709660990; x=
	1709747390; bh=IgcQr5Ip7T3qxa3LT0feew0QvTWVBHs6zJCSmlNY7wc=; b=v
	g9qh4qPkZ7f6LO4BQbB95lJCN8VlCK+legV7fVh4GnYuQuCC+DMM3nUnQnbH23e9
	Nz1C6CYWjeNj3SkHLoGvndh7EhxfLr0bu7mjBQkRnWisLPqNzA6Tu8PAj0Rju/PR
	wn+zgQmmzVxnua4nKHAESTllBcTwu95GDVQofDupj5uVassJIM55YxgXci7oUALQ
	LUK+Njp0CQx8GTNKXbpw7lHJkCoZi3XVQHRwJH1ShBKqbKa7tTFtdb+tgiwpFbFH
	vmXeOei034qBkEgf+OHxyyKi8lChLG1JMXuGgym+rrrzzpKCd1O9XVhRZKASUf0l
	H+Pf9Tz8scqje81MzW03A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709660990; x=1709747390; bh=IgcQr5Ip7T3qxa3LT0feew0QvTWV
	BHs6zJCSmlNY7wc=; b=OsTe/ZreutF+I6AvDgMeFr1NmjuMr2lYY3D57zwqwmRo
	DAZVQxdRXsmwv7ZNDPtSWGLabJfAPrOIcwVMMCxUVqETKZDDlmpU6DnseT+ZmPtF
	sUvLE1G4h8mJuP8R2znaY+xKRYk5DYKkE44z5xtWLnt2n8c3fYjYqLQG8t4kLVwa
	wWxocp4pMP/tk70odpoCXHVBzj40RJ4Z8b9qxZVDIk7rsLNC+suM/aGwfiPuYO+g
	tut5bESvh22uvCbXRAnf2jbz/xwLT9dBrvfDIkKSqmTMHtNLo4e9IGQhM5A4VWZr
	dZPKmBhmc9UBtd1xIjB2dolDCbOF1r8wXFs+HJ2JmQ==
X-ME-Sender: <xms:PVvnZYtFDPrqO0SC2t1UsLWw_svadU9lUQlvERkIx-0PZPjz0SK2vIA>
    <xme:PVvnZVeazmuIwpW20aotoeKtdrGAHY5DM5_8tautVDOJMA5SsAWhKlDSE-Ci3gQ90
    c7Nvobm465Vdx4CKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepudejfedvtdekfedvveevueegfffghfei
    tdekudekgfdujeeihfejjedtkeduteehnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:PlvnZTw5NjdQQ4PeTKdX354lk6wUImBpj5m16QMYEPb8fIUrlRU-lA>
    <xmx:PlvnZbOytUmMquGb-p_Kx7n25saRDQDQ60f4qmVMKcDsObc0Mwrc0Q>
    <xmx:PlvnZY-sMdQfXrMwqvGNKpKCUo8KOQpoHYecttlg0-cEzWOWvFlwtg>
    <xmx:PlvnZXbGXkHzcBMYAs6kDTtOweQ9rJFB7Y89OX5E4NrMgJWPxELg3fmWhxU>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DAEC315A0093; Tue,  5 Mar 2024 12:49:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <33966e29-ca9e-4835-933a-9316b3c6c24b@app.fastmail.com>
In-Reply-To: <xmqqedco37hh.fsf@gitster.g>
References: <xmqqsf1466eh.fsf@gitster.g>
 <9633f9be5ddd9ab3df4b79ee934e1ed47e90bd1d.1709656683.git.code@khaugsbakk.name>
 <xmqqedco37hh.fsf@gitster.g>
Date: Tue, 05 Mar 2024 18:49:29 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Manlio Perillo" <manlio.perillo@gmail.com>, git@vger.kernel.org,
 "Dragan Simic" <dsimic@manjaro.org>
Subject: Re: Clarify the meaning of "character" in the documentation
Content-Type: text/plain

On Tue, Mar 5, 2024, at 18:37, Junio C Hamano wrote:
>> Maybe introduce `core.commentString` and make it a synonym for
>> `core.commentChar`?
>
> Yes, if we were to do so.  As I already said, this is not my itch,
> but such a synonym would be part of the migration plan if somebody
> seriously designs this as a new feature.

Maybe someone will discover an itch:

https://github.com/gitgitgadget/git/issues/1685

-- 
Kristoffer Haugsbakk

