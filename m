Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EED3EBF33
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 04:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769316716; cv=none; b=GmciZQkbmMdNcnw9Vl+hFcWPcinPeGSXq9Gzhabzt4mId6JOjtiJRnkz5XcT1cux84P3WQpKEQC3vzcoa6SZ9QEq2JkLKS2qf5uIzNpL6H8tqDUKOZa4bVc1hPaHifEJD2GibABAsfNq6kuDYUUSJ+XYvnWDR0zt2HReOmxQuhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769316716; c=relaxed/simple;
	bh=ofepOaOb7fhz2FePg1ZVHdDARS0pkOETD9erpcK1ti0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dk2wwxWj6ZUKufjSWqm8DOsI503NcHgL1+v2WKTH0/HLuX4AjXYkXytqNnHYOTeFyCafEYjbZvt+gS+SHmOLYWkegsL+ZdjcehHB0UKFET90ElWr7tEcQfxmTDX6sNNSx+O7/k8vxVk1U6xfsJ1yd6lKIeTzCt+cdR4P4PmB8Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PUi6vuKV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wfcqgl3b; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PUi6vuKV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wfcqgl3b"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2AF3B1400032;
	Sat, 24 Jan 2026 23:51:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Sat, 24 Jan 2026 23:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769316714; x=1769403114; bh=5pMyuxzvlG
	miJ0zyAd5idaJQZAlDSVhlSsK/ICPf5uo=; b=PUi6vuKVPSlDnM8o7vnYWUw98z
	f5F2FlU55VBVvhDLq4iFbZ5L/wYG+8ITeK96TPXSXPM4f6CZknpIbRoH4udGY6OK
	jSVGKrNOIIbz5PQz2A+4YV14eWBitxtufWgkhom1Zd9759QL/NHhBtYzX5XEx9XF
	zsGADvxJbTqBBwsnx196ABMWBO7RgeJk3E2WeDXJ7AEEPAiVlmAewxYZE1C+NZc9
	gbpBT5KjY5go2e6GjOBpskbe7j5DN5lBNUZiPqYC2PeaoxwTS2tT5mY7AlH1E0pN
	LNXOutQfoZkJLEoYveesWg+iQ++hzu0bOk4oNc0pjANdFGdH1Yytgw65Vd2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769316714; x=1769403114; bh=5pMyuxzvlGmiJ0zyAd5idaJQZAlDSVhlSsK
	/ICPf5uo=; b=Wfcqgl3bYJJSPVwsExyMpFhPf7v0wegWHk6zJXdN4OmIpSvZGzs
	PuTROUUQm7nuWNjm0vLX3NR6m7hB6VJpW/+PS0e8oTwlFdyjAQ/ueM8j/mkCtUZJ
	czei1EaqAVR4jD6OGthHqnSYPZtfkyiQRj4+WdJ7gvnw2OxCMrIA5Rf3QlVP1SV5
	coaN59vbeGOcSRMptDCMGgShZI3UiBVlJzO0Y0cY5Crx1carnK1XVjTrajdEhDXQ
	SsadIAO984zHR0/WgEtgCby9ahmhXzE+fxLIJEBk0Gn01NyD0dQGrkxIXd6tTr9O
	GYiLFs3nw/qKZlXbC9u7XKaI8bytGfhJhsQ==
X-ME-Sender: <xms:aaF1aQOs_y_FRD-_BAjQHuJdb5b-6sOmtcAuj0EufICPTCXbk7pAzA>
    <xme:aaF1ad3VV2z4yJWAoTJb_C517lHRaCek8SSDsKw9bWwhHVBghxN8PSQFtlAVnWJJI
    zdEXBrAR5WXOpa2ieU8XSSeepTPO8zzH53N1x_8LlBdtsoCJWX9>
X-ME-Received: <xmr:aaF1afkvWXzEVX6KGJsHtWSwABgcHciOiXNfqBcNEAEqFECPiDG1mQZMLMPFixwVpStdPFHRl3hF-htL9K5OxOIwk0LEywkpT0_eoeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheefkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnheshhgvuhhsvghlrdgvuhdprh
    gtphhtthhopegrshhkodhgihhtsehhohifughoihdrlhgrnhgupdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhsthesvgifohhrmh
    druggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:aaF1aUVNQMDM4o18ssW3CX3MeLZHxz5R93A553ldB8aOgQOJSG1vew>
    <xmx:aaF1aVuhfudf9yIYkDKy_QmNKbiXGTNUUU85SOgxja8uiMDC3s4Zrw>
    <xmx:aaF1aXbPwgP2_rHZxYcdXoGr-3tfzboqiSE2TMr9En6hkWL8ebki1A>
    <xmx:aaF1aUWhV4uTAz2ByU3MCTsKyNQyYPTnV4v791UWlEJSc_Y51BFOHw>
    <xmx:aqF1aWdNkM9GGjIjx7fI1oEng0-H7ZoxM9z0CVnSY2lBln6p3QwclL95>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jan 2026 23:51:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Heusel <christian@heusel.eu>
Cc: Colin Stagner <ask+git@howdoi.land>,  git@vger.kernel.org,  Christian
 Hesse <list@eworm.de>
Subject: Re: [regression][bisected] git-subtree remote desynchronization
In-Reply-To: <xmqqikcql8cq.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	24 Jan 2026 18:44:05 -0800")
References: <755578cb-07e0-4b40-aa90-aacf4d45ccaa@heusel.eu>
	<xmqqikcql8cq.fsf@gitster.g>
Date: Sat, 24 Jan 2026 20:51:51 -0800
Message-ID: <xmqqecnel2fs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for noticing and reporting a regression before the change got
> released in an official release.
>
> If a fix materializes and gets verified before -rc2 (scheduled for
> coming Tuesday), we should revert the merge of the problematic
> topic.

Oops, sorry for an obvious typo.  "If" -> "Unless", of course.
