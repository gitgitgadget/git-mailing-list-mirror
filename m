Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692877;
	b=kWNwLRfKm65Kl4J5b/Ui9uOSp8SWiTmQXj2NOLEQ44BtK2fCVf7sKPsXkl8KqYrqhQGU
	 lBJLFihJSv7bPRF2sDeGepgMFTNkMMnrRfxf3cLOXKxTQRRAZA+h2cGfNO6c31SzJOtYR
	 VJPKRI/7GugtMn3YT8YPv5YbBlWMGJq5L8t8PbTOf4bygBgZQ0O7SqQLYOLCIN83HGlOI
	 o5vHlNEEGAmXdCPhrkMrcfrTPNDt34/aSKkFLx8y9pTDX0e+pgN8WmLy3KzsvowOIvlVa
	 mfk6ium3NL026magogHUYrpbSnBsMoiIfbS2Av92bNLeNORHrv1Qf1E3OYN2p1Po5dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692877;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VlgO0is4HZeUymczOLSe1iI+vUtIbm7rtHJrChSRN/U=;
	b=iXg7y5QwfWaTAr/wt6AyEZKKYG2pSaKLsogKk826jUKShfVv6RfkkA18OFonmXM8GP90
	 2Zy/ZsJqDYz+TFSVmsV/fH7CWW0nbjVHTAPNbVMlgMPGB/CsrpeT3h7jpmAgrcujZcudz
	 IPeYCtKL8mRdBEuH0pHUN7kNnUNGE52scF/F4w2oHvVCcYUSr1jx6CIqJMpuEIzAKa4ox
	 kv5HeBPAVVWkG0ju428YH4FC5cYqNRvMJt47JSGWKO9Sy8ffYpxcj9hJCBjxJWms5z1Cd
	 pPQ8C47a1QhAiE7C512P2+npAzw/ij8hzZ2GGB/GMopU9uu420IgxjTqk7aze53ES8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="E/PvUS7k";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=w24HAbqY;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5368F606A32D
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 08:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5368F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=E/PvUS7k;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=w24HAbqY
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 99E171D00039
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 03:01:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 03 Nov 2026 03:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793692876; x=1793779276; bh=VlgO0is4HZ
	eUymczOLSe1iI+vUtIbm7rtHJrChSRN/U=; b=E/PvUS7k9y3go6VQiasKkvbqom
	eoVF7W0/vn2IwxAKAr9CCk78jKyvY4ruux95nqT0NGS+DTjNUXqi9IRmVZfuw3Yg
	Lwxs6bEodZoRnHY4Ukeg84dwKPusOPb6gKUMc5JNR/WotPMvsn6crGO0CtipHRnz
	ECOyLfixSFbGt8aEtBjxwX0wSQ5ALuFjPL+0Gxdea4FonBulnIJ17KjcFM+LpmQn
	mChELLUJLk0RnReHpPyCXsTml3WCtI2yPDTBQaV7h5FM+3m1sbWgQwyl81/EMErJ
	emtZL/pmfO8oR+RxMJcGgMsSU0D/Nj1xcL7miRff39n2a2rmcxhVbd50nGHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793692876; x=1793779276; bh=VlgO0is4HZeUymczOLSe1iI+vUtIbm7rtHJ
	rChSRN/U=; b=w24HAbqYvaicHqncEDIifAljlAS/Ogrq8dhFUCyjutcuC17T6wz
	mfg31v5J9oPGV+hREXcW17+ZZEDA/OEvvlrUgjbpzqs30mMX1s417Hw1VlqcXuTC
	6f8mUL/UaXlDHzf9L/BxrGkg8wB7B3oLqd1l6kJi1QAovPsOZA4gcByW4R8dVOMu
	1HNkB/P3Pg1vFkJGe7h+VUAvxk0F/BSLdx0AMn8AJbVmO+NcQLhTxo8n9vE+TGca
	EWjrhpC+NUjgIyhx5KasvRCfBXMf4qzMfG30Y4uPfzlKdNWq770a2/LZHfRnueXy
	PIpd0PelNuDNhPv5So3IM8gmHiD0PnBtiVQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793692876; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:YZucOTCMNUkDoQgLiAg023CTyQNBkffvdQy0fK0lzqta4jv
	v1cLpH4cPc+VNK2aodjQm7IzerpXK35IhoB9wuFb0VgT+JV1MlyV7EvU7Vi1HyYn
	oAtLC40wlBH9RIyCtEmX/wpLyRPaPUfPVvEdrIxrEGsjc/OHxbXOZfjbjFtT+ar6
	9C9l6umx0T8irGaOAwwDWV6Q/Ev0JC2H+aEDNLMgUozaFKV3I2yRd8pOaMbzF1Pj
	JbUFIDKIFgu3RWcH2Tuou6mb3k42NRUw4o8hwmvAKACG9ZPm7hUGiVh+Fvey14R0
	2eBO4YhOB777WALEqOuPA20fHN4o2n6TIT0TlUQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:B5tMY1tz/mIhWAYCcImMVQrJ3nk/Tll92dYWE6LJ9X0=:ZJP73ZVTicC7p17zubmZ731RecZWdBCRQasXm8y/FN8=;
