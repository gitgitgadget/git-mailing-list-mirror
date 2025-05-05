Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05EE14AA9
	for <git@vger.kernel.org>; Mon,  5 May 2025 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430797; cv=none; b=PEcCgWE4/wxSIdq8guatjL1sbZqAbBCFJalwr8ChE+7tsjHIE+SJ8yE6yKUShZoRDOJOvRVLYP0ecmMkV3ydFLBe+5JImbKsh3PIxNJ8S9P6qhPyRhsFu/gaQkumoRKx/HEDZhXsorJDSO32wfXorno+qNXvdl5xTudDa4aQrkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430797; c=relaxed/simple;
	bh=//K/7Q113f4YN6LYwbjjyHsgduIu7ASIQycjFyjRTlw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RlxAMqeNVEbVWwMEP2GynfPn1ARwf2YveWCCW9rOEXVA3OA0i86Z/o5akxxwYjtieneAzpE6IvhFqm03REn8pF6gOuhzM34cmOq3XYDXHgYSRFJZ0Risl0cmSOvVwoxP1jOCsiVSAu8rR8FerI9Vv37J9mZugtOcUB4/ysWIBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdKVWmXj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdKVWmXj"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso3691260f8f.0
        for <git@vger.kernel.org>; Mon, 05 May 2025 00:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746430793; x=1747035593; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yd5wprasinVij3lvFq0et6jweRQ3pDUSxx/3y1k+j9o=;
        b=ZdKVWmXjM+tfPhbmZRyB6qWGO8RqpJd9CizY+wAVu5QLNsOdnv7Mkr2AAsq8vI5CsA
         BTmeW7puWn//udnL/kBuzJi0nZ0/g+8XZT5py9wJ9lREfTkEkMBYKx/YepbtFVHyPUH1
         n9YtuDULvAhBO2FejijyHVJ1+MyjQyYv+2xldN6Z3d+yi425VUTW6KY1uUwspYB2++4Z
         MRCWxYin1uwN5Apy9F3weQyPPRMfWQklTgPPeOC+Ili6GDMWT1AsixOv0+Lm2xEFtEMN
         rgEiqazBi/sFMn0TAYHWfW5KqzaYD7dXBvtXGw9rC7o5Xgu+335HsSThd5tolyRH4LMv
         YQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746430793; x=1747035593;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yd5wprasinVij3lvFq0et6jweRQ3pDUSxx/3y1k+j9o=;
        b=NkfUO5vTItmUOXYKi3Ps561E6PwYmlMImYnIqJdXiz+l3uq8xXRq0WHxoWB3yI9m/L
         DsquQ7V9ZAACXTmlAS++UgS/6EDVlebj5jfiZGiERlvxhnwD04MTKCsOfAna8Ba+ykNe
         3ct/CaivvSl5dSznS5esz3qOuvefD8owCI1SwPGixxaSUhJAozNlq9TfNfJJMtBFe7IL
         z2vWXtHAl4+Yb5u1Kq5PPf1OIVEjam/xI0Uio21AuCmKmY3bf8LzlheOBV63ndg/fIIu
         fO1lsDRM/mqJjUhQ2gRv5/Aj7rkEMniokNkiQCGZlh3LC5rsp3Cu+XAacteRDAViRy2f
         S3IA==
X-Gm-Message-State: AOJu0Yzl4qh9VmyKoTq1DqEMZoEiInEgLEOMBg21zZ1LsPzqy+WI9o/g
	TzXdIgTwIw8fpcqUTxBfyCnno7KOH6kM5pBTz5HPyYgXVMPq6DrMgWUhiA==
X-Gm-Gg: ASbGnculXsj6THFwIyJbOooP6fDiAHOz2RQq0ZsL4oeatuWvXhVTYxemUbA3JVyOpPC
	MJA13/t9RnBFhq+s1vf/NT/kfKwF6UyX9X24X7AemrAuZJ2a3nH/xSyypVhpFHZ0PTQmlzJxNL9
	z8jnFOJROqwG84JIeTRxZXMnqrzRTLq3Z+IbC8hL/jsk6KyE5NHDBaH4bbUfY2uSueeaJBmJdnT
	7rTozImpFpxq88qwlWLzrQxu+YmTjBD4f4faiw/rPcTKf61VTpU4FB2/imiPQJuek6n+hf1KWo/
	LWFIExWmVrXp218C/SHswjQ81AbzPWCr1gc3MWytxxbblcNR2S9z
X-Google-Smtp-Source: AGHT+IF/T0g9iw9RigsWs9UBP3SGqg47sRpAety3BhmmLT8NV51xjKajtWeLTAcP7xw+vJ2KlsM6yA==
X-Received: by 2002:a05:6000:1a89:b0:391:4914:3c6a with SMTP id ffacd0b85a97d-3a09fd80e55mr4320172f8f.29.1746430792621;
        Mon, 05 May 2025 00:39:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0ffd5sm9554081f8f.70.2025.05.05.00.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 00:39:52 -0700 (PDT)
Message-Id: <44e4012d03b40b5abe552e6ab51f1c8361af1597.1746430790.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1916.git.1746430790.gitgitgadget@gmail.com>
References: <pull.1916.git.1746430790.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 07:39:48 +0000
Subject: [PATCH 1/3] ci: stop linking the `prove` cache
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is not useful because we do not have any persisted directory anymore,
not since dropping our Travis CI support.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 5 -----
 ci/run-test-slice.sh      | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index f99b7db2ee81..4e1413d3891d 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,11 +5,6 @@
 
 . ${0%/*}/lib.sh
 
-case "$CI_OS_NAME" in
-windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
-*) ln -s "$cache_dir/.prove" t/.prove;;
-esac
-
 run_tests=t
 
 case "$jobname" in
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index e167e646f79e..0444c79c023c 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -5,11 +5,6 @@
 
 . ${0%/*}/lib.sh
 
-case "$CI_OS_NAME" in
-windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
-*) ln -s "$cache_dir/.prove" t/.prove;;
-esac
-
 group "Run tests" make --quiet -C t T="$(cd t &&
 	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
 	tr '\n' ' ')" ||
-- 
gitgitgadget

