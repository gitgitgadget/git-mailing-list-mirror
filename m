Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097923;
	b=tWym9qD5B5p+PHibL3/oCera5cDAok2HcAFaZQO1j/kEPMROSriLDHTOyFAyEbt2Ht69
	 dubP1zlqutNwU/YF7zQmC3H6gB+Ip0CvaJO8Br+z7KR5kVoYFAu3+U7SZYuTSvg9GhsFZ
	 9tC1X9AFaHvobPplfKhmG6wPBgT9lJ+wUNj6cW2j8J0+iZGmgpPGdJvpIMnq5eQLHDxl/
	 /EuDT5Rdmw0oxWV3D491wngjPz7XZKpkgRlEO4dnewnvt5BzEtCK17lavc9mkFgvEqwDk
	 7waesBlzJf/6fZm8ZtIV8Nzwpf5SgG/hheykdFEP/HJ071Mwt59t+ufK86+PafIbF6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097923;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y/cZ7KQR01WEqDLz5NjN2MXB3WqkaG9HfVNTt5Mf0F4=;
	b=tyXWdldocffdr+ybxyOXxm7fMeS4z1OC8kwraiuIxaKjza5yhf+KeShSJMbKqFjGEgvl
	 fZgSQbXtPOaTbhTCWg4WF8c8UwiQllLLGgCGSOUojMoSHEmJB7+t+Wp/UvO7Kx1KYGwQh
	 JyWMDuIjyEUH3IBs45TV6JeyLIlTCS9bxs43tYxuHM/sFTIXyD3PLd8XrQfN81TJuKZha
	 2Jm5ALD3Iw1KHUGGcbrcgD75ZHxnQ+Cc2wcJ0YbVWVGPKFLHkWPgkdcrAQqJyO4lHnwXv
	 aI/wuhcIrzsCqdX7hTgTMOmN/UPmeO+L6z4zz6clVUMfFeCGqAOdV8w87JAZhnmppJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=qu5Xcezc;
	dkim=temperror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="gyJ0NFU/";
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA9606A31E
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3FA9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=qu5Xcezc;
	dkim=temperror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=gyJ0NFU/
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED88A7A00A3
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:45:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 06:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793097920; x=1793184320; bh=y/cZ7KQR01
	WEqDLz5NjN2MXB3WqkaG9HfVNTt5Mf0F4=; b=qu5XcezcgOn4VbPik5P5HYTO38
	QmVIlbYOfgUKY0MHZQujcYlD4HzKF+KW3oBXqF7nshUfIXrhSfw61CosbAP3usqx
	BxVdJmVIqBnu+9YndNej6FH015w9RScswhJEg4VQNnLMQVv+QYdlJFIw0t8PKqHx
	C/PboPrbqtuacJGvHec3yA60ffFhaYzKAetkA+y9qiJjDlNc+B4CZZqNOkowFY/K
	Sb2IjIqxMl3FnlFvFmxyoVu31/sQ/aKJVACKfZmS9hlRLd4B/w1/Ik4LI3f+Wm3V
	8cz56vO5/x91N11L1C12SR+TQ0ZejD3hGkSPQgGWqM9bAFWk+FX3JFdZAavA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793097920; x=1793184320; bh=y/cZ7KQR01WEqDLz5NjN2MXB3WqkaG9HfVN
	Tt5Mf0F4=; b=gyJ0NFU/Kq7QVcbbUz74dpZr8aWFgUjr3cUR+0ETsioIjgOw5Pr
	dekWzM6UhKzvCT8iDF+enW8MKC250kTc6ck5vqPaVyDeYlkJqTuxzI5nxrB1CCok
	BMb9o/Lren+b4fvZ9wlhSEtw6Xsm0K/+a58BSwGyT24gQxcqFjUxk0ZEJFm2lFJS
	/OkNoAtk1wda7Hj1n5/DKpvqF2/1B3+49CkPIdPTEKq4Bjk0COBzmMigpdvvvSgF
	ZaxbPt5k1i9Mc8MsddAon0JooG4+P8S4xKMqapxfcU2Abww+goEbKKEusM6GC5H2
	Tp6CrGYMZkf9cIylhuyafOZoWNKTYJdpZaw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793097920; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ILrwQHPB+yJOoRqOdcnuTF7Vaa1Jyo+TxAPbTT1hqdCs+R/
	wvBGMbfQgACTasdvV/9to7HMsU9ZHqc8EFEda87BkYjq86D3VLdu7QjcpDyKmuaE
	Pl11WRdDlBhIsAe7RWw7hRVEVxo/05vo6MWY/YsWMDQZEZg3ErSDQg8FbpoWBFr1
	6Kr2RVcfmxnIinieARiJM5kE+CZDSCjo11d+VXKP0vURQ0QtlhUfT/JuBxS43vd7
	q0IvGh9hTwEwMCAxJeleYm3eUu3r4W8SA643zP6yqIa2xbz8f3PcwyyYw+3OsYKx
	YTWPlLynztDQPNulSQuiBLkERoIHw5Y7yrjUYwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:KJtgWlZ+TVyKcgfwKLRTNFEbuJ3GkmGEtMpYNI3A4qo=:XwXCpMc1Biafp0oXWCOmsX/c87Y1CgawgVNRK7ZT/Mw=;
