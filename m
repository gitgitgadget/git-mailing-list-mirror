Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666257;
	b=Jf2HMNco8KGA+aUfOpYC2VHLfxo/oOijWjsXipmRUBl3ATO/RjauI+fDH49F9TTodOul
	 dOJn6+8GnPm095liQJu6OHLpfQ6slNpkWXtVJ0Q0nFINIxVUFhXsTmT4VdiSjX5lwpZHi
	 qRkvvv2CFsIfp6gL0sJGlj6C5ItB0CxSn8bz2nrXvraEFhQTFsT+jEhZyY0vq2ReR5lD6
	 Kvx9Ilu/m8dhmYL526LgL94ENlACZzA0yr3bBYTaZn/r3z3sJavWDN4zMq6Zz8LO1UR9a
	 BaaJQnHPGLj7jOp28lmox+sHrySRVONmPOutTLrUF0KcTp5VEs0garvUObvbb1E0fsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666257;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=tew11t95VRZF5hMMNvDfBJF+bhGc99dO2KsFKAfQsfY=;
	b=hDnHqce8ac8CteoLufTRv3skwKLdxeflSfki9lDty8lmQ5MIQGqpXQ7qCkx+k5+b50MA
	 81NXxLDd+dBmtQYqYyrTp3UKW+ojMaB0t/rg2UelKYvZ5HCAcxKSvya1QjMeAcMP0bfAn
	 tajtZLoVkSObvemCNdZi86mSHxC5ybmGH84t4UbdjEonujZcZLT0xdEN84BHBiXoQfJps
	 i7v4OSZBZoxUJXw79QX7g9ZLPl3cWm5V0q42/E+6W6NaX9QSbp/wl8TGsxyjTsR56dZFS
	 +3KLrNtzdKq+yjDkg6pC8zP8vZYLlfhiE/n4RB0uN4HZ/zcvX9oXh6Bw8a6Em//SoRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=jwj63HmX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=O40NuMG9;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D1606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 00:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 054D1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=jwj63HmX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=O40NuMG9
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F563EC08E2
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 19:37:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Nov 2026 19:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793666256; x=1793752656; bh=tew11t95VR
	ZF5hMMNvDfBJF+bhGc99dO2KsFKAfQsfY=; b=jwj63HmXmbRGOkGi+WNyfG3aMx
	usIwUvUX+e8b3iftkBcYBmxJjD8ElV1TKQS3nKLfa0BqLCgF5jA9JtY4ZV1ssL37
	wdSmYM5u6T+o7COw6BBz7qBKOBJ1rcRBMHIAL5hwurxj9SPrlrRubV7yHfcaZJR0
	fzlpKebCFzuNz5zqA4bYOkkVk4c3/5HgV7Xb9pdn3JRsTQey4y5ve7Nkh+7q+sxv
	iybTpzD2D+MhQhEJRXZxrR0MJ03KHYrdKWALh0oafUz6XN2MEakhXT3AKu0ftG5v
	q5o4tgjjMWMjKbls2fiBNqiGkYLBzCTvVaq5encE1g3IU30Zgvjp54lPvx3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793666256; x=1793752656; bh=tew11t95VRZF5hMMNvDfBJF+bhGc99dO2Ks
	FKAfQsfY=; b=O40NuMG98ic6kzf6rUbY+nafb0SzjlNoMqTd66g9QO+yPu50xRQ
	aYvnornOIntMih5LXxEZ27QIkvg2QR3njXNS5X8kpc1PW/IIouiF7pKcjNxByqBE
	JWC8Y/f6COaQnrbbanPlR5QBAVVIr2K+4DLDo4BvKGyjDBHGmy9Rwb4Jxw8y9Ohs
	oDRokYI5VaFWTho/TuaKrQkpJOl8wJ2YtmwIDzFjQBfyMabsMt4eLt06rSSf5JC4
	so2HhxiFhfE+nT2YqmXLv+0tuuSbIlb4m5lK/IGSoVhQ19LNrUsHTJcXyoS8hNxV
	J/QoGCf6EumYK+fT81JOEAYserKpniUCJfQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793666256; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YqXEPSnDDMalt8u77ttuW9I/kbNFaO2LOjv1ema0gEI5+ak
	/B/W+0Hy5r373vXEPnweUWw76dgnesh28qFwmUHrvh8OW7pPvjk+czVTtPTs6bZf
	2IBc1dqSmBaJ2Tsa/dVY8uB7JLI8gjoxjDT4ANqgb52hab4wCi48Oc2INyX6pbzi
	60ryCBNLkJjmWlYH4p0DwNfbHe3T35FBnbHb0NkTdm1S2+SuIZsU8zqqW1tv5l2x
	ZL/k+BmctXwIo7nAichdI9ns1ZpJGP7Py74BSQ/O9PIwGePrDdalh/SiP/LY+CUz
	DmpsI64LFi6PjV1jVpfFp7a+zr5CcGnlOFrnt7g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:VytFest2jS5GvS7Gs4KwTdAgfGD1REWppzjkVBESXCY=:wbhDEa9+pCHzfMIJ9KlmvLBIh58WHYOpkT5rv8EuvMw=;
