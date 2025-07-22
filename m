Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300A21CFF6
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173686; cv=none; b=tcjqwgBM20Cy4qvuMzGTzjQiLjqzN8z8dLDjlKAtIhFH4Jqb348QpZoRXZdBMUlO/WvbmcjP03ZCOGeix4jm/jkgU8Hgj9jps9cv7DEPdFWTn1ZKhNLFlf5u3TpZ/umlRcOPzVLPwR5JdBuUvY2Ap9sBaMOfUYUcWyyxeVrpOcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173686; c=relaxed/simple;
	bh=40PPSotJQnwI2H+0IGlQMYmXI7Oto1LjomxrL9GOtjY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k4iuh93IR72hp37BAKkBv6huE/PlFAWZT72w+LTRzdRzyPXm0+gdyZfl7ka7k50iAJSaIr0/0AGwWZiN1ozVOsFxrMMWWzgd0cozP8FR8Gr2EXbPFmYIIBuILWA6R5mOmq3mSLqeGgNbY4Sb4/7BKg8YHqzLRg6bxI/V9IpfYaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fHIrRYYm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VK66WyeG; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fHIrRYYm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VK66WyeG"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 486C31400079;
	Tue, 22 Jul 2025 04:41:23 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-09.internal (MEProxy); Tue, 22 Jul 2025 04:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753173683;
	 x=1753260083; bh=gz6HCUrCYynOR+knaDwa0d9V5hNEfIpECflTeXgZFeo=; b=
	fHIrRYYmn9hIjvmVIOkKEnqCE85hFxpfMF3NnumEntInCE2CHg1l0PSJvc0GSg8A
	HTtowWLJZvh59LQqXm1PryUxcfAM7UGj0WQXoShOHxjlJVAe1W/1XFuPJ8xlY7Vm
	9S6HgVEBeC+DFtb4ejnva1u9fpDauedAttnXNqEaIIMTXzQ8PIGDi4FPt8eKq+Rb
	EKlkVasoH6JYbJHmd8Zfy+L+bwje982Znm4HUj7Ej0Udg89CTkosnKDUrZA9hLdp
	IoKla5gJAcfNxNVh9W0U4W3xeSodwvaDJKgDp4gk2H+X+Ut59ospqwj2dIovnsR5
	RvqfQkhaWmVUetwqsDQK5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1753173683; x=1753260083; bh=g
	z6HCUrCYynOR+knaDwa0d9V5hNEfIpECflTeXgZFeo=; b=VK66WyeGsDN3G0gu9
	rzmcJ6xFSoCXkI/cNV28xg1NvfhN36JT5r+fRrCmgyAxjqLzEjUDDrHD+uDRivmQ
	rgM3/TQ1CwhYAF2qGh+Oj9HRCIYlaX4Jnfw3B+c3U6ZZKTNoJPGgHsh8xNFmg8an
	OwFAXvRr8t7KKPPrY42Xcb1LIJysELdqlhnOMBiW8KOq4fQNMDuJrXHUifYJcK8C
	VHgBTLrPj4qpblQP9LAd9ABDtXhTNEvJPs8c9QAK0YUoMzhr41TjzOgzQG1MHEo+
	f0pt8yOamfH8nYwGoNX6tmj4hvcZA0emL6+p2vDZFMshaAa7dp8kjh94fz+BDSsn
	ea2+w==
X-ME-Sender: <xms:s05_aD8KDUVV6DGA4IYCE7VdodBi6uh6GZvS-d5gkYCIUS7N8lm-yrU>
    <xme:s05_aPsSzHkMmwTkOGTgE8zf3dDpYwe4GRhlLh-AhVnh2SUtd17YF8LPSWmzQK3nl
    fuCLbQbqzMlhG1WAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveei
    ledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:s05_aEB9XZKcYpTxwFndVDnNHnoENEULnwUIz0SkneZOLv32MwfHtw>
    <xmx:s05_aPdRHDENoLDymQ3sL5DzoEGk-Dwkup64n0rXPdXvpXM9kwjj0g>
    <xmx:s05_aJi7_rk8VkVCJGoZjpibbt30iIqKJzTlZERYky2mmpXyjLTMzg>
    <xmx:s05_aHoital2wYWeyQthSc2FMy7p2MJ8fs7xUBjFEg8TaLwoY1pUeQ>
    <xmx:s05_aBAhU3h3dT3I07at5hKZG_ohY3hMih37OPij4uAljIL2CC4Cdo1U>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 10413186006D; Tue, 22 Jul 2025 04:41:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tdc58e48706e0a2cf
Date: Tue, 22 Jul 2025 10:41:02 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <1599cd31-436c-4ac7-bbef-be7dfbff00a3@app.fastmail.com>
In-Reply-To: <xmqqecu9w4a5.fsf@gitster.g>
References: <xmqqa551127o.fsf@gitster.g> <xmqqecu9w4a5.fsf@gitster.g>
Subject: Re: [PATCH] rev-list: update a NEEDSWORK comment
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025, at 00:46, Junio C Hamano wrote:
> The comment was poorly phrased and it wasn't clear what it wanted to
> say.  Strongly discourage this broken pattern to be copied and
> pasted to other code paths.

Why =E2=80=9Cwas=E2=80=9D?  Shouldn=E2=80=99t it be =E2=80=9CThe comment=
 is poorly phrased ... so
[change it]=E2=80=9D.  According to SubmittingPatches, =E2=80=9Cpresent-=
tense=E2=80=9D.

/nitpick
