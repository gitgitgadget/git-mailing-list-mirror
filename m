Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA282DCF4E
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597137; cv=none; b=sWoPOb7y4f/4NAuBR12PbNDYqM4g2zLFgnbx2+0t4NIw4VDSFJaZX/ck7IsOmPxgJLkGotY+4Iu1kmxWgvu8Eh1wNIWA37ZEHedSXNRsmZe+h5SbP+3j2QDdf5NnEYNmEEn6sgS9e8ODaY3AMae8t9+ISKLsfHytGYiAaEQFupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597137; c=relaxed/simple;
	bh=XV9bBVKtbv1KO4w0v8HJ6cHrC4kvPiG/6bJ/vme1yAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VXZL+TdkHZPRwrCuvVu7uDnTwBuIdzx3GQsMUJEJ1gIUySpGgzwtHWytOy8TEXls/Na3HWHqSGRn9bAlbsdmkfRiaeh2NO/4fMRFnRNsD0kxAqzZBSCg1S/7HX2GtVEX9xodmxtNJ+qOsjAfIq4JIHSEs9cTAtT79wDjrHL5Xz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XFMqAint; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qoyqbK7n; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XFMqAint";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qoyqbK7n"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD26C1400209;
	Mon, 27 Oct 2025 16:32:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 16:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761597133; x=1761683533; bh=a/bVj3JM6G
	2kcr9HM/DPfGIaia9qyQ4uZsA4HcOY/oQ=; b=XFMqAint+Lc0GvFyHus7s7P+Z0
	j4pIcRyusQs3qSvA2KDMM5WrkVn86nlolYly0IdVc6PLwWAhBFMlsp28Jk95LBMJ
	0spFZhCuPccQtM9GNao8cNvFPWZ8pu6Kl5DnuFahXTQZPHd81MdKszM+JcNTS4x7
	6rqnSDBa8OqbQSxeArn7PEe2Pf3lOCE5DEvubun7feRLbDt+WFS3GygbQpCM819m
	1ZHVFONkuuNsBNQb53lfNNCU35/+XN+OikJLlii9+3TNzMXZoLjEibDJwTmKtQ9U
	oRBz7RpaSpGsalFyJ+povN61N1HKztadOMA1HwQymYOwDn+j/8frkyhGfPyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761597133; x=1761683533; bh=a/bVj3JM6G2kcr9HM/DPfGIaia9qyQ4uZsA
	4HcOY/oQ=; b=qoyqbK7nl8dQiYU4OqAQa/We8SAZf4WR0zVezd09XfU4gMcae8g
	glCdIQ+ZhxgMuFP/if500CjIg4o0+6kewc6+XOqR+9ezDpsqtH0tJc9cNI5xF1IS
	AHOfWMfBOaCG/eAUE3kQIFaBs6cQKHHfjwzeX+8sqOkPgOnDXEl2cxaZGoYQ2lgb
	tfTaK7AYg1/QbKTWAm+wNufUlJvWHh0YhjLvC0/lk0IDFsSl9e4gLHVpZ+1DImFD
	Ts8lSOplP5uQtxFtsXNEaJYoxg7oXChzpimpGK7nIti4tD8GPGup1vfTzL8dTxq2
	hcvDf3cuxTL0b/KmzEzU4iEhmO1uicQYK3A==
X-ME-Sender: <xms:zdb_aPPg8EyPJTaf4yj8R4QgQ3P0F3CXw5JBCprMlPkW9IM15J6DoQ>
    <xme:zdb_aNpaHz7Bo28o1sF-j-61s8TL8eWnp-KtZAvTyiliA_QL9MqA1KA5oSzh3KmA1
    u_R20PLNcLqZlwRw_6v9NbXVkTXmzVQIpRErsNwCwJzPwVsz0I>
X-ME-Received: <xmr:zdb_aIHltLRb6b_JE09_JBPzhysUPZTK4aXPnp4XI9d77qOlQy8rDWDNsap9Jpl297Q2PkAMXOvH4qwwg5MJGYz47x2Z8J8CPLjB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtghomh
    dprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfihhvvgdvfedutddtfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zdb_aKoNEcwXCfdBb5o2xf_lNxPd1Bto_VQVwAJVyHOfkyWW_DuaKg>
    <xmx:zdb_aJZct6A4OpJjq_LFbnWnxgNpHLswY97hzLJ8fyndCJnJ92SxAw>
    <xmx:zdb_aLVOuSiyBm86gaMw37qWWmH-xmNW-iyUvmfjK-5VGQhQBNyWzg>
    <xmx:zdb_aK-XgWaHNHU4TJ88YdwJTMtnD_rOoh7kTOiawjaZ2N5_NFHxTA>
    <xmx:zdb_aCZXYwXpZFK8Vib90OH9OpFYyeE2YLuuUR27AxJlxB2JPIBfY7pZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 16:32:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Todd Zullinger <tmz@pobox.com>,  git@vger.kernel.org,  Kousik
 Sanagavarapu <five231003@gmail.com>,  brian m. carlson
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/2] t/lib-gpg: ensure GNUPGHOME is created as needed
In-Reply-To: <87o6ps16pj.fsf@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Mon, 27 Oct 2025 14:32:24 -0500")
References: <20240703153738.916469-1-tmz@pobox.com>
	<ZoV8b2RvYxLOotSJ@teonanacatl.net> <Z8HVkqqD054QGPIE@teonanacatl.net>
	<xmqqbjlump3m.fsf@gitster.g>
	<87zf9c8glu.fsf@email.froward.int.ebiederm.org>
	<xmqqqzuoi6sg.fsf@gitster.g>
	<875xc02mmq.fsf@email.froward.int.ebiederm.org>
	<87o6ps16pj.fsf@email.froward.int.ebiederm.org>
Date: Mon, 27 Oct 2025 13:32:11 -0700
Message-ID: <xmqqms5chyr8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> So far in the two should be identical sha1 and sha256 repositories
> I can confirm the failure is because the repositories are out of sync.
>
> The sha256 gpg signatures match
> The sha1 gpg signatures do not match
>
> Which is very weird.  If they both didn't match it would be easy to
> explain.
>
> This is starting to look like this is a case of the test doing it's job
> and finding a problem, rather than a problem in the test infrastructure.
>
> I will keep digging.

Thanks.
