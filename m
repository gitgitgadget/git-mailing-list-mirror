Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650CA3C0C
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181675; cv=none; b=d63UhTcUDcQRqvIrpWKhCsxBnhBt0jIf93zOBTmZN6dwtwWFJDaH2jvdlX1bZB/0bWHBiW3QiWLP7pn4rPKRubHJJ2Tksf2uPWZCtanbaUASmSL8FV5OzqQJHtcQhbE8co+MvXCfDr5d8Mx5LNKjJ6XBNoeWdDscUQhMk5pzIs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181675; c=relaxed/simple;
	bh=ZWN2MYGjP1xdqTTsLBMoU2agzEliXWhudqtojn4xsCY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y2lwH7DU3cNVrDZEOihZnzpRjD5aqCKIBFNC4WPEErqmVlu3oXslmz6lbHycWozDaTtmYY2V2avxZylI1pH4m4IM2ETCb1ik/OyK6WrpyH+9KHNKl0yI74qObqR9wqZgffYgXcT8Ti8ffkaPDb9QSaDbl7KQitjTDLndIGWq13E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i34Y/EHB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i34Y/EHB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf848528aso20981905e9.2
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743181671; x=1743786471; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGr/XzAg5R3LfC3ivsucjN1QW7T4+QNbAHtUXfPMwc4=;
        b=i34Y/EHBSuS+kIMgZuq/7vfbLmtkeV4hxxKgfURuJ0Jfs+sA4Y/668FYA8AtUnXLbc
         XjcTXUCXBvGGlLYsX0nBR+xaJcDPCS5OJENkaYHGPi6BTGqBRqkA3/FHfiKFC5c75U+V
         On26Qn4PM7nJqCRdRVavJ1UrwNe8aKIiIIYWNUKT9U/LS0LTe/AFC6cxA53UCrvHfWaF
         +dFefqFPbpAPzsIeiAzE46BMQ53Po34onp8ApznAYMF5LGVZQTSZVf4lwIC4E/HvDdDD
         SjU8gugrpYM0mVm8KXwJMErqCqr1EhfuipAfrb7hwb27xS+9vx2uHIV722J+v6yQDuKk
         jW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181671; x=1743786471;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGr/XzAg5R3LfC3ivsucjN1QW7T4+QNbAHtUXfPMwc4=;
        b=IeAgtQ1AJAv6da+uBpCY/2NG/eQCd+XS9l00wdkhY7OjTia2VmKHGPsCfjEGuOiQzo
         8kW/VuDUWtRMmySw4sNoDX8mMCCDXSKZrGRhPBd97m83RuVOKgHoVCanM/u04VIjih+D
         8WYCSZnagiMpZSc/CKCyW2YXcRgaxLqi7YHuTyN9gLTlI3cRtQhfD/AmIBTnKHEf/cGY
         BgYsbZJxYc3QFemflNIQF1kncHruQL3GEn8HtPHEvL7KwrtjH3b/fhYKZEZSFofMTUDO
         8eoO0WrHk3cxu5F6J9klZ2XunMC2nUeIY0yPfTzdSOrKHdKAkFB8F47Ggzf3Oja6c6vv
         R6gQ==
X-Gm-Message-State: AOJu0YzH/wcMrQPACx089r9m5mmdkmkq6dIvuGYWtfeVguSrMu2b+x3O
	RrfEAUju+oDyY3+cPHD9/5slFuG1XTctNdw/9Sa3mRE9agWXLb64JlD3fA==
X-Gm-Gg: ASbGncvRHQpxocjIo8PK8zfeIBsQp8hGn6X74EKprzj4Zp8pcaAmeuR6yJmMN8VXDyO
	9Fo8KJYf0rd3NsxsUcvLZp3GZMJox3UCEGyCC+Zh/k3AbQekr6/VcGGHy0wYNWQWxNd3A431SZs
	hjUOagO84/8KcrWJhDNftBpwperHvSZa7ipJ2tfXO3T7Ghw5lFCF4tRPqbqOMItRR/oQrYMbtXr
	QNyI+NbCkk0bJV2SZ67yvAtDJEmRuEv3DTmDq+YH1wMRRZiN4oiM1RSHxioh4zz8K4RhxiooWcF
	QJQS0ZSsi3QuFlvTjGG75Mw/vq55RbyHEwfRN1grzGz4RQ==
X-Google-Smtp-Source: AGHT+IHczGor/Go0ej0TxgN+anwWNuqRDpfOXKcFi69oQH91odJaMzJX1seQKw/IHSfldtS8qTRVhg==
X-Received: by 2002:a05:6000:2a10:b0:39b:fc63:474d with SMTP id ffacd0b85a97d-39bfc6349bcmr3591009f8f.54.1743181671218;
        Fri, 28 Mar 2025 10:07:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6630a3sm3166183f8f.30.2025.03.28.10.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 10:07:50 -0700 (PDT)
Message-Id: <41a093d570a5756f730b069980edafbcedf5c8bc.1743181669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
References: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Mar 2025 17:07:48 +0000
Subject: [PATCH 1/2] p7821: fix test_perf invocation for prereqs
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
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since 5dccd9155f (t/perf: add iteration setup mechanism to perf-lib,
2022-04-04), perf tests need to declare their prerequisites with
'--prereq', after the test title. p7821 was forgotten in that commit,
such that running that test on a machine where the PCRE prereq is not
satisfied aborts the test with:

    error: bug in the test script: test_wrapper_ needs 2 positional parameters

Fix this by correcting the two 'test_perf' invocations in that test
suite.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/perf/p7821-grep-engines-fixed.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-engines-fixed.sh
index 61e41b82cff..1d126c7b039 100755
--- a/t/perf/p7821-grep-engines-fixed.sh
+++ b/t/perf/p7821-grep-engines-fixed.sh
@@ -33,13 +33,13 @@ do
 		fi
 		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
 		then
-			test_perf $prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" "
+			test_perf "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" --prereq "$prereq" "
 				git -c grep.patternType=$engine grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine' || :
 			"
 		else
 			for threads in $GIT_PERF_GREP_THREADS
 			do
-				test_perf PTHREADS,$prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern with $threads threads" "
+				test_perf "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern with $threads threads" --prereq "PTHREADS,$prereq" "
 					git -c grep.patternType=$engine -c grep.threads=$threads grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine.$threads' || :
 				"
 			done
-- 
gitgitgadget

