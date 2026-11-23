Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467846;
	b=asQyo5cqG15HBn/YODA3j2wu7pQRWXkc9gQH5R4sKcc7KhdutiswOEnV9MymbjqAJ3Yn
	 8p756Wxa9AMCz3/OsCkMW04bhHgqSOrXXqRzFFo5ktCnNX4xpuXCBcol8JOlC+80tLAbr
	 t0K3Y2pwtvlRFJYYw+yr1jUDgjD7h444ghanfVw/GXCp6ywDwGqnspsS2uspI3c+EOMgh
	 Ch3vkUvhBAGEB0l51Q9/fcruFo6rq9nZKCvyFATdgjKnmtmMi01n8mMFLjVtJKflTEAoC
	 PfLZhoeThv/z4HjMluy83unb/QnmllmatanDmaDzRZlWxXdJOulRL0OBSmBPjzGegeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467846;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=PwLeHjBNhdHt7xfaDEFVGmz46LzSvWaw0HG7ogTKAzk=;
	b=ybNGJoS7a24oHrL/Lz6002xC5hY9u3xRHAqTMh8dmTtJ1G1znzf7emGZp6yjdPfClQMe
	 9PgvvANmII6e++hiFmoEusNJeffLMco5aVnhvJFqCrA++7vz3/8lShreNcEt8sZjnwOVj
	 tD//Yv525nq3rrIGLNSyBRqrhzhXGKXvtTa9aMiTMCkm4HfwbDBvk3t8DpO+J2WmEUwOx
	 QSMUur7cYZ9Ubb/6hEUKqCKbvhL+30o8ryz1pcFA7gsLYb/HGXqpL3cSkOB1+jGkE3vM7
	 ZswE8GXk1O+I8ZdZcgSQtbBrF55nVfa8ca5rFkdcKeWRLEFh5rJd7+bjDd2Gq+cTWTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jZhQhAlo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DiefP9G9;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E92606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 21:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31E92606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jZhQhAlo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DiefP9G9
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4FD3E1D00669
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 16:04:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 23 Nov 2026 16:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795467845; x=1795554245; bh=PwLeHjBNhd
	Ht7xfaDEFVGmz46LzSvWaw0HG7ogTKAzk=; b=jZhQhAlo6UH5NtTB7X/jiR/uAY
	3m4B0a+giAGTX1gy6BGKXoPA/OQ23cQxlNSISAu+j9duaf7CHfkm3d4FakGkqus5
	+QLOmQxtpSdTGkvTnHxoy9lmrBftu0b7e90DOEGG60Doig8xy58Vpme9rD23fWQ0
	LwrmleBtrdi9OL2l5qtWMkO1p7pJJxhDZKTFDVhHDlA3oBWUKqrdamXA3hxNk41u
	aL1I3m+LrDWXA9kLg8V3PZ8qLRq3kwui8KsQWIZTQKLhm3SPT93+2w4lQHIpTwZC
	20YIG5C+Vj0qMNnEmFbl6ij7ie0hW0ZJz2Iv4UKW8GyY0QAnPdY7OLRIJZVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795467845; x=1795554245; bh=PwLeHjBNhdHt7xfaDEFVGmz46LzSvWaw0HG
	7ogTKAzk=; b=DiefP9G9WIGVFhC4JZDvgX/rRQxcdFSKt0h7Quf5kWSRzgbegBr
	XZ2MXZVgDu4JFjnWHyCAaOFcOOnvloeEh/2j9sA92TJJ/gZexEU8qqxEuXktnFcj
	5tzYxfeWEWB+Omgp2SsAmrHreDRExH5iSoMQTUrZ7bV/hcOM1v2ZXLE9xWN332Af
	u5g90jmpa3qfHz6IY4aFHydloLIB/PSYG18F9gOVXk8RPjMUdxzoLYXxzB9hoUkL
	JT+k66F4MZ5AyAvuBBZLytK1Flzxgde7bKLfPfO1bEs7A0QoreouUOX7UDsBxvJL
	htXpHwn9bfUDeKM21xjj/94+XhVlm/WDYsw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795467845; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cSe3NGZh7ylwfQzkEjVWE21ahjKeisCXrSNQP85HJuB5Jyq
	YkVMmrtNAt8cDnFluMvKUvZN7svLlKHRl56RiLs+fBzsGuWHU8zILkLDSQ6HZnWA
	ejhfEUlAz2IYkVU7jT+LGfs7HMr7/+8RgOo8N3/1TxLQb32Hi/LgF5PvCTCDp79k
	+ECdwkQIhFrl7qf5Y1zwqGi495lS+K5s7IVjybzzH2X5JkLD+gPBeT2fValnuDrO
	3ZEizIcjkrp74mEik9tynTJa/3hk9+jZIPis/U8RXKmaKKbBO7TWBa6I1EGVZYyU
	1FMD75J+ayTTy6O4ktuGHF87S6tCrnkTBnmq2iQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:C84H2vgnogsRjBWvbpVB9c0nnAeBOhE3etNkgPbn2GI=:zrpP8PK0P7r9lqUFrAhuIL4VEhKC0Ackg/hsVyAbyPg=;
X-ME-Sender: <xms:RKoEawCMxcyfriSw6k_We8yzCvVUskLvF71LeayHW85Ib9omN7FgSQ>
    <xme:RKoEa5aCEdfhlHsU_It8wBOZ9P0Kdg36st7ltHwEsI911NDmANUHftyxOalk9HLki
    1bCgb7UYRohqVUZzgsmUESO6XLFAseApOCgHExl5S71lU3GhkBJqxw>
