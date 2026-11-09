Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218091;
	b=sogXg3vEtmgo/NG+BgcBfAY8gvIxqPwinhta/sw9Byn+NfLazwJffzYVRVcNbZ102U4r
	 s7rFSC734r27bWcxuL4A6MwJmkhBDF7ZJrk7hYtryYo5iOVmEX3sPmuo5EhoVFb1K5TsW
	 rII8DGTQZjG2KM6KhSwXo1WVNEDlAkI7JZHBjej87CrHhkUBJKXnCa3bay+KeimHpWLEe
	 9uoGE4wV8te0bdplgcUGLs83nV837rARji4WEExdvjp6EBIb+xgSYBMAfBlvOakAWP0xm
	 /uGqEtlgC2Bxun71UJTAB4koM6a6EZn5DnKoFIkl5to3Xv7Xk8dQ7W7VgYrHbzDIJEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218091;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Kb7pYKj16OyBBU7+1KC6FShqwYaGBfWz57VxgcWl4eg=;
	b=Z1ARmWuyd9Y8bB2rDChBY8B36p6KbDnPr4f/V2MA35Npq3Uf8JmBADVVvT9ioBH5gqD5
	 znX1RMp3w0yQacQ/AAU+PSKLUogJK1xsrEB19eoAgiFKtHD9jCK/NxzU9i6eC72MolWet
	 5UoSlG5OzB0aHMonm0J43vrwvpFU/8ldWf4DK8/goMPALgKfeAM5NEpVsCe73ncsYkmnY
	 S4Q9CvxKn98EekyssOBK4kbTchPyKJWRZpaBl0JteTWaCCjfJfOkR+NTlzwiLW5cjPm6h
	 hAkJnoV9w/+TB5rm9aSuynVeW08UrKEcbyYxfvA862VQ6MLHKdHZDoKfWyyP8hu0Zmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=dv0x8rkx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p1wtZyBn;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023F0606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 023F0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=dv0x8rkx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p1wtZyBn
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 560F97A016E
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 04:54:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 09 Nov 2026 04:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794218089; x=1794304489; bh=Kb7pYKj16O
	yBBU7+1KC6FShqwYaGBfWz57VxgcWl4eg=; b=dv0x8rkx/17qub64iO3WZvt9IH
	kG3pZ6t+Nqn0K+fiG5H+Z3NPOsyWBbHEf/4K0vTKEZILV+Rgezf5yjvaGVHgQTMP
	M0MwXCbtYr8R/pgsRem4jBPaccFl3VDOf5lS1GPW72S6Yu+5ied9a2PGNfs2YEYq
	Fd3yxrj30judnzk0ygfC+wrOmlxZuIFzwhbCtR9jWD48rH5BVEqC1FNIXyNnnx8i
	ViBapd4+tZcnv+yA+1++lkjYYLJJ2zz+OkCM+0+AIV5PqPF+QbRvKiHB7l+uhKen
	0YcVvrHIvZs5TGve9cQVXxU8y2fBAGxDfd862mpHjk/4hzo1WW9ndZKxU6NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794218089; x=1794304489; bh=Kb7pYKj16OyBBU7+1KC6FShqwYaGBfWz57V
	xgcWl4eg=; b=p1wtZyBnXfDk+gZ7cMG45npEidLHXFyNVSBJUjgsMoSYF7dm4/f
	xtrhihprDwF3FLECkYLWnkneqaEC7TjDZnWYImF0Dikfu+tSfO0r+36kL6F4itZ3
	RV7tebvb37Q2Z8v/kvrvJSyW0aWKJ67lhEtxbwxRhXJkgTZZd/s1XW2zceeX6NO4
	3v9L9ejHWsAPa3HQDhlr/XwCXJsPXWfQBz3q/z/aw3Txgfl1a+i6KAQGlfusWfHn
	oK1Ata52ckB5PZm0DNpbGON0z5SmJjs8AYgq+5cua0ILUg448GCYJK8kFmqr1gCr
	RB6KhGSsdisIenz0O0eg/bMXfaKO262wRnQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794218089; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:FvtyEDFaLgTcV+2ZWOZY3NJJkjbIoJQGSn8gy00f4PeT6ip
	vrB45bCt6vnGDDUU4AgbuswfpQ9kfmLZrhZu2jkRtp922X2uYbzKpLZvtI3/UqzC
	mc7OGwLibLzhfFJRzS5oU6H5cjTrueNwVeGkR4u6N5nPGYnxLjuppMuHICd0pzGs
	67kERWAFEAT0oSWWfPHKPVLER8baMyfRPfFhWkrkxpNngvk0g10NaBFpK/Pm9VL5
	bMQaCNEQ3Ux3lfML1xG9v+tlKIoLqfguY4zpBu6OGRLCtxr9tvudV052IgElhU9C
	k/zJSthjPR0hdMPImQ8B6b7IuOHZ7ABY2mslkuQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sd4wuc4ZImAGXKNfSz/06XEVKp978uaGGz03EgNQW7w=:ETqSM8Mnddi/d09ck4V4izqS7pQ9g8h/U3zUkSLOnfc=;
