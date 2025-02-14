Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E61DC198
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739570857; cv=none; b=XKsfX6jCNEfHJtcOk0YZFFwEoG4vtqyg19mH+DvfJiVrGHso14VL80EH0n3A8uszANrGpacBFRbDpvMvWvnUSme8Y7p5JEUbG7q+thbgN5Yj62xoZrvGegKn7zQUavG8827RBGi5T9uZQGrJ90TFGS1MIanaFWJBclH/hGZJrgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739570857; c=relaxed/simple;
	bh=bCcYlxZskX6CfBmOjCPr08yAw8P/Xss0DJhhnvGt9JM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HmyWAk7PVFAGm13Y7iziX+ADoUcTNkLcFiNz9rG52DE6Skif9IPcu6RuPeGkD+5L4AxdsldUK4f9xnvQK5AXxJMzgacCAw3+hsv/bEemYuD8ZPaX4DwyHudI5WQlnF54KTbyPQ0lCcrIWIXplZ+/NtnYEzI4xil9x1A7Etyu0mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QSNAkZSr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CQu/P8I/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QSNAkZSr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CQu/P8I/"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2BE4F1380871;
	Fri, 14 Feb 2025 17:07:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 14 Feb 2025 17:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739570853; x=1739657253; bh=NhK8eArAJ5
	nPRXSRrsptY1lGzx+T7Ep/ONdZEdbs/1M=; b=QSNAkZSrNeWaoMFPxif3QZCy5e
	zv5XhBEtgbaSAa5ehoS28rA9viDNO0b3y//zjyp3ME6x7iXd52QPMgtWqDx/nMQO
	eLno1CNBLArxzoIPtsJK82eGfFclVeyF1kzXM7UVVgigynyAsWVK+QrMPtB0kxtY
	0hyGO+B1h0jtFN6ou3GKVY9r1nIf9gwsr8E8rDGh/lzDbSucjb+Aytv6u06gvNAA
	gg5KOzVU+vW+9C86Ey8CG1OsuCAZUJ60VK0s1R+ishBY50AgzYUP6G3uQv+n1Ef2
	zDbrK6WHdw30LVYR7SNMwsrrDZbEtQmzqYdWN5FQRETe4hXOHhS8HYMl5+sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739570853; x=1739657253; bh=NhK8eArAJ5nPRXSRrsptY1lGzx+T7Ep/ONd
	ZEdbs/1M=; b=CQu/P8I/DX++QbqMWbvWdecXxhMPSLhEAi1GXZcMLcSdpqwCDwo
	XPSNOuJVGWDyKxXA6VtW2mvBYmHDntvvJ/Aq45IAngKtNUwiAAfkC1jO+L+crQPM
	xtyYWknJkkCDFsQwYzM5RFLBHRdrwORFX+gGfn1KW/5QyQ+efWv513g0R6EupwuY
	zRxTBaqREX0CNQ9knMae16UJTMBHfbrvWQvBRC53s3fFlljz/JwVE06+7l2PUsHl
	aab8I/4l8yV5aT2V2JgxDjGlbvCX8TDEpdKK7mNC2QU4q+ZiuDuDtD1QHPZWD3IQ
	us56hSyqv9OMZH5IP5JHIEY38ELL9qM5F0Q==
X-ME-Sender: <xms:pL6vZ49Y3I9JQldC3dhhZj0H5I-HVPzVK-fNcaS57wO1Aa7qgiXC0w>
    <xme:pL6vZwtLLCZzenvA-XE4iopql_rAOcMKIKHnB48P_RqrFYMH6CGcGDYa3gab2Hd9H
    tAs6PXZ-Q9RtLYeeA>
