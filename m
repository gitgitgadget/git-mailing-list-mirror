Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1817109B
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691439; cv=none; b=CfZpj6ru4vWrOmIyGILvm5kQ/UNz+XnAVYUtAojQPqvKa1dAgYFg3xvPP9M4Kt8Z2upKLMEWR3ojTiH6BwuwlDP8RnCzlJBn7SjkM1tauLiv2RuzHW8TduwA1hCzbmwQJa8DLAiTNxFGKUgzk0xzBJUZoNF+G10IkOA2KAJKxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691439; c=relaxed/simple;
	bh=atCuIi1aM6uEc7faB21mdiuqtJEDgRSbnMVrLzUq5BU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mM01rINPbQNViiAATm4CFLDM1UjA4dtXnN7LfQC4EB/yXDzdYjjTbHEctOQ4mYrSh4c1RY6D1n52JF5tu1OXyN01Wzj4PD3jI+bE7pZ/axg9q1UuPlH+va/o3W2FMibXzDjRv7GacdgDrnI0RkylOvEetWZBF2+BxNNDeXFQvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fnq8d9Iw; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fnq8d9Iw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0849325400DA;
	Fri, 15 Nov 2024 12:23:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 15 Nov 2024 12:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731691435; x=
	1731777835; bh=SyN3sWyZqWgsE4OLLjcz/NLqqUQ/csn54Pwhbiwslbw=; b=f
	nq8d9IwhnbaUz6izfMw7gYGl8+feYMq7HiwxaO8blS8B8rOaC6UhKUgr3k4+MmHH
	mBFw4sN7q1Leb13mPeryeCvdZhoE2GRtfurTHqO6orQm6ML7A0JtxYZuWIL45xtG
	1GhJthe4jhBFtGln5rku+LtKD3BB5AlOd6aJ91WbjCalrabkpb/htM6YcU1FLSWn
	fppOv2TS7d3gKosceC8e3vkSykHb0VdiXxEX3oOhpvFkvlUYMzjqreEv5kKdxovO
	ww6IacLqzhV7GIf6gGaey/AkidZVQLtg59FUcGxVylBoCOUI8HUeLkovdHAxZI4E
	7+bVNWtyzs0EaefPS7K7Q==
X-ME-Sender: <xms:q4M3Z7li2POh_VvBXGxqmfiUxk-jDFJ_Gs5pHogOwcLiXPOIeJ8C-g>
    <xme:q4M3Z-1aVvQiJyXkClbEhao2VmBS1PlqWweSeaU8CEsnTXvWCTYmz7hvbtsfhHiiU
    dRZ9vsKhj3uZG_B4g>
X-ME-Received: <xmr:q4M3Zxr9Ue5Djv4tYeoJFFDZJ9SZTEzjTVfgTyH2vuyMzVq3PqjJDChoC6v4RAeZVkCA_TpKnaaVO2SSZ623ic1zlQyyMVP_qAgf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeggdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsg
    druggvpdhrtghpthhtoheprghksegvnhhrghekrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:q4M3ZzmMKUcf0JgwS_HQGLIsFV8V43rZZ8pbrtGqYWVxswIQebXoQA>
    <xmx:q4M3Z52ue4-obbBIux3la0VVPb32FZ21EanStIJks-4uXXLfPoDFQw>
    <xmx:q4M3ZysDLdZYPTx2JUJPTw7DqYUxJMteMwBrXktY3i_P0TBnD7cqyg>
    <xmx:q4M3Z9WMREpEjcuCvM33ylsiBThrrqWfNGhzz0QYTGHnARBhoZvNCA>
    <xmx:q4M3Z0QBCSGhDeKXlvv-RTqkocc1VHk-GAFb_FPJRW0p-6MPaIjiObJM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 12:23:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Attila Kerekes <ak@enrg8.com>,  git@vger.kernel.org
Subject: Re: malloc: *** error for object 0x1: pointer being freed was not
 allocated on MacOS with git 2.47.0
In-Reply-To: <4ca84916-c5f5-4d52-8f6a-08b729bb66b8@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 15 Nov 2024 17:34:16 +0100")
References: <5FFE9429-7496-429F-BEC5-9D00C8409AC3@enrg8.com>
	<4ca84916-c5f5-4d52-8f6a-08b729bb66b8@web.de>
Date: Sat, 16 Nov 2024 02:23:53 +0900
Message-ID: <xmqq34js1kd2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> This is a known error.  Commit c95547a394 (builtin/gc: fix crash when
> running `git maintenance start`, 2024-10-10) fixes it, but has not made
> it into a released version, yet.

Thanks.

There are bunch of topics that could go to 'maint' and be part of a
maintenance topic, and this certainly looks like one of those topics
that can go into 2.47.1 someday.  The usual source of candidate
topics I use is messy and unusable for some unknown reason, but
offhand I think these are safe and sensible to merge down to
'maint':

    ds/line-log-asan-fix # 1 (2024-10-10) 
    jk/fsmonitor-event-listener-race-fix # 2 (2024-10-15) 
    ps/maintenance-start-crash-fix # 1 (2024-10-18) 

Thanks.
