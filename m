Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618284;
	b=AA+abvCddVuf3OEm4PkQmtLJK79EmfUFriApzQIZqwoY3xzj7ho1ncY/uTKG1NfYoVSb
	 IGpsNbRjI0EoUFeqoTQQTq8x39Z3U+r/abGQAh6nj36DWQz7Te3pQeD67KXY9M4BRiBjQ
	 JMx33l97DDYbH0VJw+r2hkEi/29uW59nZQmANnCfsgsAr1Yg1fuoAgfTQbHyP5S4a2HaP
	 EPnyYUTXYLlBJw6zNr1/l1jXK1HIiYuGmM2gEImDRlkz1T89nnzkFc0gA8oO7Me/5fCSe
	 7xauzJjQh8hhbjt3n6oJCEAtdPxA/xW5JpKI9bfWh/123d0ryWRCvG4tLQDfYiUiUhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618284;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=o5eMLtvjpzTqt8qgavVX9kvGV/DSDZ0rR8Tm7cuaj1s=;
	b=caqWmfi3pDNGhxfsAdBbGpzIzbAAqmZtBBRVJtt373uyFqxKmyzBJWG1zOdk4LLa4fmv
	 q9WzhjCwZbZE9dXHXx6aRmm+8MXvfDT8Me7XmEidSvA/RAMCu9Ahz4gZw+6CJlci/eqoY
	 vnhi9r02e/Yj6Q5/s0gNtFurYJ6p/CrxDb8FKzEsSZXpFi/f/vxRezeJdYx7TfUzt/Cib
	 sZ5rtH4EqvICgTo7ledCYwUP+6RnAsq3eGy4jSHxaq3IK5PhodhxryKpPNyK+yg3nc3p1
	 AW4FEmaSBSpSttuqzbGSxgjZ4zeiB/qxn1KYK/toNAcIZxdUrwPkrb7UXPwUKCOWxHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="j1lPoAO/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jyD9Pi5R;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944E606A32F
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8944E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=j1lPoAO/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jyD9Pi5R
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DEF441D00229
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:18:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 06:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618282;
	 x=1793704682; bh=o5eMLtvjpzTqt8qgavVX9kvGV/DSDZ0rR8Tm7cuaj1s=; b=
	j1lPoAO/UvfO/bSKCH8LT7CAAkPKbEEJ5K76+C1Hs/10q/Frw1MoA7w40aFNCHaY
	wo3LfKAwXHoa20u4L5xD74B6LL853w2p/7sl9rZaHTluDbExI29OB0BQwt8rGd3g
	UQiwxLMu4VXjkq76j5oTYuBoWHQF9jI8dAtr1sdrLhpMhPhyvNw1DD9ZgRBWfhUO
	N3VkrF80TmcoGgifD+yYTGdnUtMJnOsuScIV6rwrjAu+/wPuA/hjcy/doiQMUd+a
	aURVIiYUak7A1cZ82c3PFaKJQsL8RCeS/mO0lZO+9a6fMilFjJcqnsA/DT1+PS9U
	Dp4yDfUE3+4X8VmvemVV1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618282; x=
	1793704682; bh=o5eMLtvjpzTqt8qgavVX9kvGV/DSDZ0rR8Tm7cuaj1s=; b=j
	yD9Pi5RwLIRx3fS+tv+eRk3Ea67ZkCKnKD6L3Xfqjp0MwkHIDmQPctjAUoN5fy26
	4lafHkzX5dk643jijlaj96eY9qGqkoo29vkgZUfbA+ev8AuzW0k38iAPRiT9HJVK
	o1s6hRcWxnv4HniJT5Kr1J56jabJGj/Amq7i5IkcTT4aN6I4qN2p+4j9N4P5igus
	zXrMiP/srf3kDt1K0VA64fkEZCncPV2IK5+AJHWiEnRNP2A+QZTWXEJE3A7mQbAM
	gg2fFTt36QCWsJavR2X4iHbuSa5zwUW+a5vDA50M8uK+Y6J8vADCn1DDpFmohsj9
	fRLzG4c1kwbqY7+Af1QiQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618282; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nHClVR7wccs1CnYvPAVy7IQbhcZykZRD2ArRruZ14LoyMAJ
	3GWWxpjKsf1I4oxuGN7KxYpnqBRMJZFNHc3WkpEDs0o0vKUFnnOrXktcI1x5ZiLS
	WCYfzdYQk9d+Fc4qBM0psSlG3/M9IU88BDZqNRMCd2wq+HdcMtnArSREQLkAIoTA
	3e2AXisWgmhWGJvYSDpvs9ni6Ep7uCzbp36EzTwGUIlVh3ITnaWtrWM9jAHXPcKI
	OEpDbBUWLYx/VFFxDujvReawvtipDYBDv3fb4AfNQZy0ZNQ1AgeBhLjsHaCwdXQ8
	x+/Zclv5VCFlmFIi9hjq5rR67kUx0qiXklPYlAw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Rc5m0MWNVIG5LjNQruoKi+m4RCvm7vVkJLLM0sShhbI=:aKgw1V9KVQOJFMKql16uEFZaWDCfPehsj7zcqJwqNyQ=;
