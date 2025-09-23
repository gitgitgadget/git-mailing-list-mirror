Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C919154BF5
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613336; cv=none; b=kMalQeD4URUxnbFjFr6lpsjjA5oNiCAOMQL1QmdAefcDgfWaK0SueLlpr4RSVsL9lX+NSTDhaUHs7B5WTAxzHFt8j0cfO5oDPoB4r7lBZAB0CEuaAfbjUjREuSnzkMQHQf7m469TVbMomib8oF3o2ZnxF+f2/tKn3CFOmB6J/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613336; c=relaxed/simple;
	bh=97Y/F6K8VVtb+XA+ht+zsLUNBHqvHB32opUJdm7CEig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esom9XPO3INZD7g76HNinmOGiXQ9RylIN4u4ncY7QsLZGTiW3iV5e2PDBdDiMaM4zesEwcwu12yEJ7LHD5fam2I41pQLQESpstOad/BazsqnLMp41JLc0Gbn81KH5w4Z+Y4RynLyD9jQ31ga6D33eSUOTOfUb4iQ/VHj5inJP4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KPk0FxNI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WqjgFx5l; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KPk0FxNI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WqjgFx5l"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D5247A0268;
	Tue, 23 Sep 2025 03:42:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 03:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758613332; x=1758699732; bh=/ZaL4CS6Yt
	+U/Y0K8/OJkcCjSmW6qOPKGv6fSb0Fgi0=; b=KPk0FxNIqM4c3KR2asFIM9fm5x
	KMb5olWLyrrzUnm95fve02gAUtmOjJ/+Uz+JRBMiZ6DUo9tP1799ZZTsdGiz0wGd
	JDGIvEr7t3FEexTAwnk4xIHPjBf6xV2IyPYii3lfcEDZRxN/i/0HaOij6W04nz7L
	r7tnlqWBUR9NExVaC0gMBgHD/0MAd8pwh1crWfPYs8N57DeAkIREjXsadqTioeZM
	VsJ5HVIU95lVK+pZS/HfQIK3PN5KFPOK9KUW73Tquw6syxJoEUbyEO45zhhX/hsU
	9ejz/lhIFTYASc6/db0XIwSliZdg/kOLOMTrvccZe5ZBgh8KzwvDW14ulnUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758613332; x=1758699732; bh=/ZaL4CS6Yt+U/Y0K8/OJkcCjSmW6qOPKGv6
	fSb0Fgi0=; b=WqjgFx5lSv2wxK7ADQJanvsFp+gVl/N7/CDsN5o0KfdC0FrfaQn
	ge3I3VS0Y2SWh/1SNdvmOccnkyxtyJ5y8DMR1oo4PCqfEAMKWb9qbZtPKwQ2pQR4
	nS2ws/paGcSwH2uMpmYrbpDJzhTYTb3YSTQCudZu+WPLZU5cSp9akvG5Eof2/eCX
	s3Nr+Mxj5F9fJGF/YbGqAw0LDyVVY//RhBih8r4fQjqn3TM1nEdtQt/ZBmR8VOH4
	YDnor2pOhfifdiVr0D3OOHaLWwp7Q95myj4yeo3btmEKYv80KKOQFactoGaYkDq3
	bTAknr15v8CYx0w/z1ea29RWN/Rd5xsHkeA==
X-ME-Sender: <xms:VE_SaN6mxg87ox02SjOqNidLvqdQn-R2BEZysq_t7zmh5Iu98hwRDw>
    <xme:VE_SaA4gvGIMAi1qt8TCPJLuziXzSd-XDlfK5nqYzHLJc2wiNheNTIT_exYikrbK7
    d30WT-AOfn_2xAIEz5wcqN1HGPsbhRF89kk3ryEkuh1hhgAT6j8zg>
X-ME-Received: <xmr:VE_SaCEwF_Te840saIOLA6j81FVUfMtrCl2ZeX1p6H7Tlj6FM99KSgXkae0NDpPmzN-m_qjP3vLgYbw0X-A28hJwFmmIXewK5qdfTQMcYLKp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VE_SaBRtY-ceDExh3J5coEKo71I3D_L2n6jzbZlb5dR67UkNXK5N6Q>
    <xmx:VE_SaDvni6kGblk59I5yPWA-hED5y-asQTCwR1mKUeolNwzU6XtS-A>
    <xmx:VE_SaIxhTNR2BRKoWVJ_Ffl98vWlc6FcKz2vODEuq4rjLsFc_eUMxg>
    <xmx:VE_SaF4DzjRMDuQJ5MnYC-Obb337YrZjpkWRcuuT0dJXzhoJe295YQ>
    <xmx:VE_SaBR8_sVt_zSnruTgc93jtPZ8aplBY-Hcda5E8sxOTj16I8OF1qCN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 03:42:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a8e93a45 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 07:42:10 +0000 (UTC)
Date: Tue, 23 Sep 2025 09:42:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #09; Mon, 22)
Message-ID: <aNJPTrPHA-xd12p6@pks.im>
References: <xmqqldm6qehe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldm6qehe.fsf@gitster.g>

On Mon, Sep 22, 2025 at 04:01:01PM -0700, Junio C Hamano wrote:
> * ps/odb-clean-stale-wrappers (2025-09-10) 1 commit
>  - odb: drop deprecated wrapper functions
> 
>  Code clean-up.
> 
>  Breaks build when merged to 'seen'.
>  cf. <20250910153759.GA562601@coredump.intra.peff.net>
>  source: <20250910-b4-pks-odb-drop-wrappers-v1-1-6ed660cb1eec@pks.im>

With the evil merge this that adds the missing "repository.h" header
this status is now out-of-date, right? Is there anything else I can do
to get the topic rolling again?

Thanks!

Patrick
