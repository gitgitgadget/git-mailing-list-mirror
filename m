Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B70184524
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571464; cv=none; b=lKu0dgqVt58v32b2OXBGJysHuaiOkpWuWSQm8txmRKaKGhhSD9OXWOyW+ROauPW06K6Q2U3/aMFJFcgxaH2jBeLUPlHpL6+qngUd9EYNH4ypr6EHdXI4g+yEpi1pu5f+fckjRryVuXYaPHr8d55gq1IgtQXB/o0WYcmI1e6mpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571464; c=relaxed/simple;
	bh=sBDxmHmMJWqPY95cIw4iuPmAqnSZ1w7luG1IZrJdPhM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fGYhvu/jJKnooJBWmCHEzV/DGALaM6qfKBPwBoB62qicZYa1n1j30VJMl9IloBeaI7PzUEEVkiEKtpdRNG5ge3/FPqcYv6dBAlSkP+X/fcNtqkBai+aK7GF2YjHOfGxnG+QALmnQ0MDACVFX5OhF8n+fk0M38RO8GcbQzeau5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGIWs8xS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGIWs8xS"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso756569966b.3
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 18:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571460; x=1742176260; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZfgU188EnQL+k3sZE2JE4F3xbk0g4OY20kDa9yr1/I=;
        b=lGIWs8xS0WYIZqEOTPmODpT1ut4eTZQ+GMfYsgupns+607ga96Y1756Omak+z8TVgL
         LNaVDPGgAOXL1IPOkQGxypOXrUz5mdr4wfFtCKMZN8BMXb1a0nRtkI6zq2YEUtomiTOV
         j1wtKRCHRZRCabXQdstnarOtE1XnZK3X+QpCOcLvNeB4i0AlFzqh4i+6f9efRmN6Y+Vi
         GJBoUz7dmYQ8ZuNzYB62M/hDi7CUtrk+tKSvXjOzq7NfIp3Rh1SIgeQruDDxUj3uMCwn
         EpevToJsL9SCNYfL3kWm6tL8UL0H4dIiJZlYZv2JbIsG5SRrcb38VME9HRGtOab33o8h
         0iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571460; x=1742176260;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZfgU188EnQL+k3sZE2JE4F3xbk0g4OY20kDa9yr1/I=;
        b=VovMu4/dy/JJP3g/Z3QAgI5Xbo5ttesxhuwhWkk90xFJxGKJun+8ZvybtiNUvrmZe4
         syVLkzyOR0/10J8DhGbwyqE9j21DKnrtLNVFs/aPkm0qgchb6jJPM1sPlKbVPjO1oSrK
         h7HNgGiE/+cQ5wi2HTFZgoPzw9XBr+A8aQXiqi9pwVOd/5DfazGbfdiTMBXLEYmcpZxZ
         RlleCBiAPQ2KtGqJ4r8S2qKTE+1W6jjf0Hiz+LUM1x/kXvRKmdS1M/yYjEQ/34w94Nzb
         E8+ZbA4seTj0Cd7SBoJ+V2whwqC8W0EQITzbSEUXkfS3DcRr0EPxk1H9hnB6l7SUCCXT
         j+zQ==
X-Gm-Message-State: AOJu0YyC3ow8QMX0OXglkZV5S8AQmZYlhURioeun1H5Bzmz1fYE4wsbY
	C0pC4OCmkoeXcmbTzPGCURT+i9mN171qizqldwszSEAAW33WALqy3eTXOw==
X-Gm-Gg: ASbGncuSg9jzfUinTKsQnd5u+SUOd2Er4OBFTCjVwEnpfTogK9hxIi4SESqqGKf2oAS
	vu9SS3t7dY9ufpGVG2Iui65UkkIKtHVn57Gx52gM0OYrXYkT0jy6+VnXY1QZXyRNmmaTx4daElx
	dtuebbYddTCQAO3b8/NrB0vFQgCUFM8ku8L2pdICcX/+71v8UVA9Qu2xiLFPUf1KVKQayTpjkaF
	pS55BMSoU7DaG3g3Ep1D/h02T2z6yGAEvM0IgRcW8+yUrAGfvlLeqA4imI3YIEQNO6EFQiRUN6N
	Xor18C4RWkHGjK4MM7qDVY5/lpAsQVIVMB2gR4nPegYqpA==
X-Google-Smtp-Source: AGHT+IHq2SSGDxxDEws3NG/Lr6XbNL1fUxMogOzoDkeS9NTJtAG9dEJSLYXkD0D/egfJlfiIdar2Mg==
X-Received: by 2002:a17:907:c302:b0:ac1:fb60:2269 with SMTP id a640c23a62f3a-ac2526e5e9dmr1349026666b.27.1741571459724;
        Sun, 09 Mar 2025 18:50:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac24ce8f578sm567480066b.153.2025.03.09.18.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 18:50:59 -0700 (PDT)
Message-Id: <de848ebff74b3ea461d6b750454d4b50af23bedc.1741571455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 01:50:46 +0000
Subject: [PATCH 04/13] p5313: add performance tests for --path-walk
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

