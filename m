Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440592;
	b=CYmPs1fR5wIwUS66hsbP97z3o9KURxWBytXtCvHm3jgp59v6lGbmYZMNUHuNYM1X0+25
	 VczXa5QfkHSnrBKxWpclpFvLb4C2US/XaP6afmEkvlgtxwVAt9FqN9N861pJ+kTrHfkDy
	 LvUkgiNt0gdNqDUhLlNjQ9pn61dzWi3U/Y+sgtOcKGct54930C01uATBEoEIUHrMDX1Yp
	 T6en4IcKXM0PZrIfcrg8kYBBkT4kVabqLSh8SN0o+BQh4iVStWJtpUDp7AzOUdZtBzw5i
	 V5eTfmsKQclDa8yNMu269UkSeKSmSxrTvDK8BgTI4J2/3bj/eFmDW17b96/QWQocmWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440592;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Rkl/SJtTuyhbUZPuVBC+tHoa2CiY/I4TZnZ1tICOFto=;
	b=ylx9FUCCbYyE0DsQ2QqBBBYHiBu3E+OxAFi8DfxokKdL9uubLBSrAFkNKa9vHSBiZeDA
	 FOmsKsHLkVdTEo5GTVBjO6KXBMCuAU3qs0KMn6tKxBJ3S7idE5ew/4cMllas19wKRihR9
	 MS4+ZP277radfiN7vRAOjt+CZogTvfthThnM/VO4+YpWPRmC0yhFtmjRCTNj0YdlOVahX
	 bs0a5Svzo0VaxjOc82CJZMNuhWeXz4raKeN094NuUzATEAEJPO1DDP+HFjJZJh0I8nd4x
	 HHWSg5EJXzMCrnDNa7/8tW2qcSS6H6iYxSHnM94Cky608ea87x87IldYEw6jC2SkfwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="T/JxZ9T/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MvMjtiwl;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41590606A31A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 20:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41590606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=T/JxZ9T/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MvMjtiwl
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A85C6EC00A7
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:09:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 19 Oct 2026 16:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792440591; x=1792526991; bh=Rkl/SJtTuy
	hbUZPuVBC+tHoa2CiY/I4TZnZ1tICOFto=; b=T/JxZ9T/DeZYsMIeWcP8k+8MvV
	A+JgjvFT7Yk2gRwSXIhVgwhKLw6GyoQ3z/srLxcYkoRWj96RH1671z5SjgH9Rfpb
	c8Qul1jCXG0JEUVmFA8BFI57DF7e9SsTThs8/YAb4yvEo+xuzcDy7L5sbOxtQrIo
	gigHeYL5Y0p+1IkKwaJKo8V+pJoFN83wb4GFFOv7xDdX66KYfQCEslHd/NAxVrN3
	12nip06KUA4YqW9PvQ+egcuLNr2HCyE8LD9antw6e2tcW0HkGd3gUQNkdX5uAutN
	4Qs3q2dWYUHlAYvQku+H+VSEMT05KmOwGR13ytlWqEkpiSs/4kgl+iUBMxwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792440591; x=1792526991; bh=Rkl/SJtTuyhbUZPuVBC+tHoa2CiY/I4TZnZ
	1tICOFto=; b=MvMjtiwlBkcaypYHgw8egurGg8IpwXFzVt3VmUDuD5V4V2+N/RY
	IvVt6yD1r921MZCQEB5HHZLuGQ1XuyzYfiE2rCM508rCFPK4GRO52ziCwZBC2j9T
	67XSHPrormECipO2fIjtBZfGPncNuOVQNw7s42iWZqtP/fSEW6F4wggzVwNEExt8
	ylpmqt4O0CklTWmE0BRTxFV7f+p07crRy6UeUjQN8FSrjS5MYTH2ngPQjpsm49sP
	JDkgs2kCW0r2iuM48CPoK6R0fwljZnJ2yAyQUsD9356IAbk4FWF8qQviZn8IiICT
	nUE5jBhBJswi3Bt/PMbm0GzGWVl0etNhT1A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792440591; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:eunOdkOLN5tyt/c7uTUWHDKpkSmGVYkpAs1HhNLv1WvK+jg
	2aXKTrG63kB5uP9i1IoJWhOX1fbzpiwhDQvUH3UUoYm2nD+zK61J5diss81V29oO
	jeqOS/DY76V/3pMls437Eqrax47FIL9XSfPaNe7pIKRy9xPmJfu+d5mTzKQtLHNC
	JEJMcQSSo80vFqHr++ApIwzWx9nGnvOTGmaBo3k/xUeUytrI++3Tep6oyTjN2o4m
	VXC3frl3us9+wOtsAH50JTJBFqBWe6N1EvS3IPoxEF8/WJsSkHF+7UawkLGCxT5H
	oR+OS/msP3M1wIlvocaVsgcQMeF6bIhP9Uth4HQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:fGWv8sAlptKP+sa6bGNCM5DR1Y1VIXe7ah1FFPfVUHg=:0AcJOq5KuZ2bYSuN9FKZldKOFy2Tyqx6BKBhIv8rknE=;
