Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C079FD
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733020573; cv=none; b=K3ajdREZmWUQ/6U+dAo3csBzVEpUyme7gVDSii6EM9Uf7Ot6dAOGFQ+CVsSbDYbf10jDD7n/xakS61vvY12qtlGJVNSv26rckrAIsjTjAGH9NaAbQWRF+ibGwwcLF5mpZMJW/laElvMVs2HDAsI6yd8U7exBj3/W34WuzzjrvnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733020573; c=relaxed/simple;
	bh=hPB9rF+tR3Hjtkx9OlZeyC9NUZ9Si6OyvLPuXkOJVGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VPyP39VJnvOlMFPrjT3B8AUg5vZkLGyH0CIiuIdTGAWcCL/h4md+wOldtqtLNszuEllzFqzksIFVTXUDANvlcc/K2co9IPaSDR2pI0kPCdWB3mRL4c+9Wrmr58MHbygM2/3iVJonJrU5apx1LWKOEIQLFcLcjWI5Y7guulUMDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XR7wJsrG; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XR7wJsrG"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9CCF6114007F;
	Sat, 30 Nov 2024 21:36:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 30 Nov 2024 21:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733020569; x=1733106969; bh=hPB9rF+tR3Hjtkx9OlZeyC9NUZ9Si6OyvLP
	uXkOJVGI=; b=XR7wJsrGzXE5AWiHmZ+TX62QEGnm9tFSEF00bJm1LPaoAG2xIZh
	YAhPlobfbIGKLIJeViEeeT26aFySDzgh1tcDVpziip2ShhdgbwceTRe7Qv3+yk+0
	sJVNi0bTyIgYHYmt1jNav0G3RjyVylvlPDuodWvUoJGBYlYjDkcnpRdJO2zhKfmZ
	sUB/LuB3vl/iCvVzCGj5iv7YW4bfJmHTBIT18SJEDEAi91+k0Hr44Ld8DC0dtDRg
	S33MFEaY242mc7oCdqVhq3rHe6FijKUjhmDYO+sFa4cer74kvMjWYEX7grTyzHNW
	QmF41vN/pAruLPPVQXY713bVLkGOZaCxOMQ==
X-ME-Sender: <xms:mctLZ8lkh50CbSB-9U8G6TqZvrYGUP8IPnYsrqVQcyVw8a0qtYEFQQ>
    <xme:mctLZ72bdDa_EdJTSoSXNkmcZCg8ckgflrZW6Tmh_R_8W3WGGWZMCbKHD3hnikqh8
    LDyFCpjcGPwYkDMbA>
X-ME-Received: <xmr:mctLZ6p1LmOsmWbPf2J561ASgeJyqTkkFO7r5DG2teG8BvuaahUD8d_dDMRkMCXTIL9HKbVlChzTB6mzQTUZNmVwEa28vDB3h1o6-pY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheeigdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrvghruhhsshhosegrvg
    hruhhsshhordhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mctLZ4lBGiK58ZgbnLeSaXcHFHbE7wTNH0uFxrSqaMlhmeZTltz7hg>
    <xmx:mctLZ63BnpAZAhAaXA4mMwZSTr6qLEI-4YykCsAXDd_kWP_wJR9ISQ>
    <xmx:mctLZ_uA_EejvAB2OAJxsXqjOy0eUwoa3dOCuIkOzbL6yFiUUqS4Mg>
    <xmx:mctLZ2X-ZYbPgPsYO9kxMmc7UydqGblUWDBr_pQhpwo05A7-z2L_fA>
    <xmx:mctLZ_zql4pOAjk0S9zcbycXRYb2Mc_A7a2Ruw9MjZatzMbstw2UN8kY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Nov 2024 21:36:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Antonio Russo <aerusso@aerusso.net>
Cc: git@vger.kernel.org
Subject: Re: FEATURE/QUESTION: git fetch only commit objects, but not
 tree/file objects
In-Reply-To: <c99248d4-777f-461b-b4ab-4cc8df3f09a3@aerusso.net> (Antonio
	Russo's message of "Fri, 29 Nov 2024 09:24:58 -0700")
References: <c99248d4-777f-461b-b4ab-4cc8df3f09a3@aerusso.net>
Date: Sun, 01 Dec 2024 11:36:07 +0900
Message-ID: <xmqq8qt0m8o8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Antonio Russo <aerusso@aerusso.net> writes:

> I don't really know what keywords to look for, and man git-fetch did not

You probably want to look for "--filter" in "git help clone".


