Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E7A1E411C
	for <git@vger.kernel.org>; Thu, 22 May 2025 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747946064; cv=none; b=aYpclPJMpSz4EkY3zG9r9tkn/pMGw14oQqgePyfeIg3/kUmbAy0VoOxWLWFNXxZH2l/KExVBS8K02wkbwakl4Xo+UXjTehIpYuGrl/+CFiIgiK/OdWXTfp4LdXWgUuVsyS0wnxsiEljBKms7Hvl7kYNvGknYK+tQt5WmJv4ZU90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747946064; c=relaxed/simple;
	bh=p7jqH/MLS97ys/rdsEnkN8vi+Ya1mygR4jjxnwBrDPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KBPXPcExlYBCD+2KTLEwSR9NG180rJdVsNwaY6LG+uBHhe7/2YiSe5REIw5sliH/FyV7v0tPXUJIfsVlN7Da7R4zk92uAVE9VJkECfHnJgoNxuLV9KYAkxoGEdYgG+UAcNOd6Huv11vmPsrIpMk3z1nAMl9q2O0FUO+ci3FPLos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aIa0zMPh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=slinoHon; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aIa0zMPh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="slinoHon"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7469D25400C1;
	Thu, 22 May 2025 16:34:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 22 May 2025 16:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747946059; x=1748032459; bh=7Fj+G5pe2F
	ZFrHk+dBDtUIH2evBoCgiA5/l9la5u/Rg=; b=aIa0zMPhF5EJ/7CisYgrQYKUrz
	BsN38lhLYFt6y7KKATb5eJrSGDEOaZscDBBMCemejbgAKlw/8jZ3kdWZmdIa6BNV
	DKBJjyeVPXC38WjHCjXWPNjA334LAQLjXJDfezrH8zy7TLDb7xD/VB0gWa8Ywnjw
	6wgk4x8HDBSZDR0dzIbEwJJcsT1Rc1ueLrVzyOCmBzORKTC1ZrGg5t1F9rbup07E
	MykNizYP4exqbi5l2a0AJ9Kgf4lf4RIgp/CqMs5OpiFtJEp1auUtAomEvnmG3DL5
	NKHwnku4oitv6w8KOPvNnQFSi1FAdn/MMknmyKeZAL9Uqar+a+5ncT7dx1pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747946059; x=1748032459; bh=7Fj+G5pe2FZFrHk+dBDtUIH2evBoCgiA5/l
	9la5u/Rg=; b=slinoHonwEUQjOr44N+1/S8XNUhsQcja5BAnW5KDheycTGnz0zf
	6U4R/Tc2xYrHT9Q1rLHOW+Vf7eDjVhXJXbTJaymGVf040TGGFDAH0O4LS8wU2cvt
	ik/w4bf8Rwt8MZlS8eJ6afEW8ySmX4GhgAQ7vcD3YGcKRFJHxyZ/3Ij6Ac1lNAVK
	EmpqShz7z5VtagXK+bQsZjcNKJ9qZMbxEVhXLuh8WAzAYIehApDGuLGCF08xMLgA
	XOCFwKEmYkpKHv0NJBDx80AIQowMsAwfA7+z/Sy6RQt9n6k2bvGC6umbrMsC51me
	+/HHHXTACZD7S5KcEZNQGI0PQ/4we26QPOQ==
X-ME-Sender: <xms:S4ovaFZq0YbK1Dni3RcOZR6IjF9J4uFf53d9WeKJzXVjSgJYhBbfbg>
    <xme:S4ovaMam8W-0gv2_XQJmNT_ddJB3PaN5bmwOPD-uL2kjjPJc10tpfiKGtuNpmuFKi
    24--Qe4uFNIttcbdw>
X-ME-Received: <xmr:S4ovaH8-oi8n9cO4-rjiNmrPfB_No-4fPv75iib5uIwcWkts0EALwOhQUB3IIoy7i9lPkc41VbCZL_CItJrqppp68Zp_MN7VZsSbUKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeileefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:S4ovaDoiMhAv29lL2c_gCorneP-CnQ8acVJvEv09etSCj2Os0mLPAQ>
    <xmx:S4ovaApz1AUDywdl9DoNCN0L4s-ZDszLeLRIgTUL00-rq4YZXUeCuA>
    <xmx:S4ovaJST7pTcXDgF9uEWH9Ub5mIp99FPf0H9KPpfE5-krHc35OC2lg>
    <xmx:S4ovaIpfOZn65_xw5JRGsq2vXnAtww8qtfvyns_RtUPtQpx78uZZSA>
    <xmx:S4ovaJ-xhRZYaAnvJ-q-u5IF8BbIY93TnYx2Xki9bD73n7fRY0FhWmOX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 16:34:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 3/5] builtin/stash: factor out revision parsing into
 a function
In-Reply-To: <20250522185524.18398-5-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 22 May 2025 18:55:22 +0000")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-5-sandals@crustytoothpaste.net>
Date: Thu, 22 May 2025 13:34:16 -0700
Message-ID: <xmqq1psg5qrb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +	strbuf_init(&info->revision, 0);
> +	if (parse_stash_revision(&info->revision, commit, 0)) {
> +		return -1;
>  	}

It does not look like this series add more code inside this block in
a later step, so let's lose the unnecessary {braces} around a single
statement "return -1" here.


By the way, what is "pwodd" I saw in the e-mail header?
