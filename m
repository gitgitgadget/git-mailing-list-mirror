Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7252638B0
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099706; cv=none; b=kSThoYHJ5psUWsC8x/JcVNZxhNlkGkqifEDRexwcHOpWUZmwIvnJdZS+G3SJPz1kCFMFTdmko0eFgh3hBsPtK8K8xjlw5rScq9VV1Uv4VPAdUQ9PqEaIQevVUTdNWHuPlfDKfcUNk5CIUquCRtV3oNFw7OgG33BqF+vQG3PPwh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099706; c=relaxed/simple;
	bh=lKtu0yTseRe3BipvfsJSORCIjoKmJq0XbCc7ZSgygiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/FQqR8zqzZ5x70fANIytzTDGDnP9Ll6UIPhgVZDiz2PBvQRfPIIEoHUcilvILMroUgorY/NPimS3dT3jaueSUINxS2vYcBUErAUjuOnPI725s7DfPHZBY/2wz0tE6GHkl+q/Iq07rIkR8bTs1rJUxr8nL19foF1XQENSvCy7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObHMePpU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObHMePpU"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so696954666b.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744099703; x=1744704503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYomGETYnuaj2vK1ZXN0P/slFz4ExMRa6L0AMNEraXo=;
        b=ObHMePpUgO9epMNa20/bYxa6JMWVLoPiklmQvPIJYAIVr6tQ0ppOmVrq325gYJosGJ
         D68o7jTQkSeqXl5JCBrSAuB3TWbbbhJuRPRwPt47FNfDLSBSlHChEdPi5ucd+D3Vmaey
         gJvqcH1WzsYRUyQ8nHSyCuxqpiMEVS3yBaySWfmd4Fs3wGe0svqXORXRUaIB7NTfRaJf
         GEjb3cPoW3N6txIwjZaAoZqXOE1yhsqeQAOTW6A4N41GPYIIZdQ61ximczd8q4zX5vT/
         llvkeLAHyn3hTkbAMjQGRm3mj6WdQiis6wbzEnu5ouX96pyRhCQk4inUGzU9/6PvZjPx
         qT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744099703; x=1744704503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYomGETYnuaj2vK1ZXN0P/slFz4ExMRa6L0AMNEraXo=;
        b=N2dkykM3dgLAwbKUTS0HunE1z/LHvMZnXP8ced04O3t7vclFEv/4jMIZUMl7PaB+Eq
         5AM1Z4UKIfbfFRqefjx7RO0mSdDmIcMJjycs4e29EuXo0aITCYOQdQl5GMGCLfvbSX0H
         uisHAozpav0l8f5oVfqWuZgzZf54ZVKifpz9GAawfEoomyM9wgX5PZWNMEpybScyrwTf
         do+pOMuLt5TcJLcynqlyALlGDxnZxM6yAr4bcsEyoLbiD8fcMB0SO6owcaPByAf/bpqU
         AtRW1cU+DI98IbY6E9hypF6cdvB3W3Peprny+pHbKDnBBgaM8vpl3wfd6tL+TKzovjQA
         MECg==
X-Gm-Message-State: AOJu0YwcHgvUhOPeRh+caKOLfuqZbNQW6dWm8O1/siZYxAM6pXfhficD
	kXsCxrXxc6NcqsB8joCETDeRasPyz22sXVn9WJeL1e0frke08px7RX2y9eZSOA==
X-Gm-Gg: ASbGncvwFltMhTLW2/br2zXut7ESa4jlY1EivLWSBaoDuT1/EONEsHjdQdJz2Y7IiRs
	bqdri6/WX9HCZ1231Aaw7aDHtfsgD9i28NmcGYcwdIbagFASvRV0XoZz/PBhouN5nYdQjfryaAS
	wbnIj02Bhb2FgcUO2tSDvKga6GPb57p8w+VG4OytJq3t/McKYcQol2w4JpVC0OoThA3zKAh+i8Z
	IuvtZxq5GicGxIn+rocHbCot5CAzJPRYXgTb5lz8Z48KBqmq2FMHXO2uKMMQE64zritbxgovKKk
	qRpx3GZSIF6U6LjnCAaV7628yCYTTxkrmQhA7XaUCj7QMW6UB7NGXY3l20ETB2vEjZra+h/Td6e
	UyIm+Ijr1StXakkbjJTaZlzxTIdeLzjN080S0Gfv7H3VaHFmS/A==
X-Google-Smtp-Source: AGHT+IEaRo+RLwsDHAZTkhc51bB7BBjG2FPnY3bHHFJyURosp712e2aLMNqqsVSsaL9TE86hxXJF2Q==
X-Received: by 2002:a17:907:608d:b0:ac7:82b3:7ad with SMTP id a640c23a62f3a-ac7d198fe5fmr1443132566b.46.1744099702926;
        Tue, 08 Apr 2025 01:08:22 -0700 (PDT)
Received: from localhost.localdomain (host-95-230-249-134.business.telecomitalia.it. [95.230.249.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013fd1dsm880882366b.95.2025.04.08.01.08.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Apr 2025 01:08:22 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Anthony Wang <anthonywang03@icloud.com>,
	Anthony Wang <anthonywang513@gmail.com>
Subject: [GSoC] [PATCH v4 1/1] Remove the pipe following the `git tag`, ensuring the exit code is not hidden. Add explicit verification to check for expected and unexpected tags, increasing specificity and future-proofing a portion of the test.
Date: Tue,  8 Apr 2025 10:08:02 +0200
Message-Id: <20250408080802.56341-2-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250408080802.56341-1-anthonywang03@icloud.com>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
 <20250408080802.56341-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Anthony Wang <anthonywang513@gmail.com>
---
 t/t9811-git-p4-label-import.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 5ac5383fb7..cd06f39519 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -95,9 +95,10 @@ test_expect_success 'two labels on the same changelist' '
 		cd "$git" &&
 		git p4 sync --import-labels &&
 
-		git tag | grep TAG_F1 &&
-		git tag | grep -q TAG_F1_1 &&
-		git tag | grep -q TAG_F1_2 &&
+		git tag &&
+		git show-ref --verify refs/tags/TAG_F1_1 &&
+        git show-ref --verify refs/tags/TAG_F1_2 &&
+        test_must_fail git show-ref --verify refs/tags/TAG_F1_ONLY &&
 
 		cd main &&
 
@@ -208,7 +209,7 @@ test_expect_success 'use git config to enable import/export of tags' '
 		git p4 rebase --verbose &&
 		git p4 submit --verbose &&
 		git tag &&
-		git tag | grep TAG_F1_1
+		git show-ref --verify refs/tags/TAG_F1_1 &&
 	) &&
 	(
 		cd "$cli" &&
-- 
2.39.5 (Apple Git-154)