X-ME-Sender: <xms:0CzpaoczzKebriHBbv-zPhQPXKZgxo-NwKoK6ky3RFRwJNTcu-IsWg>
    <xme:0Czpasc-f3k_As7NB-bSD8eawVNyCMY2Zepg2o0Sw8tVN57lxqWsuTRfUhCtLFqVK
    _0Ow91PkkxB9afU4L0hr48EuVX0yzG5GcyJoJxBFgLR5Poi7w0ATQ>
X-ME-Received: <xmr:0CzparxgTGrjDLIVlQcePGAoJcbYjYO0cQ97tZHS5dc0-2DMAgmpB2oJp3kAECXssQQBAPWIeWw1-4KUvBjvWWqLCUen1h7v58KI>
X-ME-Proxy-Cause: dmFkZTFoX3im07Cli419gQ4dW6rwvzsE/SdY6UlF58l71eYZ6GbbCDaIEb6g8PYY7jDehr
    G921YgMmjHsE2bJnYBy/vrx+84fW2UJOqHP2i4l56+n1p7AEEjkh9YYS8HPQk6W25taiDg
    RcIWV3SD6AF0ABpbP3keI4J1/S10uPz0M+dzESsX82zFuG/8XD1lhmT0ybys0ZWmD/E8HL
    ZB97++db5/rsDG3SFLlKWTyFJy2q0pIlt2KbYi1dW/nWBIHWVQvuE0U7oWKgRlTkhXRRcb
    MIuiL0f7XFKOEg1KQAM9tU0pkOXAEh1uvXBwo0fPjDxTFn79xRIzsyXC8sTu22uM66UES5
    gsnVlghyaQVXhePrT/zaLGrZuGWbKlwwtC2u7RBcggmrzSfL/5+s1XqVwm5nviwNVbGFuO
    vDhOEk3cKKUxCUwT6hofFZWmjnz1K2JVUK9Shg92FtfoaHXSs0Wk9rL5pPF11Ow32dSqbc
    tKlTdy5xw/CEQiplbQHuFjkMcI2U7sBLlLuMQ33jJrBV7x5UvrKIyRByKHubxAWeidhGV8
    zQvrZHjhxu4BaYbsCrfyar4AyeUhkE2yKtTacL8pHtZckZ7y/LSbwvLct2hB3P1+Je26Yf
    vW5EARDl6K7XrvPd5m18yY6cxS+KLoGjQsRyCKzXCXBnS+tDqQwKiSEOKVbA
X-ME-Proxy: <xmx:0Czpaj-GbaX2XaAwdaCQmWlDh9slifGJlZZb76Z_0jXGZv0v2zeKZg>
    <xmx:0CzpajiXB4LI5SCoQErxp6xHN6LC0TlKrn3uaE0TK_yT5RviKhMevA>
    <xmx:0CzpaqESBXkzhWMNC47u4S9sLgiTO7tNAoRi-WHxj-sUfnoelk7QJA>
    <xmx:0Czpai_wK1TWqp3h-qtO9xq9vWB7ZQwErQhHDI211kA1vkNBxUS3FA>
    <xmx:0CzpanelttZhkXEkf3tYt6SgPhDENs20VzTbP3x2ut2Gorsv107b0Pmp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 19:37:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  Justin Tobler <jltobler@gmail.com>,  Kristofer Karlsson
 <krka@spotify.com>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in
 the quarantine
In-Reply-To: <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Mon, 02 Nov 2026
	11:45:33 +0000")
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
	<pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 16:37:34 -0800
Message-ID: <xmqq1p92g375.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     Changes since v1:
>     
>      * Changed the rule to "an alternate that is ourselves is not a source
>        of alternate refs", as Peff described it.
>     
>      * Added a "borrowed" flag to alternates, set when they are loaded,
>        which says whether they come from another repository, and used it for
>        --alternate-refs. Our own object directory is recognized either as
>        /objects or as the parent of GIT_QUARANTINE_PATH.
>     
>      * Documented this for --alternate-refs.
>     
>      * Added tests for rev-list --alternate-refs in a pre-receive hook, for
>        our own object directory set up as an alternate by hand, and for a
>        quarantine outside of the commondir.

All of the above changes make sense to me.

This unfortunately crashes with Patrick's odb-reload-alternates
series, but let me see if I can get a reasonable conflict resolution
or if it is more reasonable to ask you to rebase this on the other
topic.

Thanks.
