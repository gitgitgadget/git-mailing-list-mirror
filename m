Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657120;
	b=cMTV2cY0f8mUQ1p06jWyKpA9olAuF54CbVwE5q1FAq5EzwL5kjuqTPHkJrFbAcCFbzlF
	 gAm/+UQ9Fk7RbfCJT9v7FwOItm6P6Sf3rYc8/F4VvUysrLHCJ8yEG2UmH+EmiHK3UYPX2
	 Z+RqcWDUHpU2rClRK2bafFWu2sXsaZqS5b7vJ2iuIGdkriOHHEuGAiaYLT7SMUJNPaSOz
	 TioYMt8/27hYE3Uimwqe33FmFzRivdYqM46NNhZg3S44A/XtpJQTaL2ecvgRDasHMYE/k
	 WMWKVGnuWx1bNRO4+v/GImeFqCJGr44rPW++Ygi2yP4IJuJKFDa07OgW4f0vE4kL9cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657120;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=AwOblIaU6zlGjH6OsFXiOgI2Wl1PeDWj1JR/WU27Dgo=;
	b=j1S6QM01fW4uwFlB+o2jBVbkax5kx8sWa0GJXumKDZ9RzQFMpnUvjDfNCeeV8S0EpZpg
	 kZf365Qx8BdNGvMAfa+VAZMusKdfq3ESNRHmLACbqJDTYsWl128cNQgxV30fdmtSWvHxh
	 EnWpCEE5VJS1TtosGn4f2n+c+K/ZaHxgoSjtBmytVlZtDwVgX38YLxdUwb0H98nOPTbyA
	 ucvdewGJxwb6Ul/JDZ4IroC14ZiBmBLQ9WddLd6yr/jbed37of25/ub9La2k76vV6xG4O
	 6V4/m9ZseoJZNdKJ+X7CJhFRlWF58oq9G2kQr3pa9/6CLLg01Mz8fFr7Azez1TX7mjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Yyb47ibr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aPqyuJyP;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384F6082BCD
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 22:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7384F6082BCD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Yyb47ibr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aPqyuJyP
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B8CCB1D000D5
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 17:05:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 02 Nov 2026 17:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793657118; x=1793743518; bh=AwOblIaU6z
	lGjH6OsFXiOgI2Wl1PeDWj1JR/WU27Dgo=; b=Yyb47ibrdVkfNTDIimB6i9OUPB
	pHeQ6beF4FEx52xzKs9T7QPHXfPdgxv3guzfjYT9IBB/3R4C6tlQzXvrYx+aY+KV
	MKY5X/nGvG7MTb2II64iDT0NnOIFrZes80qdJkXYPUxa28Q4ZLQK2Nlo0BCZcMjZ
	mMvtkGL0hXbCswdDGwEArtFUMNUDg0FwiC0pG6b6ruYCz41Sw79m81u3bbUTZLA7
	a87HEBC3dk0iaGOmhE17/G0HmCm0aOqyxUUAu99qnm6inw4AN7reZ0MH4XlJ2hpF
	+DNRSVTSoweQJ8KUIhK7mEkEnjB+tsEpK1VN4BoQQTBFweq56e7HiPnN81hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793657118; x=1793743518; bh=AwOblIaU6zlGjH6OsFXiOgI2Wl1PeDWj1JR
	/WU27Dgo=; b=aPqyuJyP2UfVzDl4nxta4Jxit7iCzShxr0L/OcaV6uZvAnyomeY
	zkZ39NMwrP58HYaIEOKnW4aT1uMVpnCVVa8pA+mVIyjHWVPX6zXG6gwqsKt523r4
	dxNOewZBdaul8CJ6/BA7XjsLgGlfw7wKkW2rryB+S9igYdnEpy4c6Evb3oWm0B5f
	W6uVyUxGPAvdfY2k9Ja6fSOY60v+Qnca88hGxoCL7JinMpfT94YWq9XFiy4EgPe3
	rCIO1aCacEM6t/zQ9cWOYIoywbzlp/vvWrh5nhjkBMzSl8jxMbP1eXe3bfGcDqCk
	P003/gs+0BEi41RIpWEnAYosKOTP4jvY00w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793657118; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:A57Di++TQ3FyEaZBIZ+UjjgrxCDBjEX2ZTNJGI2II50TWSZ
	Y8YBh/ziS1+hEghqEVtC1ThNeHgdIBbax4FBa1ZwVnHQAFbVDIONTGksGxDWJwPP
	yhBWmG9GI/BJz87ggSywJDAO8zT6sCAfPuWmJfjXfiOh21K0hpO3E/cv27Pwccgl
	i1t7sBKrgyVYza/b1LBhtoHM4X267s1QexXeGHXoOhMvgzareILtrGq1Ll87uD5P
	RORoVhm/ZCA0uaniAsY2HBu4nTMpAD2qiEzSNmS1iSZStwkIrGx+KUXQ+3zhCcL4
	+mnl2DLrz39xA73a42hGw+Rcha+oiuScTbzPXxw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0JDEYh9EurZ7D8WJMV46U5N2cHmZhPmSNQQ5xjn8KxE=:ZjWpM2oF8a5kqm8N7hOD+pLJEJtcuz3vn3w/pe//Fiw=;
