Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566246;
	b=rJ710vWMXyVDKlfBdBaBMk0zINqYftmWw6NZ3kierT2HIL+UNedLesXGELkVbaum0+Mt
	 7dJjm37O9s1cMTRlTDYhqiyu2cvKeSG8X6ws8sw/9UDv5TZJxUqMgHLBft7ViF/K4XkKH
	 AighdRe8gPNbWrTl0usKMCbgHJQExUp24PfUQMvfCoJ8LFXC79OtYhfgNX0NJeQhDSqBR
	 NrgZDiBUQPdjxdlvD0UfMn+ooiC2xWhZq6PU+ASfXgsGFS9KKUWBl6dlGmyG/8iwxu/zD
	 yrgdaDXAOrHwnNT/igvkVkqkarUr6q7eIVvqMo/KT0p2ousk1xgztzGSeYJEEH7ocUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566246;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pzNIxl8CbR4BTJYG/irjxwkPc1BSVpBIyAUuErpJrLM=;
	b=v45WWMD3ALzIsql/sSscddWMm2Ly16SxDMl3KO7MiTWEQ6Pi9n35txHmjdXfWiVVCaiS
	 CKheo4PxoZWIYRuNiaLb/tL5G3JXiebVRELO1hDCSd53iHbAhSxunttlSpc7Y8y0JooP+
	 TWpTRLSdXDuhdxCchbgm+DM6aGG8wCN/7VPx6jXIbU96v2ZkqL7fBOmrkGhvBwRJwLZ9D
	 MGUU4+tcklhHCCczKjxfElHmsddCzC/fmVD43Vj6jZGNSl7OG0AQiJgsLJHlJ6x1umrVf
	 Hy9gHEqrkM6VcInxerwcUoJDg7C2o2xYZim9zrpKpolKMmtwbr9EykihDiglHFRJ+GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VkGwAJg7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Tkqy86kT;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D7606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 00:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B32D7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VkGwAJg7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Tkqy86kT
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D8CAC1D0061A
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 19:24:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 24 Nov 2026 19:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795566244;
	 x=1795652644; bh=pzNIxl8CbR4BTJYG/irjxwkPc1BSVpBIyAUuErpJrLM=; b=
	VkGwAJg7uwH7/srmu6g7QTTnsf/ujP+SsxwUX18KwLgjS1J6gGRCvrusii0Q963w
	nF7Kew+qnJ7rfPdRghLOLgVJe8PP62DhTPraNuGpVjvpbz0wqTS/NRvuDSI5/okK
	8F5JYu2TMASM0/QPDYOvXaebNKpC9cUyeZmPEFocW7HrDkVKMT962O8EvCO42jl0
	6TPZM6Uvcq4JH0/nCoqiV84O5Z4HMK9lq3KSMm1dSl4TZMFcJBXzpVLwNiPnANeo
	6XKFUKdYcGwYVB6E820xY9R6Gk17Ob/UIOR/VkKsXuC2/hNECQ61cvd07nsTFuKO
	nf2nTYoilGlt5VKu4AHAEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795566244; x=
	1795652644; bh=pzNIxl8CbR4BTJYG/irjxwkPc1BSVpBIyAUuErpJrLM=; b=T
	kqy86kTjaCS4e9YEDJs8BEVPnp1MtWh4xckqYcfbWIR9GDrhzlOQYZmiLlyAlTr2
	Q8hqK7zZYCvF1sPcs62qFmJOCpxw6MTWtlN7N6uVxiMkYTYfUGHQDIbXH1v6UMS+
	GEeHsto/ZljB3jpbtEA596Lm5+v8gHm/79i2HT8Gv8l0nGkuBHPTnBmUL2QcKB3R
	yu9I4b65h5S3PHCdpJ+/iqdscuE2xvsNrLUCeSkUtAjFcov7Z8QEQiHMhj8zjWJk
	EKo+1G2tMNqSqGNXFbAeVBkhA6I7Xcnn4vONrDtvymhui7wgRbxklXsRObv0F2q2
	ouMZF1UKGM9W42/tOkj0Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795566244; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RpB+UaqWVJlWiTcpFH2Bu9UZzMEnTj7PWN9cottIUxoDuNV
	boQVXKlDhxNWcSJdF/aOe1w5uQcbHDdJQPQLLalSpj9GyM3Ywkx+QsKkr1m9gCtV
	VePjbm8vnds52FmUU6+yetG6KbubrAzDlnheTabI8nYLCFqUxV8CvRIrgcZ537Y+
	xi9/u0ebF3bPs81fWcIklbuTchY96WEUdnvhr/C5b11VvvFRugpnIrht3PHBeQfy
	vI2mN2nUQCZ0wznZfBeOMeTs4yS8SkFjjJH/miz0uNOs60GFrP1OdC/jevYdfYXj
	GkYDEqaV+/mbo/8HxTpmUs8dBOloKN4AVMAxJ7w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:FrusIyxomS0LWg19B1kTtUveYzvrfQnoRcHA/6w13pE=:KYyBKAubiAJz6g+dzJu/je2DBozlFr95VFSorL6x84Y=;
