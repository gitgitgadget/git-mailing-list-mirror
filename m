Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089134;
	b=qEcqVJBfwi4R23fwD3vthivCff2uhmx0jvAjdcJb9+CoodLJrKVTIcx7gUOkmif4Pb/I
	 Y20K7XWKif1vQ0wrNpDWRlg4xMVI4bhN3kHTni4tAUCkG7mAoLGRk/C1PFQ6RLxgRL9eu
	 d1DzpH3Arghnrqi7rfmmyIh68GYk/3cOF+Xp74V0B05uQ2wwMgzohG9l4yg1cMQAC4/cZ
	 Fmbe0QYdH8wroEQbCAkYHIWtbLWh0LwA7HYoMT9H6XhNfdlluE8gX6p1wqrNEhaFKusYO
	 uyZPA5l9jJB/Vo4sPn62c/dfDmd4RimxNOK2ic+9azIKJpSpAXFmyjoYUyyCIMzD6hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089134;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=t0TxOTnNohk4hiko+/X9jvdD1s/s+HHcpJmfRN69lFQ=;
	b=jcCCj4RG5p3OjjgutRqjNESnXKXY414hFGjZY5XuRJ1lUhmPFzkagPq6qOk2B3gei5zc
	 fElBYEeqau5V0hpX8tTq5fRktfQ+dFQY0EWaUl1tjOde3EGA6MPr2jj8069j7025Q3olT
	 o49w1S7gnInYuXLtgoH3YWUy6leO1zPzUp9NDIYbevvi7k3muLX2elKUvdRDjwCJ5ineU
	 T7oemyPWlwGEdLFxFBgfXLSuc/vMwLNFiDjSWQAH1JXvOfPGX1feNKMWEC8wBFPBBXWkg
	 snpV3BqdvjtWn256adjrvtbNA5PmzxiXJ9MilGK5zGSQ759qyncoXLcuAH/K1rn4edg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ap2tfod2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QyjDUIfd;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64D606A32A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D64D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ap2tfod2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QyjDUIfd
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A44437A0101
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:18:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 27 Oct 2026 04:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793089133;
	 x=1793175533; bh=t0TxOTnNohk4hiko+/X9jvdD1s/s+HHcpJmfRN69lFQ=; b=
	ap2tfod2IPOj5DbRhXlBZtUw0KQR6aiYjPSOC6N25IqRhZDYlo+vKuOJgc25gdfY
	8fJw1/LYsyPJoQYba+ceEQk8Up4egZb1TWlPVpC1D+CS6N2Q1gsut7ayNXOmccJU
	k9PBAWatfL/m127JTYAx7Fm4ZE5QbiJjd1txP37yw6edjnHGPDpNU95V+KNAM2B6
	j3PEdVadSebqXhfAooR83e/WYLsjybf4Hcu9zyFoN1eJy4IS0rnT5RGRGfwSj4cH
	hcviU5qcogTyMiTRJ9PmIfKHvB6W4LrH2FZMzCwiu/SV6jkY4w/IsA6DpnGm+1xr
	Az56Dvri0+//hUhpoZke1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793089133; x=
	1793175533; bh=t0TxOTnNohk4hiko+/X9jvdD1s/s+HHcpJmfRN69lFQ=; b=Q
	yjDUIfd6xzsGepViwW83sKJC3ElRJcXgh38ZcRzEOdUQhwLa5mfn7gj7PazGKo9X
	4ppVNtqOsZav3dj25PummG/1uWxMmVFYc1sAnkKDKBfGHOcdNxmts47GmZ4Kcs9o
	WKnM9Wgf6fkmX1XI9bn03rlSeTQhzCzU9qXvXZ7fw88OtG3bc+HShi3Z+L1783kp
	boFbUGccvQQ4mgh4mKEf4IYX5YNVz9W2Z/DYTC604+ow9XxaHJeA/sUudG7EKE9o
	bx0vnvKqeIqlf/O2g/Yd4gSikGqKw1bkIZRgFoSqpCqOvaDrwg4MUQiZT0rkXpBE
	HDaGSxsusrZfSrny2efuw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793089133; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AZ+IGpTnjuWXVuZkA9gbB3/xLQ6tF+M/w0GkqeXH9s40Wo7
	rjuVFPhD799TrVUvpJO8DspkHbR8ZQGtX/j/wqEsPZKv8MXKfwndvHDaKdj4ngBH
	2DhebU02TR/i/hpwdU+N1rQrG4/Z20eZ6oo/OP4+eUlwgeC0zLPkE89JtWwumuOv
	uiqwfIUwRwMi1QtZjPEcW7XsKtAmFbN2tnvYcLzgnSUdvtlRw49zZZv9K4Hq7Dwl
	7Rf1kDpS+X5uQQIbiWxVQvZJuITi0bsumsax+3BjkiXgqbBbcOjBDtqYs2l6X14y
	FenMDoa/RcjPErXfUvmoALc8UaJ9fm1pPZBSGJg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IWHJmCvu/labgyqsezhAyPGWFyTQZtZj4DVojok1rcE=:ZuMtmNZB9AxVEu0iyo28+fTCU+hADcgZ5iK4qAz7a88=;
