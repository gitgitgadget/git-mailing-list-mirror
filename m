Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662461;
	b=GR2U4nI+uiDF9Fzs+qFFTjJ9dZ9FYA1dq6C0JnAxCe51k16eS+P0S96DbsQ+GoS0ZM0r
	 TE1yCmhx92qIyKKK+KxBpFYAOfi1sAKQc6gOgomwKzGgHz2sD8Xg7YwFiGWeoeZaJ9M8k
	 AR/S3sQqrEuhggVzP8zZHQCaSY21KWJ0WZR9Tid4lAGzqaEiwu5wAzbeQ3wPLVvgZh07u
	 N4o8nyLugmX18YdUrTekPn2DinMXhEv5e7aEOhvPGNBPoBIW7u7K8rVLpPpRWXfu+N+Tj
	 T8gCB6TxFl2ADcm3gnEOqbuSt+bevzSPPyLuSc0TwZofXpdceuvSPGhayiNlCKFariA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662461;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=fNh8d4EFEtVk3PXGo0YmMgEu9sqC/0fFJEHp1gnlvww=;
	b=dHRy9buB8xZ6dt/w/aMbS90DEw7pQPmMZBMLe2s4cSyd1LUVdtKr5Yujx3yjzelpABJ1
	 UhCXY1fL+rjEElZ4A7Md0WBGCYcerJEujF+dh+VT8aSmg8OPPE8H27LPOiqIXAcN4k08x
	 azJQjfjhLtDDcKZB8ANiyxt5KB6K3i8VuJG2y/hBS/k7jGKZieriI8br0auLPJwi2TaFd
	 5zetL7I7pyAu76fu8gn6op74fjOlvJpXunASmlMcSAJY7TCmoxfV2L1seKlxihBtzYogO
	 SOOb64EpeNUmIPWiPoPC/XLFKDZTWgwfdvlruK6TJQVn3FLaWPcqnTkzuvXTL9CkNVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PYDKy1qs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=E08Xm6W6;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F9606A321
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 03:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB5F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PYDKy1qs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=E08Xm6W6
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 036257A04EF
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 22:07:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 25 Nov 2026 22:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795662459; x=1795748859; bh=fNh8d4EFEt
	Vk3PXGo0YmMgEu9sqC/0fFJEHp1gnlvww=; b=PYDKy1qsG/VVhcclqBAkXVR5NG
	tIb4fvFG6I7KNQzS6/qCkSSOqZYpKsWhTgFlCq20RFKXO/fRZ4kGJpPVkvPFLgaN
	pwtWfzkWslU+TG+IcpMlkeijXXKlUfgnqxAp/34BeOGIYa9gEmOX+asDplJUcJEG
	YTphUG37XYXTBlHJq6b7S7j0YtqtUbz+UlIp7gHue3I+XnVfg+JqrQoa7rUQj/d9
	30A0wOyc5SWTjB1xpH72RcFEANtJKxgkiHwS8LckgfOlHbYhiLgP2jMelzqiN6LR
	5+Z3jdJ+ix6g7j1B80yjHOIehuSQFWiAT/KG7+JuExz9YJfJ+PZyfvp6HDvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795662459; x=1795748859; bh=fNh8d4EFEtVk3PXGo0YmMgEu9sqC/0fFJEH
	p1gnlvww=; b=E08Xm6W60utAlgcEmH9sArLtDTtv3H2ZqVbOYUUMoyZp6+dR8Fo
	8lVT0znVivFN0DbAI0voz/xQmSJl3xFzp344vIKvmLZAwDkUY5Z/pw7MKCfn6D9c
	mU1mYeJRx/kq9xkgxIqEiqVNzlS4KEsz7QZSjmglfVYZ111Rokxe6vd+KsDpBfyH
	jfU4d29O+Chvo2Y/SYubuv+AGI0VaAzKhtHoN9bVbEWh9iwfT+yg4lid+ptCKhEx
	6Nnm70Z3L4Z3ExzZvmKzgRqblIPXXlFdjtZEwuzmzj8DhC8w95lIFC0NbW/WrO1u
	DVuMECIppj71Z8D3Lehg6DJMKcGzmdFLkpg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795662459; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:msbohN7z8DcJmgQ+ldmgMA/zqqpZ67W3PHaYxhwgxoGED1u
	/qUlcbxpoD8g2ihb0ZQvSkLFdevvNWNg/coTH4e2c5bEwVtVrkKnNHsHCCTEDYlS
	MpEFhtPQZsiNdPnKC0EQsW6+QLQacd6B7N0lmetz/+T7f/u1+szfzjLycCPMQB1k
	WgdlxTmeRP/NHvombMBeCUYfcszIMafmGAeu3A4J2E1eVOav/7vWG9viOKjzynt0
	UJ+z1Y16J2CVcWiruGgaX2k6T4tqgmjoaos8EpRwtDOOgSxm7r+gfjur6ZXPyL4P
	h7KltGJpX/cjZEYaPWMT24M6p8nlWDhDkDfZRHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4idx/VH5qBQ41hG3WknkFneSP/z31lI4FDFpfeZoC6I=:MBB3lRvhNwNEfehgmVekz5bVoArSNvq8KQdfrq+gH8E=;
X-ME-Sender: <xms:e6IHa1qYI1yGAP5P-vlnF4gXpObrsPuWSyTQ7LBHPNJ8aiO-kYnCqg>
    <xme:e6IHa-p6Lxh5Rwaw4rBEhuy2sVan5q-0wromq-qoYW9z0gYjvTbYIF9f_FsLyKW57
    O-AlAKScIG1tSdE4m4k_yPg3kW6u54qQ84t1SHuNlbA6LNjYxInPYTn>
