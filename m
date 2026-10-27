Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122825;
	b=KHsLpDr4JZ2XgRG/rp/1e6iTx2yjncRZ+Gera1AmjB/ofomC/L+Ps/GF3sTGs/lh3cxp
	 b/RyRRi6aLqtvtKZfQZ1Qcb+XBf7ODYPRrJoXwx8dS4oQNeaEKpmC2rB7ovhBiJ62E55t
	 qg9eLE6YOFq1fyiojHOuJ66leLkb4Rgm02QZILJ8pApaw6IFH6If/BbkA8t54zc9RR+1Q
	 8h0oLzfgFVPo14p1vdmF/BTP5ZAQbvy9L5QcVTUM/IVC07CSzOJXR3jTIkQ7tRoOheb/M
	 WmzAB+9whWWPXdoK3yN/a/mz291vpFnYp+nGZCVfLQEqPJiw2yCFlUstK9q3SOGBjeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122825;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=FkW8iNFhnKqWK/hK8hVrxNolMel/dkasvzrHxQNZGnM=;
	b=lE8RM5wdRxgqY0wdcQ0uk8qjRlKPSknxUn7fiM0LRO7kzQdR1g4jJGppwLnbwsuaJZ6S
	 SVw7UM6eh/+71Tqh58biCLqp89KAGg+5vbBL6a+z9IjXVk1e+Q1tNF1ABb4BysBe/Krwr
	 Dw8DNU2VcNBsMGMhXg5z68VO/ZWMK9KFv7ENGPtnBS8Eu8FfX39iSUHEGdsENvrZp4lZ9
	 1wRplckmluKuHb/ZJagWQxD/2rA1C/ncIIrlXprMsgKsINQp1w3kph7Z2AaB4+spuGhSg
	 lSYj6xoiJCcUTnyWFSodf8XbHM4NNXhivPN3P/qZuYFNEQsZVbm9X8JhpbPfBdu+DDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=UCePmkbf;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E33606A323
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82E33606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=UCePmkbf
Received: (qmail 38410 invoked by uid 106); 27 Oct 2026 17:40:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4nmRtmrxskCZAFAHtHrM7tdbp88HNFWrQ0XhJYYkClo=; b=UCePmkbfV56rK6TAOR5Z6QCThJx5dtVzv5JM8ZZL69eUASCmVj5GbEiX9z6yWaNAOhwHU6BA5DAasvStKRNpiGL/gpZ3REnVzNysk6oxqeq3T6EyU/hZiAS8V3LhZY6KjmP9w9QGHggia2iBdXzxfqbLIOAxaiGX6roT1oibsYgkjzJOIAtZfGO0HAd1/02ZObwJutvkAC2hzmivSf+cQP2vdGkCfuK5YSQD5U/wnR8VuI//kWSVNkMwp4BV2RsnmI/X2Esz2OqrGjiKgt6oTSMLcRNtmv6w5OQM3xaTEX0jP2WbU5G7hrKg8adtgi21DgUAP0GnH7tb+ol1Fl33tw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2026 17:40:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 276040 invoked by uid 111); 27 Oct 2026 17:40:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2026 13:40:23 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Oct 2026 13:40:22 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 6/8] t: drop redundant unit-test invocations
Message-ID: <20261027174022.GF136740@coredump.intra.peff.net>
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

Now that t0011 runs the clar unit tests, running the binary separately
from the shell tests would execute them twice. Drop the separate Meson
test and the extra invocation in the first CI test slice, along with the
unit-tests-test-tool target it used. We can also drop UNIT_TESTS_NO_DIR,
which supplied the arguments for that target.

Likewise, stop passing the unit-test binaries to prove alongside the
shell tests. Since all of its inputs are now shell scripts, we can use
TEST_SHELL_PATH directly instead of run-test.sh, and pass GIT_TEST_OPTS
through prove's "::" separator. This leaves no users of run-test.sh, so
we can drop it, too.

