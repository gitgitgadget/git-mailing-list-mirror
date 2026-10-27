Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122529;
	b=dG0RR0eutOR3QV1QFUHIBbi/uH2bMhLvHl2SdY8Pg/Nusk0SR8KVzd9xNNvssFjN+cmv
	 yy+ML5FVdMg3IPwisPgICNiJILybwRTRGZI06oOj5bRK/ZhIHhfgjDUIkp2qBZLCxPcbP
	 C4CWoB/A1mVJTtYx/6BdnpAb8/SB4bbdRgx9bw57CN70ZDWZWbsDXDi/rhgtmgN7OAnDQ
	 2s/EHPis9iCnE/vG5QbY+aS2LhO8vOtmRSMqSj8KeoRqWZxm/KOeE67z/wlaZOev0RGaq
	 Hk+sgFtdktkNeWp9IM70H3ImpSCqLa1p3G+oDefYSfnT11mzd2B4RWpS53Y0/mWrXhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122529;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=QT2gFdecBPHXDffFyk3ESumjIAbk3m7Z9kjrzZKQUq0=;
	b=0c3Cvl76LvC5eQdolTruVaOx+2gmQDXaK6NHQV8LY8T3lN2nFIt/yYKYpcT6xTt0idcJ
	 0e3BbsuMn2AfHi4x3Obf6CtOY9+sKcFpwX44rhS9Hcb+npvAECLZIanZR8ElwWEzbooND
	 adQNoR986rb06J37HGgYJN96HimaBvtVYHNqQLoUVaGCKkHcQ+hmvqcJCsls1BZ8m+Jv1
	 Wk5CMbCX9W2/RBMm6159F848W6N/LJL9cZONH2L8dA0aTVy3WS6NX6KPW/AcxnkHbSidS
	 cICkI5s8U2AYl03Ss5xY62m9IUoWs0SzYVDjSlMenVef+OE6nwq3NDQKcdv4pKIp9RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=U1RXUPcp;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0706B606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0706B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=U1RXUPcp
Received: (qmail 38345 invoked by uid 106); 27 Oct 2026 17:35:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Pigm2YcOgfZn6iyPT40sG6Je1e4c7zRSJ9ts9xF8EME=; b=U1RXUPcpo7uln6kWqp8cy4DafwwClelXk7ZfIAjD8rnfb3iECpACY1IRq7B4TS+5dfk5IhPrz0h+qHIq5mCU0lDB74Bfpi6O8A2pYMn6JfGT9wPHWrz9HSSSBG4+LoiBJd76M7WHEHR1QlzEwbv/zJqNiwiiANvXIJSSLxRHx9ppkSXAph+BiAGlaL8xNZPyp0n+CJRSB+KL77Rlfq6dQvlaYcSjciurS21O7NxsqRByqi/1m+8fSLfx4ORo0Vp9zWIDPDFV0oS3LTbaS/z6CjWjd0/U4uaTRSJoI/Z99txkGB/Hwq8ymAD+MPmXAxqFdbc0nKuRRQmcRfEVmC0thA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2026 17:35:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 275968 invoked by uid 111); 27 Oct 2026 17:35:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2026 13:35:26 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Oct 2026 13:35:25 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 3/8] test-lib: stop inventing a JUnit testcase for empty
 suites
Message-ID: <20261027173525.GC136740@coredump.intra.peff.net>
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

If a script finishes without reporting any test cases, the JUnit output
code tries to call write_junit_xml_testcase(). But that function went
away in 78d5e4cfb4 (tests: refactor --write-junit-xml code, 2022-05-21),
so we get a shell error instead. A script which sets skip_all and calls
test_done without running any tests is enough to trigger this. For
example, on Linux:

  $ ./t0051-windows-named-pipe.sh --write-junit-xml
  ./t0051-windows-named-pipe.sh: 97: write_junit_xml_testcase: not found
  1..0 # SKIP skipping Windows-specific tests

This is mostly an annoyance, but it gets even worse with the "set -e"
detector:

  $ GIT_TEST_USE_SET_E=1 ./t0051-windows-named-pipe.sh --write-junit-xml
  ./t0051-windows-named-pipe.sh: 97: write_junit_xml_testcase: not found
  FATAL: Unexpected exit with code 127

Before the refactoring in that commit, the fallback wrote a successful
testcase named "all tests skipped". We could resurrect that, but I'm not
sure it actually makes sense. We can just leave the suite empty if we
don't have any testcases to report.

This also prepares us for scripts which delegate TAP output to an
external program. We can't report those as JUnit XML (we don't know what
was in the TAP!), but it does prevent us from inventing fake results or
complaining about the missing function.

Signed-off-by: Jeff King <peff@peff.net>
---
I do propose dropping the JUnit support entirely in the final patch, but
this is the minimum needed to unblock the rest of the series in the
meantime (in case we do want to keep it).

 t/test-lib-junit.sh | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/t/test-lib-junit.sh b/t/test-lib-junit.sh
index f4994dd9d3..03a7360198 100644
--- a/t/test-lib-junit.sh
+++ b/t/test-lib-junit.sh
@@ -86,17 +86,11 @@ finalize_test_case_output () {
 		date getnanos $junit_start)\""
 	write_junit_xml "$(printf '%s\n' \
 		"    <testcase $junit_attrs>" "$@" "    </testcase>")"
-	junit_have_testcase=t
 }
 
 finalize_test_output () {
 	if test -n "$junit_xml_path"
 	then
-		test -n "$junit_have_testcase" || {
-			junit_start=$(test-tool date getnanos)
-			write_junit_xml_testcase "all tests skipped"
-		}
-
 		# adjust the overall time
 		junit_time=$(test-tool date getnanos $junit_suite_start)
 		sed -e "s/\(<testsuite.*\) time=\"[^\"]*\"/\1/" \
@@ -114,7 +108,6 @@ write_junit_xml () {
 	case "$1" in
 	--truncate)
 		>"$junit_xml_path"
-		junit_have_testcase=
 		shift
 		;;
 	esac
-- 
2.56.0.559.g7c1a1d8168

