Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C1382F34
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280269; cv=none; b=HVzDwJnOSKl7ZfCPoRJkeETcdNAzxVvsG0XtGzfBQSSBbh6Ux5odr3VADEY/cEBP1aF7wjgeZ4FiwSBZttfyMiNxz+8tDAiGtifkobKEUqFeL17EYwam8PcN80fCevjfynLN4pJrTYekssv7KO3bBYQQ8pxjtS0RNa/cFvTXSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280269; c=relaxed/simple;
	bh=bTgb4Ap0JlSUy0GEkSsHey60Vz15EcSy+wluOdbcKxQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=enhHO1Dq8IFS7E1RanHKh7Dhg1AVNRBgSQ7SWCCiIwxvSgFyJ5lDf3FBtMin12ov1sPuXP/Tp7CKnOhLOY648haokFXDKt+iPJWlfjPQYXkf5zWWsVYBVUdCti26fqaer2EIQClxOVQK/Ma7mXGwKzohcUVd9cN3Y+3aUUKlIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=IqoKJKPY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T1PrGTyo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="IqoKJKPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T1PrGTyo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69E701400103
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:11:07 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Wed, 15 Apr 2026 15:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776280267;
	 x=1776366667; bh=9v+AWs6/kQRk3K2MeBBIebHGAdbkG1JKNdzQK3Iq7h0=; b=
	IqoKJKPY5bjJY/hD3IG49NlNdvkWEjiMJKUVZWZANipXg9g0UTRiwY91uSRgfEds
	azr5f4yTeHb/fE02jGiuIzJ4EQSpqr8XOH7+eiLFBf9+e1GKOpzpHtRrrVIY85w7
	QmBgXTEt56lcNErqwAd0i3EYUOv5JMqlTHTephzLY72x9aRmAkFKX7J48GAtYKfN
	W4sK/3tATLcbjQgT6SaxeWPHCGgsgLhjpg5R8dmgvPUof1Ue9bQgIhXVToudc7d+
	mVa/7BwDmLcSzUHL3q3iaV+NKzoHKpVOLdc8SIWWgOPvVyqicM8kTf4VX9ys439/
	WvxgynSXIHQ9hMmLUdH97A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1776280267; x=1776366667; bh=9
	v+AWs6/kQRk3K2MeBBIebHGAdbkG1JKNdzQK3Iq7h0=; b=T1PrGTyoxY5st+c6Z
	bymaajtJq78kxXgnuqc3I1xisthPozXPofw6SBqOPzzdh0F+NDNv7+T459TVHCGB
	nv4taIWXJge2F/rzo1+S/cZT9ab/NBmVIlGtFuX1Qernx8hJ97n1H6ViNGIPMI6i
	D802BepbczlzVOKfy0mIqgZ5W8w6xaC8mqQqr4aGc39pxiLH15XnlYL5Ouxx8NBG
	XAcIsOF7/4bufTgv6AwX6ndx+doL3e99wSFV1EDuxGu5hFqWRiAqfvoIwwJHZ5UL
	cewvptqtky7QvYMsWj4al247q8gcptl1DpuN0WcvEqgX8yqYI/nKZSjzxF2usOYh
	7H1+Q==
X-ME-Sender: <xms:y-Lfab2zDWw4T45zdcI27Yhay9m7Git1u79YVhwGkEeUqlwlfmk5wg>
    <xme:y-LfaU4pHMWrfx3SKB-YSJQk3a7VbgJyRxDz1qASHrshGiOCQ8jc1K4Aij-BnGHnv
    HBiOAGs_2Rv24VWt4Xuu09MfHACtHnya4RiNQPz4_ZwVULma-gp0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhepofggfffhvf
    fkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfuihifvghiucgkhhgrnhhgfdcu
    oehoshhssehfohhurhguihhmrdighiiiqeenucggtffrrghtthgvrhhnpeeufeekkedtie
    etgfffhefgleekudehjeevhfekteelhefgudejlefgieeifeevueenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoshhssehfohhurhguihhmrd
    ighiiipdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:y-Lfafkmf9p35RPmb8lvwEvpF4o-u0pXJeM1D3tT2Rd3cqBtNqImCg>
    <xmx:y-LfaSzPKIlL963jtf_QhAq70lyOfmi8welmCRLqsSBJplYywZBIbQ>
    <xmx:y-LfaSizNtb8Wnz7vn4byC74LcTp7EE4Vm4H-2mcRDXKzq8MY_9e7Q>
    <xmx:y-LfafUky_TPHwHfA0L1uUu9qn4WVXdPuHRGE_L4YS3Us2cY9cJj9w>
    <xmx:y-LfaV5Z-H-7WsE3D7zo1eQ7LusewUQOb9cR7_aWpOyptQAAldMhtlgh>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1F01B1060065; Wed, 15 Apr 2026 15:11:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Apz3yl709QC7
Date: Wed, 15 Apr 2026 15:10:45 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: git@vger.kernel.org
Message-Id: <ff08baa9-d731-4702-bdb1-19cfb03a3466@app.fastmail.com>
In-Reply-To: <818da18e-f928-4473-8a37-28a737dbb261@app.fastmail.com>
References: <818da18e-f928-4473-8a37-28a737dbb261@app.fastmail.com>
Subject: Re: [BUG] git-send-email hangs when sendemail.suppresscc is set without
 sendemail.confirm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Apr 15, 2026, at 2:46 PM, Siwei Zhang wrote:
> When sendemail.suppresscc is configured (e.g., suppresscc=bodycc) but
> sendemail.confirm is not explicitly set, git-send-email hangs
> indefinitely after processing the patch headers.
>
> Steps to reproduce:
> 
>     git config sendemail.suppresscc bodycc
>     # Ensure sendemail.confirm is NOT set
>     git config --unset sendemail.confirm
>     git send-email --to="someone@example.com" HEAD^
> 
> Expected: email is sent (or a confirmation prompt appears)
> Actual: process hangs indefinitely after printing "Adding cc:" lines
> 
> Workaround: explicitly set sendemail.confirm:
> 
>     git config sendemail.confirm always
> 
> Tested with git 2.53.0
>
> Best,
> Siwei

Sorry for the false bug report. 

It seems vscode credential helper didn't work properly causing the stuck. 

Meanwhile, I want to ask:

Is silently changing sendemail.confirm behaviour when sendemail.suppresscc is set appropriate?

Best,
Siwei
