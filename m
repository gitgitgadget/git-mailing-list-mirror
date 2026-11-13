Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553438;
	b=y3ckrVYkcfDPLGkxx9oRDxbZYhw8pCNxNCo7sb/vt81zQlKBpugo7jd23/cR2Y1X7LbR
	 DdQWvDZIZp2WYh/602tmnIV6HNT/yVPOyz4eirZ9z3oeP6gzuJW7884ZWqaKh4IZg2yEo
	 JOisPW8WciC6Da62NGqu9R7XxKXBVyGWGXgs1Mn1L0ElsyuuQ5IWV45DfXUJsKr2xoPAU
	 SeLZ+q9d7hPFFSZE8IikUT/d65Uy/U+66eVCObe16aU9A4JN8cstNvdZDslxRQXiIfA8e
	 4ULXcCIJkCNCohWYrsnBXrEqVH9XNVKJqMj1uPu8xLSWV4Uw2u7NR88yb7qZVpTUdvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553438;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=G1YIP9L7+8rCTzxZYEmAkNnzKuGOxBLimw2CWnzvYyc=;
	b=WqDA76gSeqyLWCFS24QIXBFk505NLvGeUkt3wA7dQC4JiV4eZ/jMJiChjpgvVBGI95bL
	 MjxxjQnnmKLdyhD3ohxBagLjy3MxnXMj8ifhWCdWo3zySOdYtQBzUJEYZGzU1ygyQVAXx
	 rc+kAKLjJEWAigDYHwL3/L3fFNW3rHqgJ4P+/J54qSoPl2hNrA0/udleGrSPmuAfZwyCZ
	 1lSQ19/qZlETYcHky5VFKktuJWfJL7ZeAXtstHjg/ji7F+h6jSJfNCcQrQxYW5XeiwRAO
	 AeRf/jjvrcaGvbAzeJxUtasb8djBCqfDSv+x7ObBUDSgWZ+0SxU283VLaZBhRkJ71kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=S0G+blxw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Z5fjQbAz;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C7606A31C
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 07:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D73C7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=S0G+blxw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Z5fjQbAz
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2890C7A026B
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 02:03:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 13 Nov 2026 02:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794553437; x=1794639837; bh=G1YIP9L7+8
	rCTzxZYEmAkNnzKuGOxBLimw2CWnzvYyc=; b=S0G+blxwRTyqbDQYPS7I/HpAAM
	Cde4zfnrUtO55+onguMi+rtnpVZYxAnrfQGx6pbCUXA9Mxr1Lm/tiVYeCEfkO1SS
	2ZHwhLeT5O+CWz5eYQVxz4G1bNRpTQwIt2NMvqrD51Wm9e+C+6gP8yF1+TI8i2MZ
	wOrUzFh3JTzS5KRQYk/ahZFYhfUP8UOq1U7csGw8vBUBY8C/p1ghhqOfeuemscDm
	cTHTbOlNr3W/8J/Si/LYcbjpZfQXCxOSufs4draPE9XjmsB8jz127Ownu5lA3Q1l
	YdWa5GjOqw8X9idYTl+mAmCxvJL0TmvMefskXmVEOwlB2YNAKPYSX/DQbvVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794553437; x=1794639837; bh=G1YIP9L7+8rCTzxZYEmAkNnzKuGOxBLimw2
	CWnzvYyc=; b=Z5fjQbAzIpqDdGnosBOoKq1tF4xDjqqYj4PHR2+4IJQZSitjrWB
	ffnB+8HIMgIkPQq2A23Wq6xvnClR5miKwDKiSzG6Ouca0tqZsrzNEs04P1yZcTGg
	mzPTOUkCYm9yoQPGwkazvnpJ1eyF/XtbPuu7Tm7v04skbr72qVc+VItYWZ03kQDd
	Y4/eyRqULREgeSdiZdtrrgUiH454xNyKvVlg0WlmmSgZ6kH95N1Pp2ZJXS6021Hy
	GsYq2mVTSDDJushDgOMJT7IFzWYSylzq5CzocqaTgejGDKcLlW4anprn1c45Dv2t
	LMgKtcNIgsLyTFW4VmLnjHg5U+0qdCKMRjw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794553437; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:w9M80+PaV2uRKtU+OlJGVrkCHhwAyXYakyslc4JM/2kLznL
	QczMNaMqRX8gHR3U9zjeKQ7miAvKK7oA4crbNgJUB8IcUQjKYA4TF+DYKXDNQXS2
	k9U3zcbCxrBgDMKv+6qrvE0gG9i3g8uoxNb+yx8yAa9bSSgEJSA0r47pxOt6sgBS
	lz+LyCTOM7NIoaCQn+zQk11S72T91/0xLuqsLHRc/oYARDLNnHj5PkXd6kuy+k8/
	+P7FrL1y5o4aLPCuf6H8usmdG1+aWyQnTv7sF7H+oGxScIR8qGNIGTuLyYqP7dRK
	1rgif5QVLYXBsgU6ovwwS6htdv80VQP9nCHhgwA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5vy0ux71TH7NNx6cX6N5oSGSuaJjomg/m+S+4wHqdUY=:eRAengJYxeSv3JYDa7o9qK31p+UQN6s31wUFM/J+ncE=;
