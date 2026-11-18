Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035080;
	b=KSHz8KeLOgDLSOSm2/5k2/sN/m24Cn/3pbhg4CB0TbQ/lmqzcrkwFC1BQ/NAuM7p/RJR
	 x7LJTT/2x2S/w4yRWf187B8kFm3QAGZ9Nb0avUlXpJl0onIxb7AQQYP2AZzM5fz0+Lbyx
	 5LQG4ge0jpM59bigHzoAY52MV+W0ycFEfEiCYyawQPSzMbWqr32tgHIjFZRYIwOoYFIAE
	 jzxxXVNtbAksLptRK7tlMpWFw8Z4j7ZuqSCM+htogKgjt/jAqb6zeiLqN2UZ/G3TUeZxC
	 Q4yX8w/niFAaQziNtIqTWR86rOZmSe/VbeDHMIMDM9JxWUo0Cz51m16cVPOSTPDNNUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035080;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=am3R70Zi9Y8710M/3j6M9L7aG99Y8DI+IGpAxxRiwT0=;
	b=I+vPf5K6OX879XBONPV+760kRvwRSkZ7UQ89x22vy8H/unxp6Vpu8UE4Lmt7/N/qwCn8
	 aqZWK5uIJ9e2nxKK8bh0HjXwZfXV5wzZ1TiJ+ukVj30lUiC9H7q6j7oZQd4COYw55SA+x
	 DSQtCTWxtAGq+q5FmREmZopIcjtKzeDd6Kz3rhXH0vOlQnFiyE3HCt4kD9Amza/bcnXDY
	 hVh6sQ55qtgHz79hKx6P5ziABgcaPwtqKY5BZv6uaw6gTBUORP/HQj5Q/h3ozKDnKiS7T
	 aX1kFoWsalrbi/Eds4uaA9cL1+OOfVsxI2qdPJiujdVvXWMjdk984Z7YyIejIQhU8BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=H8xsd+yO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4R2A1OBA;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD1C606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 20:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD1C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=H8xsd+yO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4R2A1OBA
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 81A6CEC060B
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 15:51:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 15:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795035079; x=1795121479; bh=am3R70Zi9Y
	8710M/3j6M9L7aG99Y8DI+IGpAxxRiwT0=; b=H8xsd+yO40908XWR2euGJAH+pj
	MgigXT6xZK7dCcG2gCywliEMtnaZsovlijC7APo/FDxryBfqabjNQgD6GbLWkeP5
	QHAbTDiHzNKWkm6vrrFbHNh7BotF4u/6GQxwceJVv7uNqvdD2Ryp75JPm2JgfF7D
	+PEiM2cRmk0nYRu9yFtN91CLr550Lxp8xtB0eKD8J/BBnX/pDQ9WiFX8z9q4t5UY
	fp2be41/3xRbpd2N8v37znToNrqPLTLKL7Fbv7S9W8RrudX3jRAY999CboR6viWw
	rbyrFM2B3J2+awmXSdpZL2LkKo4v3gp4yzMU4rPfBJILvAph3ytnoHwQwHmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795035079; x=1795121479; bh=am3R70Zi9Y8710M/3j6M9L7aG99Y8DI+IGp
	AxxRiwT0=; b=4R2A1OBA88moLymsQYit7aKr23X6XGaHZP4Pc27gxJXOymo0yox
	vwJly6g0dHym9eIvd77m4p1h1pDMWiq8ImMNQ8bwofXnVDhkVXLwvmubmYiSOPci
	TmYe47ZZDbayU92Nn6LQNu2Sv7OuKNb8JG/t2gDM5R23gMN8T9Wws6eJIQI+C6kJ
	0TBLmHuXnJhCBRD2N9LzLtxxz7W6hQtXDETSLcGpfB/mkYO1l54HLBrdvTRXkI1g
	N+Dyuh135L0Du/o7hGfTFlDb7FLwxx04Kbu/s7H+/0w1Lf4+Acvg47ZB2TidGRA+
	wigOWVP8Rz9pjwEmdzuOamA9lLSeffw+o3w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795035079; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:M0jxDoGgF+oNcazpyzhITsf5Eg5QUt86hxGA1wshDjkwbun
	f4f620s+R0r7zcXIRftPU+qKIQQGePrFQEQ/2A/6DGXixEHhmd5dEtbifqXwWZXd
	xkhCRiii07oUdD7HIu6g96O4IA4rWe/95yxq3iyFwA3d+eoczJLNsQL38sNZ21Wx
	7082u9Lla/v6S1S9bAntsbTvCf2CjxL+bYoWZBQ/YgE9TWuKd+DWyWy9m9AtH+mv
	SpAXPKjwylPMkXX9b1xVDKbCMoOQur3ISaMc37ywkdjEdJM/618j/AsrAtM6d1lW
	tpwFF8gpU8lYOP7olE9iQUqy+x18Jv6buUzgcCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0fVVpPj+x1Rtz4xHHFM1RJ2pwOVOvARaiF+jVem72Lg=:ScEcar2fbx3w9JLZcVgQa0xfHho2dnrxKaJ3HjX9QeI=;
