Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792793298;
	b=mYX/tftI/XJanZ3BOD3KBMg7BCin8H8MK5MjgjEhPCMlGPlldaT6yg2wWAtVUigQmHnc
	 Vs46RfYRpwjjmUmHnc0LXoDK5gVpS/iiysF4zOn8k8pOeFUfQCffVJtBZqDP+Rromoyh+
	 yZBLkRfbwoTjF4oS6/XtttoGqhve3HqYLuZeYUL4cvgcjq9xEgWCmhfuVMLVXiDmw9L4q
	 XT9HV/vbhQX0iiodm+ktaBDvh6YkIZqbRNDutn8/xnQ+sE0T0LRwK0GBlDd6PgEY0N/xs
	 dOLmUgldHXxY+IROez1b2F9iX9OBsWV/WkJnbIsbkFdLPfBvn/mGPfUoLWNI9trkjRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792793298;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nq7IOU6IBEtHeHFLGdcqex9hjgAMa73620VgOrSNGzM=;
	b=0b1i526SY8kAPLXv4Ln5lni5FeACouNXZCehTG7IA8Z5R4NdIgG0mzrZDV0DmeVwdWNf
	 /LwRdoaZIR+VNS7TxU/6VFda/Fc2C45GyS1m8/PM8/I6xN089M/h0TWPwHnN2Fr56gH+m
	 1IUJYXvtXk3nq2RFnW/A+sD9c2GTiWy0FqhEMKsYlY7n7KvyMgYOz7CmWePVrLToqEjW/
	 VG8hEEOkJ/eZm7Bxbg7ONJN+cIi3LFXNdRMi0ppcPLHPaIxknMyBuDkCAx8R94txINjDE
	 NdqrC2e1KwDbRfpfGo+C5kZsU+w4xW1mFBK9IfAb4OfrFnYJN4ny/DJdpNvbdXducGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fJPj6dZR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="k/iLgJVP";
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4F606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 22:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08B4F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fJPj6dZR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=k/iLgJVP
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5BD361D000F6
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:08:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 18:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792793296;
	 x=1792879696; bh=nq7IOU6IBEtHeHFLGdcqex9hjgAMa73620VgOrSNGzM=; b=
	fJPj6dZRhNA7f7IOKwgYvT9mNTazdx28CFANtW0EGmEG+OLdKZ2tensKM1Wj5N3b
	2vUfj1ml/j4PS8KLG1gmcPmcsxxHinbOX+ZxyOITriQ5iIMOLy5Gm7TUVaKMWX7j
	MaPTiMOzItl6dqQn7wEhd0qWs2nXz8GtTysPDFFL8NzwXvSOXN6Zu7MG2RAtQtJQ
	T/GNUuyZLnDXin3eVskPHBbPEH30JaJ4H28VcoCnhCn9YndnblGvmAnZyFyIvKHk
	eSeNM5mOMBZ3A2pvYajWzno3QPAD0mW6EmWcHYO5GS/HmnX1MPmEhm/8H6vfhopT
	DKST8eRSdO7cF9Tutq1YuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792793296; x=
	1792879696; bh=nq7IOU6IBEtHeHFLGdcqex9hjgAMa73620VgOrSNGzM=; b=k
	/iLgJVPSmGcHBXPsi1qE3OR3xkqaRrw+iXLe8VZ+c1e6OHGBtHOdoQ7boEnxNpfX
	i7L0Jk4rpudPbscLqAxO2cynbQGDMUYd5I5uQHXK3xze6QdYm0fyUeXg7t41ajDd
	tLH51qeeBrZ5gUAE1cdeHYHtWITqap5Ribm/uq/rAmjI4Kg6WZikfq8lrzSg42om
	keQmp1dr7EbgDZbpvTQF2PvwDTfLzF7q+dhwHkA7jZnkcI2UE0pYa3a7jhyOAqi/
	ZNpXFfMY2RQJVoldoEQsZR+caHwXnUMghVIh9EpUhOHuJ949RdMlaEysAuKLxJ1Y
	r1WgbjmxulmJTyYemHgTQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792793296; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:kgJQvpaRGvgJ8YYXFryNRThbVRlLJketQcLlMuFqtU4ba4F
	jmZ4wmfs7HvAS5eLIqEMwcpmJUNyoqlRP72b186Jqz31hesZWIOTvOaempKxlXxn
	SMtYviKgZ+TrDaTBhzb0U01aSqnprUhyXEyca8qB2ZSa4y6nzFzb0KlO/gp+R5UB
	WkS9jaAh6wkbNJRfbB+pdyPWut3mEW444WMfM23QjXZEttv5/NOIf+c/kbfmVEdG
	iZsL+Nmlmwu6zFge+RkHbXhyNY3H/dRzaZgT14jAb1JLuzAKAHifNTDrCZDYJHbE
	lb92MCwzuFYzYdBM7dzpIu9hX7FzP9gNF1s0STg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:XE8Bla8k8ZMd6mF0uurMFx6whLKxgeeOLFPGomOEQP8=:4L7JtHJK4WRJBIDvqSlAV0j4bm8xXjf7MqC7t1vw42Y=;
