Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328333F5A9
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321210; cv=none; b=GtalkVdK8/RrKICExmhfFYPiVaBXFi0fqeGRJiPfnavjxpD1Vj2aDLqSURAn39RNXZY3JpTl/bW6anE/MkqKDBaObZJgfIqaKlTKFdA0RrxKupG8ynTIpbved/KQx+uWkL2tf9UOgCChxPg/xhCdoWLpkeggfNlmi4ICCdRkT7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321210; c=relaxed/simple;
	bh=9biAqUEtZsHWEKpsh+d124SAPxHZ75LCEyeWrUtzAug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RFnEJJw/NaKpkB3XrMmKtpkqgUrcDUP9FzVPffH03ehrZ5ZJWQrrWqJD9BfAK0rAyjS1wMtEd23jEBkiS5r8rsnqItRltCTpHmHXuUkKqAXVxkGJ5YA9uohU86VMCpDr5MFBxFHHjwZPLCk5f5tsWis4b5tSLgWqWmE/1/C4vEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X/UBS+DZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CyOrqcWr; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X/UBS+DZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CyOrqcWr"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 6FE7EEC02EC;
	Wed, 24 Jun 2026 13:13:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 24 Jun 2026 13:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782321208; x=1782407608; bh=9biAqUEtZs
	HWEKpsh+d124SAPxHZ75LCEyeWrUtzAug=; b=X/UBS+DZ1gtM8dsXuLolPu1+Mr
	MyD8uJc32VsMXJZhnOjmfuG+Cb75XqIdTYhfINNdlhBBLtI6HOS96UNHLbrCENIk
	L+fyETcn3Vyb5W5MDONSO9Gq5kI4PfwBROEPG4QN2skjK+dchG9p/PtZSf6yUGzh
	6hTtqyee4s++BjxhR1gdSIrpA1Y8t9rESZKFVfpySslzgW520a0s+DqpSL1spxrl
	C/NQw2ahJ0EFvX6AQZnXp6E4NTOKBc3N+XoWvI1YJCUom2PbGj4PLLv3/ITOoPMW
	ZYVdxQLco80oELAibAzZhpod5vh3duSYwwzNnYbMCL/gGSLAbqP86tnRiy4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782321208; x=1782407608; bh=9biAqUEtZsHWEKpsh+d124SAPxHZ75LCEye
	WrUtzAug=; b=CyOrqcWrT8szsQNnEuPgffFVKrl88GItk2W0AquXAbPCRY5QkRB
	twvGdye4oYZgQfkzWlyw2jJ8J69ORDn+U/idZ4gM6OJ19euB/32gVc+SBLC+SKw0
	jzpn2KPvlotNdZa7DN3pALtXMGFuHsXB0uNlIcrME24uLTekJKqg2AakE5JEnuc/
	IO3pCCH96w/FLJHxIduT21rCEGH8uhdWjMjc8bYGfDWJ5V7lxIDbY9aJFQLKAwcr
	Zsh2U2nZK4XElmIUuBfGqXR2Xj7SC0NCl1rvUcx6joW4X2rM3EhpnRrC0JtLQT3d
	jTNudI69AdGFvPCryJjw6go3GetI/qIVksQ==
X-ME-Sender: <xms:OBA8ag_ynqAyOWQPBliMgaluouAR0scgktkjVZWNeZXshyo__w4TlQ>
    <xme:OBA8agKCzAo9SiijSz9U3_G9yqhRVH4d6RMLLa8OgRqDnD_m0ABpQT21tAZgb3fzG
    iYoSfMGNExSi79QT4T7XiIu9qvCIl4PxcRYPWj_xns7ZaynoPoQ>
X-ME-Received: <xmr:OBA8ajYvNyAYukZdKqEwQ2t3KIaZ89b_9gTp_RXQLMXebuiVW_pDyMiMWAV_i3_2b5qORg-DSPYL15gXb-EpMQ4CXy-Fne65bJ-5iqU>
X-ME-Proxy-Cause: dmFkZTE+XJ+bd2y25QaDWt+vJ0pEzRTBBxMQ+/V+xJIDdeMeRaN62CbQF2APONTkdDQPV7
    csUS9kBGNuzDwjtUJMhu8cd2Q0Kg/T3DV+usnpVX1RswQ1smyb7NCYJmQmGDeJ4InXyMOf
    tlj2+q7QB+I62ymLjVurMCqjWTuhEFFhyNYJwmYUDtDKHh0OHXues+cepRbrUk8i6ZL0tY
    7UCFMnkTTgDj6PxuQK7DQWUl/LeGyH3JeixhDNpYd2yyXpFGUQqnvjppR0S1MjUvmjD8EP
    iWimnZyl3g4ZrN74Eh6Ku5gGEhtS3q9aps67thGnMxMcHqQrUroL5y2VOJwiQ5OoT+nOh0
    xR/5/EkZsgdOZ00QopQE5aeHH3UNr6QQaZDfPy8phRtCiMzcwfGdG/4nPHDisCi+tD9nDK
    AWREXx0V0EoxzMiJrCOQdprMT71f+yew3G6A5e17oFebAj7NpBwO2lmHmvoiberfW/E6MY
    iRxQBZD/B+E/t0W9Ks1U3XVHkk7GnIgaff9zgT8p3eKClrBRp1vUujXforIHt/VldXZSts
    zNd7LqhFRTU4PcfbhAH7xqjg4GsXI5gdp9yIW/XF51Ol4UT+TyqLy1PBA4hhSeEQtmi6CC
    tT5054GdE0qOsJt/rC1opIJVqbyG0t+qjBiy5IZltG+iuM0yFRO82aLmv4xQ
X-ME-Proxy: <xmx:OBA8aqIhfI4KfJ4qgm02ohwzbSe7CCtA3td1YoZ9aWTBMdF2PqQmGA>
    <xmx:OBA8apBZyxiw4_Yb0Cmq_JY-qZPj8b4zzGKkCJiMIMz_6imVtVuqMg>
    <xmx:OBA8anoDXrwNfQw0aNwbshDO1caLD2ZpY_0y5Ud-4rykFg8X613PcA>
    <xmx:OBA8asggchldZctYOwJwI2yS7TKAt8bBQG8AJVDhE6qJrYq61pTIDA>
    <xmx:OBA8agQZS_9nA-x15qauF8E0TFkRQz_vNb5BNtxb8qUd-iXlkng6qMXb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 13:13:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/6] odb: refactor source-specific information in object
 info
In-Reply-To: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
	(Patrick Steinhardt's message of "Wed, 24 Jun 2026 14:19:13 +0200")
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
Date: Wed, 24 Jun 2026 10:13:26 -0700
Message-ID: <xmqq5x37kgjt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this patch series refactors `struct object_info` to not contain the
> `whence` field anymore.
>
> This field only gave the caller information about the type of source
> this was read from, but it didn't allow them to figure out which source
> specifically yielded the object. So instead, we replace this information
> with a new `struct object_info_source` field that both contains info
> about the source, and any backend-specific data.

Great.