X-ME-Sender: <xms:pCoGaz5m3-IojBExAFYNFrfufzb-osGCRA3CpCyFLn9E3CXkOIXcRg>
    <xme:pCoGa_wiT2-xlXKEUoQ7vZ4MpZJP9-gqWZSNs6u7eTjOpHidr2u3mMGmHSj6uadMg
    gMlszuv8fV_AfJphcrTsEUzusRryNHwZXwY4E0rFJa_wHpVTWM8A_I>
X-ME-Received: <xmr:pCoGayzggulEW9ho3i20Fy3wenQoFhARBHonue1yUmQaxoZN1ziVVf-qmPcpVkcVSVPj4m7SQ9_SAtjXfFTxGMd1iIJxKYEnFQJErXg>
X-ME-Proxy-Cause: dmFkZTG4bqujEx47rigbnzzGrSh3npTlyvFS/9UhjNkaduToplbp/YVyE3ObvGbOYGPN+Q
    prNtOxTvz/z2Cgqyup1tTkKx3I4d1o2NsfumE7MT/rncO9TTMJ++Zr0hfiraiF+efHAXpQ
    s+iWsNEU4EbCHHVVfC9FxkAoRirPaMadlVxeZzdip5UnBo0NQybduwdf8Eb6zWkBYv6slf
    q4hOF+cjxPvFURfcCVu056AxwBqXwtrKoM5TPkm+jU30AV+TwErRcdAW5cN76lVxvrZVa3
    iUICsezICLJcuhGBJbggL1M0zMJ+3HpwpRyL1rUBq1UzLg3FawI02/g9cNi8wHxFPYZstP
    K+HtKAkFT9IMAOFPgY97/YggKx/plKwpAIPOzP2wxux0M3TELjYN81t8TlalwB98e48RB+
    DQ82TCeFQ597Kiwx+PdU1TX5nG9yfo+BryN9LNhQZI/22Unbs2y0JPrbddR6P7WqkhI1oh
    D2Pgn5HpnqCBq92XH3HvC4STNCdNAXJOLl56o406vS8lSnO+vDmX5vzzcYl6VSz1ta4wyM
    lq1Uzx294i1wXe+TGWTXwXgqxgkf3S5AA8wqU7H1g1uaEyLI8v2zXNYcSRFMx2YyMRTVSk
    B4P70BL8e13QoLintujLiemFdC/i+4KiqZ0hWaQYofiSZ/Cd7DGJxycQYSFw
X-ME-Proxy: <xmx:pCoGa_wkUlid31MA99aPSCnQJGq2EBwqqP2Tfmu92anrrEK3j8sVGg>
    <xmx:pCoGa0bkmT0FEtMadiHvA10rgqwWF8YNYL206MkxqsqZ74DIVeROlg>
    <xmx:pCoGa4VvIaa_Ae7jlUjUlx3i1S75X3IceygQlcDRKwd82MOYMqwRpw>
    <xmx:pCoGa6hBQ0HnPgo1ZrGqsfY4ElEAFn2DjjaR2mCSMfzrLxoFr4EWjA>
    <xmx:pCoGa5Nyj_OITXzdo_D2JmRo_U80kDrZKKdZQOY_huLCiwqCJgKw7iAb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 19:24:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dominik Maier <dmnk@google.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
  dmnk+artist@google.com