X-ME-Sender: <xms:xg_-am3GUFH20vZv18S-HjbMachc8lnyEj_UG6AE27yQMpaREB3K8Q>
    <xme:xg_-auAfs7F32HXWneQBN3EkTXF9WQXXDB7bZltoPbBZ6fVCPw6jRUGtP1-1qKx6M
    uo7B92DwWvzDnPGbxM-G2ii7vHKzM-4VBG0O2LYHAz74rJl0yi41o0>
X-ME-Received: <xmr:xg_-ajIC6LtzEvb8ITweFgMIBjLinQnrQY8mKcXOG_2pL3e5q4eiqfGzO0njxrIReUoquOHrlgnvoTG9v0mV1mUBZBqnqByFrmSm>
X-ME-Proxy-Cause: dmFkZTGreYgd3KhWOx+cPZsG+MOpkV874INpZ21PLfpulN2pnbRs+MSdr5Y4Xa8Whpa9w6
    +XLDJfP8GLBvpBzSNMyoz1Fc974+vF3AnHqexKyifmhNR27kpxrkYR/mx6+qarjhZbYaQy
    jDNKZDtL+3TBDRQ9BPKSb487M6q4e8jeb+/Uai06Bi8sEDknIxEVnDrN5B3pFkjec8ZNhQ
    4uEQHDn1WX7gyYHoYi5qNELtnIVjPKl4uUQMGUtAlqbcru+cNLhWcWwLFmcJzVXBSwiAah
    S9sJ9BgIM7PDhum/Ps1UY+NpZ942cuyKtZRhD9KKGicWRwRiEVAcvoKCGc/5MA8rbeLekG
    tBkTV3YxyhJhgQdVg6+Vq/GXCzyyffK8lAlPTTgDG8Cx6YkYEOZzzIdmBK7fQLZklbBFtm
    3LV58KTcrxsmwtAbN8mQv1vJsshyAF5ps/c5/VbJLpCl+V7jraeV4s8PsaA6GpaAN2hNqn
    7LKwDPb2q0teDOvZPrm6N+9Xb2NfC/4o1mVKcq0pk9jIZaiUgcwHWrXRjAHUFfJ5/iJibd
    C5jEvfqinsOkmNJfVmpcNg7WcTpnz8bpdb45F0BJPcbroEBsUv9nL+kSzItvD/8BvbUWFl
    qHkRG2Pn3GcZ8+o/SGkPk9WvWzOJ49PK4p+braLYXMax8EUTowk5QdUZyQAw
