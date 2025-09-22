Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281AEACD
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522030; cv=none; b=E7jpNVFntGGMInO9SucbSUSrDH+M4wsWcGDSIToNemX38DNGldGRD/4Lv397XB9nEHFkmYanROi6f+CM86Jtf/gHG/hu/Q+TZzRGuh+amTHDhRv6MZV6x7bJQd7Sha9MTP6m3gBBpnHpmXYhccewHdDfbW6JJTbM/F2Ov1na0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522030; c=relaxed/simple;
	bh=bTunLdslZabiOR4xlqmHd5Fr7N5xDJWF99ri3wLwm08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csSt9O328COBfei5kk8Vko9H8dhziQEo+lk806qg0GljXjqoCfzL2/EHvszcNr35XYklbeGdllkSFTz01Y7Z8clTppKgeCnHb5pPc141ycvXKpuCVKKUBJTkCz7+gbaUTKk8VCfZdTcdAi8yu8YVNeprS5sRhg68TSPaqG0u/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oIYOMtdQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f2PhGcBN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oIYOMtdQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f2PhGcBN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 831671D0012F;
	Mon, 22 Sep 2025 02:20:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 22 Sep 2025 02:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758522025; x=1758608425; bh=cI/eqvijO3
	cfjSR2acDswAluuaVl5kEpwbxzoLqGpG4=; b=oIYOMtdQWzzygmYcJHPMq2ZMxV
	oHYmMJuYeqXE/lmtVJKKWk8jqf9nFk890Ag/JR8FASSIXoiUwV3jCDzb4kdrNJw9
	JGdkf8GLeNREmL8xaiZqwM38GI/StqI/IKmaEo+4eSR/uMrY5yHasiqW4jFpfRef
	faqN1uzTB9Am1agcyETKI2I6i18ooSHlJioFveFkqqjsPNp3SOxSdycvvHWxw3Hn
	LfUjILlF96HcdUMgUgHXpGemtyg21Vgu9MZQv9HtiInD2x6+1zvNhf4qwiv/7vsM
	kMb3E/6P612HO/yy1Y0XEI/UefEMQdedKOdazbEFnGO0ESnQX+qFtVCfvkrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758522025; x=1758608425; bh=cI/eqvijO3cfjSR2acDswAluuaVl5kEpwbx
	zoLqGpG4=; b=f2PhGcBNMepwQH3goNOhJNU0OLs3AaxLPZyAkt7t4Znj0sFFtim
	VsJyoAws9uIDDx5e6i9xbOJVoKOP8HR0MMEDq5ipp1Ph9Rv3cuK0QejHBDrHOCLP
	VGxmbY4JKjdhl+k4tC1X3nk/b8wI0BMwBA+J5C/OneMIvC0fospxXDQzgfQbCQWj
	f+v1Edrl4yePEY6JK+nwfzEWD9xreaAwGgZn0fuKGizPQjZ5qGHplr0LJz4ONPLA
	zemcIAspfGRjcOP3sJww9Doj63Wscm3M+v0TQGk1Z6f0Am2UpkMtanQbu9YxvmuF
	GPa0PBLIMpQTf7DqzlyocxE2VNWn832/RoQ==
X-ME-Sender: <xms:qerQaDT2Z5miSpJUFTgX_NwWyFALEtRBA_bLp3t3-QNmrnxtyElc7w>
    <xme:qerQaPWZUDbf3NV3meSEvTkt2ZHwyK4UG1Ed-mGan9Tl07AAQ5V2bPiwLlOglKjkt
    6P8kRXGTTFTJw0Sfg>
X-ME-Received: <xmr:qerQaFa5n8fArxXIkjS74wRZfQvq21_x6tmZgEPceffVmcExPPdmRZ7EZY5W2m5v7kBAFwRrI_SEmZ97r_HILmETLjv6U2je2AuO3faBHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ethfdvieejteetudfgffeukefgkeeitddttdegtddtueduhffhgeevvdeghedvueenucff
    ohhmrghinhepghhithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmrghtthhhvgifhh
    hughhhvghsleefgeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qerQaF1jDpyXh0EIW3TrJOUmB5x4vgRJkaIygSQ-eV4sq3xvDx3gqg>
    <xmx:qerQaHgquO2yGgHpaeW-vAVODct0fJXboi-7oRG-OFWdYSLrR-f_8w>
    <xmx:qerQaJb4HGxY1Ix03Feb8r5sb8LYj3SN04KB2gF_lnIuaY6OEa8zjA>
    <xmx:qerQaHSCIWka-uOTdcQ0MyoraVmNLMfneFzJ6yCPP0em4HtF5qxTmg>
    <xmx:qerQaKCuPZ6cHsGXFw2HmfQNj7ugqQkjALTYvOxdvCNQ1qn1uo2H3Cck>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 02:20:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78cce5d2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 06:20:22 +0000 (UTC)
Date: Mon, 22 Sep 2025 08:20:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew Hughes <matthewhughes934@gmail.com>, git@vger.kernel.org
Subject: Re: [QUESTION] how to find options set by scalar?
Message-ID: <aNDqnMTJIoHi7Ifc@pks.im>
References: <vppjutjcdglp44qvsk4qozphycyg663yrq5775zztim2oe7ty5@uttjrshb52bd>
 <aMkVqNbdgxqBJ9K4@pks.im>
 <evxbvwwyo4p4iboc4k6r2cd2cvlnm2upgxumqopdijwmvhxhxs@7xvg42heibp3>
 <xmqqikhf7bdf.fsf@gitster.g>
 <08deb8a8-6c34-4f11-a36b-93d151a56f9b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08deb8a8-6c34-4f11-a36b-93d151a56f9b@gmail.com>

On Fri, Sep 19, 2025 at 11:38:50AM -0400, Derrick Stolee wrote:
> On 9/18/2025 4:29 PM, Junio C Hamano wrote:
> > Matthew Hughes <matthewhughes934@gmail.com> writes:
> > 
> >> I was also looking through the list of config options (within
> >> `set_recommended_config`) and thought it might also be useful to comment why
> >> each those settings are recommended in the context of working within a large
> >> repository.
> > 
> > That would be ultra useful.
> 
> I think all of these ideas are good ones. Adding the comment as Patrick
> described is good, for sure.
> 
> Instead of commenting the _reason_ in code or in the config, it would be
> good to list the reasons for each recommended config in the Scalar docs
> so they would be visible in web docs [1] for easy discovery.
> 
> [1] https://git-scm.com/docs/scalar
> 
> It seems like Patrick is already 80% of the way to a patch for the
> comment in the config. I'll see if I can carve out some time next week
> for the commentary on the config options in the Documentation.

Agreed, that seems like a good compromise: we note in the config the
values that were set by scalar(1), but the more verbose justification
would be part of the docs.

I'm a bit stretched right now, so if you want to work on this please
feel free to just pick my patch and iterate on it.

Thanks!

Patrick
