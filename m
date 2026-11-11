Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413265;
	b=Y9LvNTcd+gUGPlDpqllWoPUYa9OcIdb5Bq12wRJOJ4v7YYqDZiJ84vxfyxTLmurfd0Iu
	 3Di8uT3dFpLokkfkiNVTsMGQTMLyFd5Qj6BRyH/+Ld4HOx33S6dznDykiDEu0naXvIMUf
	 FcerIIX9gUmVGGqVZOGbi4imF9VimbegjCSgDvJsFmMzfTXd10DEWYgZya7hAGwz4TdiF
	 tFEcGUcXLZSUYqf/XCReWiHT9Qda6oGV2+Rwxr/PLADpV5IA2jiyyVnTu6m6PDBVh3iLy
	 pSUjtp/ckHO5YeQ2sk6O6AVlBTLFl+LNRgVSUlxaaX8KfyolPklBks7QeFT9Os68BrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413265;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=wnzgMlhu5ISFh8tyOgt1y0CA1IJv8Y4QOVT5CeYlP8I=;
	b=Tbd15MSx6iGaWNc7Z0XQNAEHjExnapkYrYHeBEFUvVoeK0GJqvHGS+GFTn8nltUuA8f7
	 hkm0HauXrgvSfUIaWt+ZFZTG72w4P3ooBO8QwOulgJoHCZHkZoJfJaOK7D7K7UrxZ6ilH
	 4OtJrOObkdfjvx+nqSOOfoB1CwwCj2dJ86eBvmWFJsX/gXlqtwzL5tJ1LiEAgS/z7wzAZ
	 zJqm5ZHTQFTplP4a3nzwbwpDO/3TOi9Wo2brh4F4F/OVs4hJiMq5GXC5Wl8HyDosUz0Ik
	 vU/qClidD231y19TBdsw8eaSoMi6ym3d6wAGFf0reEQ3Ig6WDTZco9zBOOAHkmrpBCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="t/rua9Ea";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RBtv0DLT;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC3606A884
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 16:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23AC3606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=t/rua9Ea;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RBtv0DLT
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7240C7A0265
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 11:07:44 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 11 Nov 2026 11:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794413263;
	 x=1794499663; bh=wnzgMlhu5ISFh8tyOgt1y0CA1IJv8Y4QOVT5CeYlP8I=; b=
	t/rua9EaqHxS68YfSunAMb5P9H3xQmtcbIFCZm+55tGzHRkWNp6LUT9k3ywC7/uu
	rIE4bI1wNpAjm1MBJuTv420hZ/PH8kRrxcsmEmK7XcS/wiREA8JKZc8bonlH6seS
	3LqQ2RDGG1gfoM9qYj5Q9xkXXNGPSeDh6Ug1Hpvhir9OF9Dsc/jT9pCi1DpB4so5
	75j1+dC3uydxg9cAx17c3LytNDf8bzLPJfbgTckCU0UgGB5KsN8nCHylyxPnA1fX
	R1ZNhfzO1cKsat7VYZIcerB+9fHyk9bqceWD5TZUH003veCoUj1S3UCLTj9G44Jd
	FXX01in+iwqLGUr/LvLdLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794413263; x=
	1794499663; bh=wnzgMlhu5ISFh8tyOgt1y0CA1IJv8Y4QOVT5CeYlP8I=; b=R
	Btv0DLT3YeZFbxWyyXe4oX+cI3DDEKp3Jj8YEcBbMXY4EbdPJrp8JnBPcvJSwSqa
	ihdKGfu85oa0xuUJHvGPM4wUiaFe0ZIM0pNfTQNV/nnx0kADwA/SkRW36ZVyUXQ2
	gzRH3ylZtvIa67EtmTq59eCPRRC/+NWDskz7po6RFyTwpX24kN89V8IObURJXtDj
	S9Ajbj/Q/1RaaqqyvKEJtoX/vd2uH14e64+JWeY3HUFWlbiFJFa+XVwb6YjxFoPh
	DSXXsbp0AqkYXoq5LfuDBFQKWNkquQXOMcTiFDyDH8PfKuHFtS4PMRpWOT6hiHUT
	uv8UPLpdHd90uBUBPsK8w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794413263; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:xvAIvbRqElZCTrDrx+7LlpDeK886mFIogtBsx2byLkspfVo
	ZsUT3rWbrs5fvGFJBfA2MwvH6hzsBfvwNUmw9jqyFL5Fey0nHutCbPj9kJ1KSn0v
	u1LTu5c+l6XFr2hCn2Tl5ywDq6lt5B5DpuHo5nhDIlOJz+gN2sKXAmoUWv2yEs4j
	z+11Utpg3AJ2wKKwcCC14BCdeGMZn4pIyhAvz8/NRpJozSe9qYBaOK4W51BZpmpT
	V2VkVzUgrLdg2tDj5OGzF0ZyB6heRJwHwqX42wUyLcfCeGFdkoSfui7H8/dhoC75
	UrsOJ5mALLADz7J3PzO+4vOQkXU9x4OfAt1jAgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Cbd134pEo7synhWpidHX9Rrby6Vcu/D9GKSmAEIXRPs=:3HLLHMm67x34dUfKsNBdqLMrMW9Te6zbimwWtqOllW4=;
