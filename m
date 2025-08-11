Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B8F288C14
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956725; cv=none; b=WYCTn/cnEG0UDlcbsOjI51TAZu3Kd1kbL9erdnhIf8nk332TQIMwwwFm8ambQ2KXKS8kC198yJ93qezHVukvlRHCScWz8pkeWuGrzuNgRqfQk1puq2pcG82pWuy53hg5m8DWdAH6TEhLiDpkJ2BmgC3IbgPqQtl0fOyrDT6AN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956725; c=relaxed/simple;
	bh=FWWs61nVG2Z+mSaPcP7ukJJO6Qsom6rFmwfnHXGFyGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a516Z62Nxgb5jN6Z3Hof7Hn0YPM2V8rZoFSONGxrcdf9YSNMP2a0aBw6ixZeIhi7dFtbomc6EmRKL+rAub0HngVbpAoOdn2wGPd3nJJ4wpw+ljLVsE6LqqakvfdrL7YVQFMPThdcKA42HTu8pLBOS5p7WVaxjLO6QOogrHZWl68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BDegPsar; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ItiyOGS6; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BDegPsar";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ItiyOGS6"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 42C2F1400179;
	Mon, 11 Aug 2025 19:58:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 11 Aug 2025 19:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754956722; x=1755043122; bh=eKnLeB/YQD
	qGTnmmQN2I8fTmk9LLjNjWMGIZJ0aOa+s=; b=BDegPsarD3Ug4eeQn32J7fqtzN
	fLK3vYDA8qZWo9Gaz5idyp6azOL/vpw1fitugvS70YNKd6i4bYIMNV7rYDKwKnll
	sN+jRIomnMF/DSu34puPmF7BzF0CEI2RMT6nc78QyOty3XzCagm6kZqYVYJJkh5X
	xrFFuIpwsMj+bHPER8QO2E35jyBTRIp/nqQo5zQf0h4x2W76O9RYhGCQsVUqmQMP
	bAOZR6uWw7BvQGmmS+Me2i19FSCWcBxJrUhqZPL1pun4zDRy0E3VFCer2rkvULCs
	K0J/grayJjidR8uxm9pIzwn9KGl6TbccmZv4XHfroI/3AC286HtzDvfLDSGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754956722; x=1755043122; bh=eKnLeB/YQDqGTnmmQN2I8fTmk9LLjNjWMGI
	ZJ0aOa+s=; b=ItiyOGS6kSuFc7sJ1m9hB3pPUWfXbVE7Kqak9nGigNhsUqYQpDN
	Xr7Va/nFiAyWAl4DD+pDT0CA1lX+71kj4KxJCkM7sfnioJZ4W+BUdj/w+ABijI2X
	CRd9OmhwY2Yn5Zr1QZJ6R45Y+9exgymPzxEFpIwIlksM46B5U+km50xHuQ7XsbqP
	e20PiHOsYeGcVpiM1brZyZ4NfI6QGasTASqaj0kOSkUxq/UiTQ9LWzGJo9OEqrHN
	miHcU82MjyAJNQ+1yuDAZJUKHi2ZR0sBoQn025UMp0jHcZoyb83K9Wgi6llzkYXO
	OKAkodVGI094zHUDl/BaSaZpj4WCZy+K4hA==
X-ME-Sender: <xms:sYOaaG5BYKTGeCDqUFyA5_hU4zyVR_qKv9Wph56L9ToneudP6xucjw>
    <xme:sYOaaLno0qATIQGxbU1o-1gr6ifvZtvkctrsxwG6gjlK7V4sxifrnpjfYqoswYpKH
    zICJ3AoSwjFlUwrpw>
X-ME-Received: <xmr:sYOaaB5O5B-SU-Nb1LGnnf6lIv57mFMaCPbnaa8DbeSctGgNBdkbjUDXfDXPPk6UyoPcGaHsMkXj1r4DEftdwbzYPr3ZWPH2UwWFCos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrlhhvih
    hnfigrnhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:soOaaMQOKhbrj3gO1p16VMuJK8AKl72Nd2L2DLo8IQU9oLZJ3Mx1_w>
    <xmx:soOaaPzY3qaUo0YHx_sNFjjJmcqPuoEOqyx_d-gm0543I3jE_Twr4g>
    <xmx:soOaaEo05Wc5zZIRAqcgSCkmTPlQ6zycnkDX0mNyqM9_AyAoHjDBjw>
    <xmx:soOaaC3QO0wOXGRVg5fNgWkGjkVPWDltOhBB8GfpHoaRRivxtGQ8rA>
    <xmx:soOaaJlUy8OPv8jxC6W8OvWdFR1mtGE-eox8SzK1A3QURHAYCiNEI8oE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 19:58:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Elijah Newren <newren@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,  Calvin
 Wan <calvinwan@google.com>
Subject: Re: [PATCH v3 4/4] editor: use standard strvec API to receive
 environment for external editors
In-Reply-To: <CAPig+cTXuTaMd1+sbSSDNbGKxxciyxAT3LMk44aSaimPco8XTQ@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 11 Aug 2025 18:46:38 -0400")
References: <20250810160323.49372-1-ben.knoble+github@gmail.com>
	<20250811221706.67168-5-ben.knoble+github@gmail.com>
	<CAPig+cTXuTaMd1+sbSSDNbGKxxciyxAT3LMk44aSaimPco8XTQ@mail.gmail.com>
Date: Mon, 11 Aug 2025 16:58:40 -0700
Message-ID: <xmqq8qjpz9zj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>>  int launch_editor(const char *path, struct strbuf *buffer,
>> -                 const char *const *env);
>> +                 const struct strvec *env);
>
> Typically, we would want to have the API accept the narrowest type in
> order to remain as general as possible, but this change makes it a
> requirement that a caller must have the much wider `strvec` type at
> hand, which seems counterproductive.

Yup, very good point.  I do not see the point of this change even
after looking at the whole of this patch.  It is not like (being
const) this would make it easier for launch_editor() to further
tweak the environment.  Let's not do this.


