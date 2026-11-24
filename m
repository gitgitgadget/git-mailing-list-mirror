Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551307;
	b=Ybp1e4BQ3Ym4RNTGA0eGOWWTix0TmfdicXEgzyip8iJZWJnAIifHJNA4LR/CsDPrRkTk
	 dj8omsdylZlw73f+if/W01bd8Q/GSe/ZgdizeWRFD/FLQneu3U1ASNA71WkypIoW1mLTG
	 lXh6d8w6fHlEq1fALwnvPWpKWlYmtsQRTyPw/pnRRFjUYvaLejkVE0nEEink9/pcip5AG
	 UXyvGiOo7Eafx0c3REg+5bhG6sibZvRIMx5OJ/gCz/IFXClKiIgA0ll1kvV2f3fMK6/ZI
	 YoqUkJTrIICmpwKBg5DISeTvamfMWS+rxTr3E2yqQd/iK4tEklfOaoJlK5Jc4piG1Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551307;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=03t9u+6ErWQUPqqO1twWwAf3Et2+23bWE+GQFTlfM9I=;
	b=5qbK4durRtxK/aNi3AkRIClAOXtYhDGKCwsiLjqDm8rEt8EgrrE6hJiKasfokYwcweaD
	 0JQubd0HZ+CrXHDxG0WItXcFc3LTJ9kTyxrljnafUp3g4XFnZTAYnDduo1bq4kwZlMDqA
	 xPU4XsEncMzQK3W7NFcqv4B/G2rfarXTFacawaOUmHYF/2pPC+Gy35Zdq1Glrc/lItbbA
	 OEaPwl/p6xnZjwf7M36bL/IpOB+fz37itNAnl0+JOu2ijeng0wvMLpFbCNXO/TxU62Pld
	 Y6EAxyDp7xyB3OcA1hdOo6sPHzXk/Tqq6IDzFV6iyGxVRR+0m3RSlr6SI1HNlgeHYLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=laUDDcKO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KsS4yIzf;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB3606A32D
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 20:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81FB3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=laUDDcKO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KsS4yIzf
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC3F6140003B
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:15:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 24 Nov 2026 15:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795551306;
	 x=1795637706; bh=03t9u+6ErWQUPqqO1twWwAf3Et2+23bWE+GQFTlfM9I=; b=
	laUDDcKOxS70Dh1qRr0xr7DST1pgvPq6xjsuvFIfByLiznofNmshsc6C3YAi9kFf
	pqq/kCaoOXJPdv2MJbxmOYx51V7PdeyJRkTfcVXXm+3CgxSs5U/NTuWv5UUxbhzh
	fWMXNLLuKGoN/mUCYN55KKS6sZ5oyQ1wzlwz/0KMcQy6EcdWQVpqbcTEu4vLR2D4
	+m0YXCsj/puVIjgEP6jGq1Jj5kJXfIOzCjknixNN3Vkg8I4Ctnai5nv32zLIgcUs
	up1A+l8BctqahJYVYTUKFeyOrmKogfJwk4eCpI2SeUNHdSfMkvBD27GQr+tvrT9c
	V4jvQVzyGnDL/nuDGBbvag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795551306; x=
	1795637706; bh=03t9u+6ErWQUPqqO1twWwAf3Et2+23bWE+GQFTlfM9I=; b=K
	sS4yIzf1Uysx4C1jH/QIoFlhawalbrZ8GFsYpcm+H2RaQbMcn3Km8M2hyftg6733
	tktZXDzVTO7B5eI5Df8f9InS8KobgFoMcmMOnyv4NocrUeQzIL2OVyjx/+NKJKBi
	pVaLnpgV/SpSprHSD8Abu03McDnKYeLag8a0psgPqI4jKlxWryTrXLH4YCVvmsZ6
	YiwJnsTboeuHr9rJSizLdQ56aAV+nO48/Qpvv3dtQqSBhVK4FlvnnF3XSSdZLfB3
	V2B/lqhfPDWIt5Zcp1BcFj6cmE48nzzavup+fld04C/sKPK877C5XhCCi4d2o4cS
	LuU/Q1b6U++mJGz7ZYWdA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795551306; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:h3z+D74qOs7o8Llsg7JXM6w4ZP4StNnu/r5wESkXdUSpZnd
	0/hjAFet9YFkSx2EXG5rV7ZfUp6sUHXXnZT16oPzxhZ9iQThEzh6PoDdD6MXUynw
	WVzssOeCp2mNAt+qRurnqLYg8MRWDrFrl+u0pUjXSSoSWg5WRexuwitFDeGWxQDj
	Fr5HrYO8I9ifp0YS+5Jsjf0h+oFSdkIaLg8CpEQH1zlqTyHg8NL4wZQnVTaYGhUo
	84VoehONyYkhyInA+V+uE9SCTM61QhHfvgL6kSIvgEX7zGun5439K6jo4SWcV4Mi
	Otp09FGvnIB/AtDF7ehfSyC+2VIZxw/dgctLkog==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:Z1YxDOZuWYMy9Kf9QVX8bN+7Acv5F/1lavGkwzvZTok=:19DR5qZtEaZE5J/6uOwOkbidGLJUDLhd019hZSuWUzg=;
