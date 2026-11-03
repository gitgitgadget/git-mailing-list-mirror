Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705400;
	b=BnOVkyz02SfN1By3ZDT4+KC0aV/W6loaIG10AzLX+oW3bsrjnLVjSAw1NoF8F8wxetH/
	 JsTZ2s59pWzWmE9FJhDa4qWOLAqvGx3ZP8/Qw0iTVJcPNuyOPNJmmQp41Bwaz57ES2fwt
	 TcXXKHoTtOx/HEsdJM4TPFnLgpj2+Y1f3QCg5dQfUZ0dzC9OMtzuljQrm06jnqNvC9HtN
	 4cK72552TZxj1Tioh0uPdt78W6Dd3wc6Rc1vGfL+SloPbkMv85VbKEUUyUBvG5ImgqQgN
	 3cqEn04GuVIeGDXal36AhMl32B6cylY+fDRsogEXKoq2TWWc+FiTGzXSzZgmLLwwkTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705400;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=INVJjQMsvJ9VZMFdRJr9DQ+tBCDgNmmAwdyNxdvwDYE=;
	b=RT4+QRGpL6ZQngIvh4CjOoNGcDim028ffipJnwws89MRAl8M4z4qLamilYbFGTqiguuX
	 uwbyhO7Ku0n0gfd2MurHHcy2FJ604OLpIwAvmtRI9fRe6XN/W7H5bkdTRYoZUIGvMvrzC
	 HEc4G3t1HlLh9mhhwCoK6ENv7g4U/bbx3mX6ioBilAvzk4gJGS9WdTIy3OtAWmkzWHikf
	 Y1iiU4gdSwVwpAOLb2G90DMjBYubR6xNFTXlwd0NJ+F/3vNKGR9TV8Y5753EI/0E+nEQY
	 7E7/DU5AJaR8BqTkOA4lhl9gxxkdjVMMBw83jJhreqFGkYtidfr1ZcHBgy7BVX5S9eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=QQHKJFg7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rfZQJ7H0;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E0606C569
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 11:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 160E0606C569
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=QQHKJFg7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rfZQJ7H0
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4AE6C1D0022B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 06:29:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Nov 2026 06:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793705398; x=1793791798; bh=INVJjQMsvJ
	9VZMFdRJr9DQ+tBCDgNmmAwdyNxdvwDYE=; b=QQHKJFg7rpDVtSbJTx89d9sdDt
	L/AhsUpL54D8eyD0tWEDGRfsR6LxkhpwRE/bQurMTJct9JT6GwyNECVLI0aovKeg
	446b1N5rgDfZdRUEhf4nacv4ya3/aBTNWMThrfwbSKPyptQAsz/PcZSTl8qGS5Jt
	b1+1C6Q6+e7nELSKfp/P+Ro2opih/FQ83zyMi0OYsNbC+Sc6toC0Cgfadfmk6sM2
	R8tTn25Bo30d5PTBMMPq0JGlMMJQ+cfOvXMaNrPqHG3HIY2AxMLueHgods/mTl57
	oKM1/CAP4qg8k7Zq5XZeJArf5R7AvTiivOTXWb7YU7f/pJhElo3ogB04tZiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793705398; x=1793791798; bh=INVJjQMsvJ9VZMFdRJr9DQ+tBCDgNmmAwdy
	NxdvwDYE=; b=rfZQJ7H0IYvRJz2+PYoX5FlXLqmuDJD94Sy914sEVnT1MF3LXPr
	ypRWy4BuXjlLte5WKc4QgPXFoU44WwxDPkBgFngoDWzkRxD41j02C7PFslSZqVth
	SuvIeBM33eNfkBTpSM02i0rg4i5GWF72S+8MiFYXmJWPyUDrPVCQcf3Iv0fyA3r4
	nu9xF4C31033jyptcUUE2v6NfkB+A+PwntVgIDCB9K9/Xfym/YSvar+u+xA0hOcP
	/StfumbaroF3DKKO/34r+Wbohugzj9pal5cngIRxKmagZytx0XvCYd3moZvGpaRO
	mf6DMpwbXL7/WDi8BUwI6iTE/H5B+bxJWkw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793705398; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:LBmTMV09cwWqSsHEM2W3otGBqf34QABC8R6Z/ZPeuKwxXj/
	3fTiGu18C4cKzl7Bz8zAvlgvzvbBDavXdXF9bP5gTayX5oCI0+fo0QLG6SVxhYhO
	PMm3v1ISonr6Y5W5I2SON0Hcc97E8CFBXeX1HuHjizbUl/5KMi15pSb3flFMinUR
	sCYffXdzXCHjutRlHY8QuThZy7bSPJd317noOw6fgFS6UJ7q6eedCYp5g6Au530c
	drZbotp7Q33hT7AXn9B7YRYkZBfKfv300d730c443HVN2LewQR/9Pd9VfRyxmChf
	78sWKT+E33Jmy83Z81DfmISBE7r95RAj+PkUpiQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RbjOH0YGJcF95zjqIKYwyiCL2wDDmISuqhV/UwIW8hs=:rN6MtjPDANrbyeNfH5fMlMvgEY5TJG0j33UZEpqiA7c=;
