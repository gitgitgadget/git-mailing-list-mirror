Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293604;
	b=RNsZ0LtCqC+WaKvJqDP6pcF3tl+5OdsFVdNNWgZB13BB66imMqFnAEi1pgjJ0J6kR7G5
	 3EJczm0zoQet7FWXBAmxwNTZj1i1DgoWqGUA90uV3yuns1rTLuXnYX7TgrOF9vMrCEsbh
	 gow/jJbz9Tzws9U9q9qxP6D7cHvNuBuc3XFIsuSBz1XwmW6rMqQI2bPmx/XTQphecWXzP
	 TQuaI4IPAu+iwYbUkP2Ka4pVwhno1zi7Kh/Udz5t73oegL0pqLCNm9UPQqlkLul4mcKxD
	 fXHf9ab+0tEGBP4eeuMdNE1z+utW/tqbM4s7YGgqDiKnBiRZkTz058XOr5osNsojH0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293604;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=WTZVQF0hKjzSZmTNtb2PGXMX2L6xIBX0qsw64R+6aEQ=;
	b=j2jKx+s8X7zmVYh+HxM0V4EO2GXVzEKg9YmeTZ2prN4R3nvmkL3axn1oI4g2kzrKSeP9
	 Kc0aRLvpcfUOplGeUryhnlOSZQXTOmm22xMiPg7oq+WENG+U6ajKfyGrMYDEl2gOB3dMN
	 QH0TMR/iQWFWMK2XUxEZUE92yjdim6T9/jZ4BEybcEqLDHNxPuB33lq5R+68Jr1564Dyq
	 k30C7GBylBPt+v7LFZ8AWw+5ooXpGcdE90ROaueS8v9H9mdxldBRyDtjXZSWA/tUls1Kw
	 Z2LwVrmHQ0NwZu/iXWR7/nV4j3quy5zWAGx6ZfGa/jGvj99sthknBCracDitun+WbQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=J6prCEwB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NAza+v8+;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F11606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 06:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1F11606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=J6prCEwB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NAza+v8+
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F52D14001E3
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 01:53:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 10 Nov 2026 01:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794293603;
	 x=1794380003; bh=WTZVQF0hKjzSZmTNtb2PGXMX2L6xIBX0qsw64R+6aEQ=; b=
	J6prCEwBC6AF8Jl74ujI22pjzPFUj9w/VR3wfVoAjeP9/Dx69XG8sy252IaMXwI7
	rrz/Bl8bWQOMPHKccSnOkD/1l2PIOgVJA08lzUkJ19eLtaRiLTCUBPH41L2zcS6e
	XXU2EkqVtm9Ye2fLkn5wuebHQ3FwrPJDKnffJy4xUDyCVSvFO0AxeTERitivlZH4
	DZIFRqc9Y9lMEPeeceYlAgwTemgA0EE8966/coG3REIB72aiUTVZrnl/20ngtvPg
	O7u3czzvFl2ZRyxm9t23rfpZH7iFsReZEZB29z6GGukjjlkEpytkpZ5uEH0TfpoG
	CeO1YzehlAG9PGovb0Be4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794293603; x=
	1794380003; bh=WTZVQF0hKjzSZmTNtb2PGXMX2L6xIBX0qsw64R+6aEQ=; b=N
	Aza+v8+9xEGWsJsSqd9mk0XG+V0aOTaorjUIZNWWwWxQNysOvdFutQTd19WW1z8/
	cfhbD9nrmokg+Ogk4OfnQsTB7EpjmYlbjy2YvTknF5ERDU5B7McPlkYHJ3VD+I8k
	WunDa2nZWe+MQgFtI+goL1aYvKr/av2e3jj2kI7CDoTnojyWIbnUvwmKpKtu4Bf4
	wH5mbUHBrHRPOa+rrOfo1dWuIvVf7fuzmzhEvzaGCUZ/F1lePWPTJZeAiSWNZDUo
	pv0OlOtCp0tiHIynCNnd+BuoH+9tmCkJxb/Ah0k0RgO/4WJ9o0ETY9ICy2ATenBd
	opkFMHSyu1GaiWGW7+hcQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794293603; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:QCzC2Lyg5i4jklmlelj30oUnm8HHg4kxlkbp6m2WAYtz88r
	5ijJy+D1G+PRfWrz4CsyNb7gALuBV8dcpQTo/9TtyBp7wo94cmmzPzrAq5QzH/+L
	ZxnF3Ue2OCFrvUabBNXmsBoYosFso1OXuVjjL/ZCgaxu5N40iQYFSldbCbgaqwNu
	hYVKBAliXO0+Uiyrdbh1StVZ0h/wcZSzgbwhlnPvfOxqQMjmjogbIzHz6sEJTZFr
	ePjUe1s/1YOUmggYmOU1TkUdkVHFmLEgGfQHYWuVOkTRWD1dAZtrpLCdeLAhHvot
	x7eVcTCvITBMumw8rLBlPT/RfdUxjyKVVXf0hbg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:OMqL0XZhVJbH0PN7hE7swfeTpwJLwukPt0cgRm7w7nc=:Ss20oR3vb8N6iVQ5sQpRaLD/6d+rpqn2t2oIEbqqxs4=;