X-ME-Sender: <xms:0NrbatfC8H9YDjRCzocLm7kdvV0Oe3Gne0dZCJ3OxUxFstTMsmvG6Q>
    <xme:0NrbakiPsbwxWl8ewiNGAXdB2juvMMJK3T3SllUZfnHOeO2PXABG7EW5NSUCJs0pp
    qAwGPJ512a44C73rriFUXSnl3CCKDxD1k7Pp1qKf2nlhx-ENOiA5g>
X-ME-Received: <xmr:0NrbatyAKsttQFHeqCMzzlAPb91wUDw0Xcv31SPABflzXyPp8qwY0ifEJv4l42_jXH1z8wgQQRoZARIcxyFOKbnADpnE_kmcJpZP>
X-ME-Proxy-Cause: dmFkZTGdUQaJxmewaH880rVYlse0JEc6cWhOb0j9Txe3tLzexuSRCsVi9Qn8U+UqKzg34p
    ZYL4sZJPWTvgU9IEqv7RBdaDbDGJkAfMk5nYmrNhHqImL39Ii7JcX1iuQiyRrn9MfPVTGE
    ybqZQm5AghuJC1RuwlaovmCl9cguhkolrCzZJ51Axp7nqne2eiO9K16QBpn/DrDv4UvAKz
    /TXMXGM9uqyCgxyHD7LukRqahrQx3CqbifQM7yNQ6fnQZnu3Tq+pcmtfPTUfn4H62nc8Bs
    LF4darLnZdku1vP26KnRfgltoXrfWxotYKhsJigUPkugg9w00U5qxBfmkCi+Vl8nxh/7VI
    WewHFqXBGTkmJQTogtFMbKNRFVHk2mkNKaM1u2r4g+aswPHvfLk+bDMpARZsBj5yFtbQDr
    13uV4bomDhtwbfiPvaS9W8BPn7oIz16XzT0TjB6iP/VKvNSzv0XiGFWt2KGfaVpyLGNpmR
    m4WI4dgob8cZhrT1o+4+7GKd8WCfRz9fDrhhZ72hUvSB3DmxDTmoyFcPqSaab/z/MtJOb9
    ZHNBSZRK3GEGupkjJIT4P8oK3GzB4+rsKYV/4T1ASE/DMqqx/f/pU/8htmEQ8b8H0cKwB8
    ECXcEUvaTMG/ZMo4AMAjNNO6XrmKrbUqt3OmolOuLD/CTAVQNahJD6KvtioQ
X-ME-Proxy: <xmx:0NrbaoOk3tLru-UAL0hJCHedfzFDUwR8Xc1oBbKTYQoCoWJ1fENgfQ>
    <xmx:0NrbamU0ZiFVj_dOG2DZHIpqc7ail_ZwVJXmmkbgFLquO9OLym17Tw>
    <xmx:0Nrbak0Rge0PIIOhRwt1Ar0_MrScSlv4pg4e9eavgSfyaXqHde2p3w>
    <xmx:0Nrbaspnv7k-j3CKU8oZFCRPOdM-gw4ghn8Hhgvn3RtjLjJOfN5MRA>
    <xmx:0Nrbaq7Ffke3n265eAEcUviRHrynNrCbhqi55iodNDSHvzSpdNooWyQN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 18:08:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,  "Emily Shaffer"
 <nasamuffin@google.com>,  git@vger.kernel.org,  "Justin Tobler"
 <jltobler@gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
In-Reply-To: <38958af2-98aa-4145-813f-da6d601ce9fb@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 23 Oct 2026 20:09:19 +0200")
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
	<20261021200341.378978-1-emilyshaffer@google.com>
	<CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
	<b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
	<xmqq4iedc99a.fsf@gitster.g>
	<f192e10b-c7d0-45d8-8f67-21383474d16e@gmail.com>
	<037a97bb-af3e-4e20-9845-c2d92ed3a2c4@app.fastmail.com>
	<xmqq8q3o9ycy.fsf@gitster.g>
	<38958af2-98aa-4145-813f-da6d601ce9fb@app.fastmail.com>
Date: Fri, 23 Oct 2026 15:08:14 -0700
Message-ID: <xmqqy0bo2hpt.fsf@gitster.g>
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

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Fri, Oct 23, 2026, at 18:26, Junio C Hamano wrote:
>> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>
>>> Some people care whether software projects that they use but don’t
>>> contribute to use GenAI.
>>
>> Sorry, but I cannot quite parse this to guess what you want to say.
>
> There are people who actively dislike software projects over the fact
> that they use GenAI.

Ah, that is what you meant.  I understand what you wanted to say,
even though I do not understand the reasoning of those people you
describe.

Thanks.
