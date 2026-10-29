Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282433;
	b=hes12G8O1k5MRnAJ989ozBbKL4IkDGfdnSOgDYUeRLiBHPF1nZ1FfGbvFI1hrg2PkX66
	 QjBBHkE0O9qJE5M1CBFJ7lTiBZShtyehTplnpx9V8h/5lBO4RmXm+SU/DN6uGQNn62st6
	 HOc1Idhr/nalRbkdgjUMEKBUe+EkrtyQKWWJ32ijN/6AwdK4F2TL7npLJXS8pDlqH+Ygx
	 NZq/cxkxLiMXvitnYWDdrwEONgVpJOBDAtqmc/BukArd+QGoLnwbbgAk4aUuZutUCDzya
	 2IpufAjS+tMJOFPt6v5iKUVGvDdJugH2SVydh5VIR8SpmDkg7lTqzAlwa5l7rTGwDwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282433;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=p661oP3ENAmFWDs9WFwqLYh8FvcptXqHlsNdLR6q3X8=;
	b=qk9PpM1F0Rh8TCOO5VtsY0nZjpUL0FsxnUm0thZKRJuyFt50fTSQaKqboCdfPOU6dIkq
	 fiac5khT1eHa4cxdMnBWsEz5Focnl0MNfgpP9VVS9rNRAROnwpsykUT92aaCAsB4P6EBp
	 btKKi2IRZ0hMGC/2ILzI5Wwc+chAQzFSvKM7slPcQPIzibAbo9chOp903ok9Ih+yrNLa8
	 EY/pCiuSWkDtyopc5MCix0g0EndnmuX/OUqjgfJG1X8eYsTS4vQCZS0QSJ6yKbr77loCB
	 1K0yevAxqjHRrNNSJWWYjcKG/IcLFMt3H+0eki4GH5nl8fwhMX06cbLWYOFea2aiDbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=KPoLvc9j;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Lm3sPNdu;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E0606A31E
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 938E0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=KPoLvc9j;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Lm3sPNdu
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B35B31D0016A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 10:00:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 29 Oct 2026 10:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793282431; x=1793368831; bh=p661oP3ENA
	mFWDs9WFwqLYh8FvcptXqHlsNdLR6q3X8=; b=KPoLvc9jRSZkaXULaL9C2/rcgZ
	7N8mH9z3K181HP9TF7VzwGjRrElnm0dKjP0CkvsJRd/4oLSmKSvv6ex0bEXePaTj
	xhImYhZ/ix2jwg+x7JWODnY08YtjQL+dDA2190UKvdPA76nnc2EDNWouRQRjI5ga
	QUiO1uBj5JaYa79R3TKTg3GujCQFnNdwZ8JCdUvJmJiSkDAusB+OWi7MacaWb2Ao
	rMp66dhP8jrH8GMoWRl2m7L6loC/lPYfDCmFIA1pB4Ah/fpdHdsOYrhi6IZwsfC3
	lkPJGQt1fjuRO8UtDcr92DJAjjuV1S4hepqGj6b1S5ZKyDm0v5j0CaCvW9eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793282431; x=1793368831; bh=p661oP3ENAmFWDs9WFwqLYh8FvcptXqHlsN
	dLR6q3X8=; b=Lm3sPNdu0CU6F7TEPJz1s9KJI6eUuGigczsj5ej9u5JZ0KZz2Mq
	9x7J2i2PkASQWQOebnsFFE/b+lvMK93Grh2Xa0UYbBeuO8h3p887A1ZbYHlEbH2m
	aWxlL2GzzbJqp1tCPOwZwYfmlQVZ3mWDssrSw16fVSeiCZGx9dIpI/LkKAcWHYUr
	1ZBI1D54McIzcucHTN6+1/qYW57q2eR5fAykAMQC3jyJVEVR4qStIuZ+Yd6XiYTa
	mZ+zmLk0MvmRda68Pd8MaqY2Psqx0qyN4xkW5P/bQHxD+5FLJuRp8WoMRjNMB+hw
	b34DqTuxQlt+OyZ3WWJXueEa+oE4xFmkOlA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793282431; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lMO7xPxv8dhwhiHixW3diYKlo8drG7WHak0z2W02/AkFrju
	Bg45fC3qQRClx5j6XzwdzlwEn+mgclBAT0/ryUf3e7rhSkZm9hLs1DpelFIIt6Pp
	1r02iIODB6XBl0A7H51QToA4jyeqgzOXxRyDTkFYqSFkCaSx4ctoaQGQ8+lfAk28
	8ICZz6S+oil9bCuislKVLHBOboitL1cxz+qf4HG9iBctnsRO3qhsJJ2T1FR8Osea
	poHEYSlRGlTsZvoV3gqvyP1+dz1P7LrkTdrpzuqPdxMxE9WcGexSWJZ9IWGkgQhV
	/JffuYVEfL/p2Zp5KC6Wm8GBIJWLtujRGXiSeZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:R9eK3P5r3hvbMRp9hBj3guPB9A0uqYBPoRZQ+5qfQu0=:var1HY/wWbbUQNpoHQe6IcT/fLyXWnKiBtdZpLX4ub8=;
