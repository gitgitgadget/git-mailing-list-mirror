Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792860449;
	b=efouqRBew8OYM4WvSO5MdxSgk35O/BM19Ao54QjGxruZ5l3FKdUOYX76jRo8FtrYDX3P
	 agXIux334bQ4jv2BzOQot7Zp9XXla+yilMye7X/jF27G5Cur6D/pAmb1m4PCRB6+NLV7p
	 wSHDoOfq5ZrnUw+UO2sf/h3+SpKUjQdkxEBLgsZUIgPef0uMW77uJc6kQgUykZ9bUmJHK
	 vkPlnHEkpRW6E2lfIYdnAMRhk3255onxnaUHrCtNTfwzGcOG7/ICrYQE4OOU2wNR8k+Mh
	 JyUS1zb8IGsSYVJLrZnxTdSjzgAAJsLbTLBwejfobeX8MlMk6tQlpb3Z5+32NqiM0Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792860449;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=8BDe/UBO6ZHL53ijxIfNIaVCsAYLdDNCUu1aF20Lq6o=;
	b=LHRzWzWJ9rdn4FDXTIrsxyqpz61f9ZXhaitPf9BnukLqfxt8iNy+cA5QhgNJmGsN/ZzK
	 1l3SzG+di6lvkq0qxrgTh0Y+sN5sQvgPvygFfXZtNa9bFa/dgQKC0S5XWUh7cj0ix9+1o
	 UgR2Cyblz8uACIPZY3FldXZTQZ50iOUgc/3TGbLbWJQhrpVHOcxitztHhU3I+ZoiwwuY5
	 euYqGsj23rqIdwbZrYxciwzDsGxRBh2FdNJyhfmRi8FdQkWkwWpoDvlc4Ae9iRo6OTkwZ
	 aGbe3N5Kk5nrDry+Q+bczBVCaBbTT/0+j+qkdlEj5YSvCsBAghI1/Hr476U1N6Gpe5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=e5aOcoIC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="jYEs7W/m";
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD64606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 16:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD64606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=e5aOcoIC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jYEs7W/m
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id D3C331D00169
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 12:47:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 24 Oct 2026 12:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792860448; x=1792946848; bh=8BDe/UBO6Z
	HL53ijxIfNIaVCsAYLdDNCUu1aF20Lq6o=; b=e5aOcoICUEAZW6Ny1SWbiZhqnE
	pHgEDzjNg3n1JqB0Pc9cGpCcyGRMZhsGJZCTleyRf4xrh06NxLolS9Yj3tKd8Umz
	qBdkp9Bld/MGnKPW0YDo5tzh8nhVLxvl4uqKGywsTEPclzZn09s+2he8TAFiGtdU
	KT1c7QK8zpWQ5q69K2lnYZ2hXirxecJKS54xIdLDqYiKaa3/EY1NuP7lxJYa0ET1
	LtYRf7QPLZQnkDsiawVY4dEZmtC/iHR58SFwLdY7kfdooueCtFV5JiD1HG8n4P61
	5Q59waxmzZ06J7Dmy8NfY5M7a8MqpJ8z99eyk494Qr65B1GZA4nrZkETP7Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792860448; x=1792946848; bh=8BDe/UBO6ZHL53ijxIfNIaVCsAYLdDNCUu1
	aF20Lq6o=; b=jYEs7W/mFjsMxE/LLZ2ATIboSCV7J8bQExYPd2OmPqRCJ1Wdyky
	QHx2LTWaKBbx+nOh8yT0/tOutR96I7icwJWk1rOEA/EUYaEuMCG1uwRrYwzwt5d/
	JJrUxLjPjjdpmXW8d7DIZyEqSSirya663IFbnpluAr4la+pdGVmDHkwSzJK2a/Vg
	0jttLekxhgJk+PO1DXSdTaf/aJBfBl/FBURHgPa4N9twN4cLtDoqKvbhFK2NnB/a
	/M8DWp+IUYOIxCYdaRGJPK3J7/4nFOzxSvKe98Ci5XvvcGXzb5HRBqcHMgBcI+uB
	WQd5UKOypsurc9P/hPbBtIxkGJNDcYvJi/A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792860448; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MRN4LVBaJM1KICT1vvno2mSoGIKvEDXJklZXY8P+9PINWQW
	/JAv+Wrp9Q/SP99tIeWIj1fpfJOLF8X+UMMqJOJdxFMZAhkjGa+Cm48QXp4/Hs5g
	HQq1qrJViKmdPoy/a5xNwM/womxtDnd7OJqJV1lP54JVZ6EMb5FelKvV5jfqEyzu
	9gXusPCvMwhikpYIuU+eodYkVgCrlZ1f/rZijiDzrnpLlZ0dcIrUoNyyZBwX1e5g
	o9eUwYfmtsZGMAN+Q0NowLU2ZnJAzhUS0OtE9SoNpjYsErudoQQrJZNYiXsS2Gys
	2sv82FzJoBcUaE9Sm41Ouim589Fgjt6iOF37qLA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:duDmBNsaBoceG4ldXEsFDSdYkvc2O1yTK56W5wx5WRg=:NEeXn54hoHOzLycd4mHuMBpus43frle2U64QUB0I6PY=;
