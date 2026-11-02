Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611877;
	b=BvJ4Xmk5blbMu1w/MS8db0ZwYOfxbEVVlGAeC3tEc9mX9qEiTekCdqDsdXigSDs9Skxw
	 uMMo6QYd1NADZvFDbQvvwUCesVbMXA3iVfhVQ34OD4qX+xxowDrd9AIVt+EmEN2eAs+BK
	 fNDhZUwfA/adqGyaoBWmQbgyKlg0ebKa9nW69eMBnRNOqryUTL4r1tm7FrIsp0X+/cTxK
	 9BCXNvVkVKCt2P8Qb0Fl074u5NFPg/II4dcMnVvWvKoydX2cL4/NpewaPiIdskVTELqK9
	 1NtYk/MoztX15bFL8WSiZ60Ord5hZXsG97eGta/xrjPqMD71gu5rd3lGLzlWw9E5llQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611877;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8lLpeIzBvXN2dKz9mqQURjG1EhOxd7bBgQ5jpe/U7kY=;
	b=X7AeWVQwidjMpuBVzj4OKagZz1ALwgSNDMhzEoLg3TaYQQ4bx59f3L66sIfKaAOVLSXu
	 QtvPlvsm8e8SgljS2LKvDiXpV0od2Ul6sfmENsJB3CwIOyRyCPYYXKEJo9XEEsI5kabYs
	 Q5+PlhMNziJLIh2Qa//ShpTB9M6wXvQfhHSnkBrrCblEEXu9qhFocSfd3JqNFqYsThoxa
	 dmkpO+BNMwiw/Nuwe5SzI/2Sbl6jYqiE8gUyj1oEgU87QfDB2l2J1wxQhe0S29Z9n5DWF
	 W+46IG2ZuCUAFCAZPI8oFGYMf4w8QtyGdnJhHLIU+5aQt2RgyeDZKTTAoLckavkfhwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=U2bWItTP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="KWhQt/Kw";
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2C606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89A2C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=U2bWItTP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KWhQt/Kw
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED79C7A00F7
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:31:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 04:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793611876;
	 x=1793698276; bh=8lLpeIzBvXN2dKz9mqQURjG1EhOxd7bBgQ5jpe/U7kY=; b=
	U2bWItTPRG9ch4CsXqJsQOCWOHWypaEpy3aMnmfrOmQ/bkQRaiMWVh6+Cr4SNPec
	skS2G9g1Ai+kewkVb24pw1m9H+/ilGL9bq6XtfN/ucZYs8AEumG/wcQ/db5PheF8
	iLDOje/RURfsyILJZANbctE/KOKwKzyx5wtL2doKU3Fbdgsq07sON9W5q2ZIcs83
	ltGP2iKmNcSaoqTmjJZ2ZO8/U8wYiUBXUX04fcKLJNHHgPrd0qqZ6RM5ycocIOFG
	dzFomEFhpv6wa4y2Pg7UmtLwr0O25gUvs4Fy+1wiyXCDMEVleyvK/QJYxy7rwb8y
	VndN9aRQlK7CG0wyYdC+ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793611876; x=
	1793698276; bh=8lLpeIzBvXN2dKz9mqQURjG1EhOxd7bBgQ5jpe/U7kY=; b=K
	WhQt/KwW5ih0n9owl43GxZZXhM2kVa2wAS/NjuNp2r2Md1YsFtJYRDEw9US1iFLd
	cFPFUHWTdDcZ79WQGekW7gTDVaU6ifIcxbN96XmWvSZkFdZhbjf5iKloaRc/8waU
	mrU3OJOJgc/VaPcgAj0TrX0HpDWTv2ULCqSVh0sF0uTfRSCr7KPJRcc9XUlRubPk
	+cgiRSXaU5pQe5izCXHbuAUm3fDpIhrsYJfiGe/ez/BD85CN8tDYMxksYzt3SKwN
	F40p97X+JZBPLnq/HtxxgggHowtc9592WQJ9iN0WCug1RoUMWPwPIXr/+uN4YFkA
	NylYPlyzN16FlkLYZ9Ikg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793611876; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:anEcViuyM6wdkoYF68ukl2x580YYzr0ESZUMQ4glZY6I41I
	x3lIwZh8d2EgrSoD/NYg0AGeKZn1uHJhBBNxSsf0g73iyZRbH0jvl4aowE4rkILV
	2AWRy/2GE3omWAQVRZd5kgHpoKD9vtbLltZhIM9x9rb7pNWkfRPoxO0HfPfFZ9u2
	/RWNLef+AoWzf50b8br+CPr2PTEKtSu9BpX27XG0pdMBh06gqW60NswRBc2mRkV7
	ngOIl6yPMuC7Q88tnebrP7CWwc+H49hOJZRDLcUmMtRDUDDl2ggWHfMgQ0jYEytZ
	ZcpjAen0SEnnJ0PXj5BgIfs7iNkbGXUnl6oxPZQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:5Fh66BNa99XlJY9MmzCs+WPdOnUMH8gBPYFwfDXmJzs=:XidPQt888Y/1UgZqi1wrvghD/Cj14EEUTSnlVKa40fw=;