You can still run the unit-tests directly if you want to. I've also left
"make unit-tests" intact, though I'm not sure if it is actually useful.

Signed-off-by: Jeff King <peff@peff.net>
---
 ci/run-test-slice.sh |  5 -----
 t/Makefile           | 12 ++----------
 t/meson.build        |  1 -
 t/run-test.sh        | 18 ------------------
 4 files changed, 2 insertions(+), 34 deletions(-)
 delete mode 100755 t/run-test.sh

diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index d0063efc42..fd66443626 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -10,9 +10,4 @@ TESTS=$(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh)
 group "Run tests" make --quiet -C t T="$(echo "$TESTS" | tr '\n' ' ')" ||
 handle_failed_tests
 
-# We only have one unit test at the moment, so run it in the first slice.
-if [ "$1" == "1" ] ; then
-	group "Run unit tests" make --quiet -C t unit-tests-test-tool
-fi
-
 check_unignored_build_artifacts
diff --git a/t/Makefile b/t/Makefile
index e3249879c4..1d2eca9ae4 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -54,7 +54,6 @@ UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
 UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
 UNIT_TEST_PROGRAMS += unit-tests/bin/unit-tests$(X)
 UNIT_TESTS = $(sort $(UNIT_TEST_PROGRAMS))
-UNIT_TESTS_NO_DIR = $(notdir $(UNIT_TESTS))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
@@ -79,7 +78,7 @@ failed:
 
 prove: pre-clean $(TEST_LINT)
 	@echo "*** prove (shell & unit tests) ***"
-	@$(CHAINLINTSUPPRESS) TEST_OPTIONS='$(GIT_TEST_OPTS)' TEST_SHELL_PATH='$(TEST_SHELL_PATH_SQ)' $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) $(T) $(UNIT_TESTS)
+	@$(CHAINLINTSUPPRESS) $(PROVE) --exec '$(TEST_SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
@@ -88,21 +87,14 @@ $(T):
 $(UNIT_TESTS):
 	@echo "*** $@ ***"; $@
 
-.PHONY: unit-tests unit-tests-raw unit-tests-prove unit-tests-test-tool
+.PHONY: unit-tests unit-tests-raw unit-tests-prove
 unit-tests: $(DEFAULT_UNIT_TEST_TARGET)
 
 unit-tests-raw: $(UNIT_TESTS)
 
 unit-tests-prove:
 	@echo "*** prove - unit tests ***"; $(PROVE) $(GIT_PROVE_OPTS) $(UNIT_TESTS)
 
-unit-tests-test-tool:
-	@echo "*** test-tool - unit tests **"
-	( \
-		cd unit-tests/bin && \
-		../../helper/test-tool$X run-command testsuite $(UNIT_TESTS_NO_DIR)\
-	)
-
 pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
diff --git a/t/meson.build b/t/meson.build
index fc628ad2d1..4dc47824f5 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -74,7 +74,6 @@ clar_unit_tests = executable('unit-tests',
   ),
   dependencies: [libgit_commonmain],
 )
-test('unit-tests', clar_unit_tests, kwargs: test_kwargs)
 
 test_dependencies += clar_unit_tests
 
diff --git a/t/run-test.sh b/t/run-test.sh
deleted file mode 100755
index 63328ac630..0000000000
--- a/t/run-test.sh
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-
-# A simple wrapper to run shell tests via TEST_SHELL_PATH,
-# or exec unit tests directly.
-
-case "$1" in
-*.sh)
-	if test -z "${TEST_SHELL_PATH}"
-	then
-		echo >&2 "ERROR: TEST_SHELL_PATH is empty or not set"
-		exit 1
-	fi
-	exec "${TEST_SHELL_PATH}" "$@" ${TEST_OPTIONS}
-	;;
-*)
-	exec "$@"
-	;;
-esac
-- 
2.56.0.559.g7c1a1d8168

