Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243236;
	b=T4E/PwKaorLpj5WTSwvjUIPCRqfFDPyaB+AFIZBUKVaY3EpLnNs20lnLFM9VNEjwIgpL
	 iQ46TMaDP786Hgo2+TGYOafPwAgSbkKvqhpv49lW3/8VI/xtIyaHUb4UVNDqo7805WNOO
	 kGBe+rDRhACppkr5mi1Dd3fY4iHQ74YEToe4xJrSJ7t42mqnpisPXN43TT8f+j5EDNF9j
	 bB24zYJ8maxe4f2ubMs3x7qSjPbth0XDs/8sCIkV3IfCv/6cj7vsm9yoCerLw0CViYbJ1
	 BpAy3eymbnaElwdTvEdEseaxqAwvI/aru5kT+nzJHuDXF57NUjj6cfmvawgWUxjvBKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243236;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=a1qFU7aAFwyd2JJ+zCuGKU+yaE3Z6K/E8uSnAD8WUcg=;
	b=DtRdohM/zLwf5E4JnO49yDW/ySz053WCk5WVf9O0S31CpQS0eeaTNfpri1jbFjl6Xp4t
	 CRUvAGhPyehw9hHr7vLHp3e74/+E3kSZUsMcduwUB9xrt/ia5wNk8ytZdeaU5EJuzN6XZ
	 /WMSFAG+GkFcE1GegrPqkAbikNrqA+P1HjJcBx6sXZTNUQwEAVc8qFN6ka6isKwepCAHe
	 NcBPxL7dOBp3ruohVtjMVWH9SzeYm4H6Pd6BX6VwWfhEngJwXEcREyNE3M0K13wyJD1SK
	 B3cMZ7lsGjtvNlW+Ou2y4mI4lJMeTDb6bord9I+/dY1mPshrNoiPzBzVQeAkjRrveGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fnWZOoW6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="M/8Wjf1u";
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB92606EEB6
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 16:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFB92606EEB6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fnWZOoW6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=M/8Wjf1u
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3EBE51400179
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 11:53:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 09 Nov 2026 11:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794243235; x=1794329635; bh=a1qFU7aAFw
	yd2JJ+zCuGKU+yaE3Z6K/E8uSnAD8WUcg=; b=fnWZOoW6UPVFPUrvtNLhUHR7Zw
	2Z3D2tVpqDsT3ZuBTqjNvW5l5Swv6U7U2TkvZAnDJTDmu5ztzXHby8Wczw/9HaFB
	gS4fHlZS2XbPSXdCZGhJu9fmF9ADt50rhA4tc7ha1nMhZDnUjLuBeAlrbc9x0YE8
	NMqIsnFHptoZfZJS9NPdToAIMcOC0MYLaXiCtk/x9AHWtIYe3/2c8AhJKSVghF90
	MlAztJFqPSImDlHrsgYXagytAuwW5HiIzV0tvwXKjmAGOMQ/njQdlAFQyQqglKrl
	4qv0uDE40C2Uklt8iLpeK5snrFfeHqoneh85c03wM0Y3G+0iE8uVZCjn09aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794243235; x=1794329635; bh=a1qFU7aAFwyd2JJ+zCuGKU+yaE3Z6K/E8uS
	nAD8WUcg=; b=M/8Wjf1uCGD6IdbAfQTTclW1i0BdW0SB6zJ++ZQBpgF3ZSW0zLD
	gQPh5cIW38Kb6kN1k0CWzLIddlwV3o9hC9tqJbGdwmXyOUfg4vBBB3qdgackgciU
	pdh7YTu+ZJW9kPXa+IrZjrxB5V476ZrRRUrq0YSYg47rvdmux1IJZMZMuBwsEZZP
	DWS0n4IMT8J2ktyMYjedGa80sQOnw0L/lt6e6/Z3LOIuCPTLYReOtwVI4BSTZcbQ
	Gw0EyMRoC8K5pbe9aANYkK5qdQHRsWfAmvq3Qb+8GqygyMGv6NKsobFxJTuKMMMx
	uRvW9g9WXQS7nRu1mc/5wQ56+vFS0SOnNzg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794243235; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HG0t61EAOqrzNUu99kjpu1BtYN+abwyuTq9GsNnnek6vOAI
	XGRn7jv/uy4bp35S/UOMkMURyE4uA8bDQhhRxoJKpFgIEd8/45cn5n/VKssdgfb5
	JQQlLeeAxDoPlI3ZMxVu6DlZoQht+VhnFnJFLs9Y2aPkdNxz+fQkwpc29cO85Irb
	ZOx/HnpKqOj15KM/fh3RyjJVWi1MaqCZW6JNar4P4qc2DOiUmQTsfKkJWsj9A2/9
	5HhJvW7yxXZ4d6D+yzsQwpp+ahe2B4Y5r42yzbYcgagDHB9I7t5PRg1N97IKxQ2V
	tki3W3Ophi4+LshbUC0G9kD1KcMq/POjnGxPZbA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0XosmXsmADNahMpbjIpTk4aC7qlFo2F+fpSr9fno/c8=:Y4Kcja47OhDJFXm1s66j1xTxHLnB03H0hhKn4LLVlWs=;
