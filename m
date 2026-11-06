Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003418;
	b=yAjyBYs77Enl60yHLOIM6FsSBzkDs6bZNoHzHgSAnD66Nx50FRPZeuvEtWWx6Qk0uIKf
	 iXmPShtWRPw3Jg/sXwj1uBwBb+4Wyw9uzVXZk2pVEes8T2P/WyNx5I27EwJfhDtPQIeQ+
	 1ZwYb0vvBLSLzMfcuRlwVZr3RY/jdFdU/nbPcDaKP5bxhFg+cfwSEEInWYWMbw0Z72lEH
	 3Ydo+ruQjQDeMfO3sRkuF4OWSrxc4BEI9SwvwrQbXuU6M/IAqaQQqP3u9toS9I6vBTsls
	 jCob/L6XCBgj7ejAkRnPyxWCcdVjuZ2RS89d6o2ZQwCMIMSjvUKCu812Nu2jY/tTOLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003418;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=bTTdA1SPCzLrgpGpEe2XT3i4HGRuaa9qnemgCW2saGQ=;
	b=eXI2oFUNTOcIs6tjRWh75/vwPngC2kFW4W8qMe36TIR+hlEdEOaCmM8exXZIixkaq3+I
	 cW2dbPuC+BfX9Nbo1pYuGV/2aTWJPj7Kcz8WZ7vZCFN/QrUlDHGKOFHiOkBz+llTyBqRz
	 aIRwfHXHEn4CCsJI9mN0RJSQiAgmNj8wXAwM3mcX7jnBvy/ctu1SZFaVB09ucL9LG0baS
	 Mwi8xh1yVxDnIZZ18Z+yP1Hvc4zgmiL0r8yLw8KQEwZ/KMJJJkKXqk/uVSxEq/MTB4NjB
	 H3M5FsV0sYJZXMGTOD6cMmju87rhnc2Sp0rAPiRnyPO107wQf/wMpCkqqaU4wUK7PzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Yn8mWoJx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3LfeYXS5;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B82606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 22:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37B82606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Yn8mWoJx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3LfeYXS5
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 81F0FEC01BC
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 17:16:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 17:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794003417; x=1794089817; bh=bTTdA1SPCz
	LrgpGpEe2XT3i4HGRuaa9qnemgCW2saGQ=; b=Yn8mWoJxcBKUdZyBgT3S8KzPIm
	wB5QgYpr8YXOMaIUTH7lzhEKFGlyAV4RChrUv+YYDnQYOQdycuMDtF0RvkdWP4IS
	q+iEgNEMful8I92t/FPC88dzPnW3ONpj9GgwDACs6TDIYma754RdmYejKryCR0CM
	hrUf5xTCa5ZWtjOYrGRjuTNV+vAXaz8CELfMfOX7TlNWfy8DO6OXyLH+DMH4pLJr
	6FSNNlpDwUdB8ROqoFueK+m0tcGGotO8F6MTFwXChvRWC481VopGedKnM8TKO+zJ
	XFfnAM22kc2YC3S/W1jKkjfBUhcRuB1Kx3SFmnCm4uthvk4T5wkL5H0oD2lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794003417; x=1794089817; bh=bTTdA1SPCzLrgpGpEe2XT3i4HGRuaa9qnem
	gCW2saGQ=; b=3LfeYXS5SxNd5yO6oGp1H3J7qv6ac8IgymTMW/2AuWyZf/cd7Ag
	xRiKkh7EpiIDEyy71YFXci2TfpA3qz4GEXSedZAEs1NU7Q1mYjLNj+8QwsxItuCc
	x+msJbvsnYjIuDz+IlWdefiekw4xJfjnlWPRYgrSugDtsQ8hHvtFkvI3xnlxzRYq
	RHAdUk/R/zGoVENx9/gNROpGSmQ6thiFYhv9OiRjeeRLoOTGvTWtaNOVKgI1UcWS
	kYV+CvFj08nOKfbRk1WWdFXh7OljJtEDribReUzJZMXE8etPHsXK+CcLb8sLdxtC
	xmZgkWkWJBh38d4izZWlx0EKzUpzOg+bJcw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794003417; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NdOJNfR+RIGx0zCOAXrNpVFuPhk/LAgpCUMg9FGtm3Ttx/i
	GGfKFtYFjsvlfKiEBLBFDYkEZr7Y3PYiuTfl/jJlyezSaJV+J3CkBtVB45gry4lf
	dKL9m9c81MfEDG7kbQUtbYd60Igu1P+xqVWP3cTZoRb50BbUYmd0pqXpa8VQSdFI
	CYXVjsz36DB7fywXMPKhEqgYnuvjht5iVBBsrNckll2rhQglUJJjN9PlqUiQRko+
	xs3MjqS7rAR0UE6UMtWvlB8Zo4k2X4Rz/5eLWIGBcqKnNbuJvNDVqNjUj0cz3HEF
	/GGsLHYZVtHCMIU/7H8SAaIlfOn2X37ttHN89fw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:yS8G5pMSpxoIijs4AyTtBs9cZeKclN2iU4qdLL4Acb8=:rjNcuB328px4OCaw28RTD4tcWl8zrEpD+BthWoWEHX4=;