X-ME-Sender: <xms:bV7gahI1t6tKQWa8Xa775HAj3PXTcf_gcX_jl66JZ3kYmEPMj-7nuA>
    <xme:bV7ganvSMa2Bm0mHdP02uz9p3ntQ1HVyiJlX8Vm8oJybgk3KBAb_6S7V2nlEC5kyE
    K-6U2TenNqpijHlcT4w_4aqpw4-bRGPYZDSgyj4q-Rvn6ky0RMofv8>
X-ME-Received: <xmr:bV7gamQu1Q1dX_vick8Kr9AE1D5AGk5_XVwq0lM8KzWS6G31mht--Q>
X-ME-Proxy-Cause: dmFkZTGW4gIF+OOltoMUDFuDCLa8JR/1Zq92OR6twLpCr7FBh1VqjIbmn1u+7QM0VHFtEE
    28zuboRD3XJUQTa1w/qEydFSUd7bjdniYE6Flw1rCS0lGrlAxGs48mDuM+nP4jrMGgZuQW
    r0bzEzHV5KYokltYYeW/GyP40XNXKJDVfns/KOCTPKKLiaiWS4fZeiwhOvKD70d+2O+x3x
    8y7g8zimAsnlYuGuNAAIJQPMGVIdeKH8YAnzgdfTX1GW9jzVauJvSv0OBSUZTuW8LxQD6n
    SneCzaXOtGPo3bbI+fN7fYXTS0d+FAr2f42fua1fOrO+vdbawppR4ejEtf+3v2381tRkaY
    tSobcIC773k1h+ZEVAJEwEBcIVggPzlkEVJ7AkDruduwKlcoKxh/5wOZnkTb2ivxe2gtL1
    VmpVBoNuiClHT9s4R1UCpGJnpn/YdDc1ETiP5nIbD+oh8wJz4Dao/bS9VPdMeDUxxOrcmf
    cpKgpfyi56xJxviMghBUNhwVFaYF8t42/ULt1o21sIaZvI20YxbBi6pM/9dZNkp57NThE+
    PnnnptisQ/rWlZJD6qUzHfMRUQ5zoJpCyq0WQvLXAxjsd4DVKhpiibLjI2fdYpeS2SLhyH
    RgutqMa5ALMDytX7oQNWxLe31uY6Dc3EdM+LOQAGuHKS2JeIC4vH9eNG0waw
X-ME-Proxy: <xmx:bV7galPO45TQDozqo0q3XohzJtbgzGhVEH0JZFa-Sx2XVjI1DkcDeg>
    <xmx:bV7gaja5d40NpW3Ts8dUmpEZFHIBW7i3EkXkQlxuqtBdVESVb2rYnA>
    <xmx:bV7ganxzE-aiL6IIcfgKim6rsDxQjyrIu0uFid4CAY3r0tKHaO_Vaw>
    <xmx:bV7gamJ6hokrZLi7OReWeKxezxuj32g5AAgqI97-bQLx733d7tybhw>
    <xmx:bV7gaoZ9BH93lHwwfCusJ4aFvNxc-d4vJ4BoTkS_3eFTiNNciXh4SyCN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 04:18:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dfa50e89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 08:18:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 09:18:28 +0100
Subject: [PATCH 8/8] t/test-lib: make feature-testbed job more accessible
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-b4-pks-ci-test-vars-consolidation-v1-8-f28edf79bd6c@pks.im>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
In-Reply-To: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

Our "feature-testbed" job sets up a bunch of GIT_TEST environment
variables and then executes our tests. This is mostly intended as a
testbed for features that aren't default-enabled, but that may
eventually become so.