X-ME-Sender: <xms:Yr_yas79frb2_6ThDCKWdxeHDSvXqfRbvQ1vf0NM0OZkPpnZoBAUmQ>
    <xme:Yr_yak7lL831U4rGTTozp8qCRH5ugwobRwBWcFzCcnwcPx2mx6uftIjLi4E_sxAqC
    RQCCZsZNa8e_aM83YodjFNhlLSI4SKHkpamPIO3-Cs3E86EqgzXkQ8>
X-ME-Received: <xmr:Yr_yagfEOtsi70BWo0UekAfoKX4Z9Ea6AnFsh84uGrkZwpqo9dGUvEWFJQEkTT6mePmayQ>
X-ME-Proxy-Cause: dmFkZTF4iwbXH8YXFpB7GfOzztCPYQfje2S+9IEFkr9swnjiJiv5jAeoyVpbU5zo8MFQxj
    5QQbn+RK6rEVlp9t4fblj/ORuS6rIeA9BqTWaHr6Vhane9A8CLs+gsFFiJ9+/Tpa8yEMrj
    /1TKz8nRLaa4NdMkBLk1w40qgwrEqS+4d5wjNOFgChvt/oAXlMcMgxsKjbe3ElopS9oWgW
    yC7XFb3qk+g/Io1kNOEz0sRp7Hr7BXMMOc9wSmOpXvJJnuyL7IKLaqVjzWxWcZanrSDWHN
    7M9RCmMrm2i6w32xOtEOALOQQZXzXdal4jvogQ3epe146QNlAI6wQZvDt6sGDsRb74Cgfj
    NKhsCeNP/jojcGCiHlRaNBJ0W5uIpeHqobMKV5yzK2Ltoq0ClmJHpEU38I1q5HukYihxsB
    qUUGUSz+srVK296nNpBiDRwVyf+3bu9QETRpYXwRSczrpI7hBJv9hQKI6+ec3pV8/xJyPR
    bNbI8k5ZUnitAP+HVo7TZkvqRq8eokkKD5RBtxcwdiR1MzdUFazntOPN+5rjz5hg2caQIs
    gQinOPnN92QtMSsY4dDHuXDGzax4ksrHbaPMX5+FK2mha5kqTyr4uuJCtuXes7OekhnXXD
    eFl8rjCIDmNbAY2NKXDFUwn3bAhhMx1YLSls6VniD8T1lU98NshZXf+OkpQA
X-ME-Proxy: <xmx:Yr_yagDPt8Vj0yWtd2ENjK1Gewag6s7oMdAI3cLYaK801Hw4iopHtg>
    <xmx:Yr_yar9YftTqe4X5hmuvrfrrYaTelTKNR_NMKwfFdOxq7kjSPmDDGQ>
    <xmx:Yr_yajKxMb5q7jP1qiRRmZm2yL4zK3JWm2QvFGl1zXp46doUnHgR0Q>
    <xmx:Yr_yashxXt5s2wJiCtsOX-xG1Y9aMSbveFQjOFFYMHeWWJ-j3d9-cA>
    <xmx:Y7_yavxvce27gYCW1nAiqHcQYU_y92_ibdEiBrw5aTHn4QVc6_1pWntY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 01:53:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd216b5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 06:53:21 +0000 (UTC)
Date: Tue, 10 Nov 2026 07:53:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/7] t0027: cache expected output files
Message-ID: <avK_XnoZ7Asakg25@pks.im>
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
 <20261109-pks-gitlab-ci-speedups-v2-5-508832602d0b@pks.im>
 <20261109144651.GA14738@tb-raspi4>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109144651.GA14738@tb-raspi4>

On Mon, Nov 09, 2026 at 03:46:51PM +0100, Torsten Bögershausen wrote:
> On Mon, Nov 09, 2026 at 10:58:26AM +0100, Patrick Steinhardt wrote:
> > In the preceding commit we have optimized one aspect of t0027 already.
> > Another inefficiency is `compare_files ()` and `compare_ws_file ()`,
> > which are both called more than a 1000 times.
> > 
> > These functions will repeatedly generate the same expected outcome even
> > though there's only a small handful of input files that the expected
> > outcome is computed from. Recomputing those every time is of course
> > quite pointless.
> > 
> > Improve this by computing the expected outcome once, only, to reduce the
> > number of spawned processes. This reduces the runtime by around 20-25%,
> > and on Windows the runtime decreases from 480 to 380 seconds.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t0027-auto-crlf.sh | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> > index 504a7ea54bb..b021f0855a8 100755
> > --- a/t/t0027-auto-crlf.sh
> > +++ b/t/t0027-auto-crlf.sh
> > @@ -5,22 +5,23 @@ test_description='CRLF conversion all combinations'
> >  . ./test-lib.sh
> >  
> >  compare_files () {
> > -	tr '\015\000' QN <"$1" >"$1".expect &&
> > +	{ test -f "$1".expect || tr '\015\000' QN <"$1" >"$1".expect; } &&
> >  	tr '\015\000' QN <"$2" | tr -d 'Z' >"$2".actual &&
> > -	test_cmp "$1".expect "$2".actual &&
> > -	rm "$1".expect "$2".actual
> > +	test_cmp "$1".expect "$2".actual
> >  }
> >  
> 
> Nice.
> If you want to save even more CPU/SSD-cycles,
> you can prepare the expect files like this:
> (No, I didn't do any benchmarks, nor look at ws_compare)

Thanks! I benchmarked this and it doesn't seem to make much of a
difference. So I'd propose to stick with the simple change for now, if
that's alright with you.

Patrick
