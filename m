Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616460;
	b=DRooKdkMDTDQH0NyjVOfsEvgEJ+Y3wIZbEAc7lSoiGajbGWFk0PMyz9Wgs19Fym5s49Y
	 M6XIba5rakbWY48e5JX6qEHVMbOTjtQbG7AgQhEIf33hPGZsipJtASVtx04TDNz/uLymf
	 FT7ZBMs4iQfFoklGZbIQUZi+N5byJr+llmkjF4oHsEhkOkJZf1X4o+0fEI4QxJcUGlB2y
	 4jFhJ3UgoFQaqALKbcWviEQN05H64j7aVlMINtjWNwy4/RKstVGSh/9U5pqBzcfGUWpUN
	 cfwc/1xWfqTaSdX4NqWeKUO8Q0ILJ8l4Ryj3fO+wHJIT9vauVPUQQQevzGclG08PZqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616460;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=abTnJERdZ9Qi1M8XjNmkaiLVXqjKkYo9FvfDv8FxyFQ=;
	b=enNoLmHAd6q4QJ9ozJ2FzaRixwEw1bq+edUcAWdPPidbLzY0CgTN8d3pNrS3+Wjpr2sM
	 AtlDIu7CQ7ywhVH3oLbUpse8qZIsjm7xd2w/AlOEhuE5SVzjZDM847c0Ctoc9sXwMIK/a
	 S1J4RDN0MWxl1TW7V50cnERUDvmjoAMvbea51G7pBaNKmF7ekqaaQusTBrFV7UIeMRmVC
	 qHsFvQDs6ktNWV+haKR29laVql4iATvX3M3zD2+dA8TUd259FSh/Sf3Ro3PxsGlGbCFHV
	 loxMgS3J3Sl1F7O8BcD6TKtb4UkmswvhCcibUloxktLg5ftoXfAlCmIq7PKL2ltN31w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=g6NsIqen;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JixSULIZ;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ADB606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0ADB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=g6NsIqen;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JixSULIZ
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 412481D00133
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:00:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 21 Oct 2026 17:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792616453;
	 x=1792702853; bh=abTnJERdZ9Qi1M8XjNmkaiLVXqjKkYo9FvfDv8FxyFQ=; b=
	g6NsIqenN9LWg94nXXbJS3cvoNXYouip1LwaunXVAsZDmR8+/Gnb5Fz6157OFZ1E
	ADcx5COtnT3NZKfevsGunbZDlXE6209Ey3HTwlQ3L/XxhyDO7Y4LEn9/YRizXY5v
	EXXOEyIQY9EObXeFz/kNyKWXJLbTiM97l5Fyp7tSL48/Quh3ARbikbKDhXTL9tdA
	wb7HXJlJed87wTuR1IzFfLCpLV6uDRE8sLMvQit5f5hQG3flrjZveeb8i/eT1/Y4
	pPTHovUEGE0CQvR/kvlhxFNxwGZ/ewLQ/PD1IY/A49GBVWjs5v/bmWhwydsR+3M2
	HjZkAGdK8PQEl4wof1pVnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792616453; x=
	1792702853; bh=abTnJERdZ9Qi1M8XjNmkaiLVXqjKkYo9FvfDv8FxyFQ=; b=J
	ixSULIZhU6nvWN9qbiZghvV8SffqgLrDxl0iTvA9pwOeOknGYn1J5oar0Lwqn8tG
	JRgPqjnSLMN2CKUYTVZmgMDM/noQJyBMDDrwajY385F6RUbjbaITswCwUQqJ8N2e
	oJB5T+IrWCqmsV+p02XgvfAzsJzUtnE9PmE7pJTCW6kw2cYwh572NJVQ5jLl1dzA
	1Y5hJRhd+a70yjB/QAGWzDSeDbm8eMP3m9JXcTcvWnv+T+GnGmYTiBxtfLS1bPRk
	cPVMu2Sd/g5KOFD0IMeh8b7VvzBZASmbZB/5O6DpMx6XWZ62r1ZeTXQH7AQyh/rQ
	UrpsXVJU1E1K8K+2BZZ/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792616453; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:RyVb3Ywiew70+YoKr0b9tLUv9tl55xQKOKMd+adJM4p71bV
	DGqNkUz/GBbGwz1BzQcIDbp03onGc1Sc6YdRZYjrvtfcOVCukaDZkwMAbdp68VB8
	j9G5uaZWGrbNgbd9BHDgNw9Ig+C+41HqiIj/mkHqqq4RKzEMr4w2CutzSVJwOB6Q
	xxOs2QHxCGBS16z7mnR98VBemY5WVZP2CTdjlS76d0cQekjxzngoYZoXKvr3u7PF
	tOW0ga5hz/duFwwPH0xgZvCyb0LtQf3e9uIJXZzLwSSfNik0m6+04JRJC9tSu7Ag
	D3mZEzhZvIil1W8DoMolcatvQi6OdJwhtHABBWw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:aONhu+eynSFiczk3SXMO8ceawysiLWbC1I5Psbw7Aac=:LUnZAuQKhoVjZgNWd2Qp9P047vmvdgU7vD2duMIcUJ0=;
