Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449511;
	b=e8V9uV6xgzSYeKrBKXoRWciMA0gyiMxZHzrEvm1Zkq3REplWsQVzeUYK7Hlv7ygTaL2p
	 hGUp45et6Gjm9EOnppugWJD/nwdSE3ee8t1EGIGcZB8XPTWhppw1tRVc7t/mOPTgxp40X
	 N/R7Z/pU780mj55N7qM1xSfpyWPkD9naez/7utqFlw8KapGM05p7kEDxS/LiMKXCHfvB2
	 lIkUVaRx6dBEiNUrEVO2qW5HZnXSbD4O6c74YEg/L1Z4qZZR/ZJzUOXD9aj6+u2GKCa96
	 bcnwvXqVd0IyUe7xgo0C9FTQd8ImQvvNrdfQAjVevYcgj49ar/x+GiDU+HOv0Oclqew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449511;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=gLHItAveLoUqQvlEzrF95WZhoaf40cEy44IEXgwoKgc=;
	b=FvtB7r+H1uNTARoiaineAUU+mST9UIrXmfJhf3Cxku1W6Y0j46tSV3coIt07hG39wjMg
	 6/CdzVZ4VXj06KBpj1E7WyJLH6z5D5JzOpQYf3nMRyKT0hvwGWbsieX1Fac2b+aHDoamf
	 lbTDGjkrKi9qtF0pDDnw422HjbpsuGpMjpOBx2KL9XZoRYCpN9/tltrPcuWlAiNkijG7V
	 73ZkvQ+HFEhx8jOT7xk7yEvwiF1e3LNPtpvPGnECgSueD2BQyzTETMeQ7obWaKBpvfEtN
	 IRvOJom54RPt66eaOcNXLuOuH5aBguDl4QYZMV9el9ox+XCnhhQFrq4hp39FSUowv0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="jNM/f3vl";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DWyeZuZL;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0CB606A32C
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F0CB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jNM/f3vl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DWyeZuZL
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 590D914003C5
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 10:58:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 10:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795449510; x=1795535910; bh=gLHItAveLo
	UqQvlEzrF95WZhoaf40cEy44IEXgwoKgc=; b=jNM/f3vlCSs7XMy5e63ZWx8DJ1
	6bJ+Nwau8DNc5Y4ubJXQTFsv40ypMFaMTrOIMqWzuuJ/ZiWaD6/s9uqrqfDM/zKj
	oPwIyD/Uqp/zq8M0nxuqdZQrqhspHJrVvjf4RvHXO//C7YIYpa4wI1djc//J8cqe
	j9TSxRVBIwj03vV8BHzuJtOoNKiNeKSEwQyubqi3vU5K/xJFjmsREQFvk153php7
	aoR7SGzg5mEgwwFh698xgNvTlVlH6vtZedjfsv7jyeEybk1U83r0fqnMMl+o6xfd
	H7WZj0tqF8dFu0AjQ/kP37NR+pJgQitm2nmeQublwX2NYoh52/v2DHXj7u7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795449510; x=1795535910; bh=gLHItAveLoUqQvlEzrF95WZhoaf40cEy44I
	EXgwoKgc=; b=DWyeZuZLdbW1NgzmPgcdxvqqmrGakkgYK4L+4XrFm+UHse1oZYx
	6NildJApSOjnRwf5JzuJGh+9f+4YrsV3gJgCbXc4vALqnHBxUC6F3O30jwg8B0SV
	VmzhyoEzWpZzMqB/RyFPdVbMbW+Tcx9I2ygs38X/jtTsk8e13hZaxrRThPPZdoH9
	9giSaYBE5hWx+VCwCepZTtNDGUQFALDuyF9hVF9d686ECx9n4l1e4ces2s2FvLFc
	oGFEhB5RqhGbeMtytBpLhvC/pKW9kMtW7wUsya+5uMc9EfwI6yY2+3vEufGOowNP
	s6KJJZ/As1cdCKjlJwsh9s089rlEppcwnQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795449510; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NLX4SnxSHO/+UWfZQ0pcosizvTEi9giyTmTT7WEPPQrZTuG
	uz6d2K45xn8wMH9xac/iMgd4hHWFcebfs9zWPJNtK/vcVIEwyY7RSREYp07vuZSz
	PaGkU97GOMxGjvCH1fz6zz3hxHdYxqApoAJS/2iJIrCMnOYu15sc1iVr4i3Tfkrz
	8dFThk3gteMLJlW5Za0RHdyZ/AhMwsqU16YwA+vQ2Kf95YhC35ep+mUMoMgd6ZjS
	B9LqmwjiawBdg8KPKt5E1syHlE35/LcbkQf2u3S0qSxxvBxRs81nD6+rPROaD/MV
	Cy0eeYF+rt/ddHZk9+Yrdto8rPDufoUXAzpX+sA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:JgrD6+Li5F0SLqXyScPn8DfNwUh4wPalDkx02AOu0ms=:3ryPfkBk9zrFhfFFQnQy2/Ohxvvi85YV1xb7U4iYRAQ=;
