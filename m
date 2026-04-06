Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB62989B5
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495243; cv=none; b=sc7EYVP2wFIn6WCg1cSGfa62ox+Dn6lKAb/ahX0vLmKvp5mts8tCX2yGWeVTu+v1TEK+UWoLL9+2z00O4CzjOiMLKwEJxT4lMzGBrwybFZ+A+YHcV/FBgp2gph63x2V3oc6xmR+KssgZSGZLCQMEdf4hrTu/wu9/8T1Z3bGWjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495243; c=relaxed/simple;
	bh=VVLSroxqhspaG4+KEfQ5NgwT8+qmEjYfs1R+kjQ2Ud8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RGph3NhCkMPMn9k/F2DrnED3sDPhikaw559EuVyUn8zObnSSE/a83zS2+OvLEF9wYBq81kD7BmmS4PWbAtWktVw3dwLzdWArsfuSkWJxJ4tnxoOQLgI0nokf+FOFqm/GR+C5kW0E/tTn7euM9C1x0kW5kjGK4xAn93kVlE0+Tts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PJLslrWz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jclSfytJ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PJLslrWz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jclSfytJ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id A21101D00014;
	Mon,  6 Apr 2026 13:07:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 06 Apr 2026 13:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775495241;
	 x=1775581641; bh=Cx8I1CmicuxmyDFRG3fnetU7sxEJPGF4DCScZM6TjPo=; b=
	PJLslrWzcpfuq8xTmffhshFO5YDCAgi+Ja4ZjWg/2hOriVzI3L3xPHIEEuupyflT
	N02/LFD0AWT16XDOGlX0gBDhDEnb2MFM+trhF2gMLhwMcTk+251I6G/3WpfJ3KUU
	XksOwNdw0oZRWZ3OmyuA0OonjHOZsW29UXndkkk3ASELISIsFWYpRMErFKAduD2V
	zmc4IyApUEqg86RC2pw180AVhQavnPDcvoEwecMDrml5ubaiYxcvQvbIeDYLYmb1
	iQhsom+7Hu0W6YBFKt9EWiKvgY88xUDtzTVR0+/0zPzG2Too8JUkTSwsdtqkkmxi
	oyZqv39S/vNsVVCwPbBFOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775495241; x=
	1775581641; bh=Cx8I1CmicuxmyDFRG3fnetU7sxEJPGF4DCScZM6TjPo=; b=j
	clSfytJAVinhyURdew7hcIdcaww8NVicFSpyavm9WDjd8qNVctvTB5PORaa+Bx4+
	F+kiqNMEfb6v11H77hGmOz42cUvTCT3lh5Q4q7jeNGgZSJD3ScLoxhL3jedfWvNi
	4BOjGLKxbFvxMr+VwTRPXvDNJzhGMOizxHlCErW9Py+2Fp+RAk5CBaJyhy3i9SZX
	JFx2zfyEJ3Znh/MBGIjSM6nrMmq3LPKg+4ll/th7ymVmtWnOoJnaxr7C2DuEpjXb
	wc8JpYCIB3XOq2qUt2nN1pGqP1Ji1z9ErJAOa7qmeVkHlcU2RSve9zZBTCDrakrl
	izrEv7f/lVMqfoJgGjAtQ==
X-ME-Sender: <xms:SejTaT7B9G5796qLE0q7SdpGc9GvC7-G9phBrRhmDnmnZ-DGJrlhtQ>
    <xme:SejTaf67KnDMjclYdnRD1VUIicXcZJialuVwRnDXAFx7B8WDqtZhYWJSaaPO8632u
    ja8cfrdC4-v5_3IDrUAP3RN9t9zm-wLnthqrwhbA7hfOfzEz5bh>
X-ME-Received: <xmr:SejTafdMKidZec_4MDXc6mexiNNz4n2hDX07dgpr8a2a3sF2PMvAN5Lb9XYAXhQLIgRePnYsNaQRQ7JYMG3EECghCx2w6BWT2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffgkefhhfetieffteehleehtdfg
    hedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SejTaTC9_Kz1tNjG8GuMFngTKmhnqYMAq_5iJ2mO1OIGanYZ3tIG6w>
    <xmx:SejTaS_jFm8rq9LfhwzDCDWDx66eAS7Ch3U_yDBO5uwstkj_ELyZSA>
    <xmx:SejTaeJCxVy3bPkmhJcdooCbpcEux-k9p1IWnuacIyTGml5G4-e35Q>
    <xmx:SejTabiZV-b_54Rx7TNfU5tcgKqUbqtTOLkgmCwA2YRKhSOyeQla0g>
    <xmx:SejTaU2i152H088no19NQm5FrAkdgSbmjH5l7xod_7HCryLWdEsNoVWN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 13:07:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] unify and bump _WIN32_WINNT definition to
 Windows 8.1
In-Reply-To: <pull.2081.v2.git.1775454330.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 06 Apr 2026 05:45:28
	+0000")
References: <pull.2081.git.1775386448854.gitgitgadget@gmail.com>
	<pull.2081.v2.git.1775454330.gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 10:07:19 -0700
Message-ID: <xmqqtstoaugo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Clean-up while preparing for v2.54.0.
>
> Changes since v1:
>
>  * Added a patch I had forgotten to include.
>
> Matthias Aßhauer (2):
>   unify and bump _WIN32_WINNT definition to Windows 8.1
>   compat/winansi: drop pre-Vista workaround

Thanks.  Will apply directly to 'master' ;-)
