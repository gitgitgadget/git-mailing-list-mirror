Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F591F4CAA
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459908; cv=none; b=nXMeuL6yVDSacj4HK4Xrgq18mgwq5x0hSWFF4dWYL/SbeAEd9p9MtXtiZblxcDMlu6qxz91ivFNtSW1ccCRXxlxS/EaV1aIPUy8Q3ZOauUl8bZqmtCw1rl26iKhzPZ9298kZDgWbIxpJPOUciO2/0qKFtXt0ZpLCWUxfmr6OLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459908; c=relaxed/simple;
	bh=5lY+BES+juQ6Bm0FWVIsTZ2cK8INRIj8243kW1l69oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxDvwcWF9gMJyk8QH8pmwUM+r65W8m0xDfVyYERtjGIcyKoYne2TTdPgqMH8gj1X6TQpioonsW/tDYLWpiPiIcpaliIGR4YD8uavrMVjdewduQAqmNm2Bro0m+8q3e1xSPFQLpMkri+NaTwu67JO/FWIixGOygwP4EE/tKTL6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J6/h7Em1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GGdzWqg3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J6/h7Em1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGdzWqg3"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B179114019B;
	Thu, 20 Mar 2025 04:38:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 20 Mar 2025 04:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742459905; x=1742546305; bh=ULTI1m43Vj
	K0fd3UP29ICe4HlQrnB8hn2Zyb+DUntUk=; b=J6/h7Em1dPUf3DaSZgDAYaS8Cx
	mO5Oq6aXg+xr3Lh5aR853eWxE/g+sX5y7VMuN57RmIu7JquJ4/G1ei5EtWwyrHDd
	an8eRKf2QgPq+u0hyklU1j6TZYl+PQO0rM7LBS8tXh5jW5XOgXJQXkp2bKMLT6az
	SjT2eBnurfQRO4PAGksSwkJ3oOaTQ0grfIxNYiacwZxc3vxLK9Y/yPtQQDpf+58a
	JeNfxdYwEs9av5+4yOdsx1TTTdc4XmxEjENrVkiUDMkPk08bn/UAMCnzaKgHjMfW
	S4GsJNVxlZUx/eteE9HLO1YHmoHzc50c+yx5BzrUY816jcOXP+ooEDsNUM1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742459905; x=1742546305; bh=ULTI1m43VjK0fd3UP29ICe4HlQrnB8hn2Zy
	b+DUntUk=; b=GGdzWqg3eKF8wEC5/vm7A3Pv/JG9RAuNryWREjiuIrKz3VABRGX
	uhX527CGn0WBMNxcwvgYxp95F1zzMZxcXDmCekFBXeNIJpouvIUW3pj+FXq9v8o5
	6ejLZ/SrViiBs/UnkVxPmJDBQUSi11+NblnYrczfGDXNYx2+IXA+CVxn2fpsg5xX
	nliJQU+BNfmzIleFoDrrPZetGsWcqNfqs1yrasVAvSFc3HPgpWHb1pv+gvMJRkDh
	bGO+njj5sgftkop//ahTRoNkBl44U0zcS1NiAlhWwWgAL8/pTbiL3QKi6MhNUDRJ
	WrIq2mOpi3dR8EhbXqZ2NltKYaoAU//XXRQ==
X-ME-Sender: <xms:ANTbZ_DqNizbuc9tQfI2vxxqLM3ABBd4_uIaDWHFRzl9po05RzXW0Q>
    <xme:ANTbZ1jEqycOMsD8cG7p8gTcb6Pgy2ZWUewSMUdt2Tnptc6r_5jdJ8MN-7qydsEkd
    x1o4UDJO_Ec3Z71SQ>
X-ME-Received: <xmr:ANTbZ6kBCn_3HGfjrfsuwfOMxFaCgDkcYeT0yIiNDbt4sTcDy794lLWn1IURnN3YkKJ9xt31iLgKfbHIFr_cuzYbL02AMUme7GiW2tOh_OBBSs8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ANTbZxz3b28Tl1Vy6pCOUVx1XqX35OrhW_lnKTeAbso1jULtPd9orA>
    <xmx:ANTbZ0Qjw1wdvFYcRlilmZErzm8CSP_d2iGnsiiZfBPSoVTNMwu-oQ>
    <xmx:ANTbZ0a4W8wV0hCAkK14dDidjw_UbGNMzQtHqbizv7xS-Pm-LlWXbA>
    <xmx:ANTbZ1TrwXHGapxBVo1bTFqW4M0s7CaNk6gF7htg1dGHFos6C4XB5A>
    <xmx:AdTbZ_fUrTlu_Vs4OKARvurbvjbGMB2bLc1ougg_HCNyyK_7EYARpYmb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 04:38:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 71676ef9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 08:38:21 +0000 (UTC)
Date: Thu, 20 Mar 2025 09:38:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 1/2] userdiff: add builtin driver for gitconfig
 syntax
Message-ID: <Z9vT-dqBzXxzXnlU@pks.im>
References: <20250319172016.2115-1-lucasseikioshiro@gmail.com>
 <20250319172016.2115-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319172016.2115-2-lucasseikioshiro@gmail.com>

On Wed, Mar 19, 2025 at 02:20:15PM -0300, Lucas Seiki Oshiro wrote:
> From Documentation/config.adoc:
> 
> """
> The file consists of sections and variables. A section begins with
> the name of the section in square brackets and continues until the next
> section begins. Section names are case-insensitive. Only alphanumeric
> characters, `-` and `.` are allowed in section names. Each variable
> must belong to some section, which means that there must be a section
> header before the first setting of a variable.
> 
> [...]
> 
> Subsection names are case sensitive and can contain any characters except
> newline and the null byte.
> 
> The variable names are case-insensitive, allow only alphanumeric characters
> and `-`, and must start with an alphabetic character.
> """

I don't think it's necessary to quote this whole paragraph here, as most
of us should be quite familiar with its format. I'd rather summarize the
info a bit and explain how we can use the userdiff patterns for the
general structure of the config. And in case there are any subtleties in
the format it may make sense to specifically point out those instead of
quoting the whole manual.

> Then, add a new builtin driver for gitconfig files, where:
> 
> - the funcname regular expression matches sections and subsections,
>   i. e. the pattern [SECTION] or [SECTION "SUBSECTION"], where the
>   section is composed by alphanumeric numbers, `-` and `.`, and
>   subsection names may be composed by any characters;

Okay, makes sense.

> - word_regex is more permissive, matching any word with one or more
>   non-whitespace characters.

It would be nice to provide context _why_ it is more permissive and what
the effect is.

The order of the commit message in our project is typically a bit
different than what you have here: we first explain the actual problem
that we aim to solve before discussing how you solve it.

The code change itself looks sensible to me.

Patrick
