Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319618;
	b=ubr390WKBx7uMlrk7joJNJGe+fh2FacwQenaowGTGDt1H9pd7Nh8jc9VgPFNsfpej8qB
	 QWnHYUxx9Iy0qmU79F1HVUl9RKZtBj4DlCpZK0M2FKCU/sFs63VKYwddwWJ+4xvvZJ3U2
	 rlCcrZMfcZmWZgjMi4OhcoHEgT8Ykzzahpg2kt2rvQHSHTXps8LArkKW9lPOUqdBKqbOs
	 t1v6RVFVXC2zRW/PMleyEfiaFw0l1BgzTj5pk5u/vlmVuci8UUAatAX730zQpAf0UqIEt
	 WiqQd/IzUHec+fjCIJiZd9b0Yo7gr6jjxgDp/uq1NKKwB1137boG2jjlnhjtj/8M65w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319618;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=uNYzDmysHRrA1dO4EZ3oI26nCmmmME8xrO6Q7AvyREg=;
	b=noAAziqXPbVWhlVKfNhn4d3UCBw22RVYqGud0cs8GXKt4PGgcY4WpGdyNsyhUz8fmoYF
	 3Ued40DNlatm48xkXRGgIiTfG5zRuWJi303dC4wMr/74f1lfzoQipitEPOYWX2SuggQtk
	 WPeqG8Q+r2dh6IJqqexWIQ4EOMWmhIG8j2skNfjfMB+kOWz+5IjjxXwiwq7NLS6xs6saz
	 f5gLgH5ICFE1v4lVpYizdfokvVg1k7qepjtzijgtOMif2WYUPNTSXel3UqkhnCQCXoVjY
	 X4/bymqSlcP9Bj0jw46MzE4t+RqVPiVMdElhcEKwCnZU+nSpWQnzqO7ktOyFPlYHlSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=uxXImWKL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5Du71bXs;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2146606A325
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 14:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2146606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=uxXImWKL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5Du71bXs
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B3EF7A027D
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 09:06:57 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 09:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794319616;
	 x=1794406016; bh=uNYzDmysHRrA1dO4EZ3oI26nCmmmME8xrO6Q7AvyREg=; b=
	uxXImWKLv8ETyc18Ky4uY8XZZNslcdkqP9CUWXbUYxZohBPew63ayIz2ctQlSLaN
	pkg+EohdmCsRDff2VPFlBlZSrDZ2843r71OJyZBou41nCrri6b7SRfopSAOVQ4Pe
	ZXRSomxF1Vjusz4UMldhHxoIN5uxRkiR0CT8nTs2acmYWIIjIC/50FhUUyZ9t8CF
	GIgyLXTgdmQjR1vbyUhjoG0xNuoP3ERxggCRAs01v8N5Ql6UCQfDsVTbYak1fGBb
	HSiSQz95aHGTZbeCG4rjUU81r3+eVpcB9fMspkW6cJps6DRVQGvxGwJOgWYkCUvy
	R2NHorXH4ts5PKSabnPdlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794319616; x=
	1794406016; bh=uNYzDmysHRrA1dO4EZ3oI26nCmmmME8xrO6Q7AvyREg=; b=5
	Du71bXsQ1RuPRBlZJs01BPPF1SmCs4DJ1vqkGebjVJxz0QA0Elb3F0Ui1r0mRy8A
	eJUXELNXu1iYM9eipIOXSxctjuWlUvsuO92DdJD8AuXPDgccAX8luPEln+XwSU+U
	3j/3A7nQVaWrwjc7LvclwcBC123wXWduSbuVDL07ZF4yqsVMKTZJ82xr5nJ3gC5N
	VMzOALf3Mw5tZEXPO0wTuxKZC9BxTqB0cS5mecnjvXHHtlqT7IZhaPpCv3TNcBxq
	zcbry0WmgaHoe0VZUusCz7Kwkv75Oi12YSEvh2xvfla6DmbFf9dENBHKkl21nAFk
	8OV4vIV86IuL5D99s5lBg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794319616; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:i0aPw2kpCFvT1856LNs4YCV8B8zK2KA8c8pqE9jovI+28uy
	ikKCLgplFWSxsxURkYV8N289nYdS/yyTeCMon37sS1z5GSC7iUFmmDfrAyS2eGPT
	LPAZBdlX0MUKqxkRJFeMB5dByjgG8R+fOY1IggHL/T6lsnIi45PwNCzU3/Z19Law
	Zhp1Y8yxRzSsRKp2ZkhpLKb8+YULuHyjSiNnCdx8jjOV3/DI/clAonKotY3Ps/3a
	Xt2iFaTuB5QFJ9LLAXH1c/epo+mqoLEEy0dMOt2l9h8TKzUYzFiWpqlS/RSnZLHX
	AV3qhcvJywtEfv2Y5izMWual72Y0dh5659PBJZA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Mhr5/0LzpPROsmVqh/am/pIU45TmJb6L2i1U8tJOF4Q=:84Hb+Y3Sh/GWu1awYnj5COgtDkh64YVor9l//yDWtz8=;
