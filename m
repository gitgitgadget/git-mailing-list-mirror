Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B279261387
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829780; cv=none; b=jxMIUDw8WWVPHQU8P1UxLjZf1tGSJPXMZHqAN2N2TtEzGMC8OLiRGuTYL06Qh3PGsbKHh8+DWFf4keaTt+IxmKkmgRDZ6dH+6WrGOK7Woyt/vKSuqGIbhHrun/LatBEktSnaHkfHmNmMA5wViR7DD3f8zeXTIhcyYF0EilR1itA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829780; c=relaxed/simple;
	bh=sBDxmHmMJWqPY95cIw4iuPmAqnSZ1w7luG1IZrJdPhM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c2p6jT7L1AN1JcEi2D+PCuPmX6EqwR+AHRRUCgUsRpkm8rws39mOT3xOL8nLfjTZs7g/5Dek/OUoUlUxy3wbrCUL05tWoLZJ89Og/tZdBbPVPkHAOxbHjKblMf9+QRZATM0xwhpK+VjgoBJUR6M0yuYhKq1+4qDAMnrZqaK0+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtEM9xl7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtEM9xl7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfe574976so25944495e9.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829776; x=1743434576; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZfgU188EnQL+k3sZE2JE4F3xbk0g4OY20kDa9yr1/I=;
        b=QtEM9xl7hXF8RuUzfDLszT5BXiHGA/Zpi5KmlzPxZVMWPfihakF9eD7UjOWkjQTZdA
         IXcXmu9ONHUeJzUXo2AyQq0D1tmAGWggmS1/rhDFnR/5oGAJqdYD+Z/p5LhaO6cILsWZ
         0LQMuzLcoRECYScYRHWz3z8R32o17xeEDvLmBdT1nK1ORKkMiTgCDwcYVjTLE0qcUGjT
         A+8oXRUls9YV1gLHPs4Jb7st5zvebRgbm3e2htQwNits+DBpYBr+bUGs2VssBflltBnY
         DFjybugexkRZDbHIvVWzI0tvUAAoOTeW7Q0NoII7EqlQjjhWuhRS7ntxWhsvJraLDECE
         zvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829776; x=1743434576;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZfgU188EnQL+k3sZE2JE4F3xbk0g4OY20kDa9yr1/I=;
        b=PduOsLyCRTMimqRhRcsaL5a/ZfUungbd5u300aVBj0aiGiJ/zX+0e0lbVpI4ZIa5kJ
         UTlAVfuS5AfMEMOvgWIBRXF4R9m2BnhJ00AL7+dgHH7kLGHtE3zAyQ+GyiDuntmyO4xA
         hdhVQ9qAVgriVf7xeff/Q3hsj9bAMwf9eJKmoT0iQkwq6suFbU+oVdV7a+9SI81raDA0
         uNQGwq2wsgpxKKVqhpiPIam+dAunUTN6lK0EcpNDXo45JY6ioPU/dzzvVBtyBgP3fXU8
         0jE379Tl01ey9M4l9xwp2gYYufpi5S60/nTkJVQgXGwdmGY/AoOZH70h9bdGRBfzFK2H
         YNsQ==
X-Gm-Message-State: AOJu0Yxo6kQeOeXnloKgIJmlvRR/fjTv4ZJKxzoE4ezCLnz2dpVEm7Xq
	NRkhIpuDkqj+nddhiMstq2UtAABcc5D5pWs8WQo5lBRJELQfWZmB/GmzBg==
X-Gm-Gg: ASbGncuXhN+QptpC/g/ttZ977Inylp2inRixGmOnaRld7YYIaE84rmi13hvSytD9Yme
	Rvr8Jjn5obsNn04odKnMr+O7lbM8eDx3awOWUukaDhC+nKw8Q1PoXdca1LMnPJilZDqPtpwTqm8
	hYjMbk2qPUlF3lR7XmYhU/wlrwFQH707RK2YLZleoXROCVN8OnT6m3DUR7W+lPF1kwCfjPXiACH
	KAGjaBuCdyAabbf4sLPiKhIc0G0L+rwU8lOtNP9d7yyvmUyo3buTf4Abh57XrmKLDFYiDEGVPFO
	/QqSDwZYmNX9rw+JFtZMPCBqmM7llnPYv5Aibh8pUeeKGB3YyjSFhanb
X-Google-Smtp-Source: AGHT+IHlTp5aedK2ISIP5UUBfF6///UD6e41fgxf0irRPpbd3jeNll6WJ86ujH4vhbcGuHNJQ07xmg==
X-Received: by 2002:a05:600c:1d8f:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-43d509f44f2mr137927655e9.16.1742829776119;
        Mon, 24 Mar 2025 08:22:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceafb7sm126896015e9.1.2025.03.24.08.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:22:55 -0700 (PDT)
Message-Id: <97a0b52ccee8844c1c91232c625c2c6444873d85.1742829770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
	<pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 15:22:40 +0000
Subject: [PATCH v2 04/13] p5313: add performance tests for --path-walk
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change added a --path-walk option to 'git pack-objects'.
Create a performance test that demonstrates the time and space benefits
of the feature.

In order to get an appropriate comparison, we need to avoid reusing
deltas and recompute them from scratch.

Compare the creation of a thin pack representing a small push and the
creation of a relatively large non-thin pack.

Running on my copy of the Git repository results in this data (removing
the repack tests for --name-hash-version):

