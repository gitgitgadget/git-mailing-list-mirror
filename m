Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC21762EB
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268823; cv=none; b=BFTv68XhEgco00E095MZs8V4HBDCm7Re5yYtZT8aQ0oJFcdZceHOSW4R0JtjgC5Z3pHhosve/XZLm//y/dRLYz7Sv3bObn83QISPApPbGne2GfyhRtWsuHul1aEoSXbDDkn9NuLjtbAVz0bZC55Imu8unzjBpW4YwCeiQDJMuXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268823; c=relaxed/simple;
	bh=CY11lixL7ClJmeuGbmqAsfWkJuqobtm1UI61wXRldKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GBjFhfKkETtWBAyP8yjWbyi3Rk2iSQERQoIBFOzRWsNDAGcqPwR5BSVWcw5k1GRN+lnzedWC9BZXdKR+IeBZaigmpeqSRttqgXHj1II6D2cM9DcvFxePe5u0mz4dChT8fj+5YrUcXNaYRjwkcbvqvxyjK/Cu9psFdOM9DngXTXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ygoOLZFI; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ygoOLZFI"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4743A25400FA;
	Tue,  3 Dec 2024 18:33:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 03 Dec 2024 18:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733268820; x=
	1733355220; bh=hHUyqS1lsGN0thtqqQEmIQ194ugMFUF9duDTKhIEpdg=; b=y
	goOLZFI1Nv6HHAGBQ1KHNJUOIW3uKkkP2kDXCMAJgSumsonL9FrESMMEUCPlxyDa
	qyNTeF59oQMzYbOt3n9uDJrc9AK+MtOTz0A6coSoeuh8OifpZ1xUG6kJdUp2c/hA
	Nh1HP5miWmeKX2c6lZmfzWreT0K1JkUBAAccbtZSQn+Y7cvcTx/4IPpMu7v/fgCr
	43+KgPydna37LKglngAwFUCV2QhnOqT8OBsI/nDRgiJPegYfLxdKBPs3Rwdvb8ik
	V4DFCS67OXTufz0vInCEhcJoXTRW/Xy9BK45KuQVbhjBHtiB5sTVJ6BV2GOQ7ugx
	KoA7oAPZ7q4exP7wxVJQQ==
X-ME-Sender: <xms:VJVPZ2x2-f6QSDZYJ751ZY9n2lpU8UQTvLVtoLl0hyWySherKSQLuQ>
    <xme:VJVPZySQIsxBvXBgp43dT3RJ_HeGiPcBi4fhmmZTtRSFMjPoEYCFbLl7j_JMkDYY4
    p7tyA2GdvQi_kZ1Kg>
X-ME-Received: <xmr:VJVPZ4UPyAhhcY9ebHc9w_4Nag4sUJbK59yU8S3gdRrgamd38txBiOLCMnErZLAfkzwX1jSFdnbPRO-QJXXDu-CT1Zr9SRsmStGBcAM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrihhk
    ohhpohhnvghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VJVPZ8iFn2SOu4murBwBH29FSvynWM9hEhawDwJf6OUGQVpHDzCb-A>
    <xmx:VJVPZ4BqwSog-tRaaAZAGWiR0uS7OZ7C1qyDy_IrYQwUpxlWeTmJGw>
    <xmx:VJVPZ9L076ghc9689CZ0P7JFz0KKdvlmvObVwjx7CpYTiGKEpbABYQ>
    <xmx:VJVPZ_B6VcQAqU6R19-xmJvGi40EZXWWEl0gC-4e8UaCvWaIQP102A>
    <xmx:VJVPZ36MktxZBFfHFoFeL2ZSMy4A07Tr1e0asDrMxjF-zcPL1S5v4Z0g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 18:33:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Kai Koponen" <kaikoponen@google.com>,  git@vger.kernel.org,  "Elijah
 Newren" <newren@gmail.com>
Subject: Re: [PATCH] doc: mention rev-list --ancestry-path restrictions
In-Reply-To: <3bf4e4bc-c807-4bbb-8920-afba077413b4@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 03 Dec 2024 18:38:46 +0100")
References: <CADYQcGpXm=RTEYyxqdSowQ4Vg9jmXuCzOOpd-TgDX8U814BReg@mail.gmail.com>
	<CABPp-BE1C2izp1a0Xm8_0KU+kas8XKejDyix+AzXqbCOeVp2Dg@mail.gmail.com>
	<CADYQcGpyTL18N2t8t-HwafB8VEVbBt452fsE0yMBvRvZd1mbVw@mail.gmail.com>
	<xmqqfrn5h8zj.fsf@gitster.g>
	<CADYQcGrD5KtM1sZQbccAtDaLmUXD8Gxv_nUWmapjfZm=TMq=Jw@mail.gmail.com>
	<3bf4e4bc-c807-4bbb-8920-afba077413b4@app.fastmail.com>
Date: Wed, 04 Dec 2024 08:33:38 +0900
Message-ID: <xmqqa5dc9wa5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Hello Kai
>
> I couldn’t apply this patch to `master` (cc01bad4a9f (The twelfth batch,
> 2024-11-27)). It looks like it is because..

yes it is heavily whitespace damaged.  Here is what I applied after
manually reconstructing.

--- >8 ---
From: Kai Koponen <kaikoponen@google.com>
Date: Tue, 3 Dec 2024 12:14:34 -0500
Subject: [PATCH] doc: mention rev-list --ancestry-path restrictions

The rev-list documentation doesn't mention that the given
commit must be in the specified commit range, leading
to unexpected results.

Signed-off-by: Kai Koponen <kaikopone@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/rev-list-options.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 0d90d5b154..9d5243e0aa 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -401,7 +401,8 @@ Default mode::
 
 --ancestry-path[=<commit>]::
 	When given a range of commits to display (e.g. 'commit1..commit2'
-	or 'commit2 {caret}commit1'), only display commits in that range
+	or 'commit2 {caret}commit1'), and a commit <commit> in that range,
+	only display commits in that range
 	that are ancestors of <commit>, descendants of <commit>, or
 	<commit> itself.  If no commit is specified, use 'commit1' (the
 	excluded part of the range) as <commit>.  Can be passed multiple
-- 
2.47.1-529-gecd20ec0f1

