Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543446;
	b=N6kKqzwKe6d5ybV4woBOCMcTJ0aUeLR22BwYyu/32z/py5sAtbewYRejOSLRxLecFPRB
	 LUzW54q4hNCmmw4yADOODdnZty5Dh9i4siNDwyAw7VEXhp3bHMaWB5jX/UkLBIE/ykEqk
	 q9TDJcu3EW3eCXKDDEiX7A9225+izixdlcRmF/5CV2dj++tprTxyC+cNgULYv8AHlYufe
	 /pFtnCltvge6xneunxqs/E/2JC4sOziiQeTJoQR3chmHCBJj0rPyAWuYk5FPIHBHQPh5I
	 Gis/4SMyIOxbZoI45eohMk/Rjb1ZkU4kSNVsz6GMnZeSttGhnveNNsbsHADfyq/Wnig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543446;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2agT+IyCoTLkjR2fzy3oImBewVxlQN76AWt+AXSAnzA=;
	b=1w3mKs4E8UX1olQr9GbI+o0OPdQXuCD5B4SKrJPIMmvDZKzgIkRpz4dPJegcTjRA6W0i
	 RR4ADVjYiCF6wW5DaLg+y5NsupgPyIWwSgZdgD2TgEaItS3pU6kXl+Hh+4ZHjGpw8ofMo
	 /em0PspNJZ0fvQ82fr0ejQuS8+PCJszeUf1vSQBcdztVxzARx/ff//I9055PfOnSuRP6W
	 BbLt6yEBPxUC/ny6bB2CDgt6PZoLt1YIfq2oJtaUlJ2rWY1SdiefMTDxIoYeuHJenY3kO
	 bYygRRcdADXqkB/g2iWqCc+i0jYhIQ1KIxbHE78fNJU1z7UrJF8YpkCGO/AIjFdc8BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="P/+MN/G7";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pOH7q2bs;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855C606A683
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 18:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D855C606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=P/+MN/G7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pOH7q2bs
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF2511400303
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 13:04:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 24 Nov 2026 13:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795543444; x=1795629844; bh=2agT+IyCoT
	LkjR2fzy3oImBewVxlQN76AWt+AXSAnzA=; b=P/+MN/G7RpMAIREWyK4wdahQ/E
	fBr6vOQQ+Dt8hGEj1HGZs6yA5umgAQvg06SnC5S/Regkd8lHMsgMP2L86XOTeuT8
	vBhOsOXBL6EnaOusq+ZqcsJvVzoiaGwuUjW1sIvrttGyiWBiz+kASSR5PKvGT3ZD
	w3rGGuqNe1eTi65VDjMMGdh8QPj5cGGQPn+tphB9PC94vtv4O6ZP3twFxnydWDXI
	uAutJxNYQIKrNjtS0DQsxTG7bSsTBOGt//t3/e1kgE0L9JwI7JSEq0oS+7I7H0HV
	RcGwZkUqDe1RNUtxUpi+qvxBRLADKhq+HCISz3bE9YYDMiDZsB4cEFRlmMqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795543444; x=1795629844; bh=2agT+IyCoTLkjR2fzy3oImBewVxlQN76AWt
	+AXSAnzA=; b=pOH7q2bsssPVwxYeDjtNRU29jBaLyFLaOoY5/fSFKx1+HIOFZEQ
	86KO1fVzkZTO4BeL/GY0PJPEZiHJjMXvMjP7ZycxLu6HBIGMZYxCmuuhwcjs2J+h
	e2rSEjAKZNHadiMGiTNmctfnBYzhs/Q/RJAQ0PByhDD77FHAdmqjGIZZ8nu0JZYn
	FkXfov+02AMGELCTt1hWsReWilhm5olfsg+Vja8FWBEkT7dm0OqFWwT6iFG97Dht
	h89hu+u+RXydxNIGyk8zVzAQOCqevuB7aqIqLSe/09QwSTq/oh5BFntpstjLrDvL
	EHT4f+JeCz1+5QByxQi9d7q4gfKJzES04AQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795543444; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UHlhDGWhIL7XoZWsAb4FuV87Q+NQEqAq/BDFiOxjW/zUtsq
	8+Oby64Z2sOxG/+aCFnIWdOKrS/+rhbLdarv1ffLSf0XmO2NRq11qn/ecviWuSST
	xAEHwJlv3lHBaCWB8lv3sgJof653sc+dOLs0d0yntdYeOiv8c0+/8itbhA6uEqqh
	FIjEYZvYfLIeSCZczDZGTbxL0NzvMoED0851TN66g1fZrCY1XwbwpE0p28zuS5YQ
	UhrQV1QLDubYXlbSzEriPaEhiN0F6nz6K5hYFibbvK8ZNPZEnBQ+qq86wKYBsUVu
	sFbaMRedQ5KLlZc2hp75AAwBNPV05WmFwpDAoRQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:autQMU7wKrmdb3qLdryUc8I5Nmnu9hvCIC7zEYGFPTA=:I/lyrF4PQVBdP2wNnbo7DQdryNF53viisoAHc7npyUc=;
