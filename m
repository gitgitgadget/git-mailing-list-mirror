Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729020B81F
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308906; cv=none; b=jwKUOlwfaUZ1SnQYrA/hrys63kZz8TVar1kecsE2tKlq1WZVo7NZrVXfUj0jvdbd1eNC7i3bUk6sA4fJX6vlNxEkazSI9JD68/eNGebVsPUSWcwIn3CW6ioPQBFnxostk2cXbZk0+5SRY9RqpaZHflMangvW87MgtgxRklZl/ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308906; c=relaxed/simple;
	bh=HmmQkzCSLYbXdPCFF0Hh81Zg955fc35mxeI2Uj1+acU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Xa9OdxA7LP6N30OGa7CrvUxBdpIPcq3UEmxPZSzDU+ZBC1dK0ix7wiiEuWj3mGmbo7BargLZWvzMvE2OxVaMCUicsmrJCkbpo7JyonjCyKmfK018zLfO/XLi+QJbIj4Pycs+2azM8+/Y+St8hBbKJEoa7hQduDznDdNmbO6G9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI7yave5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI7yave5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394a823036so32154535e9.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742308902; x=1742913702; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy3kXcG4zRdiiqXSjoMgE2W73PCd7jBtVstXnSo2hIk=;
        b=EI7yave5DDgBvN2agpCDAjQNAqBRdCawG742qIFtBcPwvUAUmKqpNkF2H4zmcRKPvz
         aPkbm8Vs0MEcLzS4ZXdcF+0LofETtOHq2DtVBKyu9jJsRCGuLzuaxPosH7SxHe2t6F+J
         6UQ6z9SXnOMmD3/mmnTfceGAM4lghfIwzcDvLOetMVDXeApOFQh027siVbTHHqpYKib4
         CIdfE2c0/6sKBM1UzhsHQKf9dFQ1q3cCrK164KsMzQriQWycAespVihiBb7chxsk5y9A
         THsYcyrv2ue/v/bCxtSaDamDQfe3K7z1+PCRx9Kbc88yLaKvjUUn7bMWyuFFxDqfyzl5
         8f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308902; x=1742913702;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zy3kXcG4zRdiiqXSjoMgE2W73PCd7jBtVstXnSo2hIk=;
        b=T9Je5HlYSPtHyZtx/boXeLFvN78JtDZehb7fFEyUGUu+pYCXDRrbNRD3Cv/Php4Xfx
         w24d4N9hD/bA8DVaSn9AyxSCtkI3mwsYqxk3kF6ap7p+KcG2iKSHNI7qSp5zkOZ4RGRN
         NYBP5J1j2zj1IqgT4C7BJhmUac7qQm/Bl6uvHsvd+pwYmYu8ew3lDkeJ1+PZlnneQmvt
         xqnCFSw0i+jLRYQPTeAQuLoiwBq2VhMzgpQ7EIoDOOoo7Noz/FIzAnfCbKyAopZMMCmu
         2mOp+fTom0rzg8D5N75ELKK4F8W7tq0W3ROUgEOchf88q1jTrZEhIfXHbmk+kkW8mLDr
         JJ6w==
X-Gm-Message-State: AOJu0YzE6AoIMnBV5M6FKs8Parv7TXRu3j2Vz4wBDtNG+wU7YjILz8kR
	WZqjxuAqr8I4Ih+pJoUVzutNXyS0SSz7wH5m+LvWATC9gN/Bky9uL8OjsA==
X-Gm-Gg: ASbGncuKyRet+EkH+5bRFZATpm/4C/H7daagWAFsLZtpPqoRgq9lSdTm5+AHVUTiBn0
	1oVZS4P0lwNBKzVpNtApvfq3Qmj9+UtrEp0mOQ5gU6m5Wd9kWQsoJyq0Til8IZzEXCJKr8gw+oG
	skW7rY/Ir6OGO42puNQgfwL9ea4dg7UpUKHJJUJhCs7PX3R2oyovvZttgLz32+FfLEr1uKWwRqe
	ROqZ/b6/W4TJLC9+TWsx5URiPlUeXm0pyODqHu24zNagqGRAETvdfL/G3jYzeG9IkErXR2BKose
	q4KnX3bRxAIvaVezgLkW7Uc+splwDXhmbWtEN/cNUPJk9A==
X-Google-Smtp-Source: AGHT+IHCCdcTufrcrEHnZKh47Nyll86pY3RrCcuRf1qa+Dse4UpmKAhQGlwlq9fOVpgXVSBARhnnJA==
X-Received: by 2002:a05:600c:444e:b0:43c:e7a7:aea0 with SMTP id 5b1f17b1804b1-43d3b9ddd1bmr21554405e9.26.1742308901238;
        Tue, 18 Mar 2025 07:41:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df339asm18083227f8f.3.2025.03.18.07.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:41:40 -0700 (PDT)
Message-Id: <pull.1921.git.git.1742308900290.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Mar 2025 14:41:40 +0000
Subject: [PATCH] docs: add BreakingChanges to TECH_DOCS target
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When BreakingChanges.txt was added in 57ec9254eb9 (docs: introduce
document to announce breaking changes, 2024-06-14) there was no
corresponding change to the Makefile to build it. Fix that by adding it
to the TECH_DOCS target.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    docs: add BreakingChanges to TECH_DOCS target

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1921%2Fphillipwood%2Fbuild-breaking-changes-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1921/phillipwood/build-breaking-changes-docs-v1
Pull-Request: https://github.com/git/git/pull/1921

 Documentation/Makefile    | 1 +
 Documentation/meson.build | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 671267a8ac7..de57d5822e4 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -109,6 +109,7 @@ SP_ARTICLES += howto/coordinate-embargoed-releases
 API_DOCS = $(patsubst %.adoc,%,$(filter-out technical/api-index-skel.adoc technical/api-index.adoc, $(wildcard technical/api-*.adoc)))
 SP_ARTICLES += $(API_DOCS)
 
+TECH_DOCS += BreakingChanges
 TECH_DOCS += DecisionMaking
 TECH_DOCS += ReviewingGuidelines
 TECH_DOCS += MyFirstContribution
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 594546d68b1..b62ec5f6010 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -440,6 +440,7 @@ if get_option('docs').contains('html')
   )
 
   articles = [
+    'BreakingChanges.adoc',
     'DecisionMaking.adoc',
     'MyFirstContribution.adoc',
     'MyFirstObjectWalk.adoc',

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
gitgitgadget
