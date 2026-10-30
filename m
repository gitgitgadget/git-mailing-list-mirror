Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373140;
	b=Gzlb15SOmpNAMnND4ivZqfxsVhi8Tbi29MAHanUD5XzZrkiR7FK18/gHmlepSeyKVonz
	 DLUbfdE/6avUU8vR7ReOdjhS/dHmSB1QR82N4kJODKKrLMe+a/3imymjs2zjDn8VfAbm4
	 Y636q5o2TmJUl5ZRSKVJhJSlUs/y9zaxNenkngrf7SGyHdDqylzpeVmW3NOrhcA2o0jp9
	 tWfCWXDl0NFRqxXWpIQ4+Ht942Y/Jj3aAkYHBFvr9OXJU92f4InpbDx6ThMRdxJKJxCJC
	 Sz52dnbPB9HXG6A6Sd32Wv8UxllRj1stXdoZaqhxrCy6u2/xKvk2a0TZYwubtzYuIGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373140;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=uj+QA5SoqAKRc9P+zo6bD/5Nn1hGgJayEFJTN9loSSk=;
	b=v/sZoFTgOb1Sd2ctmjHfGK5hJjUhR2bHvKcZtfGXvpj7F9t2bsF3a3Vutfb5n87DKt3+
	 K1r9h/XAXwAFsSZ3JVJJtULBAYLpYwyVtR4bXi8uKEL2rBAcwkOSpdrq0el0qYCLFehbX
	 EY73LvA7lAuKFVgWs8s8tKH44ZHZqzie/SGgvrdtUL6caVLnIO8eNNqC0Kruu3b5APhVA
	 NavM+Eq5UrgIpDQ/EGpcVCPFAwOHzZr07aZkmfD76W62q3QFCQa3Yawdhad8N3/MllLpv
	 1kjQlTLflQ24wdEn/ju9y5rfiNSU7C4F5m7U7TbHeO7JneCUF7f7I5EwFDbpG1b4ASA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Kt5jdF9R;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TbPdXkFP;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D60606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 15:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D60606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Kt5jdF9R;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TbPdXkFP
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5200A7A00AD
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 11:12:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 30 Oct 2026 11:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793373138; x=1793459538; bh=uj+QA5SoqA
	KRc9P+zo6bD/5Nn1hGgJayEFJTN9loSSk=; b=Kt5jdF9R4jWcfKOkdMT6AKLOVB
	ByzN5y6ErWQ8wFzIk0DH8Y6gWMj4xWlJjJh0r72o04V/WyOIBeMxkBOrU7lGBg3n
	w1fMeFuzrQyfSMMl/+GoL6wVurvtDz21RbkVv68KNkv9rqRJ6oGaxNlZKh5PCsqt
	0xQJsWOVs2uSrc3lfY155ZsfAem9BbQI709qsTfVRjhcaeky4FAvalqtgXYIYPHv
	qgeUh4JIihnilIOdwjk/DeqflD7RLhFUfodxMXJsXm2dX9DbZwxUalw3/M1BsZbb
	99gS48aOcAD2V9eV1W0iDqD+c4LirdpgVm3FthqiAvLWRYO2QRcplyBvd6ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793373138; x=1793459538; bh=uj+QA5SoqAKRc9P+zo6bD/5Nn1hGgJayEFJ
	TN9loSSk=; b=TbPdXkFPN7Fr+xYghIMfjh01En3t2JS6kT3DK1JtnPjxQLVvNLm
	r29fHYB9det7FP4m3Vs5wswxD+oBsCQaJ2XGkxtj1imsocMoQtmkJflkW1mDj3xl
	B4UWjb5H5BbJxHhvJbC0+SQ+EmcEwRlQR+NOHEgiB4NPgBS4wBFgSXTNEaGoHzxY
	HMT3f7STNZ7T5mNwlZOo+zRxlAhVD3lfqVhCwxOqHEoB/tgq8VRAasWMBZU//298
	7QbP3F2I37/KBZeCmtaUjNUveTZZR+Nbe3EqdJ53AWFA9UFqyvgamr4/DzYc4185
	ecFmL05R6d6Qjx0FsrwNatuPBoR2HwYKThg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793373138; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NmQH/k8JZxtTggFVOvJHRUJm0H1bbzRScqlydwPZHqKL7tK
	JXFUxQ7wILq2k+n+ypLknRO2BvjoYDS8SlUl3WWN61IVGWc5iMGwckLUtgKnyrBd
	5ssJycWzgS89RUEoQt58uQ8UDKk0ezjNoJKcVSwLSrfPd1uW2ub4+nqFDNWqZYbH
	iPGpiAhGXcMZj1CSi1ASOxEC7J5lRYCgUYPDHbtp3gqgI2lKHCyhJYlc/Em9opC1
	7Zo0HiqI83NJs7PKjaS95ea/CXjByBcNlZWiNMsLiuiosGilsZqz3qSeMAtfYnV2
	pcm8DOBT2+w2dzNVT9JgYvO/r7kzfZKxPgAnMFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jn91wI+/KxnS3+kDgtZOlx+rA4qnBKwnGGLqrf8cJzQ=:uj+QA5SoqAKRc9P+zo6bD/5Nn1hGgJayEFJTN9loSSk=;