Subject: Re: [PATCH v2 2/2] archive: defer --add-file stat() until after
 option parsing
In-Reply-To: <543109b7483191cd26b4f02d8b95a62a940b1dd9.1795543448.git.dmnk@google.com>
	(Dominik Maier's message of "Tue, 24 Nov 2026 18:05:50 +0000")
References: <20261119192311.2685319-1-dmnk@google.com>
	<cover.1795543448.git.dmnk@google.com>
	<543109b7483191cd26b4f02d8b95a62a940b1dd9.1795543448.git.dmnk@google.com>
Date: Tue, 24 Nov 2026 16:24:02 -0800
Message-ID: <xmqq7bi1hi71.fsf@gitster.g>
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

Dominik Maier <dmnk@google.com> writes:

> add_file_cb() calls stat() on each --add-file argument while
> parse_options() is still running, before parse_archive_args() checks
> is_remote. When git-upload-archive parses client arguments, it probes
> the requested path on the server filesystem and reports "File not found"
> or "Not a regular file" instead of rejecting --add-file with --remote.
>
> Move the stat() and regular-file checks into parse_archive_args() after
> parse_options() finishes, refusing entries with a NULL content pointer
> when is_remote is set. This rejects remote --add-file before touching
> the filesystem, allows a later --no-add-file to cancel an earlier
> --add-file, and lets --add-virtual-file work with --remote since its
> content is supplied inline.
>
> Suggested-by: René Scharfe <l.s.r@web.de>
> Signed-off-by: Dominik Maier <dmnk@google.com>
> ---
>  archive.c           | 24 +++++++++++++++++-------
>  t/t5000-tar-tree.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 7 deletions(-)

This seems to follow René's suggestion cleanly and resolves all three
issues without touching the filesystem when --remote or --no-add-file is
used.

> diff --git a/archive.c b/archive.c
> index 2348ab12ed..413fc1cd11 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -586,11 +586,8 @@ static int add_file_cb(const struct option *opt, const char *arg, int unset)
>  
>  	if (!strcmp(opt->long_name, "add-file")) {
>  		path = prefix_filename(args->prefix, arg);
> -		if (stat(path, &info->stat))
> -			die(_("File not found: %s"), path);
> -		if (!S_ISREG(info->stat.st_mode))
> -			die(_("Not a regular file: %s"), path);
> -		info->content = NULL; /* read the file later */
> +		memset(&info->stat, 0, sizeof(info->stat));
> +		info->content = NULL; /* stat and read the file later */

Keeping prefix_filename() in add_file_cb() preserves relative path
resolution when invoked from a subdirectory, while deferring stat(2).

> @@ -706,8 +704,20 @@ static int parse_archive_args(int argc, const char **argv,
>  		die(_("the option '%s' requires '%s'"), "--exec", "--remote");
>  	if (output)
>  		die(_("Unexpected option --output"));
> -	if (is_remote && args->extra_files.nr)
> -		die(_("options '%s' and '%s' cannot be used together"), "--add-file", "--remote");
> +	for_each_string_list_item(item, &args->extra_files) {
> +		const char *path = item->string;
> +		struct extra_file_info *info = item->util;
> +
> +		if (info->content)
> +			continue;
> +		if (is_remote)
> +			die(_("options '%s' and '%s' cannot be used together"),
> +			    "--add-file", "--remote");
> +		if (stat(path, &info->stat))
> +			die(_("File not found: %s"), path);
> +		if (!S_ISREG(info->stat.st_mode))
> +			die(_("Not a regular file: %s"), path);
> +	}

setup_git_directory() is called only after parse_archive_args() returns
to write_archive(), so the working directory has not changed between
add_file_cb() and this loop, which means 'path' is correct.  Entries
added by '--add-virtual-file' always have a non-NULL '.content' from
xstrdup(), so skipping them here lets '--remote' work without touching
the server filesystem.

Looking good.