X-ME-Received: <xmr:RKoEa77wIWenO-hf3e3-FeFCPeywDr4IxXdhDvMhansu4K5eLNjxv1ibbrqshR4wnymIZsfrTFNrS-mrktll1wONcGz-TXeIG34333E>
X-ME-Proxy-Cause: dmFkZTFlJPbSbi9iZpICv3pWxHjmIwSoLptXoBTlaUrmLZhSJCIPENu992ZPxXSi4/48ST
    eOs9umqw1+15hGDit6rsTX0/nqt1udw8mrs3mzuLGDMF+pT0eS3dErxOh42+2/ZUNSU/fq
    qAVkbrXCQBsQs3GLgTeD9rJxIuQkyQiCnPLW8iDgBE3h8LQi1xtvdH5cwkgP4DsvLP5JZ6
    nqYphG5TVbC9p82zg0GgJiGyBEQSxtiExdtoXUE5Fa05Ca/YbAwS8aypx+/bceR87xaM1x
    KXLWgkvECbWJ/T+IxExBFMFZWNGuWKwae9ECUOcasGs5GuhIlXWTtWLjkBlpGNzmW87MMX
    e/cjkAM6SM+E2O2oTBu93f0FDfBLFAeuAU/tn8PNQTI1esB47hE5btjJ1FbLZ4UX54DVUa
    Ct0c1ZvvrogqMyr2cfzUsrDGkIPlUEjD5ncT8fGo+S7N4zs5b+ULz0dLAQMRXf9MMuL/BC
    KNdH8RgsY4k+BOgJ1/8VsE/XYkLgOzPBuU63PCRz+sL2+IO2s9y5Y7KA1kieXcagizx8Dn
    XO274qc+GhCUtOHzPtPqPxwQE4FksZXp7wYaKDCV4ILk55YpYPPPVyvbp6oyU34y5/9lN8
    72k8Cs+CO3Zuq3vKbxNkp8pcsVn38lKdjrCAmsj5uHwp9x8oyVQy/PSsA+CQ
X-ME-Proxy: <xmx:RKoEayZfh6B6BBJGulXoh8hXQVU2TRP4jGzbUSNRecqq4k1ClJd1nA>
    <xmx:RKoEayhkPdlxb574v2xjgE8nckDG4EsM3pEQpBwR_8EKGHceN89qxA>
    <xmx:RKoEa7_u-68SxE4x_oewV702B5hLfCa9Dv9enxvLjWq1ae0q7DufvQ>
    <xmx:RKoEa1qJEVd6cY7DjwT_8i3PccY13-NNgVXzCctRTzUJHC5OXwIBLQ>
    <xmx:RaoEa55ne2ijgiVZ2hRNhme4E6pfxDNhlX5iTVFW-yQl-9jkMQZyCU_m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 16:04:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 3/3] bundle-uri: do not die on unresolvable relative
 URIs
In-Reply-To: <ce37d9588d833d306df3cc9d0e656e09c32e6b44.1795415793.git.aniketgupta3001@gmail.com>
	(Aniket Gupta's message of "Mon, 23 Nov 2026 12:14:22 +0530")
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
	<cover.1795415793.git.aniketgupta3001@gmail.com>
	<ce37d9588d833d306df3cc9d0e656e09c32e6b44.1795415793.git.aniketgupta3001@gmail.com>
Date: Mon, 23 Nov 2026 13:04:03 -0800
Message-ID: <xmqq1p8b5kfw.fsf@gitster.g>
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

Aniket Gupta <aniketgupta3001@gmail.com> writes:

> A bundle list, either advertised by a server or given to "git clone
> --bundle-uri", may contain relative URIs. They are resolved with
> relative_url(), which calls die() when there are more "../" components
> than the base can absorb, so one bad entry aborts the whole clone.
>
> Resolve them with relative_url_gently() instead. When that fails,
> bundle_list_update() reports the problem as an error and stops
> parsing the list, leaving the bundle without a URI.
>
> What happens then depends on where the list came from. For a list
> advertised by a server, the bundles before the bad entry are still
> used and the ones after it are not. A list given to "--bundle-uri" is
> read from a file and rejected as a whole. In both cases the clone
> carries on and fetches what is missing from the remote.

This tells us the story much better than the previous rounds.

> This resolves the TODO in t5750, so update the test to match.
>
> Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
> ---
>  bundle-uri.c                | 10 +++++++++-
>  t/t5750-bundle-uri-parse.sh | 15 +++++++--------
>  2 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 9797eaed9a..d2a33b930f 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -209,9 +209,17 @@ static int bundle_list_update(const char *key, const char *value,
>  	strbuf_release(&id);
>  
>  	if (!strcmp(subkey, "uri")) {
> +		struct strbuf err = STRBUF_INIT;
> +
>  		if (bundle->uri)
>  			return -1;
> -		bundle->uri = relative_url(list->baseURI, value, NULL);
> +		bundle->uri = relative_url_gently(list->baseURI, value, NULL,
> +						  &err);
> +		if (!bundle->uri) {
> +			error("%s", err.buf);
> +			strbuf_release(&err);
> +			return -1;
> +		}
>  		return 0;
>  	}

This is minor, but because bundle_list_update() places the bundle in the
'.bundles' hashmap of 'list' before we come here, a failing entry will
stay in the hashmap with '.uri' of 'bundle' set to NULL.  If valid
bundles precede a bad entry, fetch_bundle_uri_internal() may emit a
"error: bundle '<id>' has no uri" while iterating over '.bundles' of
'list' before the clone proceeds with the remote fetch, which may or may
not be what we want.  After all, we have already issued an error
message, so...?

Thanks.
