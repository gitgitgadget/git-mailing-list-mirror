Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674D243968
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573646; cv=none; b=HT9o0nY/QmZdhIVQ76HAWXygJfWOITfN/f8z9jBx5buwCcRtWXF4SG43TqneNI/Zb0AfOh++OkKKzj51UgrgR/QEJZInQOBGHC/GtRUFdEw7/pi6t06A3DQJbpVXe1fydWjT7/FLLBZessioOIv0DakDNIapV0dN5xPggcwDFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573646; c=relaxed/simple;
	bh=I5TdGFU4+22kbbWVMANNol5rtcpFaX8aRp5hPk8eRnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G8HWYBKM/XSZrVcMfeB005K7wv0SJMoBz/ba4dCFKGZUxA8BGCdjKauHqvQMnIIz0uHcDQyRx+3kS8ZYRqsD38eD+4B0pC5b0hiX7/+fn2ZqLQziOjJCDIY3cAW2BZuFDF6N2xgXI37/Tc0fhhCbKuaoqvZ9J2lRjyQVU3UgBa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q3jdDH0r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WveX5mPl; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q3jdDH0r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WveX5mPl"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4D991140139;
	Tue, 10 Jun 2025 12:40:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 10 Jun 2025 12:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749573643; x=1749660043; bh=xC7IGuIXiw
	WZX1hB7sAo5lDNFJrc+vXZ3sn5tQI61qg=; b=q3jdDH0rE6eBqMA8refOKrevko
	W1Lhbx6tpZTZRJgCqXjKdMtZbfP/QA6WxtuK0z9hMVc5JvyVZLo6fDOz7dRdMMdI
	YCOZ50OkP38Fc2Umz4CXFxm5ZSrmBZTNUQB6zW5KJ+Ql86lcXHXRWeGXJo5brcry
	0cmPnXuw+Stpw+VJhYBKpTRVyoaQOcSsV0/fWxIQS9W/yipDLtUgzwVZNnlmsTpU
	kmEFCgtBf4ba8Us06bgp44PLcL6Qf6gmr1D9PtR9NIeBMcEhdjQ/+Wb59PsGMxNw
	r7dIgn5c+4ubHCVOPZJfincBIQmhhWMRhawT1BEMz0TDAU05nIa1Tc5J1N7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749573643; x=1749660043; bh=xC7IGuIXiwWZX1hB7sAo5lDNFJrc+vXZ3sn
	5tQI61qg=; b=WveX5mPlfCm3yFIZ/ZLQNLnYiJm8QOi6gn4UhqdAjlp5awhWCwF
	V+dx9d3o4fmvce9jfEJAlSIDzrnaAV1a2NU81aa+NM7+jrwykCanpVyX3nDWzY5B
	K8WUyTY2Sb7ScJXLRX08G2I/NasfPaijblldSJFALpfHynWwUR3GajOryvZlr+Ps
	zxz264nfBBJMsh0W/3OzqYk+boZ09LviyUxEIkO5IPMa3UUzMKa5l7p8Rj7XwxBm
	dvvQdFn6IDDzQdCtTNo67VZxpPKswN1lYhw9koT7fmXFIfMNFkYzgbenuf30BSXZ
	OQcoOdA5apbz77kMIo7J5bIP4Six+BPv7TQ==
X-ME-Sender: <xms:C2BIaOVfcXFyUdKL82M0oHZKTVLWmFgOSRmkHfLtQTGGV2NEVgHMbw>
    <xme:C2BIaKmuf257qwx0OAaVPtzKOtriGC2b7U5jEQ0oWAHQvccKCnFxLhAB8oYkcIqLF
    J46KtnwNt76irR5Vg>
X-ME-Received: <xmr:C2BIaCaMdUwVpds1YXiKt3l4PA1gFWyQPzylpbLq9TKABwjTt67lkBiuXsg9aKAIrx0hcjup9hKb1AgmNse-t75tp348rSNTiTkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgtrghsshgvih
    hkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:C2BIaFU84pWoKkDQhzEexGojcnynBvnql2joJ1zHsjJETxHWYKYkyA>
    <xmx:C2BIaInSJ6THjTumJgcavGBrcuqbjLfdmYJ5h5oqn090v7CGBCr5tA>
    <xmx:C2BIaKdWThFaBqUcR8ZJICJ60eXf0mMCjav1UGyuyGsqxz3lNvKZnw>
    <xmx:C2BIaKGAxubSMa9nYKILMa7tfapqSEzTXzlzPDfxLxgXCPNkuhvqYA>
    <xmx:C2BIaF2FCicU-XehDCZLbbwmTpO8dbERG0A8R892DbKPOlIz_0rblnrl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 12:40:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com
Subject: Re: [GSoC RFC PATCH 0/5] repo-info: add new command for retrieving
 repository info
In-Reply-To: <20250610152117.14826-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Tue, 10 Jun 2025 12:21:12 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
Date: Tue, 10 Jun 2025 09:40:41 -0700
Message-ID: <xmqqikl3mtx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> $ git repo-info
> {
>   "objects": {
>     "format": "sha1"
>   },
>   "references": {
>     "format": "files"
>   },
>   "path": {
>     "git-dir": "/git/dir"
>     "git-commom-dir": "/git/common-dir",
>     "toplevel": "/git/toplevel",
>     "superproject-working-tree": "/super/working/tree",
>   }
>   "layout": {
>     "bare": false,
>     "shallow": false
>   }
> }
> ~~~

OK, that's understandable, other than that handling of trailing
commas looks somewhat inconsistent.

> Or in a plaintext format, like this:
>
> ~~~
> $ git repo-info --format=plaintext
> sha1
> files
> /git/dir
> /git/common-dir
> /git/toplevel
> /super/working/tree
> false
> false
> ~~~

This one is a bit questionable.

Is it safe to assume that we will never have to deal with payload
controllable by the end-user that can have arbitrary byte values?
It would be uncommon but possible for LF to be in one of these
pathnames, breaking one-line-per-item assumption you seem to be
making.  If one-line-per-item can be assumed, you can certainly
claim that this format is easy for consumers to handle, but the fact
is that this format is cumbersome to use safely if we have to deal
with end-user controllable arbitrary byte sequences, and if the set
of info pieces the repo-info needs to deal with changes over time.

> It will also allow the user to get only the desired fields, like this:
>
> ~~~
> $ git repo-info --format=plaintext objects.format references.format
> sha1
> files
> ~~~

If the user asked for only one item, this is probably OK, but for
more than one items, the same comment applies as above (except that
the number of and order of info pieces are known in this case).

> or:
>
> ~~~
> $ git repo-info objects.format references.format
> {
>   "objects": {
>     "format": "sha1"
>   },
>   "references": {
>     "format": "files"
>   }
> }
> ~~~

This one is OK.

> - on deciding if the JSON and linewise plaintext formats are the really the best,
>   or if I should consider others (e.g. gitconfig syntax, NUL-terminated, etc)

"git config list" and "git config get" may be weaker in handling
arbitrary bytes than we would wish them to be.  As much as I loath
JSON, the format is widely recognised and supported, so as the
initial cut, it may be sufficient to nail down the schema first and
then worry about emitting the same information in other formats
later.