X-ME-Received: <xmr:pL6vZ-AtzLv3aQhcUBkmn7zD8HkjH5L5NEJkE4y-jnmHMb_e0n4BDMiDjCJ6EBAX2anubDRqGCtIuxUlQkc5Wac1YiFSTtJUmW5tpfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgr
    nhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:pL6vZ4c0ijaJz9ZHuA_1hogV8EIra0AArlhKyFOkdpqorcGk8seGpg>
    <xmx:pL6vZ9NrwR5ss_O88GW7y1z4dZbF0R2NDutrZUQMSZULUywIk5bIiw>
    <xmx:pL6vZykXpcAxWC0S286q1kF1U-OhCnzdrDyuVxR0CQR4DgxuzB6Gqw>
    <xmx:pL6vZ_tDg7M_7ZEy-qinAhHxCNKUAXZOrLYhLGKE3BfrPfIdHVmlBg>
    <xmx:pb6vZxk5RC94jXFI09NFSemIbiQxbIUY3vWX4fgy7DJ3fWcbaBeBv4SZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 17:07:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  Johannes.Schindelin@gmx.de,  johncai86@gmail.com,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  ps@pks.im,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 6/6] agent: advertise OS name via agent capability
In-Reply-To: <20250214123734.1403120-7-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 14 Feb 2025 18:06:16 +0530")
References: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
	<20250214123734.1403120-1-usmanakinyemi202@gmail.com>
	<20250214123734.1403120-7-usmanakinyemi202@gmail.com>
Date: Fri, 14 Feb 2025 14:07:30 -0800
Message-ID: <xmqq34ggkwnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> As some issues that can happen with a Git client can be operating system
> specific, it can be useful for a server to know which OS a client is
> using. In the same way it can be useful for a client to know which OS
> a server is using.
>
> Our current agent capability is in the form of "package/version" (e.g.,
> "git/1.8.3.1"). Let's extend it to include the operating system name (os)
> i.e in the form "package/version os" (e.g., "git/1.8.3.1 Linux").

Shouldn't this be "git/1.8.3.1-Linux" or something to avoid SP?  The
capability list in protocol v1 is on a single line that is whitespace 
separated (cf. connect.c:parse_feature_value()) without any escape
mechanism.

	Side note.  Does it pose a security hole, when we can set
	agent to any value?  I do not think so, as it controls what
	this end sends to the other.  If you are attacker in control
	of your own agent string to be sent to the other end, and
	use a string with a whitespace in it after "agent=" to claim
	that you support a capability you actually don't, that is
	not a new way to attack the other side available to you---you
	can write your own Git client to talk to the other side to
	send such a bogus capablity list anyway.

> diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
> index 1652fef3ae..f4831a8787 100644
> --- a/Documentation/gitprotocol-v2.txt
> +++ b/Documentation/gitprotocol-v2.txt
> @@ -184,11 +184,14 @@ form `agent=X`) to notify the client that the server is running version
>  the `agent` capability with a value `Y` (in the form `agent=Y`) in its
>  request to the server (but it MUST NOT do so if the server did not
>  advertise the agent capability). The `X` and `Y` strings may contain any
> -printable ASCII characters except space (i.e., the byte range 32 < x <
> -127), and are typically of the form "package/version" (e.g.,
> -"git/1.8.3.1"). The agent strings are purely informative for statistics
> -and debugging purposes, and MUST NOT be used to programmatically assume
> -the presence or absence of particular features.
> +printable ASCII characters (i.e., the byte range 31 < x < 127), and are

Patches 1 & 2 redacted non-printables and SP separately, because SP
is considered printable.  With this change you are allowing SP to be
passed without getting redacted?  I do not think it is a good idea
(see above).

While I'd prefer to keep the range the same as before, i.e. "any
printable ASCII characters except space", "33 <= x <= 126" may be
more readily recognisable that we are doing something unusual, as
"32 <= x <= 126" is fairly easily recognisable as "ASCII printable".

> +typically of the form "package/version os" (e.g., "git/1.8.3.1 Linux")

So, I'd suggest using something other than " " between "version" and
"os".  Dot (as if the byte there were redacted) or slash or dash or
whatever, anything that is not whitespace.

> +where `os` is the operating system name (e.g., "Linux"). `X` and `Y` can
> +be configured using the GIT_USER_AGENT environment variable and it takes
> +priority. The `os` is retrieved using the 'sysname' field of the `uname(2)`
> +system call or its equivalent. The agent strings are purely informative for
> +statistics and debugging purposes, and MUST NOT be used to programmatically
> +assume the presence or absence of particular features.

Other than these nits, I find the above very well done.

As to the additional implementation of git_user_agent_sanitized(),
except for that same "do we really want SP there?" question, I see
nothing questionable there, either.

Overall very nicely done and presented.

Thanks.
