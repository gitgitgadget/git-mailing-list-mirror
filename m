Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0821C16B
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721366; cv=none; b=ZXkC31PHhzXsdWDH2WUz8fBMqpVSLtyAasCvQorjnCyDQqKHKYo3i7bMs1cNibADpBO7YFLj89Ojwfr5lH7SMHnLpEc5Cb6bbGN4s1ecQeBcNrqgsxmvej5c39o+514Ye5vVbnS5wQxV4ZCGx2Rcbqm9ZYZZJjnF9bf5s1wz7IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721366; c=relaxed/simple;
	bh=zRS732PVY28DhGLlZNkxyAGaGfpuf+y/r0q3gyo8S1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVecVW5Nx+b4IjPdFCRLxDyZfB4NjsZChP1fqnhXWVxBO/lI+KDBYeWZS7B9fFrFd93qXMIt7/QMglTWWkDbeKn6TI9tTDO9TzCWZyhkOqiPA3U6XFh33eDvrB/HVRW1rhrhZkQ7k6kDh6WxOW+jCJY42kx+yUNvUG4QhrHuxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJlpCZbR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJlpCZbR"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so3657799a91.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 04:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737721363; x=1738326163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KGvJcJNDa0j7iQjZZ2ooP1DPcHkTZ3keVk2fmUa7PI=;
        b=LJlpCZbRiCkHGKSdRYcSX2y4tRJIqy8RGUCEhhMAJqYVMKB+7KvLXHq/Zow8kQsZlS
         UFj3gPKLH0JXkxGkgRItF4CWDUQVsdSz85ZaIBysMIR7+zr8JvTWArD2kItwZgTJWgM/
         VbC+Pk6lSYmHBGOg1oN19gUAIZ5JqsJH8Vs5x6GOT7LW6bhdomIsBg1zqzEJcRiNf4EA
         YzUQe1eq7qC1GleAHusCDGbGA6Z413y9I/1h+W/Eyf/cKnlTYFci2Ox14Uh3euiuQEXr
         CQl/KyQf7NpqH6JrYd77w6MvO+w7tqw3nKNHxu7kNy3CsAfxjxoQ75ypXEHEjUBYxRnT
         7R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737721363; x=1738326163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KGvJcJNDa0j7iQjZZ2ooP1DPcHkTZ3keVk2fmUa7PI=;
        b=MdabCwpuE+eesfSAyev7JIFGUS14Fy45jJbtGpre/Ud4nBEfqBA0705qDsEd499TSp
         8YoGEe7DQhmd9Tg7COYkRD7ISx4x8L2DTLsX/yNudDFq25RMajOICgZaRIAIcxWy3hnh
         edE2I4P5FjJrVy1/dV+GyZsmyJWUtKBewdR1M9C6yASuVLyaQzjhHn0NnbrMQiwXwUfo
         ajfd3PR3yQVCeNv3cpPqEunDVNzE5LH41pCdY4rjBAHcWtVR6b0IeyxRN1IyaaHaf3Ja
         uwMgCcYrZJEREtpaXdMq4tY9XaB6XJTLMRkRdPPLSyal8YI8rbVrZ0eXvaVTe3fxFOuW
         K6hA==
X-Gm-Message-State: AOJu0Yz8AqboMUXxA6TK9rsQmNKTUZ6r1niy9q2XveqgQ0YgyAAedatr
	Jm5s7VtlTTJMMwKQwYsgRWRw99SGbL9uGrr0bLmxpOnN0iXroTh9s9oA5En7iDY=
X-Gm-Gg: ASbGncvCacnKBVznQ7SQyLrL8iVtLHUMkNLdYsaow0LQvaMj5Uq81hk0KUBCGv3TWCp
	yhAx+JP+1L0D1VCB0h9/opBGaMe5e/pPAmJwyrgvkbz/WOvD0MZFCUb1dks/uYgSN7NGHYoHedy
	WUKEsjWLC/8Mkq9CAbo4Egz7hBw3sJo1Eai1N7UQM/yTmJSqaVZolGEH4Wmc3eYbn/NANNODOsa
	azq8/MjzGR21KGHH0MP1gq/cubKbMDUh1KAS1jVba1DA97bfFVvkuCnLm7JwfEcZHeQYyuQzvBw
	nJaITkg/JAvrSbCZVnJBLT6QkRsBtg==
X-Google-Smtp-Source: AGHT+IGJhJLf0QZ8+5cSiHKw+g/FXagN2b77GOPRazRfmcG2Dh7pOMQ8asu720gkuBdDMBZzR7GjEA==
X-Received: by 2002:a17:90b:38d0:b0:2ee:d35c:3996 with SMTP id 98e67ed59e1d1-2f782d972f5mr42773258a91.31.1737721363604;
        Fri, 24 Jan 2025 04:22:43 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffb1dc56sm1685056a91.49.2025.01.24.04.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:22:43 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 5/6] t5701: add setup test to remove side-effect dependency
Date: Fri, 24 Jan 2025 17:51:40 +0530
Message-ID: <20250124122217.250925-6-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250124122217.250925-1-usmanakinyemi202@gmail.com>
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
 <20250124122217.250925-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the "test capability advertisement" test creates some files
with expected content which are used by other tests below it.

To remove that side-effect from this test, let's split up part of
it into a "setup"-type test which creates the files with expected content
which gets reused by multiple tests. This will be useful in a following
commit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t5701-git-serve.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index de904c1655..9394235fa0 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -7,22 +7,28 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-test_expect_success 'test capability advertisement' '
+test_expect_success 'setup to generate files with expected content' '
+	printf "agent=git/%s\n" "$(git version | cut -d" " -f3)" >agent_and_osversion &&
+
 	test_oid_cache <<-EOF &&
 	wrong_algo sha1:sha256
 	wrong_algo sha256:sha1
 	EOF
+
 	cat >expect.base <<-EOF &&
 	version 2
-	agent=git/$(git version | cut -d" " -f3)
+	$(cat agent_and_osversion)
 	ls-refs=unborn
 	fetch=shallow wait-for-done
 	server-option
 	object-format=$(test_oid algo)
 	EOF
-	cat >expect.trailer <<-EOF &&
+	cat >expect.trailer <<-EOF
 	0000
 	EOF
+'
+
+test_expect_success 'test capability advertisement' '
 	cat expect.base expect.trailer >expect &&
 
 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
-- 
2.48.0

