Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A7317555
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733190382; cv=none; b=Grgfq77NK+DFhAvuE9XJx6ehWIV4/rcsbXjGkuXxbOWnmlJ+V1PhPzF/bXaTtE3J6dzNVcH1hvzaGfK+t52wVd46X42Oo/eG0UP/d8wYUfjlPByAn2srhRw01ybUQeQa6yGW3Jk1zkrNjUv3AemSr8j3pWhhGw+0C3raEAnjceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733190382; c=relaxed/simple;
	bh=Eb72SbXL+jVbSbJCmBOAfXLqlY4IqZHY8VTNq4SKLYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P+aeMh51GaxLD5SyW7V3RDjrHVjZQlqJsUWXhRIU+n6kL3xDEx1wjlNItgn4vFsWLDAfSnxP/VPs6U+tAiyZWrbxd3HUekzLapj6LAPDo3uhymO8KAjJY6XxXGTG8oZzgm7jTYYU7R5uR8MRQ4l0CmpyC/BGsS0xem0oXBQFsyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l7dARiZD; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7dARiZD"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E794E254018A;
	Mon,  2 Dec 2024 20:46:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 02 Dec 2024 20:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733190378; x=1733276778; bh=UvbmxpfZb7Gb7yd5wSVpMlj+m3KptTswe7C
	u0I5a768=; b=l7dARiZDujuR5j9IzgbP4sGcpzHe4WVQMfRlGxUx6FYHHG9T/Gq
	mggo4+IA3ybm56gQI1lnln4gqPAU94N1VuFHEnp4KRspKBaVRO/AMWiElLAYbRhh
	JF4+y4WIIEjsb+Lkjpxh5mGyhmTt4qACjBjAi3iYXmCdyd2Qp85iKD1suBcnlhZi
	5ywpaqXf79bc6TsJSni82neqosbbNsKsSNWMc0SpxZvi//MFSN6Y3okwPR5zXv+J
	ZQTtfYOtiJ9T+oh341mPDFEpE9a2Iz1WM/75T0bQkhWZn4U3831MvQFdka7FQ8rs
	f3Q0TlMLhum1ZDV7PX09taRsy8Drmv2wVvg==
X-ME-Sender: <xms:6mJOZ8D2C1jllQ41ZmC2MwC1-UyVUgZkGSDtXbQ3ygR17uW3h-COpg>
    <xme:6mJOZ-irvn1nDiUf2wVzISumj5cz5zMH-sbeopQwFRreNI5kTxe7qbejrHpJS3rl8
    eDvHoSdzZ2Mxr91_g>
X-ME-Received: <xmr:6mJOZ_n54XmBv1Q70_vnD0ViqQn7p7f-esXT33xZ9WnizzByFPmPvGkpQYDXylVYapQnrOf3srdPRjagbWipORf7iV8QPX8U2YXv7eU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghi
    lhdrtghomhdprhgtphhtthhopegtugifhhhithgvfeesphhmrdhmvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:6mJOZyyRPJDXGpMv6dUXNIjNOSPXufPppVIdJdg-wbhTG_fKJJievg>
    <xmx:6mJOZxQcCw2Y9XcVz6b5dGoAHbZW5BpDqJBCteqXQU-rYw5S6Il76Q>
    <xmx:6mJOZ9aIS0TldgRmEvnK1iGYnBcgXW7lb1kNBAj9pZP4K7Hn9KvQcg>
    <xmx:6mJOZ6QY_xyRDFb-cS8AD6UaJ1H2bD5YZ9QW5Ij5vAVCac4QvtbvWA>
    <xmx:6mJOZ6L6wiz9GIIS_p7sLgh_UffOFBeV1vflMC49eWtVBSU6YUgiZNnB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 20:46:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: shejialuo <shejialuo@gmail.com>,  Caleb White <cdwhite3@pm.me>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
In-Reply-To: <CAPig+cQHW9=A5ejU5aZ+Wy0uOQsLU_uqUibeYzZs2PXK37Vpbw@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 2 Dec 2024 19:56:01 -0500")
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>
	<xmqqed2qkfn0.fsf@gitster.g> <Z02eKA8i51QyXgJ-@ArchLinux>
	<xmqqed2pioff.fsf@gitster.g>
	<CAPig+cQHW9=A5ejU5aZ+Wy0uOQsLU_uqUibeYzZs2PXK37Vpbw@mail.gmail.com>
Date: Tue, 03 Dec 2024 10:46:16 +0900
Message-ID: <xmqqo71tfsif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> Unfortunately, I haven't had time lately to follow all these
> worktree-related changes or discussions, but perhaps shejialuo is
> referring to the ability, from within one worktree, to mention a ref
> from another worktree (which is a feature Duy added some time after
> the initial worktree implementation).

Ah, yes, that exposes (and has to expose) the worktree ID.  It still
does not have to be unique across repositories (only has to unique
among the worktrees that share the same single repository).

Thanks.
