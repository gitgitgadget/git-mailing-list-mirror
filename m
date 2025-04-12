Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84D20E700
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744481742; cv=none; b=NJVOotYPWGq6Oi9MjX9sFnksSykGPIUqwl91snutGt1fcZjAMTcygBi5BqBGKKgSs2Mo+RG7ZztREJXVyfP+KZC4SrcraW4mjntZCBdcDgB+kPvGkwH57mtKCHhDxf7kwOELNBo/lBpIZiprX6D6MgoJD2c3VL20ijBThg+xvbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744481742; c=relaxed/simple;
	bh=/1GGV1Qxw6FOdAnPdrOShuNArgDPMP1iH0zTs6PP/Vs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QnecTPkf+U/inUuq/ZZmL7frAYLxmCncS4jbGivRszSgmPuAKhVKSkyQb4MYZd/QWEGXCabkU8RjS1OM0P2ryxLQlQBA2a8eO+noqs+dCwAQJHefZGITdvdCM5x7wnwcZds207E7DsJG+5cO6+3wO9ZFSyndt4G2u/fNkacbrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UToUTZP7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UToUTZP7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso21094775e9.0
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744481738; x=1745086538; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CNiB59QtV++rMyZzgKRtosaGc+XMgAfRuTQpu5WIQI=;
        b=UToUTZP7cyM9pPk1uSrR+KH+kLqw3cowJDHqG1w29/yKYTuRvU4wKfvdjr7Zu2SEEW
         B5CE8PECHNu8nJ5jNDy0nnwqo8j7lVbESVE1njqjtyW3ObfJe1BvhIIZHpBXnuHUPsrw
         ZKk35RHz4j7ap1m59So7wetk94tpO6Pdz73tthvrNlHXj4oj3Pnoea/kfu5MTpBxB4gU
         secWkX9t+ARGkytXQvCYAOBCJpOuFolRbVBjCWpdsgmGCiX/3nBK2ZMPlTXe9C3EkY+6
         IznElLE3U/UrsmJDMjXSsr/xfWZgK7rLPu9H/ybdggxrQeqJZext9m5akkV2OhXHy5IC
         wE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744481738; x=1745086538;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CNiB59QtV++rMyZzgKRtosaGc+XMgAfRuTQpu5WIQI=;
        b=NNnYSPqQXDMY5AjhOCKpsiqQAjvY5YfMkT1n9vUkX0ddOMnwWMbkMH6BgTj0F8npXj
         xzMvY2mItxx7/bkOqL4G3I2StLapJz/Ms6tXEKCB+5uHs4X/VBvLHfsx/xkcMryyg4iM
         vhrPdaaieSkARJlwbsszpk25tGT0040GJ9av7qCyNPSmihhubRQHVaPY8+6WJk29oBI+
         AvltPXRvEQazkgy2IzpfCwzYUwqSdYsSB90gkxCU3pLcX+R7BFPmzp8NDDSTjnV/DDXe
         r6Mi0PnSOIGX16BpAoHXuOquUpWYli8sSTcjApOHR35Zl42SZJvBZkIrRNuc5xf8X0zR
         xKkQ==
X-Gm-Message-State: AOJu0YwsSf0rAzWo0+dhq2klikTN+gSXLUddqyIJH0Ymq88llNhGH8pI
	Smi7C7aYfInjB56IunWm3m2t/nvByxgkvdWF0ZUeELH2CZFiG0GvDakyAA==
X-Gm-Gg: ASbGncsJoZwl4Kc7pwhAKpGQkoSTXf46Dlxe41bCPvh9fC+27aBnP8YU7GMEKuhbkS9
	GYX4Z0iiKvBgPZJgNSSjI4X7WsnT4cIzXiKYqacsHU+8qe+97K/0K9RNRo4SlA5T3o9lxKfyCUQ
	tcP2QPgzer5WuLDvczp1pWrOW/TrwRAu21AqedgycbkMl3dQy92h+Vshx+6ImloQu4wng/SlzDr
	QHRaZiNMd2LgKIn1reGbVkEEREj071yMwhhGCOat960mbKTqjDdGUE94kx0fHAcHYTfUWJMathG
	UdHuRCtOhHs1UauLrxg+S4L+B7M/00RTE1u0quI+TA==
X-Google-Smtp-Source: AGHT+IGbbnDnFlKUMStCrGVLIeUKU0s/Ge3cW6lP+1BHv85PLNtbeTQZETPkfqIY93MQrK471THJ8w==
X-Received: by 2002:a05:6000:2282:b0:399:7f2d:5d23 with SMTP id ffacd0b85a97d-39ea51f578emr6162999f8f.14.1744481738171;
        Sat, 12 Apr 2025 11:15:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cb43sm5742286f8f.65.2025.04.12.11.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:15:37 -0700 (PDT)
Message-Id: <abd146b7c2a62aaef5c22269cff155387f33fe32.1744481732.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1936.v2.git.git.1744481732.gitgitgadget@gmail.com>
References: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
	<pull.1936.v2.git.git.1744481732.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Apr 2025 18:15:32 +0000
Subject: [PATCH v2 3/3] p7821: fix instructions for testing with threads
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
Cc: Victoria Dye <vdye@github.com>,
    Neeraj Singh <neerajsi@microsoft.com>,
    Patrick Steinhardt <ps@pks.im>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In 7b31b55db1 (perf: amend the grep tests to test grep.threads,
2017-12-29), p7821 was tweaked to test the performance of 'git grep'
under different number of threads. These tests are run if
GIT_PERF_GREP_THREADS is set to a list of thread numbers, but the
comment at the top of the file instead mentions GIT_PERF_7821_THREADS.
Fix the comment.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/perf/p7821-grep-engines-fixed.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-engines-fixed.sh
index 1d126c7b039..66bec284e3b 100755
--- a/t/perf/p7821-grep-engines-fixed.sh
+++ b/t/perf/p7821-grep-engines-fixed.sh
@@ -7,7 +7,7 @@ git-grep. Make sure to include a leading space,
 e.g. GIT_PERF_7821_GREP_OPTS=' -w'. See p7820-grep-engines.sh for more
 options to try.
 
-If GIT_PERF_7821_THREADS is set to a list of threads (e.g. '1 4 8'
+If GIT_PERF_GREP_THREADS is set to a list of threads (e.g. '1 4 8'
 etc.) we will test the patterns under those numbers of threads.
 "
 
-- 
gitgitgadget