X-ME-Sender: <xms:aXHoakYRp65kxHyHvlkRcQSk5ihQeIkX8I3fGns6oCzKJmj_7JHcKw>
    <xme:aXHoaouuHPs4yYAMe_uarEY9k7NbEFfI203H_K88kOsrpq1XS2JYVDcFB9lpvHj3X
    miinhDUp0ecM2rD0gBjYZ7hXe09qRw0D3eaqLCkIKWyngEaLwDPh7E>
X-ME-Received: <xmr:aXHoamMCoYhiFjqqJM2vGSZqjDxBSoKCcUA5uHtvJlyP89-8fbA90vT0dKWFkrSHY-4oXQ>
X-ME-Proxy-Cause: dmFkZTFYNdbPZ+EwG+SbhpDIqr6BLQ0Mn8d99oCbVfY2u4yGnvOncByysPxzXZCVhTCz7a
    UB4nFiQrzgFG0Tqno2XI2b3dQghSp9B9AkCkvhc894LNI0295VB0zWg96Nio0pW+c/rwoa
    A+vVlAccCUnS0ml4E0OszzJhFaVeaoMS/lLHebpaDJqRpvWqbV1cw+guBp/41uOZBzlb1T
    eiPKGt3Ya0jqM+iY+mWuJp4Y0FeUBnLSp8uiO/K9sz8TjBHEK0deyry6IvoQeBAD4Lvn4l
    LBBHGeBAorQldJ1E8LA36woEVZnhAzdXcrrVA/uvm2/XzsHa04YxEgI9r1AEv6CCUkpJge
    VAheOKJR0uPhDvPwNLd1aG1CF/ABRyzm3r9KJZGuhbvprih1GZuTx8R+xmwufolYrIx0z0
    iCMH+awuzCxX79fb9Snl+ajninWGnM9nEB0FlSHJgCqwcQrLEr8ZQaBUhVAVpPCNO8VdZU
    YxytaneJxU6FHdLbERf4Y63g/xZq7t7kDntRIaQm0Yt4Wq9OwhE7AtBsMbhDj8p72hQk/6
    jXMPXdZ5U5L9oFtgJqdUsTu/dzdiy9t2YBEp9/0FYgKTIIAMH43YZ3TMgNZkThI69SY54h
    opd0mgNBS1XWQW6Keg2Af1/KQkjqudw2DpAy51fXzVUz4LX4ocAsDl+i3r/w
X-ME-Proxy: <xmx:aXHoav4UJ3Fsr7vQ2LafUrPaKUDHqHlyQ4MPftnBX2MDutOW2oReTg>
    <xmx:aXHoasSasPaTo2yAXqU_C5hZRzzHzpG2Ka8mtMfuMAjAsArj9UPeDQ>
    <xmx:aXHoasABvFeUwErfYQk7BUjceP9LzvJ9l6DZfKKikQj5GUNVIXhxVA>
    <xmx:aXHoasEa40yS8HCepbz379XtVj3WL9UZJe4dOCflP2DvhqATTeJA6g>
    <xmx:anHoaoGpOJ-ouRY0xgMPn1_hxFM_6bhogfz1jODMvf-U4HTRvb2qMcj->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 06:18:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6f806fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 11:17:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Nov 2026 12:17:49 +0100
