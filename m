Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8A2E8E1B
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587596; cv=none; b=CQWetsWpJIDfBvrXOGZRW69bSTrsCbD5owrp3GHN/YduYA6Tj3cqSSYDXz1Kft5p6XjsYMbVcL4FKS48Vzqtb6Iqt7dHt5QB9aX73BljFGySH9edKXFLF4zwWR5cLfkmqusbTU8bT9QClUtXpIW2HoRofthhLJdNAXcM8kIPmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587596; c=relaxed/simple;
	bh=a6KaXBTremdGWUtYAAD8ddJc7lr+xBd71GezDTs+zCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+ptU4xvVuzuMbZWMriZP7nhEyjt5jVvC5i41nq4H0W02v+9kBI34OgQebTJFtqFbPlx1QKwYp/jVXV4XvTRsNDxJpUUddPgnGPzJfMNmsPX/+HG1Qe2LNWoP+F5kHfr0zRePpB2GxYtZJ2AbH6HoBcoJQfOnpHcsLxItVPNgXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2/giKAi; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2/giKAi"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a53359dea5so2895112f8f.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752587593; x=1753192393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RID4KGBlDrKiiaezDhkDFV6vZnEma+TKoXvlSeyv0EY=;
        b=T2/giKAi5pd0/xkLMCgHH657xWL207NVi+kAb/YDeioXmrrogpX5zU9Cqy8GIx33q6
         JZBlyL1ANsshYtEhlI5/pI+3ajAII6JOh/iSdhLzh+I79YGe3hfAcgwgoMKOKYcFERXW
         V20iXHnSN/6DVidtP+SbbDtB6t8IIRzI2Kk7YH6ivROmmFwkexnLVfGXZJHq93hToNX9
         p29vZHYVC0L5u5jkp/AfS7udSs14ZZFxE4vXCSO9FfntOKEJegr0jFFXx75Troeza0ng
         1kzEQs1Jc4buR+blRSOkd4NBVfmbpJcbRRtuL1vbnBaPnJPQY1k0AoFgVum/eaM7xQqM
         VNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752587593; x=1753192393;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RID4KGBlDrKiiaezDhkDFV6vZnEma+TKoXvlSeyv0EY=;
        b=VEmtpAXymVp/pg4AZeHdHJcr+lVohx8DDKs8Ud2KCzk+WN6v9sf/Cdr/9Z4pLv2Bn0
         E6A0/tr3gTeXcjXX21cw7FY9EdSyZhJpMiipVyZeDOMfiLBYm3O5S7kiQX3/Ar8DQApt
         xHkbF5j7D8oiwlv6FaOGEv+et5p2TQz2JLHtHcXLBVm+a1f0Mxi6B0AoJMx1uL/pmExe
         fUcQJUlPiHPGrJiqjwhNEecbRRxlVntRYe/TGCoz1V6YQjB7gj/FWn7Ji3gZK/3NexVo
         E/A/W5JiAI+h41azhbf2BtVvBQdQ0fJNYgE4D4NYZz4qoO1BMnhrweg7VLbR2qXp57fC
         firw==
X-Gm-Message-State: AOJu0Yw7zAiwILWFhk9B1oxLUV/xupEf0OFQUzRaCrJQ+z10tu4lZD6P
	5LKmoGxeeGpfceNZcBD74fH5+abCr5+35LAUMzNlQ7uRJRFSKjbLwu4LbfO85A==
X-Gm-Gg: ASbGncuAChCzQXFb/5co6uhMUH7OnkOTbHEoiemdlca96nuVkr1LCYh7Jao8j8tRPlw
	jlKPyuN+LNmlnUyqp4K/CXTquyo8VBKXrP4azlZSyiowv8lD0n4bRTQdxw+rdTcYDFCByAHlGXu
	8/HBwpDznt3kZ2e6z6j1q8WZXWZyPgXJumuMl3fMK0f0yBldvmAM0rC5AjWlLSoqdlVYrhM7kjG
	q/hYVMwfWV6XHwJvzmwnmqBwesg8yTSGcB6HmJteVxlNR13UzoJBWjRMIsbXFhR6nLj6lyInrPz
	uFhMdQwXsuRe9tgBgLnNeixaYFVwLL6Ceo6hYj/stPMkIqBLKqtCPzmxWyTqnLQi1IHWpuqkInx
	Be0Mak9A42nSraMKBkOMpCQuajvMae1YebJswK0VrcR4S
X-Google-Smtp-Source: AGHT+IG9EgN+cUdZ64LLb1maekpzgSUVE3vIKepST1fmmgF72Y3yv1N6YWmTKbl3FfUXYCMd5FjHVg==
X-Received: by 2002:a05:6000:230e:b0:3a5:3a3b:6a3a with SMTP id ffacd0b85a97d-3b5f2e3a01amr14299727f8f.54.1752587592757;
        Tue, 15 Jul 2025 06:53:12 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a54sm15421112f8f.39.2025.07.15.06.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:53:12 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Brian M . Carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/3] CodingGuildlines: allow the use of bool
Date: Tue, 15 Jul 2025 14:52:50 +0100
Message-ID: <352f80c49b74053d611e7d64991fed1c16d857a4.1752587571.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1752587571.git.phillip.wood@dunelm.org.uk>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk> <cover.1752587571.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

We have had a test balloon for C99's bool type since 8277dbe987
(git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
2023-12-16). As we've had it over 18 months without any complaints
let's declare it a success.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/CodingGuidelines | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 6350949f2ef..528b42d1dd1 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -298,6 +298,9 @@ For C programs:
    . since late 2021 with 44ba10d6, we have had variables declared in
      the for loop "for (int i = 0; i < 10; i++)".
 
+   . since late 2023 with 8277dbe987 we have been using the bool type
+     from <stdbool.h>.
+
    New C99 features that we cannot use yet:
 
    . %z and %zu as a printf() argument for a size_t (the %z being for
-- 
2.49.0.897.gfad3eb7d210