X-ME-Sender: <xms:2VHuamHYdHYdpLg0tVGiTtlffjzqFA_gFtVxptcNC-txxBFzMrt9Vg>
    <xme:2VHuarCIBPlJCO9_Qny4KmFWURc_3gwy5dnrseQsO5oqBbcOQ_-dDTr7c-2x6yxS-
    -taWfncFeOeP3nDJ2wCSnqEs-ZC4LdPKDDObt52KCz7FIBRSj9_jhE>
X-ME-Received: <xmr:2VHuap-tvwSQj0FHjW5PJamgW8GNoWfMdNm5Fr9jU7I1R7rRW1GtWgpL2JTwO9wHVQJ3hBv-Llzq-lcQ1STX7ETRebSiGJuSlZA9>
X-ME-Proxy-Cause: dmFkZTEBN0vqBl7SQU369nDBO3srsJmccSMganvyfC/lNONDFXUGRLNhGwY3Hdg48kL+Np
    fSc3QCJRQd0gN25XGORLheNFXKnDRhs7zyg2O7gL9lyBfWDog/I7J5A1hwtu1VrZzR10J9
    TSOATo+/MmUkk7Z6oPs7NBQvi0bCu+W2NZtgWt0pZ8X/bEy5ijHOOL+KwMbsI9g+dYH5Ot
    lk6vxBWQMsjcCcZrbeuGsMlftHAPcFVvjnhs4CUB97H/SVUmg1Vamji204HUmlG9KRHwa2
    tvRpoW9kA2vL3Mb73M0cobC2uVJ1vmhP3kRaxDSYmE0/C6fvgCYcCOsvr+D+7bHkd3UEcI
    SNx7pdQf3G5tRWYj7eexAnuIpTlhXDFXaCf5VBZyALps2KbZ2mWnfr1sfRSM7q1JkaWhQ5
    BS+PosEBVZk1o6GyxJEOFcjb8M+8uj+Km89dWSGPJXi2/nv13MmMGrzEWrv1+/Uw6lhNXa
    ciy11phIJT3XUad3UmBD+9xDshwb0LwZO3juQFjjSdrF3vHxm8W3zQeqyze758QBN3+/2w
    H2TqiffI7Stm60kvnRatqudAkUmc8thnQDM7VFq/kSOgsp07zkjqnSFXapgqnXTPp9mvdS
    NQFNKohXdz1ZWx6YGsJApDXaAC2d3iclVbXfGASC/8IQKo8k+zBIOAxZjxRw
X-ME-Proxy: <xmx:2VHuanA2GxDFMB5tJubKVxw2UEHmkPdCfrwicMKKlP7w5MJlhn8mxA>
    <xmx:2VHuauScNAQRghAlm8VFxb4jy18BxdVR2Y2MNdeMNeKcPdKcVus__A>
    <xmx:2VHuauvDu_hBp0szTasiz5Fwe9ZlMeHPpsdbZWej79msIp04MXfruA>
    <xmx:2VHuaq0DpA5W7hPH6UvC5HfEyA6EO573NNP7Q0ACFWPE2tobHl6CIg>
    <xmx:2VHuagrGqVqOeMxJyUF-HAUH2JlDgGB55SGHN7twsuUO_dtXGm3TKEvr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 17:16:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 2/5] doc: glossary: update per-worktree refs
In-Reply-To: <0bc902f13d89e2b6c692ae35ddfcf209b088ea0e.1794000450.git.andy.koppe@gmail.com>
	(Andy Koppe's message of "Fri, 6 Nov 2026 21:31:05 +0000")
References: <20261022212903.177261-1-andy.koppe@gmail.com>
	<cover.1794000450.git.andy.koppe@gmail.com>
	<0bc902f13d89e2b6c692ae35ddfcf209b088ea0e.1794000450.git.andy.koppe@gmail.com>
Date: Fri, 06 Nov 2026 14:16:56 -0800
Message-ID: <xmqqv769ehbb.fsf@gitster.g>
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

Andy Koppe <andy.koppe@gmail.com> writes:

> diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
> index 668f309a6f..c7ab1c981f 100644
> --- a/Documentation/glossary-content.adoc
> +++ b/Documentation/glossary-content.adoc
> @@ -494,10 +494,23 @@ exclude;;
>  	interface than the <<def_plumbing,plumbing>>.
>  
>  [[def_per_worktree_ref]]per-worktree ref::
> -	Refs that are per-<<def_worktree,worktree>>, rather than
> -	global.  This is presently only <<def_HEAD,HEAD>> and any refs
> -	that start with `refs/bisect/`, but might later include other
> -	unusual refs.
> +	A <<def_ref,ref>> that is specific to a <<def_worktree,worktree>>,
> +	rather than shared between all worktrees. All <<def_root_ref,root refs>>,
> +	for example <<def_HEAD,HEAD>> and `ORIG_HEAD`, are per-worktree, as are
> +	refs with the following prefixes:
> ++
> +--
> + - `refs/bisect/`
> +
> + - `refs/rewritten/`
> +
> + - `refs/worktree/`
> +--

Very nice.  Do we want to mention, like the root refs whose names do
not end with HEAD, that we have no plan to add any new ones (in
other words, new ones are meant to be created under refs/worktree/)?

> +<<def_pseudoref,Pseudorefs>> are also specific to each worktree.

Prefix the last sentence with "Even though they are not refs, ",
perhaps?
