Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803584;
	b=aRYe+IP6dEt/hwtCp5hGgfvWm/qwTb4+gU1cycBdhLE6LktmENhLIssNaiLxrTrJC3Eq
	 w3za6inZKyPAvS1+M6NyODhVVwU7SHjGzODmglZsOb0gtrqSF4RXczqUzuX88j0KFULER
	 k+Fl0Hna7BG7lFU2keqkMc2lLO6xXLfo8XPwqbUk5fvO2Udi/PpDG5o2aDAo8fRPC8XuU
	 DgtW9GuTHREicwJEwx1luMdHPfA3iiz1/bMWafVBNsNN2SQzocizD5zjXhDZGciqGvBAc
	 w6yFrOkXf4YQLy8C6bRad/GQ/NgnaHNKCvrqe12VKbMFyqEXREwfKQ7VTg6N79pTFZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803584;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TdEKSl+8ijRZhU7dEbZFwwq8lM7vGplGIhquXFiSnaA=;
	b=Ri4gSiO/yX6TBZiQOvGtrGBZc+rcxnsnRq1Uv9HsWDAHnvhP5w8PF6nS2avPD2++TNvX
	 Ehf9/7yUT0K1TEZoA9I11+pTcDEcU2qTCtUSA+BYB3TWLtmrbOOFllhLFb1BxHuDTe4bL
	 saXiWQIuZdyJ4HGFm8IXmwVdq0Wi0EVHWKanoBAmL+AYDl4W8RFNUl3h4vejGy6e4st+y
	 XSmR4wAafReTkUVtrPBAwyMQp6GQ7mVXjgOuyaciaVSdQsciqy+Fu+/nets4BUKe+gy9i
	 AOC9JSFBMShKp+qtYmh9RVvrnsqFKm972JG43zyzXFaRfnSczO9gtpQ3r/qs7gA2DQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=eVDziN5L;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=J11lQKMG;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9027606A31E
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 18:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9027606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=eVDziN5L;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=J11lQKMG
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D5F3FEC0C23
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 13:19:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 27 Nov 2026 13:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795803582;
	 x=1795889982; bh=TdEKSl+8ijRZhU7dEbZFwwq8lM7vGplGIhquXFiSnaA=; b=
	eVDziN5LXZF0HwBArcxy1zj4I9iaELredPw7tZAMNBFcDlSZbZIw3DKH5DwjcGGo
	VsZbWbe+zLSCkaCTlzjIV5TefbUMA/k7TJdLsYHfz2XifzZvCA+ik3E4FrKyFQQu
	/CBPudddwChUIvcQoSp47CaH4JtOoHmmIPmgRZHRjiOUyXRKZhfbL0hMnfFCsjr3
	po/TcebTCX1qhR1RwwsGcWLBvL1lDtowGLtKMbmGhQIA4W1wQ9sPxC+2z1zsjQia
	gp1D4dsOYZVlDhREyhzeREELFn2jrge/ezChvUvGf2czTXrbOF3DpOfyV9V+0Nj/
	Tl5iUJBM/Pq7yG74V1sYIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795803582; x=
	1795889982; bh=TdEKSl+8ijRZhU7dEbZFwwq8lM7vGplGIhquXFiSnaA=; b=J
	11lQKMGykGfpCFuKUQ6I/iNNK93sE71YCulVinPJR/FlgD3yOwBCpJBgspbngR3I
	bY7oecQ/tPbepBbJOy+p9QDuKJmxxuTx6Ihy/e9ypPp5RW4leWsQjQQQaXxB7Gyc
	I6zxVaN4Q2teLK1Pi4aWVNwaBRApclflJh4tU/jd9B5j+Uqp1FpDg/Y9xfPDG8Oq
	r6tnsYmGkjg6ZNdG4QYJWcV+TOLWl6D7d6CuCK5Q5ej7S27wa6kbEAHWT0J2LE7q
	2dPzR6dlZ7spkMJD3h+i5pzmyi3A+yIWLOavvtTfSbEPEUJaAmlAj7bBnNjAgdMN
	RkHsrNV3H0MfgzVagW2cA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795803582; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NR2rejDLGdXZ8urxXOBA04zYdk7TLC6wGtQtu2I4EV71zda
	zteQQh6rdQ9kh5dSyP6WJmEsLH5vrAMBrcdSFT0e+o593JsuzVh/bENwsNfrd+cK
	AipjmNxWLDkqo4fklW/1Ss+T+YGq8UuOQgbuLeuN3oMjvqa/gVXhfYlWpQ9G+83X
	obx441/j8iDJN3l3X7lKlJ+RN2jURKgB50Rrfb04dB7CU/tdtYWj8P67MzC8LTpa
	O7O2LT7K9iTcfYTdXMK7GODdrChhCmSaHcDI8YPwGUAS1sq0P7g909tsvbz2VtX1
	y4j8KbPYxFOiFTm7xoE5JuJUqVtzVn81Z6Frx1w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:xCNBislwnPFiKVIQYHXKgSm/lqVY/syefhFWX2KeNDI=:d0g1kkWelaXz7PIQ6DgljlxQFcJ2wI3QyehHawtiPhI=;
