Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469FA4204E
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715209; cv=none; b=JqmwPvcFf9UvVABiBmQa9ILCpxzGzA4wrUS0oDh5lBzj4EMqvCw/GXzI6aJgTmFCQMbY8Hv0/BaIamY1W+U2GTAchS4yBBfbGAyBKhLwkDw/HDhXSXLytvC1dBYQJjnrjckuVxSJrHDLSeGJscaQFiPa73Wt7OhCv7IbucXMJZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715209; c=relaxed/simple;
	bh=yQ2iZxVJ+TtK2GgkvXbud8GsbZku/5LG+zNmG0+AWho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mhmUWJLq2Z8Y6+rmGW6ILqlB6oW5vslerWAzGvtnl403Em301Vms4tLqiTpbJLSnfYHMIib8nQpFvJF410RktoE6xbdSnOHo/txM3lfhLKJpLcdoFbPRqsNf++nMhgVGBtykHdAZFCm4NBq30ojCorzUYkcxZmTQ8FSWlFq5gxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KPWkvhbC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=In4kxgKN; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KPWkvhbC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="In4kxgKN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CF4821D00183;
	Wed, 17 Jun 2026 12:53:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 17 Jun 2026 12:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781715205; x=1781801605; bh=iRvDyugKLv
	q7BPKH3wIgD3gGNDnNJ5hVJz/oAEtunnE=; b=KPWkvhbCTx5wIlvaEa9nkJ+z4F
	ojuUwY9KcakOnfx3UYTkNqqHAYyDD5jmQR/uIAZaco/h5Apuc1HGfDgGjWTRkaE2
	aq+pCIAFYJ1ba2I1EYhNibOWsJVLrQ9JAxhb915gS36mEC2BlzTJAKT2TNuhOGzI
	yLBq+chAcUYDQnZnnWFNRnrxSA7Tqs3j9cxrNEQM1ZYkQu/1mvvVe9paulnYYkZg
	q/OsMmitceFqQ9cZw/1QPvk2G1kSh0Ov2jMim+DjI7Cr4yq58RciiFNekhMqmT2x
	I2YnwAHN8nFsd8WYel4DykbDksG65hEVmq69TP4Vj4O37UIc/7sdgBd5HNpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781715205; x=1781801605; bh=iRvDyugKLvq7BPKH3wIgD3gGNDnNJ5hVJz/
	oAEtunnE=; b=In4kxgKNd9yntMbegisgmYfOhCX6srPhu5w2JLwJ6WjXFXpvgBl
	XuIshXAJkX7myhRR35Yz6v0RlLGNPAWFN4l/ahKRZ/J1Fj0Fhn69jldf32xYucGu
	XyqUHfI4jyARQ6CWQJkvN0HFdTTFf4fRh9+rdXuJWvdi9cUzEZLAmoXBXRQAn/oI
	TW0C1klrJqEILjRnxpR8Z7pNChuHeCojZcEwvH3Nn7Hw3TcjJz/kLdCrV764r5i7
	3lVf7vo9zh3FFjS2ccrr7pTGcQDqysxVBJa9yshXtID0vx/lSV+urwAT46CF8vkA
	X4YBxwsRadnqMubb9HH7DYj4tWVydI1ipng==
X-ME-Sender: <xms:BdEyapgFF0eCGuZgTmG01MzSTANXarYCB2pdM-gApiUyzN_pMMGwrQ>
    <xme:BdEyak7YIAc8M32fmj6SF5-dg2lan3xBr4oPcBy6FnvVMdlNEocQsHZAtkOsjvVaB
    ZWa2Eu-RbACG33O2PpAogpax4R0KttZ0C1p-nsvbmuYENSTiobiIiQ>
