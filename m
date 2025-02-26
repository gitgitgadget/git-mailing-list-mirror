Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D7E25CC85;
	Wed, 26 Feb 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740609495; cv=none; b=MVZerUBI+Dsz6dwsRiwWdDLrdJIfEcOuaBrOaSM9+yQJTo0KYfFPCaCrvi8irTRPxF83UDjVgqchD9WjglU8/E1e/5+C8coOiUnJquKJa4dhfH04vW92551npmMIPxi+nc2whuKy8V9HEVCuMPl7qoYUG7U0R8E/w4HRh+8LmlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740609495; c=relaxed/simple;
	bh=Db98LTqH8jszRgpa67m0NYmQtp7oqUzEwRQjHmNgjTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G2V/3a+uwYJW74tPVcPhhzjJh6uCPDjO+UFgMvB379f5eVSgGuoyTKFiVcPVUpN7OGYWPC27ebYkKkVllRjvaLC5cBUgve+yurG96kIaFt9PwXsKg3wi2gKkZODcKm0cpWneAwBGLO2n8LVSUx29015GF/zXlw4Pe/ejkVzHt2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KF19JGhs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=7Hcrrdfp; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KF19JGhs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7Hcrrdfp"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 576A213800F3;
	Wed, 26 Feb 2025 17:38:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 26 Feb 2025 17:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740609492; x=1740695892; bh=8jeNcdAnrq
	Wk+vSPdJdCmOaMfIzJZpxOKWi8SuZ5KO0=; b=KF19JGhsJlH3a2SDPv5eAxRvhb
	k7cvok85X37wos8bEf6CI/iHsc3GIS+ja/sFVlPNYqw8sKAm3cNXLTFjgKbYnIVZ
	gExLPtmPqurPB5RJunsYPcn72eyfsbpB+LMRrWonURbaXoo8Z6ZKewgGsMY21x7+
	XqSVn+7ZWD0UMm+s/BDleeLs51lNL1H0rRSBEdhHVRaUqObk/CpUTHVCV0GrRHNi
	nz+8ohFzsgmsWqq1gQMVyvdj1LAknHCaV2NkZT0j+tOpTWGDD635JHGXEbWJMpFH
	kxk1OaraKH52qBV1iqavApSODFecOB5od5e4Gi9iq9w+wm+gqEUuJecjmk+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740609492; x=1740695892; bh=8jeNcdAnrqWk+vSPdJdCmOaMfIzJZpxOKWi
	8SuZ5KO0=; b=7Hcrrdfp3vQVEX5bJoUSrFhgbhe2LG8SjUrJOf20Ug85y9ZaH6H
	SvZ+KorAR+y2VdIWv+OFcErsDVtdE+eRyzEaoFRsr+1nXcEonHg6jiHFXlfnSuwt
	rnRSzILivxfJEu1kh5ApjzlbbGEP7xJHLwiZGsFrcSWRFP9+b6FVOHlCxrRuaund
	7x8CkcEz8joGbKSk29KCy5wurStT9Iy/Fg3zx7xQvG8axsuS+ZIN1tSmLbAH1eXH
	D9Q4uxrzr9C9iwoXaiVt2h+9kOG0WmMeh+yjK58GlSg/OlVxAXKMDRcFmJyFdtFg
	xpU6aPMQlikfoIrTEjEC6ed243SMSx65iVA==
X-ME-Sender: <xms:1Je_Z0fv-5_fCC0Emq9_ebNwkTh_TuofeVM5knPvNj45pfFrgDv55Q>
    <xme:1Je_Z2PHqOYEZrGit31V5qpDyisreeH__lu1G1MOXF5uGcAtvWNRazTCjFaerjieC
    nZCmfJeOn-kxflhZw>
X-ME-Received: <xmr:1Je_Z1gvpHnmN31ctsO8kcTYEkGCNKuIBML2QOY5WXY-CBPJU98XskqjXaR_ujauQTVTUR1Hq7NBcr_LGuERAxYsKRfENd6FhCh1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithdqphgrtghkrghgvghrshesghhoohhglhgvghhr
    ohhuphhsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1Je_Z5-kdIdvDZ_BrppncdbGFpGvAkur6KE7ASVGzTnbGJ3Ei3Jnmg>
    <xmx:1Je_Zwu2aFmrD9k9mBpTLIdaQc3EoQV5r72SKe6j5DtVfcTLEUaWfA>
    <xmx:1Je_ZwEBLgJyTEjy6NFgQ3EbY94slp1ZvRS3nGXnECTJMCAR3d1AfA>
    <xmx:1Je_Z_PkBoCZszyJ3k08M5mJ5I-0_52ES8c2XDXBAxpIbTPFvcddOg>
    <xmx:1Je_Z6UjdHcAuaixaLKzZdnjYoKlb31YXXIxkXqP-g2h76kEmxlTjA77>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 17:38:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Linux Kernel <linux-kernel@vger.kernel.org>,
  git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.49.0-rc0
In-Reply-To: <CALnO6CA5tw9DNo9U8Fu95Y27DBiRaRDsz75MHwm64iW0TBkxDw@mail.gmail.com>
	(D. Ben Knoble's message of "Wed, 26 Feb 2025 14:09:43 -0500")
References: <xmqqzfi8bljk.fsf@gitster.g>
	<CALnO6CA5tw9DNo9U8Fu95Y27DBiRaRDsz75MHwm64iW0TBkxDw@mail.gmail.com>
Date: Wed, 26 Feb 2025 14:38:10 -0800
Message-ID: <xmqqzfi89vsd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:
> [snip]
>>
>>  * "[help] autocorrect = 1" used to be a way to say "please wait for
> ...
> It seems "help.autocorrect" style is _usually_ preferred, but there
> are a handful of "[section] key" style. (I don't have a preference,
> just something I noticed.)

But you cannot write "help.autocorrect=1" and claim that it is
correct.  Your configuration file does not spell it that way, your
command line to "git config" command would not take it.

The more awkward "in the conifguration file it looks that way" needs
to be used when I need to write the variable with values.

Alternatively, I could say "setting help.autocorrect to 1 used to
be....".

Thanks.

