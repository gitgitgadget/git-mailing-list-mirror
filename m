Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72B254B0F
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379059; cv=none; b=gnCyaMLLNpUr5WpFqaHd3Z4i7aISJnDx2HvusKuP/3WdvBZYfCK4SLPN42DnFaRBDsYgZG9/Oj0fls+GTPl3IM9cvDxllDGiKRescdo003QLvpS5EZvSPfj4bL3MKL1cu3fJL+Q3N3148qZkefX3R93v8olyMuEkTsdwIqGWepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379059; c=relaxed/simple;
	bh=LCpfFZKMy2quY0v1LnTawHMtN20Hg3jsqVTkcFJSbXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WIJSug7BRuoyy2J/I990qFmd4qHffXS4CH59ixif+sA1uWc8OIxprYzz2tMbiTxXj8LxWoY0be2ttQhcYcOM5xas1/TqXU+pbsMnME5L7+gYln3eG9ydpxbxlkTr+6p6s/JylundZAkKLgUiZ2/k8qCTvaRhwhSF3sZo0O6Z6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m2QADI6r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K9aXjGhA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m2QADI6r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K9aXjGhA"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 19F5A11401CA;
	Wed, 12 Feb 2025 11:50:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 12 Feb 2025 11:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739379055; x=1739465455; bh=eDO6/d7U2Y
	8vMTh8YB7J3atoGJZUKuUUL/eNdEnbc4U=; b=m2QADI6rLHOa4LL/Xe3C8mvx8u
	NN55vbH+I8LFpxlQXwj9RNuHkumSl46IMj8iXb134c8NxuDH1whw3KK60Da/fdgt
	qi8Vo9ijGJm0LSlk93x8QR9SGB0/cmflWpPsoF+E4I9skcngwxlVNjbQnjd5mcf4
	tfDs+rtETLraFLXJ+424DoZSJGEMGTRb5bxyUkhH8L3sXhuWhGaa95+YT3o/U1Pf
	OFyscfqVsefShsJ8gguTSY6OJ/HAovfXVN08dPm3eQJvX0XDTWkXmo6/kkdAvi7t
	WKEfaht82bVUYTrd5/oBHsCMM1xbIzlR4yhr9+AKLn6K4Rl4L1+XjZ2w2V4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739379055; x=1739465455; bh=eDO6/d7U2Y8vMTh8YB7J3atoGJZUKuUUL/e
	NdEnbc4U=; b=K9aXjGhAMQqu6KSiGOTrDTaGIu4PBXRwLAsred+3nDFslp8QzNH
	bJ56f0shWj3i7uEpbaa8Ym0sd8Fei3bjozDtyL/hNYTKTTcaW/kb7rQgExoiy3t5
	xgx6di/BC/IZo4VDPWPFzltMB5ZMmynLcpZVhccEZQrUyH/qg9jyB2KAZaypcFhY
	tE2VmV6/T21wlQBffZYbWAcwmB46W97QB4l2zwYABOYUv4iNOkZNyp5Ejo1SlLNk
	Mgddvv+n2R+zcCJ+RN8/2jRZtn1262kXv4gOXMWYzVPlFodV0gAl63o4be9hmWnS
	bIyWVh9AX0Gdpqso/nFDvX9mrK03hGuC+YA==
X-ME-Sender: <xms:btGsZzBhHH7GtcF2z62Dwq3WPp29V4IBaIxNNtd37kfTCjh9CI8LjA>
    <xme:btGsZ5idnLEInt2IXwTRtIRJ4JOy9dO07E5MrTM7qGuykiYewTNWt1Z6yKQoOao2L
    Dzl3vorEcIMqbqBeQ>
X-ME-Received: <xmr:btGsZ-kBxmQn8hwI_Jil6fnejImrM-sWTDpgvzqyO29PxEVUlTOgJ12mNkMU_fhZe7-zl_ezexYrmfULdwyyqzuHdkgw-FmUXqSAhfo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:btGsZ1ySteMk9YY6gKESUgCVBK07Sv6cETr6ukeXXeKx0sdvxh5iBA>
    <xmx:btGsZ4S94QbM1B3-q59OGqaRqkW2qaiskmyin8ntiCZzCFtzj8ppcw>
    <xmx:btGsZ4bl-Gzbx1akUStOthMsorYoAkXm_Kq96whLZZd7U6IPz2Yoqg>
    <xmx:btGsZ5SvVUKlX-6CDSZ2-wB36GEsjRJYkTJyegXxS_oQZxjtIw3UMA>
    <xmx:b9GsZ-McbmZQWcg7LnuU0g20RiHrq30nV1lqbdAqq2139VhpcAw2TBcS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 11:50:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
In-Reply-To: <20250212041825.2455031-3-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 11 Feb 2025 22:18:24 -0600")
References: <20241213042312.2890841-1-jltobler@gmail.com>
	<20250212041825.2455031-1-jltobler@gmail.com>
	<20250212041825.2455031-3-jltobler@gmail.com>
Date: Wed, 12 Feb 2025 08:50:52 -0800
Message-ID: <xmqqldubumxf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> +NOTES
> +----
> +
> +`diff-pairs` should handle any input generated by `diff-tree --raw -z`.
> +It may choke or otherwise misbehave on output from `diff-files`, etc.
> +
> +Here's an incomplete list of things that `diff-pairs` could do, but
> +doesn't (mostly in the name of simplicity):
> +
> + - Only `-z` input is accepted, not normal `--raw` input.
> +
> + - Abbreviated sha1s are rejected in the input from `diff-tree`; if you
> +   want to abbreviate the output, you can pass `--abbrev` to
> +   `diff-pairs`.
> +
> + - Pathspecs are not handled by `diff-pairs`; you can limit the diff via
> +   the initial `diff-tree` invocation.

Which of the above limitations are fundamental, and which are merely
due to incomplete implementation that could be improved in the
future iterations?  Without reading the code deeply, a lot of them
look like merely due to this iteration being at a WIP state and not
quite ready for the general public.

What is especially curious is the reason why it is limited to
diff-tree (by the way, don't you require '-r' if you are fed
'diff-tree' output, or are you prepared to expand tree objects in
the input yourself?).

I can guess that the 0{40} object names in the postimage to signal
paths with working tree changes unadded to the index is something
this fundamentally cannot work with, but you should be able to grok
'diff-index --cached', which does not have that issue, just fine.

> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index ead8e48213..e5ee177022 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -41,6 +41,7 @@ manpages = {
>    'git-diagnose.adoc' : 1,
>    'git-diff-files.adoc' : 1,
>    'git-diff-index.adoc' : 1,
> +  'git-diff-pairs.adoc' : 1,
>    'git-difftool.adoc' : 1,
>    'git-diff-tree.adoc' : 1,
>    'git-diff.adoc' : 1,

This apparently does not apply to 'master' and the base at least
needs to contain 1f010d6b (doc: use .adoc extension for AsciiDoc
files, 2025-01-20).  Please clearly mark the series as such in the
cover letter if the series is not built on top of recent 'master'
(or 'maint' if it is a series to fix breakage, but it does not apply
to this series).

Thanks.
