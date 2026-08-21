Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C7A38398B
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333623; cv=none; b=AtM75SBgxoZwDRKFhfrXDizxZQzc4GLZ004c3OsdplKtb1VOx7BGqr1aZNSyLWxbKyFRnoOkwpuZf/jyWXTrSy+96He8LUP7tElCinaE+wEf/NWs6IV9ZwosZEjxx8oLgHQBrE4aHRQTepRDOCD3Kxv/LP8WLdtgtG1jvg7p2ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333623; c=relaxed/simple;
	bh=aIQbAStLzZD+7pyde/vjgJcoHjk4zbPuhYhmjZ1fr00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kvqRTCyJxRnCeTiXI3JMCT/h5lH0RKg+QqVtK3sSq5zrk+RTwpx8h5/F8LL7CQ9Fwfrb79x79MUf0esBUN+EpKQyQW5rxayCHsk5P71PT/JFVOvnZ/KZVsy8rpOjSSfMUlZPCnHdlSCGmEhdX1+NbohntxiILi5igTy9e0nK2JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wy6LRj9y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N1urGwiJ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wy6LRj9y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N1urGwiJ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C97BE7A0104;
	Fri, 21 Aug 2026 13:33:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 21 Aug 2026 13:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787333616; x=1787420016; bh=aIQbAStLzZ
	D+7pyde/vjgJcoHjk4zbPuhYhmjZ1fr00=; b=Wy6LRj9y4MZQ04a1Spkuci1ULk
	NdXjSZmycyM1BU4woQUrJ5Jls9IsZ1PmaHy7drzSpiX4OUIJfNsOdF17aJqARARy
	vY8TMgzEZw1H3LULA9bnFsggLpBJJVVtC4JRguP2pU7XqMXSW5hMjT8+BqRHBSCN
	PiF7R5h6CBmmE9LTDN+nzyH0i1KRIHY1osLgOyt8WDZoqd4wmKBc3vl08bugIR6v
	WwsnIbwvYkvDB+BSVh79DTbY31Cd1xdi5669W1pFnXV5rBaD8QEPqTFulbkBt7DR
	JsMAvunbc01iB/1i1fo4T4OyA3YeeuA2z0e+MoMErm2qGQLIket5609iUiPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787333616; x=1787420016; bh=aIQbAStLzZD+7pyde/vjgJcoHjk4zbPuhYh
	mjZ1fr00=; b=N1urGwiJFEYgZf4NEljf3Cy8fGl9LJOvPyvwzNeH57B6R40EPEY
	K+mynmoFWVBu3CjgrDtf18CgNWnNCwPBXL6/SLDxE3SXV6iPdRxghaHS9UP4gg1+
	kBuYQQx5XGsVifFVCRxOxSRe5iugRBPtMBPgxwhk3i6hKW0cy3zfr7dV4pyIGNJv
	7eU0WBvGQqIxE8NejkPzgDwZJMp9Vn85rReJpNrzSVqhta1v2SaBOjABkaYotNaa
	T9IPMi+jk2Kwo1g77iRr6OlZc33gsWKx35Wx8DXRh57jB16eElFEcqCWa3P/NqwD
	EhblaPhlrW460w9kk7za1hekfRDfTmtMvBw==
X-ME-Sender: <xms:8IuIat2t5Rbty3dxzHOtCpgv-SrBG_ibdW4DmkIfqjfnYksYTmW6pQ>
    <xme:8IuIarFV6mokmNuAePbQ3Cjbz9_qQbp7URDEPHI3hhL_uKNSoMXchqrv16ffj7vCV
    YoXxk4wwzUr3cXJBBgC2m78Hh3o6hdGH-GBPIfvuTashKbAjMRITQ>
