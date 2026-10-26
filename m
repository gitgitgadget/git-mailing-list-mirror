Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793031041;
	b=xJYXiOmMUUf1iKYb158G3eGuzY/XM23pOzd2mns/XMl+rzR7wl5E7Nx3rUm75BH31fVS
	 xrofhk7wpu+4svMbkmKt4Tjxqs6fE6/V5oJ8/KsM1pFZMQ82njGvqNux0HCc60TOqZPS5
	 Bu9Iut7bYsJbEhd5gS4UTOJ1ManspQLIY5o10P3zde4JDVEz0kBseViQUm5NEKTBBYsu7
	 TbJnqCC4z2HqQQPZXVhVU9tz51NvrXdH7QN6JnmjqrgVhVAo4vUe27WN+x8HftdIWb1aL
	 yGo7ydrOsr0iMCVUN3jJH9M3AFXfLB7seSLB1V2ryRpTwoE4ktl5yBkEnMiIAm3QiFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793031041;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=sURSVuftHAHUi0CJH/D6Hz0PlrbhpR3KMvKhnIQpZdw=;
	b=lSUZV6SHe5Alg1mIhDhWsiIStor8/Tzn/qm+LsnfmN4IduTMwJt5DV7KiqhlHVG5Pkxa
	 tRlvxx8jn5q25gLP0z2U04eBbDoGVj4yoMWSaEDBTRZC4sE7OXBhsn3WMhl+Acnu8DEIb
	 kRgN7dG77GzM8hezU4yYcQiIDQ5Wl+bpeoSpwp+5VBhNNWecERtKnW/ujQiaS8hI8nz7Z
	 n5Vfo73ZvvQgpFmB786Q1btbR1mmeYU05koGhODqqVLi6KeZLMzPmjyIQilQSpYNL+xvR
	 LKERMcaShUma8Da5IMI+W9622XlXDdJqsAWFe6EoEZqh2iGo7ZI5aE3r3+6KoNikOig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=XLAP3ImC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BpeEvC7c;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD55606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DD55606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=XLAP3ImC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BpeEvC7c
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 688F97A03FE
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:10:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 26 Oct 2026 12:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793031039; x=1793117439; bh=sURSVuftHA
	HUi0CJH/D6Hz0PlrbhpR3KMvKhnIQpZdw=; b=XLAP3ImCvPOOWu2J2KgqPTy7Do
	0CHxDZ05QamCWvmD8NNKD2yel5CEA6A3NHzOFDUC/MXMqPEguLTL7DVzoc6A1KRz
	eXIzfJb/8rg8hp0RpOPY7mQuJ8dudq34IsGbVC7sUssrLP9Q8W4PytW5F12I9fxv
	KGPClbfOUy/zTZhiqiByW0bmPRO9K35axWtbRaaZUjBlbMKXSvmou2TPAtprcgTT
	i7IrW15iRw1Oj2FSdOjxaGKJVNMl+BCOhsCAK0oIVHPTPDPiw42wd4SAJyc2B4dg
	9aXuSEwLmfpgzBMn9di2+BnXm8rv5h6dc3QWJjhN/RntMBwbPAvSRyCI2ivA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793031039; x=1793117439; bh=sURSVuftHAHUi0CJH/D6Hz0PlrbhpR3KMvK
	hnIQpZdw=; b=BpeEvC7cYfiiQsDyvyCmWyXXtMtMe3BjB+QdTeMS0lgdWy5Rrbj
	Ke4svIhPxhtEdQPGI1N8vSDOgdPrSjdLZslv383QeSzaCTq51B0i5Y4JGcobpHTS
	b379HHyt1nTbtSIAlaQAsTMijdxn6XiUvFBzJEzJvk9Kqz16yszaCqWFKvf2WEUW
	39X4i7yJGKziw/WrVTfSeZE72iBK4IHET8T21n+IXsaRD58i6Ec+YM7diUzj9+Jn
	iLClGZA0DZL86026HhOsZGps7C6HagpTMB3ycx1gh4OvShntAqAvyDZ4Mi0plH3u
	dPoLdAxlSld/1yAXnASWK9Biaj/sBIhpckQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793031039; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:h7ZW0wyCqKVuV/ZwFXE3HgtZ8yBV9FCSElepx3xfsMEc/iL
	Fb7TC5IG+74UKvgD8msGLnl9Hug8LliDT/UJrISHetT+XdBrv/wflP2v4LHB+W0d
	dd9CswTNre2stOnuRLznIeo9q/3vcpvbJDh2+CaOl/ezKZOfNQOwnC+UgVh5Tl18
	IJJ/ncXdAeKQ/c3NCLs0QJU05R1U1TSwOf10YpMvHg5eC7MUaxvydGXzhMK8e+Ax
	7LSWQN/iIZQwf/B4YAGMKKvMUf1h4qlWsZT1ZAk3YUzjuRy83fMxJEyVUlduMLs0
	na38bEr997+sxhTVXKiHffKWR/Wpk1JTA/3x2Mg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:EKGetRRi2oK5SvQuQhaqLxr+R5c09D4G50J+bhYwEeM=:ZbRPLOE1fPF3O7I5bQmcSBsuZ94PctLMox1DFQf7jNU=;
