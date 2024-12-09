Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749ADBE6C
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733707967; cv=none; b=gDhFmDe4sN24/TUSF7rPqvoZIW8Sswc2yDxhCsMf/m6mPL3s07kYqW/aahqAOcykjMYE/2sGe6XzyQk0nUOoALDNNkFv1RmyCl+Zzu+zljElf5MsMalvMi284kmcmmxNqNk0t+l4GkgM4+HeW5/sH5s0TqzbgHhJ4tbQO3Xpb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733707967; c=relaxed/simple;
	bh=60o8Z8MPe/qje99Awdhdlqc/YbE/+WnTfxw23tlDw0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uuzMfmB88Ue7xi7wz66T90BWJ1R1XYHcHM7zZpEFKlovopDIDumkXK+3jRx3KThZYFLu4d0zriTXBZy+XsMa6NDzm6BImgp+pD0x03XZJmEW6uGzNQfFyeyByx+iXpyyEcE5gWMBZoZ7zxAEemXWhjWaMbQ6SfA2QFsQq8acKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GIj/HbSy; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GIj/HbSy"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 561AD11400F8;
	Sun,  8 Dec 2024 20:32:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 08 Dec 2024 20:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733707964; x=
	1733794364; bh=fHJImvNp2/J3I4+0A5mnYguBs6+cLQ+Y8R6BEr9B+eU=; b=G
	Ij/HbSypU3mVy9sGsRaElHPnRyV4U4qJY6GAFOf5kVrhZk/Gx+T3iRpGTJE6vft6
	sdjnLIgnqqONnRVGr3LQaB3tVZJjZ36iRp8dOPcyn+Qym/jQjbBP9bvEn3Csz2Wq
	j3PGkAHeZJEUfUBEGPqS0fT7x1ETlNvi3+9bAe+jYAN8uk56z4VgPG2C+A2Hvwis
	rI28shYzCSYw3QekTxeAIiRZboHfyhhzK4NMYRrrI558XjQtZU/6fvm82ukAJ7pw
	eXZRhdveh4uOGCfGrpairbLcdxCaHerha5My0z55to6QybRA0VUFUUaC9zL5CnQk
	zEbagVOSptWOUQAabIyvg==
X-ME-Sender: <xms:vEhWZ_RAu2mj7BV9eN-VOdCVlUqSClQE0I4b8iourDDGNWuxtqhnIg>
    <xme:vEhWZwz8-wGGfk0fM8FC-JsR47zUkUCC-0mQWN8nbbAlmGs5FsS1ryqWWdMi3ccQx
    mReudTdNpNn0XuLEA>
X-ME-Received: <xmr:vEhWZ01xLferEgqJlILQrex1ko60pT8auIRtKsXALDyhUnpgZxr4DfKjYiYq27JXG504o6iyFCERaDOdQJGo1OKqmILFUyhV8PX0iWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeggdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:vEhWZ_DXA5BqbLeI9d3js9Ulux-jWC7ZlzSyK8O7K3ccELeXFjcZbQ>
    <xmx:vEhWZ4hVKDPyiN3qJnkpN73fCDPxfzxBSDW3OFW3Ri2IBUAVnBjTbQ>
    <xmx:vEhWZzo3S0_hLZBq7YcOZ1CqbMh9fSN9K3nBK3zIOQ47sEg2-GdC-Q>
    <xmx:vEhWZzgxuv65enmAryQuYgkmsTZcIHbxj399TEq74tqn_nyglfxDFg>
    <xmx:vEhWZwevm7Qxpt9V-6qOhagnSTC5FiglxQqOQWnGzUBPB3FiMfZFD63E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Dec 2024 20:32:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically
 initialized vector
In-Reply-To: <xmqqser33ga6.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	04 Dec 2024 19:15:45 +0900")
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
	<5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
	<xmqqwmgf3nf3.fsf@gitster.g>
	<c949fea0-817b-45f9-b8b2-55e1cb55e915@gmail.com>
	<4e60eedc-e4d9-423c-b2e7-f1c65bccc254@gmail.com>
	<xmqqser33ga6.fsf@gitster.g>
Date: Mon, 09 Dec 2024 10:32:42 +0900
Message-ID: <xmqqy10pprnp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Rubén Justo <rjusto@gmail.com> writes:
>
>>> ...
>>> Sorry.  I'll re-roll later today.
>
> No need to say "sorry".  Thanks for quickly reacting and starting to
> work on it.

Any progress?

Thanks.
