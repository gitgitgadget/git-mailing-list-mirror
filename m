Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D435AC13
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850357; cv=none; b=UYsC2a0gJEs4v2j18mNsCovsa+qCMFeOukqt/C2Hkfvo1Oa/rGsGLbjopqsxiXVo2ml/zEbGZlcLeXX1m8loNKAID7lGKBMc6BCAjwLLDMp+N2OLZgwqypcLseKBEwWyiOYJY44e+zxcguKrIMhO0ExzSpTkkJ7YayRBdZA904M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850357; c=relaxed/simple;
	bh=RI81ZT890Y9YNuzNoZWIiXJLiblcT+iGK0vjGBgcbK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9t14WhJxAFJYTAVa1cZ/DygbUAh1EWxCEXLtdDC2eif+Fq8E12wUoqW1BNYvgJVKyYHcm9FJYmtkKp3ExMtMp9HFC3ol34s7vFKKgX5WO7alof3DBAN8I9i2zCGAFANtuNNDqhZoTzPVI+aH6dgrWcWG/rqV/04hnEUVdYUFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mkIflurg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EM+u0ySK; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mkIflurg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EM+u0ySK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 97DD31D0015F;
	Fri, 19 Jun 2026 02:25:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 19 Jun 2026 02:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781850353; x=1781936753; bh=671PRNa4mD
	a1bt0QrTmU91qMXmfZEskPgyHyEW5zMMM=; b=mkIflurgcCGJ9Mlo1JHyUjxg55
	gYHZSFUccUE5Z2fVu/UdhJUsr6LNkWkeYNZwc1iTUU8b3+KyaO9inoyI8Vo4FUyX
	zzFRFiyoa/zUffe8d6AKBD2un3uT2ah2DFs5wHarp1X2NGUaA4rrqKBhOx+EzQw+
	vVjpcGzkiRpcbMaAF2MA2f+pVEsVOQbltcK5NfpwNIcBCFdZwIK46fm6zyZXWYjz
	bMa4MGidtEMGmxD4rdGqd2rCbVsrfXdDCMkP901rss6jscgpWU/FeJAvx4TzPGAX
	Rv7WdZa/WOS3u3sDNTUABZQTvlqOFHIYN7TVIBEt7gFHDSVjd+T/WuNHOmWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781850353; x=1781936753; bh=671PRNa4mDa1bt0QrTmU91qMXmfZEskPgyH
	yEW5zMMM=; b=EM+u0ySKR9rMP17sZvP8sw2myugAFiALJb2Px/lbN8ZEwVSevNa
	Mtx5WSpufEcGnMoCs6K0/bsAr+XWthcDPr6UMnjdCdWpZQFW9RV2OoNlSfxzKV0Y
	2aTrB01pBCLFUNnvWuHFCfSEcquLjeXtML3IIHwstC0DnSl310CGLyfk/GnHroh4
	l+0fFh3Cmyc2drDuqA4UwHSx+8PBMJhJGtg/0CxHrjHrqV4ivBGP7Eid2HMyWgPs
	7gx62J0ckBQAAGzzQYsHVSwfJLXvkxqZY0BPIPdzFKOeEfi1RZJ3//uKr2DVOWgp
	vOKQkmla5DAZ2bFh5kB99PU6P+Bt0cWUg1w==
X-ME-Sender: <xms:8eA0autYB0u02AwCLbYxqEPBjCslTcg1EItSxSjH4EBEn3nq7s_NCw>
    <xme:8eA0aq71eQCSOOWajsixA403LjD_Gb5BpKeZ6cLhbhJkWmCyxVEJl5qyev-L04xst
    tnwach2l2YExiNwrE0ox9mzagl5C5oxbQnVrm8Jv_yHfYGsvxFPlYM>