X-ME-Sender: <xms:Y1joave3sF-X2CdnQuF6zuTvm6GfLQNnm9pBqqL4d5CetS7pbwPxuw>
    <xme:Y1joandCCEz1AOFpxlwFpTnPpefc7tAqTrsaXQqeURWUP29D8AQHtZKZK_RY37XrC
    LRsMMmsykCv_SEBydSYD2zMtCZ5oag9TSkRrnMah3eMC5zuVVqUhA>
X-ME-Received: <xmr:Y1joaqwSMy6mey7PVPIgfNs0rh4muUr3F-88am637Zb84OvYGI-VBpU2kOxmUW1VX1TnFe_msun_gz6JAFUQJvzZ0N2tawDODWEU>
X-ME-Proxy-Cause: dmFkZTGbS6lZHyAuzodUwCOyC+Dt18fRyBYY1LsGkqH2V/9zm9PwE4oVHbKqXzUPTFF8HD
    K2ERNYAI6ZCOs53pGgf9s7EbxMT8wHtjeqbKUY8/Tj7lt1U9eswGCxq3v7ZyZlr+fS4Tkm
    Z/HAn6y4CXNcarg9oiINMmsdTYt3nQvE8u76XoLRwktmce4XIyJkF10W1DO000YNuLJ35K
    YJF1ILg0kfYHuJt00/3l3HUEFFTU/Z4wyRANBaYHUDy8WaC4jnfZQSYxGntPaS/lWgLx6O
    3GG6omP515U/eJ8m3p2k7Y6DLYbzuZKcqyHM5B7B2CoTHwM0Y/B9r1bMjKd+LbAFK9ccc0
    WJtmaN6LHHL4ZW9EImCwgcN/Rj97KEx71+bc8f/7OL6JbTGVr0NhOQdCSY23FHhjQ/Mrc4
    haTx26iQYjS0r8zTPztqbN7+oVX5q1ovLm6qX/HOJ9W+jsqOtWCj9ebPT63q5k4enX5+4+
    lDAM/0G31d4veecCLitcpc2C2DzfqD1+Wn1orCpU52rgvdgLYygHXcKU0jbpBjqVY6WTfy
    uWPycCwruW9+OYBGq/fGnZE0BBAlvzfolNXSo8BdRzexiAE6WsO0zQA4IadKA6frTxGT+u
    aiD6PJ/3ZBBN3BfAqmaZwkJH74i6M+UwTZYow5xPMyoUfDJlSOlRo/YpYMDw
X-ME-Proxy: <xmx:Y1joam_pxHtsfjAfFLVBvmlwGeYmSTncLx_HLsdrE-mgEsMqPWcRrg>
    <xmx:ZFjoaqjymVi3FlSKPVhwzKImqdTLXeoSQLNyTZntalLsz6deAt9Hmw>
    <xmx:ZFjoalGhvL7_M3J5zl_XIGxo1DaQwk0luRCi6-uzSAAyW5mZ3d7gKQ>
    <xmx:ZFjoah_RxReUMvbEvATHzaxDK_1kpOcjs5thxAVRPxwbDL0a46Ay3w>
    <xmx:ZFjoatHDVNDwo0WIBxiGm7MfmHYuLYiJ4OuVukU3CUjE6RVBaLB6JQn0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:31:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Daniel_Mart=C3=AD_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>,  Mantas
 =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Daniel
 =?utf-8?Q?Mart=C3=AD?= <mvdan@mvdan.cc>
Subject: Re: [PATCH v2] credential/libsecret: load secrets explicitly
In-Reply-To: <pull.2372.v2.git.git.1790549181518.gitgitgadget@gmail.com>
	("Daniel =?utf-8?Q?Mart=C3=AD?= via GitGitGadget"'s message of "Sun, 27 Sep
 2026
	22:46:21 +0000")
References: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
	<pull.2372.v2.git.git.1790549181518.gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 01:31:14 -0800
Message-ID: <xmqqpkwnlgv1.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Daniel Martí via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Daniel=20Mart=C3=AD?= <mvdan@mvdan.cc>
>
> keyring_get() searches with SECRET_SEARCH_LOAD_SECRETS, then passes
> secret_item_get_secret() of the first match unchecked to
> ...
> An inaccessible item now produces a useful error message instead of
> the assertion failures, and git still falls back to prompting. The
> race needs a concurrent process or a locked keyring to trigger, so
> there is no test.
>
> Signed-off-by: Daniel Martí <mvdan@mvdan.cc>
> ---

It seems that unfortunately we saw interest or reviews from nobody
since this v2 was sent.  Anybody interested enough to review it now
to resurrect?

Unless we see some volunteers to give it a review in a few weeks, I
will discard the topic out of my tree, as 'seen' has been crowded
with topics that have been collecting dust without getting many
reviews.
