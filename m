Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885902BE647
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174458; cv=none; b=fnkxSIu+NY1mIxcht2RV0XmQe2EZIRyrpwhO/LOpPa/a3jUSN2PY4M1vh6EbEE0bZPzG9G1aPcVdqLK8m6Kz3HOxQf3ejeyDU+P3VR29aaMJTuXbJuPhhnAC0JcX29VxGRBW7mpdwVG7zaS1Sy6tRnkYmXJ5lKjasnKiS7TOxEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174458; c=relaxed/simple;
	bh=9vfIQPZzS78R0N70xVPUGUpgztpONvTVbUXAaTDFigk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Koi+eEtrVweUMNsoZkT4CxEz5tSb+kHsxjuWkBqjyYOuITkcoQPh9/FWEO5P3mCymH3zXkQJoGj0X2F4fwZp3MiaV/69EPrG0vFj+mZMZOqRzYcFz7JefL8lgg+hsN6614AD8oXMtsCfjKqjZxu03NX5le89fgJXqUgnWSmsfxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmJTXSxH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmJTXSxH"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2698384978dso3746675ad.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758174455; x=1758779255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaByfOwz7Tm410PgESFS3mI3VL6dVObAgvO37yeKDss=;
        b=DmJTXSxHoLZpXeJXEieD1MsPrlblN8/60h5+XvB5ReN2LLfiS/7W5Sdymc+JaomP5k
         YXMA+Rjfz8FMUQ7td0fzVf0aTufS4lEfIW4FoM2kj/TDDQGePZL5ILa5ed3m6Rh86De7
         jLwkSzrGqKLXVoLI/TbzghYprg3NxpRKalnwC0wcLp/8wg79i/ZjNOZPJQuZrZuh4hLO
         y4ZYK4BAFdpqo6TGgtYvKpSdbBQXov8Xe/DA+ehMpkICLycoXVt9qGo2vlFJg7cxzCxz
         o3kH+62hU83aRE26vDe8M/PlBovrxMOJanW7WA4sunJOpUGTaNFRr7Zba0T9zE9l9+jR
         Q8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174455; x=1758779255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaByfOwz7Tm410PgESFS3mI3VL6dVObAgvO37yeKDss=;
        b=tqyskc21ky3eUrrtkSVaM0mVMXpf6M1VaDUuE1Fi3e3wnabytHh3qtZCYmEBu4NBBm
         HnrKRXjoLST6kBSjU9DKn1BQlEx5I+fH8o2sgbFC+TC4/h+tMsXpuTVkgfmgjP0Trvwo
         ozWON54b1C4z7R+IU53BRun64iq3VDf1McRJ3AQmQX+G14utflYMGIS7H3VujPUEvXwf
         x7oAlwDGDWElc3QJO8vbRA1qH2qkZW/1J5+/hPYoMvO1hohHMqYftH+sNNt7/aNOxMt8
         BBJsI0/XfjOCFNxY/byGD+lbZUO3pGfF/ppDz6NA9ynpheaWNSzsL7rUeRBImnD1gpmu
         /sbg==
X-Gm-Message-State: AOJu0YyMh5RHNJeCjUUU/aZcFNBhi4V8ArQpxu1EebZV9RZN3kVs/YF6
	DJsSoCb2SUIjW5Usefrw+R7sRNjW0oPd3HW9R627yXK8uaEuGh3Ch6DANsbcLA==
X-Gm-Gg: ASbGnctSSQGku7X7RpA+Ns4/UqNk4xzOaRoY2AgdvlpEIq0hgM2qb06+vVv0Tb4/og/
	3TqH/h9rwutzPie9A8R3Vwh0/MO3uszejoBzihbzhysHtdDlieokVku8HdflTiNX28MDx04NJw3
	RUHK5HZ8Ipok5GmCMl+9BK/OA4J2/kzsQkjI6qlduUanYnLTTjHPluNhWkwseZyxPx3dDmVYt2J
	QHlnxEZ7agC7NxmMlmVz9OUtouHDo/eorbGTQO/1opyJiEvLujoe2XmmKcq2FgRJLxIvaZ1lkSy
	mGs+a6ICRDoPglTr02H1nHL4J01c8CkGyJXvK8NP2kcZcRJFEQAhgqTKvYo112OdYH4xDOIsRWq
	uAeDf+CEL6N65WrKAkZ3hytkflalYgHQ/L5r6rQ==
X-Google-Smtp-Source: AGHT+IETdh2s8tbzhFLkMfdIQ6Px7vSi6FC4WVb1o+Q5hjsqC/M3f4eARZfpyt0o8VNyN7SClxNaDQ==
X-Received: by 2002:a17:903:38c3:b0:267:c984:8d9f with SMTP id d9443c01a7336-26812190909mr57896685ad.24.1758174455436;
        Wed, 17 Sep 2025 22:47:35 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802debfcsm13621535ad.86.2025.09.17.22.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:47:34 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 9/9] t: add test for git refs optimize subcommand
Date: Thu, 18 Sep 2025 11:17:04 +0530
Message-Id: <20250918054704.544254-10-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918054704.544254-1-meetsoni3017@gmail.com>
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
 <20250918054704.544254-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test script, `t/t1463-refs-optimize.sh`, for the new `git refs
optimize` command.

This script acts as a simple driver, leveraging the shared test library
created in the preceding commit. It works by overriding the
`$pack_refs` variable to "refs optimize" and then sourcing the
shared library (`t/pack-refs-tests.sh`).

This approach ensures that `git refs optimize` is tested against the
entire comprehensive test suite of `git pack-refs`, verifying
that it acts as a compatible drop-in replacement.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build            |  3 ++-
 t/t1463-refs-optimize.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100755 t/t1463-refs-optimize.sh

diff --git a/t/meson.build b/t/meson.build
index baeeba2ce6..92327aabdf 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -211,6 +211,7 @@ integration_tests = [
   't1451-fsck-buffer.sh',
   't1460-refs-migrate.sh',
   't1461-refs-list.sh',
+  't1463-refs-optimize.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
@@ -1219,4 +1220,4 @@ if perl.found() and time.found()
       timeout: 0,
     )
   endforeach
-endif
\ No newline at end of file
+endif
diff --git a/t/t1463-refs-optimize.sh b/t/t1463-refs-optimize.sh
new file mode 100755
index 0000000000..c11c905d79
--- /dev/null
+++ b/t/t1463-refs-optimize.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='git refs optimize should not change the branch semantic
+
+This test runs git refs optimize and git show-ref and checks that the branch
+semantic is still the same.
+'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=files
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+. ./test-lib.sh
+
+pack_refs='refs optimize'
+. "$TEST_DIRECTORY"/pack-refs-tests.sh
-- 
2.34.1