X-ME-Sender: <xms:IOHcaty9np3LZ2XdeEIICnv2bHAyyJNcTxugRiSV-5jqbk_ILuDoSA>
    <xme:IOHcakQ_Ke3lBW4pqqHaP_J2qgcparOqps6_aqu4346nkTGLXHGj5zX4Aii5ouET4
    IQD6g5zgjvNHG-H-VADR9_2KLRRuLEwWBZAG-NwHmlab9RG4-Y7ag>
X-ME-Received: <xmr:IOHcasUVAcJaSPwt-BLc4vskAyWjAxXaH5xOD9uD5ut0xWdML2VRQX_U1BPVNmSi0ntoj659UZZsSjtIw7f2wnhznc304HVhTdMh>
X-ME-Proxy-Cause: dmFkZTG3klVwWSFpMTOEwv1ACI6QYwRCG3oo6We/TtlaxFSkZjo70j3XO+LsaTSTsw9iA6
    xNMG5F6vGbLzTKROysjbEe0PWRCv8kDyXGLMJ3AdL840sy/7tE665zbCvltiTDDHSidUuY
    CL34McvmBMKOCoh5PYBR0FUVUt1SminJRd73YG3y5nT3rOBF6jQ5FM/Gc8RslA9nO933nv
    FKtONwPNtaFPGA6wc/rImTFgEKLEY7GcdSvnqIhDBa6Ff7rKrVlwaxfl170BFQBVH79vl9
    Ki+sCYWZN1sOXcxpFJc0PwzdhSTXObSLda+XIcvN9UN5aPEC/hrk6/70nHHRI1gnanwMG6
    srHTAtSXqTe6fIoSTRErv5PNSEu9Vn/om/JYiJaBFVXzbLDF9XVzYnsqsa44+qQU3Xr0ko
    mcbrJHnyB7E5MXNM8x+i76Tz/NlbMKgBuVOKeUCatlLw5ZOmCbD8SXo5i0KUwH+2JvgW0n
    /lHkM118JUHfzSJazfF5GtNqs91cHXCjBYfL2GxACXR0kUBM1ai3BI1qZHRT3C0xaKJI3w
    flhacBainkQcZQRz/HJZToOXcgEbhqq5d1W/ifaskTajGqmvm9Y0GZRsWCnqkIQ1c8I5VI
    WcfUU0PFw6j32ytTIjY/PxXBgfIGlEtoGI6kH9JLDXp/Lm1nvUKzDjBGB0GA
X-ME-Proxy: <xmx:IOHcauZQwVREX6ayO7d2tj0njbbwJ6FH6vhv-Dol73cUNc7N7Arovg>
    <xmx:IOHcaq1LR3psILzUr8DbkKf6hFGEDMAq8ZnvR8FLv2mltAvXbVrVzw>
    <xmx:IOHcaoj0ajbTYGLhxDBX7RBvps3c791a-NTI5_uwC_lukEmgQlfiXQ>
    <xmx:IOHcamZhhygW2AfzLM3jL1Bx4Okgt8BBUrmFvrlCgSLN_g7S7Dcxmw>
    <xmx:IOHcahmWQzUdKZq_TDL3470U8AT5HnCMyXCHQEu5nn9l4kn62WokDgL1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Oct 2026 12:47:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Matt Hunter" <m@lfurio.us>
Cc: "Colin Hinton" <colinlewishinton@gmail.com>,  <git@vger.kernel.org>
Subject: Re: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD
 validation
In-Reply-To: <DMCYNNPMFVMA.S74D9Y3OQ9QE@lfurio.us> (Matt Hunter's message of
	"Sat, 24 Oct 2026 05:28:46 -0400")
References: <20261018235508.848-1-colinlewishinton@gmail.com>
	<20261023185007.21642-1-colinlewishinton@gmail.com>
	<DMCYNNPMFVMA.S74D9Y3OQ9QE@lfurio.us>
Date: Sat, 24 Oct 2026 09:47:26 -0700
Message-ID: <xmqqwlr7yrj5.fsf@gitster.g>
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

> Besides Junio's whitespace notes, I have no additional comments.  Looks
> good.

Thanks, Matt, for an extra set of eyes.

This however has some textual conflict with Harald's work to limit
the set of branches to fetch with refmap which keeps this topic out
of 'seen'.  If the hn/fetch-refmap topic is solid enough, it might
make sense to wait for it to hit 'next', and then rebase this patch
on top of the result of merging the hn/fetch-refmap topic into
'master', to avoid mismerges.


