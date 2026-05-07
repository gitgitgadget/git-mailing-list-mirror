Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584FB31353C
	for <git@vger.kernel.org>; Thu,  7 May 2026 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182557; cv=none; b=bIL8aZeUQ9AoZxIdyYVsM/256lSfYuvkEiLKSFBfHiyWb1DjjTeZi7/gHkpjL45rBwt8WFkMd8CqCkv38PZuaPi0cTSsHzE4tUDkb3qqL9qW1nWNlcmZ1A1T1AUwddXi6he34huCb4cgYeUYo6f4rtwg+xPNbEmWaLsDQtbbdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182557; c=relaxed/simple;
	bh=2gVEDcx7FzPvE2Ak1OyIADYTqSl7XD30t0NiskR5Sc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9fozm1S0QoUJdfJwVE98jDFa1ai1zX67flkUjkn3AiFanUz3jR0wELrHKq3HbsX7kLX5l9NV9aMOqP4byPHvDYtG8YXzReJeqG1e2oikEY1uXLHKgmD7XcJ0hVFPNk+jf7+FDUTOh86mW9xDBAyqo2JPKvmteaKHPQCkv+lnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dBIWMftB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LEaFu9vD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dBIWMftB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LEaFu9vD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A53E3140002E;
	Thu,  7 May 2026 15:35:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 07 May 2026 15:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778182555;
	 x=1778268955; bh=d9j6OUvygxvmWr/ltxSEHwuKG+yTtu/Wo+VC9O9Ccow=; b=
	dBIWMftBGhqa7X64kLnzrXUCbqaGpe9XM0HnWZdxuCGfzO9FrX0F/jhWJokt8NKl
	2w/az3pFpxdXmTOEjpNcMuaTiprWR06QTdjMhYrk/d+cgHXTX+cagNZK/4Ki6yKM
	bQ9kWJu+2kE6l5gCCHX7fDX7WpNI4MSnyZ6gSIlmOOtYtzV4gmRjEUKZ7Frf4y2c
	jqmEaP68yoN3MYQhsriMVJPVX0hglad+e1p6elnogvkTAamLswEeV+F4nx4WAp3o
	wwLnwRek4MfNfhjEwVVJeaLNoui83sWgKtT9m1c/tDuNUr2+3RoqFOYvq43VAp0v
	Qe+eCc1/HJT6YIHj9Qu12w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778182555; x=
	1778268955; bh=d9j6OUvygxvmWr/ltxSEHwuKG+yTtu/Wo+VC9O9Ccow=; b=L
	EaFu9vD29hNsi9NZcxsi0Ep7hqGJv0nfhwScUaMBYLCLCeJmbB7MuVfEQCKnBjK1
	RcwVDdF9LrVaZLJx64l3QxCDdHz7smGP0omG7+A4DC8AxEEOY5QvZAbimuApUG2j
	tce925F3J/C9dMhGn8CAMoitfMmMIPJn9+Magak1+vUWiFdtBZsSuWMNKzHdiSBu
	xuugd7CUjHkWyTH4gYDEbpsPYXI08YphqEAo/zV1biFG5EIJsgzA+AAoISSHaO7/
	EADsMqLr0YAQD9ZZ4YvAW+f8FeGMQmseFbjntcaxlkF5aizQf8fb5tfroXFGSve3
	D4A3nvJsf1n2eFTILJmlw==
X-ME-Sender: <xms:m-n8aXWY0nWHj8o8_Np9l0G-oTjVhe2fGHCi6rYMME0lMS0p-Si8974>
    <xme:m-n8aYhhfGWVrT6ziA-qPAVbs4aqi7Ddam8rFgmmOWVrqGsYHomFbu8KnPXVfWCz6
    HgeTHAWw5C7dalKIzN7sRWPt-blnb3HU6x3isViG-KDlyRmV1P7ew>
X-ME-Received: <xmr:m-n8ae_-LiUBS4vM7hEqfn5NuFR3OKWqOoTvmruuAeFf-_U2w_IbcvsIX4z14Pz3P297mDWaLkRGEQcmtPjZ-qpLjFpSUgh0zOcneP4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdekfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhn
    vghlmhdrohhrghdruhhkpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvg
    hsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:m-n8aSaH0kul20Udi8mFpyBYjQvfCpMRWNCZuqWrVc2eYKVBOoeZcA>
    <xmx:m-n8ad0J20GhR7AtifyGh7Hzlb0XVgFSmRVUlpbMLReskkLLB9JKcQ>
    <xmx:m-n8adYwyXbRH-siIy971iwY40TTCBxSq2cel1OQ1JQjdChTQNKq5g>
    <xmx:m-n8aVLeR1UVtLKlfaPSWae1nrA0Jl2L_DkrmIy72f74D_41HiR40A>
    <xmx:m-n8acEXJ2-1k9h6ueBTq4GhM7VEGKBwd5Ny5F0fLS1dg1cNJrGrYH43>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 15:35:54 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 4/5] name-rev: make dedicated --annotate-stdin --name-only test
Date: Thu,  7 May 2026 21:34:23 +0200
Message-ID: <V4_name-rev_dedicated_test.6ae@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V4_CV_format-rev.6aa@msgid.xyz>
References: <V3_CV_format-rev.66a@msgid.xyz> <V4_CV_format-rev.6aa@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The previous commit split the `--name-only` handling:

1. `--annotate-stdin`: uses the new `struct command`
2. The rest: uses `struct name_ref_data`

But there is no dedicated test for the option combination in (1). That
means that the following tests will fail if you neglect to set
`command.u.name_only` properly:

    name-rev --annotate-stdin works with commitGraph
    name-rev --annotate-stdin works with non-monotonic timestamps

even though it has nothing to do with what these tests are supposed
to test.

Let’s add another regression test now that it is relevant.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t6120-describe.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 2c70cc561ad..62789f76381 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -298,6 +298,20 @@ test_expect_success 'name-rev --annotate-stdin' '
 	test_cmp expect actual
 '
 
+test_expect_success 'name-rev --annotate-stdin --name-only' '
+	>expect.unsorted &&
+	for rev in $(git rev-list --all)
+	do
+		name=$(git name-rev --name-only $rev) &&
+		echo "$name" >>expect.unsorted || return 1
+	done &&
+	sort <expect.unsorted >expect &&
+	git name-rev --annotate-stdin --name-only \
+		<list >actual.unsorted &&
+	sort <actual.unsorted >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'name-rev --stdin deprecated' '
 	git rev-list --all >list &&
 	if ! test_have_prereq WITH_BREAKING_CHANGES
-- 
2.54.0.13.g9c7419e39f8

