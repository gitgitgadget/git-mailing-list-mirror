Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FAB3537FE
	for <git@vger.kernel.org>; Wed, 13 May 2026 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778634660; cv=none; b=GIzMwGaM/ZMDs119a0r+CjrWVW7ZnjL7nrBpM8m8YewKRn+lDbUMnwlyWVFs246jyqp9mRUhC77GMqxbLED7uFpplOQU4frIELEnKBVpNQXUXJFtSbTiROCIpbY7cjoERogkuWT0mAoRt9IzaT/0RptPjLlWlFzMbufWkUUUV18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778634660; c=relaxed/simple;
	bh=O/YfGAYJKVewWDcvsDKW86r7ZP5C2QqYW9B/MXOb1UE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Re+xz7+UKQ7A2+t6SgQlq2XuOWQYJPtdnenV+xoDuRucNQoJpKTKRh5D/3XDXItWE69W641X1il0qq+9G9CMEXPTBD7y4y4sgxWdyM8paCrxiA9nQsHcIKVhscgd+V2Eu4fyiDcKNAOxy0jGFc69MF5LhKXLz3lU+ZCtzN3kUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QtnHc66a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OcS4Ky3H; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QtnHc66a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OcS4Ky3H"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AC2C4EC025F;
	Tue, 12 May 2026 21:10:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 12 May 2026 21:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778634656; x=1778721056; bh=CBGYJxefPp
	jbIzdPZQLo/JdAi+7EViSqk/pDwv0VzK0=; b=QtnHc66aBf/u6Dz9wTxTFZnl15
	4kcSOm9DmmUpDc1CzmNOb92wCn6ss2i/Gw7fORISN26Sw8QwLe55ga08tIVEQnor
	N4CHQQ4jScpQ7xWxjtyRAma+nGaQN1cu14R22Vvygj5IacpIf6lteDudi41R1KKQ
	L5AZFzbUSYG8/zlycic4+Fn1Gry485nrjfHUKEZpLOPjMmoblkwYsm3g93qKiCLd
	mxBwazUzJdb2tJnTF3EZTE6t/5VqHLD19nZ+Z3oAgNTxSxQDoHcoHb/uIEFdPOYp
	h1bSDrwcXgYlBh7KasL0VKN2Egx+YhFRX5qXy/5DAFcq/BHvQyZ8kcPTC3Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778634656; x=1778721056; bh=CBGYJxefPpjbIzdPZQLo/JdAi+7EViSqk/p
	Dwv0VzK0=; b=OcS4Ky3HEo1ZADkBy3lUmCCnErsuMViOrAUjHduu2ThWqkMG7+M
	m0QrGow4n5xtnWGvbwBZB3N53YOp//yNct5VHJxsokm/vGPAh0HrJcF2Z04R5CSI
	89pUXdWw7sbjWI++67xj5hhDDVVzT07nGHV3Sox/i1jhDNfL/LqmD/75rXA1ijK3
	XCmdmCXtGNGJ+eNOlG7V2+9LC4J3PlcaCSAVHI+27vGUGBqjQ+BQf98atH8H4ujQ
	cd8dNvy/XSZRPkIarK3vdkmK0T5yBS0d4FLnJvIbmTR7/cJfEOjWdtEYHje//RY9
	C3HoMhEFg60jmiCjOyoMjIwIue+9327sU3A==
X-ME-Sender: <xms:oM8Data5T_YqE4VRqqatr1O1Ck5vOpDSPCFOXGrKqePZ5zoMODz1Ew>
    <xme:oM8DarYkX8ktMbx40NeANazaOWkP9zAn5JVeZAmLXwLxsLnjcImt91VFCVfSUtvww
    tE2jkx2I7ueb4Q2yJ03i4B2nKIrRywOMxKvk3O28sAQfVDGNbneng>
X-ME-Received: <xmr:oM8Dak8zMFJnY2kJOUagnr-mxalxnKLmsYx2NotZyYl4qYVj2lmQfuI4al0vVZmlCJE5tFNGA69juRtBWSla8FA8SJ0LdfrDNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtheduieeijedugffhffefudeuvd
    fgheeuudeiuefhiefhieevkeduleefveduhfenucffohhmrghinhepvhhitghtihhmrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhlohhnkhgriiho
    ihgusehslhhonhhkrdhinhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:oM8DaqjgkvShFZ-Va4Nx2uvCqR3l_FzWAiA2bhuQKs1CEDaJnQcl9w>
    <xmx:oM8DakfNgZC1kZtfxnI_5wF9y-sDq7kBohPA8c7mPpOsEXhZnojSQw>
    <xmx:oM8Dahp_vEO7kM_Mzov7s4sEgz1XTp86CgH--e_jLtRyr6WYx7kJ4g>
    <xmx:oM8DapCNVnEAzpL0HZgP7a1Jikru2orV77h8UqFtDbVgSSSPD5ITNw>
    <xmx:oM8Daqe3G4HmNLxevw9c_itLq-PHSbXkIxTzZ9Yow-bOed2KXZkf7hlv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 21:10:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  slonkazoid <slonkazoid@slonk.ing>
Subject: Re: [PATCH] http: handle absolute-path alternates from server root
In-Reply-To: <20260512162619.GA69813@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 12 May 2026 12:26:19 -0400")
References: <20260512162619.GA69813@coredump.intra.peff.net>
Date: Wed, 13 May 2026 10:10:54 +0900
Message-ID: <xmqqo6ikjeqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>           ... Probably in a way that makes it totally invalid, but
>           if you were very unlucky you could turn something like:
>
>              http://victim.com.evil.domain:8000
>
>           into:
>
>             http://victim.com
>
> 	  Which looks like the start of a redirect attack, except that
> 	  the attacker could just have written "http://victim.com" in
> 	  the first place! Either way we feed it to
> 	  is_alternate_allowed(), which is where we check redirect and
> 	  protocol rules.

Yuck.  I know I am the guilty party who introduced the dumb HTTP
walker but I wish we could kill it off after all these years. I did
not even recall that we supported the alternate object store in the
"protocol" until I saw this patch X-<.

> I think we can just treat this like a regular bug.

Absolutely.  Thanks.
