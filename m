Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E3D18DB37
	for <git@vger.kernel.org>; Wed, 14 May 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244215; cv=none; b=PJUjXcrEzfmm6grz5N+UN4rv52bkYNzhSXiBFQEpEn3/CRk+ZMVoFDxtDRjk6iF+xOP8CnnxXWADXdsQ1JUqe9DjtVsHVJnfNojLnY7E0pRsiKZkWHcZ7t/WkSxh08U7z5+BG1ZQPVSRn0C4V+RiMriwyWHkB/Cfsijqe+I+mfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244215; c=relaxed/simple;
	bh=D66/W10soIqPKNj131yVZpvLwJ4tSmCPOOLbqZPSXJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tZ/5c9A26p++/2AGI/6RVo84dh+OqwoR2nN7apIRlWxYWlQlWZIaDdSOZ/UVv4RCb2E0c5kJls0j9ONveEOzCSIF8Jh3cJWSSJE6cftosDGuU5rVKX1HYTNcZTjZv9PsvWzO8SVxpOhwgGLiClxdROOIGa/PpeLsm4zyKdEbOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mx6LOvji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tMtZMZ0t; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mx6LOvji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tMtZMZ0t"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C00751380196;
	Wed, 14 May 2025 13:36:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 14 May 2025 13:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747244211; x=1747330611; bh=l1pWszyoq4
	9ADQp9lIncwL+cCf0VzgL1PcnN5I+5tWk=; b=mx6LOvjiHsfEmXQjWZaq/3Zsfk
	3Hy+v5vdG1f4qyPCIuLn5PkB6x3yVKNILzPX3CNjlBVcOXcVtYhdaMKySrzcN9eV
	8qC7phHmH8FJm7QRNm97FO+VGvwOFyet5oeUTASy5ebVSW3zjdhXe2pcNGgXbcua
	uqIFrRCzjtn15lLG5/0f/UVu0Ftu8gFAuIgAvng5DzGx9qb+6PWG+WrSnzGwabXw
	ZJuU1WxCOSRz28SPgpSFDoSSBu7GeiKPx5EP+lV6Ps8MzqEq0GV0ge4Ll0Is1im1
	ptBebH/HQ+QE5bOKZ/Eo5gYwTwRXWWZTdiMpKKUy77XoHsNx+8EF2DQ8qLcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747244211; x=1747330611; bh=l1pWszyoq49ADQp9lIncwL+cCf0VzgL1Pcn
	N5I+5tWk=; b=tMtZMZ0t2pDUpO9qfP2g5DL0BYGzoLZwxuIDKA9frhUohnhFmzt
	TRHEf8i9JSazmLt/0EGtk8T0/SiSPLrxvUX7bDzsp3/fOO5Qw0Cib5FOPhXg82EB
	2Xt/q1GoFJT17j57ykG5K+iEkqIoeCzR1mOxoaazBBsTFJYPaSaFof1EjItRBosj
	hT/uJzLwyy7/UyxzjWvbPau7DvNQdY51KvQaSPsSsByTh2Ej3JYhmO/z40AfGzlD
	lZ6ipkei2GzPNQzWf8eWBJuB9sT1GZ2RSlG+rsk5hRk8vYa7vHNGUIcm00k2oyvA
	W2LESH8XNaNKXsZqQUwdoDSt1o51jswMXzQ==
X-ME-Sender: <xms:s9QkaAy241cpJlaIbiK7FOX3bYicImqmIMqKJz3IyuEMrlt4ZhTCpA>
    <xme:s9QkaERniYR95y9kWucdKJvt5NGoAiUkdWLcNmUMd7TTNP0tNRq4wIOCemWU3SSg4
    9t0IB3mrnCuo60yrw>
X-ME-Received: <xmr:s9QkaCVoWANaNqagF3jRYQ_jXBMF-dcICD6Dm61wrj7-2k82VvAtk0uJQqpAxGVT88ow5oac59UK4grxxplHbQUCV3kCpzEliaDWVfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:s9QkaOgBNTdnulTWlnElt3sTM4gTIyIrM5GgAlr5Wh1JNQ-Fi2kIAQ>
    <xmx:s9QkaCAEbE9A5Y0OB3PBRHWrGTaN7vqfB0vICCmJ2-hAOXmTefs-3g>
    <xmx:s9QkaPIdGesxMRrEEokvwRk7nNXI5qsV6smL3RX3ij38zhSBUk_Yug>
    <xmx:s9QkaJC9TpQJnWRWG0AO6U0Rfl3P1vHxvyOF1nwIhb2FgEoZL3Aepw>
    <xmx:s9QkaPIvBNll46DLfTUQJiBBU0grmcdtm2VSJ1PhDqpVDTNcBD_A4ixZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 13:36:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  ps@pks.im
Subject: Re: [PATCH 1/3] fetch: use batched reference updates
In-Reply-To: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-1-7c65f46493d4@gmail.com>
	(Karthik Nayak's message of "Wed, 14 May 2025 11:03:47 +0200")
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
	<20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-1-7c65f46493d4@gmail.com>
Date: Wed, 14 May 2025 10:36:49 -0700
Message-ID: <xmqqmsbf9jri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> With this we'll either be using a regular transaction or a batch update
> transaction. This helps cleanup some code which is no longer needed as
> we'll now always have some type of 'ref_transaction' object being
> propagated.

Great.  From the above description, I imagined that the change
involved would be removal of all "update one by one" code paths, and
addition of a new line to set one bit in the transaction object that
says "this is not the usual all-or-none transaction but is a
best-effort batch", but it does not seem to lose as many lines as I
hoped ;-)

But still, conceptually this change should simplify the things quite
a bit.
