Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC142048
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144434; cv=none; b=G2CUJ/4A9BTnyiKkW7wIe7iT4yk9frp9GoEBD03eWafSjo0DmF5wTy+KdAJsmPpfGmwFwUYbG87JMncq8pR+cGwr9ABTb6ZvemJJNevpk1KTM6LLRy3Kzz/oR2daogHZiwpkhIpTQp2zqB7oHHNSTZbdNuOSDu5miJAN5G+fpJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144434; c=relaxed/simple;
	bh=88PS2I+9uuKtkry9FIeSB2UU8i5xbIwdoOBikj/BeUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P6+2u0gZrtuetkZmbIe0Qa4LRCMrInvO+mHwi5YmxUDN2iNIM/R/wbIhXWEuuuUsnOwe6uaeogkcGYdodlMB5CJ4CxnpCg5jwbSoCyLPN1NJihqPfr2MhWC3+bM5bAW1JQHlRUEsI7fwDNCLsxqN33gYOTTUZxNtYMHTnPGlbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yJmMboB8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yJmMboB8"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E027F254010D;
	Wed, 20 Nov 2024 18:13:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 20 Nov 2024 18:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732144431; x=1732230831; bh=88PS2I+9uuKtkry9FIeSB2UU8i5xbIwdoOB
	ikj/BeUE=; b=yJmMboB8Aa9MvGi+xRB5Gv4emrkC2+Au1PayNzzGvoWAaM4on4s
	+1caF370TQw8pSTK/yaYAGQO6GrLF97mLiNFRV64zAkTEbnHTZW0MZMtH/sFicjR
	uoF+HOTTLALSQMDUzZKa3fbA6wTrJkmsA8zkNagRe/qCMshQ8GXF1qImq0fuWedz
	06TMhxKYXTpFv2Sl8Xl9coT1d5n8CyOsm65CpRz6GbNHk6Ac3h5xoL/4LWt0B4iw
	RKBvVyvAxbaOmE9iu1PuZTnZ/nFoBzpv0F3JmNwZuUIIQlXvFY2z8reyQoreVeou
	pJo2BWp7/Q2U7aQzt2By8VifaQ5KCgE8S0g==
X-ME-Sender: <xms:L20-Z6DxWRnX0srx51EhWwTWgRXillCW3MG3fllnRRZlNs7J8aN7ug>
    <xme:L20-Z0i912HpHBOXn3_lfbFfOZJ2x2RmRMxhddL410InA7-wi29KXBVSScA0gmo3u
    bStWejzDiu9IfRKkA>
X-ME-Received: <xmr:L20-Z9mfqmKj2RiJ3i3kM8ZqGUhMs6D_gstAAY1NhpUSkxc-i6e8Pf1avzgIN7eVfZRaUjohLtsxBr4XkrLcFo24X9kDuVPoPcy2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrjhhushhtohesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:L20-Z4xxMh0YlWtTNnpRimEzECl1R4RUXF6qHJf4nfkL5YfffsVnjg>
    <xmx:L20-Z_Tk0RF1o0huP_LfNxX6Q-0hpTkVP9WGTlBKaX4No33lFsJw3A>
    <xmx:L20-ZzZQ6FO5NtAEexXlYlqKkqRpOKzenkWGAIeYwZtTnXeDHATW2g>
    <xmx:L20-Z4Q8YKrEkGz69vwl62bxzrBmjeiAkae_Qi1sWCT5GUR3vJREGw>
    <xmx:L20-ZwLtIAN3AN0EC1XYm4zFYloIhOOO8uwniaMd_uzxB5yWRsGt6gLP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 18:13:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  =?utf-8?Q?Rub?=
 =?utf-8?Q?=C3=A9n?= Justo
 <rjusto@gmail.com>
Subject: Re: [PATCH v2 09/27] strvec: introduce new `strvec_splice()` function
In-Reply-To: <Zz3Y35YI9ysFabUJ@pks.im> (Patrick Steinhardt's message of "Wed,
	20 Nov 2024 13:41:21 +0100")
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
	<20241111-b4-pks-leak-fixes-pt10-v2-9-6154bf91f0b0@pks.im>
	<877c8yti5n.fsf@iotcl.com> <Zz3Y35YI9ysFabUJ@pks.im>
Date: Thu, 21 Nov 2024 08:13:49 +0900
Message-ID: <xmqqcyipijma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Double asterisks are typically used in contexts where comments should be
> extracted via tools like Doxygen. We don't do that in Git, so I don't
> see a reason to have the double asterisk. Our CodingGuidelines don't
> mention double asterisks, either.

Should we add an explicit mention that we frown upon double-asterisks,
even though many have already slipped into our codebase already?

I personally do not particularly mind people _preparing_ for that
someday when somebody starts extracting document snippets out with
these double-asterisks as clues, but unless/until we decide to (or
not to) enable doxygen processing on our codebase, let's not insist
on adding/deleting double-asterisks in new code during the review,
and let's not churn existing code with a patch that only adds more
double-asterisks or removes existing ones.

Thanks.