X-ME-Sender: <xms:f1HjaigbDXJHW4__jd3MT3XsnnQVRZajOHgz3SgZfIYU96bLiPzO4Q>
    <xme:f1Hjap5mByqE5OSZQ-_UdcIrLpA3RBaLmVxdkzz48XOrcrAKORw1gUejHd4ZKAja6
    RVCnRd_92fP9gT-A-4xbANpUono4vFt2ebMMKvmz3GJgPJs7PXbzSw>
X-ME-Received: <xmr:f1HjaiY4E8zy23SY-pogpr6gg4UfzQbBHsx-Ovuww46VUbqwtGuvAQ>
X-ME-Proxy-Cause: dmFkZTFiPMUen26pYKHnXgRGyZslrJ7916FIVd+hC3yWys9+mX8ZB3+NV6nXp/l7MCTyA6
    5MfZFqT+4owmBrY3eZ6WYCQPPE7Um2hhx2HhIK+x90j4cfiX9grD+/Ml9KPZfGQS7N+vdK
    v/Aq1w7PtCd1N3OK5qedWjVAkk8qaFcoRm1s93xgYnh2/RPsVjB1eQNOlInIBmG5DltL7c
    oqLKEtCe2Aw7TcoKIcDvrc+DIfL+q9UHNgevSVT1xwgNz3SidyRp3d9UGXOczRnJZ3kGsV
    0GuZL+99IdQaXAveOfNtzBb7218fS/c35OXytm7DCKUQf4r3vKP/kfBCED66CCLE4q7YJ3
    QGhgIzbcCwNd5ujdfhVE6BipvlkzzaczS6S9hYu9zE3mDRocu5O7BR0H8Shva4OVr9Itbr
    u9cmLq3DMjI9B5YHYQuEtWJrXQEZ5HgRQQwbcSAjbpIpcUU2BIdLn8QwrWUOSGp/TA6AKP
    dfwTONNmg0O9BqVvLSlNYQbIkBdLHMb9hfu6kO1CItNFdjfvn9Xg4+edzHLKoaKIDV6EGD
    pvy8ozcC/VS4u0H8gIjBglJpGX3DyMlyx35Ks+iP9sahEyJ7G0Y9vqxbjVzjU/PEM4Dnz8
    spUSLDkE+gnb6OTdOuJ3+L31wT9PemakFQKgLh4sGetVhvGtoTXjtY3G7iFg
X-ME-Proxy: <xmx:f1Hjam42SmW-uUZezpTlVL0v0tsD0-nzj32RylvdeAso63fqmFjILQ>
    <xmx:f1HjatC9_ZPfHr07fMkKFM81NP22UwNngfxbFvB-DsujS4G5QDAfDA>
    <xmx:f1HjakcLT1vipoNeVbgx5AIFz5TQPq1IrQmsVgJM4EGZUHY-34hnng>
    <xmx:f1HjakLfdjIvCSK7Lh12Diw41kwJJ81OwTzdnEYBRqik7ipdWolrMA>
    <xmx:f1HjajbInt-J3XKE7MN4OYGvL9YRvWc1xcNtDUAaC6I3B8WqI_bcEwB_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 10:00:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52246fb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 14:00:28 +0000 (UTC)
Date: Thu, 29 Oct 2026 15:00:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	gitster@pobox.com,
	Mitja =?utf-8?B?QmV6ZW7FoWVr?= <mitja.bezensek@login5.org>
Subject: Re: [PATCH v6 0/3] fetch: advertise fetched refs when backfilling
 tags
Message-ID: <auNReY6zQ5x7tlbV@pks.im>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <20261029-799-shallow-fetch-with-tags-v6-0-e6ddd5201def@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-799-shallow-fetch-with-tags-v6-0-e6ddd5201def@gmail.com>

On Thu, Oct 29, 2026 at 01:45:36PM +0100, Karthik Nayak wrote:
> Changes in v6:
> - Move the last commit to the front, since it adds a test to exercise
>   existing behavior.
> - Fix grammar in the commit message and mention how the next commit
>   would catch the leak fixed in 2/3.
> - Link to v5: https://patch.msgid.link/20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com

Thanks, I'm happy with these changes.

Patrick
