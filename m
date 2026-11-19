Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104761;
	b=w3dadgduad3utE+Ufj+/AxWWvy1zyJyOfLKcWoZuUVOvTm4Y+66cCCEfS2yCqPw7kTgl
	 XQMBjhJ8GxiU0sXyAAR4ZDTm6TxR7xRjhexjKrciljERGLHJm+uj8WIyFMwFkXl/Oq+sq
	 lVbS5r6SGOtYLk/UA2cXdFx4HJZ5FEX8jY3Fjl91ZOla5oo2NgdxJQ6eTUgKILG6IoNkZ
	 WPfjijuURFhxVIZ8ri5OQ+Dq2minz2ZP+zPY+UfTWT3XXb5ax+xEHDuipE1zg3q5DuL5A
	 2oIMgRNk+vWX3S10Kj4ZYG/NBTVIeMlCK5qp1W53QmhKPDcmYoJwD4htcwbrRPrCwVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104761;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=o6dmGeBuqZMJD5BUCezsPuzbRINT+I71lW2JHzYbGsA=;
	b=JQMV/Z4bfz0MgBzu4+e6gcvhYrdf5Bror09RpK0wABQ1n06EtrTJftwbCaOtN/ZKs0DU
	 ZQtsxxmn2E2OcEwYh5NWyw31aZGxT0G1UNm6w8YuKyw7pQdsIhlip7/33/AsvEOg02yqa
	 JfqKCwXIhDHUKxcfnPaGp0HVboJKVaClLPNcbaE4JTcl2PPRA8AgR08q3Z4TiVynZ/c9x
	 TUW6UE7TXRteFtivMzwgimWK9uNliJXYnwjVOqmk2i5RnOx1ZsUdc32hFZmMkrQuZyRHt
	 CckuOacItBe4a051DebgERJF8z78ZLQoEqrOVWg33eskk9PyMX2DJwuaHPiFj8pz2eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nh60GUDS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=c1ecp5pm;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA00E606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 16:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA00E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nh60GUDS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=c1ecp5pm
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id F40301D000A9
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:12:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 19 Nov 2026 11:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795104759; x=1795191159; bh=o6dmGeBuqZ
	MJD5BUCezsPuzbRINT+I71lW2JHzYbGsA=; b=nh60GUDSaqnV6CsYhAoKyetDNp
	dTOPiP3I+2UGXSgY//8G9cXo9s/Gwmywj7TxKsFQ7HMaP65e4UM97+z5iRL4fa9a
	mjW/hPsmBEuz8hgeXWyOpU1LwSvk9ymG0nQRKSigKFSIvXlmTOh7sU8xKRnCgAN3
	J1HvLM90Kn/Egjf2Pq/EpaGYKsXN7VaptCaIFpa45eNf/Xx99ZLhb9apGfgTvn3J
	sJFF4UvldNFKCZBuzkFjKAp9poUsw3hZjuvQFIBptA19TWF6cXXVILWtf6L9PlMa
	7fXrLhBVrbFdlgXjp5qjwxlpSvft1QxR9cInpAsS5jG2C4TRsVYh0D7ukXGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795104759; x=1795191159; bh=o6dmGeBuqZMJD5BUCezsPuzbRINT+I71lW2
	JHzYbGsA=; b=c1ecp5pm8DQQ/aP9LwNb769mayhwfj38n2VBGtDJgO2nkJmkfoi
	imZEc3lEZe2PtXIstCjlzeQB5IUhwM3P4jKTLrNwKlkRgkeuFfbBhjQESZnPDwzf
	9k0nGWmvmQuIb8SMjgZ/Z72bj/DDeOjruAOgXt6S3LcxW3bhmeeXJhWRO0wHSbjX
	2LvF9qDWoT7x5nP9gYwXxj6k2WeOtl9FsiAFupSiZhIsNWa2MadWmcIz6C7w4ZgR
	PwtzhftJWJLbN86lARl6PnY1wsfvPKPyJzSGTqkL9vsHC2+Bdb+RTKsdFX2+JjVS
	QtFY1DH2dtTrf4Pv8PaCHWp9jBv81FNnCog==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795104759; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kxHsT0J2ebLCVlJL8553Nk/LA/Pbi+cZVlH+7Xuk0cpR15n
	Jwsghx7wZX2nmR2a8EEIubtja7U2Sys90SD52+S/tRoffQP0mua0MOnT+rBgwGBE
	1MW6hYBxKrbp48pEDiO8kuAbNMh451kwb6AxO9ntRjY87U/PEIZxAAlTzZGjVNvx
	mmJ10/UBV5Joc5VyGl/ZJeWWWUPJrCVSyEyM2rSubsaDVsH6yNtgIs6uaOA7H9Bw
	WPmgzHvUdU5cTdubfWcVV/Pv/KiXifXxrRdS1ADJZfuhB4Hfimy4Gnm2h/LbsfGI
	FnvzNMrnoVUzFc+lCY3gdm6Ui8o4iVT2z+bRNrw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hXitEBHANmp/Pde68ytkw4Co4ciQudamrimYMElCtzo=:SnzdYxBVHoq1nl6jCOywlu/KGJ8NLDnH6DW59/UoRcc=;