Due to the job being special it has a higher potential of failing even
though a local test run succeeds. But running these tests locally with
the same environment is somewhat painful, as the developer has to
manually set all of these environment variables.

Introduce a new "--feature-testbed" toggle for our test suite that, when
set, sets up exactly these environment variables. Migrate our CI to use
this toggle so that we have a single source of truth, only.

Note that we only set these GIT_TEST variables in the case where they
haven't already been configured. This serves two purposes:

  - The user can continue to manually override a subset of those
    variables, if they desire.

  - Test scripts typically source "t/test-lib.sh" after they already
    overrode GIT_TEST variables, and we don't want to discard that.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh                | 12 +-----------
 t/README                 |  5 +++++
 t/test-lib.sh            | 21 +++++++++++++++++++++
 t/unit-tests/unit-test.c |  1 +
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index fbb13ca6c6a..c3a5ec48f22 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -398,17 +398,7 @@ linux32)
 	;;
 linux-feature-testbed)
 	export OPENSSL_SHA1_UNSAFE=YesPlease
-	export GIT_TEST_SPLIT_INDEX=yes
-	export GIT_TEST_FULL_IN_PACK_ARRAY=true
-	export GIT_TEST_OE_SIZE=10
-	export GIT_TEST_OE_DELTA_SIZE=5
-	export GIT_TEST_COMMIT_GRAPH=1
-	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
-	export GIT_TEST_MULTI_PACK_INDEX=1
-	export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
-	export GIT_TEST_NO_WRITE_REV_INDEX=1
-	export GIT_TEST_CHECKOUT_WORKERS=2
-	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
+	GIT_TEST_OPTS="$GIT_TEST_OPTS --feature-testbed"
 	;;
 linux-meson)
 	MESONFLAGS="$MESONFLAGS -Dcredential_helpers=libsecret,netrc"
diff --git a/t/README b/t/README
index fd7e8504b51..211bf78aed9 100644
--- a/t/README
+++ b/t/README
@@ -119,6 +119,11 @@ appropriately before running "make". Short options can be bundled, i.e.
 	This causes additional long-running tests to be run (where
 	available), for more exhaustive testing.
 
+--feature-testbed::
+	This causes tests to run with several `GIT_TEST` environment
+	variables set. The intent is to test Git with optional features
+	and non-default configuration.
+
 -r::
 --run=<test-selector>::
 	Run only the subset of tests indicated by
diff --git a/t/test-lib.sh b/t/test-lib.sh
index de566309861..8863bcac930 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -202,6 +202,14 @@ finalize_test_case_output () { :; }
 finalize_test_leak_output () { :; }
 finalize_test_output () { :; }
 
+set_default_env () {
+	if eval "test -z \"\${$1+set}\""
+	then
+		eval "$1=\$2"
+	fi
+	export "$1"
+}
+
 parse_option () {
 	local opt="$1"
 
@@ -212,6 +220,19 @@ parse_option () {
 		immediate=t ;;
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
 		GIT_TEST_LONG=true; export GIT_TEST_LONG ;;
+	--feature-testbed)
+		set_default_env GIT_TEST_SPLIT_INDEX yes
+		set_default_env GIT_TEST_FULL_IN_PACK_ARRAY true
+		set_default_env GIT_TEST_OE_SIZE 10
+		set_default_env GIT_TEST_OE_DELTA_SIZE 5
+		set_default_env GIT_TEST_COMMIT_GRAPH 1
+		set_default_env GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS 1
+		set_default_env GIT_TEST_MULTI_PACK_INDEX 1
+		set_default_env GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL 1
+		set_default_env GIT_TEST_NO_WRITE_REV_INDEX 1
+		set_default_env GIT_TEST_CHECKOUT_WORKERS 2
+		set_default_env GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL 1
+		;;
 	-r)
 		mark_option_requires_arg "$opt" run_list
 		;;
diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index 752fb38fb32..f4898353045 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -27,6 +27,7 @@ int cmd_main(int argc, const char **argv)
 		 * options understood by integration tests.
 		 */
 		OPT_NOOP_NOARG('d', "debug"),
+		OPT_NOOP_NOARG(0, "feature-testbed"),
 		OPT_NOOP_NOARG(0, "github-workflow-markup"),
 		OPT_NOOP_NOARG(0, "no-bin-wrappers"),
 		OPT_NOOP_ARG(0, "no-chain-lint"),

-- 
2.56.0.341.g393f52fd96.dirty

