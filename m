Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303CB227571
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715207; cv=none; b=lG9W7gsUCxzRVwZU/6Q4R2fjjoYw5Ea5y5cn5cah8+ox8XKKKlAsbKess1qh6TFX+8evs9jeregtMfoWrSKQ9rYMWbocZ+ZoEh4+XPXMPjH/M4i9N5w4sWt9o4545Hf4m6jFTDf6FfK0hXQaUxlU9aBnazbSVas863abCDXLamY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715207; c=relaxed/simple;
	bh=/bD6qCwBs7FMfZFdgS/bUKV61sJk3M+6KsZ3ijnHrYw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jSyD4yzBww3qPbwsPe7AlYY8u16e+RaunWXVo7716+NVgDKHPadLL8ZFzcE2sUI1nlJvk7aKU6RRHGZz6Uw4rJfNIzU5Zw0YqrpyjQkfznDYpI1RTj+ple228yAG50u4tvycoE0oN6G2zXVFXC3lr40bJmqhcUiGp8Aoe0MLiTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcA7swUp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcA7swUp"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436345cc17bso16186515e9.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 09:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734715203; x=1735320003; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnbYefj8n+7rAkXVOoyWudmPM1pS4P6SwY3WyjHlJqo=;
        b=VcA7swUp4TjpoWi0UhfLRhYcyxvnyDK0NmRt0gDyBQJ97pQWEwhIEo0fbQjxbiOlwt
         52t+8b4e92O9ZlfKbDVwgz6dc3ZXshkeW+4fjtquQEcfT0H4cE+hO2WSYRvgtlEY0FcT
         hMji7ksy2anEjOVoZ/DTQdnFl/x09ZJ1o4h8PKnksVwTloOPykN94r9nUZVOipgRCQe0
         5goW9Pk8UUJC7jH8JUWEtrFHjKdFYYNC2IhTcHB9KNoIXo3s1nQVlsObd/STCBwvgZwI
         jQDR1Y8uHDysJs2Kcj34F4RKto7oGCfPvksRzscS3nhsPxTvam67KhZf1+vixrKVHBQU
         G0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715203; x=1735320003;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnbYefj8n+7rAkXVOoyWudmPM1pS4P6SwY3WyjHlJqo=;
        b=Fk3zBJxWnulXVepDSBMETmegPPcnrUcyjaHFD4d38wN+s47jGHPh6Kog82cWFEBYsl
         RCCiLcf6j9uzb1p+OtbU7BMnejF5uh2+dzO0zTOtv2mq7AN76sEGU/gP5pa/Q+vvjPcO
         AUo3F4w9e736G5jd+3oN0ZIsSkPbvm1h55olAV7O3zkhxI/8NkW/Ry4ZHdL0Ijdy4XyS
         AJudjPp4u4hyW41YQpaJ55nNhCYy5boP73Sy4UAPAyw8vGjMPC9qxAdV13K+ZI+l5HQv
         btxy3JrB+BF3UqVHCtfR7LOEMKdul9T9GqVBaWyKKv8DRivHd8obLewHE727qIEeU103
         pZsQ==
X-Gm-Message-State: AOJu0Yy4dZE1wd3+LdaL8wOMEVjeMQjUv8g3hwdJUXdKSjs86sNN/gdE
	SQZOKMTc14VJyJBjLaDxfAO+guE9lEkd6bu+jpcgW55BqNtKkTWtl5FvFw==
X-Gm-Gg: ASbGnct/wpiYPTizR1+L1yIiGT3UKvfZ1iCxGfnq3yo5+HCJTsCWaKLDBJ8GNz0OFBH
	LaAlV8XwErKNnX6qsCebs708znsEnLGl3Jp3h8K/R9Ub0acBfHRACrR+pe7HoWelZd6FjV1O95M
	jvaNJT/6cxAER/teozS2E9U5Zh2g2FhjGuOQkcHWDwXWS2bBrJNZi0TCElgBrz9eCN/mWyzIHuf
	a8w5bCe23RQOQlT7XYjZLqa717yliN3KPagK90nA3dpC8A7tkb34lhbaw==
