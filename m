Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AD414B941
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 04:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733199647; cv=none; b=ft9ZW8nM0hGcY+HeZmL72pxk9lEwZBK2IHp0vQoG1oz5tA5Q6ENnGRnLqlAYWTQMNAsWz5zlXX5tcZzWC1PiJ3jWW9JQHGXh7QHLCe0Vh61LSCTzWI3maPHSmwY7rp3jxuLIjvHU58sW/+nKBG+rnXA+da6Ur624tMXwoiyOC+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733199647; c=relaxed/simple;
	bh=movizf6BxHB1Vp8xN464IQYRiwQ7qdBp2CsmlW5G51c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f/oOAjn80HB0tvHuz7h4Ii9L0Tmo6oNT9gcQnR/9uf/3C8ozoiHm84znjwvgeKeqRotKjy/BbNSuBi75BrXBoIy3mLdlLoOudsOxTT0Cva1D1ql/hGmSi7YHYHNEKYUkSxThhCbZb5Bh7AzT8j3aRJGxLGm/PxNmK4kaEgHRGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CKm1hAz9; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CKm1hAz9"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B2CB25401E0;
	Mon,  2 Dec 2024 23:20:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 02 Dec 2024 23:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733199644; x=1733286044; bh=nRCY9TtUozMk00nXFOdBPfxZhcMHOdQNnxr
	hVJVrAR4=; b=CKm1hAz9RviR6Cmqg8InAPafhyOxN08gIHYh415Rv9iH/so4Mo7
	ePw6xiPUF9MrSnMiET5xVynM1Hqwo7dxx8O+VAwJXbWnpRj2ih8WCDcyb5s3ytol
	bNJbx+MvKAeZVYXtDZ5D8fJF7VO62EXIJQUzPoWM+N38anJnCAMdfaYvoh0+LNDv
	sd1d9jD5mvtFE7jECjnLj1ewBsYLfi99yDsYNGNexTPT9MFiUTMcUG0ArI7Glh4u
	VHdhVnkoKtOQmUj0kFPE3IJvurhlhj9HE6/MmOHH5DR/rS2LboJd0lrsqaHeIbss
	YzOeH+b8CfJj7oLn0rLuf765aA2sU72yRoQ==
X-ME-Sender: <xms:HIdOZ24rEK_JeE1_Fu5MZkaUPTkpW9qB4aRGM2YFp-dbg2OjbGbPIQ>
    <xme:HIdOZ_5tRcZGUkblbVa_NGULWTak2vh1pzlOj1a3rSW-pWHgFvab8byeo0Gp8q6Ew
    MNiMANWQWwqmDtwEw>
X-ME-Received: <xmr:HIdOZ1dh6m3GMATdvxB_5LJpeKvbGbJLSvWCxEqmzkifoffC6pADt5SOUL6CDuOfwOlayEPCjrjnurQ2Duy5iVLg9_hleb08Jxrcmnk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghnhigr
    nhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HIdOZzIIV9MgVoDtzlMwN9bUoPQPzk7zSkOsi0hBdqZ1tCOCcwjm9Q>
    <xmx:HIdOZ6Itx1PsokoreTj0UFuZeJN5yo7_UAu2MtC0bwASuxDCvxmEEg>
    <xmx:HIdOZ0yWDK0gaolRRT-d8LnagboHznbjHRIMdORBR6kKQ154iA-fUg>
    <xmx:HIdOZ-LXEeYNZ1RI8sEOslK24URfTpDoFAMk4AtE-Q-8StfYhJ9mSw>
    <xmx:HIdOZ_HA_aNmhr33xQapYzV7co1m1iMy2vwsBU0a50RHONxbQSiRXWqu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 23:20:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  hanyang.tony@bytedance.com
Subject: Re: [PATCH 0/3] Performance improvements for repacking non-promisor
 objects
In-Reply-To: <xmqqr06pe6vj.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	03 Dec 2024 13:18:56 +0900")
References: <cover.1733170252.git.jonathantanmy@google.com>
	<xmqqr06pe6vj.fsf@gitster.g>
Date: Tue, 03 Dec 2024 13:20:42 +0900
Message-ID: <xmqqmshde6sl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> When merged to 'seen', this seems to break quite a many tests, all
> related to "pack".
>
> I haven't tried running tests on the topic stand-alone.

Ah, sorry for a false alarm.  The breakage may be coming from some
other topic.  Haven't figured out which one yet.

