Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FEF3BB40
	for <git@vger.kernel.org>; Thu, 21 May 2026 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779340370; cv=none; b=gpmalXABABEcjUavHuSSF5B5d6f0r1J1LO698uCORISmm6rReFlJp2oX35PY51fWAYe6lij9/X75nVKy9W4MI7zT2r4ZaIWqJtG1PTqsWlzyxcqPVwQz/xR1E12rVWEW6pMco0IWIM3HlYyoa8KBMOexieY1PZpObp9pwL5ib2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779340370; c=relaxed/simple;
	bh=sTpCGHSMUdrvFusvXYyMnRb2mDEhH6EnrhTi6EIigT8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GomeJK7eUggiRugqgNyisi4zobOHEjgB5LpfYROAQjZwy2RShbRv8dOP3Z+ztubwe4eKmrSMzxCplBCsCkTGEUUN2EsCyOrGaA6y2erffIHGt7FAHFW9hBjGnBGvsss9eKjwtr9avkiNZoVrrh1KCjdqDWriyqZt5YqWdhdb6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VSu/Tyvi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ht+FCl7I; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VSu/Tyvi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ht+FCl7I"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9363BEC00D1;
	Thu, 21 May 2026 01:12:47 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 01:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779340367;
	 x=1779426767; bh=kdseD71tDw1c5VZWDyUhEZn/2Bc0e996YBfMfBV78ko=; b=
	VSu/TyviNS4QtJ1PC/Qd6OEw4uEgv/fMMFB1H5FXMXcn2g3LoMzOw/VrWlLtjE8x
	MLrbVmuoiq5U/TAD5jjtcJcxngvBMPDL86tM42sLyi7mUhWJP1YslRhmXQB+PjBs
	MTOFfq5+WruxoU5l2pWMekgO8wq/MU8Adjf+7Con9txzynDcSrlrg9bLYMKY9GrE
	lOEgROaw367XSdh9QcmB/gb/mfyhWF1JpTqy6rvOs3xB1CW+9tO3Ml8Mt4a3ejqo
	6Mcgzh5GSdbwkSNkuPiQlbImyxiunDKVQ5t3cDmLtSr5JHBD/pMwMWUNdc3zmso+
	btxKAKFor79G1n3VfV2e/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779340367; x=
	1779426767; bh=kdseD71tDw1c5VZWDyUhEZn/2Bc0e996YBfMfBV78ko=; b=H
	t+FCl7Im5OVVRoHYUpshh9YFwgiteelhH9ICILyhvI5R//0JetQt9mazfQBt3F/o
	4q9DxFBR5YMQ1JA4o+RT0ea3zE5ZYwJm1ldU5VFKUJE6SZClwlV7qfePxpNmo0qc
	hb6IO4h5T9puZn/bkheayfwKmoCCu583AnrjccgxJ9+NUvBYMdqXygcyMiz3HIgb
	YZFsRDVgxEsLE+1LLBC5TCxq5hNlMQZni20wqgz1PGio4K3zvspvNHVwWNcAa/JV
	VRz3lv2zxOTdo6kLB5Nz4gfZKISo7/jR2O0UgguCR8HXIBtUxLUH+zd7tvzXaxrA
	OISjy3FSUXn98sGgkesWw==
X-ME-Sender: <xms:T5QOajGPrTtztcSAQEoe5WiE3PTLSO5tQsdWAhy79w8pYc4GOPxYAQ0>
    <xme:T5QOarLRRrIjtu9dweQR9-cTNzjc-XN8hzJMhUeyo0UsU3-_aKuAhL1gIiNJ8SBdz
    TghU-JnJZrqFnc6uk_M0UYG6gMfl2-fWLXEwsew-5jbUeSpCU5HZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeiieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsihguughhrdhrrghmrghnrdhprghnthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:T5QOauqhZdXQOEThSgBpgYn85TpF4O097AWjEe-dlb3hup8BGrVdVg>
    <xmx:T5QOauJWF-EgLNna4Mb-ci0YX2Ujs6bmORi8wkg_KDcytHmGOHY7Iw>
    <xmx:T5QOajTHbBjuGhVL_iCk7kbypJeWY8U8ibM3XL-u6c0K2gj6iR6U7A>
    <xmx:T5QOatviNeG0WGzzbaxcVsYy0O1Qg5CBYwNVFX_i_ePtkaYq-rg81w>
    <xmx:T5QOakgM5nPX5_w3pOuxrJp_b3mJbAJf8iGpgkH5V8Cf5TPNFUzv8vGM>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 55CC23020073; Thu, 21 May 2026 01:12:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AmEhG8rwk0hg
Date: Thu, 21 May 2026 07:12:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Siddh Raman Pant" <siddh.raman.pant@oracle.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>,
 "Elijah Newren" <newren@gmail.com>
Message-Id: <72839071-153f-4306-a705-3be0dc203109@app.fastmail.com>
In-Reply-To: <20260521041908.41055-1-siddh.raman.pant@oracle.com>
References: <20260521041908.41055-1-siddh.raman.pant@oracle.com>
Subject: Re: [PATCH] Documentation/git-range-diff: add missing notes options in
 synopsis
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026, at 06:19, Siddh Raman Pant wrote:
> git-range-diff supports note options which are also mentioned later in
> the help, but they are missing from synopis. Let's fix that.

s/synopis/synopsis/ or s/synopis/the synopsis/

>
> Fixes: bd3619188682 ("range-diff: pass through --notes to `git log`")

This project doesn=E2=80=99t use `Fixes` trailers. Mentions of commits g=
o in the
commit message body (outside the trailers) using `git log -1
--format-reference <cmt>`.

The Linux project has uses for this structured information since there
is a lot of backporting of bugfixes. But I haven=E2=80=99t heard of a ne=
ed for
that in this project.

> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> ---
>  Documentation/git-range-diff.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Okay, there is no need to update the synopsis in the source code since
git-range-diff(1) is excluded from `t/t0450-txt-doc-vs-help.sh`. So this
looks correct.

>
> diff --git a/Documentation/git-range-diff.adoc
>[snip]
