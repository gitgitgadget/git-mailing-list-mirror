Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015326AA94
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945549; cv=none; b=ZDgqYU0UEHFKCwYy8lcYNlRR1avhvN0j3YbFz8Gzc9uN87FONZtQxuPIERXyi+i7nBtbbVaQVCF22uxzf27A8+mNrbvnSApfAv62bcvXfFyLc4s626NtVKCfGDpuTHyVDrV4/nMNUIpLKWJ/giSni+20DdV3EPi2gKE/tk5L+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945549; c=relaxed/simple;
	bh=iRwIeu4aNkIDlaA+bXIdED/dHydBvNrnAhLlbcF4Ozg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=THRHFUlebUKWBrbYBEX94lRvfXaCWI0DzVw/ZzKbw1YFqrAAWi+wWm6m3LF8J8PWlTmOyg1LSB5EFpvdUzHVSX7a/nKmAjmNxeFPzdDSKvz5Xtps+GqWn7cmxKQrNnmfVTXbf4hEG4kkFaEmwCHjKXgwl20J1UESV5VsFRqDi/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDMAgXSq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDMAgXSq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so1976475e9.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742945546; x=1743550346; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYkXSbdsNk8toO4gnz5+KubGjU0Tchu08ZiuqSR93UI=;
        b=LDMAgXSqnX7blo3+QICcpj9TMvqboNwbETPbRufuIHTQk73/+gb1y1FBIixJ+trt0c
         s2ary7sYPOo9QKCPe9f8HtSYeAmabxNZSRpwPAJVIQJOLJSv9kXYg17BtWbXy9pXWd4F
         FPfnF/sp6Voc96Ri2fHzgJsYmsKbZCstRMYOZA0eo2NdZV8SvPeFWk7AS6wUDMPryMEj
         zmOdiUW1kaZ7g2QrTnFqXnELnPykBes1aBkMIf5c2ngI98MmT46j2PgL7Dzu9YBjpKtx
         +6OUsdwPbR93ixCwQcsPfThsu1XpvF0KcSyMvV7naa/gfEJ6NOl3VxibRSobRJL7/RK0
         rWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742945546; x=1743550346;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYkXSbdsNk8toO4gnz5+KubGjU0Tchu08ZiuqSR93UI=;
        b=C9HoHAwH66rec0tOzeQOYyv+/qzxM3Szhdqwj2NRu7ddqJbly46qdZOOGGePiKVEX+
         6XPf8wBfkdtCGolm/r91pyvysanya6RMaPejlYMkvfDuKgMES4Ay8VHKxWuyPMrFp2jS
         wsYBI6GKfbgm3S3x98LN3XvY28ZqvxHNxFdyWH8mfCmGcCqZ486fPBxMZJvjkaqpVdyP
         Ki1kUqlj6N2yG0pdltZB3bw/iRB2zyYjDb7g1ti2S3I2ipuUf46PH9bC/vS2DOohw7vE
         AAgTk2jzGvIBEMsYr/gRPlco4mkw4YSEr5BYMoxC2t2h8csICYsfdkmiMTeqxrygnT+j
         KmtQ==
X-Gm-Message-State: AOJu0Yxgky2IQf1VpHhIDsh9Jw/FEwpgqbvFm81e4Dqvk9iY8FPlVLHi
	wrHx5BmgslMB2SttqJlVbKh9iXJVyEPcxoIBDvMfbr6zh3YopIli0Ghayg==
X-Gm-Gg: ASbGncvR9diAm6oB+F2haGq3eILSQ7BHTp4yI14+ktvXWsVD5nDvALa/tuL4S9XiP6W
	x3q8RjWegPHSGrGAPnu8iLu1URIVze0WNzBmkMEW4ArtkOTKL2wx5nnr9FyS1ti1cfCvYaJ4KP+
	ee1FHRRWV8ugGMDXVvXQtZx8EfoHWOu8Kxo7HID6tT2zpy/xAhL2c54kogfKpxLp4YTvNzpeVSs
	q1VJDk6PpihCR9GBvlzDPCQAM/HbuF6Rs9LLx3emQpQCg9hqPJCon3slhUeDDq0047kbJNv4bjI
	V697gIMbrdi+I6q8zltPWCQhZVYn26kI//d/mPBDlpsEIg==
X-Google-Smtp-Source: AGHT+IEYPXGi9//1wWmdMMQl51DwdJNhtSuvJTi3xINT7YVOqr14hPBPQ8hnkIpD1cjMBvp8IEGVbg==
X-Received: by 2002:a05:6000:18ae:b0:399:6d6a:90d9 with SMTP id ffacd0b85a97d-39acc46dd97mr1353349f8f.18.1742945545442;
        Tue, 25 Mar 2025 16:32:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f934812sm15065403f8f.0.2025.03.25.16.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:32:24 -0700 (PDT)
Message-Id: <2f6f31240fe6ce5f8efab662af477540a0f966ca.1742945534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
	<pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 23:32:14 +0000
Subject: [PATCH v2 10/10] detect-compiler: detect clang even if it found CUDA
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In my setup, clang finds `/usr/local/cuda` and hence the output of
`clang -v` ends with this line:

	Found CUDA installation: /usr/local/cuda, version

This confuses the `detect-compiler` script because it matches _all_
lines that contain the needle "version" surrounded by spaces. As a
consequence, the `get_family` function returns two lines: "Ubuntu clang"
and above-mentioned line, which the `case` statement does not handle
well and hence reports "unknown compiler family" instead of the expected
set of "clang14", "clang13", ..., "clang1" output.

Let's unconfuse the script by letting it parse the first matching line
and ignore the rest.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 detect-compiler | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/detect-compiler b/detect-compiler
index a87650b71bb..01eca3a781d 100755
--- a/detect-compiler
+++ b/detect-compiler
@@ -9,7 +9,7 @@ CC="$*"
 #
 # FreeBSD clang version 3.4.1 (tags/RELEASE...)
 get_version_line() {
-	LANG=C LC_ALL=C $CC -v 2>&1 | grep ' version '
+	LANG=C LC_ALL=C $CC -v 2>&1 | sed -n '/ version /{p;q}'
 }
 
 get_family() {
-- 
gitgitgadget