X-ME-Sender: <xms:0rPkahlG9Kdc73hwPLnnfDuIGwMX1o4YrqhrzTLSR99Gh8RliXfpqA>
    <xme:0rPkaj0PN6rybcCUt03y557hDnb4lEt9QOsCuNzQ_6lx-HmLS8d3WEP8GvKZhPIb3
    MZIt5lli-aA9r-AxdgtPPVVQTAkkAEFjTqLb1E9QZw6okzANFYI0w>
X-ME-Received: <xmr:0rPkaspYSFHE6yyygRB8C4fGjxSgovp-nQSIHiPu8J1p5ltsnaJDO3NoaR0SMlb57aiu6UGNAzRZUrceQj8Jlq9I9nIVz5gIpyBR>
X-ME-Proxy-Cause: dmFkZTFxEmn+dh7i+9O1l24GpT+vX68YgIIyNo0eBZia3Gqfht7wmmrPOUQcBXqlLqPHY1
    iN6DOpuBM8mot5NKE5G4JcB2v63HQoy0NI9C9H1Eq/d8g+ue4e64MuCyXagOGHPJOiDekp
    4XKatBIfqitBFWe5QgO32ZeQTAs9UuJD3drgvmv5Or7rneD/q505rbusjd6K4qvAXBPO0N
    QeOu0srV5pU7f27C5nz9uqtR2PfQkG94Euql+12U+5JjPLOSTVEQ7kZFQOpeCgNGCtXxWR
    0LoVuloMWYQMnZBcYv7cI801dxQ3Dt+CdBzaeTmXqamKySzIAc37nZf2jU2LgHHUoIYSsb
    ZSdhN77Tu3br+tIvxZ59w+iCZ6pJNISnsnedm9APKsWVpLpZgc7QDjqNaHWpfB2y69Wo2N
    HFPee2DXfBerBTqixfShx2x8I23Q7rNjC/koCx9Zx7Maxuspe/hGjav2SARy8VipZ2TERm
    qxvqaj17lsBOqkF33MbSfWqwL6jMlUPmNlN/9XGTkJki3hM2OVzx7zBn6zyhaW0Dn0X94k
    Ec5n8eNO1appJMYsAxQnhgIAuylsd50GklmkvKBZ05hECe8pHNkGEn754ShUwh8QGaCFpb
    HV4jCGuM5F1vDPc9bFeL8lE6Q5hll1+S9H21GOU+1xiUy2q+tuCsqLwAm4sw
X-ME-Proxy: <xmx:0rPkagdY63ougiqSmn6WN_MyJr61ExhVSDwLxmf-rV3GnovaWzGl4A>
    <xmx:0rPkarr6_6zqoMokmh-ppXJ3mENhhEd-EmpPH3ThrnmRMgsm3FHeFg>
    <xmx:0rPkahErT2IA01jazs-WEu5TY45QNw_txl5BkJeeg3jPDRZ3ZudBkg>
    <xmx:0rPkaruv_fWCw_DJD3TY7bHraL8dJ_EyXB3F8fdqS7QeIuUvjdsUeA>
    <xmx:0rPkajZf9YQXIJ64ul0K60y4wAMXBp7FhmwKFxB51Zzr3SwCi4yGbX1X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 11:12:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Matt Hunter" <m@lfurio.us>
Cc: "Colin Hinton" <colinlewishinton@gmail.com>,  <git@vger.kernel.org>
Subject: Re: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD
 validation
In-Reply-To: <DMHZCS9LOW3N.ZJ3947HUCXZ8@lfurio.us> (Matt Hunter's message of
	"Fri, 30 Oct 2026 03:04:55 -0400")
References: <20261018235508.848-1-colinlewishinton@gmail.com>
	<20261023185007.21642-1-colinlewishinton@gmail.com>
	<xmqqecdezfr1.fsf@gitster.g>
	<CAHeTm9NOqLA=BfTU9ABDFt8+jOzaRDPRrMNP8thzAQN2NVZAew@mail.gmail.com>
	<xmqqmrrxdhox.fsf@gitster.g> <DMHZCS9LOW3N.ZJ3947HUCXZ8@lfurio.us>
Date: Fri, 30 Oct 2026 08:12:16 -0700
Message-ID: <xmqq33tnz0hb.fsf@gitster.g>
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

"Matt Hunter" <m@lfurio.us> writes:

> On Wed Oct 28, 2026 at 10:26 AM EDT, Junio C Hamano wrote:
>>
>>>> This part of the code becomes overly deeply indented, and more
>>>> importantly, the outer conditional around here has been reworked by
>>>> another topic and the code that learns follow_remote_head will have
>>>> to be reused elsewhere, which would lead to a nasty merge conflict.
> ...
> I wonder if it makes sense to incorporate such a new helper function
> into the existing 'get_follow_remote_head()', since it would be the only
> place using it.

I am not sure what being the only place has to do with avoiding to
split a helper function out to clarify the main logic flow, though.
And simultaneously, another topic wants to have this piece of logic
twice.

