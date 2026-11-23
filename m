Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476846;
	b=DS+8rPxFz6LhalUneMX3h5FELSmtI4ebwfjsNcCrxhJYA+WTuh09Sp7jMYVAeTbJlBdx
	 US08XhnMZ/ZTtqYWP9d89IDfsQuFbjS5ND/Ak+lhDzGrFRNIj5AsWEHXfMPH6oiYJ2D1s
	 J5NMKw9sFBScMWItRWtqnJUex9xjUKvD+Ou884aj2Q4iSVT4TYmb2tGN/kOAzB0m5C8L/
	 tzVjz66ejT2ncOYxhmFrO4yg4CaPtakNfTtXWTx3WuHdFs7sHp+VXKRgyUEGXkhzCRGgk
	 ILCXZ/og2m98M42V77Jwry9yO57kwzHhBCLhCLBtnnPl+NWbEEVEBbjMfZZ202A34xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476846;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=PxoxgqXnPB9IFdKH5JWEk7Pi6a5bbPetqZ8OQUh9DWs=;
	b=QnIJ8FH2Zp8e2tG1+aCB0ZztB+tpJ+LUpTOT2tHg5A87hx59OtbdR7SdUM1he0QT0l2W
	 F4EF8T40I0miEeYiozMBkWviOft4KVdoiRpPTHtnFmxfcyxfmM307HShzHG9unC+9w8Ge
	 IfC23Li4NMEvS0+hLJvoEEMPYG2ARAd9vdEIdBXOxVsO7DKpIJd/8hgg/zNkenqC2fCs2
	 7ndvf1BNs0mXAurg9yyv9oiiFWgKqxIBuunSeXxZmwSbmLUwx+sChburF4fyKsXRZj8BR
	 8gdSXN8kPngvEWsgD7GwNNuew28voQpVFfT/u9lRmIArT1ObPjGTWmSKR1xOURgGSLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Nw9Cg3UW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pmxttZLr;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84393606A32E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 23:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84393606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Nw9Cg3UW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pmxttZLr
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DA0261D0063F
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 18:34:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 18:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795476844; x=1795563244; bh=PxoxgqXnPB
	9IFdKH5JWEk7Pi6a5bbPetqZ8OQUh9DWs=; b=Nw9Cg3UW6V+hhj8SdIz7beWmil
	XqNahBYXKR976A5mmU2wbgmBeV/ZgdwPQvIr+ze2yS01vDhhMWhPI+ocLhv4lMwT
	cTbNaA4EPvXfroavbDLrCs/2TdOvtyYpOpks93SBEBrrgIMWDtyUZ5MKN3vkwHmS
	X4X6QP1ODUeBAr2Ke7TvmMKcvOgbsNg/g0ebPqNvXFaUnt29PXHaYFblpnuLCZMP
	EukLanLmPgqn6sDrROZour+XrMEhhT7+5+lehXXsNctOVVQ+0aOGrOuapey+guOn
	dhjrXtcX7DayI9OOz5vxqlhCO8fOY8qD+hjwwgSoLsb1niWagY38B8km/2Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795476844; x=1795563244; bh=PxoxgqXnPB9IFdKH5JWEk7Pi6a5bbPetqZ8
	OQUh9DWs=; b=pmxttZLrsttZDMiQW6JQQetOEf7h0f8AeLJY/zWQ8QS9VKa76pq
	qacz6yJgrWEEzJa6M5Cc8mtRZaSdc3udjt308lfL3DB08/PzyNlY+hk/lON/1VzG
	CZKijywIvHMKmiMh5/vI58lClMyX77KTQiUoH98g3LZE+ODhseEZhg3pXCsl47Lu
	wPamRe4H1oe1Z+LMPO3bXTOeOs4ln51nPemg30pTpYEmQ6Qh11I3YAEN8WMgREJr
	zQg2wRkBeM8ysrLiuFrC5yAH2N+qjcOkY+oR3sSjYBCIoOa/a+BsleM5iVC5ni+T
	vPk/SRgpaNjdZl/zdv6X2y1SpHByyyWNqSw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795476844; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Z9SZZISLCTv3HUgTlnictXFs/1dlPcIid8+ooCPFKb1agLj
	nyd5qyWQwNyHcVwdgMzZ0XQkZelmIJxU+YOhCrhoAsLD/yvNNgTo9A34IVoz4HUZ
	jJIk2n/p/SeZebU0zAjQTeKkXvb9x6CDI2Xoodezwqu8xcNnRsvc3xaXGfRn4xHS
	NU3uz9FkyN65cWHfGNoEAG8BGY1eHO/O9RHCcGm4AI7cEa4tsyoM1mA+JW6nSWil
	NyTXPljrLmK+BOd/iP5hFvdWfGpeXylhrtTJ/qUOMtJ4eQjjDpMqIVtzuNl/DuKB
	DD5KQDPKhScLETUy2m/ZXHQFCfQNwf5CDrnHdCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Ho4vc1AJgU8xd+8tIGwQ+lJz5r8zQBkmfma1CIGIbD8=:/At855zUYUmZu0z7gIwopoZMTAn5JGAcMiRtxb5Umqs=;
