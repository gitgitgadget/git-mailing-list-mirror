Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B262595
	for <git@vger.kernel.org>; Sun,  8 Dec 2024 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733626852; cv=none; b=lHjKa/xJDooiLEggSU50tNBlcr8KFs6PqcyG8hTkRwXnsFUCPRVHOoEKETKkH51VxtI6D9O9tzjE9uQ2LFyrm5w15vY/zK6rx2ry2QmZHt7m53k/k9QkM/EaiBdWM955K64lZvSOYZHMXbuqu3zv+l79GIEJe5IO29bLn6VTzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733626852; c=relaxed/simple;
	bh=GS9q1JbtjxEuKc9fBqBYDt4ZN9Vo0lS1hoiS4vgCcqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JjhwL+/BfMQQIc5PQhb7kYkZd/c4NWKbofQ5ytjH8XXzg6OevHdClCYOJxQa4X/oAoA4Px6txpqGNz4BG3SPOY5FZbpVd/N29BDB9V6mHk/MpphYZrgoAJJKutimmsb+mqucnk+AgqJmnP2ErkLHt1+3ypEOg5KTd+zL5R8yGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s+cETDmP; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s+cETDmP"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F4D3254016F;
	Sat,  7 Dec 2024 22:00:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sat, 07 Dec 2024 22:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733626849; x=1733713249; bh=ZFXo7O46GG3LgIBrppje8MultrdPj9cUrW6
	U6kNh96g=; b=s+cETDmPwOSTG1xLMYiFsMNWTxqoaEjkJmjBrkBbsV3R6FwCtZm
	/ZKX/2vbl/64IG+QxkW65d7PHKQenniRssuH2I4HYd9Gs2NWxvIRvJLn1KkeT91k
	O8Fsmp7alGwRURVbmbpmFVdf2hcEGvlLYxsBntbsoF+5CCGPGV+6X6ID+p1qY46T
	ANJ23MvotopAkmtx97/roHR3d5n8DiMma+Pxf4B+6H+kbPiyTNyTxXA0Ob3UGkCI
	p7KNy5jw6xqBJIWeJI2J+p6rqiwbJu8glda3e+ZAXH76n/hE50Wi9CVvQ4NxLvuj
	d9ZyQ/kfoMs/QH3gOEUCTmF/3LO6M/tlkZw==
X-ME-Sender: <xms:4AtVZ6d3jAwJG1fY4uwatDOpExb939P-qlpF7GddH2GgDvZZdPwFtA>
    <xme:4AtVZ0MYOfPY7ty3VVg6r01xK9K4apVR_E2wP0Z-A5HwyfGAo6y1GHangVADC5j8m
    zw3jJDrbGKNl6G99A>
X-ME-Received: <xmr:4AtVZ7jeP0rTR0_mHApp3njZd5OZnmOcieQzk9dOsZRvCOa_3LsQVXk7HS2M4hqA1pvscR1QQCKLF1v8dyS3IzqR5VBJ0mMqoX7i_kY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedvgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeejkeeujeegteevjeetgeeileeujeeijeefueeg
    ieetiedtleffvdffheeihedufeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhooh
    drohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegurghvvhhiug
    esghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:4AtVZ3-QziV4BBxxU4aw9Z7_k-ibFVA_5o9LFpufcmgyrw9fy0GB9A>
    <xmx:4AtVZ2tkHUK8AC_vGDwR_JTYMmovQ7C58vKHHloV8rEpwvw6bh5k1w>
    <xmx:4AtVZ-F_RmxJi0dl-u3l6WfktMAU3t2uLantTHiiAzHTfzZotoqbDA>
    <xmx:4AtVZ1Mq8uRuoMI2tMVMneEa0fWkEnmW12V9KcehmWb-Giual9kBiQ>
    <xmx:4QtVZ3FlGfq4b6kBXGPGSJocXB-8L21bpFRa1CrylADMLDzNE1R_2Ato>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Dec 2024 22:00:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Taylor Blau <me@ttaylorr.com>,  David Aguilar <davvid@gmail.com>,  Jeff
 King <peff@peff.net>,  Johannes Sixt <j6t@kdbg.org>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v11 25/26] meson: fix conflicts with in-flight topics
In-Reply-To: <20241206-pks-meson-v11-25-525ed4792b88@pks.im> (Patrick
	Steinhardt's message of "Fri, 06 Dec 2024 14:25:00 +0100")
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
	<20241206-pks-meson-v11-25-525ed4792b88@pks.im>
Date: Sun, 08 Dec 2024 12:00:46 +0900
Message-ID: <xmqqikruswtd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> As support for Meson is still in-flight we have to accommodate for
> conflicts with topics in "seen". The following conflicts are being
> addressed in this commit:
>
>   - ej/cat-file-remote-object-info adds t1017 and "fetch-object-info.c".
>
>   - ds/path-walk-1 adds t6601 as well as "path-walk.c" and
>     "test-path-walk.c".
>
>   - js/libgit-rust adds "common-exit.c" and "common-init.c".
>
>   - ds/name-hash-tweaks adds "t/helper/test-name-hash.c".
>
> This is somewhat painful in the current state where Meson is not yet
> part of the main tree, but we'll have to live with that for the time
> being.
>
> I've split this commit out into a separate fixup-style commit such that
> it is possible to test this topic both with and without "seen" merged
> into it. You can simply revert this commit to test without "seen".

Now I had to reconstruct these "fixup-style" commits and they appear
under ref/merge-fix/ hierarchy in my broken-out repository published
at https://github.com/gitster/git.git/ (and no other fallback URLs;
it might make sense to have another repository for redundancy, but
it is an unrelated tangent).  In addition to these listed four, a
newly added ds/backfill also needs refs/merge-fix/ds/backfill to
adjust.

What I noticed while performing this exercise to place ps/build~1
(i.e. the series without this step) immediately on top of where the
history leading to 'seen' has a commit whose tree matches that of
'next' is that we need some "distributed" (read: put the burden on
topic authors, not on the onwer of ps/build topic, and not on the
maintainer) way to make sure various list of files in meson.build,
t/meson.build, and t/helper/meson.build are in sync with
corresponding list of files in the Makefile world.  It _should_ be
automatable in theory, and to help those who develop against the
current practice of treating Makefile as the authoritative build
system, a Makefile target that tells them that they added a new file
to Makefile and removed a file from t/Makefile but they forgot to
make corresponding changes to meson.build and t/meson.build files
would be very beneficial.  We could run that target as a part of
"make test".

Of course, those who care about keeping CMake build up to date can
add something similar hooked up to help others help themselves.
