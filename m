Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A926AD0
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934092; cv=none; b=dmqt7gQDTc3LuuzVmU+FBgoOzD/5EQ/LHXv8SOq57h6QAW7qnPB5m+q/jz2J/EWnjx79YLGqgv5aIkldvpz+sWtyjmw9xfbCcgocPVK0WpFScWPxGGlmHlM1eTjFZtzKkHQuOZbNO+z+eIKOq6eWRbHwTXYWiwhGymRg05ZpcnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934092; c=relaxed/simple;
	bh=HOlQCPcYDHNtHTl8m8w+75jLdP6KQ+uC5LIZ3QaRqTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q2l4UfoLWLw/Wp/mUfAyROBHQx2HY6281HhTWRTKz/CxMEkPx3IAdWTWtm2QxYw67XVBWX961zSd98PE4w3cVwnRp1n1N2qHccAc1plURZH7UjPwug8vt/dSnU1lWfYsT1w9U6iR66Z0Kwj5lEcDEWoBHAhguIo0gUE9F5Q3kFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPtys2EJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPtys2EJ"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 903ED1380693;
	Mon, 18 Nov 2024 07:48:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 18 Nov 2024 07:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731934089; x=1732020489; bh=Z4Y/ZZbv99opGDFJ3n+9X9oxbNg6euOs/9J
	fl9A0K54=; b=XPtys2EJp/1S9fbTBxI7KIYUO+buzRPt6J7+jU3cmxiZ4hVcuTe
	HZVhrREI55vyBwyMKzhuxTCNtYSJwFTUNYCPOwBeL1Bin6sVU8iesv2suZJm2aAM
	xZlFszdg1tt5Ssoiio4B0KP2trTMXlJG9w9gwJiSbPsdZ1vypvuiSsYkiAnJ1h5e
	cH924mRQmmYfp1F4rPf3/ZwY4IPq1bCm9wqFDvt0qcz6MnnVZ5dxitqOW+Z8ZNkp
	S2XCtewrlU3FEOoP7lWvDiYIPjmK1zpm5QyW6MrCotIGY7HirBO/4+VxCZ5j1mW+
	y3LH0QREueqPaaz8UPwTSl0ee3ZbzYzL+HQ==
X-ME-Sender: <xms:iDc7Z9wLNtrlSR_oJOmEm47d_ewwVvJzGUE0CO0OsX1zDXXKcn-DyA>
    <xme:iDc7Z9TQcHY_dj8fSoZOaxmK2RGzLNUX8hdnW6BrDxg_4RirL5JL_GX-PT_SHKeTV
    7Ii4oMdh9N6Jb2ijg>
X-ME-Received: <xmr:iDc7Z3W6dxyI3a9MqGXsVFwKRIxly3LYQZ5_jGO_fw6SXXDakqwl2F7hjzzEW0_dA5F4C45yr2EQ3fUd6c8V3Y7k6YF8uC5BlAfc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsuhhnshhhihhn
    vgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:iDc7Z_jtPk_MjdzcQsCzIp3mbJSDocje5z8ZEQfjY9_GfDnMiDe8kA>
    <xmx:iDc7Z_Dme_RBo-uau7QjSgOvgwXiHXUo3aK6SqswDcPqEirtpSPJHQ>
    <xmx:iDc7Z4KQY_B-FfKZiOK_DvGo8wHVN_eua-Hd29VUl9W3G7lYxMS0Cg>
    <xmx:iDc7Z-DkrjSR9NutTzg47RdxP_bKndFTHCAMHms2wIvu2BzFywzy5A>
    <xmx:iTc7Z8LH5kmS1z6pl66SA6NLAfRTrzku56UGZmBCQ4sW6hXhSqexGPE3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 07:48:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  git@vger.kernel.org,  Eli
 Schwartz <eschwartz@gentoo.org>,  Eric Sunshine <sunshine@sunshineco.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  David Aguilar <davvid@gmail.com>,  Jeff King <peff@peff.net>,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [-SPAM-] [PATCH RFC v7 00/22] Modernize the build system
In-Reply-To: <ZzsJRFQ2KaJCiOyG@pks.im> (Patrick Steinhardt's message of "Mon,
	18 Nov 2024 10:30:44 +0100")
References: <cover.1727881164.git.ps@pks.im>
	<20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
	<b9e0f631-b2a3-4c48-8745-a4b1e3f58ad0@ramsayjones.plus.com>
	<ZzsJRFQ2KaJCiOyG@pks.im>
Date: Mon, 18 Nov 2024 21:48:06 +0900
Message-ID: <xmqqfrnok8s9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Now there will be exceptions where it does make sense to make something
> a build option, due to whatever reason. But I'm in the camp of adding
> them as-needed and not proactively so that we don't end up with hundreds
> of options.

Surely, your system may have openssl installed, but for
non-technical reasons you may not want your Git to link with it,
which is impossible to auto-detect, of course.

To be quite honest, while I am very much sympathetic to the above,
in practice, I am afraid that these knobs we _already_ have in our
Makefile are exceptions that was added due to whatever reason "as
needed".  Dropping any of them would mean that you are declaring
this: by default, all the past exceptions we made are nullified and
you have to resubmit for requalification if you want to keep your
favourite one.

That's not a very nice way to run the project, though.

Thanks.