X-ME-Sender: <xms:f3vfavMYByIzUzHj1hK91-6bs8_2ez9eFw3eveP34tXIv6yq-FmBQA>
    <xme:f3vfag-yovpRbdGqPLHrM9CBQyy0ZBq9cxdY4LuIhrSEWpe28Kzsf_LzaXe27Lntd
    fdFyTyldw7lND8Astf445gNMFuGPw6iuZBwpAvjbQ6rNxo449q51A>
X-ME-Received: <xmr:f3vfajRY_XgriqVoTAoaolYdSUViuJqrs9Lq6n_QPBqHZ1SCyL0y4DpgiKgmuSUrlpSPpNmiNjK_lRkO5GmPCZPvD5JWIKVxyx65>
X-ME-Proxy-Cause: dmFkZTExst1pwDhfrj85/JChJum1FywMqqHJYfuWiJrSN5Si16dgWbHj3+wMLACTjus8mo
    wfrP7Lw+sWx/v7BdV3RlSqL+55gBDajTTMCoARqZy3CA9oJJclbYAizZnU5GB/U3vc/P3Q
    K6tY2I8+fkrbZ/Q00GSm6gs4xPTTVgkjzG1JpCDE6iQHz5Xx2ZRqMI0at8H5IX1HXyBQ44
    aeSvsuVNFp0uv0qMK8djBl/mUjZI2ufoXRdRel27/RIqv7JYuv7G2UYD6F9rH437ClCqgR
    n6wWdWBehZWxU3zqu8XJsI4Us3mfXof63Zys//VLLldnDjWQuG/scmUz1FWMJkcm/u9EQ2
    N2xRvIDO8E6j76xn/sn6xyq/c2d/IwNkDh9ju1WhviPGrybNV+M+jI+lKBUlV0V3YUaDhF
    paceSQ2Bx6WCMmkBkCfIJVLHZoLJri6Xuo772a5JQ1s5gf6JXsFpPR8z/A85Zrslok1sTh
    gvJo2FfMVJLC67CCZtWvIfqtVYJbsJL3rMXGZ1NPljunu1BZCigIUBo87whMuaN+tayl1v
    XJPGvMNBECuXH8bj7OT01TZr/Lhm8fU6y2VcWdcpaOqIXKCJB6zBd513l9jPkJU/xF83B5
    OI5G9WYRedztAGejBcvM7oP7J7OFj3ht9SfQIYYfLBEc/lZOYBNMWbZI5ROQ
X-ME-Proxy: <xmx:f3vfailULWLMA1qzE3G5auQTHh0lavu44NjvC8YTqMIvlgxmPOXA2A>
    <xmx:f3vfajTh9lfuOwX_u1Zn7JrcxfZRe3DFCGq2K-renWZhltKZBth_xg>
    <xmx:f3vfagPp-EQV6e1c7DOLcJdrt6bxjLdq7CXGF8Fdd4fP9nQ9lw_2FQ>
    <xmx:f3vfasX7AvCLxgiHSsxkhRcV3KLmn-VFcI6QnwZdD4EZz0LcBVLnFA>
    <xmx:f3vfajPvFrN63EinIi5J8aUqGgTJVlyh_bIl6i6KXTXF-P1b9raRVVTU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 12:10:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,  Git mailing list
 <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Make our clar tests ignore the long-tests argument
In-Reply-To: <at8LHqyBm9Y0JE-1@pks.im> (Patrick Steinhardt's message of "Mon,
	26 Oct 2026 09:11:10 +0100")
References: <20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com>
	<20261026-ks-unit-tests-ignore-long-tests-v2-0-fdbbefbd19fb@gmail.com>
	<at8LHqyBm9Y0JE-1@pks.im>
Date: Mon, 26 Oct 2026 09:10:38 -0700
Message-ID: <xmqqzew0sarl.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 26, 2026 at 01:01:03PM +0530, Kaartic Sivaraam wrote:
>> Changes in v2:
>> - Fixed the s/prerequiiste/prerequisite/ typo in the commit message
>> 
>> - Link to v1: https://lore.kernel.org/r/20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com
>
> Thanks, this version looks good to me.
>
> Patrick

Thanks for writing and reviewing.  Will queue.