X-ME-Sender: <xms:SvAFa5Bt4-aefbMgxBYfUdMY99RvBpsxkEoT5tKFPW5THAeSuACl6w>
    <xme:SvAFa6HmuLaI_uy7PJltch6RCS1jj9Icz5ISoy--K3R1a5sx34k6U8rDNeiAzQqJE
    BwqKOFpU7A6GHn_N9lClSZZDDO4X-BPVaEVqU-6em3LKzHnc_mSZ3k>
X-ME-Received: <xmr:SvAFa4OteK0QXG0_CLxGlwhSVS2fMzXu560sXF_c3vyEiOov8usnq1VE2bexScFim1uj3TXZcVcLR7Krxi6pOK3WTExz2afWFeaDLJ0>
X-ME-Proxy-Cause: dmFkZTFzbUoj4ra3lY8JlbdL+4dB0vjZY0++s2T0i5E3+HcgVlIJd53bTLR2VjUapXPavD
    lxGA1iYAZls6UM6X5f0HdeqccjSCCNW8ZIX3H79lcHTDvlWEpfAk1n0prWnqIGRHijmNM3
    yCJDNv+KGEqF+j6pWa/Kg4P07XeG4ZB31M7FO0CkoMmtMleCwXkBRMeJm00o77tjZJzjlh
    qcu7icSeDKWm+K3BProj46iXKAcHg4VqTA0rphpCz9dvorGUdiusjDW36Igdga/sPQ3mW9
    OJToUFnSW1xj5/UKP8nGwRo/fpBF7CgkoE7ySluA1mfv1kIXNhAUQ5cDm2iuZhNWvlo7XO
    oiH8IdftpkAdc6xFNQroC/64JZxDgW8i7i4nUeB/deXrUVWqy83txqmDB05kNpDhMyZvV7
    9VTZyCdGKgn8XW68otWjj50OgdsfrUDMsgGsQbO0Qa6ynpw+00qMnsHeGizseYdRriC3iM
    o2rBLxhFNnAIIbG6PV58MuEkGxsJlGioDiz+f/EHpV2cUkFE4FKThQSDL+ENKI+/M2qvxN
    ablSJggnAST7GQlbjkTZqlZpVvS5LFDQpxPxSimWixbmVOJYdIhP7AcGJ4gLxlXi+R3FNU
    1eDwBQVcOaO0USIe+XKMAr88Kq4HI4Hh8gDF88ak9AOIYRmChQ1bB2kAOm8g
X-ME-Proxy: <xmx:SvAFaz5IluRoPPYoBVNAbvb7vJdme7cLr76MIcYEtjRSgdO6Fw7PDg>
    <xmx:SvAFazimjDewUDE3SBRiVhkXV6uhjlx-n5wykNMsLqW5Jlipk2o41Q>
    <xmx:SvAFawfMeuGWlJmVz1rufcbq89o_4YjqdBOlCcCCKImB3RGXtfRbfA>
    <xmx:SvAFazwlEkYHMZaohQQkLWHUDyUaIXub3sD2llTkDxDhpnop1qT6EA>
    <xmx:SvAFa-4-PPS4_7ci2MVHUeKW5-Yq2czzTuLYI6bn90-QUw1kzk1o3LQV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 15:15:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>,  Tuomas Ahola <taahol@utu.fi>
Subject: Re: [PATCH v10 0/5] branch: let --delete-merged find squash merged
 branches
In-Reply-To: <CAHwyqnXs99Jd5ajrskjpGyVQZmR1DOOPmXturzDxOyWuE9dfBA@mail.gmail.com>
	(Harald Nordgren's message of "Tue, 24 Nov 2026 15:24:56 +0100")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
	<xmqqse0r44y2.fsf@gitster.g>
	<CAHwyqnXs99Jd5ajrskjpGyVQZmR1DOOPmXturzDxOyWuE9dfBA@mail.gmail.com>
Date: Tue, 24 Nov 2026 12:15:04 -0800
Message-ID: <xmqqld6iouk7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Harald Nordgren <haraldnordgren@gmail.com> writes:

> On Mon, Nov 23, 2026 at 10:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> >  * New commit: --dry-run also works with -d and -D. It is still rejected
>> >    with options that do not delete branches.
>>
>> Much better than before, but we still have a few operations to go, I
>> guess.  Users may legitimately wish to try (with assurance not to
>> cause harm) renaming and creating.  It may be OK to leave these as
>> gaps to be filled for now.
>>
>> What is important is to wean us from the "The dry-run option is
>> incompatible with anything but the delete-merged option" mindset to "As
>> long as we add dry-run to the command it ought to be supported by all
>> the operation modes, but some do not support it yet".  So, perhaps in
>> the ideal future, we may want to see
>>
>>     $ git branch --dry-run test v1.5.0
>>     fatal: would avoid clobbering existing branch 'test' by creating
>>     $ git branch --dry-run -m foo bar
>>     fatal: would fail to rename a non-existent branch 'foo'
>>     $ git branch --dry-run -m foo bar
>>     fatal: would avoid clobbering existing branch 'bar' by renaming
>
> I think it's a great idea, but I also think this topic is probably the
> wrong place for it. What do you think?

If dry-run is a wrong option to introduce as part of this topic, then
yes.  But if we want to introduce dry-run as part of this topic, then
the users would expect these "I do not support it yet" from individual
operations, I would think.

Thanks.