X-ME-Sender: <xms:XLb2atUykkSTe8w_QcHKM7ZmCWR216W8Bl9sRXfK972mYvXopeGFJA>
    <xme:XLb2alD6GNC5zPkDYPbPttI0zR561IrFFVZKRqXTEmfEr-JiD1OxToNOX4VfeD5oS
    z-AKLhP32j8WGR2sFaeCiypTSxCvnf4mCkHZ-jd2oGtco8o2I0-OA>
X-ME-Received: <xmr:XLb2amx8xGGC6OwYsbqoCJE9paUIKmWSylcBqXZgUiILN8OaJMdXYg>
X-ME-Proxy-Cause: dmFkZTFFTDBk5Xh7m2AosUFHuP1zaglTHNJPt8CflHgek9Jz94roeIw5odeGmrpTtm+jsn
    1ABJaQyK5+00jgQMbIQV6rx/SHodi9QC0rhujMh4oEfb+WUL+1KGQyhdn8d5/vRisc5kI/
    GtF0Nul+y3iK7aBwAOHV4sFKC4ns95Qf0D9IzSG1UXJPyR8YXDfn5ijVyizT9CIjdlYzsz
    kKEFcuURCNOnAgwz06gv+c2sbDCU3nki4Jq4P0u7fZjkGORm4qOtXsheIYhWAXoteoQ4VY
    jlCCOIyrP0K+nFHyeMfqow3KScka5tKqjQV2nGtLGpPCQoqm5QkkJ7aT1PCwewvAaHvRC+
    BJWYixjbUmlX5SZbCr7uxl4lksgAgIpoMX7Fv/mdi1CB+PH6KeS73BqkF3gerOSRQRCxIq
    /C1VtkW4lPFlnYNt3NNVLAb4bs5RgedbrAEUQzz3DuZlLMSGXjvoOpplw1XzLXh+El34oK
    kZOkUel27b8+uKZPrsHXaqwlEayUAcsx6e5VEQkgpCIFFjnT37nJISe0wduOSWbvXAmyfh
    zYNT8RF3DpSFuBvZa4U0YIRza6ILpEhvJDX32dJRAOpMCQWu1CGYGFmjtU/JTHQa7RkfL2
    quCGuE96zr0CcXJzAyj8bRgxQQrHBmmVoaVA0Ufat9NdIiIpGC0PVUYzRTaQ
X-ME-Proxy: <xmx:XLb2aqCFzGyz5zFT3U6_GB2nvwOsdm5-HxDF61VNh6hNK_cS0OSXsQ>
    <xmx:XLb2arYgBG1V6-opD2aIR88T1HQqL4phffJ-9-m2Hh2Acv0HXk6ZCA>
    <xmx:XLb2aqjyfibHYyZOVU6a6CJo0gT62nOVpgGRqiulHYJ2x-nENn3NXA>
    <xmx:XLb2al5Lw0I-V9mrybUs3On9cXQSDRPDYRlqxRtm9YAOgnLD2vjm2w>
    <xmx:Xbb2amsCIkk249M7ulr8VSYpiw2ARlk6I7KfQpI_9RQaKmOTSzgen64R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 02:03:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9130f40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Nov 2026 07:03:55 +0000 (UTC)
Date: Fri, 13 Nov 2026 08:03:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: yusuke8h@gmail.com
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-backend: drop strbuf pre-sizing from
 get_info_packs()
Message-ID: <ava2WJkDag6-uthA@pks.im>
References: <20261113-http-backend-drop-strbuf-presizing-v1-1-7d66aae03b22@gmail.com>
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
In-Reply-To: <20261113-http-backend-drop-strbuf-presizing-v1-1-7d66aae03b22@gmail.com>

On Fri, Nov 13, 2026 at 02:17:58AM +0000, Yusuke Hayashi via B4 Relay wrote:
> From: Yusuke Hayashi <yusuke8h@gmail.com>
> 
> get_info_packs() iterates over all packs in the repository to count
> local packs, calls `strbuf_grow(&buf, cnt * 53 + 2)`, and then iterates
> over the packs a second time to format each entry with `strbuf_addf()`.
> 
> This pre-sizing dates back to 2f4038ab33 (Git-aware CGI to provide dumb
> HTTP transport, 2009-10-30) and is no longer worth keeping: `53` assumes
> the length of a SHA-1 "P pack-<hex>.pack\n" line (under-counting the
> 77-byte lines in SHA-256 repositories), `cnt * 53 + 2` uses unchecked
> arithmetic, and `strbuf_addf()` / `strbuf_addch()` already grow the
> buffer automatically without needing an extra pass over the pack list.
> Similar pre-sizing was recently removed in a9ce8526dc (pretty: drop
> strbuf pre-sizing from add_rfc2047(), 2026-05-12).

So this explains that the behaviour is buggy, but that may lead the
reader to wonder why we don't just fix the bug. And sure, we know to
grow the buffer automatically, but the hint is intended as a performance
improvement so that we know to allocate the buffer properly right from
the start.

Note that I'm not saying that this change doesn't make sense. But I
think the argument that "others do it" is rather weak. The more
important question to answer is why it's fine to skip it in this
particular function.

Thanks!

Patrick