X-ME-Sender: <xms:y5Tpakl1yYonKdz4AgVQIPDpRIh1OJFC-SZB5t6OV6ebheRZNAIXlw>
    <xme:y5TpamGKQINpS6I-iPD7WBNZJCItUI6jRoXOeddB5suT9txqaY0BOW2DqZW6SZOjE
    S3hqLO9AJuluSrw5lVG_ul-bTlZCBlgTebJN3ra1DIEkL4eccSEmz8>
X-ME-Received: <xmr:y5Tpak7tfXkNLD8T4v8j1ncWku1qiUbITJ35wy1jtPM2go-_FzWCBQ>
X-ME-Proxy-Cause: dmFkZTGohUvRIOQRnm96HqDsmycmc9NfNQ0PahCCGPhwlMhYdBIJRJAWgGQII9a5kw+L5x
    4NcEOTDAsfDGjAdH7LrisAnNIqzqlfqXu3kPvt9Uvc+m1i3kOxg274XdYzSkRBBBrVDPQD
    j0F49ReoAGXOzCPmFOcMsC5AqcnaP8v3QV4s/L7+HaGvZULqE9gR5TycUMScLYLkmMjAbv
    6n1lZbvRsIhYBGP++OhCKXdrp4rjfIFinPz1a/zaqMy2Em0ta1ovYml9J21Z9UxCIBvnek
    uHJheUIYFSgTaWKbvtqdn8cDjVWgi/CkYE8ieefcyZxJFaW7mYcoPfr8SLrZeMfck0WuI4
    Dwu5z3bHfIPM8b5o2ugySjc+k9MoBDXf0po8/w6tfUzMhV9H5OxRy2LDvpPG6nMAuYQRPH
    95XG5ioM7E3UerohWK03dgUPV3VEa2h55/pl1k9kllxmXDFHUNjemj+dx8FK1LvJF2eO9K
    Be9bfmu8paqpU+QzY7/fsH6ef5nDJ+z/6RuojV4e8TEIWO59j6WA1Zv7a0FbP6fzasRbv6
    UQAm4MLrQcbd9p7tdKaFEluTg/Kya11snc+U6N0yW3O9zAr4Aq1L0jICjTYvtRnKage4eb
    qcCG5uKVws+2Q142UgeXD+qku9EwplzE1wd+i3M5CknLX5M6omrOIMPOuyfQ
X-ME-Proxy: <xmx:zJTpammMadQoeNOpuX0FdT4wU75xWClBu9pOZIRTO19B3kmnD8f3Vw>
    <xmx:zJTpahrzlwvvMp7qBY92_dHQ7_LQAwQKqlsOE3vn8O9lXWay6VSG_A>
    <xmx:zJTpats9YW6tf-HqqEZYkq6PJEawiGqVlnhOmRmJIaR5uMbR98_V6g>
    <xmx:zJTpauFzuMDGRCuvpsFFSQZjZGGyR87tfY6ITD12h2P5Zn9M9xc-5w>
    <xmx:zJTpakXGnlT_mv-4drQR1BwXFvnt1tMzxYNrfwFkLnTHxO28GCQMXseW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 03:01:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a68e749e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 08:01:12 +0000 (UTC)
Date: Tue, 3 Nov 2026 09:01:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, M Hickford <mirth.hickford@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 1/2] credential-cache--daemon: allow a concurrently
 created socket dir
Message-ID: <aumUxF1uVtVC4qYj@pks.im>
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
 <20261101-fz-credential-cache-race-v1-1-28f0bac51e11@gmail.com>
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
In-Reply-To: <20261101-fz-credential-cache-race-v1-1-28f0bac51e11@gmail.com>

On Sun, Nov 01, 2026 at 03:29:25PM -0800, Farid Zakaria wrote:
> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index 65cc619bec..0dfa11e2ec 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -273,8 +273,18 @@ static void init_socket_directory(const char *path)
>  		 */
>  		if (safe_create_leading_directories_const(the_repository, dir) < 0)
>  			die_errno("unable to create directories for '%s'", dir);

It's quite curious that we use `safe_create_leading_directories()` here.
As documented in "path.h", the `safe_...()` functions should only ever
be used for creating directories in the ".git" directory itself. In
particular, applying "core.sharedRepostiory" to the leading directories
of our credential daemon is never going to result in anything good at
all.

So we should call `safe_create_leadingdirectories_no_share_const()`
instead, which does not apply "core.sharedRepository". I know that's not
introduced by your patch, but would you mind maybe fixing that in a
preparatory commit?

> -		if (mkdir(dir, 0700) < 0)
> -			die_errno("unable to mkdir '%s'", dir);
> +		if (mkdir(dir, 0700) < 0) {
> +			if (errno != EEXIST)
> +				die_errno("unable to mkdir '%s'", dir);

Makes sense.

> +			/*
> +			 * Another daemon created it first; check it like one
> +			 * that already existed.
> +			 */
> +			if (stat(dir, &st))
> +				die_errno("unable to stat '%s'", dir);
> +			if (st.st_mode & 077)
> +				die(_(permissions_advice), dir);
> +		}

A bit of a shame that we duplicate this logic, but I don't see an
obvious way for how to avoid that.

Patrick
