Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212270;
	b=dtzZ1CpZ6ZlM0lQraT4uRp4dFp3I8nMMKtjjFeU+mKmp5X/xrB05oa+BupIdclVwujjq
	 t4nUvn0BFnmgRokSV7q3JUXoQ8Y6mdAarEyNpGrIr8SaFh9WlHaHDfM48rcx6/e0GQCjp
	 vh2pmAA50k9Ue8RwJmdlSVwTu0lFdggcTSWg2ApEU1WmkTRgTulAdfs/IXp5/wLZGgiam
	 QXh1+gvzlrpuoRLRh2Hb1USUEEq0TzHwRkIra3tsZVVfF2ltSif+EKH2YMJx0QBK41jyW
	 aakIyxvnn4UciLkFuIhK+qgGXWsNRalmNqK2y3Rlf4ZqHb6vALpFW3mo2EHRuFVXhQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212270;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0PF26U+v57vs1kALUd8L5HM7DPe88JHvgfLKMcOmK84=;
	b=GzCPP0OZZ3jY1TaiYTlYGzFhKR+UePa65X403L9Tp699j3QMcGcTbXpFfHti2gcJ7yTn
	 TJvg7BxhYl41LuFDTbKkRtplqitKCLF6CtvFKadOdVYKyxV67G0cvH9vlyN6y8UgS7waW
	 XEpO5GtibyGsnyVFrXspXNbNEsFYOR+E+EXIJInI0wzRH79+nGXKC3kN6vVg5KQu0kW2c
	 lpxNtkcKArqv72lI9O/+5FBgZYw2amHGfycH4NLJwX5pid4hVNiDxWNU4PVIoWri1dJYN
	 RAoaDBZW1hvj0+uO6exI54XLaFfDPLmM53JkLr9xl3kgysVGbUMO/Pjdz+tePqeJByg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=RuUIyFpI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GREnGkzZ;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C23606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C23606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=RuUIyFpI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GREnGkzZ
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id CDA571D0013C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 03:17:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 09 Nov 2026 03:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794212267; x=1794298667; bh=0PF26U+v57
	vs1kALUd8L5HM7DPe88JHvgfLKMcOmK84=; b=RuUIyFpI/JOPfNNUTgfcxhfxcZ
	LTozLnPGPPDdhhs28PEURwQW/4uES1s844d1EjeyMGh0y9KC3kdej3pClKzhhzQl
	HDjtyxzBoVkGqO7yGUrCVGH8z9EHf8cwSUQYvBljUf1W5vtv3P2dqhO1kmBWvo+Q
	7npZyNSWLtx3QLMEKCA//VC9A/aZ+6lDF75lMX3szyT0cUh+Vhpqe3SwQpXYiJ36
	CCZZNW+S6/1RBPjRu2TOcjaWnXMtDwUi0Mo6jIQI7VjepAxXMmcDHgAogePSBbGZ
	JUC6qIjWBweIdmsu/p/5vgHVdSk1I0MQViz6+3x+6qhOB2hsvfDIYNYvMFAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794212267; x=1794298667; bh=0PF26U+v57vs1kALUd8L5HM7DPe88JHvgfL
	KMcOmK84=; b=GREnGkzZt2mApDcS0JouNRTEb6XRdHqzsiZorBGCEcbleHxvfBE
	nsXDxqIT5mkTjq5OfB4eoP2XPrun/4FtfKGjQ/A09f7UBENteFPT1BBwB+3cN3T7
	ma1HBh7xwTqtyBuHMJGWl4N1bHvHg8jPSxb2xGz7eqpSzfiDYMyvcWv9MDScu0UO
	yXNGpFAjlzg8Q/sliWgo3IUdriiaFSeGm3aP/6GnCYJXf+qYYA+P4H7ubWKATYN+
	InWnPSbK6CUEvxePzG+e13fQcD/4kPZ2f27WnbIeiZ6m/R/CmvnRSQR62MPdxrYI
	jRpKFqNQ3h6aTOjSlD/mQ11UmBnL9IBdxHg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794212267; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:QxtNDsueDTdGi+CmszULU9vs4DR4SohQxngfIJXjnT15rvS
	ujztgmy4iGc6jP2LhN35BS+1LuybizuFcKwIG7WLaFFpEIVzsd6rg0P2WfqF3t5e
	24dIuGIeA5zlxNrMAzMeTLftwd2tBHJbc6Nu9PSJvUVu1sBxmHnUj3FDJPHjSSnv
	cu3hSZrTvqEwUXiGmBQ9BvKmIp+buExuoxZYkuxS5YpXqsFD8GFUSgVJsE/ObN8b
	mKVGiLrWtQeD12Iyp50KoExNvug5o9rlm+/YRDrYL1or6Y3uvIHBwDgn6jS1bV9U
	In3P6te38k2Gui1hRXGVJeen1oF41VS7BcMSUUg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3kRMCUcIP9+sieEP2vRLjCTq8YJ6JZ5fmHOxR3aw5u0=:vVmiz4zySj6GBLAgOAn/XmLlp+u5I1Mjlxt/i4WG2jc=;
