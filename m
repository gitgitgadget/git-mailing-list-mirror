Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BFF2038DD
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527089; cv=none; b=p4LWCovriFGzgCLGgDjGT1wLL16NTaEwndkyqHDqQXv4gl6xNx2X68svTisNpsGXyJTqiq4zeoZVvTDB7edqRUWS8K55iz2dbO/dtcN6MJtuqZFKe7fphr+6chC8sJDRFOskO5BCfMSEElpXHz3SD6zYA4vU5BNpn+OzUZ1wEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527089; c=relaxed/simple;
	bh=8/x3ogYNl5E4l29pR2PmkiWtNuNE1bo+ud3yaNllhXo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OxjLYuAv8IJzw4Kl1qJieC8fTdc8G4vHHVJIaqM8v3hSSEumq7zn2IP/cIzC0zwaN3E5TOy5z4uL8N+TIcv1w22Ip7DSI1nHGbWg6804GiMiRa6aLlByfffKN9kVGekFjjd+UXlsrUP1ocE+3DVXQC4m07TntOsx7RChY64iHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mayhew.name; spf=none smtp.mailfrom=mayhew.name; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KmP52WvC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mayhew.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mayhew.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KmP52WvC"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B7E00138020B;
	Wed, 13 Nov 2024 14:44:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 13 Nov 2024 14:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731527086; x=
	1731613486; bh=yfexP7oyDn1ZBroVm5MmasghzCm7kgeWiyVGvVpHbGM=; b=K
	mP52WvC7RgOg/aGaHahYIG5AgsTquBXDRk58XBx0v8rQrWGKjTktC9utdvf0gMW9
	BxQ5DJjYaJ3HqbXitjRfVvAzs8ywd9VWnRXUMXFrhhqPl8/1O4ucH8HsLODJqGi3
	sUd/t4RXm3BuPHjlMW/HYy4q0S8UPdahzaUE+bEIDnRD+NcALyi9dMruG2SrvJCI
	59YPq0hkrllHenXiEETn1GBQUDPsu9O51FYXpml2459sc2cui1Kzwzaio6Q6YFgh
	+N6RcDouD7ILxAQE1vDBYcnogsjp0jLY3FPDTbw9W76SYVEXHWSQweTb94uNoVVT
	5PERa8V26IpkaZB4cfR4A==
X-ME-Sender: <xms:rgE1ZxjjxzxTc4OyH9cVbK9xVQfNMg93er2rVlMIunNa78rBjVueVw>
    <xme:rgE1Z2BdOemMizN1waJoOgBl5awlh5pCUrdiCE1uErz5u8gORO0hPNVxn_nQMt7xB
    Z-2nk-jQF3boUPmrx8>
X-ME-Received: <xmr:rgE1ZxFaMSO8vxlylvXgPKZRLSIAL8CP_M3aMTIT2mp0B3XMxaE6Jw44ddPdQObzSeu13VZ3gataHLFOxaaxSyJ3iwmHYzqE1Pk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefpvghilhcuofgrhihhvgifuceonhgvihhlsehmrgihhhgvfidrnhgrmh
    gvqeenucggtffrrghtthgvrhhnpeffgfdtudefvdevvdffffeijeeihfefleefteeggfet
    geeiueeuhfdtfefhudelhfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsehmrgih
    hhgvfidrnhgrmhgvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehvugihvgesghhithhhuhgsrdgtohhm
X-ME-Proxy: <xmx:rgE1Z2QLfl0LlsT_5DGgo0BMxeNby95VG0DoDimxLyW8WqIbLEGx4g>
    <xmx:rgE1Z-x1WoG8api52d1HOTeZzldYvMtGDuSb7UXMXIdKEUYPSHjF2g>
    <xmx:rgE1Z87Z7DesrD1DFgJM78CQmLkOrSWweU_2jYYuljIwFrcyYYzteA>
    <xmx:rgE1ZzxiDXy2GL_Mn7kmlRNl_KC5oY6vnMiXP9DsdcLMSyxKCAduSg>
    <xmx:rgE1Zy9rPaOCnz_pa_Ti7q-j8ZdGRZIZJcC7rVQmeRZI9MTY1aKEgc6l>
Feedback-ID: ibb8947ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 14:44:45 -0500 (EST)
Message-ID: <c9260270-c783-45d0-8842-304abc978870@mayhew.name>
Date: Wed, 13 Nov 2024 12:44:44 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Strengthen fsck checks for submodule URLs
From: Neil Mayhew <neil@mayhew.name>
To: Jeff King <peff@peff.net>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <20240110102338.GA16674@coredump.intra.peff.net>
 <d9f53fe7-6570-4aea-894c-942e12e012c4@mayhew.name>
Content-Language: en-GB
Autocrypt: addr=neil@mayhew.name;
 keydata= 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
In-Reply-To: <d9f53fe7-6570-4aea-894c-942e12e012c4@mayhew.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13 Nov 24 12:24, Neil Mayhew wrote:
> This pain is happening in 
> https://github.com/IntersectMBO/cardano-ledger.git, a large 
> open-source repo.

In case it's helpful, here's the script I wrote to reproduce the problem 
minimally in a fresh repo:

https://gist.github.com/neilmayhew/f01dd8f807ebc0bdd37c4db154eabf64