X-ME-Sender: <xms:z5L0atozfd3JMEkCNGVKPrIRcAYABSKT4lxfIIejw_fRfwPmOCB4zA>
    <xme:z5L0akmlabHrjrtidvcsPOGQF3bVYeA6fpyUWUpdTFITg-r2-hxMaD-kiXTW1ryDz
    7crUU6AKpTbH2jKSbx2zJzJ075U6s_mz-iR1n-W8eD6beFcgTTWMNs>
X-ME-Received: <xmr:z5L0auclR6M2wlJRld17v7u3IXw6U8-ph7eRqBJ0gMo9spmCpst0KrRCjc4GhfsS9rEwiA>
X-ME-Proxy-Cause: dmFkZTEOt+FEzWT50mIoOX6XGFAehruZFUSf1oXDEzF6HaQuTS/WS6pkcVfIjQz1F09MuA
    7qbCo7s3HFbmNQpL8NlizkRS+iTGN7QpRYwpZOL2LnvMtyEKIMXIj+b3gfcQFJ487j21eh
    QOulf/5ptYWKbOYblRQZLWraBoFzsS+Bw4OjOYzfFBllSZR6c+q0fENDKvn1U1yZdiP+XO
    C9ToLzasBY9S/QZZWACwRp6kuTo8pZNqjqLXSNfCo+O/XbyWooYFPN1JqEPaRYvG+2Ej/O
    Xvfh2JS7quf0sA9irq6jUmzlmWqCYTISvVXqfBXulzx6di58fa8p4emquNVFYLSZhClDYK
    CnqjRWYxIKHyqLP5RYcyHAKVw6i1pnMw19KJduBsmMYgBIHyYDldkkAKZWY7a9uj5S2FKW
    3eMqVsvZ8Cw8xWVGynfO9oawYx1q5a3mPgERHbFissDCk11wm5lv8g43dExoRzDYA0YqC/
    NJhWDiye+kUJBSmoiAmc/kbybf7M0+hIWNYXdVmD2lE3r65pPvhbAXV9vEBJGGBON0cxyR
    9CORaBTvUdKRbHH4Wi9Zb5PjQEuiZoGeflPo6fU7v6VSj1uI9UnvmiaC0XBacc/iwTd+NK
    ing32mpoQPQ21TkRaWpxW9FpVAq0BVEYvEcEtSY5F0jYuKS5gDASTLHJeT7Q
