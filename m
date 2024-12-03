Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B938DE5
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733189359; cv=none; b=p6gkBRhHR7T+pB2wnWQgnN412K5PVu4g+YgqY4vBHG43whaHKBt912xePg8yLFSDXKcUghQFwk0xMbIl790+eATXsRfcNI4FzVtFbwxT7t4cBZ6RIfhdIcqyCozgUWtBG8pw2Dj7WxYAC2xc+HepvuCnxwpAWUXOmgHwx2+k34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733189359; c=relaxed/simple;
	bh=ID0h5cx6Lv6CxJcsNcBPyNVgboRwgXDnStvyYSe75MU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XSq+9bC88GBNN3b9BjYPse7OvfhXzk8ku1pIo52YlhjfLJgRCiu4kg+penU/syXX5fJkijilgW9mh3A2JUxCYLFD2y7s5wwhYCqYqVC0Xl49Plad8tVxHQ4fTIXlNIjdCJGwAEzbKiAfud45kTheRKPDu/t2BkBo8l03rz8u3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hkE+//LM; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hkE+//LM"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 55256254011C;
	Mon,  2 Dec 2024 20:29:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 02 Dec 2024 20:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733189356; x=1733275756; bh=PWuOHPQ+s32jJr5lCM5J1yrKq3lSraYt3ay
	kG/jCLfY=; b=hkE+//LMqD5ue2nGb3lon3P13TDbAUkqV/+zm/7SMJ5dmU/oZYz
	kLPHtWt9jTNamDPtqUyPHioWu3G7sL6RxdKG9thOc5WuEorPVXmVzO0JoCtz8i5w
	tKSGbP/lgeKKv5Yft5jiKnHz3PO1COCvEyHOQh8T0YCjFMafLd4gBA/WB7Z8eH4a
	wfxal+3wUMzZCGyl1/JmndYUOTiX0gg7QwuOTtOdSWW2dDmpTrqBdkVVs775lwow
	8nd9Axbhdl5kqEYqCJsAnqq4jQDEC4JJlP1K6iKsE+dOgP4geWQbwIRVqzdMwqHe
	hv2oUkwGXtaCueK7ueskxSYHGsh73vZgt8w==
X-ME-Sender: <xms:615OZwk-dJKm9z1vmstUsfqnAunC-zQrBfqZvqcDtTwM2XO2_aI6bw>
    <xme:615OZ_2bfBEkM3jeed9D14oy3i5TxDTMRL-hp-JZB_gCJ6QHGFT9r_1BPzjJsY9Ty
    YqlnfjaIOW2xhXwgA>
X-ME-Received: <xmr:615OZ-oQ0JDI2NFPqKslLhQZ7SdBhLlSChnNtq8Zl7m71pjs2kfN45w8RNtZ8JtUmzBiO-vwL_HDYdPxF6O_CAFcYn7m7qiMc8hc_NM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeejhfegvdetkeefhfdtgeetgeehueeuiefhueet
    vdeuheelkeelueeiteekieduleenucffohhmrghinhepghhithdrihhtnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithesjhhofihilhdruggv
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7F5OZ8nbZGCt0O9wizqkVdpscrXpiok1tchr4GwBzJQTCqm6YREHDg>
    <xmx:7F5OZ-3u989hu_eQWmakkUPmg9o9heMbW6GHlecQfpjDcO_hKDLzQQ>
    <xmx:7F5OZztFnJaSpQWGkFnsa9sKxElgJG7goR17dZqJEXjz1i3t2dtYwA>
    <xmx:7F5OZ6UNvvVmIDGiSXUaHDSKPmYEbp9QFcgJnRBUHqP7HIbekWwsdw>
    <xmx:7F5OZ6_ScGudGtSi-SHD0HnQdU-Scl3un4NV_ejxxHwdYUbZou1GqEe0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 20:29:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  git@jowil.de
Subject: Re: [PATCH 3/4] t5604: do not expect that HEAD is a valid tagname
In-Reply-To: <20241202210006.GE776185@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 2 Dec 2024 16:00:06 -0500")
References: <20241202070714.3028549-1-gitster@pobox.com>
	<20241202070714.3028549-4-gitster@pobox.com>
	<477f0dbd-60ed-4f73-b945-cdbdaf9f510a@app.fastmail.com>
	<20241202210006.GE776185@coredump.intra.peff.net>
Date: Tue, 03 Dec 2024 10:29:14 +0900
Message-ID: <xmqq34j5h7v9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So I'd expect 10 digits in a fresh clone of git.git. It's possible Junio
> has set core.abbrev to something fixed, though.

Thanks.

I have "git one" (and "git who") aliased to this script:

    $ cat $(type --path git-onewho)
    #!/bin/sh
    if sha1=$(git rev-parse -q --verify "$1")
    then
            git show --date=short -s --abbrev=8 --pretty='format:%h (%s, %ad)' "$1"
    else
            git log -1 --format="%aN <%aE>" --author="$1" --all
    fi | tr -d "\012"
    $ git help one
    'one' is aliased to 'onewho'
    $ git help who
    'who' is aliased to 'onewho'
    
so that I can say "\C-u ESC ! git one HEAD" (or "git one peff")
while writing a piece of e-mail.  I can drop --abbrev=8 from there
but the machinery knows to bust that limit if it is necessary to
ensure uniqueness, so ...