X-Google-Smtp-Source: AGHT+IHqIQ0LDWgI7jZhKaztCaPHpYvMvhYRf5+HPc99+Ev3p4q9c4XR73gr7DxGdhoLjhROaXyjrQ==
X-Received: by 2002:a05:600c:3ca1:b0:434:a350:207c with SMTP id 5b1f17b1804b1-43668b5e22fmr31301145e9.23.1734715202813;
        Fri, 20 Dec 2024 09:20:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436612008bcsm50652205e9.16.2024.12.20.09.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:20:01 -0800 (PST)
Message-Id: <163aaab3e1bec5bf92e4e056df84aa76848b31a4.1734715194.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
	<pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 17:19:51 +0000
Subject: [PATCH v3 5/8] p5313: add size comparison test
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

As custom options are added to 'git pack-objects' and 'git repack' to
adjust how compression is done, use this new performance test script to
demonstrate their effectiveness in performance and size.

The recently-added --name-hash-version option allows for testing
different name hash functions. Version 2 intends to preserve some of the
locality of version 1 while more often breaking collisions due to long
filenames.

Distinguishing objects by more of the path is critical when there are
many name hash collisions and several versions of the same path in the
full history, giving a significant boost to the full repack case. The
locality of the hash function is critical to compressing something like
a shallow clone or a thin pack representing a push of a single commit.

This can be seen by running pt5313 on the open source fluentui
repository [1]. Most commits will have this kind of output for the thin
and big pack cases, though certain commits (such as [2]) will have
problematic thin pack size for other reasons.

[1] https://github.com/microsoft/fluentui
[2] a637a06df05360ce5ff21420803f64608226a875

Checked out at the parent of [2], I see the following statistics:

Test                                         HEAD
---------------------------------------------------------------
5313.2: thin pack with version 1             0.37(0.44+0.02)
5313.3: thin pack size with version 1                   1.2M
5313.4: big pack with version 1              2.04(7.77+0.23)
5313.5: big pack size with version 1                   20.4M
5313.6: shallow fetch pack with version 1    1.41(2.94+0.11)
5313.7: shallow pack size with version 1               34.4M
5313.8: repack with version 1                95.70(676.41+2.87)
5313.9: repack size with version 1                    439.3M
5313.10: thin pack with version 2            0.12(0.12+0.06)
5313.11: thin pack size with version 2                 22.0K
5313.12: big pack with version 2             2.80(5.43+0.34)
5313.13: big pack size with version 2                  25.9M
5313.14: shallow fetch pack with version 2   1.77(2.80+0.19)
5313.15: shallow pack size with version 2              33.7M
5313.16: repack with version 2               33.68(139.52+2.58)
5313.17: repack size with version 2                   160.5M

To make comparisons easier, I will reformat this output into a different
table style:

| Test         | V1 Time | V2 Time | V1 Size | V2 Size |
|--------------|---------|---------|---------|---------|
| Thin Pack    |  0.37 s |  0.12 s |   1.2 M |  22.0 K |
| Big Pack     |  2.04 s |  2.80 s |  20.4 M |  25.9 M |
| Shallow Pack |  1.41 s |  1.77 s |  34.4 M |  33.7 M |
| Repack       | 95.70 s | 33.68 s | 439.3 M | 160.5 M |

The v2 hash function successfully differentiates the CHANGELOG.md files
from each other, which leads to significant improvements in the thin
pack (simulating a push of this commit) and the full repack. There is
some bloat in the "big pack" scenario and essentially the same results
for the shallow pack.

In the case of the Git repository, these numbers show some of the issues
with this approach:

| Test         | V1 Time | V2 Time | V1 Size | V2 Size |
|--------------|---------|---------|---------|---------|
| Thin Pack    |  0.02 s |  0.02 s |   1.1 K |   1.1 K |
| Big Pack     |  1.69 s |  1.95 s |  13.5 M |  14.5 M |
| Shallow Pack |  1.26 s |  1.29 s |  12.0 M |  12.2 M |
| Repack       | 29.51 s | 29.01 s | 237.7 M | 238.2 M |

Here, the attempts to remove conflicts in the v2 function seem to cause
slight bloat to these sizes. This shows that the Git repository benefits
a lot from cross-path delta pairs.

The results are similar with the nodejs/node repo:

| Test         | V1 Time | V2 Time | V1 Size | V2 Size |
|--------------|---------|---------|---------|---------|
| Thin Pack    |  0.02 s |  0.02 s |   1.6 K |   1.6 K |
| Big Pack     |  4.61 s |  3.26 s |  56.0 M |  52.8 M |
| Shallow Pack |  7.82 s |  7.51 s | 104.6 M | 107.0 M |
| Repack       | 88.90 s | 73.75 s | 740.1 M | 764.5 M |

