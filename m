Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8021FF35
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589805; cv=none; b=ZFDhDX0fgamFOPbk5KZGD2GMEfuLPoQaBsy9Xo/U1CaC6iR8aD9XoCHW1H01SXKQRbOIWifPAbQiFCe5Tnm5b55Ghw8TNN08Ae4xjlNQ/sePhlZf7NsilYtGt0f+G5sNNtWVQTghvzW9FEQXq87XQoFv9EztCYBXR0rRqTrM9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589805; c=relaxed/simple;
	bh=riQU8KcwDLQ0LcWQUaI5FKq+ZMI39eJYtxJcHlajpBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nrKsIuDwcO7Y6D4A3taS1xzurKLMTtEAQGAvUB7YnLztUXTZQMDqvEYW1u/fFTLLeJBG20kXFoMXsSQ4385nn0Za7F+1dBe0K51Z4HwkR/JmF6X68Pxnw4Pwhn/fj2bbKzqVT+7Xf4DAFb9RAq3+66lFvO+YQUDOhy00tBirQcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=efkd2tzh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=saE5qDrl; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="efkd2tzh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="saE5qDrl"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C0461400094;
	Fri, 16 Jan 2026 13:56:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 16 Jan 2026 13:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768589803; x=1768676203; bh=vs4r7jaNqg
	I9b3WBw09joG5/aw3gFQleZKEoObuGiiM=; b=efkd2tzh+70MyAWpxxCjUF+3Kk
	y6O2AkhWY6pViOR/mMrIG6zUjGLqf8d8jMxU5YyN8ziVxwz/WTyvxXZFiDxxLl9J
	39rlrzB2LViVCA0KRXJpmyud+Q1SnMGk+VyaQoBvXE0jmrIzRekMedJMK2mmOJ/H
	g4pn8LuVnkIVNxq40fXF/KLW0+qIKU6jNn6XmXLIFshN5T9Q8widOBAZmqwP2qmQ
	FLJolZaGdf8JS14XpF5t7yKgj3LUQo1uJoxa47phwva5pEreCXPOB56l8hyhft0a
	02wRZMGSqQ+IClm/uA92vwDLBx4GdOF7nj6gvd0U/5hwRjOm+o4ffUGkEQbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768589803; x=1768676203; bh=vs4r7jaNqgI9b3WBw09joG5/aw3gFQleZKE
	oObuGiiM=; b=saE5qDrlCYgB9yQFFoqD2t3X0u+oGPq74MlRvZdX3yphId2M7Vk
	n9fTF8UX0nkb6Z0uMG6KCzejS42qok1YWr2doHZWI8FTQ4Ly3fuJs6dkr1oOec+Z
	2TV3XKWsXtDmVhXAWeYg5+7VA44rt6CRHwMYJThhA77O+2UhCm8UfXNBbe2B1hwy
	EY5aLyxPvnB+Dcx4vAkbbs5boLeSAE4S9dBOYP27h7qB4gfKuvhzym1JbFYgl6xT
	J5VzXaPu3orJk/LtUlIaU42RCK7zdAl3g/cNthxUUiv/hhZcGQk/tyyvYS95ZXiR
	G/5JICyxxxUoF3BGnCHr9nk11M+CSrodBqQ==
X-ME-Sender: <xms:6olqaaDC0b71gQuIMb7V_4ZyB_or_vD_8i55IQOvo_9f1spH2pOQXg>
    <xme:6olqabhe2kLvLc2Ps6qGXomndiceezyaFmPYAsqe7wvvsdXLEyLpprYGaFzjFG2yo
    M6rt70ny4-LHbFJkTUUbuxJK-BD7-ugqRzA-iWZaChkzM0tU2ST40U>
X-ME-Received: <xmr:6olqaSmynfcEgIeRH8Jqx2QIfeoX4dQFfbvi9f-3gYXYAzARBghelqR3421AQRbhUfjIYEl_xSiPEPQFReqtFdGQhSVea474ZVqAyEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithdqphgrtghkrghgvg
    hrshesghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:6olqaXq_IcHxbCAlWFnC9P8Eh6DL0GDkoyiibDPkAsdJYaMsMXoK3w>
    <xmx:6olqabFYH4sN1-Lb1ts9V_cKrTol337pQUI8lhn7tpHGgMI2Okm2Xw>
    <xmx:6olqaTwXyvUGL8box5IyZ1WO5CvgRhPZLIhheJjuqDFiuYqwvhWOcw>
    <xmx:6olqaQrgJjN4-rWphgCQJtTg9CzoOa7_4XYNGs2AzjzeA9EBC3hO3A>
    <xmx:64lqaSrj66or9L8az4vpEdsfYQQudJrdTxWR9SoIjzZfS6a2KWmh9WFG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 13:56:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git@vger.kernel.org,  git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.53.0-rc0
In-Reply-To: <1MbzyP-1wEj5N1dfD-00evZm@mail.gmx.net> (Johannes Schindelin's
	message of "Fri, 16 Jan 2026 16:30:36 +0100 (CET)")
References: <1MbzyP-1wEj5N1dfD-00evZm@mail.gmx.net>
Date: Fri, 16 Jan 2026 10:56:41 -0800
Message-ID: <xmqqwm1h75ee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.53.0-rc0 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.53.0-rc0.windows.1
>
> Changes since Git for Windows v2.52.0 (November 17th 2025)
>
> New Features
>
>   * Comes with Git v2.53.0-rc0.
>   * Pressing the Tab key in an empty line in Git Bash no longer causes
>     the session to "freeze".
>   * Git for Windows' installer is now built by InnoSetup v6.6.1.
>   * Comes with cURL v8.18.0.
>   * Microsoft Edit can now be specified as Git editor.

;-).

>   * Comes with Git Credential Manager v2.7.0, the "anniversary release"
>     after one release-less year, which brings native x64 and ARM64
>     binaries for the respective flavors of Git for Windows.
>   * Upgrades the memory allocator mimalloc that is used by Git for
>     Windows to v2.2.6.
>   * Comes with the MSYS2 runtime (Git for Windows flavor) based on
>     Cygwin v3.6.6.

Thanks.