X-ME-Sender: <xms:wIDgaohygC-AjoBCI5Nxyr0bH6QCvnHaKjC3NGpGaH-r2t_h3pbSJw>
    <xme:wIDgaofryNdH-RrO1THsSVwHMy9obfMATiUAIlczA34OBWJp74jez3H4x3Wbs7_Ag
    c8H4YSW8nltMthUyEX2oIuG3I60ZamVJFBZLmCFx8Hv5O4T4_xtYgam>
X-ME-Received: <xmr:wIDgateaGctMIm800NuNckb1NT_vhWyeGKPdli4u4LeRq61mJznQRQ>
X-ME-Proxy-Cause: dmFkZTFglgfK3OGtTBUarTKp66Bs1y1/fm9iBBOu5kxF6wbvmu7bgnktrnZ0Y7C54vQ89p
    UMV7kLW9oNGOIuVxdd2ceSrHIv88C1nCWNj23466NpMVsv9B16lv7qND+Yz8n/p6SpjBYv
    Gw+XCLVuRTL9f+AP/JRJXKYOb3my5d5FENfDxYNo+4UQ9aY4+SEev0xmlLyHegkM9df3UG
    2T53V/yaFZhAkxTpryFepby4YkfdWg84dE6Z+mOho9XbSgMGsK6yGn5bK+gpNc7d1Jd7wz
    Sxs5kbNJqa9nmjKE0Z2sKTq70ej5gGRDLSj1LIKgPZy4873JEYX+CZfxGU0s4IaI8oyog6
    PANeO+nnZNsp9TiGP1bbGpljTraymRvKMD3IHimEPd1qi/i6cC2B+4IGmVsV88k/D7tt7s
    bo7OCmzuRN2gXEOl1r21v8WoJ2CSb77xQjuGK6WY3p3MnxUXaTDpKWPE7TfSNZrdM34FMR
    uG6APdDqgRGxADiDXQY/wRxpC5HjNXmU6yFgQ7o5dvRdGWXY6Hdhr6FO46duyuHzQ6dl4l
    SLH4eyKFDCkXjfQ9AN3KomX7s6P1h+m5i1efI8o8a8t83BSCkiNQ/IbIs0c6pYquMVOL5z
    AHZcjSXD03KK2v/5H3URtH4/QipFQiVdXXnMZgZW+WfpXnYx1NVMCy8dCdiA
X-ME-Proxy: <xmx:wIDgai-bApTvvajF7Ln_B6E05Iiw3EREIIe1oj_n0DGNDQsQwyuVHQ>
    <xmx:wIDgapnIPZhS-pmaDQAppAJmg7F7n_cpx2jtvgjxHypEpFvyclPmfg>
    <xmx:wIDgak9gJfoslTPTN9xVNE6tO8CZdhoYUPukMCBAvSbslVIXf-ymSg>
    <xmx:wIDgankFGM_l7wEw8YLw0MBt4FGmtSbIrz0-mhGsDiLPBYTd7T58dA>
    <xmx:wIDgaj7kFSx-m4mv3cSKtso58jpj9KW0oNS-NDqjtsbAfORQbIqLbQ-_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 06:45:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a270f078 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 10:45:17 +0000 (UTC)
Date: Tue, 27 Oct 2026 11:45:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 0/2] ci: fail the build if perforce, git-lfs or JGit
 fail to install
Message-ID: <auCAsdCsZyPPqWpc@pks.im>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
 <pull.2403.v4.git.git.1793089936.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2403.v4.git.git.1793089936.gitgitgadget@gmail.com>

On Tue, Oct 27, 2026 at 08:32:14AM +0000, Harald Nordgren via GitGitGadget wrote:
> Fail the build when perforce, git-lfs, or JGit fail to install, and drop the
> warnings that used to fire on every platform regardless of whether it even
> attempted the install.
> 
> Changes in v4:
> 
>  * Drops the && chaining between the wget/tar/chmod install steps for
>    perforce, git-lfs, and JGit, since under set -e a failing command inside
>    an && chain is exempt from aborting the script unless it's the last one
>    in the chain, so the chain was silently letting an earlier failure fall
>    through instead of stopping the build.
>  * Reworded the quarantine-removal commit to lead with the observation (the
>    call does nothing and can go) before the history, fixed a dangling "this"
>    reference, and added that the same holds on GitLab CI's macOS runners,
>    not just GitHub Actions.

Thanks, this version looks good to me.

Patrick