Here, the v2 name-hash causes some size bloat more often than it reduces
the size, but it also universally improves performance time, which is an
interesting reversal. This must mean that it is helping to short-circuit
some delta computations even if it is not finding the most efficient
ones. The performance improvement cannot be explained only due to the
I/O cost of writing the resulting packfile.

The Linux kernel repository was the initial target of the default name
hash value, and its naming conventions are practically build to take the
most advantage of the default name hash values:

| Test         | V1 Time  | V2 Time  | V1 Size | V2 Size |
|--------------|----------|----------|---------|---------|
| Thin Pack    |   0.17 s |   0.07 s |   4.6 K |   4.6 K |
| Big Pack     |  17.88 s |  12.35 s | 201.1 M | 159.1 M |
| Shallow Pack |  11.05 s |  22.94 s | 269.2 M | 273.8 M |
| Repack       | 727.39 s | 566.95 s |   2.5 G |   2.5 G |

Here, the thin and big packs gain some performance boosts in time, with
a modest gain in the size of the big pack. The shallow pack, however, is
more expensive to compute, likely because similarly-named files across
different directories are farther apart in the name hash ordering in v2.
The repack also gains benefits in computation time but no meaningful
change to the full size.

Finally, an internal Javascript repo of moderate size shows significant
gains when repacking with --name-hash-version=2 due to it having many name
hash collisions. However, it's worth noting that only the full repack
case has significant differences from the v1 name hash:

| Test      | V1 Time   | V2 Time  | V1 Size | V2 Size |
|-----------|-----------|----------|---------|---------|
| Thin Pack |    8.28 s |   7.28 s |  16.8 K |  16.8 K |
| Big Pack  |   12.81 s |  11.66 s |  29.1 M |  29.1 M |
| Shallow   |    4.86 s |   4.06 s |  42.5 M |  44.1 M |
| Repack    | 3126.50 s | 496.33 s |   6.2 G | 855.6 M |

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p5313-pack-objects.sh | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100755 t/perf/p5313-pack-objects.sh

diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
new file mode 100755
index 00000000000..be5229a0ecd
--- /dev/null
+++ b/t/perf/p5313-pack-objects.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description='Tests pack performance using bitmaps'
+. ./perf-lib.sh
+
+GIT_TEST_PASSING_SANITIZE_LEAK=0
+export GIT_TEST_PASSING_SANITIZE_LEAK
+
+test_perf_large_repo
+
+test_expect_success 'create rev input' '
+	cat >in-thin <<-EOF &&
+	$(git rev-parse HEAD)
+	^$(git rev-parse HEAD~1)
+	EOF
+
+	cat >in-big <<-EOF &&
+	$(git rev-parse HEAD)
+	^$(git rev-parse HEAD~1000)
+	EOF
+
+	cat >in-shallow <<-EOF
+	$(git rev-parse HEAD)
+	--shallow $(git rev-parse HEAD)
+	EOF
+'
+
+for version in 1 2
+do
+	export version
+
+	test_perf "thin pack with version $version" '
+		git pack-objects --thin --stdout --revs --sparse \
+			--name-hash-version=$version <in-thin >out
+	'
+
+	test_size "thin pack size with version $version" '
+		test_file_size out
+	'
+
+	test_perf "big pack with version $version" '
+		git pack-objects --stdout --revs --sparse \
+			--name-hash-version=$version <in-big >out
+	'
+
+	test_size "big pack size with version $version" '
+		test_file_size out
+	'
+
+	test_perf "shallow fetch pack with version $version" '
+		git pack-objects --stdout --revs --sparse --shallow \
+			--name-hash-version=$version <in-shallow >out
+	'
+
+	test_size "shallow pack size with version $version" '
+		test_file_size out
+	'
+
+	test_perf "repack with version $version" '
+		git repack -adf --name-hash-version=$version
+	'
+
+	test_size "repack size with version $version" '
+		gitdir=$(git rev-parse --git-dir) &&
+		pack=$(ls $gitdir/objects/pack/pack-*.pack) &&
+		test_file_size "$pack"
+	'
+done
+
+test_done
-- 
gitgitgadget

