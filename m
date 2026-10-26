Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999708;
	b=0DDp3vyGLuMsq+R73VQBex/yRwbOZ3D7+/rAQGiGLYlg1xzBuaHcCGBGDtGS/9KtqnBc
	 IzlE394O6doPCjXteZGViAxWJUYwLwBTtC3igw/1U5y6VNdb1QxTZgptOTa5/teMUDj/d
	 Wx7Gr0RaKb9wiVfpeE+ltP0IZBIV/k/NQ3nB8AIWktUbr817aEgjFjyX+IzSlya6RJ4c4
	 ogFGcQDdEipK4oqZfjJOgMjIW0cW+GisKpCPWxxO6Q9xujclLAE3qvi7RO2qhj0zWeamV
	 MKFiYEwdQlX8VEnqf9S6B9/L3P6+SG7rtiybwvfQiGLmcSxiSfEETU+b81PIw1cZvOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999708;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y5idyQIzYP+mADOGGocgk6CT2YPihrJeZxFwKk2zoqo=;
	b=mR3Nk9lZNS61QMxC/pf68Ui6laa6/lXkEJkfCtKM5wmXaWfaze9Rzp2Yn8QUlfw2sKFF
	 xN8oLx7CNJEMnpfxRwtVzZh7JOv5cSyjDUvL1Bh6HPwfElraI0a3tlYrwK7LXCCKctQ0Y
	 w8FbRii2dD+0yyFXsb+hG91euz99TnEayYCMOqrCig/j6gX4YFd4blN4iacHu9ITKRteJ
	 F6Q2jBIaev6zGaBNQUg/+xFTY1uOTcQw956hrWPIsRwilSj2Q9ol+bLbkeWLHok2z9jWe
	 M30RNaoG+lCSsOL6k+WSSGu4e/C2cfDT6ZU66TUOQJQoHMgHufV9EblnFGC+22/k97w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=rdHMZOtt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NaNGcfF2;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC198606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC198606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=rdHMZOtt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NaNGcfF2
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A68F21D00235
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:28:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 03:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792999706; x=1793086106; bh=y5idyQIzYP
	+mADOGGocgk6CT2YPihrJeZxFwKk2zoqo=; b=rdHMZOttVglh2zvJapAQ1ibupM
	3CV8VnIkiaert1+BpAQi+/gchaIyISQE9Fwfm4PxBPykO+niUx4e7gNtAUPj+to/
	yAR7kUBZNJ75vGydyPzBVxwvLhxUphUHEG7QOkl/SGiL/VnBEYSFiKXjienwLIE6
	L6hg2/bYxQ2efwG5offq7etBVjk4DH5jGEEe2HrPFiD9TO9fazCAF6gxawZwgQPe
	aSJ/TBGiTSzAT8JZ38Lbppvmip/t7NkHfN1zYDVqM+WF6pm6SBZkfZELy4WtN1dz
	KiYx5DpOjfrQQjCvYj9Rq1h5v8ZlTyqXX3PCfDHDDcjDWhZA/RHG4kbtfG9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792999706; x=1793086106; bh=y5idyQIzYP+mADOGGocgk6CT2YPihrJeZxF
	wKk2zoqo=; b=NaNGcfF2R3PrJg8diUBh/GfwMSeKRUnIJia6Ps6qx2Oa+UH+DpK
	EuJwlXw6zK7L/cMoGX/rE3HN9UtlVhEijJNa2RKROHfCKrg2s0c+ffixEka/2VI2
	NsMip7j+zK+Pu7Tcz6r8RbNKAXgJZVPwaxYq+JB/0ep5bOHR5um1og1j5ze7WKLc
	l1nO5vMDv7rIhoeEkVjrWKJlYpp9E3MKodBiM9p3ClFcmcWM+xuRhRixMFyfrSv9
	1kcmuFV+oV0UANNuYnlq6o5P0q7wlQl2h5BBOLfP9Z8xTkjLpW0ZeqpCHIH7AAQQ
	mBch3BF2YfJESFTUDjtDb9pHV1uZPFTGNoA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792999706; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JCe47NkYWjt4M3cOjUvcX5tF9zUeCZyMOQvChf1W5jw9/28
	nanwwNuMNLP0gpuZgfxofm2bfALQ7uwx91veWCJt8vPN7CYp3fN6kw8EWlR+qORC
	PKvYxEnSpYFKvERsoc5Z5hZag80EcVG86+yuTOKJw845teg+MH7UiRRQ2u82OINA
	go4sMwbSdEIFNSL5UCPT0xtpJLTwBImiYvTOPVTVmcpO9aZYBKqNWnmgsVy1eNBr
	d1GpMNl26yeEDpEoMBayi5XDxIqCt7GVimP6stigbL9+u4+JJetTS1waB2ZXLhfK
	eoYqPSjffCk+OuOdF40rV1W7j26tfSU2Wfrqi/g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4DmrwxG6Xi+AbBDe6yCF9/IFgImXGxNB5RaqG+qg+4w=:sTk4BoYfhMWuQGN6l5BLURKjL/keZ1ew5WCmNTrOcaY=;
