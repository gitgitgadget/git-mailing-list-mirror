Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB9283FDD
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774110442; cv=none; b=BQ1tYR7yxUqynJbWKlWWm1W+yS5gBHl3Dv2cXaR2coGB6Vxv4QDz370yNBcwWBj8t2esKBojBuUTueVz55FJANr+SPUp+n6TMzhxEuWi+ln5UjgTaBm3Ee3Wrc1/i/wuqIeJG9uDnJsjGHlnkab1GcOZLhmUZiwFqJxKaw0+wmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774110442; c=relaxed/simple;
	bh=1YUgIwpZ5J8jLLKQBomo9Uk2KXSLSc2pOlZxuGcsrKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pj12T07Dimp2I44cv+y4IntZfnLWRlWkQGEvaCvlvCyRaI4Mn7xrUQgdot88CiToPgx9Orz+VyYZv+KpnPQCT4GTKzrZIwqOYBQIYt4p0Qk/GRFRjIbYr327wSndP3koH5/80D9gu0u+/S+uOCwN6sl3hOqMSPUMfAXCmQjOdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W+1yao2p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KSKBZGy1; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W+1yao2p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KSKBZGy1"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id BBCD31D000E8;
	Sat, 21 Mar 2026 12:27:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sat, 21 Mar 2026 12:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774110440; x=1774196840; bh=7O7JjVRyXo
	AG/ETsWbIkv822u3P+U1lik8r7m8aQ6II=; b=W+1yao2pZPUYVh3idVo/HmyVI0
	nRTl0soUIWMed7LrHWs5TVOr2xnnPU7r7+V4psMcmYDOL656bIzHndVoAGx8Tjvw
	nC3N2T0yNQ7G4KB0aK1oq46ZCuEvKlQLPmKUNdRwZrSp5LwH+zdO5BQe3IO6iD6S
	KPLZH3G5h7E3mAdb62yIvCS8x9inoANJrhqmUv7QAapNLJIkerdvMgwPzv1ewWOC
	Psa7Jt+tX+1qhTDFRu9X+Iq4Q0sVcct8bHdN9XONBIZE6cXpvWE8jbpFIZkEBqyS
	gHeZwX2GCd3NxtxFnDy9mpMUc1Euv4BAMpuVthz+eyyMtl21HA6ik7Qzn9PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774110440; x=1774196840; bh=7O7JjVRyXoAG/ETsWbIkv822u3P+U1lik8r
	7m8aQ6II=; b=KSKBZGy1bCkDZ7jcVTbYL3cv792js9AyehRJ6+Ym8/Or1/o9V9/
	+lAojimy+mLSZMai5yKlvpOBi8sOBcGuW1wUx4BBvEn/ODvEyqgNUTX139k0l2Jq
	Wk1+vF13Kw1ki+ZKsMOnITAzMaXJN7hZ5fTY+7G2g65nZX0KNZR1vXfCfuzJZ0aH
	nV6JxnsFseuV4f2d2++4EbkmKnLaCctveYYDXn3fCXthirisgF9dsk04DfK7F8MG
	dZ6UQtXqRlxF1CwCI1qUFEZ9csvD2mR1JjPHHJGrvohmVJeBQfOrZV2g9QxDtVaN
	wJ9AdMtNIEVKFGE3RaQJX26dkIX0D1H3SIQ==
X-ME-Sender: <xms:6Ma-aRvekhut6zKygnOQ-p-FJsuFExNOHdfZQ_2VhDB6SShAM4LQlg>
    <xme:6Ma-aR7Lyo3Q3aXKsQ9TcDPFMg6zfe3dfw8j3CqN9pZu8DSmXn2i9evhNm4PyEj81
    ny8mOG24FDqycipcf_n-qgfERZW-Qog9v543wTTZRymq02mMFIkpw>