X-ME-Sender: <xms:bM0Ea9mXpg7N2P_ynkvGBtJ6iAw-mN7Mf_AGfA3MYaVkfIVFmuIwgQ>
    <xme:bM0Ea_1dlnZZsYPWCrhv4nuQiXbNEFmu_GBy8h6i_JO44R5YD9dj6xICYfGmsylmw
    oBl9D3MmNbrMJehn4EPdYrqoFx30Z3jxI1LltQir60EQpZPVeo8lf0>
X-ME-Received: <xmr:bM0Ea4pgnQ-vWnWkf0QJ4vuVDZfJbzN7A1U8HmCl7qEYRhMNo_7J2_oan7CYEg-7J2Dyd2ODm22Y3-BXoklvfW2RWZFVhl8aJSHSeKA>
X-ME-Proxy-Cause: dmFkZTFBgtszqtnN6GOX2D++JJQHH6rvwM5mJJwVY5lb7IVdvUf+MEYJ/M8q7ghK6bUUl4
    B6rK6BBTAP67poI/QaWyB3PEDDbkYSCIykBAZX5ABYRv/i7YBevCKJ+A0dUPqf3ff+jJAX
    U0oM5tnkghjEs71V3PLrzWPDDnVP+pUgGZq3247xdE2niN7OHqym1s7e7d4/nRPf1JsNzN
    Tjnyz8dJJVej5n8s36Ub0zhBTgt0DH+oUZ9NjaXRhPbDGkQa2+WB+iiw8K9Lh/V6oge/4L
    W5Tv+UrMhrVzm7UiDECh86J4j9lHiJJzxV2K3ubFdGKcXJgxxQuDfseTag1Rswf97pQ9eU
    5nFU/ZnkdKzNAPJ2dXJS3grbUC6m2YDI0OQfZ/+vn/YHZEBWlyYN71ffvx57Jt7V/IiVfR
    pyauMBmoth4ATgv7kklAlvbe+uk68IHi6BWg1Jl5JvjFROtGi9UA0nOVoIF36bk/E5tA9m
    IfIlm9TR7ItBo5BWX5/ue4ekEO9E45d3LaWTLRyeKaET2OQXrJzUQtsfMHrAV6GXeHIgaN
    IJu3JK67E3P32Zz7WHsJ+oFf39HAjq1a8eGhENRE2/S4sjJPnF58v2hCgJdPJU33OlVMpL
    busZZuPRZ8HxqObzjjpLiwpDJo3CXoQqJtyIJKwDVB9GKFMdLSCRGviDa9GQ
X-ME-Proxy: <xmx:bM0Ea8ckFo9BzN48bB11_PfIk_ZHvh3Q15YzeX4-KtAOdKo5RVDiqg>
    <xmx:bM0Ea3qoLfijPEGcjO36aBFnQQj-ytl_SxlLAXay7bLMv-RvStt1Og>
    <xmx:bM0Ea9Gl3BvfVKWj3TpoudILkiRTRe7h2p9ijTH-h1PL0Q6Br4OnmA>
    <xmx:bM0Ea3tzg7xPyVja8tJ5GIUDFC4phBsaogk1TfpxELy-oqsfXNIKkA>
    <xmx:bM0Eawmw2wz08c4d6SyphuunA4V8wl_ESerW12ZIBjkYWPyQFCRm0CJ3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 18:34:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  "Junio C Hamano <gitster@pobox.com>, Andy Koppe"
 <andy.koppe@gmail.com>
Subject: Re: [PATCH v4] doc/gitcli: minor fixes
In-Reply-To: <20261123-b4-gitcli-v4-1-de130d0e07e6@gouders.net> (Dirk
	Gouders's message of "Mon, 23 Nov 2026 22:29:24 +0100")
References: <20261115070357.113875-1-dirk@gouders.net>
	<20261123-b4-gitcli-v4-1-de130d0e07e6@gouders.net>
Date: Mon, 23 Nov 2026 15:34:02 -0800
Message-ID: <xmqqo6bf3yxh.fsf@gitster.g>
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
Content-Type: text/plain

Dirk Gouders <dirk@gouders.net> writes:

> - Reword the commit message and clearly list the changes
> - Fix a typo in the first rule regarding flags as suggested by Andy Koppe

OK.

> - * When an argument can be misunderstood as either a revision or a path,
> + * When arguments can be misunderstood as either a revision or a path,
>     they can be disambiguated by placing `--` between them.

Hmph, an earlier iteration I saw had "by placing `--` before or after
it" and talked about a single argument.

https://lore.kernel.org/git/20261115070357.113875-1-dirk@gouders.net/

And I thought it was much less error prone than this latest version.

"git log main next" where both main and next exist as both a file and a
branch, and what you meant was to trace the changes made to file 'main'
up to the tip of the 'next' branch, you cannot just put `--` in between,
i.e., "git log next -- main", but the new text does not tell the readers
that they may have to swap.

"git log main" where main both exists as both a file and a branch, you
would do "git log -- main" to trace the history of file 'main' up to the
currently checked out commit, or "git log main --" to show the history
leading to the tip of 'main'.  And the earlier text captured exactly
that.

So, while all the other parts of this v4 may improve over v3, I think
this part is a regression.