X-ME-Sender: <xms:q4HxahezKIKr2XvkYWhe5S0Z4DBumf7rvE3P9jvzF-4h8htE2Hf89w>
    <xme:q4HxahfvPAbvsJYp505KJEKqC-5UPof5XKzkvX3s_qzCxmlb6eC_unzZRgrT7LPa2
    5Gn6ulj-l11-7vGAU9siQuQHpqDIqGj0H39q-3jvkdg1Sd63ns9Cw>
X-ME-Received: <xmr:q4HxasxSOK2jhLDfA4CcyfXmaHS2nKUJ9Wg81BOMnxEgzN87BXex1vybjZ6uc0yB7ouGavI>
X-ME-Proxy-Cause: dmFkZTEfhceFDfx6oruBZO5tSPy+W54nUEat6pYvANzqGAHv3Ep6Y767dM6N7ZgReaqO2g
    7bXxR9SAP4FioVLeu5SDDob4ol4+gBr6rvWx3rKJ/7u2nCIkjn95Ovk9IerL4gjlH04Evu
    G7jsH9yc3y6SMRyz8KYgIpb5PZJsixWiiJkQO7tP5t1m2p+PNp+1WGxLgEqomvC5TUZoex
    f+9//22UkQefuzesxL8/oRTRL9ECmbEGfREaadYWpotLDTDb99gCqHQELbDU83vv/XIkFD
    vDzMDlw7vZ6owmN18Ya1YvrzdS6Rr1GVpQpPsc/Ghx9+rtx0Vnkfr2BCV0NzlpkHjwnpNR
    6pOvg8rbhXROVh9RFlqEZFa/xLxrsSr0tmxoZ6qo4lPg8MeGL2FxQ2xnP13ZH4465AuRd/
    BI6ffinP0Vt5Uv9F4BfelHyIr2t4qFh75KRimiuSHDVa6lkgq7R+gCz3++KrpuZTX6uEM6
    aJZm3z0btWxe7EGOgB38Wa1z95Uwoz2++7SCNGDp9eZ5GT/P9iyvx8AZiZNnZ+k07gJCtO
    C7o9nC98z8ysGCmorDF7uqnRQbybFANBDAVQyEnwtyyBtg61lWKSxSe68vGSW0tsnavZcO
    STs3h3BFzuDF8mvVc2XsPnT9blw8a7I7T9BHuxm5jR2FyO1YVfPWrU/skqKg
X-ME-Proxy: <xmx:q4Hxag_3HSbN4m_na2vsXIUGK3QaB3zcYv-hgyaF5JIXu87z7kSt2w>
    <xmx:q4Hxash_QjJiaCSdkOTL4_U9ERc4pyO4d4MA845lGLw2rcUlT_9kqQ>
    <xmx:q4HxavF3y7MX2OKf1-CRak-ou0VwmnB7bSjH1NciEe9zvygj9FUlCw>
    <xmx:q4Hxaj_zal8WEixqs2ZS6uVJ5Qy4hfEK3GaQtxozgHMY6XvsMAjP6Q>
    <xmx:q4HxanQjkIPhJWbuGWmRXkF_0QUr9MYkKBnY3BmqMskeW9v15MpMyqiM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 03:17:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a408673b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 08:17:45 +0000 (UTC)