X-ME-Received: <xmr:6Ma-aSJ4-wnaoX8uv_2qTVnQvzESwhqIIk4pARFSr2emfZs5lO_V03p_zAabGlSnNm6ivJCiR03lAlUfi0NQdFcx1E2cEbif_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffie
    ejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:6Ma-aR42I1KG5byKyxq_dtSZ5fKSjlBk4ZWXpUMY10kCKJIoiPsTLQ>
    <xmx:6Ma-aVx6pu1vSOSakHsg05kFJZYqmIfNIe777CbHbqs4eSyfsIqZsA>
    <xmx:6Ma-aVZCMmEYAMyaQ-OBKnzJfWCWJy2Fyxv6XYG7VwqcI42vrmQdyw>
    <xmx:6Ma-aXSMGrOkQgBqMB-VoG_4p9yaSXGlY0zB9f6LzzGTR-7SZuGHdQ>
    <xmx:6Ma-aekgVURNW224SB1RSe1Tmd6fJxQ0hLqjTroaA0Px6hl8chBt4Z1->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 12:27:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] gitk: *.po no-location and package name, link and
 ref colors
In-Reply-To: <5a6b375f-734d-4935-825a-afa41abc3ea0@kdbg.org> (Johannes Sixt's
	message of "Sat, 21 Mar 2026 12:51:06 +0100")
References: <5a6b375f-734d-4935-825a-afa41abc3ea0@kdbg.org>
X-Gnus-Delayed: Sat, 21 Mar 2026 11:26:42 -0700
Date: Sat, 21 Mar 2026 09:27:19 -0700
Message-ID: <xmqqbjghb120.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit ddae547e3775638c238c11f30120f1e7e763fba8:
>
>   Merge branch 'pks-meson-fix-missing-msgfmt' of https://github.com/pks-gitlab/gitk (2026-02-05 13:45:51 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/gitk.git master
>
> for you to fetch changes up to c8c5df79df34b40119c4bf8e3079520762f258d1:
>
>   Merge branch 'jx/i18n-fix' of github.com:jiangxin/gitk (2026-03-20 09:23:32 +0100)
>
> ----------------------------------------------------------------
> Jiang Xin (3):
>       gitk: i18n: use "Gitk" as package name in POT file
>       gitk: ignore generated POT file
>       gitk: l10n: make PO headers identify the Gitk project
>
> Johannes Sixt (4):
>       gitk: commit translation files without file information
>       Merge branch 'sb/heed-ref-decoration-settings'
>       Merge branch 'js/i18n-no-location'
>       Merge branch 'jx/i18n-fix' of github.com:jiangxin/gitk
>
> Shannon Barber (1):
>       gitk: use config settings for head/tag colors
>
> Wang Zichong (1):
>       gitk: support link color in the Preferences dialog
>
>  .gitignore        |   1 +
>  Makefile          |   7 +-
>  gitk              |  21 ++-
>  po/.gitattributes |   1 +
>  po/bg.po          |   2 +-
>  po/ca.po          | 312 +-----------------------------------------
>  po/de.po          | 318 +------------------------------------------
>  po/es.po          | 312 +-----------------------------------------
>  po/fr.po          | 341 +++-------------------------------------------
>  po/hu.po          | 312 +-----------------------------------------
>  po/it.po          | 312 +-----------------------------------------
>  po/ja.po          | 327 ++------------------------------------------
>  po/pt_br.po       | 312 +-----------------------------------------
>  po/pt_pt.po       | 316 +------------------------------------------
>  po/ru.po          | 397 ++++++++----------------------------------------------
>  po/sv.po          | 328 +-------------------------------------------
>  po/ta.po          | 391 ++++-------------------------------------------------
>  po/vi.po          | 312 +-----------------------------------------
>  po/zh_cn.po       | 374 ++++++--------------------------------------------
>  19 files changed, 187 insertions(+), 4509 deletions(-)
>  create mode 100644 po/.gitattributes

Thanks, pulled and the merge summary I saw matches the above.