X-ME-Sender: <xms:aZjxavTE1QD3BAV0FC-ns3HHhQYK10sJEpU4OnpkKCqmAVHmuqjc4w>
    <xme:aZjxanzUFvY1C2so13mJOeJrC7z8yHfRcoFbtjAbs3kN_cMuTj5j9AtjHzru2iq1l
    rDbNvmvcIxJ0f_bVKyJ5wrJnYmmbZtuzG5hmg4Lpeuh0qYK7j4XW44>
X-ME-Received: <xmr:aZjxap3u2SJn2MNW5kmGiaiCRVRZxhzliuNNgFpCbNTpQmncI2liP68Uq0TpTRhaO6JEVEI>
X-ME-Proxy-Cause: dmFkZTEWMPZy21FuXHwH8JhAEoCmAae1492DJtxXBbnguefykwwUZiXRpFGrD5XCQWL6W5
    4wcwFXL+8HKZ50wDcOrlF3jcVbkPA7l5lUdiJJ25LQUFFIxLMNtL9GeJk0gikiI64uLOos
    7D/Asbv0szbhsJeXjjWYhgFyNyX5po0NlhadOLnSgybNN41YNOsVm3SDJ54D1Zw64/v+SI
    k/7xHb5YEiH7jD5S1SZQYuGirjUOTk95NTaWzc3cSXmRHxMUEb3b2TGw5I8L/GzIWY9YnJ
    qaw34ktWQBhCBNTb2po+MkaFYFfGk7vx6/xTX3Sb0ElYjVBeVbohrWcmcg2bBZAf8dSrnK
    S4t4/NozO7rbAk1a1FK27ZWsXMWMfYmTmbiX5BUl3buycNKgTiDe8Q42WseyLpiWWx/HO6
    OS7jkYUbLcgy6Q7BEwnC/0Y4BIUTBcOWnvBOIls0qNLCQfFWDVoAODRBS/fjoU4H0u9CTn
    rFNrYUtD/vBzM5q7FA4Zpxch7ruEbGOuheoWOMKPKB7Y321xfGDxSqf5VlPwkKt2Wkb5XY
    Rc/N+Da51dVs3PfK42FnKKPCs5kdh7sKflTux00PRaw/JLVl/neezTS3lAx3AceT6qjTbI
    3zSILIFXKuE68DOfgR2/x/msrfPHtkoR4iZVLL3P5X3PlvhFlJ7TdsnNHO+g
X-ME-Proxy: <xmx:aZjxat60B5tyzCSp4tkX6cXpMrISGm5zuXuDJ_TiAaYeaYmGDQpSTA>
    <xmx:aZjxakWssNxA_EVA2z8u119Doz7pN2xSBUVs6EfvCEqRgeW0cdv7JA>
    <xmx:aZjxakClMaYD9RsZDGbBC6h6-uvqTGLU17tRKP_s1XtpWMPCl-wFlg>
    <xmx:aZjxar7vhbzt6u2HLrllh22vqZoqyNbPnSkhP16Z4E_ry_Vq0oTKmw>
    <xmx:aZjxajH2Vf-M1ElV49DxaG7omGydXHZMi8uqBoGbtWbDB-ZRzUPigQhE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:54:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e97b60ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 09:54:47 +0000 (UTC)
Date: Mon, 9 Nov 2026 10:54:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] setup: default hash algo to GIT_HASH_DEFAULT
Message-ID: <avGYZIFAmeSEP6ZS@pks.im>
References: <CA+kUOampvjU3=VK3VGhYw2L5-E+LBsk=Q0UrAxhhR7hC5SUdJg@mail.gmail.com>
 <20261108011633.1772000-1-sandals@crustytoothpaste.net>
 <xmqqik274201.fsf@gitster.g>
 <xmqqzevi218o.fsf@gitster.g>
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
In-Reply-To: <xmqqzevi218o.fsf@gitster.g>

