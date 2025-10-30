Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08631226CF0
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832492; cv=none; b=R3jGj4XcxZ/k0lCWJPze774DDhS8nZRFfdsbI4EbdxTS0KuP+M9mp8xCOk8qjVoib2AbxVCKYWdByTBu7wi1Mklq+gWuJIYEwTBMzftGuPIwvN8UaJbcIp4lcjbAwjpAekAP2O/7O6vLQR2F2mu+AM7JrWjnlhZndvLfeRd3yJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832492; c=relaxed/simple;
	bh=JJmeZNrYYqmfyapVzDCXjUAenefDlq4KOAtFgoNo1hU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XDi5xAmd/B/Wr7zAioT8eSW2hfuLhGWYmN+ozBb2ZNBbbsSoeZEOCeyV6ah4MOgZlv2iRZ3DufED34ZStDvfbrkLDq04NFQ8ZEKPAlpanGWSzg15J3jb+H8pGcLoj+Z1NeSllAKoJGStDNvWCJGUcCH44HPxzpvxqSuJ7cHkSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nU5rhWDl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kp0UnUUy; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nU5rhWDl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kp0UnUUy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B4C2EC0264;
	Thu, 30 Oct 2025 09:54:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 09:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761832489; x=1761918889; bh=kuQBro3in4
	pWMAPOEqWG9IQMKyrWuF8m3FFJrhtW0sk=; b=nU5rhWDlQOnRuiPteuMuUHLKd+
	YaZGXpsPevylU5Xp7LNMZd8fWiSovPLfJy3kde1aO961u5Fp8prjO0eq2POpriod
	NY1DEGlSsaMgYKg0iZnuM97AxJ4bHvCueInNxoVt2E7VfCmH72sBbVrN9I8qEzPo
	muC7aiXmZCgKoNPEdSPGt++MAif2UtmvtPjzDi5NG/H6Ex/QTu3EYWsSZqNp4QhI
	4z34cQOAfVc7Y4DZl8iTy8YNLy5YDWYkLf+TtPAnfPq+dpGlklnby5M+s8v1GkIm
	2+b5tyfWiivwmX1BpNnnNXHf4x7n6SzK/4Am1yhmC3DfauGwRiV2zeWPQvJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761832489; x=1761918889; bh=kuQBro3in4pWMAPOEqWG9IQMKyrWuF8m3FF
	JrhtW0sk=; b=Kp0UnUUy+kYn3r+Xp+mriXQcGW+nw5ykO21EgXuu1pLQq2HgcXT
	+Zb3jFdDV1zcKNYF+zNeKzNPVcceUqrsPPUBxOxFzW0FNsrjGoSK29/xNa0KWYXR
	iC0U7xBdcQM1uNe4CyaA/BEOp8t+RkhF4q/7aqk6qXdgqI9l0JV4byIFROP6yTTJ
	o1ZMez3dkdUhqkc75zZPlSGrS2Ewy3dyuSkdE7Gly4L1R+vNedDmXOehLKe9DfCF
	dt6MPQR4fmKf++wA0yUjPDJGK5Iqa9VRe0TBZagLVs4GQvbBZlRtEJS1My4fMDAn
	eXx5pQ0GifJyvtx62LxFBX9ocWufTd5gHIw==
X-ME-Sender: <xms:KG4DaYw7VHRArsvwgyuZ7CjmbJyZPByCtHDKV7AlcIzEpXCF2g4IKw>
    <xme:KG4DaTIJmp2UB8oYo1M8fkMgudCJ5LRmmxi1PSkAQ2dG7nYVjr_GP9jZleeacXXOC
    NvfNcFPinmns81xpbbbxbELDINmSzb2ugoDRCbgSvnDE2K3w-gm7g>
X-ME-Received: <xmr:KG4DaSppA_hDHws4Sr0fi-qd9L35UsscmwuEeQC2BkX9z8UHpzIJsk4gYVt8gRX0gtMD-bX-gWrYBX0IRpCt2xz-sqv4Hj-ezXNX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeijeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegviigvkh
    hivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshes
    tghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:KG4DaSKtSI6hIHxiWxn7r8QjAeniPKb3uv2FNEiDiBf3eR7aAl22Tg>
    <xmx:KG4DaXQA7CwymthmSBdYr4aL5uBlKHwH2DrgWKLZFzQiZRr7ACy4gw>
    <xmx:KG4DaRvD0C-fh37f5MA_Vh364zSI9mwiy6fvUFyckwfK3DqBfD88Ow>
    <xmx:KG4DaYacSohJeJTv5R41SrZcVgvzNHB9h72R6DcK3Ew4ukiF8WIWiw>
    <xmx:KW4DaSZGK_FEb-U17hdYe3pxP2q3NGnETsSFFsZmuojV_chKB136AHht>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 09:54:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 10/14] rust: add a build.rs script for tests
In-Reply-To: <aQMFFZ_uDZxHvExW@pks.im> (Patrick Steinhardt's message of "Thu,
	30 Oct 2025 07:26:29 +0100")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-11-sandals@crustytoothpaste.net>
	<xmqqms59acak.fsf@gitster.g>
	<CAH=ZcbBYRiceXQ-9FNq0aK0WzN4nDhqonaoafweStC37mx7JBA@mail.gmail.com>
	<xmqqwm4d716i.fsf@gitster.g> <aQMFFZ_uDZxHvExW@pks.im>
Date: Thu, 30 Oct 2025 06:54:46 -0700
Message-ID: <xmqqsef07avt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The question I have here is what the benefit would be to have separate
> libraries.

Mostly flexibility.  If we do not value it, then that is OK, though.

And personally I would have to say that "meson rolled everything
into a single library archive" is a bad excuse---whatever came later
doing things differently from the incumbent has to have a good reason
to do things differently, or it is a regression.

