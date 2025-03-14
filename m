Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0920217D2
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990736; cv=none; b=hWCoeyzoJStCcLl48+6aC0px+lHwQPFDZaeQ6WxW5uld8+p3kqJ16Ymq/Thr4ADFfY0NDAxTdEIQ3VQmkBv8RZd6RwFreqLxfCJ2Pl9ZU34wLzUADZpavIOV4UmvJxrC89YieqCO+CYzzTY4gkoESbcKoS/7dt6AdeMlcjxx72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990736; c=relaxed/simple;
	bh=BAGqJ7iUtHWsMrRRoogXyPxMfjV47ZqCnXodXGLsFjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uJOmfTccRjW6lDnS7fIkovAe/2Vk/lh4Xz4tWd9dmTWWW4+/H6xaUn1TzQCHbgyMbil3J+G4hkgHTLEzqt57VNBU//wzgUHfOKQekoo1ZPRh0E30XNzdkHk9VrdSQk7cTjJb2BCW2jIa2BMMz999udfvgimmvKizlNMQkdrpWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pWXUQq+i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GKQkJUWC; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pWXUQq+i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GKQkJUWC"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 110F71140243;
	Fri, 14 Mar 2025 18:18:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 14 Mar 2025 18:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741990718; x=1742077118; bh=lmCC2YNxYc
	TMT8qZ/VJCitUzoEb3XPLTvlLXxVx7Ig0=; b=pWXUQq+i2gMFGU7SuGTORnbMO+
	xrDQZgagKe1eMo+pNPE7gKAQmZniFHEUKBJZeZi8C7LD1AFvsAVIA0Y2jlVvvbLt
	kVFmtMQRTj+miQT/nPVgQbx/F6Olzr8H063KY3KBrPRA4U9hRi86Diz9VFx3xTgr
	DwK8yC5GECeeuaDToQPcQ/uQ5cEz1A52uoY3miEioPuvJs2x12Bt++6gXg2TsT/k
	khL41TizGtUsQikyF5KOiCrcd55kJy/5xvge91gn+JkXKoAqBIqsJIT1Uu+RFG3M
	NwEalok9WiHKXdLra6Upd5pTl43OQkxbNBpeBq69haS9waH34qOLzX2UZCUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741990718; x=1742077118; bh=lmCC2YNxYcTMT8qZ/VJCitUzoEb3XPLTvlL
	XxVx7Ig0=; b=GKQkJUWCB+g/nxBpKKHVmSAJPPMwxUbPL3xF1P9HUmDoeJ4zyOM
	w4C8HpYnP4wT8OhFVXSB7855WLJ18CERZQurafGiWaEfm1WT98OXk4ThkDzDvSRw
	YpdvjDOAfOmjaCSNzpVe4s6G9U3uqdqTGdkP7k/ZPh6ERhRCwbIuUAe6qYe9AI8K
	RBVvJs5+H6CS2slbf4A3728sLM/nKfUauSX0pGeTrdH1HxltII6ILHdlIgl1+aTn
	koOmj2PaUY+yZedjN8t/belD80n568VDxM3hq8HPJStwMotDQMst0jEf+XLRU2li
	JaB2td7HREn8GrMBxOpyX0Pdbr7Ps9CmpMg==
X-ME-Sender: <xms:PKvUZ38wOtbqON3jKJXbYKXg5df5WFN96SewCI4suct5LMD0kSTfIQ>
    <xme:PKvUZzvcYp00aVhlcTIO_-YHkzQd43jRmq8vHGy57I_C3vW-v5sfkJxeY1diAS3xY
    d7FUWCXXUMnVQD0cQ>
X-ME-Received: <xmr:PKvUZ1AfufzsJ1GhBETlAK_M4bQ28Ly2PlgAaeeSdEPMs6tIHFtGMgPb-Ho-3tLxYFh9VORzc-L2v_isz0sh0rbGhAtxpGHkUJJsQSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesmh
    grnhguvghlsggvrhhgrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PKvUZzehl29cMQN9ZOLacJ9L-G152ghgm8HKA4lIFXfAEDxgkGy5uw>
    <xmx:PKvUZ8PSXktv1lAvX9T6W3y3M3v6k4ibWcnLzlRcyxf3McFVQKy9DA>
    <xmx:PKvUZ1mLZS9L53yfqew5sFqCQFBdxPxHxNmm5hmKDpMqKNvE_TvtyA>
    <xmx:PKvUZ2vcF4C8m4b6T7qULVJC1BUc7Fg1JTL_zE1m6d_FpuCANU4JhQ>
    <xmx:PqvUZ738odRZSn6evTE0UM29vfEaX3CtB67GevV2Tc55taqKYqAjGtJh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 18:18:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: David Mandelberg <david@mandelberg.org>
Cc: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 2/2] completion: fix bugs with slashes in remote names
In-Reply-To: <c80d20d93c92422437150084f402ac36@mandelberg.org> (David
	Mandelberg's message of "Fri, 14 Mar 2025 15:43:06 -0400")
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
	<1587533591c81d38977e62165784f8eb@mandelberg.org>
	<c80d20d93c92422437150084f402ac36@mandelberg.org>
Date: Fri, 14 Mar 2025 15:18:35 -0700
Message-ID: <xmqqo6y3dzno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Mandelberg <david@mandelberg.org> writes:

> +	__git for-each-ref --format='%(refname)' 'refs/remotes/**' |

Just a bit of curiosity, but how would this be different from using

	__git for-each-ref --format='%(refname)' refs/remotes/

i.e. the prefix match, here?  Does the wildmatcher clever enough to
optimize "**" away and make it just to iterate over refs/remotes/
hierarchy without filtering anything?
