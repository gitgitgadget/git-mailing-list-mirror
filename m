Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673323A0
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740011770; cv=none; b=GqismerXPppRwkNHAsEaSpeOtCAvKGnp3TTYRtA2jE6oGkGarnpMbWl1PuwVYcBLSTuC7bSMU6SGD2wCXllTI9Xaz9xJ+t/MR8H2yrjTkfo3v/mmZfbEO197rLCgk+Wy2txGQTjGUcdTSYpFXbN81S1ZGlsgg2Q5Aai7ocb2taY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740011770; c=relaxed/simple;
	bh=DzrzhH/DbQywpJ7Inc8x4zvfSDJY/P1Y8jVzjvGdeeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbj/oETJpa2XdaKMj5Rtp90J2+r9CSE8ZSpYOXQX1vs4FT1mTaIjAq5411ugIbdUWKGZ1XSrz3ckkwXJ0wTlfcZkBUGmzEL7uJFCuVvqFfh3JSEGOMCqV641b6puQvbEqpnp7LJawPoywc0ufd2AOVIWln+FgnahQJgfK3ARtzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am2QO83+; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am2QO83+"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f410506043so135029b6e.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 16:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740011768; x=1740616568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FnAiEg+Z69ea1Fh1NslX9FK8emVsCPDYBc7lU0fOmcE=;
        b=am2QO83+mnA6pbSQEJX3qSl/ji1WzAEKu1Ff4S0bWxky4rC/WTcCAzDw9jDv2sKIRD
         eSq3y3IcndOQmYqR2TyywrMj70ivtLKEg0J4pXGwFul7hwQwmLa3fBgu9wxfV7t/l7ki
         fNhNuZ8ClZj/tfX9wXGHZpTDQsuiZeiRZLdqfqmuG7yE9S5NVGC3HNjADIhXxynZGWn6
         btewdij941nk9azXjupPh0cjVsUeTRwIX/yLb5nuOoyrcZJvfEQ2XwxyG9OEP9VfkzYq
         Bc7AyySdaenX8TAadzlDhMWWyo+R/lOZ/1NltiaTBMtWkQeeVj83WMolD6VWcSKysDCk
         rMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740011768; x=1740616568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnAiEg+Z69ea1Fh1NslX9FK8emVsCPDYBc7lU0fOmcE=;
        b=LUJ3JW8RdiASz4clBVbEgeNrhN6Wy2MYSsJWCbYjuG4yIERiVN2knl/cSNf4OxlfRm
         +qiIEv7d9DnOBgWE6pOAT+z5McA0cVtztU1C0XOs5P1ldcrwLJhEbCukSUsxDGuk/NnP
         EESKrfzb0N4wGsMf4C7ftwd1CCXbS+siSSIj1FOqvJDxF53CnkLAwy3bqKGZhoZb22Ja
         6d7oixWEE0F0/tLrcBT1swZ8oNhdLfxnOLo2LybCPfGUDJbTLbqDzPyY/rgvmeWITtRX
         npWz2r9qUJmkZ7e2PwD7p+hSUOqCi/uIHQ1do0bN/cyn0Z1NzupMZ80dCt5vr/wCmXfw
         53Bw==
X-Gm-Message-State: AOJu0YyZ3AjbP5YxKP2FW9aNZQmzU14uqKS0x8I48M169Ok841tolbjb
	CfP/7eSMNFDaABFywITImcR/LZUQdpU2IY0eNJvTjkBdStc9sZtp
X-Gm-Gg: ASbGncuVPO2gGbDgRZ95SLbdizM2MCYQuGsxL8N5nP5kjui/19SKirV15YcIcpNhbOc
	XYsib4SeQF0pXRNAoYVfeYjfKj6uZno/WP6a8iSAYk2Ct1dOQrD6x8WpNNkxYCpm68U0pKOCjzB
	XTHiH2Hco50vYikzgCT+PyEjqmixjWsuxwt5n2yKkdUrFsRztn5skESMd9lP2dW/upBIaRpsUpY
	ijLiFHhcYp9PjlKJ1l++ykE5LXYQXuyYdJ0+JXDkMD0WMlGQ75Ck/EWT2L5AWZH78CrJB/jvLmj
	eJNfOkyi
