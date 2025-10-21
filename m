Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A842E2847
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033969; cv=none; b=YiNr3/0piFGjvlCTZpeUMkchRlyr65SQQ1hE31JX2QpNpXEhjUT/KxAOWsKi3mIASQJs3MogUmH17+WFXN7B4ZauvQG0Yh2GMpYSovd5ayw0HF10obbL6BnWqdHBZV3NXeaQgY8IXfEG6YTUqesNvrpI+NLZVZfjc33AwGjIEF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033969; c=relaxed/simple;
	bh=TNWLx7zjBN9zNOX6DuTyo2qoF/dwY1hXdXmS2xznrnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsqeMCfUcCNResHn0tiFtwisNu5/vqVE4m4TY6trZXhIrAW5wQtQcwh3sliRNXQTFNsnzU6l2nrOfvEdmgHxhcqc4PFkO/R2moJOzsdGz5cSARpPk5DARv98qHd/QACBm6t7tR6yLKfBRuJ4NiasbVdHJEVTYU56AesRwYUZpl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eP9W4mSe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gqPJ220/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eP9W4mSe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gqPJ220/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1ADE8EC0189;
	Tue, 21 Oct 2025 04:06:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 04:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761033966; x=1761120366; bh=StOsT/WUfr
	v2TIEbIBO3oQ8qgP3LrIKJnp2BA82XHf4=; b=eP9W4mSetImKTHcW9yhie/753B
	KPS1/HNlaz3kpb3UsyocYtAWAPHrw15Hk7H3Xx42gp5C2VW7rtcwcH9UoGDSZZmv
	zA8pspSBJXwAeETJa7oKdmtXnUuVAB1bSVgLo6IyBwPDQA5IZd3yrkJGdE930eu3
	aR6kd2Q4MaTuq93/cijFK2PDI8ParOWEI4gPgxvXUcY4IkJH/S7AQ9QYox5gEnrU
	BnDRImoTsOBJupll5nCI7yxC/IFhKWi5BxktJWpEP9+REIf/0+Ma3W3rVU4p9yKr
	39N2igG0m1h/bbAacBKfzMWSRl4jSbszcqM0G4dIYtjAcWSuTpgJTXxO/ZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761033966; x=1761120366; bh=StOsT/WUfrv2TIEbIBO3oQ8qgP3LrIKJnp2
	BA82XHf4=; b=gqPJ220/LWIHJ7atFciVYfWBRb7gb0mHXNWFblLQ3Rq64zq+Itc
	IRk/DykskKuQyE4L36IzCSRE0c1fBOouxwbD5QrcCNn061yDyJLDiH+yMbxClCWg
	7nAa/mlhib7oiU+qve2hk2gNcNxePNy/tNi5/nHTeY6HrDwzkgnzAH2vLzkr24ml
	qp7x7H87YtdAzYyy6siA/RqHtbICYh0xGwx9zU7Z/RDfxi5ZuGZQEzV1wlsLT7/6
	t1K1qK/7tXg7vSf+Y7RCIB1y0NQrGrQbncu6SXjaO+e7x3mC77NNNxQ9hrtgW4mP
	sW8p6KPYgQWFRnwHqOj3pu4jJwj0T9tEFyg==
X-ME-Sender: <xms:7T73aHndrWFPrR9O9we3EXEVD3Bi7h5HFoA_EbfoP2v73_EWqldRUg>
    <xme:7T73aDATAKjj_-6oUlErFtgOAt3Ch1kmpEt5zRHL6yUNE7qz0_6WaggRIO0UiPujk
    Y09K896Lq1H0br7L-WMO53dR3FGZ1gGSmQ6iahRIodIt6vwXi6UUQ>
X-ME-Received: <xmr:7T73aJMNAHO11MnJGVWX7qJxGLIjr8VjYFKSDqP1dAxImS5RwXzvqzK_POGkxZNBgQiaF0Ce3MWfEXcx3rELXYGSyuJCvKJP6XhTejWW3lpI5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrg
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprggr
    rhhonhesshgthhhrrggsrdgtohhmpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:7T73aKNfNGObB9I1siqI79jS4UAywVwmSnEuyO7X2pKlP0CQx3tdVw>
    <xmx:7T73aBluy8Z9LAQs7SransHbfqgpcopOam4b_J5HzTX0oJtX-iiUyg>
    <xmx:7T73aIspeY2zP3vpJlld2XhwiCDzxCGZcHGjS_HziTG2sZbi-CXiYQ>
    <xmx:7T73aEqt2L0O9bLvE22hc88B9CIYprLIhkdFqA6IDAWmW8nl2_K-4g>
    <xmx:7j73aBF2nJ0dnSXZDa7uSsaSfZDtOTfEVpZELH9Bar8VTxFpx2Q3GgRs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 04:06:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96fa83d1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 08:06:03 +0000 (UTC)
Date: Tue, 21 Oct 2025 10:06:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/5] strbuf: bring back is_rfc3986_unreserved
Message-ID: <aPc-6OBaFzO_jkXd@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-4-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006112518.3764240-4-adrian.ratiu@collabora.com>

On Mon, Oct 06, 2025 at 02:25:16PM +0300, Adrian Ratiu wrote:
> diff --git a/strbuf.h b/strbuf.h
> index a580ac6084..5139269039 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -640,6 +640,8 @@ static inline void strbuf_complete_line(struct strbuf *sb)
>  
>  typedef int (*char_predicate)(char ch);
>  
> +int is_rfc3986_unreserved(char ch);

I think it would help if we had a short comment here explaining what it
does. I doubt that most people immediately go "Ah, RFC3986!". So maybe
explaining in a sentence or two what this is roughly doing would help
them.

Patrick