X-ME-Sender: <xms:lNEFa9AJ9R6RjyjESjNH6A0fVvbehJD5MwyXSL6KkVQ13abduQOANQ>
    <xme:lNEFa6kIT08Wiab7gkRS1-7Jg4Eb4HL6B94843hfz5fdPkYIMSLf-FkSDqLVk9UwL
    Cx_1rcSL1LDCY0h2ypPA62_ExY8GNX8o8Se2WjXBi4njb6bOOmK8w>
X-ME-Received: <xmr:lNEFa-xDx-MdwcATP7PN-kLTW20s5dWa-e79L3HfcyncXraDhuMzD4MwjbdUeQ0j4uIp_tYVHFzmS0HDa50BpOjkq6QnLUg9DhhBmM8>
X-ME-Proxy-Cause: dmFkZTFwH8VuztREJtfGFk5UkjC1mVH36BALAbkarcO7Rk91g9Y1YIk3XwIkCtAngdCwck
    rLsCt88kWGhffOpQy2QFDgehAUnyDxx6kb5SdyCkjOYBSOhV24Kc5Hihg1KMZAIvq3Gj5g
    KShMuIn9PU7TcIWCc5OvOOaLCVj0tpiqXry0jRGwPni76OsYtNdCAFMLZLn92mRXSHnNG3
    9VLKVyRi/YxDZrEs5gHDg+VuFLV0rD544u6j5BpTCrj++L96y9PVnwhZIAb3dp5lgarwvU
    hdYw85FjdWvidLJdqckoVug7pv6pgLGjTg8vxBdYrCIYJ2WJrQ3uwU15+nRpfe0/NqgnfN
    Q6A/81MdqDkZLbA63jSO4hcYt0RCpjF8UGAsK3zYaJ4tbosD6D99en81iehtlqS2Ecw79K
    5+fZrmH0N2IXCAFGonIeO+ijYuHTToDBLAFIGdQBs5vFLd3oVqE0omc7Ot3yt8Bnrff1p/
    z3EWErNW+BWp1kdErf3pBH0fZPUC1xhYv2eSVuPIrnvuxpFbQt/BKJkMV92jq9b90udGOR
    M9gbcrGdhgm0TSnVbnY3pGDsGoi/U2rnlNS/TlaM66gz55Ni2/2PxNPnZtl4i4/UStLzJZ
    kpOl/+dXQc2IXBbFFIbA5XukWlltFJo8KDiDd6Qr16YuViTepJxWpfMHk30w
X-ME-Proxy: <xmx:lNEFa0QRV72A3BG5rCF2j6xSlRej5HLHpeJNVZzTiaLeyICE0G4PxA>
    <xmx:lNEFa28AhOIvJJ46ZFnZee_WKZ15BXLDlvz6_KiNVGq5nshleHNmVg>
    <xmx:lNEFayvno5N6Th_h7TUZ9X40thN8fNnWZGQl-T14smRMx4xbfadNWg>
    <xmx:lNEFa-Nf4QaZmGKFWAfycVBgvy0ewH4mcSSMZU72W4guwyjXF88xZQ>
    <xmx:lNEFa8UFLEI49pSVgNqUlId8iTW1NQDH4P8wNkbJe69bNeFUHCtcalwY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 13:04:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Harald Nordgren <haraldnordgren@gmail.com>,
  Simon Richter <Simon.Richter@hogyros.de>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] Address overflows pointed out by Coverity
In-Reply-To: <pull.2253.v2.git.1795472027.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 23 Nov 2026 22:13:41
	+0000")
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 10:04:02 -0800
Message-ID: <xmqqbj7et8bx.fsf@gitster.g>
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

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v1:
>
>  * Most callers of read_in_full() and all callers of write_in_full() are now
>    no longer restricted by the range of ssize_t.
>  * The signed_mult_overflows() and mult_overflows() macros have been
>    dropped.
>  * Since the approxidate() function only deals with non-negative values, the
>    complicated overflow check could been simplified.
>  * Rebased to master, to avoid merge conflicts.

The overall direction in v2 is a clear improvement over v1.  Dropping
the ad-hoc overflow macros and separating read_in_full_or_error() from
read_in_full() keeps the APIs much cleaner and easier to verify.

Small nit on the wording above: "Most callers of read_in_full()"
overstates the conversions slightly (five callers were switched to
read_in_full_or_error() and strbuf_read() now clamps 'want', while the
remaining callers already operate on small fixed sizes, apart from
worktree.c:should_prune_worktree() which could also be converted).

Also "could been simplified" is missing "have".

But the cover letter will not be part of permanent record, so who cares
;-)  As long as patches are good, we are all happy.

Thanks for working on this.

