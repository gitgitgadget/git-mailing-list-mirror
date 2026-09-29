Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E23ADB9A
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668215; cv=none; b=jTGUvEkhFXobu4M3bzFQCbr35CBkizWMHtL5urZJd1/lERnzLrijL60k7OzD+Tmb3BEyQ5eEqWC3zYmCj4PLcZipWiBI29LeqI2erZNwxeJBxgCS9IhGbu0HEH2CxLS2VR1SUkTcbIPdceZ6eFwZXyXHfihctmGtqJDDyx59XBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668215; c=relaxed/simple;
	bh=mbWpmGj3R/giIhZIm4ABAlu6noxaM5QlfLEjLJvsvNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HWsAHduxRYCukJUTiLdMvsLqPGsi1seoQgheuaA8kAjzvbVsnuC07iOvWDLFN63X3Wu0hqmQbZ2tGjbPYAq4dUdJ+0+x4DrfxJPhojt7Sn1dY94mDz8uuuezhZZtp20i6p91G6bCk92W6S1LQNzx6Ap7aTSC/FrRK+XpQdCK7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n8Y7PPeT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MJ5IxANS; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n8Y7PPeT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MJ5IxANS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B0BCD7A008F;
	Tue, 29 Sep 2026 03:50:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 29 Sep 2026 03:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790668212; x=1790754612; bh=r0LU1YfBpP
	jpuN4JW8cbXydMFdh6JErh4Xy/6uuTh0s=; b=n8Y7PPeTWN2v+HU1gDrqVVSlpS
	2S+8tR9jjAwohFL7pGzEFvqiwjxzJxvlcdCBTOnMJhr8RPb6cP5ebRgi9XbFLpYx
	Qx6z443qAN7y+lVfNZbDHUSeYjbyaIiYV2oNxv4EHosvjYDW5iWVTsnuR3hFAbwR
	9O9UlsFCMxUSz8XYR0r3hYpQkro58GDiUOhV12KqJND4+k0sbIccgskuFuZlRuSt
	UhJ8Dxv9G63D5c7GyPVjDmF4m1VDUEPNrfUYMUbvjywEGtx8w8zPfYht55fDHfWv
	RFAqXkTg/AaP13KAgaCurOGkkH4I97nJ111oa8RlVzxNc9H9UXjGN0Bi7DaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790668212; x=1790754612; bh=r0LU1YfBpPjpuN4JW8cbXydMFdh6JErh4Xy
	/6uuTh0s=; b=MJ5IxANSAUKvkAYIDmzN0Icu2IDRLenPOyn1FgnNdedmZfY2OJy
	SodT2S9+sndzCI714NOAxVRicfMlF2Zqlj6/d2yzDTZiESR33X52tJ5Q5zXTsxlF
	dP48QY76dUpG6h9PHhQJHAqWO4GtpnbLiWy/FE19VdW3Spua+5pGD3L4s2XX59jW
	hVK1XwHSDkKX68a+dZ9b8RWPmlYB/xKM9RMEwuqRG5BLvIO0oFa41da6861sSVMN
	oZ4abMIwYVUeW9Oxr1WqGt9UORo/haHzEIRYI6tfMeXGx8phILNKwXDyQJpjSSZn
	Wqw31kMWJ4CD23LzsHBvkLqYBgKITBZH3zw==
X-ME-Sender: <xms:tG27agWS8cMxLfkSnlJjGT-HUhwFXrruzsA8L1aRWtzPGECw8jOCGQ>
    <xme:tG27arlq1swCiZk7UpsXCNe4pFK9cY9gZmV8OMgbhMBc28ls53636sXwHDINsr9Ez
    1oRzkhyrYx_5zsu3bOGMGoVAm_om6rlsOvsLClDdY021eXBYEV-9qc>
X-ME-Received: <xmr:tG27apa0oxnwSZMt8y8J16P6RykpL2izoq6tYR3LiO1_rvHWgCC-NXdqPODayZu942yuyI_eS6f5MlHAJAS5Fdhh3cNfLfhnD0RJ>
X-ME-Proxy-Cause: dmFkZTEbk9e+Azs/8vG8xeJzGIktkikneqp6LGlHdzAlJETjapsu0A6pSMasfBV5CFrCXx
    +LW+BcbAhgC5tqTidMnKIYCOcaEr9vtXL8bZAFILO5D7bgiOvizjqE9TY2Tg1domVNA8Xo
    PsNPqssPluwmh3kZRU8qzbAKalBo5K6I4N4dI5t5wjxpxiCdb09oaWR4OpHvPv6X+EHSju
    CBXtTtwaxBO/xebIA91/hGdNEkhn5g8ML4TATCQnJ/HFK6y3FajHSBxUROXTahV8p5GBOi
    JGGYKl1iUuPSudDd2PvZfhKWekZxNK4Bn5cpZePSDb6nb3BaOjdSUByafNJDXNzdvRcoVS
    XwaAScSBn0lwQ/TzEMIClq+te86BYhanFilhwlE35b63wLvt4IQ2QbDgi94GiB77irK6lS
    y+h20GMc8pvzRseLaQ0rVpYoXRiUPp1GHFD3ELvj8iHryoSAdTsPLlz0mVuEpO8av2hAkK
    YKYuJYzURRBo2sADPnOGJGjh/4UIiif5ckgMqkpIKS2HiNUmD75mKs935lotMPS8nKFtnW
    jAgsOTA/KvvcN7LrR4xwCPlyPdh6Sg5uJYLbSAyaMesN4KFS5L8D7dTGc8qDM+doTmxn7W
    sH9hWfAQpvAtqoVAYhQKV61HhnZXgAO+IADRfoDCOcV5UdlrIRR1lFRqZt5w
X-ME-Proxy: <xmx:tG27auO1WmZ1CV2hsSUque9_xtNxOXGqU26wLU378PInjBic8DwVQA>
    <xmx:tG27amaZjkiDFlHLucO0W7XuIrbI4tEHme7AyvOPIKnYuQC-YzI7SQ>
    <xmx:tG27ak1CJy_7fXbRrNlm6DcuZKajqlTk4FbxDE_Uk57dR8yax_5MYg>
    <xmx:tG27akd8L8Zzt1LkHPpZB5tUJIw3BvxgjCY8Fn8x79Me7phjed-1dA>
    <xmx:tG27ak4y6INAEjQ7mKbZhmrMiU_MZvG7yZX3DgOtoiOE3ZPtTkG3hzvJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 03:50:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
In-Reply-To: <pull.2241.git.1790627122.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Mon, 28 Sep 2026 20:25:19 +0000")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
Date: Tue, 29 Sep 2026 00:50:10 -0700
Message-ID: <xmqq5wzojy31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series removes gittutorial-2 and all references to it, leaving a
> stub behind to help out any users who might be looking for this
> documentation.

Is this the "two series" approach you mentioned earlier?

There is no need to ensure that the new document that replaces the
old one covers everything the old one did.  After all, giving us a
clean slate and letting us choose what to cover (and, more
importantly, what not to cover) with fresh eyes to match the needs
of today's world is the whole point of redoing the tutorial
document.

So I personally feel it is OK to remove the old one, without
promising or even hinting at what in the new one that replaces it.
But we would want to see its replacement in the not-so-distant
future.

Also, we may want to decide what to do with gittutorial.  It is
short and reasonably sweet.  One old-fashioned thing that does not
exactly match today's prevalent usage patterns may be that it starts
tracking a new project from a tarball, but other than that, it may
not hurt to keep it around.  I do not know.