Date: Mon, 9 Nov 2026 09:17:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com, siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] merge: stop using the_repository
Message-ID: <avGBpifgkHQ4L6WZ@pks.im>
References: <20261015142532.48175-1-okhuomonajayi54@gmail.com>
 <CAPSxiM_2Dd86rBKPj7jaT8Wmazo3PFZajJaaL2bVhB1GFsfnbg@mail.gmail.com>
 <xmqq33tdcuub.fsf@gitster.g>
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
In-Reply-To: <xmqq33tdcuub.fsf@gitster.g>

On Fri, Nov 06, 2026 at 05:07:40PM -0800, Junio C Hamano wrote:
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
> 
> >>  merge.c | 16 +++++++---------
> >>  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> >> +               strvec_push(&cmd.args, merge_argument(r, j->item));
> >>         strvec_push(&cmd.args, "--");
> >>         strvec_push(&cmd.args, head_arg);
> >>         for (j = remotes; j; j = j->next)
> >> -               strvec_push(&cmd.args, merge_argument(j->item));
> >> +               strvec_push(&cmd.args, merge_argument(r, j->item));
> >>
> >>         cmd.git_cmd = 1;
> >>         ret = run_command(&cmd);
> >> @@ -68,18 +66,18 @@ int checkout_fast_forward(struct repository *r,
> >>         memset(&trees, 0, sizeof(trees));
> >>         memset(&t, 0, sizeof(t));
> >>         }
> >>         for (i = 0; i < nr_trees; i++) {
> >> -               if (repo_parse_tree(the_repository, trees[i]) < 0) {
> >> +               if (repo_parse_tree(r, trees[i]) < 0) {
> >>                         rollback_lock_file(&lock_file);
> >>                         return -1;
> >>                 }
> 
> This shows one thing that I really hate about the current
> USE_THE_REPOSITORY model.
> 
> This function still calls unpack_trees(), which explicitly refers to
> and depends on the_repository.  It is somewhat misleading to claim
> that merge.c no longer depends on the_repository because of that.
> Even if you pass an arbitrary repository to checkout_fast_forward(),
> the call would not work as intended because unpack_trees() called by
> it will only work with the_repository under the hood.
> 
> Yet, this file now compiles without USE_THE_REPOSITORY defined,
> giving a false sense of achievement.

It _is_ an achievement. That achievement isn't that this file is now
properly libified and that it can be used with an arbitrary repo.
Because even if the subsystem didn't reference `the_repository` at all
anymore, "libification" to me isn't only about that but also about
having a sane API.

But it is an achievement because we have one less file to worry about
with regards to our end goal of getting rid of `the_repository`, and
this file cannot grow new explicit references to it.

[snip]
> Again, that is why I really hate the USE_THE_REPOSITORY macro.  It
> does not help us measure our progress incrementally.  Perhaps we
> could hide certain symbols from their header files (like the
> functions I converted in this demonstration patch to rid them of
> the_repository dependency) for those who do not define the macro,
> so we can get a more accurate picture of our progress.  However,
> an earlier attempt to do exactly that on notes-utils.h in
> https://lore.kernel.org/git/xmqqjymt94l3.fsf@gitster.g/ was shot
> down by Patrick, so I am not sure what a good direction would be
> to provide a real incremental progress indicator.

The thing is that no matter what, unless we now start to hide every
single symbol that implicitly references `the_repository`, it will be
an imperfect measure anyway. And sure, in a perfect world we'd do
exactly that. But it would result in a ton of churn, and I don't think
it's easy to get right.

So from my perspective, the best direction here is "forward", because
the problem will solve itself automatically once libgit.a does not use
`the_repository` at all anymore.

Patrick
