Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE21367F36
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806088; cv=none; b=hjrdaDFU0/5NK0j9lOCwDCg94Pk1/Nt/gGJle6ri2iXuW7OvxBHdQkl18Llwb3pgj3/4x6GRMs7WqCv7+hNTdEznrA1qK9/DX90HPW2rc7YisdAfTBBO50Vvi0Oxj7vemPt/08IQEv5Jh+rsPH58bOYeMekC3ZX0slyjdjXoC8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806088; c=relaxed/simple;
	bh=BXIOSWL9iApWst+fSVO9XqlRKi2atgsmAl1qmODhcMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3YcCeXwUwqW9TGjkfT5WxHUsuKqMWKRfqpf3DTEMPYOk4iWb3tMYxReXCE+NDsXJKLv4+AYgqJEKo/GmU8z5kBvqJcJELTu3fjnZwmwlPAo60wPTe5AvjI3nmjdEfFoqciJeaagknTCEiHy8JoX27MXx54US6tA4B8s5oU1gKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LBec2cv8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=txnngfTq; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LBec2cv8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="txnngfTq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 996BA7A01BC;
	Wed, 11 Feb 2026 05:34:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 11 Feb 2026 05:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770806086;
	 x=1770892486; bh=J0R4H45VT476W2JwlE3vz+YNlX6C/EXo0OOhTG73/wI=; b=
	LBec2cv8JiPOthw8QDZHp1Yf7MPJe4Ikr6T46UwKiPSL+xu1niA1LpTJ6H3goEIL
	TVYpYci5KuUNdYYkd9aebgVrxMYxRy7pZi/ScAwQ4lO3FqUc2TtpKgWA1jSYdxLt
	5miAATfIeO1AVgBL1NXj/wHjgWLk5TOOerkTHjauLcAuKpKOhvfnnrwpRj2GHCAV
	hpybgtZfQhRczTEp0jhLwR9xYo/U9ER4tIfqD6Rus6v1u8Hx0N49CSETBVYV8W6i
	3fI6K7qLp7pT64Nuw1zLQe9cFEz7mVNP8hxHjzN+GOCnaKioS4u1Hn51A7Xt3K7v
	v47Gnd3ZeearRZP6rZQxGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770806086; x=
	1770892486; bh=J0R4H45VT476W2JwlE3vz+YNlX6C/EXo0OOhTG73/wI=; b=t
	xnngfTqbtK8xRQSMUwfBS2Yyj7syRtRMSr09m0wEVYd2IjK8hbHGV0AFPSfnV9gd
	8qy2Qr1ml/3La5PsDPKYoGYxUtRrG6ByZG7njcVFGKMio4lC5d7f5wELl+UORlvn
	3Zg5NyS13fWHXvM6/8z3n96+l+etVum69P9DMUgnCgSGtOGbpWilnkNRYOmPrk8p
	IlGqFmzDLGYWgnDnViCg2btZpoWHIluagv2b22g2RNJrXyXuFmb9g3xtpii0mEcz
	9vsvTEA3vGtESyI9UX8sN5Kpjs5L3AyIAdVzo/8tnYRxcNvpqFAKrdhlHoF+NhPX
	YOUutEzDCZTZQ0t9geuwA==
X-ME-Sender: <xms:RluMaYmW9y0IsGJPGHsW6T9owCMjeOuRgn-Et_yb9LnMzlxFgc_ePw>
    <xme:RluMae3uJPujx3xz8wyKxrYZxIhcpqyxhQ5XSomKu0hDGQb-CD58fw9CILCRjr5xP
    EH0maplkZrrj0QhLCqrKmPOL-JMPFx9O2mI1sbUjvae7NNPPjVC>
X-ME-Received: <xmr:RluMabq2yFMYw_81scm2F_KhiD47v4MVaOl6OBx-zgK2f7IW7kZIMEdQk3Z4FicdV2vl-hKBiMPUrHqcE6U1lFzEzbaK6OFB9aoVhCNtx2cH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RluMaTf3OJlacr_Kjj4fwGloV4Z7dIhqBJKgeLzAxgmXQh8qLbDFSw>
    <xmx:RluMaSriUbFAOhbqg554_ALcuEkqOgZN0SUqMPzWggvDhl455JKpRA>
    <xmx:RluMacFVXUrSKN4Z8rMfuaCFfrXrjOCLjaO-YJFLppqvLYHXgA898g>
    <xmx:RluMaav8n3isnW7Y6blL0tzIuOGjQ5JMb-YILIc8g2xdjFnfCkzFDg>
    <xmx:RluMabk3Y5YGdJ0Z5034_R6WIZyGtPkGp6d9Z_4qP2NaRjfBUs6lHwH3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 05:34:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b9214631 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 10:34:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Feb 2026 11:34:28 +0100
