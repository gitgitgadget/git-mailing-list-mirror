Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E8385501
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670051; cv=none; b=WpjrY+wNN9GvkIUFAYNCpcAuwZrDuNKDCO5UCld5LiH9hV50H3X6j0FsdkSuQZki4ohORd+kxx0Rlxbdui39khr5bZg+uFGX36ej12gwGDSRw7TOgkWDKCvVSSFeLdxALoJp7zWI27Ur+yP6MuCsBEissUhxWzE518/ZVcXhr70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670051; c=relaxed/simple;
	bh=YXT7/poVCz51SQ52IQLErSmPA1zRE6DtveYVXQBFA0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jHh3p0rGPhZY4YO8Q1mh3QTcRlCsFtowCDq/YsHS5/a7TNiJvwp7FnIHARcwmIW7H0f+Dwqi6sp1xw1+ScXXRn8rBmKc3Vf+/Sn59sS37vybOhWmchwzW3e0icJcYbD6hBqQKLbG9WRsUTf0X3pQC01Aw6JB7NTqtqGIVXfpHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J95tIsto; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qtEuUHn3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J95tIsto";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qtEuUHn3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96494140009D;
	Mon, 20 Apr 2026 03:27:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 20 Apr 2026 03:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776670049;
	 x=1776756449; bh=mMwjZrEM95Od0bQugABsmaEZIyZWB4R542aDuTUvirA=; b=
	J95tIstoUMjQMEE1/qzjHM1IZ7VI3vpu1g/kmxdG4yiLQDa1HOK10zVFguy60oZd
	9n5GIKqMC2rH9YwnBO6fLcrdZq/wovTAOsA7JxzW14hssxHtzdAjCjV28ZQJnH8o
	qICLKetUnw7VtT2yu85OUKjFV0c6MscatundTDTAoMog9mtLYTkx2Bb5yCVJ6dgB
	hyjlo5QhdSHFT+V5ZaKr1aIC9IdJ1rxC72UXTqOemlix2ngW1DQmhQ8eW82xvuAy
	Aaj3ftoygzqlH0eo39CeaGL4FupayxyXJG1i6XnO+Ep/uhniDEOPK9Zhh0gbCTkI
	0JUGR/sdKwtu3t5VTqumBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776670049; x=
	1776756449; bh=mMwjZrEM95Od0bQugABsmaEZIyZWB4R542aDuTUvirA=; b=q
	tEuUHn3DHXs+M9aViJIn1MyxyiLQUz7FmmEgptiA1IqJNwG5nx+ajSs/xPifE+q8
	t+LKybCUqdl7JlELtTKJHtTprkVxaP5udafDSbuLshGgSd0+/j7KIqmn7ZSjRN5U
	UKxYYgEA2OXRNhABLN2lrRITOuCUuAVl7w7JS3kavKo0TnoJCnq2OjGz6ifMaS3i
	3AoT0pJ3Pxweoh0myRf4qqdY9i9/zIJyGkKvww2/AzPHXdYwGQneKNfycarHKWST
	wJi0wwGNFIMNG8M1nVrVqDhyiz12AhpGyOY+oi3lg9qblyIjQM0bbAQM7xYvzUxC
	bySJogL3U+Zp8CxFI6crw==
X-ME-Sender: <xms:YdXladBbze7icfpg0Un4deOjLMOSaQDokp3W_I4wDZBt1MEYv6aMvg>
    <xme:YdXlaSi425TG6hh3evLHw9eAQ9BGgAnBV58ixWnpZEDb_u1fh8kAsuTfDC1NLmbZR
    hXSDC3AdqmZXanhmRGzKI_3xV9s70PQSUyNbWbOo67MyaI7RdVabg>
X-ME-Received: <xmr:YdXladlmy6sB2gIBRfIKthFG6CyYNYUqzFIAaC4Z284p93Ry0TI1icf-EyPm2Va-gmMletcnOBBVFzkvgcA_xfMOtE0_PAKrl0U6t3LvlztH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsiigvug
    gvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:YdXlaWrOLbv7hcNHYOd0_llWFO04AkPtc1zIIqEOWP6Dz0coLK8Kww>
    <xmx:YdXlaeFU7bzqe5iW_rz3nvOShrURpcYfFDzlAbc1MCyJJo_kAGjIhg>
    <xmx:YdXlaayXUVfrD2M0lSSxuZdRUKruRorq4_nkqAgk7jDjwrwXQ79_Bw>
    <xmx:YdXlabovff5BbroJmrfOWF2ygy1JsNylIUhL3fKEHNSbX3TCpmRHSQ>
    <xmx:YdXlaXjBn6tWAGGuOa8RTw3Be04n2K3MIU5LmYd3R-3kDxptECP5DptW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:27:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d14fa8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:27:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 09:27:20 +0200
Subject: [PATCH v5 01/12] t: prepare `test_match_signal ()` calls for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-b4-pks-tests-with-set-e-v5-1-7d3d68292f6b@pks.im>
References: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
In-Reply-To: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

We have a couple of calls to `test_match_signal ()` where we execute a
Git command and expect it to die with a specific signal. These calls
will essentially execute the process in a subshell via `foo; echo $?`,
but as we expect `foo` to fail this will cause the overall subshell to
fail once we `set -e`.

Fix this issue by using `foo && echo 0 || echo $?` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0005-signals.sh | 4 ++--
 t/t3600-rm.sh      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index afba0fc3fc..84319cf169 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -42,12 +42,12 @@ test_expect_success 'create blob' '
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
-	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
-	OUT=$( ((trap "" PIPE && large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 1f16e6b522..a371ea690e 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -260,7 +260,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft (induce S
 
 test_expect_success !MINGW 'choking "git rm" should not let it die with cruft (induce and check SIGPIPE)' '
 	choke_git_rm_setup &&
-	OUT=$( ((trap "" PIPE && git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && git rm -n "some-file-*" && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT" &&
 	test_path_is_missing .git/index.lock
 '

-- 
2.54.0.rc2.529.gd9106f7525.dirty