X-ME-Proxy: <xmx:z5L0aopj7sWJiOnSWJYb496qK4BQ0Nqdopi7QGjr63zXwRINThP8AQ>
    <xmx:z5L0agNaLawmoDtYD2gqGBv5bX0cUP3xUsaJSPtPtBbxknfV3eGPbg>
    <xmx:z5L0ajjsvRo_OEjy0d6Skj4-bJrHYIL5kKykCqx4c915uNnRy4PdWw>
    <xmx:z5L0arscXsz1SutYfRkcrNeKrKqYr5CR1PsbAhuX4pFtiGBTeMsMTw>
    <xmx:z5L0aoi32Tggvfqz_GLH8n1rzfS9uL0Jo6ESPmqNWs2AspETrKp0FsdF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 11:07:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6abedb15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 16:07:38 +0000 (UTC)
Date: Wed, 11 Nov 2026 17:07:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jelle van der Waa <jelle@vdwaa.nl>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
Message-ID: <avSSx_RvAlMrj4Cz@pks.im>
References: <avR1u_y2IQ8WoJXe@pks.im>
 <6F40E344-D1D1-487E-B5C4-1ADC0B06F749@gmail.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6F40E344-D1D1-487E-B5C4-1ADC0B06F749@gmail.com>

On Wed, Nov 11, 2026 at 10:39:51AM -0500, Ben Knoble wrote:
> 
> > Le 11 nov. 2026 à 09:03, Patrick Steinhardt <ps@pks.im> a écrit :
> > 
> > ﻿On Wed, Nov 11, 2026 at 01:57:46PM +0000, Phillip Wood wrote:
> >> Hi Patrick
> >> 
> >>> On 11/11/2026 10:46, Patrick Steinhardt wrote:
> >>> On Tue, Nov 10, 2026 at 12:15:20PM -0500, Ben Knoble wrote:
> >>>>> Le 10 nov. 2026 à 08:13, Karthik Nayak <karthik.188@gmail.com> a écrit :
> >>>>> ﻿Phillip Wood <phillip.wood123@gmail.com> writes:
> >>>>>> 
> >>>>>> Another case where we might not want the diff is scripted editing as it
> >>>>>> is much easier if the script does not have to worry about the diff
> >>>>>> getting in the way of its edits. Personally I'd be happy to see this on
> >>>>>> by default - the history command is marked as experimental so if having
> >>>>>> it on by default rather than following "commit.verbose" proves to be
> >>>>>> problematic we can always change it in the future. If we were staring
> >>>>>> again I'd also make "commit.verbose" on by default as well so maybe I'm
> >>>>>> biased.
> >>>>>> 
> >>>>> I'm on board with this suggestion. Plus, I see 'git history' to be more
> >>>>> user facing and it's always nicer to have better defaults for users.
> >>>>> Showing diffs and verbose information seems to be inline with that. We
> >>>>> could add an option to disable such output for scripts (but that can be
> >>>>> done later as you suggested).
> >>>>> <signature.asc>
> >>>> 
> >>>> I can live with opt-out as long as I can turn it off via config.
> >>> 
> >>> Yeah, agreed. For me there's two important parts, where being able to
> >>> disable this is the first one. The second part is that we need to make
> >>> sure that such a format can work for every subcommand of git-history(1)
> >>> so that we don't have to have multiple different formats for it.
> >> 
> >> Can I just check what you mean by "format" please. It is not clear if that
> >> refers to the option name, or the way the diff is presented in the message
> >> template (or both?).
> > 
> > Both probably, but what I meant is the output format. So it would need
> > to be able to cover:
> > 
> >  - Changes to the commit layout (e.g. `git history split`).
> > 
> >  - Changes to the commit order (a future `git history move`).
> > 
> >  - Changes to the commit message.
> > 
> >  - Updates to multiple references.
> > 
> > I don't think we need to have everything implemented in a first
> > iteration. But the output format should be flexible enough to display
> > these kinds of changes.
> > 
> > To me it almost feels like what we want is essentially the format used
> > by git-range-diff(1).
> > 
> > Patrick
> 
> Interesting; I certainly would appreciate range-diff-like content *somewhere*
> when using git-history. The original proposal was more like commit’s
> verbose diff in the editor, though, and I can see a desire to have that
> in all of the supported subcommands, too (maybe just as a reminder).

Oh, right. Shouldn't be posting on the mailing with a headache, I guess.

Patrick