X-ME-Sender: <xms:vskJa98F5XVvA2b3Tozqb9tfg85blQHGJisBXWEGP3YxPbxgXXIfEQ>
    <xme:vskJawzVxk-cOnTndlHv7_Cjj_JkUWHC7w87Ib_opbMvJQ-R0ipSaj0Ykv4777c15
    muG3E3odZ4flF50f6wZ1NdHk307n9Wyni6wOWwFuBNFZbzPLOR7>
X-ME-Received: <xmr:vskJaxM8rv1lP3aQlWO1fnk90p1y0cvO4rk7WdYd2-MLn01Tx0wR9NArnc8Ceg7U4T85_uxJPGKFyur0d_uBFckLuPN2cPpBNy6tVts>
X-ME-Proxy-Cause: dmFkZTEEGncE+CpDNEaLT94faPNEhjPJDsaSdAmO5MOqEnUFhiDTgiu2QbRtGFKqnTiOtS
    q7Y7ZzXOcFX6+h8vXQg8tk96MR4tfn4ORbE3JqZPeOk1NDqvpYRX+jYQifLpdVO/QQI/wG
    gp1fR0pkuqXKkxRvZiIqEkHdR/siUzw6uLXHOShUdcTpujiZ+xlQS01lkrki4g8b6Lw+3a
    CXdSNqgrY3EM8bqJyfwFAkNAl5UdtyRMRKOG+M7a2Hrjs0gHj2ZCfzCVanSA+Cm1FNTaD9
    TDpMA7EMRgsfkTU2/2MJMUqDOmHOo1EK7vnX4nPKmQRQaITcxJtsJ7Q9DxvGe0UmNQzzZy
    GVec2zkMAO9FqW5PNJmIlnw8St2x6wcHBUMnqhURdeAdkO89htaUJ8/S64r3dTHi9lMML+
    +ldzhTVjGFIPG/WqmL+xKV5P949q2m+PJXx6X+yx/i2JqguJYIYxE7HZTetRW4mO2m5bio
    z01y+lppD8pxQRxfiHb6Eg7rT0aWi5mIuGuaQ67O9PK72PhM75HaImRHHOf6MyKfS6ttEr
    WvuxdGpUUZX+5KrXgoPo/18oSTqA26dfQQDt73vrbxeQS1TmdtumHxc06x4mjoBIsrzkfL
    RUrgN1US4nkguXixnKZ2GZZ5UzmOgzU5hn+FVlfM5BZrLCNkxOKWxG2D0PmA
X-ME-Proxy: <xmx:vskJa9_Dld21Vy7j1O7Krle1hFW-ObgABMzO4WMcGajKQr8yV47jSA>
    <xmx:vskJa25OkQJpOzPgDhIwLjIw9dVK1z-vqDnZ8HmeJbgryscYslIf2g>
    <xmx:vskJa742dTbRM0wbRIUnHPBBNDvVCDaKvv5aUg7Ay20cZ6vSQcO0Bg>
    <xmx:vskJa3pTAj1cWFcwW8Q3eeGpeiKrUPS6e2-cVGa5m72vS8XCTpsbBg>
    <xmx:vskJa3eW3SEDRnDnMxPoJrB5eRDKuOqtptv-2euNgVGfZaLb4gq61PO4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 13:19:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  ps@pks.im,  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v6 0/6] notes: start passing the repository through
 notes.[ch]
In-Reply-To: <CAFpMFfC3sd7JkK-ewhvs-6g29AJzRMv4Crz0yTH3OSOFm=4LUQ@mail.gmail.com>
	(Okhuomon Ajayi's message of "Fri, 27 Nov 2026 14:52:52 +0100")
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
	<20261126213306.87466-1-okhuomonajayi54@gmail.com>
	<CAP8UFD3wt=at-HEg58UREPio+SVbzEL-G8YF5E++Td+fuW86cw@mail.gmail.com>
	<CAFpMFfC3sd7JkK-ewhvs-6g29AJzRMv4Crz0yTH3OSOFm=4LUQ@mail.gmail.com>
Date: Fri, 27 Nov 2026 10:19:40 -0800
Message-ID: <xmqqa4mu9lxf.fsf@gitster.g>
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

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> On Fri, Nov 27, 2026 at 2:22 PM Christian Couder
> <christian.couder@gmail.com> wrote:
>
>> So in case you send a v7, please make sure the "In-Reply-To" of its
>> cover letter is the message ID of this v6 cover letter.
>
> Thanks for the review and for pointing this out.
> I'll make the necessary corrections to the commit message
> and ensure the v7 cover letter is properly threaded under
> this v6 cover letter if another revision is needed.

Thanks for writing and reviewing.  Good to see contributors working well
together.
