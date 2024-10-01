Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A719FA9D
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810973; cv=none; b=JAjjWxMhtPJhvJmHdzN7emGVTI8vS1S6R6rgBObjM7cFR0arOsEAgKSiPLr6WX1tWgoRhyrzWzsfuh1Jx+VEwS1Xg60xzIOlMrw+iWzFp5Io998RTNhus4xOa0m0bQUFSNzTNBqyrKhTUMD9t/NLAWy0rCjO6Hz+jxB6rZnoQAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810973; c=relaxed/simple;
	bh=9stoPNYqj6nYAZk6JKbqOTpVKmNI6c3AELJm063lJxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qb78HXxDgJGHMPKo5TaEC5bCiSeP6clqpCu9juCxUDWnI+PY46H5mnPkPxXFqRfql1UO+kCD4e4gKiSHaFts4b8jDOv/CYZw3ulDWPYDH82U9V89hBU3foZAWHAoehwSp9A2XuQiVlT3W96OUE+z+A5j7/ziokmYjnl3ovLDSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pFO8BxUO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hKlj2G1O; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pFO8BxUO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hKlj2G1O"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0AB581140D98;
	Tue,  1 Oct 2024 15:29:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 01 Oct 2024 15:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727810971; x=1727897371; bh=NJxYQef//U
	uhILx1CI5U+Y1oHB09bH42LTPABafnOXw=; b=pFO8BxUOnj2OOICfA1NXG9LSGi
	EUZLFYP85vMsP8rwm53CntKEk7dwO+C1LCHNwghIHrG9IDKDHNbM1hUq+u8N7O+j
	tRV4DT9mV6Nl0d6ADrNuKneClLrrOy334iGk6sWk+68DhBL8Bfed/981aPlCv7Q8
	//YZkJFm9e1QHtgzWT47FhS643hLgar23P+d3dak7GGQmobKM5facvwPbDez0DPb
	a7IonalCzzk+zDX2OGb/sz0iBhYd3ZTURxrBEZEGtIIVrww+vw3mMjyZqc8UFiWt
	UfHBSsZyjqX4QNT14IMxChK0vocKuqHmwV10VkSIf4REFyw8UsfXOmNVoReQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727810971; x=1727897371; bh=NJxYQef//UuhILx1CI5U+Y1oHB09
	bH42LTPABafnOXw=; b=hKlj2G1O6ZgFHXbo0EvBh8hWws1Oqf4FlzqcbAsNT6Ch
	a6mm8QqBs7C4WUSHZHJuUTzDnyukeZnKtBgP9iF8yDiC4SbaRIYaS5X8FY/54EP/
	tI1ooB2wC5yJtPBdYHZAVsMGf2Lf/XPjsSw3lrEnLNZ7gbIRuUY8surYI9S8rVVz
	+vxgeD/LxeHRIR6qkjP1yHmH94wL/ls0R93hwW9CpBNvbo5ULmNEtiIJyWbrX35G
	sNDK0CL0rvuAzMVDjhP66Ypp+awORIDs3rmAABDpIViX5bFCUSoMTdL2Z9Hg8OV5
	7bEB0WP+/Eqlmv3DhTpPDxgUI4v2zD6egNIunU5XPw==
X-ME-Sender: <xms:mk38ZnWNEMdcNIrs0VwNpanjFjKnV_q1YpSogds1FsyWWBG1BwCvLA>
    <xme:mk38Zvl09cYJKQPsGpuAgZKgVGQbs1fa9UZQJhRvqdUl5Vw4msYK9QPlsh-rc-48N
    -SDF5R1XSm5F1kMVA>
X-ME-Received: <xmr:mk38ZjbchviI2bB_6DeZf3x9nTGLh-OFhBCBqMpvt6WdqmDV2VaPFsBZ0pVjespebvmg-p7ajTsXpNvXuiPckTizOl4Bi7bWv5_kelA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:mk38ZiWz7xVeQB_m3T0rmuyrfXhlXJ_d7nyEMNpnczTtML5hBqFm6g>
    <xmx:mk38ZhlJYio2UHapd_zCNMJ8XTNlay0t52SEAC-gx8LyZnkS91wEow>
    <xmx:mk38ZvcxeOtosUKQN8pwstdDBamn7PjvPIY9g0lZgfHkK5w8OQq9ZQ>
    <xmx:mk38ZrHBYvPnMzZ1ZDudnVke2ZF248xu-kgAVCg-Ru9-_9s-fF0Fvg>
    <xmx:m038ZqB1jvii6spAnRsNmZ567wM1Je2-fO6fN1JcNTuLuvtS_HGT9LPw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 15:29:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] bundle-uri: plug leak in unbundle_from_file()
In-Reply-To: <87ikubsl9a.fsf@iotcl.com> (Toon Claes's message of "Tue, 01 Oct
	2024 20:58:41 +0200")
References: <20240826083052.1542228-1-toon@iotcl.com>
	<ZsxQBEpfChQozhF7@tanuki> <xmqqle0jmfpf.fsf@gitster.g>
	<87ikubsl9a.fsf@iotcl.com>
Date: Tue, 01 Oct 2024 12:29:29 -0700
Message-ID: <xmqqfrpfvcyu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thanks for reviewing carefully.
>>
>> Both of two callers of unbundle_from_file() are used as the
>> condition of an if() statement, so unbundle() that signals an error
>> with -1 wouldn't be a problem, I would think.
>
> Hi Junio,
>
> I've noticed this patch wasn't picked up yet. Is there anything you want
> me to change and have me sent another version, or is it good to go in?

I am waiting for a reroll with an updated log message, i.e, what
Patrick pointed out in his review.  I only said "yeah, this looks
safe", and never meant "it is so obvious there is no need for extra
explanation in the log message".

Thanks.