On Sun, Nov 08, 2026 at 06:21:43PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I wonder what the "git init" command does wrt the reference storage
> > format (Patrick CC'ed for this)?  I am sure we do not convert from
> > reffiles to reftable on the fly at "git init" time.

Yeah, we don't, and I don't think that would be reasonable. I would very
much be surprised if git-init(1) migrated a repository's hash format,
ref storage format or object storage format. Those are long-running
operations and in the past, git-init(1) used to be somewhat idempotent
on an already-initialized repository. So I'd much rather have us migrate
explicitly, like we do with `git refs migrate`.

> I looked at setup.c:repository_format_configure() and found why
> your patch regresses, as well as a latent bug in the existing code.
> 
> First, REPOSITORY_FORMAT_INIT sets .hash_algo = GIT_HASH_DEFAULT,
> but read_repository_format() forces it to GIT_HASH_SHA1_LEGACY
> when version == -1 (no config yet), which is why new repositories
> kept getting SHA-1.
> 
> Second, unlike the ref-storage block right below it, which checks
> "else if (repo_fmt->version >= 0)" once between the explicit
> overrides and all default sources, the hash-algo block guards only
> the GIT_DEFAULT_HASH branch (repo_fmt->version < 0), leaving "else
> if (cfg.hash != GIT_HASH_UNKNOWN)" unguarded.
> 
> So init.defaultObjectFormat in ~/.gitconfig already corrupts an
> existing repository on re-init, and an unguarded "else" for
> GIT_HASH_DEFAULT falls into the same trap even without config.
> 
> Instead of starting the if/else if cascade like this:
> 
> 	if (repo_fmt->version >= 0 &&
> 	    hash != GIT_HASH_UNKNOWN &&
> 	    hash != repo_fmt->hash_algo)
> 		die(_("attempt to reinitialize repository with different hash"));
> 
> we should have started it like so:
> 
> 	if (repo_fmt->version >= 0) {
> 		if (hash != GIT_HASH_UNKNOWN && hash != repo_fmt->hash_algo)
> 			die(_("attempt to reinitialize repository with different hash"));
> 		/* otherwise happy */
> 	} else if ...
> 
> so that all the "set a new value from different sources like command
> line, environment, ~/.gitconfig, or the built-in default" would
> happen only when (repo_fmt->version < 0), probably?

Yeah, these blocks are overall quite hard to read. That's also the
reason why I re-did these checks for both the ref storage format and
then also used the new style for the object storage format. So my take
is that we should adapt the object format in a similar fashion so that
all of them use the same style, where we first detect the desired format
and then check whether we're trying to re-initialize with a different
object format towards the end of this function.

So something like this:

diff --git a/setup.c b/setup.c
index 61bcdafe82a..bf75abafeeb 100644
--- a/setup.c
+++ b/setup.c
@@ -2816,20 +2816,19 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 * specify a different algorithm, as that could cause corruption.
 	 * Otherwise, if the user has specified one on the command line, use it.
 	 */
-	env = getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
-	if (repo_fmt->version >= 0 && hash != GIT_HASH_UNKNOWN && hash != repo_fmt->hash_algo)
-		die(_("attempt to reinitialize repository with different hash"));
-	else if (hash != GIT_HASH_UNKNOWN)
-		repo_fmt->hash_algo = hash;
-	else if (env) {
+	if (hash != GIT_HASH_UNKNOWN) {
+		/* nothing to do */
+	} else if ((env = getenv(GIT_DEFAULT_HASH_ENVIRONMENT))) {
 		int env_algo = hash_algo_by_name(env);
 		if (env_algo == GIT_HASH_UNKNOWN)
 			die(_("unknown hash algorithm '%s'"), env);
 		if (repo_fmt->version < 0 ||
 		    repo_fmt->hash_algo == GIT_HASH_UNKNOWN)
 			repo_fmt->hash_algo = env_algo;
-	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
-		repo_fmt->hash_algo = cfg.hash;
+	} else if (repo_fmt->version >= 0) {
+		hash = repo_fmt->hash_algo;
+	} else {
+		hash = GIT_HASH_DEFAULT;
 	}
 
 	/*
@@ -2899,6 +2898,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 * current ref storage format does not change.
 	 */
 	if (repo_fmt->version >= 0) {
+		if (hash != repo_fmt->hash_algo)
+			die(_("attempt to reinitialize repository with different hash"));
 		if (ref_storage_format != repo_fmt->ref_storage_format)
 			die(_("attempt to reinitialize repository with different reference storage format"));
 		if ((ref_storage_payload || repo_fmt->ref_storage_payload) &&

Patrick
