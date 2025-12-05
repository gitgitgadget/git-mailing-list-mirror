Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445AA2D5C95
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959461; cv=none; b=lipvaWiuiz8+xnCtck6mFghrS0DvZsgzu1mIEK6ZnmBdmBDnqWFiFxNgC3FccMxI8tm3Lc72ynW/ParcNtYXhr11nkusL0Z64JucRlUO+h+SWq59bnVHAOko+05hHutug1j3O545T0siFHVR9OyV2Th2hAR9czkHSmeTjalPYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959461; c=relaxed/simple;
	bh=wnSXm8z503V+1O35qe3Nv+VMhJQvuqTuZK9U1cBj2UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2LF8PcGZ/9TfJiiIhUgP/faZsWlolwKgR/4mUmnVw+CQrOfeB2iWhU5uVuW2a+/Y1YU5QgEkXblAIaxvmRbO5N8Pwh+2dHXeanJceIauRB0N/Sn7+6Pdrsm1vw8kN//oZMROJhkXO9T4cv2al++RaERvSlLgr2I2nBZlHdvNz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cEmZ2hHi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cEmZ2hHi"
Received: (qmail 271891 invoked by uid 109); 5 Dec 2025 18:30:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wnSXm8z503V+1O35qe3Nv+VMhJQvuqTuZK9U1cBj2UQ=; b=cEmZ2hHi2OXy1Zz7ATZN0MCUhzrEzywiBy3i97zWupMsPmWl5H5KlF4t6LovdIjG+fKeNhMUOPcJTVje7Ub4En9olpWzTGAxpZAVU/d0MWQgP0fKUeQh/YjbPBR6W2ZI+zFytpA9DKOdCapmDaIIydCv6xwFUh5GMrqA7DGYO1e3BmAwvNupAAuaTJLMaK1bBSg29L2PkjWL+vyhyhdofzWBzzQ6xTo4GaTYJhgrKCJY9PudUT889IoaHRrnOHMMEdkrJ9nqjxwYAmqgHGxn7hXICx93HSnN2Dx8bPFYSaG06j4MNNGlgEOwd1tNkklZNHvKD/GMGHs+xyncsUaMJg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Dec 2025 18:30:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 340332 invoked by uid 111); 5 Dec 2025 18:30:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Dec 2025 13:30:59 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Dec 2025 13:30:57 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: my complaints with clar
Message-ID: <20251205183057.GA33447@coredump.intra.peff.net>
References: <20251130131351.GA198697@coredump.intra.peff.net>
 <20251130131537.GB199335@coredump.intra.peff.net>
 <20251130134625.GA199421@coredump.intra.peff.net>
 <bd0a8a76-fccb-4b6c-abb7-b53dd890e9e0@gmail.com>
 <aTFsA-jJqcRZJs53@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTFsA-jJqcRZJs53@pks.im>

On Thu, Dec 04, 2025 at 12:09:55PM +0100, Patrick Steinhardt wrote:

> > Patrick's got a PR open for that at
> > https://github.com/clar-test/clar/pull/117 it seems to have got stuck
> > because of a lack of review.
> 
> Yeah, this is indeed a long-standing issue. As Phillip mentioned I've
> already had the fix pending, but I lost track and just never merged it.
> Phillip now left a review, and I've polished the PR a bit. I'll wait a
> few more days before merging it, and then these issues will be a thing
> of the past :)

Great, thanks.

> > ---- 8< ----
> > diff --git a/t/unit-tests/clar/clar/print.h b/t/unit-tests/clar/clar/print.h
> > index 89b66591d75..6a2321b399d 100644
> > --- a/t/unit-tests/clar/clar/print.h
> > +++ b/t/unit-tests/clar/clar/print.h
> > @@ -164,7 +164,7 @@ static void clar_print_tap_ontest(const char
> > *suite_name, const char *test_name,
> >                          printf("      file: '");
> > print_escaped(error->file); printf("'\n");
> >                          printf("      line: %" PRIuMAX "\n",
> > error->line_number);
> >                          printf("      function: '%s'\n", error->function);
> > -                        printf("    ---\n");
> > +                        printf("    ...\n");
> >                  }
> > 
> >                  break;
> > ---- >8 ----
> 
> Indeed, this was a plain bug. I've merged your upstream PR, thanks!
> 
> I'll send a pull request soonish to update our own version of clar.
> 
> Thanks for the feedback! Hope that the pending changes will improve the
> status quo.

It is certainly better for the TAP parser not to choke on the output,
but the more fundamental issue remains that the output is never stored
or relayed anywhere in our CI runs.

I looked at implementing --verbose-log in our unit-tests clar wrapper,
but it's tricky. For one thing, we have to know where to store the
test-results (so understanding $TEST_OUTPUT_DIRECTORY and how it may be
set). Plus, we would then need to duplicate much of the output, going to
both the log and to stdout. And all of the output routines are inside
clar. So we'd need hooks there.

The regular test suite uses "tee" to duplicate the output without the
script having to worry about it. We could use the same trick here.

And an easy way to solve both issues is to just call it from the test
suite, letting it handle --verbose-log itself!

Something like this seems to work:

  #!/bin/sh
  test_description='run clar unit tests'
  . ./test-lib.sh
  exec "$TEST_DIRECTORY/unit-tests/bin/unit-tests" ${immediate:+-i}

We have to "exec" there so that we skip out on the exit handler that
checks we called test_done. And we obviously cannot call that, because
it outputs extra TAP.

But the exec means we also miss some cleanup, like removing our trash
directory.

Probably we'd want a mode in the shell test suite that says "this thing
is going to generate TAP, just stay out of its way". We used to have
test_external, but it was removed in 5beca49a0b (test-lib: simplify by
removing test_external, 2022-07-28). The "modern" alternative is:

  test_expect_success 'run unit-tests' '
	unit-tests/bin/unit-tests
  '

which feels worse (the outer layer of TAP output is all-or-nothing, and
the fact that the unit tests produce TAP is irrelevant). I think it
roughly accomplishes the same thing, but it might be worth looking again
at the reasons for dropping test_external in the first place.

-Peff