X-Google-Smtp-Source: AGHT+IHfju6SbhLPPZ0UQ6t77H0+zI/r6p7F8W0psLQ0equVsLvJvPt6MYWf/5GWLWewFeolx44v0Q==
X-Received: by 2002:a05:6808:199d:b0:3f4:12a8:b4f6 with SMTP id 5614622812f47-3f412a8ba61mr2856711b6e.10.1740011768209;
        Wed, 19 Feb 2025 16:36:08 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3f3f9ce7493sm2328755b6e.45.2025.02.19.16.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 16:36:07 -0800 (PST)
Date: Wed, 19 Feb 2025 18:32:59 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
Message-ID: <4ch3hdlv23qtwi32mgilym43eqtjefgxi4yi7577xcw6df3lbv@eiemmoap22y7>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-3-jltobler@gmail.com>
 <xmqqldubumxf.fsf@gitster.g>
 <5uwp2vdm5tzv6n26fu77g4xys5ntjy2bj4hpgiuwpamxkij4zk@77jn55tynwse>
 <xmqq1pvtfrq0.fsf@gitster.g>
 <xmqqwmdlebua.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmdlebua.fsf@gitster.g>

On 25/02/19 03:47PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> Regarding pathspec support, being that git-diff-pairs(1) operates solely
> >> on the provided set of file pairs produced via some other Git operation,
> >> I don't think further limiting would provide much additional value
> >> either. If we do want this though, I think support could be added in the
> >> future.
> >
> > Another consideration is which side of the pipeline should take the
> > responsibility to invoke the diffcore machinery.  We certainly could
> > make it the job for the upstream/frontend, in which case diff-pairs
> > does not have to call into diffcore-rename, BUT it also means the
> > downstream/backend needs to be able to parse two paths (renamed from
> > and renamed to).  Or we could make it the job for the downstream,
> > and forbid the upstream/frontend from feeding renamed pairs (i.e.
> > any input with status letter R or C are invalid), in which case
> > diff-pairs can choose to invoke rename detection or not by paying
> > attention to the -M option and invoking diffcore_rename() itself
> > (which should be at no-cost from coding point of view, as it should
> > be just the matter of calling diffcore_std()).

In the current implementation, diff-pairs is capable of handling input
containing rename/copy filepairs computed upstream. It does so by
parsing the input line and manually setting the status, score, and paths
for the queued `diff_filepair`.

I think diff-pairs should support rename and copy input as it would
allow for rename/copy detection to be performed upfront in a single
pass by the upstream and the resulting output could be split up and fed
to separate downstream diff-pairs. This is particularly useful for
server-side diffs to break up what would be large diffs.

> Sorry, but I hit <SEND> too early before finishing the most
> important part.  We can move the features between upstream frontends
> and downstream diff-pairs.  Depending on our goals, the best
> division of labor would be different.  If we want to make it easy
> for people to write their custom frontends, for example, it might
> make sense to allow them to be as stupid and simple as possible and
> make all the heavy lifting the responsibility of the diff-pairs
> backend, which is the shared resource these frontends share and rely
> on (so that they have incentive to help us make sure diff-pairs will
> stay correct and performant).  If on the other hand we want to allow
> people to do fancy processing in their custom frontends, maybe keeping
> diff-pairs as stupid and transparent would be a better option to give
> the people who write upstream/frontends more predictable behaviour.
> 
> Where to do the pathspec limiting is one of these things.  You could
> make it responsibility for the frontends if we assume that frontends
> must do their own limiting.  Or you could make it an optional feature
> of the backends, so that frontends that does not do its own limiting
> can ask diff-pairs to limit.  Which side to burden more really depends
> on whose job we are trying to make it easier.

For the server-side diff usecase, I think that aligns more towards
having a front-end that does more of the heavy lifting such rename/copy
detection and pathspec limiting, while the diff-pairs really just needs
to compute the individual diffs for the already specified file pairs.

I do see value though in keeping the door open for diff-pairs to become
more robust and flexible. Maybe it would be fine for now to say pathspec
limiting is not supported, but it could be in the future?

> >> The tree objects in the input are not expanded. With `git diff-pairs
> >> --raw` these objects are just printed again. With the `--patch` option,
> >> they are just ommitted.
> 
> >Instead of getting expanded into its subpaths?

The current implementation of diff-pairs is rather simple. It relies on
the upstream to feed it the file pairs with all the info upfront so it
can setup the diff queue. This means input with tree objects is also
queued as-is without being expanded further. I could maybe see a future
though where we want diff-pairs to be a more robust backend and supports
expanding these paths via -r option. Following previous discussion,
maybe it's fine to keep the initial implementation of diff-pairs on the
simple side for now. We could make diff-pairs die() for now if the -r
option is explicitly set.

Thanks
-Justin
