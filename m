Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3F1624DD
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945539; cv=none; b=DA8necN70fZVRBq2IZyV2amJQrKTjGTlAlbmTYkdB3MsUQTvx2tqAcoN/2YEiGf24oGj2yEE3vdRPDaVdGLeSnKumKh/C0EELxJotcnziF88MKMIihZahfr0pEXIhqVVVLD5ocetFU7O5u64XqQewzCHis19r6MqKznuKciqr/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945539; c=relaxed/simple;
	bh=zmhtj8xdk7E8nqZx/ConpHcVUbHxD7ZUD6EO3RI2Sto=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bIoFpk2XQt8PtQwWoxfK5NrWNhdSws27rWbslardnrjZUDBbhzbmmn7+EbyEp/4HjY/uSOa0CGMnjGdgK+z5x/VIFRYUvhNNWXUaUwU9Kpg4IxAVTXPpX08xaxhcF8hY5uN2TW27hsr8PfoKiIwKOnx+JTBUcCauclyYvfOJJC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiMlz/1n; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiMlz/1n"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso64733385e9.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742945536; x=1743550336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzIKdN2kDr2e0llXMXL0fcKCtEc6/zaLRTXhEVJa5Bw=;
        b=OiMlz/1noaDVhuUkvPwxVMTTKgARPTJdRI91C2QsIg9JB/v4gP+Ad/v0BTuTNpKkPq
         rIrNejwVegiSUkxgsE4wj5tTF+bkXfn/JJYDRvs3dJUZHeKzuAym1yFug6Umj/dgwGvR
         43p2hSVxxOAdYu1DpAMssGvspSO4IuF0qOP24Bg7ejzSkDQ+FTVE0kJkaZB3vqGMn3Fp
         uBFWO+t3T48jNp8IVT4FnQGbb0SRneM9aAo25TlRXyH1JwJIQgoux/S5yZlxP84c0bWi
         eY0VuCarrB6DVTSv1kP3QWD2YNchqJhXe92MY76szOQS5BMFDuW1SkezNXGqqzmDY5xx
         oS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742945536; x=1743550336;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzIKdN2kDr2e0llXMXL0fcKCtEc6/zaLRTXhEVJa5Bw=;
        b=oYBclUyx4V/q5qIVtSDKnvKu+e1C2fmUOLqhnI+iM2M91KznuepdJDnlS6RZXucPxF
         2zwHhWoIDVCS38EgFx1JDrmCLGgBZu9FeJRU4TZq372LrZiCRtcdTpO8dsAa9bBBpr98
         hOksAoiRsF5g76eaUXhlTFdtqdeKXJOzZQEhBqTCmOm85tJNJ/NlFWJ+Idz5aOLbbuBX
         dDHOJWpJfC9QAszzFiyEiEo7gKX+NtnoXWu65EYTT0eUMmbz/g5MEHeyKDqMO/tc8uzN
         lz9UpnYMfe08/Xu3kRUzygmHhXzLUEvjyK8YaBvUNLr+2A6zYbHD8AoxRLU4o1Xc+ynR
         94tw==
X-Gm-Message-State: AOJu0Yx03yRxI8Z+rg2as9YMaiFnDh0Zhb4V5RxHv69D96tnnD4LMSs7
	yl+RW/+bXKjBbeKZ3q8ltAbTAA4FbbUmwm1BPBexzVVl6gbI8Kxmq4IVqg==
X-Gm-Gg: ASbGnct9sHgpfxVptiv4K2sJXLttpTfZz70pnjG1ytX5XkHdsiY8+4BJqgtAX5c447E
	d7cdsQghf8fc9KDzi4/CFn0mp27J1Ea8OOBMFOabp/KSlSW1g5iFlwLcqIODX7vBmgoHDThsuPO
	pdfuTRhqitle8FFXW6YeceHyTUriv2K31e9aYV6Dz8whnSkYTcI249N13crG5TJwqMXk2K7FsfI
	oltltJEQQVxwO3RuecsjfEeuXIpZYbCXzytk+TZvlw1J2HiKmAp3p4VbzvL8Fmy5esORJ4bzgKX
	vXeZGvyovtTNZKON/s+5MCVGYFF4cIPNsKjqsyXTL7ghqA==
