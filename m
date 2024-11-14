Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692152F9E
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611497; cv=none; b=U1f/vVfyP6CGmh/699Y216H484AVHlhr0k2U8KKBx25CFopvI/VA6WZROpNDsnJgdxotyCKNTlPE6Z7SOkHi04IOL/GmDMdakm1ocrlz4bM+m6J1SvuvKCvnnzaDXcYNHCwROZa/0c1719Hq4+yrhQlwSuY1egHBBCfIM3U8GE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611497; c=relaxed/simple;
	bh=fEk0FFXOeZ6Jh2EvWpQ3L6BT5KiJLzz0h1+PjqFGNQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P62GUKFkEV29rlwXqzWL8a/BZ5iQLkN9Rbr2aUri6S6+RSl8AIMDlD7oK6Gfp3HbNXyqdJ9GJOp471wv3rP7ZsRGDTbSAOzwWUb52p3gmDVl2Pt5Q/9lXDcCWKKVpwQf9EpolJDIweeCaSy7HD6f42IXIxNyPhsRodHO1MkuLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mayhew.name; spf=none smtp.mailfrom=mayhew.name; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SpMos3xH; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mayhew.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mayhew.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SpMos3xH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A0BD254013E;
	Thu, 14 Nov 2024 14:11:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 14 Nov 2024 14:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731611493; x=
	1731697893; bh=ZN4IpdIEB0mE3O7PBdEVvbIQy0aYFgdr0+LiQNeClkU=; b=S
	pMos3xHEYGoZyOeNWiey/x4XGBgmnRoRQAbe+gN1kDSugr8vvJo78d0g6wF8Lmk9
	BwCuEUQgWDNTfk6eySeTI2Mj+ko0E0xe+H5KrxdVLkWPdFCvobOcZCCXbF/TpTMT
	sCz31Jo09/C+j0OIcvczN7wvkkxyK2Ib5LgnF0OaQBk6gIOF0XjDvOlBon03igEJ
	U5qDW1ukuUOR8NHyAyVF/cLClL1GBDW2J3HKtXogjeq6rcvAxAvpY2CCjnuQSztd
	0q9cwjNjEEfazpGKbgwRL6Ozd4xIuVFgr5t+nvVwHY9nZk3aI/Apv5mMN+hq0w7X
	06FlDG4JTxoRyK+H422SQ==
X-ME-Sender: <xms:ZUs2Z0-BtBGIknWwChni-ON_aGDlJhce9hjB98OI7Oj5mF937lKbdQ>
    <xme:ZUs2Z8sk0rRLdhL4S31e7pLlnFVlBSyVKgbK2oVuUL6SX8Ydms8MlUB7m4qK8gfUa
    9ZdHOjRWM1Ztg0Ugvs>
X-ME-Received: <xmr:ZUs2Z6BkDLceO9JvxZAgjl2lKPvyAhaje7NxIr5vsuaDjQJXmtTUHEBWk5EJpGyL9E04AVFO-nJ-26Ktpm3Utg_Or5uhk6XB6NM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpefpvghilhcuofgrhihhvgifuceonhgvihhlsehmrgihhhgvfidrnhgrmh
    gvqeenucggtffrrghtthgvrhhnpeeggffgtdevtedukeejvddugeejhfehiefhffffgfdt
    hfdugfefkeekfefgveelffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehnvghilhesmhgrhihhvgifrdhnrghmvgdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvugihvgesghhithhhuhgsrdgtohhm
X-ME-Proxy: <xmx:ZUs2Z0cEEtsQoUGhomVA7q7FgzChkZiYNcgfjx5S3KTmv0Pojk9Cvw>
    <xmx:ZUs2Z5NgOzZ9B_bF6608d8Rnv4fBdgvXM6LTU-3IXXC2F-Q1JSKjMA>
    <xmx:ZUs2Z-nMdnImPwo7VyYYY7QDVtCbH4mREDhrijPSi6mJlSfYjkG9Og>
    <xmx:ZUs2Z7smGOD0Cnw0ieCwGevSp5oqG_2oWEpEyLZIrVEmG4yWbc71tQ>
    <xmx:ZUs2Z-qxI_a_E-NYerGMNy0__4XJqmbWoTCsE5LwjEhiy_c0FQLEd43v>
Feedback-ID: ibb8947ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 14:11:32 -0500 (EST)
Message-ID: <9a19a763-e4b3-4e5b-b933-d50307aa0af2@mayhew.name>
Date: Thu, 14 Nov 2024 12:11:31 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Strengthen fsck checks for submodule URLs
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Victoria Dye <vdye@github.com>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <20240110102338.GA16674@coredump.intra.peff.net>
 <d9f53fe7-6570-4aea-894c-942e12e012c4@mayhew.name>
 <xmqq5xoqahbx.fsf@gitster.g>
 <20241114001003.GA1140565@coredump.intra.peff.net>
 <xmqqzfm27dze.fsf@gitster.g>
From: Neil Mayhew <neil@mayhew.name>
Content-Language: en-GB
Autocrypt: addr=neil@mayhew.name;
 keydata= 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
In-Reply-To: <xmqqzfm27dze.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13 Nov 24 19:20, Junio C Hamano wrote:

 > Jeff King <peff@peff.net> writes:
 >
 >> So if it's causing people real pain in practice, I think there could be
 >> an argument for downgrading the check to a warning. I don't have a
 >> strong feeling that we _should_ do that, only that I don't personally
 >> reject it immediately as an option.
 >
 > Oh, I see.  I do not think I have strong objection, either.

So if I was to submit a patch making this downgrade, is there a good 
chance it would be accepted?