X-ME-Sender: <xms:HgnpatBjce7l5igQs3B_sWW8DUDTrc2qqNx4dDk_m3zyPkQLTD6FRQ>
    <xme:HgnpaiZG4eShx-UVg3Fdop9cQJlI55pdO2QLF7doB7IOgNYLJoDKOUsBJG55BMGK9
    bV33keyoFPEXSBSHpp46J94tmjzR8-HaUJyB3qDUJI20Y-wrLOwgpM>
X-ME-Received: <xmr:Hgnpag6VCxtMW9AMCxbmy9zMLJHivtu6pvpwR22GPnxATqX3kRq356iuoFtCNmSfL1V3lDZ8-qK4fjyZHWaRmSWR1qmBLmUVLNPe>
X-ME-Proxy-Cause: dmFkZTEP5BC7oBD1moiBo2AixAlzvx88eE/sguqzS2QxX/eB/2xGuYg2k4iSJ/vg2XNDWk
    /ttYISUR7zNM46f/s8CibHUM5DwARI9qiWJTqsOb8yhzFNOu9IKfAXzWObkEvpTx8EeYNk
    xUazw8wTaS6AFkYWdXVSMowutvMY4cNiAbRxYXvP46R+xeWGXa4cicOtThoMbISpre0mDL
    IzhQ74itd5UQGLHzYeFZn/MDt5YvAE0KKvFVYgrVmyJlj2gDmtkl/v7iLEBIDxhR8PgcNQ
    ScEY+kAUNzoBFR5TqPDX068uIhZ0hTBc+6VK7i7/9WzqK1S3TCU4A81VGo5LU6fU8DYkcd
    uBgh0Hk5iLz273kaQLm/AQj1LO2xw9v3GzgviMk9aM0LE2Js/pWJ6RKuAE6SXRyLKtvyaN
    /JpExWAlkQAsw0aReDuWikIYFkw9/D2t2vYnDXKHUt8HJ7KX181iM0C3B38qiKqlOvoqXj
    23czNUWvMvGttEOmaCdDNytwqV7IkDPo1hWAAvYLeV9XIoUSnukzXEiGaPL+wkwrtp0s8M
    kid8s+7WBzVjDvWK9xKuBB+MEYPWfAkPAdsjgOhFDteZSuJHdmyjk7BG+Rowu1U5yYhQpL
    JnNhDCoiButWn39mFqSDUQobdKXrKF4T1Noo6Y82cfqOKmVeXdd5umKHzZCA
X-ME-Proxy: <xmx:HgnpajY1Yv6zWBpFwdH-BMhHZUSaIdzoLiztks6Owtf-nSoN-YSZ5g>
    <xmx:HgnpavjofKI-JAsFJteY38G8pNd3R6eEI_AMbvu6UCb_od9MYJys9g>
    <xmx:Hgnpak9bGkHgsGCugTCyai_Qj-MwXLu3BVi-nlxitLHemBKQrkQgPw>
    <xmx:HgnpaqoiT2uLl0RBGC7h7mFs-Nal4H8Gg6XjC-7zPGvDWGPMqxd0Kw>
    <xmx:HgnpapaougIP9683E-8vTUazmJpfo4geOQVSqmpvOXvl0x21TIQxL0cQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 17:05:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] rev-list: ignore replacements in the connectivity check
In-Reply-To: <pull.2279.git.1793634429929.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Mon, 02 Nov 2026 15:47:09
	+0000")