Test                                                     this tree
------------------------------------------------------------------------
5313.2: thin pack with --name-hash-version=1             0.02(0.01+0.01)
5313.3: thin pack size with --name-hash-version=1                   1.6K
5313.4: big pack with --name-hash-version=1              2.55(4.20+0.26)
5313.5: big pack size with --name-hash-version=1                   16.4M
5313.6: shallow fetch pack with --name-hash-version=1    1.24(2.03+0.08)
5313.7: shallow pack size with --name-hash-version=1               12.2M
5313.10: thin pack with --name-hash-version=2            0.03(0.01+0.01)
5313.11: thin pack size with --name-hash-version=2                  1.6K
5313.12: big pack with --name-hash-version=2             1.91(3.23+0.20)
5313.13: big pack size with --name-hash-version=2                  16.4M
5313.14: shallow fetch pack with --name-hash-version=2   1.06(1.57+0.10)
5313.15: shallow pack size with --name-hash-version=2              12.5M
5313.18: thin pack with --path-walk                      0.03(0.01+0.01)
5313.19: thin pack size with --path-walk                            1.6K
5313.20: big pack with --path-walk                       2.05(3.24+0.27)
5313.21: big pack size with --path-walk                            16.3M
5313.22: shallow fetch pack with --path-walk             1.08(1.66+0.07)
5313.23: shallow pack size with --path-walk                        12.4M

This can be reformatted as follows:

Pack Type            Hash v1   Hash v2     Path Walk
---------------------------------------------------
thin pack    (time)    0.02s      0.03s      0.03s
             (size)    1.6K       1.6K       1.6K
big pack     (time)    2.55s      1.91s      2.05s
             (size)   16.4M      16.4M      16.3M
shallow pack (time)    1.24s      1.06s      1.08s
             (size)   12.2M      12.5M      12.4M

Note that the timing is slower because there is no threading in the
--path-walk case (yet). Also, the shallow pack cases are really not
using the --path-walk logic right now because it is disabled until some
additions are made to the path walk API.

The cases where the --path-walk option really shines is when the default
name-hash is overwhelmed with collisions. An open source example can be
found in the microsoft/fluentui repo [1] at a certain commit [2].

[1] https://github.com/microsoft/fluentui
[2] e70848ebac1cd720875bccaa3026f4a9ed700e08

Running the tests on this repo results in the following comparison table:

Pack Type            Hash v1    Hash v2    Path Walk
---------------------------------------------------
thin pack    (time)    0.36s      0.12s      0.08s
             (size)    1.2M      22.0K      18.4K
big pack     (time)    2.00s      2.90s      2.21s
             (size)   20.4M      25.9M      19.5M
shallow pack (time)    1.41s      1.80s      1.65s
             (size)   34.4M      33.7M      33.6M

Notice in particular that in the small thin pack, the time performance
has improved from 0.36s for --name-hash-version=1 to 0.08s and this is
likely due to the improved size of the resulting pack: 18.4K instead of
1.2M.  The relatively new --name-hash-version=2 is competitive with
--path-walk (0.12s and 22.0K) but not quite as successful.

Finally, running this on a copy of the Linux kernel repository results
in these data points:

Pack Type            Hash v1    Hash v2    Path Walk
---------------------------------------------------
thin pack    (time)    0.03s      0.13s      0.03s
             (size)    4.6K       4.6K       4.6K
big pack     (time)   15.29s     12.32s     13.92s
             (size)  201.1M     159.1M     158.5M
shallow pack (time)   10.88s     22.93s     22.74s
             (size)  269.2M     273.8M     267.7M

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p5313-pack-objects.sh | 37 ++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index be5229a0ecd..cd6dd3abb71 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -25,46 +25,55 @@ test_expect_success 'create rev input' '
 	EOF
 '
 
-for version in 1 2
-do
-	export version
+test_all_with_args () {
+	parameter=$1
+	export parameter
 
-	test_perf "thin pack with version $version" '
+	test_perf "thin pack with $parameter" '
 		git pack-objects --thin --stdout --revs --sparse \
-			--name-hash-version=$version <in-thin >out
+			$parameter <in-thin >out
 	'
 
-	test_size "thin pack size with version $version" '
+	test_size "thin pack size with $parameter" '
 		test_file_size out
 	'
 
-	test_perf "big pack with version $version" '
+	test_perf "big pack with $parameter" '
 		git pack-objects --stdout --revs --sparse \
-			--name-hash-version=$version <in-big >out
+			$parameter <in-big >out
 	'
 
-	test_size "big pack size with version $version" '
+	test_size "big pack size with $parameter" '
 		test_file_size out
 	'
 
-	test_perf "shallow fetch pack with version $version" '
+	test_perf "shallow fetch pack with $parameter" '
 		git pack-objects --stdout --revs --sparse --shallow \
-			--name-hash-version=$version <in-shallow >out
+			$parameter <in-shallow >out
 	'
 
-	test_size "shallow pack size with version $version" '
+	test_size "shallow pack size with $parameter" '
 		test_file_size out
 	'
+}
 
-	test_perf "repack with version $version" '
+for version in 1 2
+do
+	export version
+
+	test_all_with_args --name-hash-version=$version
+
+	test_perf "repack with --name-hash-version=$version" '
 		git repack -adf --name-hash-version=$version
 	'
 
-	test_size "repack size with version $version" '
+	test_size "repack size with --name-hash-version=$version" '
 		gitdir=$(git rev-parse --git-dir) &&
 		pack=$(ls $gitdir/objects/pack/pack-*.pack) &&
 		test_file_size "$pack"
 	'
 done
 
+test_all_with_args --path-walk
+
 test_done
-- 
gitgitgadget

