Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010991;
	b=B2BmMJ9CRxCRvsN2wB3hi/9+E2ynEDGuFBLjJsBGeiB95e9GhzMsutXYTovg84KHBUhB
	 OwNpyXRmwA0LM01NEO3pqw1Q5FjC4X+Sc44vz/EW18nfmZPrPWA96Z7NS0DBjFat1sMMZ
	 AJZRZOI2242ekfivpDFcNP27Vy9RRdD1/G7e/Qu9YmPp+YXZv9xIECc7IBD2wTrIlsla7
	 aN6vk9tUHWgwGa0rWdHWxapqc1l4YH4rZTdOkEUu4BfVCuvmcKpsU/SK13eoBaSQyxWi9
	 Arovy/elqQq3Qu56KYn/UCcjw7uXGCdORwjRjHDoZMhLdztkQOSNTibL1tSvkNBrk1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010991;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XiPk6wPs72mkhIpsd3SaN4zYUAn70NHInjLwqlCWbls=;
	b=c9hzEBAa7d9bDBOleuIiz3BQqkt1+qC5JqUTfKjFRkeD2xzMQlYaDVUUhC6bgCl1eAbV
	 BRn+Zre33e1tU+hiKoeXkyJZXDVDhhTVwxkUGxJpHF+mPCS2LDDnPhjmQWqlgOMMQhUil
	 hGjp8Q77rgNCDlBv1Fq91Jwy2ELSYmpHgnCnJHX/vGOmuDmPVycW+/9JLm/+4pvT9dNyN
	 L/KR0y/XZrUIrClbQPuGdpchd9AaVI1onHGZutlWGIbX8kGlzuX3ZIRefZ328FIy3M5ay
	 J2xaeGtgyZoivJbhKYoSBDRgpj/3Ly7w7AvjkmMhzxvT5sFX5o+/qZksjg5jgwRsiwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=j8N2ObJO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JYpSjjSI;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C94606A338
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 14:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5C94606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=j8N2ObJO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JYpSjjSI
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 06FFBEC0B00
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 09:09:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 18 Nov 2026 09:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795010989; x=1795097389; bh=XiPk6wPs72
	mkhIpsd3SaN4zYUAn70NHInjLwqlCWbls=; b=j8N2ObJOOfpmuR4VUjAn/v0AYn
	M/UG/eCrSGY9Ikm+IacRlXqkwCSAOUBKlsp5+viCyyWcJ6OtVsaciUCBbxdjwuOz
	8Szolt55CQmEy06C7oCLs2uroA88a7P7/rI6DKVRPtJEkdq76yqBmb2bTroZODDr
	RlVRFbGvkoMdlCwEpLnfzA541r7KFge5UAdZhaWS+mnVAlKRuNajeDApm+E9nQ8N
	g3Q5dK6ndBoqZSuQrMibFD3o5YLckyg81DaQM5qXJTJl14Vu4pAm1JZQ7J9IczEa
	8sW6hrTznh5ma3v8YrGg/2eIZZn/x6Dz6f4vZyom/qwcNMsbnlvsob5TVoHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795010989; x=1795097389; bh=XiPk6wPs72mkhIpsd3SaN4zYUAn70NHInjL
	wqlCWbls=; b=JYpSjjSIYOfmMEi4Ve1RRpY9XIvCI7eKCreNNw4LOk5ygWO2dnS
	8QFxTOuNdn/cio7Mef/TU58R0RaawNwZ2nXLxlcGUHk9IF/UAVPeUwdgEcSM0oxI
	cvzBQ3Ya/98Ty4TV6CY91wbGOB/WeOLowwSjTFnVgFOK69jddvBBVMS1VfR6qUjI
	XsNh1Hy3SAzWF+sZJNMmyWFdFTkHVztoZn4r9hJ1USnQItm8RveH3/yBb+g2qbyH
	cLUztLinwEQVQ0Kh6U1RUcGv5ePbx2FN7vzrTVnLy1byQUF1Z5TSY1/sm85ss84H
	nToz9d7S5HClBcnGrcZpEbVsqf/AUuOpQTg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795010989; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Kqrc3l9KN254v01Z9qw15OSEa9BXFp7ISP/4jSpGkBbeHyC
	ASU9i/y7VgoabiE6cDppVRkm8HcM0ExYJVbqfn49hQv68beTIVmdJLkVRfRwGD3R
	LFbFSoXf4LapFSafPoD83hksEZ3+5vqyqeIpOMXn6tmOYZ9bTM/qvO8y6PHM+POW
	xcUVLE8hoJPcDH4CtXpspRCaiB494tfRcYvcpT3e6Bm2YVAzI31M45hX2IGjWsJV
	U4jV64hjEJzesnH9HT9s7XR7krw11TcV0gx407mzi7KwTDMXQv/3jKHAR+5HTGXN
	khamgyK8Z2apV487K8KbpynqxVfBDjVG1p1D3Jw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5P954PDlGMQhRN3AvnNp+q9NlpoQCZpvFukDzrGcTjw=:4OLgPyzHZ8iLEqOCrP6iizHYIgS5Kwp9W6Q8UW1f9mA=;