X-ME-Sender: <xms:D3nWaq5VocEGOBzSz7cUiD3fCkuqgKEha3RSKMGoSzBqKjiaJUpcTA>
    <xme:D3nWaq6PQqinhIeCK30L--_kWdhMRlMU8wB0GGiYUzg7bo5mHoh0WgtkiNqnPigcN
    L-eHGJFY5PuOcjxvZRscwdswkMlTlVrKnCxqfgTLTSo_VZ3mO72yY4>
X-ME-Received: <xmr:D3nWaueOvzcrBtBSjuA--0hyIPrv5QJalzGsIZLRMuquNCC2wS3o9_uExZt7tdeiXFTq4SaunyVMmgxrNVD_c6xRirXjrNQb7ww5>
X-ME-Proxy-Cause: dmFkZTGlqZ/1sjnpdLdKDaXZ/NgJUv7feDWo0/xQaetcCfd3GgIpV4JlGTNL8uUD5s5ueU
    BIuz/yQNhhOhmdLOrp3DCZOnoCjgRMuz85HohOjzo50Jei8LZ2E4hg1/p2k49li2V8q04O
    rC1+ycskl7bm6fkMw+C0YOv2gIo3C04QeqnGNMsVvVkAaoZvSzoDmtLEluRLqeUYHu78w2
    AkrepK94BfZXAjfGQ/ASY4npQNF6VAZ+Ak1HYoCi4wQ/A6YyrmhkBdeUQXC1B+6apm23xq
    jsnrsSgw5fhW+mC3JH/iXcfRRzNOgSfy3SPUnQdlIqgnLHy0r0toluKki8JZk4c18LMxMi
    JTKJ0twy8a+LMCv+i4pLsdzgp7b1vlkJnsPYTMX+QjWelhlphekBuGmwzHkyh9WBnYeAa5
    +pRrDzn6L42jKdAXyV0t4kCaIpVtrlnWC+cIcqTlV/g3SzhAWHYk7FRdD8osfDZ4/rwvb4
    1AKofKYVcwje/op7uc+HAoALVK3GHlxlsTD3yk0tkprG6kPxs6o6PNDHH1jYEEN8lySfTP
    RHODTYYBka9h0A9DUX2+GW5xyJV09ebUhfT4Mqd4j+UvkaOB8wyoHGiHvGC0GcceJmBO2D
    bqg9KMDplGJq0PVOTM0Vs3DZXrLR65i1C55Ab9qb0qaMGaXx2iUS1i/+GYOQ
X-ME-Proxy: <xmx:D3nWamBwB7-G4k0cqjDM94Gq7FO30DWcudvYu77aiKm8mnzP9PIBvw>
    <xmx:D3nWap9O4ooK6pyq6RwoU2QVj6-ZnAkoaYcSpGIFVCMHM31a2ZH0qQ>
    <xmx:D3nWapKhKCDo9wSWf0bFaY3aCdfyllF6wm0yydRFLaux5UFY0bkTHw>
    <xmx:D3nWaqgK-UhwNbBI9iZ_p03BP8DdRS0Qhjj5ddnMBDw8afmrLdJnig>
    <xmx:D3nWat-7jJrcIkU4DvzpJoJy4wldmcYDsvxxiVVPkAji32ecfVDLBfcz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 16:09:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] gitlab-ci: fix "check" jobs with large merge requests
In-Reply-To: <atW_BmTQhxFRLc0a@pks.im> (Patrick Steinhardt's message of "Mon,
	19 Oct 2026 08:56:06 +0200")
References: <20261016-pks-ci-optional-whitespace-job-v1-1-f5693fbae1a5@pks.im>
	<xmqqtsmlftwy.fsf@gitster.g> <atW_BmTQhxFRLc0a@pks.im>
Date: Mon, 19 Oct 2026 13:09:49 -0700
Message-ID: <xmqqik2x4fle.fsf@gitster.g>
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

> I tend to ignore those myself:
>
>   - "check-style" is not all that useful as we don't fully submit us to
>     clang-format's style, so whatever it generates is not authoritative
>     anyway.
>
>   - "check-whitespace" was quite useless to me because it breaks rather
>     frequently.
>
> I still think that "check-style" _could_ be useful, but only if we fully
> commit to clang-format. It would remove a whole class of nitpicks
> and thus reduce the burden on both newcomers and reviewers. But that's a
> discussion I don't really want to lead :)

Hmph, I haven't seen check-whitespace giving useless false positive
myself.  I tend to agree that check-style would not be useful as it
came fairly late to the project after all the code have been written
long ago.
