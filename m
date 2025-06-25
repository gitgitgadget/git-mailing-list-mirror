Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B52C1A2
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869043; cv=none; b=eOVlIv0WnF2RjMuM/l/bUZMJbZ96hVTzoXPaS5Crh/WRGmZdj/prhcGcGGfct2S+Ti2cGuL24MUL/YdgCpQowNbGh7vvJr8/yZKYS8kLq9D3ISeqXFZYoiBFa+vqddrQ7fDEgMAK9+mJ96u+ej6JvijwuMQa9sEG+VOKOXcrS8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869043; c=relaxed/simple;
	bh=3O1t7SmqqPqaN5PhuwxfPvJ3oMXcnEZ83xzVC8I0mPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YoYNembf7Un3kAPdZyROivvIfGQWLdp3ZK/iYP/BoyZVNKIX9wl3MQDio5i4+Yfi67JBednjB2/r+kDCLbATXHc1Cj3keQKT1PdfEdG6FfJr2XFDby02o+X8SNN1xvBtOj45aFuTHCs7D01hwI1G3GihCrjBnU2zDHqYKmm8Phc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JnfQrFwi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kl66Q0CA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JnfQrFwi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kl66Q0CA"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC75614001BF;
	Wed, 25 Jun 2025 12:30:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 25 Jun 2025 12:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750869040; x=1750955440; bh=xSxVGr4jYu
	gEza218WAq5uejB0UupeSKks9SqvzoGls=; b=JnfQrFwiQqUBEq/05ECosv39Zd
	YALbciDThMNfR/gRbGU8Msdb7k2jgw5s1ESFPPboVzo64ajMCtqsDrTh5NnvYMjR
	DY4J6VVNgc4tH9GwsZTiIvWHHzQK/cjA7HChcZsRfvlSIRBJcZUXMJECL7OUsMQ/
	n+VtfibmrtQPTtYLwG3R/cfiUr74DL31g1t/SL+ILQpDjC94YM1CNfSz+DVQh6Pk
	GCwgOmT6a7R//Ilesy/i3kDCNsFiLxPaVct4J4/s7gRYmKkpGuUwTp/6S9vhXCb8
	dPRxu7pPKzHw4z2XlTxrgAO/qA3ceEf3sr9ov9nVXO3wZFc2eqtwp43PxvDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750869040; x=1750955440; bh=xSxVGr4jYugEza218WAq5uejB0UupeSKks9
	SqvzoGls=; b=kl66Q0CAd1qeN3iCt1LmOtCYxsmglGL72dl23ibZfFrehPwf/Cy
	yeSJUqPvT5vFe6+NeK5wZ3mbiiCDG5jdSL6oAsXpRR5XadgSSmSxrlqB34tRp0dS
	AVh4W1ZUi4+UwoXURDdUtB3bB+G3IlMAmNDKjijwJp3yb6by0PaFQbay3/1EGtqD
	fZxjWIt0KoELhWeu63CKvrran75O/WJ64LH5HHJaYZm6y8fiVXP8i/0dWVIr9Ej0
	RMevEAjPdiuyZ9tO0pKIk4CNkIIGlaZ+HU/OjCW7JTzTc1Zv03ywoURlYld0DU9S
	A259O/slCPbNZ1LjVwmN+8ySiwnP0SHYfFw==
X-ME-Sender: <xms:MCRcaLEZE1eEdvRG1gP_efy9G_s3S7Otd1M28c_BAj_ZZ--b3HI8bg>
    <xme:MCRcaIUSWbHHn8Oc5jWl_pJ3JouZDADo6uiIh75IBXG9WdAkqcFcJ5flxn7a4iTBj
    EGXS3JTaLtqhvvRPA>
X-ME-Received: <xmr:MCRcaNK4jOkorDFa7KC2ROohM1lHoicnPjyEYa1Msbo2DJTrctY3JV5NToZfEJ1qC_cs8uP6rG7pTmwCaacIsTLt33UU9iCRHHJhFkk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MCRcaJHJcqGkAtXcPnRrVVFeN2EwlQv7MrTgUn8L464XEdWm5eXVnw>
    <xmx:MCRcaBXd56ql8escz3DjMaLcWo8dA8vnDxYAQvp9ifwVbRlyRrWpfw>
    <xmx:MCRcaEOcnJvqNA_64d6-6srpZzFoiXbVMBZgcplJThBnO-keNBh9ZQ>
    <xmx:MCRcaA1MdJDvD8sOExKesrPFL2aHd6K0qO5U4IZ4SIWKoRR12UxWCA>
    <xmx:MCRcaJvt8STvbU9jykBOYx_5hHzVB1rvMiCkDntB2QY0h9BYQeKS_Bww>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 12:30:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  "D. Ben Knoble" <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v8 0/4] Importing and exporting stashes to refs
In-Reply-To: <88915a18-de18-437b-bd74-91fb82ab760e@gmail.com> (Phillip Wood's
	message of "Wed, 25 Jun 2025 09:40:46 +0100")
References: <20250601223225.464076-1-sandals@crustytoothpaste.net>
	<20250612011221.4158484-1-sandals@crustytoothpaste.net>
	<88915a18-de18-437b-bd74-91fb82ab760e@gmail.com>
Date: Wed, 25 Jun 2025 09:30:38 -0700
Message-ID: <xmqqcyarwzpt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Changes from v7:
>> * Rephrase the documentation to be slightly more explicit.
>> * Don't have `write_commit_with_parents` free its arguments, instead
>>    letting the caller (who allocated them) handle them.
>> * Handle invalid combinations of arguments to `export` and add tests for
>>    this case.
>
> The range-diff between v7 and v8 looks good to me. Sorry for the slow
> reply, I was off the list last week.

Thanks.  The topic is in 'next' now.

