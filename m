Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A36C231C9C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908733; cv=none; b=fzSXCg+pR5qntKJ3FKpk7xsMpOIo7+4d1jHt0tabkwqZ8B/CGv3uPV4+6Owk/l1bOXvl4lCc1WVq3AtajQw1XTe5SlUcNYPNGjSqpooolcyNHqSoLJKaB0KmyakB4eoa2GdzWQ0bzMVbqwd1pIBsQG/g4ZoGuY3Wgb/kCpwFwyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908733; c=relaxed/simple;
	bh=5FczyTle7q+inbGeQYo45+1YtgN4CSNj8WOupa+HqsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdx1HInf2y8V5XOkAYfyUd9A/B915vSQG0TUa0i5SjYaMkdDuyje4WlqThtwZvaTHPRCbZor2azGKrr6c2qB7ytCZZfgQApuDY2unylq/P8XfSc8wFRje61ZRp+b0oIo4HlHl4hYMKeHAz+iw7TLT0wWVvMKVDfAOfttd71fcXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NwRvUw6J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UZKGXDTA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NwRvUw6J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UZKGXDTA"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D830114017D;
	Mon, 14 Oct 2024 08:25:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 14 Oct 2024 08:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728908731;
	 x=1728995131; bh=OeB8JPbvOZpkWvZCEI5rgGK0WWq1DsRedKcYRHfCh9I=; b=
	NwRvUw6JE3oLCDqUUPnvnU3GjeqGUPq/lyoWHCq5FXmWqbUTOkrcta53Qtvcgn9d
	MYGh3jOc0l1xEmq3Pm/tzfO6h/zGPRyEPoopmda7RxodWdgp/ak5KaH/Al15jB8+
	Tc5IOt63eN80zfeCHgh7zlHkRK1s1anE4HvVmg1N3VF0k6Kvzb/L1sj78Monv9Ut
	2w71h3qs3qKYvwOZ00ZLIJRI9uFPsUd/LLdltRrpvC3E+VaxfwfMiBHykFf1Z6jT
	5Au98YdhQ0l3HAAzZdngK9mITJteSN4QdLZgLLHlz37KDnPV+7NkPUX4jX3jNKPU
	xKceyeYV/c0WZOadNmMh0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728908731; x=
	1728995131; bh=OeB8JPbvOZpkWvZCEI5rgGK0WWq1DsRedKcYRHfCh9I=; b=U
	ZKGXDTAtMc72anPWp31e2Ky2TGdywfmIgcHmG4Zqc7XjUbU8lDBeDqZa2tunV8Z+
	EXlElTQDUIDvaa1UMjhRUMeG6E9rJHxFSClq/xiwbOveCL8jOPv3z9UYWWuug2GJ
	pj9PYljBqn7bXlhs25wXgm04i6KB6pwPdMtNGJBlMBr2ie5EFVM7ErsBXLFmbwIh
	BuLN8vzga26Z8rANmY1R5lSE6DzHArf56hgalM3uC8cyjQXyuNAOAeZR6Q49ubAD
	OcbS2skpBEMe5ltw+KcYnpWV0N5LPQ1yJfqJ9rtqEJ4nIxP5pIx52d7vd317+vGQ
	5am8lZyuCQ3H50JD+eWjw==
X-ME-Sender: <xms:uw0NZ41PK0uMgHMzR06xTJ6xygU8AtMBFxBHJB54idEv8hJT0cjzFw>
    <xme:uw0NZzGp284IVEjOnwwEv7VBdRqengM29cLBXGUTNxwHcZuFHXoIqmv9TdQs_J9gt
    taBZav4XpOT54uC0w>
X-ME-Received: <xmr:uw0NZw5oFdwGsDEi18hEiF49alrgUJg1K6XaGe_7ciiD4Og8tOVFCX4Z6LL4O7UnFULXRkm7YuNE2tCVO8mfjo5hvfJ9FNIym03MPIIQGqxFyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhnuhgvthiiihesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:uw0NZx1OZUaxOytIUezgoZM3Y3rjBbyQDK_vquBN2qjC7KCYF8yWyA>
    <xmx:uw0NZ7EUUGKSJImpQXSIWajEChqIM6IeenD1-KTFq2u8BEPmaKCdJA>
    <xmx:uw0NZ69xwuADXIsQH6npbu6M6AXDBaIHghRp2CUuv7D1lobWzb6Wvw>
    <xmx:uw0NZwkz32Zz5Fk7fXk3tj5q09BeHxgyG5J7GfClSBChhL9e7_KWHw>
    <xmx:uw0NZ_i5ti-8iPRevcS1akWz3qTK7fWLkKk18Q2IoskUbeEl3rUv2OBb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 08:25:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 205c60c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 12:24:16 +0000 (UTC)
Date: Mon, 14 Oct 2024 14:25:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Gabriel =?utf-8?B?TsO8dHpp?= <gnuetzi@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
Message-ID: <Zw0NskRJUSmpNxLe@pks.im>
References: <ZwZ01-mtwm9Gcjub@pks.im>
 <B0631C6D-0914-4C25-AAF7-E742129836FC@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B0631C6D-0914-4C25-AAF7-E742129836FC@gmail.com>

On Fri, Oct 11, 2024 at 12:09:18PM +0200, Gabriel Nützi wrote:
> > namely by checking whether the HEAD file exists in the Git directory. 
> 
> The problem here is the chicken-egg problem: How do I know inside a
> hook where to look for HEAD, so the non. env. way of doing this would
> be 'git rev-parse —git-dir' which crahshes… So there should be cleary
> some better way of knowing if a Git repo is on the way of beeing
> created, and when it is fully initialized. What about
> GIT_DIR_INITIALIZING and this variable does not exist once it is done
> or whats about making ‚git rev-parse —git-dir‘ not panic if the env.
> variables are defined. I guess for a good solution we need both?

Our documentation in githooks(5) says that the GIT_DIR environment
variable is always set so that the hook can identify the location of the
Git repository. So I'd argue that using git-rev-parse(1) is unnecessary
in the first place. Or am I missing something?

Patrick
