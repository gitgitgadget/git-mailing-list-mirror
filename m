Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0538A1FAC34
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068858; cv=none; b=btcioU2JrE6ALqtm/f8lV7VTNkaGUVo/cvZ5PB3Pbqo43+tITFUn3X3pk7i9XLPW6nCyMnWj8hrduinjcuPqSo9uHQUJ0MVzMtPxEtbEQfG53W+8xfgQ08x4/vGbSaMfc8ORf/TdMIaLNVMFgau+AvPG1+4CxroKYg2MEjN3+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068858; c=relaxed/simple;
	bh=aUu9aVc8hYTBl5jAqGAEVdr9SV9IepseP4W4bxxlQ2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cxuGb2uB4NQPr0RNn5+PQq9TT13M9hOvzllIG0CT8JeKLqrzXhICvOVnc0hD8RJWMHGnj6U60kusamNYd/NmfCkGCgTdWb3W0NdNungFU+Zzd7B+1474kmFzgSB+0fVDSAn5PF/0rfqND1ZYMQZqivr/JwD9WekYfsqdLiGnkL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LYsQV3k+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KEJanGME; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LYsQV3k+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KEJanGME"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DCC9611400BB;
	Fri,  4 Oct 2024 15:07:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 04 Oct 2024 15:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728068854; x=1728155254; bh=aUu9aVc8hY
	TBl5jAqGAEVdr9SV9IepseP4W4bxxlQ2c=; b=LYsQV3k+DfHg56tLhagbHL5tUn
	w6CIsncLeU7MeGNtwHuUsT6j7yMeQfmoXolAuDA7kQ1ozo0pnEV33o2FMkDNJeFa
	mioqpI3D6tcYbGFLoHou1ufbAIC6nxlczQzwl4q4uAPVV3RpfwRVBFRpdlAeB+fJ
	3HjzagM2SnvmdhL+a8zP9cr6dqs46fO3m3uSq1VkXNzC+fvP+LMGzxZT1v9ufL8Z
	UnY2iWyScchqhRRLyamWXSK2jzhZdZplI57ghPt/t8/ZnoCUGkbvqr50qBI7IEHb
	jnWbGSeN374bL9ohAIC9NHczU/Rf7k4JTKPzMhzuZhFymbqc0FlN49wS95Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728068854; x=1728155254; bh=aUu9aVc8hYTBl5jAqGAEVdr9SV9I
	epseP4W4bxxlQ2c=; b=KEJanGMEpwY7nvrRtQLianuyBZ440OdOS+bxhHCOfsd2
	LfT8GiLMbyXQbsvkxAyU8nLK/EJIBaJUNaKgbciEsaQ5+Eel2c2LUwyQ4MGQBXO9
	XBuKVctklybuETLK5/czdNCpbHw1B/AqiBuStY6gtOMuN+lCCxBlYDQHoC0Vb5Wy
	wntztbyWn2ROqnpWaND4NN6/01IYNjcMI4qANLDaqT9jmJOXCobXTq+p7EKfYYLo
	uu6ctniqTanGpFMpokSzCZElBUc2ayI0B9B1JqipVdcw1A7aumLy2qd8HHhtwn7b
	GDX3Z05QvScDFAQjcHZZ8I0s+f68EbG+jySCPEGOCw==
X-ME-Sender: <xms:9jwAZzL2xCz0YDSUSGqrPQQa966NbcjgH7bX5LLLFRUiP4X4pDiqag>
    <xme:9jwAZ3LbG58SCF1SGTHmx0mkjsEkhR72Nx5UrUmnlsT1Z84t9r7S_0EgHM95BHODx
    h1vUlvuuOEeeH1VNw>
X-ME-Received: <xmr:9jwAZ7szfebH6cfETrg_zdssVH4484kDTfPJkHtMQci-03qhr7OrEy3cCzx-w0CFRI32Lr4pW4dxzHTybesHi_bJ6R2IHD9a9AsO_z0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrh
    grmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdrnhgv
    thdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9jwAZ8Z0EL9xnT6GN31dvcWzp-pof6PxnZ8inCpC3RgKSemeT7rTUw>
    <xmx:9jwAZ6Zgt7mptYHP9Fu88LnEc5-e6xhwwzMMfzsLrdZYbP2bFNqc4Q>
    <xmx:9jwAZwDn12FSjbyn-skVcEyFilyHBiyGxOUwFfruxjcNhm1PzH90uA>
    <xmx:9jwAZ4bsFAmNUgcyK5m1ZfpJcMTTJ23BCplRiyJyskBz6PILhZILsA>
    <xmx:9jwAZxyr7sXVsrcZeaZlVE0YGGVhb84uJb0eEj-FeMZDmr5iMfETxEZ9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 15:07:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH v4] fsmonitor OSX: fix hangs for submodules
In-Reply-To: <d350d598-fc99-4384-b2d5-5cc898a17c12@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 4 Oct 2024 19:47:56 +0100")
References: <pull.1802.v3.git.1727810964571.gitgitgadget@gmail.com>
	<pull.1802.v4.git.1728000433326.gitgitgadget@gmail.com>
	<xmqqiku7epa7.fsf@gitster.g>
	<d350d598-fc99-4384-b2d5-5cc898a17c12@ramsayjones.plus.com>
Date: Fri, 04 Oct 2024 12:07:32 -0700
Message-ID: <xmqqa5fjelfv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> While this won't hurt, this test file is skipped on cygwin:
>
> [23:19:33] t7527-builtin-fsmonitor.sh ......................... skipped: fsmonitor--daemon is not supported on this platform
>
> (my eternal TODO list has an 'fsmonitor on cygwin?' item ...)

Thanks, then let's not bother.