X-ME-Sender: <xms:rbH9aj7KuRruVUFBTPdchPxu8cO9BasyEe5gXUHOrdEvuLh8NRDJ7g>
    <xme:rbH9av6QJeUzQtxTGgKS5kfusQL06YMF-i4fY-mVI2ryavkjkjk4z__D9i8aVyTEy
    CaG8teOT-k1o43VrBBhPj2p85yAS2fKERlRQ8yVox4w5C1xwUho>
X-ME-Received: <xmr:rbH9avf9VK3Ni67LjmwdlroEIlKpCnqGdcBG1w_-sP2F3HYPoNJBKQ>
X-ME-Proxy-Cause: dmFkZTEqfIEQ/9Eq6adTzWUpBsRIjiEQmgF0LXw0ElBUKrPLueKPwYFPp923R+EAITdCxM
    S0C8gPoBurgCineGoIffVvDxK6Ndcw46nV07m4y8YSbVRO28oyxqyRsTlDJliml0XyWyD7
    T3N/V8isoP1AMd8aGOBr8QZghtFBLsJ8mgqDdU+Guy50rGQ/GpBCOkxDM5Pb7N3GDc/Odt
    Oicfb5/Q3h3c429j8tyPhwmEwYZlq2Urn04afl7WbGhYC+qWHFPmduzKUGNXMpybygrQ/F
    WedrOJ/ugSdR4GZI/XmQ0J2blrW95YcuhkcgUw1j8LBkRs7xU0sRI0f75y0B781GLC1hIB
    1xurysOmgHAXtqyIoxkvablSiKwa1x3I3sgBFRKpnotZsLD1NQGKRw05+GowrSz0xsTInG
    yZt/PZGryg/CgFA39W35m46JInj5jF8QmRJb5ZkcZUodQYA6fHNFFkonB1RqzvQ2Dv18vp
    qBiKcghMLjoHYuczFO3/PSeAXlmh/DjGtEGs67rMTtNoUVFMlzIUcUy+csjsRaAkw2hsd8
    Db3tSjwe4LwhLS54/HcAhKBdompEOO2cZhRzH4OfimEc/7Qpv6nc+hw39MMezJZECFjwob
    969RxN0CKxO7TX+7Dx9Z7KLWoa7K13oSkQ7e8+O3tTNAu7sPJKrabuTJAwBQ
X-ME-Proxy: <xmx:rbH9ajAaMFT5EsZeiMPu6smvoqz7T_zduq9WMWsRY9PkPTifbL81vw>
    <xmx:rbH9ai98g4G2P3nIqDd59RH07ZoSyh5yZNsKiUjv5uthuzW0l0XWOQ>
    <xmx:rbH9auJneNKZ1qSLbaThnMEvINkI8rznU2VV8taqHCyRip3WIM6QpA>
    <xmx:rbH9arha3BKrW9TXTNUZbY40mB4JneaRupDZcGPxlyXsgzDr6gMsjA>
    <xmx:rbH9au-ejd4S-8ngb0ldtXsEarqig2eIhIL4hEmIInnyZR2Orc4ZNZ92>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 09:09:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bdbccabe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 14:09:45 +0000 (UTC)
