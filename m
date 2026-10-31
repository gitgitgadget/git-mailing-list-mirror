Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465213;
	b=opP/zly7gLq0K2X3mxwi4ezfAHCtmFkvaMNy4o39iYGe9qjeH4p6ZZfjeJSAdSNIprWQ
	 20aSo9DDLpBLT3eVVgmxRNhtfr5dIltP/nUH0adu5rdjQjTqHbS0MBNFiylIPirlKjbFf
	 y/NLPGxFRsri/Zpx6DoV1Bu4Ax5yNymKXM0vc4K0YGRWJiWjrJ7ENGKzBKaGoHxZ2kHZa
	 cv1chuJA+4+apRUkTrzgJKksACzIaVjfq1w9987xNMBMINCUSGam4fNYAf1U47Jh8D5YL
	 QcC+qvWUxtBDq2y6mHpsNGVDDHHq+u2vNQgvGs9KHDUwg2MBdpqoXfzEccO5PtObEYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465213;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=hoDfWUETffRPpYKJdxdsRqUUIqhYkh5vdOFmV8xqWjw=;
	b=qkKGwSK7JGy0DnGa926j7KNdSlCYLvjLQtn3ql1Xj83k/acGPwpK+sdEBAyfMVbM30Z3
	 B1eFvL2zT6Wylf+BiHmUJ0ekvaNWYnG7pUocoDJgAOzrZnhv+LfMPLJgDDFaEI1mqTPVM
	 h0ozt5AQ2WsSzm+77rEOe65tvJpIuQ8nDb6/rDmNPAPKnd4plOJwhotjIPekqiL/XB2v/
	 qjkQoeFmq1AdD46xCk5uPuxYrzqwDOEOyHzwjj+eDUIc60Ut1YDLKTGKRzK8c76oHbFTi
	 7trG/D2doVNzeB3MrLOf04mXYJd7ncdWesEXiaNex1ey9/esypHiBxoWyhl9tyGKylQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=hxAeCDSa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="mNpb95p/";
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A35606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 16:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A35606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=hxAeCDSa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mNpb95p/
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C7E9140014E
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 12:46:51 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 31 Oct 2026 12:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793465209;
	 x=1793551609; bh=hoDfWUETffRPpYKJdxdsRqUUIqhYkh5vdOFmV8xqWjw=; b=
	hxAeCDSa0c07BpS1KErut9wxrc48I1zFW8QRBLgbNMDJo9FCDcjWg7T2J+ToLxpV
	saRo87wLBWYyA6pP3ongq+YOvlq19baoDgSVaGd+c+20lMFMNtt0aVDNpLmJDDiN
	lBZvNL25ySqdbFsIxzm3jgm6bluQr9u7j5bWqYogsFd3bAiAesL2Z/Syd+87Y/qp
	mumBP4jODJWaPMK1KqIWSTt/ZRCHZ4Ha7iRZh6y0boZI0lK8WgwxHnwgC0pl2n44
	kq1a9cijih99zL+w0JRqcaI2cwNQ6hTdVySQv1YV6CRhI4OP2TZoyCuk9GU+FqIQ
	aIaWzkQfxh7LiXn3nbolEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793465209; x=
	1793551609; bh=hoDfWUETffRPpYKJdxdsRqUUIqhYkh5vdOFmV8xqWjw=; b=m
	Npb95p/TB7YsdPtuKIJx/YECcQRgmsES1h/EAW80351//YQeY1m5QN/sk6CWigdv
	5QDjp51STHOPzYIOcky77IXNbFr7urV9kCAP1KSo6054BdcoaCtwqS+/EPGrCU+P
	6aL+F1aoBw66QUOSObiJA+53PCgAHtNVeQ5jwBdGeslhAqEVuCWKy4Gx4unD3huF
	Hpt0W8OULniuTn9SqXZ6NLJGGtww1ZiyWxDNuuTTLNpJ3SXXa8xi1x8mmoBZn2nm
	QZzIWng7YinrjEsjpC1tVnLPFQKuYuGA5lnozpJ6Oe9W9d9g+ijKfTxPm7sL7gUf
	8B0gNwIfyGcftnqFcjzMA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793465209; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:swMVFImWmfIWPxPLsd+Qwq7h3Rb2t8rcKiEhKwsG9mONjU0
	KdNADTd0s3xfURb7WxIVk+sd1wt7BtaGAgN7UbbJXDnekkRRs0Y2KTz37Pa8/7xV
	DQ/3TYpvw4yv4ymuL1ZR9P60jwe8OJrYkKFlxAkRT911skWHLrEp6LTPp8upfyS6
	6ghtRCU1KApGLkXLYz5QnApS64bFb47N2wm1Xvwzv9fzgQy2NbspEhEKj90t8jCF
	Xuin+W0CqyAbF9lmUF56eWOpqjHEYKIXp2qFgqAfWT5JsMv+I0V18umVl/iilrVa
	21o7XRWeZVDCkpALuR98rsK31Qhic0YMuMKB9oA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yu4dyTMXJsynDijlJfh7Xq96W2z0SXIzMiYXBGm9iTE=:hoDfWUETffRPpYKJdxdsRqUUIqhYkh5vdOFmV8xqWjw=;
