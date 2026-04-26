Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B95A28F5
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777161722; cv=none; b=if0YaUiQN0mwj3WTEi9oNCDv0y3GLtdz4xyIBe4qsX8wo4yaeBWcmtYxOdIP73uU6QHezSHKztLCKydlsCTxiWH925a5i8+WqVkXrB3n51EVEZw2/OeBvhLQDoGY4nbjn277+5P/umO1KqOPutTRxzcy7GDgT1tEKNzP8HbZZK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777161722; c=relaxed/simple;
	bh=PdouWiJqg9HW1z0JBWYc8FjdLtQTNNY7lcgkb9G+7/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqNmMM3SOt5pz7pGgL5dKaotdi5LKNJVKPZbIxxQwemBKdVnnDbCqyvYAF1LzfthFb2RVAWT8LoVQZhtj28bUS7H1Eg5Qla3t+cqrMq1RqTerW0qB7tTfMkbDU56udBc95/alLqBZPMhgruSLamqK8p3n9CJXJGb/GXYsfbvoFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l6vFV07V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mMNRmXdo; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l6vFV07V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mMNRmXdo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 768467A002D;
	Sat, 25 Apr 2026 20:01:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 25 Apr 2026 20:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777161719; x=1777248119; bh=MOsQPY1F4g
	Kxv0Wt/sw6O+HPd4y8kzZXFUn8/YiZ3ik=; b=l6vFV07V8/ijewja6uYkaarm8m
	LWRgpJox6BqbN4YMyiyQf/i03Vijbo8zq06T7ywBOqrmYpc/XVzlJCc7B6usnCrK
	2HMBg2l6qRggN63FXGU0Okka0p2M4f0uIHZBWoeRASua33crb9vK4M/5TA7x96hr
	fMwokl1eh/WZo2w6oi41iRo1YpctFdRpZUFerStsdA7v4w4GQYYqgzXbmmumAgBY
	FT9N80yhXULJrU+xY4JD7iJeYwzgIonyIhnMeo8Jt4F3DY2GfPvG2RraCjt6kmsU
	sm+9KKU4qIeMC987IWxCNEBOuHjY2HFlRuKo8BnLya6eBkJohTCep3BFFkBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777161719; x=1777248119; bh=MOsQPY1F4gKxv0Wt/sw6O+HPd4y8kzZXFUn
	8/YiZ3ik=; b=mMNRmXdoYGVGNfL/5x7AjAdeRyBK6tThivZn1xeFVuIveOMg2nV
	8L8GcOKgSRYqQAoR+31G1J23zq/aoMYavEV4VA/qmf6RSO3XESnFGS2vMDspvr9B
	vE1E5/YUgKiSZmRphQtPDQKcxXRU5/7cKnhjvcQZZB/PmOldNjg+IVrIP7WzSwrr
	m5afoy8DgSKfB3hjsI1Ju2n5MWTJi4Ps1CfozvuB2GPRP81eoy2e9JMvel1mQHXC
	LFab8nX04dnz2WM4IuBwNVoANHDhutEUlPv1AfWUr7S3F7RWVoxu+Sbod0i9qrQf
	CP2vukkZHExDxdxRXWngP0W2HkGMX98gopw==
X-ME-Sender: <xms:91XtaUU7VZbANwW7IQbe7oxsQtK8J6t0-cD6oHZvpbD_AQIJs9cS-g>
    <xme:91XtaXo1j51GeuDtnuBfn1tFlOVt7dT5BcKaJUB0J9IY71Yyu1-AkWEBTP3JskkOG
    MX1RZJmC5UClxbD6SD6j3pF6kdCUBYyyGdEYYbqvXViNMtljdAo_g>
X-ME-Received: <xmr:91XtaekeCmyHLwbykXj9KpKl6JvN61yNUsPJzUnJe4IS3csKUVb12Y89yrs5RkpiporGfa21b5B3aGkF_bKJ4ozpQpgGbVZarA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejgeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvlhhkihgu
    leeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhgrrghrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:91Xtaf2cyRk5whIKRa0pt3yjE_tcvdlYy8drBUeJn0mZwbLDninafQ>
    <xmx:91XtaTS0XWVtMoeqUgtIqWCl7FDQ5yxxfGi90FvW0vbKjD83cJlHAQ>
    <xmx:91XtaQxwdHE3-FdL24XWiy6pBo6u6K-p-RfIIM3lZhrfBHHEZvABTA>
    <xmx:91XtabDNESElMJkEVOKmdVpY_ODd5FS9gsPSH3RZ-NZ4Ik6BxDHhUg>
    <xmx:91Xtackm2AF-YMnGPW-9vvx8jACk5NAuZGyzike2Mrz1rNzVqfKeVgbO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Apr 2026 20:01:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v3 0/8] environment: move core config globals into
 repo_config_values
In-Reply-To: <20260423165432.143598-1-belkid98@gmail.com> (Olamide Caleb
	Bello's message of "Thu, 23 Apr 2026 17:54:24 +0100")
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
	<20260423165432.143598-1-belkid98@gmail.com>
Date: Sun, 26 Apr 2026 09:01:57 +0900
Message-ID: <xmqqqzo27fnu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> Olamide Caleb Bello (8):
>   environment: move "trust_ctime" into `struct repo_config_values`
>   environment: move "check_stat" into `struct repo_config_values`
>   environment: move `zlib_compression_level` into `struct
>     repo_config_values`
>   environment: move "pack_compression_level" into `struct
>     repo_config_values`
>   environment: move "precomposed_unicode" into `struct
>     repo_config_values`
>   env: move "core_sparse_checkout_cone" into `struct repo_config_values`
>   env: move "sparse_expect_files_outside_of_patterns" into
>     `repo_config_values`
>   env: move "warn_on_object_refname_ambiguity" into `struct
>     repo_config_values`

Are there differences between the ones that start with "environment:"
vs the ones with "env:"?

>
>  builtin/cat-file.c        |  7 ++++---
>  builtin/fast-import.c     |  8 +++++---
>  builtin/index-pack.c      |  3 ++-
>  builtin/mv.c              |  2 +-
>  builtin/pack-objects.c    | 24 +++++++++++++----------
>  builtin/sparse-checkout.c | 37 +++++++++++++++++++++---------------
>  compat/precompose_utf8.c  | 20 +++++++++++++-------
>  diff.c                    |  3 ++-
>  dir.c                     |  3 ++-
>  entry.c                   |  3 ++-
>  environment.c             | 40 +++++++++++++++++++++------------------
>  environment.h             | 19 ++++++++++---------
>  http-push.c               |  3 ++-
>  object-file.c             |  6 ++++--
>  object-name.c             |  3 ++-
>  revision.c                |  7 ++++---
>  sparse-index.c            |  4 ++--
>  statinfo.c                | 12 +++++++-----
>  submodule.c               |  7 ++++---
>  upload-pack.c             |  3 ++-
>  20 files changed, 126 insertions(+), 88 deletions(-)
