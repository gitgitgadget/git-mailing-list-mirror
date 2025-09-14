Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE4A2AC17
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855450; cv=none; b=XYAB03xtYGtBghPV2ujOSEIQYI8Q1Npdn2sLq0W6aSHNl7s5sycPPQ6ZR7SHh45XAt6WzvzzQu2N1HLWhcA9Q/hgfpBu+dxbbv6rt90Q/2IEcUQl/XUUUicyrHSQN+mYLjQsHjAfZRdLOdiBh2kBSwS2D6U/UeA4Z4H7+GbVOyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855450; c=relaxed/simple;
	bh=WbytImRQaH9/ilbBpMxL0mg0nbRCZPjN2GJs2mhU+o4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Eti+jYUUMU8TeoQWWRWfxC9g6J5EL6OsDB/qSnRN177184iksRn7MWaeSr9f0g5wYjrSUfIvWjrKtNUFHLENWrkYRYFqzNc2AN7mOLqMdISw2AB3iZJUl/5xX6OfqELDb4i22V+jZrTDCSeclepIDtlEyicl7fQKqWEYVZSqOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RuT71PKm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nMEKF6x0; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RuT71PKm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nMEKF6x0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F040EC018C;
	Sun, 14 Sep 2025 09:10:46 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 14 Sep 2025 09:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757855446;
	 x=1757941846; bh=B78ZxlYVTUTW+k5iYoB7Y5Ai9+Tv+5+YVfoXqlWp8dw=; b=
	RuT71PKmB3DCtIdAed1V5k1N7SchdcyWlGVVGmatbxbZ+YkkhpYRoOe6RO2zX5+l
	yntApsIevF89HTN343Aq5GsBjuQ4dBpEIxP2aWzRhlq2di1LlJNhw/2fVjX2kfsV
	HHQL5lBlG2ViH1RmEZItZqq8OT3cKt0WuD0GJmT/yBRdi7pv+kYDvo5Zx3lDmnQx
	5udbMh+4LAt5cJFh86+vnzGOP1zyvJX11As8b21MfGFIg4g1cayiG9+XfKWbDOQV
	3RQ+9K/9qMknm9EwbiZqWUvxwCwgYG1Pkf+KgUgowuYRkKJXAaJoOYNCTAWh7LoH
	3nKY6WHxUYE2LjKV/J5WRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757855446; x=1757941846; bh=B
	78ZxlYVTUTW+k5iYoB7Y5Ai9+Tv+5+YVfoXqlWp8dw=; b=nMEKF6x0mjSKIvKhd
	x5non1HIOqUi37zED6rPTCERW8X94s5KFr4NsYZEIyDcRwb601W/mzI/uwNkFBnT
	RblwbLQ2+Bhfb8bi9Xtm+yja4oJqHznjC8Ccpz2MzQFeRwnmlXX+78Lbe+PZZZo+
	PTIOby0MzGH5PMHvkDUUelftceEXt9zlT4NSP2DWMfUMNUrxLk8dQyTrfi/Jofcu
	GZ4wXRO738XoFYqopaQAwUHVuKRmgxkEHKApsYjqwjvTqZh0e4+n7yUzywfCf25n
	nQJnsXwFHMb2pNehRJ9Ak0olK4tFDEFiDHCSZ72b/lvQR6uNU0rAkIyLIfCwcK51
	sGz+w==
X-ME-Sender: <xms:1r7GaMCyHXXRdOzM82hydZV_JnvWT9LTHBkbREWzL4-XJY6ScRQWMEQ>
    <xme:1r7GaOi3Mx3Cw9VrQGCOB3WcnGwsf7NseNewO77rmAazicTPZMIXCh_3iWnOiEbZm
    ycvbjCzVQ4kcFTjng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefgeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdeigedtgfetgefh
    ffetteeludevheetfeekffehheefieehudekveelveffhfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegsjhhovghrnhgsrghsthhirghnsehpohhsthgv
    ohdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1r7GaAFIXaJ0RAUOVhJEoHA3hEWRJhSYsMcRrxEo7x8bCLjkmaUU_Q>
    <xmx:1r7GaCQMGxmOD4c6i7Q2TyxNdy1j3s5rCti-iPlQcddg9ggLi8NoCA>
    <xmx:1r7GaMFuNAQcDZg7gXd-6gU5DxA7-N6Xqs_eAfmO7W57kerUcO9nYQ>
    <xmx:1r7GaO9AVTlvrKNQEeJibQKY7rgouHgo4VqAYCADtgbCTYKxgrMANQ>
    <xmx:1r7GaIzRSGKPuC6qg9SZoTdT3cTTQrPQqr8ckqpgcpp5EoZqXQAUb1IC>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E87911EA0068; Sun, 14 Sep 2025 09:10:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApBtbmhnwsVo
Date: Sun, 14 Sep 2025 15:10:20 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Bjoern Bastian" <bjoernbastian@posteo.de>, git@vger.kernel.org
Message-Id: <7897d2d0-5564-4514-ab3b-7310b626f4c3@app.fastmail.com>
In-Reply-To: <aMa5kSQVlhVX7Iii@eismeer>
References: <aMa5kSQVlhVX7Iii@eismeer>
Subject: Re: Usage of git whatchanged
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Sun, Sep 14, 2025, at 14:48, Bjoern Bastian wrote:
> I still use 'git whatchanged' that has been available for a long time
> and though being longer than 'git log --raw' is much quicker to type,
> as 'git wh' is already sufficient for syntax completion. Obviously,
> for this reason I won't use it with the '--i-still-use-this' option.

`git log --raw --no-merged` is the closest equivalent.

What if you made a `wh` alias?

    wh = log --raw --no-merged

-- 
Kristoffer Haugsbakk