X-ME-Sender: <xms:dhvmauqlJkpBmqSX9Eicwb5VJc0L-Gg29tVfeh5z8eBZJ9ctUlJ2Q8M>
    <xme:dhvmane0ywazndrE1V8tbkpngk05HXqqDYS6DqMldveNVL1GMBsly6qCiCh0DIa0b
    vQX2mlJTeLdYedjGL1T2v-j1Ft7jwb_BeC_pso59zz42l9vOVop9N0>
X-ME-Proxy-Cause: dmFkZTGwt33iIMkmtgvcNU2lCoHK9QIZB+ZRFmDicWC0zs7RkyPsxlcAl/6dO4h0r7TAk8
    VMn++FrpjIza1UZqy0gM3FFcl27N+5e09nuymenwFhSnSliLF+fICFD1j3edtqZiK6NSnm
    ObXdRPxuDkdCsedpUopaGjXe1GSpS3mVDuPuEbpGdZW4VR3hmHhsdfbTzyNc7Aig8F6anR
    2NPjIksg2/nG7cmmXRtKzuTza9h0oqMhPXRGB2fs774owwUmsaGPnhn5Tu0YEfgiWQ4zcD
    Qjrrew9694e4Ck0X3yB2uDZHm5cwOGDrfT0AEdz4wdIeTeE4v3OAsHbivPHkkuUX5dSQcE
    tOI3gVlhXj4tCVSds47wJgFX7IeyGulI0KjdUHxrliqrGOWYHWQxBt8f65EHZKcpivjrOI
    aEXcly5otIBBED5SUgMIvFqoTF0LYc+5oqbA7U4WLDwqq/LXFeuvMW7WnsEXseHNivkl2L
    WV10XYPZjKESspDseqfu+W3KR1RGa3Ee+RHG9sW/16Ruh/gDYc/4pDbfxbRzWflUufqMEF
    EYYttoxrZXjLgA83EbkS5H61mxo7z5eFo4gr6mXZvqjSow5DTtugnung6qrCF6dKMoPW5K
    o3hbgA3aN6IMDkBgxoLj6r23MLDG5MGFW3eGa7Aho0AuVpwYT9GR5Pemy3HA
X-ME-Proxy: <xmx:eBvmavS9q7gwBnbuxzhfbyZVdQh1gM8Q_Q_eHF72RT3-p7509xvuZg>
    <xmx:eBvmaukm2XtZg7F4Naz8skkOAzgMoagzyn_3uzgJoZYHh7OV-D_IkA>
    <xmx:eBvmavQceG7s4Wfe3NbbMQdO8R6_0mFz52QWBPfhE_qmOOy7_tMIkQ>
    <xmx:eBvmasPZrYrwPhjUHIRIzzQqZdUWFkno948xgf-fImlLk8M30Y5FaA>
    <xmx:eRvmavVdl7NjJUTm-Q3o4cCqedyQwcUmjZ3Zk9HJtscVYYan8eEd-4op>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CDA0F22C00A0; Sat, 31 Oct 2026 12:46:46 -0400 (EDT)
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
Date: Sat, 31 Oct 2026 17:46:18 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Farid Zakaria" <farid.m.zakaria@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <e40472c7-cb23-4ac9-b82e-1326fd8c88d7@app.fastmail.com>
In-Reply-To: <DMIFRWWLOTMP.3HVH81PKHBTKK@gmail.com>
References: <20261028-fz-notes-concurrent-write-v1-1-3d513e1fdbb7@gmail.com>
 <3c4f3793-07d4-47c7-b503-13a6ae567147@app.fastmail.com>
 <xmqqbj8c2wk8.fsf@gitster.g> <DMHMEOZ1ZXRI.TDMEKTJ9W325@gmail.com>
 <34b5c9c8-74d6-4d49-93cf-1d1909d56e9b@app.fastmail.com>
 <DMIFRWWLOTMP.3HVH81PKHBTKK@gmail.com>
Subject: Re: [PATCH] notes: do not drop notes written by a concurrent process
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 30, 2026, at 20:56, Farid Zakaria wrote:
> On Fri Oct 30, 2026 at 2:21 AM PDT, Kristoffer Haugsbakk wrote:
>> On Thu, Oct 29, 2026, at 21:56, Farid Zakaria wrote:
>>>>>[snip]
>>
>> Use of GenAI should be disclosed up front.
>> Documentation/SubmittingPatches, [[ai]].
>>
>
> Please consider the thread my disclosure.
>
> FWIW I did read https://git-scm.com/docs/SubmittingPatches as of today
> and I don't see any specific mention of disclosure. It might be a good
> idea to make that explicit.

I guess I, uh, had a false memory.

>
> I see no mention of special trailer or mention to disclosure although it
> does mention rejecting anything that looks like "slop" which I hope this
> is not -- I went through the patch and the failure.
>
> If I was looking at the wrong document, please point me to the right
> one.
>>>[snip]