X-ME-Sender: <xms:pmIEayhq-Mbcg0wghZXe26tRubypbhXRZ4THNYMCazlSpSoGEKpwRw>
    <xme:pmIEa6DjM9c0OzvdZ06CgTwpRvESrObxNZiRznLZcumI6ph3WztShX1njeGZOxBuD
    BIt_1xThS4we5dlva_d5T5gcUR36y2q9-3ocCUX1dQZoDnS-ixUmw>
X-ME-Received: <xmr:pmIEa_G4A0WGN0wuy-d7tCPx1cECam-R8oAvkhE6rrhIcw5dhpFyMKyDoIPv5kPnj-Tf8p3femtcgpFiiJxH13nlnRr3XwTAHtg8X9s>
X-ME-Proxy-Cause: dmFkZTFx0nL5IVvNQ+A3X6fUHCWujFgWJkOYHBjaiEb+hlr5VwXSqTiT2tqUuORSzyVqUY
    nGFaQKamXplJgzb6EoYNmBIyxQJm2gYRQv2GpDwrZL06qYhdOERPw8H0khr3DtD40EzaNS
    8fitls4GIUVNCpM4LtxijYIgfQJB5qTACeXZS+WQWVFaZPwW7CtvhIR7/vyRiBCZaaaKS0
    A2cxY3Q0UOsO5lMg9hDTYNdG94e1vra6H4D7XkGR1meI0ikN/x7hgsNnWCL94O6a/pa4RA
    ht85bXGhyP/RsgY8kMM5uxJACkS0UsnwgLCD0kmrKyF0b3I866AmKnVNKIJS/XvKRqv4BH
    L+0B2Mz8OZnj8BeQWfke535AWCYmYHRmLcwZYz6llfvww5egGjSax5mRjPe0akRYIgzpyK
    SEQ5Qkn95r+arRc9r01mden7Py4ib3mnYjRSB+ImxbfNJuWvGPI08sOUgCemIbNtTUgzFs
    mY7+kH+PPk6ifs+gX21DjQWTVxs1TcZ3Ndid304q0/nkuCDPAK+MlPfsWJ1VpNfIY7kakW
    R7KMrF97TOYuqu4mAUzNmHBrczWi0GrJ0mR5W3ZoTuj5mi/Sp43mH10/K3P/Oamy/BofBU
    KWidrYQUqOdGyGQ7mROD8bfPAk2uSS8KOLDRyksUxuvDWlPcBKBWs7ueN1DA
X-ME-Proxy: <xmx:pmIEa6JSChBRWsZ9GF4OSqN6cOPxTQ4YNlpDA9rLbgvb72G_xaafgw>
    <xmx:pmIEa7nwO3GtofPH1o1ZcRP4TWr3dxnjR0LitK5abRyhVWfzWXFiHw>
    <xmx:pmIEa6QC7rf4nEy2l0dYKKBLBfH53vGRorLQ4dtNdf5BSRCkWXvcgQ>
    <xmx:pmIEa1KL0VXqnxvRETxbAtpSLrAwmp8lVvirM4xzcGudt_9VZBCdgw>
    <xmx:pmIEa2kWnBI-Q3RUJLwBBxiqSCmfW_MGloGy-xWBkjVk2gsd68wKOO7h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:58:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Gontu Sujith Reddy via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Gontu Sujith Reddy <gontusujith2009@gmail.com>
Subject: Re: [PATCH] doc: fix extra backtick in git-push
In-Reply-To: <pull.2504.git.git.1795429837730.gitgitgadget@gmail.com> (Gontu
	Sujith Reddy via GitGitGadget's message of "Mon, 23 Nov 2026 10:30:37
	+0000")
References: <pull.2504.git.git.1795429837730.gitgitgadget@gmail.com>
Date: Mon, 23 Nov 2026 07:58:28 -0800
Message-ID: <xmqqzeuzbkuz.fsf@gitster.g>
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

"Gontu Sujith Reddy via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: GontuSujithReddy <gontusujith2009@gmail.com>
>
> Signed-off-by: GontuSujithReddy <gontusujith2009@gmail.com>

Your message identifies you as "Gontu Sujith Reddy" (before the "via
GitGitGadget" comment) on the mail envelope Sender: header, and if that
is how your name is usually spelled, we would prefer to have the name
with the same spelling on the in-body "From:" line and also on your
sign-off, not squashed into a single long word.

Not having any log message body is a bit unusual, and we encourage
authors to say something, but in this particular case, it may be
acceptable.  That extra backquote is clearly a typo, and it is an
obvious fix to remove it, so even if we were to write something, there
would not be much more than "The extra backquote is clearly a typo and
it is an obvious fix to remove it." to write about it ;-).

>  This means the user is responsible for ensuring that the sequence of
> -individual pushes makes sense. If `git push r1`` would fail for a given
> +individual pushes makes sense. If `git push r1` would fail for a given
>  set of options and arguments, then `git push all-remotes` will fail in