X-ME-Received: <xmr:8IuIai6Q2fkCsfTFiHP9RRUwKoW7kTgd15U3ndU2lJTEz3_ALpy_YB4tCAt7HPeNan8QG4Ee4c0vJQA1Y6Smvg3I9ucTNCTNgg>
X-ME-Proxy-Cause: dmFkZTGrDQuG3f7hLdfklHINBUk9wLyoUu7oSEQKf+bhDKiP5Nkl7cSh5OGjuZEuSTnxpu
    89eMSOgMCDAGitoAxhS7nKNL45rqeD+qLpiYj4MBNSm49ATZ3PjVKYPxN0zXmodDRJzAn+
    Fk/2qO2Gs1H+wJqiiakl3v77k+6plmSgBK3pP0gCPZ7nuZxQ4I6iNS57YgTbvneoiyMeqT
    Cgt3yXsYvdndZftn5c+ZSMOr3QHYwI9FnjSH+6XOW8IMmQT6jdglcZhxw7hBJyOGgbj2hK
    oj9xpYSE5gu6CqDnASTEjbxDIpdT2xNAQqMtEQqfiSYpPY3/kwcPkPKjolVletsIxKsGZM
    RjOnJqvFmi6/3A+6MGD7RV4nU9UC37wMdULzUEmWrsqY/rxUF5CC0Yimh0fEDo8B6iO+NO
    zVeNkuNQMsdGNHkXYSvHv3VE+TQgCFXBCDVY78cmPXTX+LBqz5wqgIlY5PR3yxX17nqRat
    6eFQa1aGZ3MJ3miPr+R1V0BLqyOwj5+lPO51sgz5EvTswHhfN/w7uLMvdgUnzmZfBUMJia
    LW3YzYR0h8f9Pd+wOr+moGxsPHwvhXl6CbLMcrvCg/crpH8P6uL2GcoF0l2GOC1mbKwNAl
    sHi3ZuGXtGelZcufrCUKimj68A9YiMzV9gfrAuLiqleU3vwwHGK6P1GLOiGg
X-ME-Proxy: <xmx:8IuIapvFs4Cgag_MpDhEvs0JVzVDmzSTp8VtMV8_eSeb_nQNhuzx-w>
    <xmx:8IuIar6aOZIc5qzDnZQaNu7td9i9_60I9frVjme4KsRuKn1Amc7lxg>
    <xmx:8IuIasXkS71ufsFDHFZ59Dm6VHdaI0-E-UJt1yGBbotovrlHjqsEPQ>
    <xmx:8IuIal95YAxfkELzVCaiBnCaole3pPJqLXcVwkQivexyJ4oLr1b8Gg>
    <xmx:8IuIauZ7E0V8qUqeZcpddvfOMe93BOq22-8OWaDcMfQbzXa8N6MZhJzh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 13:33:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Alexey Samsonov via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alexey Samsonov <vonosmas@gmail.com>
Subject: Re: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
In-Reply-To: <pull.2209.git.1787322203.gitgitgadget@gmail.com> (Alexey
	Samsonov via GitGitGadget's message of "Fri, 21 Aug 2026 14:23:20
	+0000")
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
Date: Fri, 21 Aug 2026 10:33:35 -0700
Message-ID: <xmqqo6evpeds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alexey Samsonov via GitGitGadget" <gitgitgadget@gmail.com> writes:

> utime() function for setting access/modification time for files (and a
> corresponding <utime.h> header) have been officially removed from POSIX
> starting from POSIX.1-2024. While existing system library implementations
> still provide this function for compatibility reasons, its implementation
> may be removed in the future, or otherwise degrade over time. Some newer
> libc implementations (e.g. LLVM-libc, currently under development) don't
> provide utime() function at all.
>
> This PR switches the git codebase to recommended alternative: utimensat()
> POSIX function (which supports nanosecond-level precision) from <fcntl.h>,
> and, as a possible fallback for older systems compatibility, utimes()
> function from <sys/stat.h>. It also provides the corresponding MinGW
> wrapper.
>
> The alternative is to unconditionally use utimes() where possible, but given
> that utimensat is available in glibc starting from 2007, and on BSD systems
> since 2012 or so, it makes sense to use the newer variant by default.

I hear that Apple has supported it since macOS 10.13 High Sierra,
which came out in 2017 and reached EOL in 2020, so we should be safe
there as well.
