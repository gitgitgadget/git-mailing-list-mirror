Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20382229B1D
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622692; cv=none; b=UmKkWKZCirF8/N3ANtl4WrLiDxY5B0aSJOxWnq7JSDIW1Wb7r5ZJxpEk6NLvBvW3KL3pVgqTRKEaeEONLDV9QIUa/PScFhYmWz5+lIDN7GqARCaHoAZp+3Xu2pWD24OblXZ+xFpdkndRR+o974g2IGvjBkGDp9KpYtv2NBbwBL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622692; c=relaxed/simple;
	bh=xc4qWwC3OseIib4xQI6eSw5tSUZMLdcEPV3zKZTPqZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFhmlEToVvHql6dgT91CYMoQU3/eI1u/NOj/J4Q8zbFsndBiNe+0bJ8k353y5f5uYm4JnnLhOiv4bqMYgLYZ8Gr7bhE9jHjzxkuP15C/Su6/CAOVSqtuqjHDJU4Dl3KN1Uh0rkkFeYT3sfybS3CsYAdfG/n/UxMv+nBeWA0jfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NzNJqybr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NzNJqybr"
Received: (qmail 24062 invoked by uid 109); 10 Mar 2025 16:04:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xc4qWwC3OseIib4xQI6eSw5tSUZMLdcEPV3zKZTPqZI=; b=NzNJqybrhlzQ2vnnWg1vDgAFYxCxSu6lfSktavwWIIjuRanUyCZSKV5f2StGcuv/6llxP140DbMwaxObFToxnavZHkc5nNZ9rJcOO2F0NNKi9N4C7SlHVknRomH534jgnWuH4rXVEbksKrGg2i8IqwL3bmbvnPGEML9IezaaMK7PVG7xTCm/uqaaiZm8J15TJuv/2A0Vt2nUHVfakgwH+X6YR4cQHhGb+xVRzLbaz+0kvgLTpyM3E2pcOD0/BzjemF3XQaWNOAH9cnSjXmqaTIOKNgbfqALmNWd3zQSMcxGVrbf2lMLOBZBG+eUfxs7Vrzv+NTQ1AvqcjUtCfyWsUQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 Mar 2025 16:04:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29466 invoked by uid 111); 10 Mar 2025 16:04:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Mar 2025 12:04:41 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 10 Mar 2025 12:04:40 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im,
	jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
Message-ID: <20250310160440.GA26189@coredump.intra.peff.net>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
 <20250307195057.GA3675279@coredump.intra.peff.net>
 <xmqq34foefh8.fsf@gitster.g>
 <20250307225444.GA42758@coredump.intra.peff.net>
 <20250308032309.GA584028@coredump.intra.peff.net>
 <xmqqfrjkao75.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrjkao75.fsf@gitster.g>

On Mon, Mar 10, 2025 at 08:40:46AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Mar 07, 2025 at 05:54:45PM -0500, Jeff King wrote:
> >
> >> However, clang does implement this option, and it finds the case
> >> mentioned above (and no other cases within the code base). And since we
> >> run clang in several of our CI jobs, that's enough to get an early
> >> warning of breakage.
> >
> > Hmph, this might be more trouble than it is worth.
> >
> > After correcting the problem in the refs code, the osx CI builds (and
> > only those) now fail with:
> >
> >   run-command.c:519:3: error: code will never be executed [-Werror,-Wunreachable-code]
> >                   die_errno("sigfillset");
> >                   ^~~~~~~~~
> > ...
> > I guess a knob-less version is:
> >
> >   errno = 0;
> >   sigfillset(&all); /* don't check return value! only errno */
> >   if (errno)
> > 	die_errno("sigfillset");
> >
> > which is subtle, to say the least.
> 
> Bah.  This is just as horrible as some other warnings that are not
> enabled by default.  I guess we should just be more vigilant X-<.

Yeah. We could perhaps live with hacking around this one specific spot.
But there's an open question of how often these kinds of false positives
will come up.

Maybe not often, if there is only one instance in the current code base.
Or maybe a lot, but we wouldn't know because we haven't had the warning
enabled.

I guess another option is to enable it in _one_ CI job that uses clang
on Linux (maybe linux-sha256?) and see how often it is helpful or
harmful.

-Peff