X-ME-Sender: <xms:9x__akBfBEsv0a98PH7emsu_ADzpAuQR20zZJZsHx6_VHq8jMrIO-g>
    <xme:9x__aowSPiyxCR7R5Mhf2vd3Vr5gp3a5Mcp9xyPUxlOIdPhdheptEzql5OR2yyo7Z
    jk7n1ajjvXzZokxZAFRn4lJSy2tDaArsyEVnRkBZvnR-3poDS4bbhEs>
X-ME-Received: <xmr:9x__ap2JawfS-Yeg6Pc4E2GNAl4b22YX7ISMsWdDkA89AHorN0gyy2J5BPI1I5QOtW10JS4EPxmGp1rEuWyQEHYRs2jZuNoo6Oa9>
X-ME-Proxy-Cause: dmFkZTE0hRvdBebZEC4c/pHn1HR/bDZDWvZobn47aYHZyNlNH7KHBsmfSPNeVoveVfF555
    jHZDu6mJ+r55ovyAdUR5J5vwKmDzGYLYnt6xiVMTu/Wj25MK9ld6W1Y3VJThGyYJu2i4UX
    6O+F+IyCE+7b4synWxRmI/5C9WiP5iwIkp6GCWO7cGbI5idx4Fs1jtNGQY6yJBbzTn3zYn
    bDX/3VHcV82pBvr22iXLT+vrYGlTZ5ox22mSWnqCCBajGs1te1moHzQKHInH01uPLEPbu3
    GARA3/Jg+nbSQU5As6S6r93cLIyPV9+w62tcK8rbFBvMeEipkcGzJxth5XtJqqQy2WquAy
    S/tasDvo9QjJmb4yhkWlRvAlsV4KNSHUCJoAREPD7iAp/7VLxPJV2Vwbwcq038+G6mJczn
    l1RQ0TGH+xgrA5g6c5UEPolxpUQty7s9y2n8g/Rxku+2slMifWKaBWhpBBpbMbYFEQs1gA
    moimlabIgMSl5ZqQHpDrqMT2dF6Uhp+dpZsCiZhR9K7UIOoJPYonnFTe4SloH7uHhEiAEJ
    F7IsD5OwIMqByeLXwRcD2l997goQ71cRHf0xJsG6IkUfZJigibfnA1EPRhWUUzn2OqktGw
    GqEMjbPVO6ZgwdGFEff1Pbt2rJfjG0IGLvQ4rxKd4YnMLuYLfgNlrypoPwEw
X-ME-Proxy: <xmx:9x__agwU2FdxBHFk4gBmB_xy7Qn6z10FQ3tyKffrIwXeOvn-zqj2hw>
    <xmx:9x__aoElyLNluaGpB9b_rihe4KPknxdUrtstqymRo_k44iCpHU_ZiQ>
    <xmx:9x__arY9IyGB7MujZxw8g8SUMnQZLcpWlvCE2IKNphrli3zIVZ-WBw>
    <xmx:9x__aiAmFfHk1kgmBRACA_ukgc05vMwY8cz61ljdXib9D3SkIl5c0Q>
    <xmx:9x__andFOTrK1G2QOiwwuk7Zt3g8-0U1NBbctCvhzlB062IrUED0F4sH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 11:12:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Noam Cohen via B4 Relay <devnull+noam.noam.me@kernel.org>
Cc: git@vger.kernel.org,  Teng Long <dyroneteng@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Noam Cohen
 <noam@noam.me>
Subject: Re: [PATCH v2] ls-tree: do not quote %(path) with -z
In-Reply-To: <20261119-ls-tree-format-z-verbatim-path-v2-1-c014e4e4c96f@noam.me>
	(Noam Cohen via's message of "Thu, 19 Nov 2026 03:43:01 +0000")
References: <20261118-ls-tree-format-z-verbatim-path-v1-1-718987241861@noam.me>
	<20261119-ls-tree-format-z-verbatim-path-v2-1-c014e4e4c96f@noam.me>
Date: Thu, 19 Nov 2026 08:12:37 -0800
Message-ID: <xmqq4idc2422.fsf@gitster.g>
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

Noam Cohen via B4 Relay <devnull+noam.noam.me@kernel.org> writes:

> From: Noam Cohen <noam@noam.me>
>
> With -z, "git ls-tree" is documented to output the filename verbatim,
> but since 455923e0a1 (ls-tree: introduce "--format" option,
> 2022-03-23) the %(path) placeholder of a custom --format is always
> C-quoted.
>
> Output it verbatim when -z is given, like "git ls-files --format"
> already does.
> ...
> -			quote_c_style(name, &sb, NULL, 0);
> +			if (options->null_termination)
> +				strbuf_addstr(&sb, name);
> +			else
> +				quote_c_style(name, &sb, NULL, 0);
>  			strbuf_setlen(base, baselen);
> ...
> +test_expect_success 'ls-tree --format with -z does not quote paths' '
> +	blob=$(git rev-parse HEAD:top-file.t) &&
> +	tree=$(printf "100644 blob $blob\tdouble\"quote\n" | git mktree) &&
> +	printf "blob double\"quote\0" >expect &&
> +	git -c core.quotePath=true ls-tree -z \
> +		--format="%(objecttype) %(path)" $tree >actual &&
> +	test_cmp expect actual
> +'

Everything looks as expected.  Nicely done.
Will queue.  Thanks.

