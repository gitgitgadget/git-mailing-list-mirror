Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473F1C1AB6
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550842; cv=none; b=KMByGP/Qkq+rT55DjhoBRSghbLqMy/ZA74PYzc+/wB1ESc57jk+dL8GfHJnLwJqzVvQGrtnz/k/EtKEwGUNo3Ply1nI4nWY5bL13Z0VPC17qdAILnRets2makR6UGgBKc/OPkEbq3Pp3tP0rX4YOWAFqx9nPZDGiQtJZqgQH+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550842; c=relaxed/simple;
	bh=8Uq8SQwU5+EZlELm9IVS/sYZm0PJdyESGYpa6ITKrgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DKftOjwuBrIbfWbJfWVVIvtAoWI1xT/FbLXabtcGbdOnCsnZp9YrUI+S2tSHwScd49bOZV5KhXO6AOYFkbN9EceA0VyyTg5YPcGsBDxm33mPU9zLSd+jtb6c87ry21MDkNqdCU4alAF6S8pe+ZPTraY1+XtwPBFbRCar/IXeCBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fZtF235C; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fZtF235C"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E7521380208;
	Wed, 13 Nov 2024 21:20:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 13 Nov 2024 21:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731550839; x=1731637239; bh=EHr64BklnKSWiFcw5Doorm2kkekb7w7uC1X
	RcJhtajA=; b=fZtF235CFGsAjo1AWASmblQFhKQRGPDDPE+zkd/CxYvGlfE14hO
	NNPMOtdX5SLnEAiyTgo76FkI4ZTmsv2opXYkHY+znr/NJo34oommvFIcdZUAbJq7
	syl+j+SdevsoLrDrNMb8Xvn01hZGd32KmEBLYyXeI2xrOIs5O77vReJgx/i4EhsP
	YiBNBZtrsliW8nJ66ud7RTomLb1OUL5gOafGBUrLoE41NNd8DMvPbGp9EyMQrtpi
	C2OHMcB+BbR0Yq+vjTP9iShata8LrNiQpMzFJEXyIgtW7Xhkp1hf3GZcu4Y6kG3K
	XWTk2izedeanS93ZlE2qBLViAgea6Mt40LQ==
X-ME-Sender: <xms:dl41Z4Q8SkMIcvLaRC3XbuG0k4NSmkzz3u-MsMqbEyZmJTH77fy-EA>
    <xme:dl41Z1x4oOKOFyiUWyvQyA66cGv9hI4q--lOReZyf54LCEBB7-ZsjdXRwopeb4K9C
    1BcLJlKomMXMIG1wQ>
X-ME-Received: <xmr:dl41Z10_pl7Mp1VBQ023MAkzwksmDZ5zG-s6joD9m5KtYxe5COIrFDkGJ0JTa8lLj1zcyklEtksKILaBUN3DW02Y2FWBdAxsFSWv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepnhgvihhlsehmrgihhhgvfidrnhgrmhgvpdhrtghpthhtohep
    ghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvugihvgesghhithhhuhgsrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dl41Z8D0Vf5wl3sY8Lilhfmy17bEUrwQS_QfDjsPo3XPxBHGABArgQ>
    <xmx:dl41Zxh6weENojuaI2QFM_TpMdwA7ovNZjytrLaqSKN4jA_w9gCXFA>
    <xmx:dl41Z4ooGdK4DEX1Ji8Q7Z9I8PQnveBA7ZrGtJB66-C6BuIeGu9EFQ>
    <xmx:dl41Z0jQ94z363sIlROYHfeGT66ekUXqjh1qV6dYl1PqqlkJjqqTZQ>
    <xmx:d141Z8XKj0G5qYLqaFNGbjU-2mZllhxAS3bSw39es-5iS1vJ0hD50S_F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 21:20:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Neil Mayhew <neil@mayhew.name>,  Victoria Dye via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Victoria Dye
 <vdye@github.com>
Subject: Re: [PATCH 0/3] Strengthen fsck checks for submodule URLs
In-Reply-To: <20241114001003.GA1140565@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 13 Nov 2024 19:10:03 -0500")
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
	<20240110102338.GA16674@coredump.intra.peff.net>
	<d9f53fe7-6570-4aea-894c-942e12e012c4@mayhew.name>
	<xmqq5xoqahbx.fsf@gitster.g>
	<20241114001003.GA1140565@coredump.intra.peff.net>
Date: Thu, 14 Nov 2024 11:20:37 +0900
Message-ID: <xmqqzfm27dze.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> ... I'm a little skeptical
> about its security value at this point (especially because hardly
> anybody runs it locally, and protection on the hosting sites isn't that
> hard to work around).
>
> So if it's causing people real pain in practice, I think there could be
> an argument for downgrading the check to a warning. I don't have a
> strong feeling that we _should_ do that, only that I don't personally
> reject it immediately as an option.

Oh, I see.  I do not think I have strong objection, either.

Thanks.