X-ME-Sender: <xms:BSjZarSvhx5I0Fqm3gWKQuGTQ2Nlf-2HQGJoTtyBQQ69hWnWj1CE_Q>
    <xme:BSjZajpuvhQr1F9ErjTM_Fr5FekljGLM6G0P-hxoEvBtMs59xzqd64kMrPDIA1tUR
    8-ff7mq5CQ-90Ms-844ICvDi3duT7mGI8UdhTNGT2GMqQ3eEO6vWHw>
X-ME-Received: <xmr:BSjZapKdp3hx5cUOEj9NmhDCd0dTE_Yjzph5h4Ga0vqRg2579aMLwEvH7529Miif361ZtsvPIImdvzlpLaWNHMO1KuFkoSz2-mD8>
X-ME-Proxy-Cause: dmFkZTFyJI4HhA62Xr1fmX0CrB3ZORVZLjoo7vict1NyEdVo+YYG1WnDncM1hZBzWrDyT/
    BxEjzsI9qadfsAHVvFkTl5oADjWxNfnUYD7NDGaw+qtDa5NnfM2lhJ+1ax/rUUQPUfgebk
    JMk73efh5Bkp2A2YBtfzTn2SbTi8VWVq+1Sulk6yqt2om28JAFXsCaAbyhow5R0LekWHAk
    BCqxx9L36evIlsSDEmqA4uYASYDvynee2mwMOf8grSZaDFYSRGGtqy2Ao6Mg61Zxss8SwF
    MqUCs4K/Cyp86bH9Agm6YiqJQmtyjzCu+ClyFJ6sdOTnbG5D//Tiqadd6qJS5VDoc44hFs
    ARPPar9HRoZuPLDVX5oBkq40kZXVbGobdbIsxqDCm9L/jRjUB8LVtiLGxdu6ux5z5akTWk
    IQPEnGmaS/oper6bP1OUfCdqoekrcbGvARKwKC3S0d3hEx5kiXDsN5dr2z6yun61Qnf4tz
    GVQpGnMJ0TWnvngwzWOmXLmq9O/mruNvVah3AwRtfysHsXE+4dhFHUW5bHJjKZ+Z+jjY4x
    ofRZ//2n3OC3UjzthFmYeIIC97B0bpxwPElvcV/kpX/G0X22FeC50RyJs/aDYYECd2k8EZ
    DuWrcoGTF1eDKeM0lXUb7IK48+r9boZrmck4wpg6YK5NcMjg6NbaX2oes9VA
X-ME-Proxy: <xmx:BSjZamptKFse0xwxAtG4iHooR_xtN8oKa-iYccKhAEq_I7FXFXuxyw>
    <xmx:BSjZahyPUSEujdoJkk1Fl90Ef8cvzEhsEaq8UcrEaTAEc8VfDYgsrw>
    <xmx:BSjZaqNwGbBmbzafqLXX9mklvXa3F_WXOTlR1sUtOd6sif2qGoy8Rw>
    <xmx:BSjZam6vhFw8268Cmw2HbxzbmvYLT-eLU65gisG-0E-B1XIGTA6_wQ>
    <xmx:BSjZah74YxAqgEJ_objC5CGWlfUUE5kSnL170TZRWx36I6G_Q1wlGy_8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 17:00:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v2 0/5] doc: move BreakingChanges to a manpage
In-Reply-To: <ab05a3c1-9da7-498a-a9bc-d586414ad0ec@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 21 Oct 2026 20:01:08 +0200")
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
	<V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
	<612b6065-9043-425c-83a7-2cfdbe140c4a@app.fastmail.com>
	<CALnO6CBuKKF=nCObFCK0coCDqbK=OJTWEshEtj6NaVV6XpWGuw@mail.gmail.com>
	<xmqq5wyvq9p8.fsf@gitster.g>
	<ab05a3c1-9da7-498a-a9bc-d586414ad0ec@app.fastmail.com>
Date: Wed, 21 Oct 2026 14:00:52 -0700
Message-ID: <xmqqy0bqlqez.fsf@gitster.g>
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

> On Wed, Oct 21, 2026, at 18:50, Junio C Hamano wrote:
>> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>>
>>>> Is there any interest in continuing this series?
>>>
>>> For myself, I favor making more of Git's documentation accessible to folks.
>>
>> I do not know about "manual pages", but making this available from
>> "git help" would be good.  It raises a huge question about what to
>> do when Git 3.0 comes, though.  Are we going to change every section
>> and rewrite them to say "we used to do this differently before 3.0"?
>
> See me and Patrick’s subthread: <ar0OicAaDipYx-xU@pks.im>
>
> You could transform it into a section at the end for “what happened in 3.0” then introduce it with
>
>     These things changed in 3.0. They are written in the future tense
>     [?] is reading about what will happen coming from version 2.98 to
>     3.0.
>
> Then you wouldn’t need to change any of the rest of the text.

The rewriting effort is not a major concern.  Rather, the question
is whether keeping such a historical document is worth it.  Do you
still care about what the major issues were when we transitioned
from Git 1.x to 2.0, for example?

