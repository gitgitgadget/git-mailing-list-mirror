Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250782;
	b=eXc7ZTiYnfLd7dOa7kk7gIR1Bkq3di4sVNme2BbZcQrQmCElwI4Yf3AN8JHTypV+9+Sy
	 QXtNy+E0a2rltxUKt/hD0YHuBTEeeIFUgY7EtaD4m3SLG6/eciCI8IkSQwfxaMnrrRWAc
	 giy/XUsSU/L+pFmuSRTlZzOhIk2AHdUQVp36UmW1N17rl6iPiZwc1eZYSJI7rjAWGEdhL
	 vsG511UxptD7nqZa6QgNe0ePYXFAP9uh5+Jt8Mf3aa13ZdoH9+tSbX54x9aFlSl36sErJ
	 v+VZM5R2vPLmRGnE8ktsJbeH0Z/b7lv7VAs//c+zur+E8jHxlq++gOIIavxzY31nZuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250782;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/sDQfnCHWoKDCiaT7cdwyb+uI/koQR78nFgEA+z1+L4=;
	b=mTYv7tMXqZUg3/irzJ5QcSmx6C010bm/yYKsN0SWMZW7T9WkhjGM1x2DirAj6wh3qQY0
	 //DKS1vXN4DNiICnJwpKeLb81a8LKLNBnqH+80vgnCgMpLE3cXZcBUCupEvSE09nUC5OI
	 CWLBqDA2u6pIYzEod3cIIbXNBY2y/EMd6JDCbXgK5Y+qZJr1lTFK9O4LCUC0ATGkk03mM
	 n/3MxvT7mKaud6Mu2pMliDVmWgKdXi5aUdmlIr3/e3df5iKelTXsdTAKj+CxOP6Fxwg83
	 PtMX918S6F3r8pSD90DdLPH6xIiSbWCCc1WLisOmOXkPe0z5z0L0kioOgK9l4UBTRIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fElnpVoF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rxMEcj+P;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB5606A335
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 18:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05BB5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fElnpVoF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rxMEcj+P
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 30A7DEC05C9
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 13:59:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 09 Nov 2026 13:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794250781; x=1794337181; bh=/sDQfnCHWo
	KDCiaT7cdwyb+uI/koQR78nFgEA+z1+L4=; b=fElnpVoFDGvPR4HT55+v/HjQwT
	J+8oDO8fY3Oy2qB86KyNbi1si4VuDW3fYYhOi5BpHlZsFHGKlZvPGpsdMAbpBwvo
	DoqVnwBOVMPzGH5EL/nZikR2LriBUfcsjMCGD2qgfdA+ctYgHuvdEd+gRW5GAurk
	vdR7ZkuY7DODLJj6VugCuNC5VnNyWCEAPeRR/x+ApYWsbnkKG2VJ+s+N+R0OYscR
	VY4xfATjEaiFuhbzbSc+Xu7f/onkx+mbXP0NFpdlr5Ly0NAhvjuYy3eBBflu6eUe
	LlOA2rLY84k0jlBN9R179Kjw671In5qc4BRfNf5iLtrDQsWc/XCAVjzTyNHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794250781; x=1794337181; bh=/sDQfnCHWoKDCiaT7cdwyb+uI/koQR78nFg
	EA+z1+L4=; b=rxMEcj+PDXP22X8IxPqnuzNtOHPJrGUuYRgbhEPtIzPwfft5nMm
	I2vj8M3B/vWs/r2NZfAKwQrseVDM5jCcqzCsqxUd5V3TJKKSVlL8YNHJkIjCT/Vc
	Vx1u0GHbc9TPKCLIAFWDNinLCK57dHqBuCpUznze+1vfn9AafwTjyU4q26QXnlAw
	6VD8DL0AQV1497CpZXI740l9IRBiw4I1L79Q8lLJduqYaAFK2iL0IDK5sJXXqFCH
	IE1iuK7djidKaS2CxsxYwl21VE6u/RjVKhB8Fsh2Z3NWkWLzSW2QYbHdlMwIVU6P
	ATH0i+HI5+8qvh4T7R90YL5jMOqrr4Gwr6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794250781; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iJ9+3UXheNoeULFbLVZxDt/RocXfkdSZSK3ZdPuC7VqzPbu
	ue3LyhxyzOhfMbU9eyNSHIaCS98Tqo/Ht7PVCmQHdmN/iVsLnhiwd+OwM/8I08sD
	/Qyg7/GkZ5WXxvRTi2rMLZXYrQkd1WZEpip0lIcucheHDCbTeTSQapbde5wXDf3q
	HgW7vHo3W1re53aEdXhwsBgjeUFgdA3A+CPfstYdoNNNq4z3XqeTG3qjYkhxv4Pl
	wvdZQZyPAO88xxSa7UThaHy+PXINR+/sNjdDNWQHFZIBqUuRgqWlxkr/rxukihDa
	wgCd49w5ySwa1QNeMjV8NiLccUlQ7SMvAofRMVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:G5M7pdIm1YSfXyxMA3ma7A66RVzaDygQvDKVvofbjXk=:F5+jfG2azFQbN5iF6yz30NdXBluo4gqOe2ktvFwv/pw=;
X-ME-Sender: <xms:HRjyam0VDCKT-dY2jg4pzaCTqA2e_AwIxH2HRKL9oVTqdvSjT-zDqA>
    <xme:HRjyagHODwSNxQYHlssa1xeAjtVJCPI_8v8T_liYfdPcTynM7rjnAdJIqLQLjpDrV
    IrENGid7isc4dqPoke0jy3hmb2p50KSjGUoPFNnIlMw3LwqBWc1-5g>
