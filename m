Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1F54782
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743245210; cv=none; b=WEBZI2TSX+vkDxHYJr878n6s5PotujbSXvw0vdA/EzROYAxS18ACEFf/JJpcNul5lltUbkw+b5MFK0P27h+Uow77PW6de6WKvF7EpSiZ1wGV35qFVNpkZ+YHu4yI+bptKvtTmtcN5DA7K356WK8KJG3S7Ith2sk3O38Mq/GQgtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743245210; c=relaxed/simple;
	bh=XV5tCSwCtyblr17FBUYwh17LU+tIMPCQmdC/aKr9vm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O5sl15TC6WcbHOaZkdgbM+rmRsJFNIS5qc5zmInCR1A9QRT1L6KBkCYmz4LcFPFGx5bInM6UH/jjL9QqP2Ff3N6AzWHetBtw3Yd6wv6+aOaXqC+iFNoB8N8P3KwisWERq9VKfHRHMTekxz0eqILhYGGAi6rMimYD6Gtfhz2l1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ktjRVM67; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gxlRDmJO; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ktjRVM67";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gxlRDmJO"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 758E525401D3;
	Sat, 29 Mar 2025 06:46:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sat, 29 Mar 2025 06:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743245207; x=1743331607; bh=4DooAp4DzA
	pCIVL7HXn/g/TK9mEOqSgI9QL0+q4ywHw=; b=ktjRVM67dUFH5zn5tRfcWUUzX5
	dojU/L0qXNRpYF+90wMcXj/OL287mTduZBlyCKGTY6on1aPU7DlOQ+sXHF+3pMyy
	SlrdS4oKqmVLWOLa5oGObDv4TQ7a9YXn1XhfOH1xCs98vnHUT6VjkQH7iGhp/+Pm
	oylANiIOp9vuo2sPvK9I8qui1Lk0bLXyaji/UACm2MfWQjBE05zoZ1StM5vhdoTx
	RNB/v/X2d7qUVsbcOjDAQOknDx9qwTpdIYh8HiXm00RjVijbv488TMxLNDTJ2qSl
	64J48fxw0LcOAXlsJqbznWejjvsJBGXRGC2Czy2oTY9OMv00KroRcGruS+8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743245207; x=1743331607; bh=4DooAp4DzApCIVL7HXn/g/TK9mEOqSgI9QL
	0+q4ywHw=; b=gxlRDmJOfFrm2piMZvp/xNevMUdP5guy7Elz6JaHtDR4XuWqHom
	NVqu3WIaEjRhrpbbwUY5oS9QJsiw28zh/+auLm7Cu79K0QwRnH5WX73bWlstm0k+
	RFzJCuBqb0hbUc3DbzqzNEdZWSPdMBFEB+55YrwKyJSG1CHDXt2jDo6MGKlXXBXG
	N/lSpiHYS6NbavRmr/x4kRLup+ECjZ2FxdoaBHaW8r2jlg0I7X5kXI9h3/Inds3m
	6feUyCuAIXmN4UzrpVf/QkmZO39w37AsZgF0pspbEDqPzxDjuxudre4ox0hK92XE
	6+s6njFVzIWbxGeGiL5gDnJ0cYE6FiO5Emg==
X-ME-Sender: <xms:ls_nZ9vd1TCSju_wDl38SAJF3nJ8gmuWGbCpVLJRyi4QDGwa1uY9hQ>
    <xme:ls_nZ2dUPKgATXgvUT_2xq-aj7yvHKaXTlsyA3-cQV1xex4xgJvEtXtoRJrvDfa2b
    jzb_YTcFZDyfk0K8A>
X-ME-Received: <xmr:ls_nZwzS2O2a6FI3lSInWH-r0oyKTEJd8nYdhHUfituRUVY_YNAILggICYP-xo_ZUcTXmanUboX1NcByIEW3lsRqkt4Hc9hUiPVPpWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeefleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmoh
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgv
    thdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ls_nZ0Oj-2FJkZp_Nc9j7F0_CON6BtcqdIObtheyyPL_h4xBhRRWAg>
    <xmx:ls_nZ9952qTOJhXFdNem_sh7kLrqAVr4i3VA0EeO4aiOIeg1b3XswA>
    <xmx:ls_nZ0Xa_rYn0a15np3BGOIjs5IVUoWrg9ag5iinLaIf3vRv816LXg>
    <xmx:ls_nZ-d-1mLR8bQpxV05Lb9lDNIZZ-NY02UV4KsPUZgUfheQNsUimg>
    <xmx:l8_nZ9xvsmQDE1vDCsFqb2jBjbqVLeCu8LGpq7Qc8QzttKb9RbFEDoas>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Mar 2025 06:46:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org,  "brian
 m. carlson" <sandals@crustytoothpaste.net>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/5] libgit-sys: add symlink to git repo root and
 build out of tree
In-Reply-To: <xnjgoym6makh7q64sp5efvkmcubslklkjeidja45rtl2wjm4jd@xfww2a52hj34>
	(Josh Steadmon's message of "Thu, 27 Mar 2025 11:58:04 -0700")
References: <cover.1742339107.git.josh@steadmon.net>
	<cover.1742594960.git.steadmon@google.com>
	<6befc95a2d0893aa269142a18d60ad07e79c6e88.1742594960.git.steadmon@google.com>
	<CAPig+cQ+05r0iJO3me2=yz1KWaU_S_WQmbeciOqZGxYWgbT8dw@mail.gmail.com>
	<xmqqo6xqo2o1.fsf@gitster.g>
	<5qvxvuquk2yuyoyoctz2ji6sj4yld4ridig24elpoiytghlovw@a5hgdufrchwr>
	<xmqqy0wslndp.fsf@gitster.g>
	<xnjgoym6makh7q64sp5efvkmcubslklkjeidja45rtl2wjm4jd@xfww2a52hj34>
Date: Sat, 29 Mar 2025 03:46:45 -0700
Message-ID: <xmqqecygdsh6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> Unfortunately creating a workspace doesn't provide access to the
> top-level source. Symlinks seem to be the only recommended approach [1]
> for embedded crates, but since that breaks Windows CI let's just drop
> the series for now.

Understood.  Thanks.
