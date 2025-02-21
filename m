Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8B250BFE
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162380; cv=none; b=Ndv12DQ3hXHq8liAvZZvRx5Tbl+bngx9agYlVnat3RQXKp0++KM/TnKv0GHizo1bfBt1787cEJEavTur15vqfa0MsCMnNq8m7QCjvxdrzDSYt0FYKr0L67ZdPs38SdfTGz5/cdPQsXZzupef4VObm+PjMltvBrAwA/GLi6nofNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162380; c=relaxed/simple;
	bh=p8QVDJSdfpJYgWJgzYpnWch/Ra2EEnZTsEsBsYdtdJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e6QRcj/yzX/20u+AZXFYgo5qTrPYJW/qAJkcaGueodTy6pzLwIh2XGhbDU2Fgzhl8PNSnlIXpuBzAS1E9aQlEPaDrI9Vvs1QnjK1KA8A9vGSjmRHXTBY3LKGkKr/uv1u+isSD2mvFctcAB4wDvmUGtFIII83q1FEp6VbMkugOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TXvHmyAz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=laha5ZgR; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TXvHmyAz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="laha5ZgR"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C30E25400C3;
	Fri, 21 Feb 2025 13:26:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 21 Feb 2025 13:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740162377; x=1740248777; bh=BY/cKNoEJj
	fzUKWc8JKkeuownH7Y9D+8zUDhGfGsWc0=; b=TXvHmyAz4rQ75khzFylTj8bgqm
	9x7K2r8tgoIdmeII6D6p5Tw0g4kS41Eh263Q60porT+E3hMjMX/qMvMQ9rs7F+wz
	h90A7KukpmQhC/kx37TCbuiN9JMvrxI7+UpdsVB71F4HlOhhPpQTofxekiiOKo/Y
	wGt2suPJsAQC6D1MXC9KRTyAQI9/9etBHWnDqa20ADwm0FSqQ8QP8yr7YQd8MB8l
	W1eL8dAHUwODCK5dujtYk7caxEo6TQRZBjNk5i2YWDxu5ehKOWq8kxMvAnTuzAbH
	YKlTCvKBz1Yk5v5OSp42GHKMomBXBWptc3wnxHQWmQPSoGjOhSsN7s5Tuq8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740162377; x=1740248777; bh=BY/cKNoEJjfzUKWc8JKkeuownH7Y9D+8zUD
	hGfGsWc0=; b=laha5ZgRPy68R0vDgLIjWkAa+GUyNkfyOBcoYXidc1/nT7KSjCw
	E54QKm3LqefmKEQUaucHQwlEbsWxfZnerYquGV6FUapQTBVpWvEsWaT4D9hBy+TN
	maKlssXw4JloGRNo5HqMVTyOEObQMPcBY1t9Xlf90am05DQPCqYuJSFtYkfCqXVG
	0lhkd72KlORcQeEyB/GxxNpNBBMBPxJ7iT5eNXEwnuJlfXoDz8ScEPIDxSYtNW6F
	t/PaJWkToSXJQDZ+9I9DJQGRkwjscXqs77v8RgtI14C0JqFffmLyglymxMK/Kg8V
	82gCIVThfpbjlnIgNKWaGG0WxclkG0mlo7Q==
X-ME-Sender: <xms:ScW4ZxENUm88C7-TkqGE9YKZhyx3L8plkXPWCP0GOy5HdApF5MgV7Q>
    <xme:ScW4Z2XyTi-LeyibJ0QllvMTa5uHnQgJ7n_cBOnmJfWq0-jHhdFOVt2UJv1zmKghx
    rLo08NKMwSjdRwyOA>
X-ME-Received: <xmr:ScW4ZzJL4BSL08lnL4YRl5snNYG6aPeLmL0AyBKSv45FTN9n4R9rKFHGOzIwxw5avTnXyko4bb73hU6hJfnJAkE5kPvZWrnvJkRGVw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeef
    hfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtohepvghlihgrhhdrkhgrghgrnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ScW4Z3FcClo3_IiohNDDKyx2AmkR3ln1m_vfuBg7-1BkgKJflJR6Qg>
    <xmx:ScW4Z3Wm5heyFn8QobGmLUQlIgIA49wWvrAPsez8hICpke2JESt6lA>
    <xmx:ScW4ZyOahNHVI-yTZAgtaow28p9UC8Jj_9sBB34gLY6DaKEWMUSj8g>
    <xmx:ScW4Z22k0jzsvtr3ZPFnYm1GkoZVGHa4stqyJL1yq6XuHQz3lZNvcw>
    <xmx:ScW4Z5LYEN9KqBuemUSVGPpQUtUKNoFHW4BuR4T7hUYyY8DmD13v_m_K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 13:26:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>,  Eliah Kagan
 <eliah.kagan@gmail.com>
Subject: Re: [PATCH] compat/mingw: rename the symlink, not the target
In-Reply-To: <pull.1864.git.1740139296483.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 21 Feb 2025 12:01:36
	+0000")
References: <pull.1864.git.1740139296483.gitgitgadget@gmail.com>
Date: Fri, 21 Feb 2025 10:26:15 -0800
Message-ID: <xmqqtt8n9mt4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     This contribution just came in as a Git for Windows Pull Request.
>     
>     Granted, I have not yet managed to find time to upstream support for
>     symbolic links (it is in the pipeline:
>     https://github.com/dscho/git/tree/support-symlinks-on-windows), but this
>     patch still should be in upstream Git because there are other ways to
>     create symbolic links than by using Git.

Thanks, let me mark it for 'next' immediately.
