Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122334;
	b=k8gXO/JF8VpMB5lbm+WLyhO7QtkkIwtg+hV8C+f8BPcC8sSf4RzneuY0CNrwWh039Pm8
	 8lnQ7S/K5S/IaXwui5X3tXq5I91D8ddbqZT6Cd5ckSeE1AuYqiOrW72iw78RAms2fzKP9
	 1Tql16/0RuQdwMsLERe9aXAVf3WYrTOGP9KBxtD/3t7NFIwAw1OekUvasOGxW0/jFn9U3
	 JZmlo5pY+uMGgnf8o9Qjxp2VVi4sXt7M/u9jphO91g505uVOx5xw6retvlvFHSbeWtuCe
	 0pvr5K3Xs+5o3a1OAQxlj+4+MlYzbMPoyc0WIn+NlxLumx6tjn4m4PyLHCJUutqBw5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122334;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=1bbHQLojTavCy8yh8Y23pthKHMTDwZ0BSkDBevh/e64=;
	b=J6+2AU5gJqCyI1y8u+w5MmjXJJeVMD2S0rL0hIJmg2bGXsz5x1yS+9P9Eh7q7rPtYqLz
	 2KjNT/8+Gc5QRepXnCARy6yt/kWw7xcsjZVAkNimmHGR6NUz5rk0qqW6Bsf9vq2Yf1yCy
	 rvwmF3qr4tgBMzEtivQ4LkikwE8m+p4r2HV9xP3vmXebXW1rkTXxJ9S3qwOSWh2kYO0Q0
	 4MevFg2OQzByRwfOaWMoguXB4/elz0vceLxnJLe07ryvIRFehTTgphiuFyGPEv9zmerhr
	 m3sxVaQCrtn1CnOw6YpY6lOR4OHWJQYbXwYyytm3H0PyliKanjhVlj+3ObvhYXjPDig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=ZGyOWzJt;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E719606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E719606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=ZGyOWzJt
Received: (qmail 38333 invoked by uid 106); 27 Oct 2026 17:32:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=a7gRBORxTAJDZ/gEqEQyzEf8eigzXPC04tqPoLnlwBw=; b=ZGyOWzJtlO7LHPPkFuHTP0moMQOoATH5FGZIN2+sROEtUgoAKxYUS4Wi/SLKA7XpX96Cgv5d1Q2trAq5BttYEYS/9/h/fcf5r2mXwEErcdNeI13cQubcHuJVPAia7CkAI+1ZgqMKEU/FV9BnNLMfLpb6IH0IIsb7b8HKe4D0rNbHdrfUpd6EXjk1Zx+Tg9fUbxCEJtnaaqOsgvasuIqReET+rO5ajUFp9KaEJpP9OADYlyAau8L8ThggnuVPeSE1WJe03viUQplssDLoZA6WvSvvIbt+DzZK+Q2euBQm0mBmk75vzcQTt1iyQhTipJ7U823PZZufNyJt8t492NT9UQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2026 17:32:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 275880 invoked by uid 111); 27 Oct 2026 17:32:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2026 13:32:05 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Oct 2026 13:32:05 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/8] running unit tests inside a test-lib script
Message-ID: <20261027173205.GA97799@coredump.intra.peff.net>
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

I saw a unit-test failure in CI a while back, and much to my annoyance
it was quite hard to debug, because we don't report the unit-test output
at all!

The problem is that we feed the unit-test binary to prove, which eats the
TAP output it produces. Normal tests get around this by using
--verbose-log (and then CI dumps the log). But the unit-test script
silently ignores that option, and you get no feedback at all about which
test failed.

We could fix that, obviously, but I think it's a symptom of a larger
problem: we don't do the usual setup things that test-lib.sh does.
Another example I found in the real world is that we skip some
environment setup, like LSAN_OPTIONS, leading to worse output for some
leaks. I'd guess there are other cases, as well.

So the real goal of this series is patch 5, which just lets us wrap the
unit-test binary in a regular t0001-unit-tests.sh script. Patch 4 is the
test-lib.sh tweaks needed for this.

And naturally, the whole thing turned up a few bugs, which are fixed in
patches 1-3. But it also turned up a number of cleanup possibilities.
The diffstat is very satisfying, but note the final two which I've
marked as RFC.

This would also avoid the need for the unit-tests to ignore test-lib
options, like the patches we saw recently in:

  https://lore.kernel.org/git/20261026-ks-unit-tests-ignore-long-tests-v2-0-fdbbefbd19fb@gmail.com/

I didn't clean up the existing ignored ones here, but I think it would
probably be reasonable to do so.

  [1/8]: unit-tests: report the correct unexpected argument
  [2/8]: test-lib: drop unused test_external_has_tap variable
  [3/8]: test-lib: stop inventing a JUnit testcase for empty suites
  [4/8]: test-lib: allow an external program to supply TAP output
  [5/8]: t: run clar unit tests through test-lib.sh
  [6/8]: t: drop redundant unit-test invocations
  [7/8]: test-tool: drop the run-command testsuite mode
  [8/8]: test-lib: drop the shell JUnit XML reporting code

 Makefile                    |   1 -
 ci/run-test-slice.sh        |   5 --
 t/Makefile                  |  12 +--
 t/helper/meson.build        |   1 -
 t/helper/test-run-command.c | 173 ------------------------------------
 t/helper/test-tool.c        |   1 -
 t/helper/test-tool.h        |   1 -
 t/helper/test-xml-encode.c  |  80 -----------------
 t/meson.build               |   4 +-
 t/run-test.sh               |  18 ----
 t/t0011-unit-tests.sh       |  20 +++++
 t/test-lib-junit.sh         | 132 ---------------------------
 t/test-lib.sh               |  16 ++--
 t/unit-tests/unit-test.c    |   2 +-
 14 files changed, 33 insertions(+), 433 deletions(-)
 delete mode 100644 t/helper/test-xml-encode.c
 delete mode 100755 t/run-test.sh
 create mode 100755 t/t0011-unit-tests.sh
 delete mode 100644 t/test-lib-junit.sh
