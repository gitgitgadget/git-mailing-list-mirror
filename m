Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258403;
	b=UndtX/YxD1hcaYq3pT6mAnu4x8m771BH3xh8WrbNOWIVZCvStdg9HXtMkmC/JhMRIkZY
	 ef6gsptu1Lmfck1IOsqmQJkd4GQabQc46q3puB4f/AJ6eFyubkYz0g8DhK2NEzXAXPPM3
	 ae7pIrn+mlZOJhbQmF1zZ9Mk255Ez1mPovl+pKoGxMPYjH3mIb71Orbc3e0PnjvlcWAx+
	 Wms/apWkVmeHsRygXlqqy4hiVfjAVQvmNxg0obFYaEejzuPVHfZVpkn6IiaLTgF+VezXn
	 U1iqHHV4DDkgvjyX1gA/VBzPj58ta6yNrmBtULduEnvge2NjEghuYTPSnmes3gnoHEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258403;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/VlDh3xzCK+lzpNo8XC7ZRp61lw5r4F3M/FeGgRvg0Q=;
	b=x8p/RYRLeCszR0nQMei7uTqU+bpeEyDZvXvIyhiwcRIlaDJBLen2Jo5lm8MyQwfV8ZUV
	 xk/b6r08WxlzMz14RrC0DXAw2bet7o60HGcQH9dL6yXgZTr3PUBz5sOGSRmH3Ws/5nreg
	 Nd19fpdsBsdqfhYR18/ePlOO4c5VCh4pXx0FK9kiUIx99c5LvtzkIP5HiMRpbrakIgTC/
	 n6FFIVTM44oKbCZ9wpmtj0t6XXfFdvKqadGp5Jq8e3CfdSWXJ2/jLBmRJZZXA8nC/uz8F
	 jdti1KvBt8K3pwaPx0LBHGn7i9G2x8gcAigH50aH4JInKJ0ctc5u7pE2cCccbSKN6mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=gxkru2hR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BCJJD82y;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A9606A330
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 21:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 008A9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=gxkru2hR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BCJJD82y
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3AD8414001B5
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 16:06:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 09 Nov 2026 16:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794258402; x=1794344802; bh=/VlDh3xzCK
	+lzpNo8XC7ZRp61lw5r4F3M/FeGgRvg0Q=; b=gxkru2hRT5oe/owvp2u/0yev+d
	MN5pPE/35WbPCjpxZFjErIuDWmqR6PEgB/eBeMlad1PP8V9xDSaml0x+lnuEpcrC
	U1nIJ9CF2Nm2aatFZ0m2ZVa7aNI6Mu86/I+q1O5isaADte991F8jDf+YOqD+XuWE
	Ju3txng6eR5huuI4WRdtvGT2dX5ROfCz1W8gCUMEpCLrMCSo6pxt1CYJaUvs+LYJ
	OuJdN5SgOY/WBRhRsTIyZaWDp02TO858R2fLV9oHSTlazhtd/PY6cd997ngj2wsq
	ZYSslK9CYGoJCkGASGXVsbnBclyN0FyZOXtGfs+oxku5EnQA2M+fMdod9MdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794258402; x=1794344802; bh=/VlDh3xzCK+lzpNo8XC7ZRp61lw5r4F3M/F
	eGgRvg0Q=; b=BCJJD82y3tj+FMXPt+Qf85C7RD8YanP9sLVzIy914HCsmOCe0sO
	J6qCp8Vc2IcNRH28xNDwXUQxek2NDZ7WJTtkWyaj5eftgC2boM2I9I5dfLDTQvnO
	dVxf5XkziDaosNXm/MPSfe4bPMNcfBVul2H+xwdtjMJv4eDVELJTUVb8Djw4ptCE
	+5usMN/Ramwztrcqwv6GfVfnVkv6rYheHWPf5gVePjOZGdTkxaNgOW01B0r9Pa7/
	MaNnJvMUCnyBGa2I6QHB9ZgJx94l2r8jEV8Wg8etgNJId9tgdxI/DK/g5ZrGD9SV
	b6q0Bh5i6U9lyB18wwvJKnbP7VQdG0D+OjQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794258402; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Q47M1bYPwac9w03sAHVvFgVqD2Zcs+1ca6yvDRb47/KZq/H
	bh2ItGTcN/FR+vPZBCZxIrEN5lyLX/ktbskVH7bV4h1/fpjk4Lm17gcbNxh3fxDS
	Cl4RiggCV2BMKd2n8lpBaYT4khzqdIGWetAt09Vvb1zPJ4hh16QSUiiyZWW6l92r
	oebsRzd7zVSjqEcYXmOf4OYBwK+ZU6B41WgG17V2YqdXQztZT+tiltIiTTXP47zP
	dfkR0bPI6rLYE1yay8NF5PomuaAaVlZLGM+7qi5YOwc4+7gwtL1kmPc1DQDnNhh2
	nhaBRQaVjVeV+Fy6qOCX/a5S09RIveNm29CmyOA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Aj4Ff/CZpNWVBfc4hKDPM8yNH2IePfpt8vniGFz1e4E=:siJHfgGgJ206IfOuMXKE/MEDOK7avo2Shj9YKcQRRow=;