X-Google-Smtp-Source: AGHT+IF+QOoJKkysp0sErm8wwAxIVEMv2hvdp1jfRbqyQGfqzxiS0YFF7tpO/eo/nSGcTSiQNr6lMA==
X-Received: by 2002:a05:600c:138a:b0:43c:fa0e:471a with SMTP id 5b1f17b1804b1-43d509e339fmr172936885e9.5.1742945535744;
        Tue, 25 Mar 2025 16:32:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fcea400sm165717155e9.2.2025.03.25.16.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:32:15 -0700 (PDT)
Message-Id: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 23:32:04 +0000
Subject: [PATCH v2 00/10] Avoid the comma operator
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator
[https://en.cppreference.com/w/c/language/operator_other#Comma_operator] is
rarely used in C anymore, and typically indicates a typo. Just like in these
instances, where a semicolon was meant to be used, as there is no need to
discard the first statement's result here.

Changes since v1:

 * Use -Wcomma when compiling with clang and with DEVELOPER=1.
 * Address the remaining instances pointed out by clang (and by Phillip).

Johannes Schindelin (10):
  remote-curl: avoid using the comma operator unnecessarily
  rebase: avoid using the comma operator unnecessarily
  kwset: avoid using the comma operator unnecessarily
  clar: avoid using the comma operator unnecessarily
  xdiff: avoid using the comma operator unnecessarily
  diff-delta: explicitly mark intentional use of the comma operator
  wildmatch: explicitly mark intentional use of the comma operator
  compat/regex: explicitly mark intentional use of the comma operator
  clang: warn when the comma operator is used
  detect-compiler: detect clang even if it found CUDA

 builtin/rebase.c              |  2 +-
 compat/regex/regex_internal.c |  7 +++--
 compat/regex/regexec.c        |  2 +-
 config.mak.dev                |  4 +++
 detect-compiler               |  2 +-
 diff-delta.c                  | 12 ++++----
 kwset.c                       | 54 +++++++++++++++++++----------------
 remote-curl.c                 |  4 +--
 t/unit-tests/clar/clar/fs.h   | 10 +++++--
 wildmatch.c                   |  2 +-
 xdiff/xdiffi.c                | 12 +++++---
 11 files changed, 65 insertions(+), 46 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1889%2Fdscho%2Fcomma-operator-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1889/dscho/comma-operator-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1889

Range-diff vs v1:

  1:  e3069fd4564 !  1:  913c7a0d296 remote-curl: avoid using the comma operator unnecessarily
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## remote-curl.c ##
     +@@ remote-curl.c: static int fetch_git(struct discovery *heads,
     + 	packet_buf_flush(&preamble);
     + 
     + 	memset(&rpc, 0, sizeof(rpc));
     +-	rpc.service_name = "git-upload-pack",
     ++	rpc.service_name = "git-upload-pack";
     + 	rpc.gzip_request = 1;
     + 
     + 	err = rpc_service(&rpc, heads, args.v, &preamble, &rpc_result);
      @@ remote-curl.c: static int push_git(struct discovery *heads, int nr_spec, const char **specs)
       	packet_buf_flush(&preamble);
       
  2:  7dfbdc48954 =  2:  37ff88b8275 rebase: avoid using the comma operator unnecessarily
  -:  ----------- >  3:  f601f4e74a5 kwset: avoid using the comma operator unnecessarily
  -:  ----------- >  4:  f60ebe376e1 clar: avoid using the comma operator unnecessarily
  -:  ----------- >  5:  7239078413f xdiff: avoid using the comma operator unnecessarily
  -:  ----------- >  6:  5e0e8325620 diff-delta: explicitly mark intentional use of the comma operator
  -:  ----------- >  7:  9a6de12b807 wildmatch: explicitly mark intentional use of the comma operator
  -:  ----------- >  8:  dc626f36df3 compat/regex: explicitly mark intentional use of the comma operator
  -:  ----------- >  9:  91f86c3aba9 clang: warn when the comma operator is used
  -:  ----------- > 10:  2f6f31240fe detect-compiler: detect clang even if it found CUDA

-- 
gitgitgadget