References: <pull.2279.git.1793634429929.gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 14:05:16 -0800
Message-ID: <xmqq4idyhotf.fsf@gitster.g>
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

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The connectivity check follows replace refs, but other operations
> that depend on the repository being complete, such as fsck, prune,
> pack-objects and upload-pack, do not. They were taught to ignore
> replacements in dae556bdb1 (environment: add global variable to
> disable replacement, 2009-01-23), as they must work with the
> original objects, and check_connected() came later without doing
> the same.
>
> Teach the connectivity check to ignore replacements as well, so
> that it verifies the same objects that the commands relying on its
> result will read.

Sounds like absolutely the right thing to do.  We might want to say
that we check both the original and the replacement, i.e., instead
of ignoring replace refs, we ensure that the commits, trees, and
blobs reachable from the replacement objects all exist by treating
those objects as if they were also at the tips of the connectivity
graph.

> This is not a problem seen in practice, but the
> two can disagree. If a replace ref names an object that is not yet
> present locally, the check follows the replacement instead of that
> object when it arrives, and accepts an incoming pack that lacks
> objects below it. fsck and repack then fail. Such a replace ref can
> be the result of fetching refs/replace/* without the branch that
> contains the replaced commit, which fsck does not complain about,
> but it still takes a sender that sends an incomplete pack.

...

>     The case described in the commit message, where the two disagree, is
>     tricky to trigger in practice, so I do not expect it to be a common
>     problem. The main benefit is logical consistency.

Good.

>     Shallow boundaries are not affected, since they use the graft mechanism
>     internally, not replace refs.

In other words, they do not introduce more links that need to be
checked.  They just declare "behind this commit you do not have to
check as nobody is allowed to traverse past it".

> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> index 285fb3809f..b2c0d394ab 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -1107,6 +1107,7 @@ It is an error to use `--missing-only` without `--missing=print` or
>  	(For internal use only.)  Used by `check_connected()` to
>  	select the connectivity check algorithm; see
>  	`transfer.connectivityCheck` in linkgit:git-config[1].
> +	Replacement objects are ignored, as with `--no-replace-objects`.
>  endif::git-rev-list[]
>  
>  `--no-walk[=(sorted|unsorted)]`::
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 071a0e3cb5..bf66d2c9ae 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -30,6 +30,7 @@
>  #include "strbuf.h"
>  #include "tree-verify.h"
>  #include "parse.h"
> +#include "replace-object.h"
>  
>  #define INCREMENTAL_MAX_COMMITS 1000
>  
> @@ -807,6 +808,8 @@ int cmd_rev_list(int argc,
>  			revs.exclude_promisor_objects = 1;
>  		} else if (skip_prefix(arg, "--connectivity-check=", &arg)) {
>  			parse_connectivity_check(arg, &connectivity_check);
> +			/* Check the original objects, like fsck and pack-objects do. */
> +			disable_replace_refs();

OK.  This is straightforward "we want to verify the underlying, real
objects".

>  		} else if (skip_prefix(arg, "--missing=", &arg)) {
>  			parse_missing_action_value(repo, arg);
>  		} else if (!strcmp(arg, "--missing-only")) {

> diff --git a/tree-verify.c b/tree-verify.c
> index 25db76d30b..c228235150 100644
> --- a/tree-verify.c
> +++ b/tree-verify.c
> @@ -133,7 +133,6 @@ static int verify_blob(struct repository *repo,
>  	vs->blobs_checked++;
>  	oi.typep = &type;
>  	if (odb_read_object_info_extended(repo->objects, oid, &oi,
> -					  OBJECT_INFO_LOOKUP_REPLACE |
>  					  OBJECT_INFO_SKIP_FETCH_OBJECT)) {
>  		if (vs->exclude_promisor_objects &&
>  		    is_promisor_object(repo, oid))
> @@ -163,7 +162,6 @@ static int read_tree_object(struct object_database *odb,
>  	oi.sizep = sizep;
>  	oi.contentp = bufp;
>  	if (odb_read_object_info_extended(odb, oid, &oi,
> -					  OBJECT_INFO_LOOKUP_REPLACE |
>  					  OBJECT_INFO_SKIP_FETCH_OBJECT))
>  		*bufp = NULL;
>  	if (*bufp && type != OBJ_TREE) {

So are these two other hunks.

We can address the "shouldn't we make sure that replacement objects
used when the resulting history is in use are backed by objects
reachable from them?" issue separately.

Thanks.