X-ME-Sender: <xms:ovrxagle0MtvsHJ1Y_KOmMjtAEbnNbGbTl_uP3AYtP2nQS_crHUTMA>
    <xme:ovrxamsGrZXSqkvPTq97RA2PbbFlKS3SDzDINzoVuuuUr8h2jEbZmw5XwrBIUPwBr
    DU0-Q9Gy3EVe5Yle8gOdTKzKywq_aALYln6tof1wJfharhU-OXnCms>
X-ME-Received: <xmr:ovrxam9wJoZpVQNRW7zjWnpUR5tlEirgetIb4htgwd5ucDVaPjoq4sZtuwAVgQsZ0DiKcy81VbfsGoyiFjCVHIyl5k2maGwSD7ZL>
X-ME-Proxy-Cause: dmFkZTGQWqeZqocqd0EkH0aY2fGxHb+EHr39Udvk4GjKciKw5M1CJlTI7rfAqeQMNDvO0D
    2hnHcpxl1oAWymzVSdVmQ8uL0O3FKuAChxle0Mykrr5+Fi3VJKCBvStaPN9/fS3J09FBDw
    InfOY+eT8JtANBtKeIqcPmGpAAisNxzoI+1Y/GJ9hm1FmSlESQb0go+7zmKY/CAN/NLjP4
    wEwPec2ItJikhqYvGoeOWjUl0SecH67FduLjxUQ63mzhZga1xLC/ZeWK8OOAfun0GKw1G5
    bm1RgEZIFkwBUyhvsSRTeg62ZDUwTniMYSKFxxqw3/aMAaqO1KmlB3lN+2xhhXqChZhWjx
    xq4tAsfq8kCT3tztQtXIQeepHcsrthSCKUnKG+c/NEf7rKgNbRr+0+5AWR5m7Dv6CXTi0I
    ClIgCNwYEADCakFQEZw6/5ui6VL5uAnBWVMKwOgpINlwzXALFX7bjzDlRH+LrRe8gelUCI
    DXVHvSLtfWt+9hX/qaTQyuMZA1b/9/5lZlN8KwkFVH9w1oXbFstVFDZPabChqo+ZFkU21U
    paCL1CVOykGsGQAH19Ca9pAsDqrOUy3/8fm2m/cte0oTA9T2FpPZ78GqSm4qyI4mtgjJcj
    Omp2cGeR2sDaTrXF9uN6sXqWiuM1nqDweKI51CbS/KZb1jQDpgfymgj2T/4A
X-ME-Proxy: <xmx:ovrxaoPDVhU5Kma87iWpEacBSUrJHv1I7R3VyA2GukxZRWALcKoyIg>
    <xmx:ovrxasGtchV4KvCjFHzquV2J_VnITX9A5m2gveLj40LnHLsumPT1jA>
    <xmx:ovrxauS617lu8olIY5jCZeRhfai7CKVVbkRuzNsSzHGNXWy8NALgrA>
    <xmx:ovrxahuzLEuMJvPbBPD_esZ38MDXXf_RSFRsFoevnWsGmrA6aUBlcA>
    <xmx:o_rxamjATptRpP6BOpa1y3RW9AzAc5vOP_tqsty1-795znQ2bTVdh3Vy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 11:53:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/7] gitlab-ci: speed up installation of Git for
 Windows SDK
In-Reply-To: <20261109-pks-gitlab-ci-speedups-v2-1-508832602d0b@pks.im>
	(Patrick Steinhardt's message of "Mon, 09 Nov 2026 10:58:22 +0100")
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
	<20261109-pks-gitlab-ci-speedups-v2-1-508832602d0b@pks.im>
Date: Mon, 09 Nov 2026 08:53:53 -0800
Message-ID: <xmqq8q320wv2.fsf@gitster.g>
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

> +tar -xf git-sdk.zip -C $directory

Wow.  You learn new things every day.

This is in ci/install-sdk.ps1 file.  Right now that script is
referred to only from .gitlab-ci.yml so as long as GitLab CI
environment has tar that works this way we would be fine, but I
thought that ci/* was designed to be portable across CI and other
environments.  At least we would want a comment next to it that says
we assume BSD derived tar that can grok zip archives here, probably?

