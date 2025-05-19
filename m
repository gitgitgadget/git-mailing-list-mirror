Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A10266F05
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639088; cv=none; b=lfYOkyjFnQpjzjyrPrpLS60t/cr6rh+nN5opd8yw/SL1Yoi9nxNDM44HCm268TE7E1pZHEi8XPZF0ra4QiV/yaMzdP703QFwWrJvd5I17Q2NqvRTpWvwStbG7Knv8s+Pb+4xDWdLNfZXg8YD6+GW4WcUrF1gnH7t/NSCe3UI4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639088; c=relaxed/simple;
	bh=jO8TJmUuwugIyLkV1mlVjoA0enF5fj+zECwh2geJYmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0kgSpETfb5apJOMZfYFDbSdj+5pABwDjM9FfDX+qwlLm3/ElHxcFnkgn4Jz3kEpO6ScFcY7dnaFJ3qG6Q+aY2RSqDm/dZpAFFLMvlklQdIQqTT7+Y5bM0yTNCbET7Ik1XCjDg/lfi0NiPgeMGEEgbipzINwtZ72s4z7/fEmRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=3Ju+Uj3N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jg69opvl; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="3Ju+Uj3N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jg69opvl"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EF39111400D9;
	Mon, 19 May 2025 03:18:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 19 May 2025 03:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747639085; x=1747725485; bh=n1oMAOc2yq
	mWZWfg4UVWesa8s1Z88RI8uHLMU118lXg=; b=3Ju+Uj3NOk8EO8n060Y5sJvkHv
	8SsFkk8ce9WGYLkLiNxPMQs7yigvmqD2nuR6uU9wSU317aApSh5WAC93tn0McA0g
	Aw2dHfPQ6EslEd7oupAxJwAdbpF9AKh7/zHY0jOOIf/i75G8iGWP3kCYfV4CLMVb
	TOdScNyh9d7q1nTPNi8Ey7fB6rszTO2L42L4/FrToSDHA9hu/qP+8uNXwR982y59
	/O4UsHutyus0v6pJK1WvL4aggiYIHrLqH3ZhDr8Gmbu5DNb7s2DPsLKTl7eJfY0O
	lI43oaeUGOkLRhigpeWpGkj8F9JfWRPFLU7Lkv9hILmr3e88ifZ6xDsJi+5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747639085; x=1747725485; bh=n1oMAOc2yqmWZWfg4UVWesa8s1Z88RI8uHL
	MU118lXg=; b=jg69opvl3mfCXP67OnQZH24tSGyypAMeI61AKVVCEPmoo/fd/EN
	TW/i3rFd8+rgmmWsvSKHGJoth5OtPrvd0t/pvIC9scVibaj9BW9Rc1BudbYVoGzv
	HATAzm8kvNm4bQhpOUZtUxuQ+tJApkG/4t4juyCV8tfbAiqi6KiXwhGcwwoRmZU3
	If+j0a1bM+3PS4amYrKXGh5VTrOuD9VRNhfdaQVGYpp8rRtFzxpv31HhozrrQlr9
	dlrIfvlIyNROHnBd02B6m/z9sR7Tfwo4bSNbV4ShWPM+YZHjWmwmOieCj6+Clfrf
	FOdJ1buXvMbfndq9NFAdLByIuEQEzP+sJ6Q==
X-ME-Sender: <xms:LdsqaPeGyj6tY7PiDtWNlNbSb6rgVTpTB3d9eapN0Uubz5n07dlHcg>
    <xme:LdsqaFN9J5cZeLPK0ftlCFI3F2oTgqpxWArryXEtimHYpxclk6iA8Ay78knkHsfLm
    VaplbcMM2XcvIzBYw>
X-ME-Received: <xmr:LdsqaIhGTVDpi6mkayRHzHA-tjU_vpZ4dCiIW7Pau89TAUsHma0tzbalNS_6zR5OtbN1pc29SZoLynAsoBLoDmJKXp5GS1IRjl4BvHCWCwdO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LdsqaA-kiNhqF83K6wxA14Vb8XfLAerxyCj3_PNw7Ic8esnPUHY3Ig>
    <xmx:LdsqaLsYq3EB1m14uRrIzeD9zERUq8UfP5DRYPRkX_0mbGJdZOUICg>
    <xmx:LdsqaPElXJVN5wsMJnEXdKN0DiQp014r5HJYQJ3UaDpD5SVv54sYhg>
    <xmx:LdsqaCM_HM0GxmwfB2_nH4c18NjaYz9FJW_P-JTNy3dFhCPjPuhf6Q>
    <xmx:LdsqaM6uAitx9QBS4GTmXLV7qjVP-xU71O3HSaymr06CeHjDmr0l_bV->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 03:18:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 504dac43 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 07:18:04 +0000 (UTC)
Date: Mon, 19 May 2025 09:18:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/8] string-list: enable sign compare warnings check
Message-ID: <aCrbKz6tr0vj7ytY@pks.im>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDY4A62uWb-_MV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCoDY4A62uWb-_MV@ArchLinux>

On Sun, May 18, 2025 at 11:57:23PM +0800, shejialuo wrote:
> The only sign compare warning in "string-list" is that we compare the
> `index` of the `int` type with the `list->nr` of unsigned type. We get
> index by calling "get_entry_index", which would always return unsigned
> index.
> 
> Let's change the return type of "get_entry_index" to be "size_t" by
> slightly modifying the binary search algorithm. Instead of letting
> "left" to be "-1" initially, assign 0 to it.

It would help the reader to explain why this change is equivalent to how
it worked before.

Patrick
