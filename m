Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301E3B2A2
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741564; cv=none; b=oniWHKJsVrGH01Bh9pY2cOp/5MbAzDfE4XAUaPQ/e4bb+h5APOkSIezZzsTbBK4K9fSrveKlqr157TKPaHLjg7Y7EaqBizqBMy5u5cQkg0CrlSuK6cUEr9kKBboNv3cnAQ4A7YsNiFsw3Y3B4elMi1D7q2rjuGlw97xraJWtdGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741564; c=relaxed/simple;
	bh=8E6KBsxvECdOD3bvKFyO8GhHhKtAZ4prwm0qYAwR9M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bz6FqDJuTten0BsgQEbF0oV7t6tstd3wJXg80jUuW+4El5ym5jVR51dOPeAcYTJt+PR7O1ruiEjwok6s8QzpVIfQOc94oxJEj/06NSj10pH0EZLXrLg5Ezl7huDojzk3t9vPHwpV617IVjv5H9lFExqGEgFOo/XkwRyxWzbmHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tBpno5jP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tBpno5jP"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783d8e09a1cso18905885a.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741561; x=1707346361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITwzgS0eVmO5uULQt5Bo//sN7vdqNO58ibwbBGz1MZU=;
        b=tBpno5jPQqUElOibryABPt+7vF7sxX6ztXx+/zZSxs3b+FFqs8i/fTqHzdfK/oehPG
         z53pceNc/3aLs5S3ZirGV4tep48MO2rxP87nVfrnoMU6xKNKsf2ET8nCgqD4tQ8CePTK
         DvvEyaqHIvNMx0RwSJDkqjlow+AcaZjyn6oRcsQk76QcKimSyNTh85GoQyelAnhGIXc0
         +8kSC84BjtlqTOXzGHzUcG4wmDTg6vBemr5qB0vpvDEcKLgyJl8TZiDM9CZx/k+IAUSC
         1ZzMGMi2y9hECczndD5ko6+8UaAMCarlxEDYmHWZXM70mHkC0aFcSwHlbgXFxZ9QUnzy
         dlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741561; x=1707346361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITwzgS0eVmO5uULQt5Bo//sN7vdqNO58ibwbBGz1MZU=;
        b=mgg3khET4Z+vy0chjX47FHn31ZxPrAoO9NRdO2w6WCMpezzFbPtolBncpJyQ1mFnX2
         HEdguvk9g+1p+0B80jEh2Q5+kOyfJalMXhsUiCBtRgTaQSfW2gc4NsuKc8kejqLqk4rb
         3Lk4MvN9ZLWwFO/5y1n/6rW09Yr/eYZ5RQ/sXVeJcz27uZGMYKvfTuwY/6eW2jhPf5wX
         EDGzuYxRa/pN4EB2DoPJQt23JM0J3BE+1nsj/SXeOkB/pkm5uMtRqiJq31ubAypo5lKZ
         oi/7x8cGzUFTiVo8KC+e0D/L20Rleos8X6o4pfSHcbyHDbw6L9N3OOQhoOlrr4XHrOIG
         k+lQ==
X-Gm-Message-State: AOJu0YwOCMw5Z1MlgndRpTZPJeAIpbU2b3pziYSnHyAux08lRyNLZgg/
	UlmPVm7xLov/UMg4CYx8YAM+VzweFTlwmbpGNr21+fnL8wbKGk2JJ2DB3hsJTSN2N/9IgzvB7Yg
	GpEw=
X-Google-Smtp-Source: AGHT+IF9KGW95xMqgXFduDhB2qbt+1js48i4mlzO+vmBlJMlHtvyDU7/U3/p06nNtiWfArfY7vR6Rg==
X-Received: by 2002:ad4:5cca:0:b0:68c:4306:b8a7 with SMTP id iu10-20020ad45cca000000b0068c4306b8a7mr3663368qvb.9.1706741561379;
        Wed, 31 Jan 2024 14:52:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id on6-20020a056214448600b00685ad9090basm2336527qvb.97.2024.01.31.14.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:41 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:40 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 08/16] t4216: test changed path filters with high bit paths
Message-ID: <7de7b89da072513c6e095fccdcac92dae7cda14a.1706741516.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1706741516.git.me@ttaylorr.com>

Subsequent commits will teach Git another version of changed path
filter that has different behavior with paths that contain at least
one character with its high bit set, so test the existing behavior as
a baseline.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 51 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 64737b6ee9..93b8d096cf 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -485,6 +485,57 @@ test_expect_success 'merge graph layers with incompatible Bloom settings' '
 	test_must_be_empty err
 '
 
+get_first_changed_path_filter () {
+	test-tool read-graph bloom-filters >filters.dat &&
+	head -n 1 filters.dat
+}
+
+# chosen to be the same under all Unicode normalization forms
+CENT=$(printf "\302\242")
+
+test_expect_success 'set up repo with high bit path, version 1 changed-path' '
+	git init highbit1 &&
+	test_commit -C highbit1 c1 "$CENT" &&
+	git -C highbit1 commit-graph write --reachable --changed-paths
+'
+
+test_expect_success 'setup check value of version 1 changed-path' '
+	(
+		cd highbit1 &&
+		echo "52a9" >expect &&
+		get_first_changed_path_filter >actual
+	)
+'
+
+# expect will not match actual if char is unsigned by default. Write the test
+# in this way, so that a user running this test script can still see if the two
+# files match. (It will appear as an ordinary success if they match, and a skip
+# if not.)
+if test_cmp highbit1/expect highbit1/actual
+then
+	test_set_prereq SIGNED_CHAR_BY_DEFAULT
+fi
+test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
+	# Only the prereq matters for this test.
+	true
+'
+
+test_expect_success 'setup make another commit' '
+	# "git log" does not use Bloom filters for root commits - see how, in
+	# revision.c, rev_compare_tree() (the only code path that eventually calls
+	# get_bloom_filter()) is only called by try_to_simplify_commit() when the commit
+	# has one parent. Therefore, make another commit so that we perform the tests on
+	# a non-root commit.
+	test_commit -C highbit1 anotherc1 "another$CENT"
+'
+
+test_expect_success 'version 1 changed-path used when version 1 requested' '
+	(
+		cd highbit1 &&
+		test_bloom_filters_used "-- another$CENT"
+	)
+'
+
 corrupt_graph () {
 	test_when_finished "rm -rf $graph" &&
 	git commit-graph write --reachable --changed-paths &&
-- 
2.43.0.509.g253f65a7fc

