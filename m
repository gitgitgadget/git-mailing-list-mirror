Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5654A23
	for <git@vger.kernel.org>; Wed, 14 May 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747250968; cv=none; b=tYkzwVrRwEZK443sdGMAV/JYCWf1Bf0BLNI4tSnp6dqkaQY2o1bz+XxJPDPinId1MFNIArSLJ9VsnnyP50kKZvxgfmI2am0Uf6vxMI1IqILQKRimj3SroT0q2OWb1rXcj5fZei2Vy47Q43JCLTOeTxGEF4U0eLMtYm/Hti26smc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747250968; c=relaxed/simple;
	bh=l8pD38blgZbbDC73mU5Z7xzRAcZqvuY+r9L4Coq5qDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DKDk0yooUX0oMl1vkE0SNt/Y+mpANkPQF8UOlXPV5y1ncnlZDYIHhvDWYWJkSGHaTNOpu9SuZiTtiVbLbYbNKKnFs5j6fSKMbELXye2FNduej9zpyL2hv4yJKfi+gfiEQFjnXAkeJRzib1xaGID8SN1wZDSsW2D4tpJpIre399g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hecZjHJy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KBINdmHK; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hecZjHJy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KBINdmHK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9338525400FE;
	Wed, 14 May 2025 15:29:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 15:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747250965; x=1747337365; bh=SsLMhKVCmQ
	tjTinbEvf5Mp3D6DjlnMgMFwvA1Qj7AD8=; b=hecZjHJy/nk+dOpgJHB5kfwiYp
	b3UmxK42Pl7SlRGVuCPvGs4+uRLi9e2dEDjxUu7nInDTPUCcDpGRbiQ8vdk1jcQj
	7lySa602M96D5QYbYak4szLyA8RnMCBIvZR3ZnVujH/HTCRHblJsOZAdk/w5Llxi
	ClVzxh4uQlGARzG1xuwjdLWHtG9lpLumgSOlGVgFQ/QioPeYVVuSVdH0GAbleIdP
	gyv1g1iFB0xxxMillZHBSt//To0Wo7NipKpZCLp52qdb1wXaZUdIdC5CYV0k3D6u
	Rfaiocl3QZNJXvroWmszdVZqdcSxTgdcOzuYGXHpIVDh6Hn5c4bVp4gjft6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747250965; x=1747337365; bh=SsLMhKVCmQtjTinbEvf5Mp3D6DjlnMgMFwv
	A1Qj7AD8=; b=KBINdmHKe2E+CteMYcLIGeLHECVh/6iy1DMA666uUk9HvLroNGH
	e0oyC7anP+73JlRLr2UENwW3CihAB7jAzr3yUNvckS4WNUQ32K/uTddJn08bZMTk
	LfkpJFCy8Kkb7RxTDpN8EJVSOaqP5svb61p3gSZB2vYg/WRl+FxLVRr9D7mWtH/W
	/j34ZlWa7k0ioXyxE3foKZmRqxoXL4wnWJZN8L3s9CPe98nGz4tjeyT4AN67PJAV
	7ho6sPvBW8aF/k3jyLEXmRGk9hYzURxe/CkHWOGQDgY9pwrDVY5pBpbNtnCWMgc+
	W3UPXbUmG3IzvCmvyAgHks4XqNVisxlPilQ==
X-ME-Sender: <xms:FO8kaH1d1DXkBPz2nP_ITqdLrGt6zA1jmXmf0MDbGS4_Ytla2ljGQA>
    <xme:FO8kaGE4nJRc_EvvkHN5N-6u866EsEbN6B5cszU6NYsAkH95LWoohFtWVepETHSxp
    Rlpa2wsIzEUbqrp7Q>
X-ME-Received: <xmr:FO8kaH5_96_W3boz47b61Y4FdJUov9Vh6X54TGgD6diozwNr0qI_88Fb4Zy82Po599F2tgFMaioeluVm_V9JhQInB5ieASQgf319OEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtohepmhgrrhgtnhgrrhgtseigihhplhhinhhkrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopegrvh
    grrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:FO8kaM3o91lpZNauqeWTZiqOVYuwcOeMZNZtXQOx87CVwmX7PSWoGg>
    <xmx:FO8kaKER9qitlZQCZJ2Lz6UmkhdvpyuLkOpLsJegEZHd3G_8BJ1Z7w>
    <xmx:FO8kaN_D7mPyE7ZjGQ9AU5ysT_U_SgVs_GQmWBtKf096eIp1OJ1Frw>
    <xmx:FO8kaHlR1Xb0CAhjanNhBEDSHuiqP6ag3i9ymYs5qgq2PT3arLkbpA>
    <xmx:Fe8kaPF_4-q0O5_JKniOS8Z8hstt7q_mn5v6wnRsPNKtEmIkS5__ts2S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 15:29:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Derrick Stolee
 <stolee@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
In-Reply-To: <874ixnjltf.fsf@iotcl.com> (Toon Claes's message of "Wed, 14 May
	2025 16:42:20 +0200")
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
	<69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com>
	<87ecx0ijqt.fsf@iotcl.com>
	<323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
	<xmqqjz6sb15u.fsf@gitster.g>
	<7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
	<xmqqldr789gr.fsf@gitster.g>
	<9109a8ab-d4b2-4ada-8969-bc72edac5ecd@xiplink.com>
	<874ixnjltf.fsf@iotcl.com>
Date: Wed, 14 May 2025 12:29:22 -0700
Message-ID: <xmqqy0uz7zzh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>>> I thought you switch to blame-at-the-file-level only when you are
>>> given a directory (or a tree)?  "git blame path/to/file" has ALWAYS
>>> done "blame these lines that appear in this file", and cannot change.
>
> I don't know about that. What if you want to blame multiple files:
>
>   $ git blame-tree refs.c refs.h

I do not mind "multiple files mean blame-tree mode" as a yet another
heuristics to tell which mode we are talking about, as "blame these
lines" mode would take just one pathname to a blob and never a tree.

But the topic, IIRC, was about how "git blame" (with 'blame-tree'
feature rolled into it) can tell which mode the request by the user
is about.  So you should have said "git blame refs.c refs.h" above.

> or (letting your shell do the globbing):
>
>   $ $ git blame-tree *.h

This one (with command name corrected) is questionable, as there
could be a case where there is a single .h file, in which case, the
command line would become "git blame that-single-header-file.h".

Again, I do not mind "even though I may have only a single blob
specified on the command line, I want the blame-tree mode" command
line option.  So to recap

  $ git blame path-to-dir	 ;# blame-tree mode for paths in the directory
  $ git blame path1 path2        ;# blame-tree mode
  $ git blame path               ;# traditional blame-these-lines mode
  $ git blame --tree path        ;# blame-tree mode
  $ git blame --tree path1 path2 ;# blame-tree mode

would work fine.

Having said that, I personally do not think of what "blame-tree"
does as "blame" at all, and there should be a better name for that
operation that does not use "blame" or "annotate".  So a separate
command that does not even hint it has any relationship with "blame"
(because it doesn't; in my mental model, it does not do any "blame"
at all---it just does "git log -1 path" for many paths in parallel)
would be even more preferrable.

Thanks.