X-ME-Sender: <xms:GgHfau2KRRIvi9h19ZM7REA3hlccu_rYwedX3U7kRb9pMt3xC4TjVg>
    <xme:GgHfanG0fLPkAcRq1VDi3ZFcCT-0xD1GzkyFaBSN695OiERZ2Mg6cqe78mX2qkrhc
    IH12WeImJFX2uWJd2GfODSufkgw-yZQwAO8_TAEyooijQuM8f-M>
X-ME-Received: <xmr:GgHfakhQqwB-FYlLKV3JRWG5jZH8hSj3ldFRRWfIzi7hvojqP47vuQ>
X-ME-Proxy-Cause: dmFkZTE75kHV9tcYdxCcNmVrKvhjpsXw1kcic23KRJOiPs5182u6N+xTd6nxjJ95fvJ9Rb
    6qoKdqESUCu5BHFP5MMXg9LaSVmjpoN7Df9l58hjrmH5lpHAzvFyp8AkDqGWRHQAM5CUuL
    ImjFORUwVkT3O5sXBbppOYWib57mnN0Y0wIJqDizd+kanK0tikt4+kva6hti2agDCvV9CH
    m/DHw4UGMD1eD42JUcygK1ezxSlsUKPIsiWI+dlKsJWCWp0wOVdjPvS5XS1SMVnquuSZVP
    oUJVsB9G+q1vDNyOh7mzTMwbRHs2Ue/FxVi08OJ3ZytB1thJrAM1G7SytGoC18f7cTwJZ8
    iDsmhNmfWKcZUWMO/hFXeX+z0RF3sae/uT/1C1Nctkjuzy4e9qHW7mTn3oXR1U3CTK9lLn
    1+wPikiI3Yf/TdmC2kJ5gRmOMMOAbjXQo73CnVrmQGOvodaouCQ2KxrPX/fboWNrqkC2Ra
    mq6A3ZBqkjZinziG2QeOAJ3mSxeabCVzBEmjiO28bE2NS3SZU+sY3WePxTCImF/HAdem28
    9jCwdLbO6gUz9gy3Oq7dbTl+g8CeijeQw1B0JhXK2LD2zVPL4kyMuNu08wOAV2/pUKde3E
    u6ftu/UHfTmCIR2fNhhfcnBgj9w5Q3v0rjjQ+2+yPSyhOO26DpVg65atWvmw
X-ME-Proxy: <xmx:GgHfaq8nTM20Km1I6DTfgWnzvgsZI1K-5TZ_lWVuDUgL3YOQ8fO1UQ>
    <xmx:GgHfajqdLhZIwI6mNrHox6CxK_pbKfiVE5POWm3Nw6rf83poMFB86A>
    <xmx:GgHfah_5Ki6jMXCdV1QzrRlSfls-BzuW40dH5w5nXNza1hY1aVD-bA>
    <xmx:GgHfavWeRqpXsz9ycOdnB5PrMMT8co9jk2x817poTcygEkyv3ePawA>
    <xmx:GgHfaqOTo-mdta6MHhe3h9qesMhZz9kSO7Bbe6OzynKy57lCZQPIIbQQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 03:28:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1b34243 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 07:28:24 +0000 (UTC)