X-ME-Received: <xmr:BdEyahbATDrCEllI246Bymrg9465-BbsrAWC2OPnEpsihMhWLZH6JVNJI8itOA2D_S71js-AVt7g-4lLlOaMjh6MTHYF41snK7LU>
X-ME-Proxy-Cause: dmFkZTGeX3Jn3fFu6tKo1291caKzimL4qUNqLxCBLHceOQowtBzt8cJewfYbnPorEytV3B
    OONAaSXUB076iAvit3t1tsZaDmUI739Qc7cHsIHiFvD5lHiBqDhGA3J0SoXwNuAbjsXzqe
    eSFMeFYuP1gXyJJZWNiwSbuq3yexe4jBn7rSJPXpniez5F7MMfhlmTUBezvrWdJmP2PIFr
    eP+Lek62C/qFTL08u79K2KqeMGz2SbLtfGoPiJsIPxpg6398KAJ1YXuG1MH6lnZAppfltZ
    5XRF3KgEXB2VXROuuvn+efcbFK/fzO56JIu6mOKfXOyV9z9KyySUNSvwDnVddk/oLJaYnX
    M8CLLia3ujKqGXqWFsyWOZ9xt0Z60LTI640dsfHT6wUG09ckIPL4BB/6eT3NjxDQhML968
    UcaTlUkevq4ZGbTh8aLj32PbMTFWWdKsrLMcBzemzMNZnm6qVQEtiAznCu7TRWJffoTSWa
    kjtLshE84+V92KYrOvSvs2kARbglTIkQpdAM0GhnEVImhgZzwTGWXgaIxCuFtTa23cbfuk
    HehdavoPiFK9CWA4PeJXt7rBxDUCnpd/6D+XjwJczEsGH4vrRSWkqRyD3R3lsNyDcI75QY
    AEeiQ2IB3oqXmUVAY3l3QbAKDXxKQW9WyI/S5uWG9+GhaeaPv6P4njdttbYA
X-ME-Proxy: <xmx:BdEyap63KnWAXII9VPfSmPVPmJDKRSzTbsIWi8xeTuiYKa9hRPuckw>
    <xmx:BdEyakDf5cJInjt8UDACq-KkNeE0D6Y58tG_xh0H4ewBBpp_k8pcOA>
    <xmx:BdEyavfnb9W6AbECK6Ua-VFney5UZvpEUNA6-fi3hvS6iXI4PgwukQ>
    <xmx:BdEyajL2-sq_ESUNjbBKIbbOp7RscLEGGunAX3bTQQ7Bn74gDRblKQ>
    <xmx:BdEyalKLoVWil81jkwctb759t4tNMJeTFa6UCsaW7-OamQ_JLhOcszT5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 12:53:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v3 00/17] odb: make packed object source a proper
 `struct odb_source`
In-Reply-To: <ajK2QKdW-TdflfR0@denethor> (Justin Tobler's message of "Wed, 17
	Jun 2026 10:02:46 -0500")
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
	<20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
	<ajK2QKdW-TdflfR0@denethor>
Date: Wed, 17 Jun 2026 09:53:23 -0700
Message-ID: <xmqq1pe5xg58.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 26/06/17 08:39AM, Patrick Steinhardt wrote:
>>  5:  8eb3cb17a1 !  5:  c9b1e1da26 odb/source-packed: start converting to a proper `struct odb_source`
>>     @@ Commit message
>>          odb_source`, as it's missing all of the callback implementations. These
>>          will be wired up in subsequent commits.
>>      
>>     +    Further note that we're also registering a `chdir_notify` callback to
>>     +    reparent our path. This wasn't previously necessary (and still isn't at
>>     +    this point in time) because all paths are taken from the owning "files"
>>     +    source, and that source already handles the reparenting for us. But a
>>     +    subsequent commit will change that so that we're using the path of the
>>     +    "packed" source, and once that happens we'll need it to be updated when
>>     +    changing the working directory.
>
> Ah ok, the "file" ODB source already has a `chdir_notify` callback
> registered to handle this which is why we could get away with using the
> path taken from the parent. Make sense. The explaination here is very
> helpful.
>
> This version of the series looks good to me.

Thanks, all of you.  Very much appreciated.