X-ME-Sender: <xms:4TXyav6upkYLXHGyqzyNQO7AmTfqHgGBst4D14a1b7jH2A5wGLQT5Q>
    <xme:4TXyap1r5Xnc2DGuOrebo0KZyHaYo6_WxQNuy5h3XRFvEUKFVe4YdGk3glrjAnfvI
    mcAE2It3PCfqzP76zVEdsTGItrAMUkfyHiHGQYinaWYtQRYbzRfyw4>
X-ME-Received: <xmr:4TXyaqsPmuGoNke0u9pS7FI3umq6B-biEKgu2dguv9EgKYWltKia-wgE4_UPNEhl9SMDvzWZk20xe_6PZ2u1Y8KhbUBJje5CM6ro>
X-ME-Proxy-Cause: dmFkZTEvhMk/nX2K1H+DZ2Y9uKStoxws94u4ducm/0wyOYOKOASZndAQfIFaR3S2mf5gG0
    3oxo8gB+WedLxNNFF+mFVGl9deSP2pUINEl6hp1t7Np4raBwIflf0HdmpiowWShZwczijd
    IKcIjIYNbz3BBa2fjiaKPo0WvKpuaGY4ounZvZJ2Zdn8OrPvTQURcojmJjLME660Rfzc3L
    HyhjJkfKL1zlEAcXfXyy/ZLriXKfZx9z/8pBN7CgsLjm+TPP0KiWZ3VK3s6gGMtHL1IF4q
    8E6766otSVvSniC+QORX2xqQOdpKY9gIR3sz20x7Us4ydoXfywBDJlLD+5OwPMyVsz6dHY
    /pLWiuwthi2LYiDfT0gKumXyPCrqvgs8XV20+i1pF9ZQgXNxQ2ZQOhGn4zlhATNzgOEIKQ
    lbpiklYaro1oD1CzCWMaetvbfxPYjT99K6rG6lndP12vNhXfFtYCk0zfdQecabvNBzyZZK
    dCd42sw8hH37SVyAOhdjggZFeEyJEMjO3WuiWaqrBRJUhUChTTV5GYDTbw0g09OPbMvj5v
    5GMbI4h8v40cg2JvqeLyODbw5dgkTA8/qWPvNfGdWr65DNBjwZWrmY8DuPX+c0/MeWPTc6
    RepNuaT1WKXrNuwVOZ/6KM7N3bBaXbkHOJTEi2/IUAMyPHoIe8YIUgEHSJ4Q
X-ME-Proxy: <xmx:4TXyav4D8kXHIcjYxYYHYAGWBdDJVUjkVWCuCSnLFVYO3cwhdF8_PA>
    <xmx:4TXyamfj0PKLYrLa23J_VYULpa98PlhDhLGSII-tATeADQpUY_6hnQ>
    <xmx:4TXyasxD_3tE12G2zwWCnwaaPzyikqGM_HdapYEU5g1CEr2TTTsRpg>
    <xmx:4TXyar9eT_77UXtZcaCDixKcGle8jPY2emtBT8XYI6vYDWElyDuyvg>
    <xmx:4jXyav8TDNHFNm0yYA7mRqXo71wVjQ9elmIssClXFzOdgT23mOo738Pu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 16:06:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tanga Joris <tangajoris@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,
  jackrawlings2011@gmail.com,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  kaartic.sivaraam@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH 1/2] apply: do not keep names from an unused
 "diff --git" line
In-Reply-To: <CAKrRMNrwEgv6JsWcd+UorLrKcsBgHV=UUvfH316hedM2TYGWqA@mail.gmail.com>
	(Tanga Joris's message of "Mon, 9 Nov 2026 23:54:51 +0300")
References: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
	<20261107195429.96842-1-tangajoris@gmail.com>
	<7bd3360a-fb96-4631-8670-dde0d281532c@gmail.com>
	<CAKrRMNr5VJmvws0asHgmDxCNxo19ctGTpM2eoTMT3iQ5v2cagQ@mail.gmail.com>
	<d5bb8fe0-7706-4e3d-b471-ad004411a9ed@gmail.com>
	<CAKrRMNrwEgv6JsWcd+UorLrKcsBgHV=UUvfH316hedM2TYGWqA@mail.gmail.com>
Date: Mon, 09 Nov 2026 13:06:39 -0800
Message-ID: <xmqq4idpyasg.fsf@gitster.g>
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

Tanga Joris <tangajoris@gmail.com> writes:

> One thing I noticed while checking this. "git format-patch" can
> produce a "diff --git" line with nothing after it, when a line in the
> body of the commit message looks like "diff --git a/x b/x".

A garbage in the commit log message does not count as coming from
"git diff".  It may take some effort to teach "git am" to avoid
feeding such a false "diff --git" line down to "git apply", but an
important thing to keep in mind is that it is NOT "git apply"'s job
to worry about such a garbage input.