X-ME-Sender: <xms:_yTzahRUYmL0cxLe-HYmVSxr6Ww4I4xP3Sh6fB4kKfSuXirFL7BcQA>
    <xme:_yTzalmYZvEYtxk0AxhFklyzFRpArvWMA7l2tKL0WCxaIUgdhH7T0DyudyvPh0R36
    ZBrwulo8O_wN2fujIpxaPZb39XRyGjiIHJfJoVVa_xkl1drsQJTJakF>
X-ME-Proxy-Cause: dmFkZTFAkf310vePK5zxsfs60F1Zphqw5FkjE0k2D+ao3HhGbcPZnfqU0OHqwr2UjEfJWa
    YjT4IQ90i1Vy9FTQaeWUpP1+sS0iIZWVtnU/liayH4XOd8nvFjahMXpL/Z+HEqqKnKpYIp
    CtihxPwaGJodffd3dzY7mh+HM3SnnJOPz7B50RdQlojCh/4aPh/bDXDsie0vVJvPVHQv/N
    rti7HrhSXydhgAbAbbcjYnn7PPB6Kf7KNzZE2+RP68nm0btmweTxOK/QLgMz3bMJ3Vk6B0
    Gh0JsO6lxaNoUP0IPSfoKL2xZbsDHi/7OFioU9hZdL6m/8FVXnSTmqcwWVIju+nhd0ftXY
    GCX59uvYqUr9ju3xk63V7hljGfF/YPmVXueykUet/b/aARccYSTHILemJ3GK3WGmUldKyd
    HWTHZdh+yzqd5/48QVeqEB6twvtQ5gwynkRrGZzVcMa9iR4CV1d0IY0fW9vAyDnbmHcIBL
    0DIQ4FX6542N9cnLCisKRtMgS9UMsIXqGprHhggy9M8rJv6kRyKq7ehLWvYnMQCUiF0wqc
    XCiDByIn5XBM0szhE3FwVHxMifniCHczl1UL25M5h/h9i7MduQ2epd6FjLOBhBXvTcWKGr
    IiiX9OPRGFnIbFgEAe5yoQ/deA8OVhl/i4wwWhEBmK92rKXt7PBl4q+eBvUg
X-ME-Proxy: <xmx:_yTzahSQL9p8r0Y_6ev0gqLv_PHevXoUC0Tp8Hy9eFuMNkg_lC8-Sg>
    <xmx:_yTzaltvUlu2fwehWAWBWTFOBAaNaim1lYW_24beEtN3zxcVZpTtcQ>
    <xmx:_yTzal2iEZLCXrFAAdDFYRuEv4yhs9kGDa9nSBjxJzekJ561p1m-zg>
    <xmx:_yTzauWz61sATifBmG7y9HcKnjXgYloS06Y7j90gHF8iQolJf01myg>
    <xmx:ACXzavHrtvfxVtEssSmIk50SLBqppFUUFAl-bSU9kMW3DjHL3QrNXkS_>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9B4F1780070; Tue, 10 Nov 2026 09:06:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: Ai8eYB3nm2BB
Date: Tue, 10 Nov 2026 09:06:35 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Omri Sarig" <omri.sarig13@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Tuomas Ahola" <taahol@utu.fi>
Cc: git@vger.kernel.org, me@linux.beauty, phillip.wood@dunelm.org.uk
Message-Id: <eaa965fa-05fa-4945-aacb-2fc99b02159d@app.fastmail.com>
In-Reply-To: <20261101082230.141688-1-omri.sarig13@gmail.com>
References: <20261025110759.204336-1-omri.sarig13@gmail.com>
 <20261101082230.141688-1-omri.sarig13@gmail.com>
Subject: Re: [PATCH v6] doc: git-rebase: update incompatible options
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> @@ -217,6 +217,8 @@ OPTIONS
>  As a special case, you may use "A\...B" as a shortcut for the
>  merge base of A and B if there is exactly one merge base. You can
>  leave out at most one of A and B, in which case it defaults to HEAD.
> ++
> +See also INCOMPATIBLE OPTIONS below.

Elsewhere in the document we're now linking to the section like this,
since 2fc11e33820:

See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.

I think it would be good to keep things consistent.

Also it would be good to try to convert up all remaining internal links that
aren't using the << >>, I may try to do that at some point.