X-ME-Proxy: <xmx:xg_-anmRe-diEv4YHm-nIS9zhrBZxwq5AnCXsU1jIWll7RQQbaB2rA>
    <xmx:xg_-asai4maVqwZe_M_8p-6J-t8v0wp2BIOI6peMGis3ahx36HL4eQ>
    <xmx:xg_-aj8ZEaeWqyLGHJ_hbOcC4Ygi7vgPPvZk2ZbJcTV-MnD-tTM60g>
    <xmx:xg_-araSsNr8uw1jvoqeiY2AekbV80rLkpEH5WyvHjRYN0OAQ7nYdA>
    <xmx:xw_-aloStcgRlnDkdKDgY-U2nTFHAienLNRXMCpEZ8RBG0ZQyCuDt3LK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 15:51:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tanga Joris <tangajoris@gmail.com>
Cc: git@vger.kernel.org,  siddharthasthana31@gmail.com,
  phillip.wood@dunelm.org.uk,  jackrawlings2011@gmail.com,
  christian.couder@gmail.com,  kaartic.sivaraam@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH v3 1/3] apply: free the old def_name in
 parse_git_diff_header()
In-Reply-To: <20261117004348.806694-2-tangajoris@gmail.com> (Tanga Joris's
	message of "Tue, 17 Nov 2026 03:43:46 +0300")
References: <20261114012055.127905-1-tangajoris@gmail.com>
	<20261117004348.806694-1-tangajoris@gmail.com>
	<20261117004348.806694-2-tangajoris@gmail.com>
Date: Wed, 18 Nov 2026 12:51:17 -0800
Message-ID: <xmqqh5hd50e2.fsf@gitster.g>
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

Tanga Joris <tangajoris@gmail.com> writes:

> diff --git a/apply.c b/apply.c
> index f00b7ba4d3..0847835357 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1373,6 +1373,7 @@ int parse_git_diff_header(struct strbuf *root,
>  	 * or removing or adding empty files), so we get
>  	 * the default name from the header.
>  	 */
> +	free(patch->def_name);
>  	patch->def_name = git_header_name(p_value, line, len);
>  	if (patch->def_name && root->len) {
>  		char *s = xstrfmt("%s%s", root->buf, patch->def_name);

This looks seriously inadequate, though.

After seeing "diff --git" line and extracting patch->def_name by
calling git_header_name(), suppose there is an unrecognised line
(e.g., "diff --git a/f b/f" followed by "diff --git a/g b/g").  We
set patch->old_name and patch->new_name both to copy of
patch->def_name (e.g., "f" taken from "diff --git a/f b/f") and
patch->is_toplevel_relative set to 1 before we return from
parse_git_diff_header() to find_header().  Which causes
find_header() to "continue" when git_hdr_len <= len, without
clearing patch->old_name and patch->new_name and others.

The test below only "passes" because the bogus "diff --git a/g b/g"
line names the same file "g" used for the next one, I suspect.  If
you replace 'g' with 'f' on the bogus "diff --git" line, you will
see an "inconsistent old filename" error, so this change is not
making us ignore the bogus "diff --git" line, either.  Not that I
think it is a good idea to ignore such a corrupt patch input.

> +test_expect_success 'ignore an empty "diff --git" line before a git patch' '
> +	test_when_finished "rm -f g" &&
> +	echo 1 >g &&
> +	cat >empty_section.diff <<-\EOF &&
> +	diff --git a/g b/g
> +	diff --git a/g b/g
> +	index d00491f..0cfbf08 100644
> +	--- a/g
> +	+++ b/g
> +	@@ -1 +1 @@
> +	-1
> +	+2
> +	EOF
> +	git apply empty_section.diff &&
> +	echo 2 >expect &&
> +	test_cmp expect g
> +'

I do not think we should ignore such a bogus "diff --git" line;
shouldn't we diagnose it as a corrupt patch input?  I do not think
we are there yet without making find_header() do more work when
punting, though.

Thanks.