Subject: [PATCH v2 1/7] ci: consolidate setup of test environment
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
Message-Id: <20261102-b4-pks-ci-test-vars-consolidation-v2-1-a5485c437c62@pks.im>
References: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
In-Reply-To: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

The setup of our test environment is split up across "ci/lib.sh" and
"ci/run-build-and-tests.sh". It is not exactly obvious why that split
even exists, and because of the split you have to know about both of the
locations to be able to figure out the specific environment that applies
to a specific job.

Consolidate the setup into "ci/lib.sh". Note that this is a pure move
for now that results in some awkward duplication. This duplication will
be cleaned up in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh                 | 43 +++++++++++++++++++++++++++++++++++++++++++
 ci/run-build-and-tests.sh | 44 --------------------------------------------
 2 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2e63d652543..d0bd8113d35 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -394,7 +394,50 @@ osx-meson)
 	;;
 esac
 
+case "$jobname" in
+linux-musl-meson)
+	MESONFLAGS="$MESONFLAGS -Drust=disabled"
+	export GIT_TEST_USE_SET_E=yes
+	;;
+almalinux-*|debian-*|fedora-*|linux-*)
+	export GIT_TEST_USE_SET_E=yes
+	;;
+esac
+
+case "$jobname" in
+fedora-breaking-changes-meson|linux-breaking-changes)
+	export WITH_BREAKING_CHANGES=YesPlease
+	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
+	;;
+linux-feature-testbed)
+	export OPENSSL_SHA1_UNSAFE=YesPlease
+	export GIT_TEST_SPLIT_INDEX=yes
+	export GIT_TEST_FULL_IN_PACK_ARRAY=true
+	export GIT_TEST_OE_SIZE=10
+	export GIT_TEST_OE_DELTA_SIZE=5
+	export GIT_TEST_COMMIT_GRAPH=1
+	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
+	export GIT_TEST_MULTI_PACK_INDEX=1
+	export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
+	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+	export GIT_TEST_NO_WRITE_REV_INDEX=1
+	export GIT_TEST_CHECKOUT_WORKERS=2
+	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
+	;;
+linux-sha256)
+	export GIT_TEST_DEFAULT_HASH=sha256
+	;;
+linux-reftable-sha256)
+	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
+	export GIT_TEST_DEFAULT_HASH=sha256
+	;;
+linux-reftable-leaks|osx-reftable)
+	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
+	;;
+esac
+
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
+export TEST_CONTRIB_TOO=yes
 
 end_group "CI setup via $(basename $0)"
 set -x
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 68b91e31439..b81d654b561 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,50 +5,6 @@
 
 . ${0%/*}/lib.sh
 
-export TEST_CONTRIB_TOO=yes
-
-case "$jobname" in
-linux-musl-meson)
-	MESONFLAGS="$MESONFLAGS -Drust=disabled"
-	export GIT_TEST_USE_SET_E=yes
-	;;
-almalinux-*|debian-*|fedora-*|linux-*)
-	export GIT_TEST_USE_SET_E=yes
-	;;
-esac
-
-case "$jobname" in
-fedora-breaking-changes-meson|linux-breaking-changes)
-	export WITH_BREAKING_CHANGES=YesPlease
-	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
-	;;
-linux-feature-testbed)
-	export OPENSSL_SHA1_UNSAFE=YesPlease
-	export GIT_TEST_SPLIT_INDEX=yes
-	export GIT_TEST_FULL_IN_PACK_ARRAY=true
-	export GIT_TEST_OE_SIZE=10
-	export GIT_TEST_OE_DELTA_SIZE=5
-	export GIT_TEST_COMMIT_GRAPH=1
-	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
-	export GIT_TEST_MULTI_PACK_INDEX=1
-	export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
-	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
-	export GIT_TEST_NO_WRITE_REV_INDEX=1
-	export GIT_TEST_CHECKOUT_WORKERS=2
-	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
-	;;
-linux-sha256)
-	export GIT_TEST_DEFAULT_HASH=sha256
-	;;
-linux-reftable-sha256)
-	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
-	export GIT_TEST_DEFAULT_HASH=sha256
-	;;
-linux-reftable-leaks|osx-reftable)
-	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
-	;;
-esac
-
 case "$jobname" in
 *-meson)
 	group "Configure" meson setup build . \

-- 
2.56.0.500.g5d06dc02cd.dirty

