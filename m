Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC41373
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731716562; cv=none; b=oTQELtC3AuJK4KyuJ7Ulq4+W1M5Ew30ovNE9cHijhymoBQDdy5dTvuBoTvZAsHN8aaJDQGz9RsYMSUo/7swoPtUgAn57lWzHLion/pEGfIXmmkUcG1WkGkE6b6u6SDDsjKGQcToP/Mr0wqhKpTI4oNKGV+f1d27dbQOy1J392TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731716562; c=relaxed/simple;
	bh=pSkyUzO0M8FgJDqiGruL2Rv2oSBWSiwFHgFYk7WfqUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=egZmaWdMaHTzmd6KNp7xeyedxuYJQ7ZvU9R/FaNfqhppbSWCvybaWuOkC+eAdWYSS4VHiNmw/pi8QifRp2C4ED7/dtMvnoYh3Po6o8e3tc7wKQnOqB4mVsUe/BaI++nvSmXSgVquZ3XUaYwAf/heTEj8NH1wiz4ymrKdqAAIvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IluaGEG6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IluaGEG6"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 948132540146;
	Fri, 15 Nov 2024 19:22:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 15 Nov 2024 19:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731716558; x=1731802958; bh=fmKGHN33A5GudBl8kj1fIPTS32gIahQK9cd
	wxlcQChs=; b=IluaGEG6/+FAEUUhhs+hDRkI3zAwVxJ10AdQ5G+TG/cko1fwc9C
	vAkZsYsmZ1VYXNcQfpLAeO7RMM5GsljNJenQQEduz21ORPnHV7KOvlqSmU8OCJEb
	SsoPyEC7yZvS4p3UfonsaKQjtULlpHaiH1S/uEmyEOGysmNMbGbVNVkf+SHzqDDP
	NKNRjsccTzwpmgC/W9bHHjPBWl8K4lSf+PlMeUYXhYrffejOv9zzUJrrZUhnSNMD
	WZ9N5/QSJ6GQG+z0qGzVonBuK3KFK2Kq8+OBnzXFdXbghaX4tw8OJnmi6aro2r3m
	xJvyUxxDXPLurWn/Xw12V2MGQeG+9i/QYsQ==
X-ME-Sender: <xms:zuU3Z9UXyZoouTJbIM8ddXN9oUFrbuas5vyxdBDA4ZdOfgjIWl530A>
    <xme:zuU3Z9mfWolHs3YIMq2Y3cYnTJhUNxYWdjerEHv3EACbrrVmqugENw-xVclXh66YD
    yqwgwWLjQdg1NCF1w>
X-ME-Received: <xmr:zuU3Z5Zdn2iVnKhO-Tbmm9hfD5pulAVM27sHH8PVov6QBDhY0uMxrJ-Hel91_4SPW5Iy_41l7FV13aQH6mdpbIHE408OsynLRdM2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdehgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepfhgvrhguihhnrghnugihrdgsvghntggvsehtthhkrdgvlhhtvg
    drhhhupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zuU3ZwUJG1nvWARYN3JgepPtjnS0OvxqedGDaJwn5xpGHqPdhf0iqQ>
    <xmx:zuU3Z3kZfR1QGLn0kDKHjZtxYeBLZVSPOZIBXj6NH4IYsbieHFq4Kg>
    <xmx:zuU3Z9cqmd28dQMLnoYDPFoZQzjg4Us_j_nvlTm3GqPO40ocAt8yOQ>
    <xmx:zuU3ZxH5hVm2DxDQNdVMmTwhLlWkVInWuv8O2YKQMGBUSuhXbiWbEw>
    <xmx:zuU3Zwh1SOk6lTx1MNNRAaX9OzeMpLa_tOQKV4YsuSbNkPRzX-LkZCxM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 19:22:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>,  <phillip.wood@dunelm.org.uk>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
  <karthik.188@gmail.com>,  "Taylor Blau" <me@ttaylorr.com>,
  <ferdinandy.bence@ttk.elte.hu>
Subject: Re: [PATCH v12 4/8] remote set-head: better output for --auto
In-Reply-To: <D5N4TN6WX65V.JJKLX5ROS8NN@ferdinandy.com> (Bence Ferdinandy's
	message of "Sat, 16 Nov 2024 00:13:48 +0100")
References: <20241022194710.3743691-1-bence@ferdinandy.com>
	<20241023153736.257733-1-bence@ferdinandy.com>
	<20241023153736.257733-5-bence@ferdinandy.com>
	<xmqqcyix11w8.fsf@gitster.g>
	<D5N4B2SSZAG4.1O5CERCP825X2@ferdinandy.com>
	<D5N4TN6WX65V.JJKLX5ROS8NN@ferdinandy.com>
Date: Sat, 16 Nov 2024 09:22:36 +0900
Message-ID: <xmqqjzd4yqlv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

>> so refs_read_symbolic_ref -> 1 only happens if there's a valid non-symbolic ref
>> in origin/HEAD. So maybe if we put "Not a symbolic reference." in the referent
>> (which should be an invalid symref), the caller could check for that and then
>> should be able to distinguish this special case?
>
> On second thought, it would maybe make even more sense to get the reference
> hash and put that into referent. In that case the output could still be
>
> "'%s/HEAD' has changed from '%s' and now points to '%s'\n"
>
> but with a non-symref after from.

The output may look like the above, but people would certainly wish
to clarify and/or translate "from '%s'" part.  And to allow that, we
may need to signal a bit more explicitly that we saw a non-symref
HEAD there so that we can tell between a detached HEAD and a
confusingly named branch whose name is 40-hex.

Otherwise, one who tries to update that "has changed from '%s'"
message to clarify between "pointed at branch '%s'" and "pointed at
commit '%s'" (or translate into a language where the distinction
matters, perhaps because branch and commit have different gender
there that affects conjugation for "has changed from" part, or
something hand-wavy) have insufficient information to work with.

Thanks.