X-ME-Received: <xmr:e6IHa3OfR54qaoQL8XJmSVvqxAXvG0xBl_p-TAmbz6b3JQvAHYmwGtzwVBoRzwalXDzWsvgmea5PM93cKZuapWFLn-ZMiMCfEBp9A4g>
X-ME-Proxy-Cause: dmFkZTExs+Lg7Gf7k3OwrotXhJtdAm0vEFqx2+MUqpV4pWxwIdCtdWIh8KIUC/TjXTIV7P
    TnXNZ2d3DXyqgEVG5C4ShaDcpKqWyJSB+R/MKfgwK+mvBbq2TMGmA7imx8viTiz0GggEp3
    MJNjvuUIA0SR8OOG5U8Qk9ywY54QcsyOD7B82t35tAWv0yK5FieRQVBT/19rt5dUVKylLd
    kOrPExdmNRb1uV5kAa7JFnpt/b8TwCtJM3dvg5K8ykYPgZAnr0tCTr8rNL0GonMuEvNT7C
    Ubk369Q7Ytr0y0pa/AjC7zskiWvIVTGCMLeQEfaWhb2ABrKcEek+RMgwDS9wysWatNzJYR
    TzY+aS0Lnp1AEytZlKVUdRouG350YovN72NAzzNvzRulP9IEtkII8AK5Ij/JnpnmVFRrFo
    7WO3ZGIzrTkAwqvHHNQVGGLW2wTFokrMp/h0bO1UIbjjhTSOux+wHtfA934yhBNzAuTB+e
    fFp90A2P9NMmLk9PFx7AAw1zRWB4Y8jpaxYHSxUvYj8uhxMdn2JEFGXR01ORS4RzZ0yjs2
    YWH+v1HM3LDdBO75m95x9Z4LJWWoUu0b6ggrs1Z/XzO9Xtq78TWTJcuZ/clUy4CnP4G5pq
    OTpEPFDPVnT0VpBkoLZ0HrB9AX5KzZoT1I2+X9FvO4dt8W2wS02eq0Xzv8bw
X-ME-Proxy: <xmx:e6IHa_xD5E5ECSXIBPSz1nbAQqT90pM0ABLnKlxTrwoho8bGpo53bA>
    <xmx:e6IHawuQ1o1fmz51uPwbAZkgWslrNi35WxVH83mh5ObRuQ6jGvitXQ>
    <xmx:e6IHa46Ef8xD57Nwcq6dNExYPccADy0PPZq5elOjusiq4IR-n092QQ>
    <xmx:e6IHa_QXNoJVd9LRmXWg1LeYfleCnNWWKA-ZWcPPBFyYQLUSDJoZTA>
    <xmx:e6IHa2tzjnVUEbY2eAsN_em_Es4LuJgnV8Ql5EaVkQTeRfN_adjcfaXF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 22:07:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 1/3] remote: reject invalid branch names in add -t
In-Reply-To: <b829c46707c53095345ae0480e7e82bd83afef02.1795632934.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 25 Nov 2026
	18:55:32 +0000")
References: <pull.2429.git.git.1795632934.gitgitgadget@gmail.com>
	<b829c46707c53095345ae0480e7e82bd83afef02.1795632934.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 19:07:38 -0800
Message-ID: <xmqqcxrss32d.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> A typo in "git remote add -t", or a shell that expands something
> unexpected like @{u}, silently produced a fetch refspec that could
> never match anything, or in some cases outright invalid syntax. Every
> later fetch from that remote then failed with a confusing error and
> nothing pointed back at the original mistake.

Our commit log messages normally describe the pre-patch behavior in the
present tense ("produces", "fails", "points").  Also, syntactic
validation only catches invalid refname syntax (like @{u}, which causes
refspec_append() inside remote_get() to die on subsequent commands),
whereas a "typo" that is still a valid refname will still be accepted.

> +static void validate_tracked_branchname(const char *branchname, int mirror)
> +{
> +	struct strbuf ref = STRBUF_INIT;
> +
> +	if (mirror)
> +		strbuf_addf(&ref, "refs/%s", branchname);
> +	else
> +		strbuf_addf(&ref, "refs/heads/%s", branchname);
> +	if (check_refname_format(ref.buf, REFNAME_REFSPEC_PATTERN))
> +		die(_("'%s' is not a valid branch name"), branchname);
> +	strbuf_release(&ref);
> +}

Using "refs/%s" when mirror is true and "refs/heads/%s" otherwise
matches add_branch() right below.  Passing REFNAME_REFSPEC_PATTERN to
check_refname_format() allows single wildcard patterns such as -t
"topic/*" while rejecting invalid sequences like @{u}, "..", ":", or
multiple asterisks.

Using check_refname_format() directly, instead of check_branch_ref(),
makes sense.  Because check_branch_ref() calls copy_branchname() with
INTERPRET_BRANCH_LOCAL and would expand local shorthands like @{-1},
and we do not want that.

>  static void add_branch(const char *key, const char *branchname,
>  		       const char *remotename, int mirror, struct strbuf *tmp)
>  {
> @@ -211,6 +224,8 @@ static int add(int argc, const char **argv, const char *prefix,
>  		die(_("specifying a master branch makes no sense with --mirror"));
>  	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
>  		die(_("specifying branches to track makes sense only with fetch mirrors"));
> +	for (size_t i = 0; i < track.nr; i++)
> +		validate_tracked_branchname(track.items[i].string, mirror);

Validating track entries here runs before remote_get() and before
repo_config_set() writes remote.<name>.url, so a bad -t argument leaves
no configuration behind.  The new test in t/t5505-remote.sh verifies
both the error message and the absence of remote.badtrack.url.

OK.
