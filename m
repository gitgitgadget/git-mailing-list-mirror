Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122707;
	b=PIrOw9dmGwEI0Ei+p/8yFZ8o/t8BNo7QPoVErZTPfkJJlW8aIJRgkWV8pszzN2U99OFx
	 HLf+EyRLQTx0tqSGuX5AYCUFGuD/WaAEQR3d/JlhYxW2+RsTAMOqVKcaLbrrBr30OfK16
	 HZiOC/JMK7/GkfbKjDF86p+7HlUurKgtRIIKaXxxYBvatxJPnOeL2+oD+L3uxtVN3BcAz
	 +k2OkelcgPLSgLs//wVCiSy+rP4zGLDJFTSwfxV4d108z8FfQ37yPhd2M31GPfiR0dwai
	 +bg6exqojdk7Itr3oBPD3loRyodWmHl93wic2QcprCdwhf/2jDhLQZh5e0cN8eU5VjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122707;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6/dCAN/UoyeBsTqnTIQakzA2lLO6P2DtAvetR1kaXtI=;
	b=pznvTafbbqLniMNp/F4k91Vd+NKiyMQrj7KrwftqLontcaLsjTOvlZ5h8qNzxnLSBbyt
	 jEMeN0UteAQwNHEzzamcoGJbMAk0WMufDbFkY19Oo2OzJ3ocJj7AnNQXZ9A25e7KVMmyO
	 YNH4Kk9K/9guIMoBaH8l2a+LMKpjcWFyusq+SsohBjFwJijHbVhZfPNHz0FQU2PtgaY8z
	 fucEqFSjcLURmwzufuIsXCkwEQ4gUk/245mjcBeMHBwMpP0dXpRreOYzpclQyvG+T4NSt
	 hXyJpDKje0CCtDT2apE0jltzK4z9dJ187o7FAKQAe+33QajCoEIbVtFjo5V8MwID6oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=BDunca5c;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E606606A31F
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E606606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=BDunca5c
Received: (qmail 38402 invoked by uid 106); 27 Oct 2026 17:38:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0mDWdD4xLEt9d7c3tnCdbfoNgRyEpcwZoA4t6vqIet0=; b=BDunca5c30GkAMktueHsxXvmfy8ziVL8JBySQYM5TXEmGtMUDwpdibrN83bQDhSGvxJu92YEMVJ0y326IJo/NW/4r18zgiJrwmqNSL9MMYzV4fyTYPOHf7DNsCwzD1zD+l73wJNqErF2XBbfio5nTMvMYitSuYHSH3tWbhLa9SdPYG1oDHNcUiboR8SpkeoG94At/Upaq/mKbCUoeEzSwZw24P2nUVJdYVyZKEVy76Ccfaeb5eGDFa9gkRen1XTLy5fo7rOXeYTv4XCrD+oL7h0w5P+UBsQv+LGltutI68UhfaQOllqNyv+6hjQ06kTzYO30WBiGE2O4Kpaw7aqqhg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2026 17:38:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 275982 invoked by uid 111); 27 Oct 2026 17:38:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2026 13:38:24 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Oct 2026 13:38:24 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 5/8] t: run clar unit tests through test-lib.sh
Message-ID: <20261027173824.GE136740@coredump.intra.peff.net>
References: <20261027173205.GA97799@coredump.intra.peff.net>
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
In-Reply-To: <20261027173205.GA97799@coredump.intra.peff.net>

We run the clar unit-test binary directly, without going through
test-lib.sh. This means it misses out on the setup done by the shell
tests, and is inconsistent with the rest of the test suite.

I've hit two specific cases in practice. One is that we accept but
ignore --verbose-log. This means that if unit-tests fail in CI (which
runs the tests under prove, eating their stdout), we never get to see
the failing test output at all!

Another is that test-lib.sh sets sanitizer options like LSAN_OPTIONS.
You can see the difference by creating an intentional leak like this:

  diff --git a/t/unit-tests/u-strbuf.c b/t/unit-tests/u-strbuf.c
  index caa5d78aa3..4d252902ed 100644
  --- a/t/unit-tests/u-strbuf.c
  +++ b/t/unit-tests/u-strbuf.c
  @@ -84,6 +84,8 @@ static void t_addstr(struct strbuf *buf, const void *data)
   	size_t orig_alloc = buf->alloc;
   	size_t orig_len = buf->len;

  +	write(2, strdup("foo"), 3);
  +
   	assert_sane_strbuf(buf);
   	strbuf_addstr(buf, text);
   	assert_sane_strbuf(buf);

Without fast_unwind_on_malloc=0, you get a fairly useless report. With
test-lib.sh's settings, we get the full stack trace.

Obviously we could port these features into the unit-test code. But by
wrapping them in a regular test script we get that for free, plus it
will let us get rid of some extra complexities in our prove invocations
(in subsequent patches).

We do have to forward any relevant options to the unit-test binary. We
should do that here in t0011 and not as a central test-lib.sh feature,
because the set of handled options may differ between external programs
(if we ever even get a second one). Right now we support --immediate and
nothing else. In theory we should be able to handle --run, but the
syntax is a bit different between the two systems. This is no worse than
the existing behavior, though, since run-test.sh only passes
GIT_TEST_OPTS to shell tests, not to the unit-test binary.

Likewise we do not support --write-junit-xml; the unit-tests will run
but the results won't be present in the XML output. It would be possible
to support this with some work, but for now we are not making anything
worse (the unit-tests are currently run separately and do not even
support the option).

One note on the implementation: we have to inform meson of the
dependency. Without that, running "meson test t0011-unit-tests" would
fail (but "meson compile" first would be OK, because it builds the unit
tests). The make system doesn't have the same problem, because it just
depends on "all" before testing (the meson equivalent would be depending
on "compile", but it is more fine-grained).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/meson.build         |  3 +++
 t/t0011-unit-tests.sh | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100755 t/t0011-unit-tests.sh

diff --git a/t/meson.build b/t/meson.build
index 11b3752f00..fc628ad2d1 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -76,6 +76,8 @@ clar_unit_tests = executable('unit-tests',
 )
 test('unit-tests', clar_unit_tests, kwargs: test_kwargs)
 
+test_dependencies += clar_unit_tests
+
 subdir('helper')
 
 integration_tests = [
@@ -90,6 +92,7 @@ integration_tests = [
   't0008-ignores.sh',
   't0009-git-dir-validation.sh',
   't0010-racy-git.sh',
+  't0011-unit-tests.sh',
   't0012-help.sh',
   't0013-sha1dc.sh',
   't0014-alias.sh',
diff --git a/t/t0011-unit-tests.sh b/t/t0011-unit-tests.sh
new file mode 100755
index 0000000000..ac3d7ccda2
--- /dev/null
+++ b/t/t0011-unit-tests.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+test_description='run clar unit tests'
+test_external=t
+. ./test-lib.sh
+
+# We store the binary in different locations for make vs meson. Yuck.
+if test -d "$GIT_BUILD_DIR/t/unit-tests"
+then
+	UNIT_TESTS="$GIT_BUILD_DIR/t/unit-tests/bin/unit-tests"
+else
+	UNIT_TESTS="$GIT_BUILD_DIR/t/unit-tests"
+fi
+
+# Pass along any options that are meaningful to the unit-test binary here.
+"$UNIT_TESTS" \
+	${immediate:+-i} \
+	|| error "unit-test binary failed"
+
+test_done
-- 
2.56.0.559.g7c1a1d8168

