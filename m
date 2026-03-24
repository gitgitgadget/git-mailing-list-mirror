Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06292E11D2
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380919; cv=none; b=g3FkdHSyYB+iY3RWvWRJ5GfgNNvMvXvpmWFIx2xc6IPbV+loJVl8Jr75E+UREyT9WLGHQ8jTK/uJUfLzrntgvylO5vbztX+ziV1y9Vc7ClFtLeApz8XLV6J15+VoR8uhgdAXRITA+rugr3k+eCvqv/R/fsmglXQ7JS+EyeJh0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380919; c=relaxed/simple;
	bh=MPw+AUJ95kili+T362RHGoSgzpkgroIeBCceLyXXs8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QC8sAKaRtqdj4r1RBbSHNVbMWXmimLgPs6oPRBrJ8mM9IAyam5KNQuSB4xYJEzPr/Kohy8W87yBrVH6dCr1+3TTzfNy8c8eptn37C+JDVYNO6gzwbGDTvtp/i2ZsAdiiVCvrqL7aKLDYi63CxfBdDYTSlmkRwwx25tWc51FekJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iFn/2dyd; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iFn/2dyd"
Received: (qmail 130556 invoked by uid 106); 24 Mar 2026 19:35:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MPw+AUJ95kili+T362RHGoSgzpkgroIeBCceLyXXs8Y=; b=iFn/2dydOVACllV9jSbqGtJExvbfC35XzyfFZglRsyNP6kmOay9vODz1iuV55neSsmhfrgHc3sW2M+qaEa8FjOHbU4sokjmv2LfvcKez8yCM46tjRgm7QBS+uwpTCUFhycoL9W4VoqfkpRqJGrw+RT14nlaCp/l/6Rcc8ivUkXdymDXxPrgHtU+qVOeOqHpFovb+Wb8Ekr3Dq2wpc2HRT569IwxJiwA8lDll4apcxCT4japnM3rpBJ1sCZBBPhCh8Gv1GZ/mOOlxIKUiQucdiq3NoUyE5W3QNtglmRV8pz8P+QO9Mz5OLadmtUPGm1x7Xrm0Xcf05jnflgoiXXMVJw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Mar 2026 19:35:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 173978 invoked by uid 111); 24 Mar 2026 19:35:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Mar 2026 15:35:15 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Mar 2026 15:35:14 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] test-lib: catch misspelt 'test_expect_successo'
Message-ID: <20260324193514.GA1870130@coredump.intra.peff.net>
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
 <acKqvI0EhaORjoD7@exploit>
 <xmqq5x6l2q5y.fsf@gitster.g>
 <acKx6yBi-BWUVJcv@exploit>
 <xmqqo6kd18sr.fsf@gitster.g>
 <xmqqcy0t178a.fsf_-_@gitster.g>
 <xmqqmrzxyu2h.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmrzxyu2h.fsf_-_@gitster.g>

On Tue, Mar 24, 2026 at 11:13:26AM -0700, Junio C Hamano wrote:

> In order to catch mistakes like misspelling "test_expect_success",
> we would like to eventually be able to run our test suite with the
> "-e" option on.

Using "-e" makes me very nervous, given all of its quirks. Granted, most
of them are related to it _not_ kicking in when you'd want it to, but I
worry it will create false positive/negative headaches.

In the past I've caught errors outside of the test snippet by noticing
cruft on stderr. This is especially obvious if you use "prove", which
captures stdout and gives a nice display (which the extra stderr then
makes uglier).

I wonder if we could automate / formalize that. If we do this hacky
patch on master:

diff --git a/t/Makefile b/t/Makefile
index ab8a5b54aa..f57180cc7b 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -79,7 +79,7 @@ prove: pre-clean $(TEST_LINT)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
-	@echo "*** $@ ***"; '$(TEST_SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
+	echo "*** $@ ***"; '$(TEST_SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS) 2>$@.stderr
 
 $(UNIT_TESTS):
 	@echo "*** $@ ***"; $@

then:

  cd t
  make test
  for i in *.stderr; do test -s $i && echo $i; done

catches the problem in t4014 and nothing else. Note that it _doesn't_
work with --verbose-log, though, as that redirects stderr to stdout
(which is going to the log). It might be possible to do something
cleaner and more clever within test-lib.sh, though.

-Peff