Date: Wed, 18 Nov 2026 15:09:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 11/12] builtin/rerere: use `OPT_SUBCOMMAND()`
Message-ID: <av2xpF67qs6S0Hb7@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
 <20261111-pks-rerere-subcommands-v4-11-df0c8bf79e16@pks.im>
 <xmqqwlqcgsan.fsf@gitster.g>
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
In-Reply-To: <xmqqwlqcgsan.fsf@gitster.g>

On Mon, Nov 16, 2026 at 05:28:32PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In git-rerere(1) we have our own custom logic to parse subcommands. In
> > preceding commits we have refactored all of those subcommands so that
> > they are ready to be used as `OPT_SUBCOMMAND()`s. Switch over to use
> > these so that we get rid of our custom subcommand parsing.
> >
> > Unfortunately this means that we have a backwards-incompatible change
> > because we no longer accept the "--[no-]rerere-autoupdate" flag for all
> > subcommands. But this was arguably broken and misleading as we ignore
> > this flag for any other subcommand aynway. So we cheat a bit and simply
> > call it a bug that those flags were accepted in the first place.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/rerere.c | 84 +++++++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 56 insertions(+), 28 deletions(-)
> 
> I already mentioned
> 
> $ rungit master rerere unknown
> usage: git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]
> 
>     --[no-]rerere-autoupdate
>                           register clean resolutions in index
> 
> vs
> 
> $ rungit seen rerere unknown
> usage: too many arguments
> 
> and it is this step that may be responsible for some of it.

Right, but isn't this actually an improvement? It's exactly the same way
that other commands with optional subcommands behave, e.g.:

    $ git submodule
    -855827c583bc30645ba427885caa40c5b81764d2 sha1collisiondetection
    $ git submodule unknown
    usage: git submodule [--quiet] [--cached]
       or: git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]

Ooh, no, it's the exact _other_ way round. We used to print the
synopsis, now we print "too many arguments". That's annoying and a
regression indeed. Will fix.

> > @@ -211,41 +237,43 @@ int cmd_rerere(int argc,
> >  	       const char *prefix,
> >  	       struct repository *repo)
> >  {
> > +	parse_opt_subcommand_fn *fn = NULL;
> > +		OPT_SUBCOMMAND("clear", &fn, cmd_rerere_clear),
> > +		OPT_SUBCOMMAND("diff", &fn, cmd_rerere_diff),
> > +		OPT_SUBCOMMAND("forget", &fn, cmd_rerere_forget),
> > +		OPT_SUBCOMMAND("gc", &fn, cmd_rerere_gc),
> > +		OPT_SUBCOMMAND("remaining", &fn, cmd_rerere_remaining),
> > +		OPT_SUBCOMMAND("status", &fn, cmd_rerere_status),
> >  		OPT_END(),
> >  	};
> >  
> >  	argc = parse_options(argc, argv, prefix, options, rerere_usage,
> > +			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_SUBCOMMAND_OPTIONAL);
> >  	repo_config(repo, git_xmerge_config, NULL);
> >  
> > +	if (!fn) {
> > +		struct strvec args = STRVEC_INIT;
> > +		const char **args_copy;
> > +		int ret;
> >  
> > +		strvec_push(&args, "perform");
> > +		strvec_pushv(&args, argv);
> >  
> > +		/*
> > +		 * We need to copy the array as it will be modified by
> > +		 * `parse_options()`, and if so we leak the strings
> > +		 * referenced by `args`.
> > +		 */
> > +		CALLOC_ARRAY(args_copy, args.nr);
> > +		COPY_ARRAY(args_copy, args.v, args.nr);
> 
> Does args.nr count the terminating NULL pointer?  We mimic the
> familiar (ac, av) convention of the C language; av[ac] being NULL is
> also part of the convention, so if CALLOC_ARRAY() is not allocating
> an entry for the terminating NULL and COPY_ARRAY() is not copying
> args together with the NULL, this may want to be corrected.

That's a good point indeed. It likely doesn't matter, but better be safe
than sorry. Will adapt.

Patrick