Subject: [PATCH 2/7] ci: don't skip smallest test slice in GitLab
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-b4-pks-ci-meson-improvements-v1-2-cb167cc80b86@pks.im>
References: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
In-Reply-To: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

The "ci/run-test-slice.sh" script can be used to slice up all of our
tests into N pieces and then run each of them on a separate CI job.
This is used by both GitLab and GitHub CI to speed up Windows tests,
which would otherwise be painfully slow.

The infra itself is fueled by `test-tool path-utils slice-tests`. This
tool receives as input an "offset" and a "stride" that can be combined
to slice up tests. This framing can be misleading though: you are
expected to pass a zero-based index as "offset", and the complete number
of slices to the "stride". The latter makes sense, but it is somewhat
surprising that the offset needs to be zero-based. And this is in fact
biting us: while GitHub passes zero-based indices, GitLab passes
`$CI_NODE_INDEX`, which is a one-based indice.

Ideally, we should have verification that the parameters make sense.
And naturally, one would for example expect that it's an error to call
the binary with an offset larger than the stride. But with the current
framing as "offset" it's not even wrong to do so, as it is of course
well-defined to start at a larger offset than the stride.

This means that we get this wrong on GitLab's CI, as we pass a one based
index there, and this causes us to skip one of the tests. Interestingly,
it's not the lexicographically first test that we skip. Instead, as we
sort tests by size before slicing them, we skip the _smallest_ test.

Reframe the problem to instead talk about "slice number" and "total
number of slices". For all of our use cases this is semantically
equivalent, but it allows us to perform some verifications:

  - The total number of slices must be greater than 1.

  - The selected slice must be between 1 <= nr <= slices_total.

As the indices are now one-based it means that GitLab's CI is fixed.
The GitHub workflow is updated accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml |  2 +-
 t/helper/test-path-utils.c | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index f2e93f5461..ebb1a06bfa 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -150,7 +150,7 @@ jobs:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: test
       shell: bash
-      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
+      run: . /etc/profile && ci/run-test-slice.sh $((${{matrix.nr}} + 1)) 10
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       shell: bash
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index f5f33751da..874542ec34 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -477,14 +477,20 @@ int cmd__path_utils(int argc, const char **argv)
 
 	if (argc > 5 && !strcmp(argv[1], "slice-tests")) {
 		int res = 0;
-		long offset, stride, i;
+		long slice, slices_total, i;
 		struct string_list list = STRING_LIST_INIT_NODUP;
 		struct stat st;
 
-		offset = strtol(argv[2], NULL, 10);
-		stride = strtol(argv[3], NULL, 10);
-		if (stride < 1)
-			stride = 1;
+		slices_total = strtol(argv[3], NULL, 10);
+		if (slices_total < 1)
+			die("there must be at least one slice, got '%s'",
+			    argv[3]);
+
+		slice = strtol(argv[2], NULL, 10);
+		if (1 > slice || slice > slices_total)
+			die("slice must be in the range 1 <= slice <= %ld, got '%s'",
+			    slices_total, argv[2]);
+
 		for (i = 4; i < argc; i++)
 			if (stat(argv[i], &st))
 				res = error_errno("Cannot stat '%s'", argv[i]);
@@ -492,7 +498,7 @@ int cmd__path_utils(int argc, const char **argv)
 				string_list_append(&list, argv[i])->util =
 					(void *)(intptr_t)st.st_size;
 		QSORT(list.items, list.nr, cmp_by_st_size);
-		for (i = offset; i < list.nr; i+= stride)
+		for (i = slice - 1; i < list.nr; i+= slices_total)
 			printf("%s\n", list.items[i].string);
 
 		return !!res;

-- 
2.53.0.295.g64333814d3.dirty