X-ME-Received: <xmr:8eA0anL3jVsIUCWwN6Cfy9_q2NbItNz-7KktYvJUtG27SWG0T5PpVMicDt7gxwt5sEuViQI1qKFmV8CMMSzOfIAsdLEUlBPTXo8CJTtH744>
X-ME-Proxy-Cause: dmFkZTF0KL1kQHpqYhzGlHqlxjUMzJJncQZIbyGkRI495GbCgjYU85puhfuqrMYCW9shLn
    E8WIyhB54GLin0MU9Atppr3VrelSuYNJxF95jbgKYnQ5d3yYzXFA8eNHgSlg9qjd2qbdEb
    ayHJX9mMOMXaHPFCxJ9rr7ytxBCEtR5jBlRBQKEj+uO8BAnq7IeMOGjf6T5qqzs3yRAiI8
    WJWNpcu5FwxHnBeYLeCDxfhV/qNOl3ZFFXkILsJ1IRyD9Tyd36RRoMRo+NbM7ux5yn/GlO
    vdnoBl98+y/gh9DXZcXkoijcisRXTv1dJsHCQYBX+7tV9NzqN/8LHY290QhfGrW+kjfUZ/
    kqgaaFmr/8dX9U2c0FfPYhvRZj5qpsm3kI3KuHctsYHQsiSwWhgAGfT/h8yerTV3Iw/45h
    w0RHWl6ks72kbuHQHXHXk01A1GWl6PKUK90WSz9/ASX17uSc43Rh+EOtHWXztCR7ZzGbkc
    uI9IlR7A1VQjdBB+UW9uysJfaX6cQBj3a46/gx0F8DKRCLpwlW2Vn1Hb7qMpfd9abDT8NQ
    jgz1XKyk+6gaUhNf6VnNXrAr/7bqZCOeT701RxusTWj1l42lglDQNuxHbd7UaYjuNZTDZQ
    b9y5MKhoqltBeiixHkTXgQ90Noym80+YjwTmIBzGESYFALjajQIB6S9JABpg
X-ME-Proxy: <xmx:8eA0ai5LpWk-So7ZynQZrx4zMh1bVSNainDJ2VSgNPRyS-koVtNnvA>
    <xmx:8eA0aizStRn9yDBcXKFy0VYkTDIyTDxBYOEaZ7CzOSqfQyzal8Kswg>
    <xmx:8eA0auaFX0DoTKtlaVR6t7tgBxHBlfrc3BR4JZP1n-O4zT4XLGZeDg>
    <xmx:8eA0asSw04wHFCiT3xnewMA0F5it5dRdPZACWNyTmHdOFnAe5LQ3kA>
    <xmx:8eA0ammtxkAQcjG2T832VWs59mHtrphsh0qovB3i4CdwdJ1YvK7yx_QZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 02:25:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0c89546 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 06:25:49 +0000 (UTC)
Date: Fri, 19 Jun 2026 08:25:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 7/8] refs: fix recursing `get_main_ref_store()` with
 "onbranch" config
Message-ID: <ajTggBKIzgSpp99X@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-7-f4854aa99859@pks.im>
 <20260618164035.GA1218204@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618164035.GA1218204@coredump.intra.peff.net>

On Thu, Jun 18, 2026 at 12:40:35PM -0400, Jeff King wrote:
> On Mon, Jun 15, 2026 at 03:56:53PM +0200, Patrick Steinhardt wrote:
[snip]
> I'd expect the ref database config (like the ref format) to be read not
> through the regular config subsystem, but via read_repository_format()
> and friends. And while that does build on the regular config code, it
> should never enable includes at all. So includeIf.onbranch:foo.path is
> just another uninteresting config key to it.

This feels rather painful though, as we'd now have to do this for every
single backend that we know about. Also, I think not enabling includes
is an overly broad fix: there isn't any reason why "includeif.gitdir"
and all the other conditions shouldn't apply. We really only want to
disable "onbranch".

[snip]
> > The consequence is that we have recursion:
> > 
> >   1. We call `get_main_ref_store()`.
> > 
> >   2. We don't yet have a reference store, so we call `ref_store_init()`.
> > 
> >   3. We parse the configuration required for the reference store.
> > 
> >   4. We eventually end up in `include_by_branch()`.
> > 
> >   5. We have already configured the reference storage format, so we end
> >      up calling `get_main_ref_store()` again.
> 
> Ah, the culprit seems to be ref_store_init() calling into the regular
> config parser via repo_settings_get_log_all_ref_updates(). But that
> feels weird to me. Either:
> 
>   1. It is application config that should not be something we need to
>      load in order to initialize the backend. We could lazy-load it
>      later, or rely on higher level code to set the option.

I actually tried lazy-loading, but I found it to be quite painful
overall, as the above setting isn't the only one we use. The reftable
backend for example has a bunch of additional settings that it reads.

We could of course start lazy-loading all of these. But that may not
work for future backends that really _need_ to parse some configuration
at initiation time.

>   2. It is crucial to the ref backend functioning, in which case we
>      ought to be reading it alongside core.repositoryFormatVersion, etc.

I think ideally, we'd have a way to read the repository configuration
that explicitly disables parsing includes. We could for example extend
`struct config_options` to have a new "ignore_refdb" toggle then
explicitly use that in the reference backends.

I'll give that a try.

Patrick