X-ME-Sender: <xms:tsXpanDaNBeB09H0u7ZRZW4YosR9co9-ca-NqXAhOSZMyOv21_4dzw>
    <xme:tsXpakhiMEA3NMhs533eOBgYTDunYosc4ir9-13lllWuQ7Z6ruzWaOac6a3hJxmzz
    X-a94a0-OUMQcayrnYyDSO5cXOXRNoxMuXSCwpJ6CCRQ2r4BPjAK21t>
X-ME-Received: <xmr:tsXpanmWMEUiT8ULIXc6SoY61IDN3sjeZWHsBeGIHi-Pa4NuItplVQ>
X-ME-Proxy-Cause: dmFkZTFhtpSfkmIhik3CNpLEcjnopBeXT+0q7ikUzgzXra28TY7meHAIazuymjnPsssJnD
    cgbeWGckfa8PV77DTABqUX8Sqs25yvJh1K5bo0jt8TN60iG7Y1t5wmQgMk+7i3aSvYdduD
    lXdKYk6kb6z0ymlFK/8rJdJkBF9GCh3O2sLJ47dWbP9m4sRCq3CQKUWPVxBfUrAcoebed0
    tAP4/pdS3MAbGIL2/icMHGVI7VAP9xgzwjdpysIiD0OFJjplU0vb09C6V1niB0qKgZsH6z
    Au0qWYfHKDmMy9722j6/C1KHk0FEUJM8eCOd1iPg+sI/TUbpJwJ/KmZ2ucxyVHS9qirRL+
    Q7vwx95SPxV3tfXp2CmOmIku6c/YoKvMlV8NXt0DyLc2A9pJnKxWWlNbSrF7IEI/3r+d/N
    GjKXQO2wcunHlZ1KwgPAs6ty2rQKEin3gTMzFhMsIiocWjWW752HTkHkeq+W/3S5oeFSYs
    LEJ0SbiWLJLqthYk+wUaHP3canoX62Et84aTwrv3XbE7p06/YIFsGvYCB1cVn+92MOl+VQ
    i97yVHUdIPkh6ecyVSZNplYUH4IwGAU9DdByRQd+iNU9qOe4tCcr5QQEVXadKxfC2m/VMP
    98GtoSIm5BT4gv0d5CV+hxvq3/OmMo/ptC21p70mk24wG00WWoeFsCoBvgYA
X-ME-Proxy: <xmx:tsXpaorVjJtHpA344gmXOYkCM8hcolxmJ08mHUKEvfBJIdbKmLph-g>
    <xmx:tsXpaoEdSvcUd09OFHnegnjigdwETrmLpMlP9pWPyPKPo_w1FmEKmQ>
    <xmx:tsXpaszDkkB-19ivU9L_GKP5PDFeO-nQ3cmBawfVtwbURKOK_Izc-w>
    <xmx:tsXpalq5YUpEWApj85q67CSFcjiFeahNImO_eTxdYGnrKLHMq6PtHQ>
    <xmx:tsXpavEt6tV94SWNfOpZVYwc0P4hwp46JjGc098Hj_7CPnKHnk8odPfU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 06:29:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fcfaed53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 11:29:57 +0000 (UTC)
Date: Tue, 3 Nov 2026 12:29:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 2/5] doc: glossary: update per-worktree refs
Message-ID: <aunFsp6B2rNJCXTi@pks.im>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
 <20261101230326.3675597-3-andy.koppe@gmail.com>
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
In-Reply-To: <20261101230326.3675597-3-andy.koppe@gmail.com>

On Sun, Nov 01, 2026 at 11:03:20PM +0000, Andy Koppe wrote:
[snip]
> Bring the list up to date, and refer to git-worktree(1) for how to
> access per-worktree refs of other worktrees. In the "worktree" entry,
> describe HEAD as a per-worktree ref and MERGE_HEAD as a pseudoref,
> rather than listing them separately from per-worktree refs.

This doesn't match what you're doing anymore, as you don't mention
MERGE_HEAD at all anymore.

> diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
> index f905b4467b..67fe49b26d 100644
> --- a/Documentation/glossary-content.adoc
> +++ b/Documentation/glossary-content.adoc
> @@ -791,5 +804,5 @@ and pseudorefs.
>  	"working tree" and repository metadata, most of which are
>  	shared among other worktrees of a single repository, and
>  	some of which are maintained separately per worktree
> -	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
> -	per-worktree refs and per-worktree configuration file).
> +	(e.g. the index, <<def_per_worktree_ref,per-worktree refs>>, and the
> +	per-worktree configuration file).

Patrick