Date: Mon, 26 Oct 2026 08:28:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/7] rerere: get rid of global rerere cache state
Message-ID: <at8BFdzlcaiDl_sL@pks.im>
References: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
 <20261023-pks-rerere-wo-the-repository-v1-7-b6ac0c2e4b81@pks.im>
 <xmqqv76s8i12.fsf@gitster.g>
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
In-Reply-To: <xmqqv76s8i12.fsf@gitster.g>

On Fri, Oct 23, 2026 at 10:04:57AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The rerere cache state is tracked via a global variable. On the one hand
> > this ties it to one specific repository. On the other hand it has the
> > consequence that the cache may be leaking state across multiple calls
> > into the rerere subsystem.
> >
> > Refactor the subsystem to instead pass around the rerere cache state
> > explicitly and make callers responsible for setting it up and then
> > clearing it again.
> 
> This step is a logical conclusion of what was done in the previous
> step.  I very much like it.
> 
> I was somehow hoping to see that an earlier addition of "enabled"
> bit to the "struct repository" would be undone and replaced with
> this structure, but that may not be feasible, I guess.

I guess you could in theory, but it felt a bit cleaner to me to cache
this value in the repository itself. Caching whether or not there even
is a rerere cache in the `struct rerere_cache` itself just didn't feel
right to me.

We could also just not bother caching this value at all. As I mention in
the commit message, we don't really have any code paths where this logic
gets called in a hot loop or something like that. So we could instead
just look up "rerere.enabled" every single time you call
`rerere_cache_setup()`, and nobody would really care. But we also check
for the existence of ".git/rr-cache", adding another stat(3p) call every
time this function is called, and that just feels wrong to me.

It's probably premature optimization though. So if you agree with that
conclusion we could adapt similar to the below patch.

Patrick

diff --git a/repository.c b/repository.c
index f51699a6dd9..e584d6c4054 100644
--- a/repository.c
+++ b/repository.c
@@ -76,7 +76,6 @@ void initialize_repository(struct repository *repo)
 	repo->bare_cfg = -1;
 	repo->fetch_if_missing = 1;
 	repo_config_values_init(&repo->config_values_private_);
-	repo->rerere_cache_enabled = -1;
 
 	/*
 	 * When a command runs inside a repository, it learns what
diff --git a/repository.h b/repository.h
index 86795b6946c..91b1f57db7b 100644
--- a/repository.h
+++ b/repository.h
@@ -185,12 +185,6 @@ struct repository {
 	/* True if commit-graph has been disabled within this process. */
 	int commit_graph_disabled;
 
-	/*
-	 * Indicates whether the rerere-cache has been enabled. -1 (the default
-	 * value) causes us to perform auto-detection via ".git/rr-cache".
-	 */
-	int rerere_cache_enabled;
-
 	/*
 	 * Controls whether the repository should lazily fetch missing
 	 * objects from promisor remotes. Defaults to 1.
diff --git a/rerere.c b/rerere.c
index e0897612085..58bf298ae00 100644
--- a/rerere.c
+++ b/rerere.c
@@ -878,31 +878,29 @@ static int do_plain_rerere(struct rerere_cache *cache,
 static int is_rerere_enabled(struct repository *r)
 {
 	int rr_cache_exists;
+	int enabled = -1;
 	char *dir;
 
-	if (r->rerere_cache_enabled != -1)
-		return r->rerere_cache_enabled;
-
-	repo_config_get_bool(r, "rerere.enabled", &r->rerere_cache_enabled);
-	if (!r->rerere_cache_enabled)
+	repo_config_get_bool(r, "rerere.enabled", &enabled);
+	if (!enabled)
 		return 0;
 
 	dir = repo_git_path(r, "rr-cache");
 
 	rr_cache_exists = is_directory(dir);
-	if (r->rerere_cache_enabled < 0) {
-		r->rerere_cache_enabled = rr_cache_exists;
+	if (enabled < 0) {
+		enabled = rr_cache_exists;
 		goto out;
 	}
 
 	if (!rr_cache_exists &&
 	    safe_create_dir_in_gitdir(r, dir))
 		die(_("could not create directory '%s'"), dir);
-	r->rerere_cache_enabled = 1;
+	enabled = 1;
 
 out:
 	free(dir);
-	return r->rerere_cache_enabled;
+	return enabled;
 }
 
 int rerere_cache_setup(struct rerere_cache *cache,
