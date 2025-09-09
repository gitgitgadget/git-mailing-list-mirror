Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE86305055
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399003; cv=none; b=lGRr/u5FOTXZ/nQpjdt2oAemcSUHiLMuMPIil/OWcNR7jgKnhJFiGoVzVqPTa07p2MKR8Vt6CJ3nPke8xHRX2zW13X8upZhQ8hG3cCxYTgPH68oeq8W+IDaw+/GU8jOLw64jOdBcKRamBFU1MB3PisqB7U/Sh4mLj4ZsetcaeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399003; c=relaxed/simple;
	bh=FO/2fvneQXqpgcfT1hOfN6DkQFhZ18r2QdleqkE39ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbHdloJIQasI3iHclMN2dKZbUkCIZyrti33oQUc1lRlHKkfR3ZkkL2cL57mGaj5BanFICxS+pI8Oi30tIWRbhUrBWV92pYpgzHAzxjiZ1WHkLbbwTAfkv/CuW4LyRmnqg2Y5HH7QBcFP9mMd3eeW7ay2ueEk/wKWiPo2mr/nMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RdsdiL72; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D5IVho7q; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RdsdiL72";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D5IVho7q"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BB4CBEC0143;
	Tue,  9 Sep 2025 02:23:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 02:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757398994; x=1757485394; bh=FO/2fvneQX
	qpgcfT1hOfN6DkQFhZ18r2QdleqkE39ak=; b=RdsdiL72tdFpde3HtAzwqvy38C
	UssV3Coyg/fvvkqE1YJibC5HtwqdpP0yLoGUjmsw1h6vg7SWUmI2d6XQBWJ9Hp3q
	gRIJEsmc2AYAm1e8pQEnauMoPCje831ITjGmpU/3CoT/Z/kPIj0Jxm746ThCLtzQ
	T+e95vIllsIs+jnFejG7+FPHaQM+Er7MXhVQY2zZCwfFolw2OfKU/O9QlFLOCxDV
	ok5oMYEv+YPPUq+69cV/m6jUSccj5rk5pmLefD+XodaTmA0Jw41kYVZrpf4nn4W+
	4WmnCTfzHXu7tl2VUtPJPSxGYhlNMrrBhhmHSHIa6PmfnlVqqyHxNdS8BBbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757398994; x=1757485394; bh=FO/2fvneQXqpgcfT1hOfN6DkQFhZ18r2Qdl
	eqkE39ak=; b=D5IVho7qoVpbqlISA1Ns29ZbR5PBNAfTHMaGutcbRLqjfBmh0E1
	cGFiUyd+5dgBxHIXKX8d8gvoP+nNEfqoTxD19IkTel4pNL0Id4FEQ1QH/EtDch+a
	vbgu0hN0Dj8/u52ZbwX476LClVQqFpbWTw8ftAXaawKDldMOwm09/sNS2FVIIXVM
	6wH7Ua/rDEj1J1tYlOUeOrrY4O5a+OHwy/85UjtVSf/E3jPqXRFgGag6h165Fi/K
	HfMfeuUpKHG01klQBhdQW4nVIKgcwxKSk4AKZeyEUArjksvi1crnutLLx5tBxEuN
	PJn59Kp3BoqcPLWKevAEO94pBTcTfAPQgnA==
X-ME-Sender: <xms:0se_aBAl4u6HTO0OG7H5DCMc1JWWFD4zmFiOyusUclK3CIgppI4sXw>
    <xme:0se_aPsdnyJ8HriHaLoSi-NiRIM-alx0g1tbcJNdKkgAVSEfHbyswEfJepMFRg3ki
    nfN1tKzFO80mpHioA>
X-ME-Received: <xmr:0se_aOaO7SdL6lJvGkqc5gNftcX5SSHVrXBBE9XDzOCWFlNwFd3aDjmGzV0zAxcJJL7bR8BhnlMRoQ8SIcPcNax464p3zYnlhIHCNAyoRF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0se_aKX5Vogqn1Q-YcnLJp2AAERyn4WsKwhewSfawY3XpHB4Q4GHaA>
    <xmx:0se_aK50BgnLGnOJNHwfsPfWhr4azt-XZOH-udg6uOWFbIcEePeVCg>
    <xmx:0se_aNi0kPTNwaco9N7zDq5IL0G1kKAMC83qAJJ_kG1pRmUuuiN4bQ>
    <xmx:0se_aJcHCd2SpvL1N7JPBcqnVr0g9lA1OmkfBeyRxyQBWIbb057-Sg>
    <xmx:0se_aOSCYhWMkijZRvP-Hj4Sf1UpY4UuDaoQXw-9-U58ctHaaD-ZsVKx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 02:23:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 783a16f9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 06:23:13 +0000 (UTC)
Date: Tue, 9 Sep 2025 08:23:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] refs: enable sign compare warnings check
Message-ID: <aL_HznRC3HjRuaDC@pks.im>
References: <aL21cEM0OcnrKtBW@ArchLinux>
 <aL22Bd_6YM-l92hm@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL22Bd_6YM-l92hm@ArchLinux>

On Mon, Sep 08, 2025 at 12:42:45AM +0800, shejialuo wrote:
> After fixing the tricky compare warning introduced by calling
> "string_list_find_insert_index", there are only two loop iterator type
> mismatches. Fix them to enable compare warnings check.

The changes here look obviously good to me. Thanks!

Patrick