X-ME-Received: <xmr:HRjyaj6qpSIhaGdmDSUUEnscufWrj6hHOWcJUh6O1Z9aqKvYUWWtlCiJYW58rjnMSNsOBH0gPOgi_bMHOwzTsIMt9ESDd5AEUgkN>
X-ME-Proxy-Cause: dmFkZTFr5G1e6ORaZ2tAL0PqMIaqpl8QCU9BPcB36elYMnbkuOg2SSkGgbRBTi+GsKHwgL
    Myal+A1lnsQvfx3/WlucxrS/vK0TwfLh0bvr3P57Mnl9TLLtdbNO5C9p5tOkf8jWWH4rzK
    3F8lxnkLPEtmTVSHuIuuhefywNuoT8Zi72h/nGuyUhY4w2IRl9HYFrPxGpm6FK0ap3sqLI
    ZSZACqoUZoOwd740UTKiZgrslvmlfjSytvDhzMLKQQsm3sRfsgUE/yspVW4u0P1T130Uyz
    THCqbfv8A4MxmaGixxMt3MtpHsSHGBCqIV3I8OneXWO382I9l0R+G3GZvNqw0XWoHAftfD
    gMbYWHSkeHlcwkECmhVmaK0OQBHHrcApYBcY0gF+EaDWCb69VvG/kWwykvg8S8PlDm35T/
    DX9vfMCFvAHIxGt1783rqxpD+iGbxqPTwx27lpysHQkqQuqmPZ0/fFfIBLZ6hXM3nYTegn
    lD0PRJKPfS2YF8vPO9FFReThSd8tEHyqr/UDjkmjA1o2azIFvM3CZRKpEDFjXl/kl12OWL
    RYVP3L/yn6P3RIo1/3wDuC4GD6DcCKVUNT8h/uUZN4HlAOxAdirDfcga2PGVsmdyNBe68O
    g+iQs7marVDqoW23AwklVpsfuVFEc2eoNwjxzKf4gPEvGAj0fccHjBf75E7A
X-ME-Proxy: <xmx:HRjyams-xSWmHdNNY3yQVKtQyBcPbZQqks9BJjIll_YfEwGAtmMlig>
    <xmx:HRjyak7r9Ex5wfUCBzyjEflz9Ge3aPxOvI4e6fcSp6PkKu3iS9-DIQ>
    <xmx:HRjyahWSLq45vPOgTuAULtBHdn4_CAJtGegdbJVn0SeSrki0b-f7aw>
    <xmx:HRjyam8kWmo3v_-5HWxMgpRYhusM42z5EkaP7wZu--WTv1wkJ53YvA>
    <xmx:HRjyavbJLlgJEpcLNCa644PL9owCwbhT2qW-QxnlGUsndQIFbV_Lp0xA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 13:59:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  herroyalpriestess@gmail.com
Subject: Re: [PATCH v3] api-parse-options: add missing flags and macros
In-Reply-To: <20261109-kn-parse-options-doc-v3-1-e60022942721@gmail.com>
	(Karthik Nayak's message of "Mon, 09 Nov 2026 12:30:10 +0100")
References: <20261105-kn-parse-options-doc-v1-1-403edda5947a@gmail.com>
	<20261109-kn-parse-options-doc-v3-1-e60022942721@gmail.com>
Date: Mon, 09 Nov 2026 10:59:39 -0800
Message-ID: <xmqqse19zv8k.fsf@gitster.g>
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

Karthik Nayak <karthik.188@gmail.com> writes:

> The 'Documentation/technical/api-parse-options.adoc' contains
> documentation around the parse-options API. The document is missing some
> of the macros and flags provided by the API.
>
> Add the missing flags 'PARSE_OPT_ONE_SHOT' and 'PARSE_OPT_SHELL_EVAL' to
> the documentation. While 'PARSE_OPT_ONE_SHOT' was introduced in
> 202fbb3315 (parse-options: add one-shot mode, 2019-01-27) as a temporary
> flag, it is now 7 years and still exists. So let's document it, as when
> the time comes, it is always easy to remove the same.
>
> Also add the following missing macros:
>   - OPT__SUPER_PREFIX
>   - OPT__VERBOSITY
>   - OPT_BITOP
>   - OPT_STRVEC
>   - OPT_UYN
>   - OPT_NOOP_ARG
>   - OPT_COLUMN
>   - OPT_CONTAINS
>   - OPT_NO_CONTAINS
>   - OPT_WITH
>   - OPT_WITHOUT
>   - OPT_CLEANUP
>   - OPT_PATHSPEC_FROM_FILE
>   - OPT_PATHSPEC_FILE_NUL
>   - OPT_AUTOSTASH
>   - OPT_DIFF_UNIFIED
>   - OPT_DIFF_INTERHUNK_CONTEXT
>   - OPT_IPVERSION
>   - OPT_ALIAS
>
> This brings the technical documentation in line with the code in
> 'parse-options.h'.
>
> While here, add the missing `flags` argument to `OPT__FORCE`.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> I was reading the docs while reviewing another series and ended
> up finding some missing documentation. This patch tries to cover
> that. Some of these might be options/flags we rarely use, but I
> strongly feel its easier to make choices when there is adequate
> documentation.
> ---
> Changes in v3:
> - Fix typo and rename the variable

OK.  Matching the parameters of OPT_ALIAS() the documentation uses
to what is actually used in parse-options.h header makes sense.

Have we reached the point of diminishing returns now?

Thanks.
