Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293AC153BCE
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168256; cv=none; b=F61Pu1xa8I9tyV8Hyt3wr76q675W9xGs9WMUMfzjxSHgk54THvzFSVWp+mAgdvNEpY507lFkKxmr4eowWB8Nfpm2OlL+sySLTi5C+gYNtIm05RajfQeUg7AiX58JY3l1YXce3smRUy9CeOhDAaQqLtYYRNHbZz0Nmm7086OXesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168256; c=relaxed/simple;
	bh=7t2xXs1p5bkoTTg36/kHWEZ/YQputGcwerqjMLwWq5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7jkA3Kf/ccaFQR848y3pvntEdlfashbLstblIbkVUiUnJXt9ZBEIlVvmdKOYQwyhVVpo56lFigwUDhoKZ74XVQX/fqIt+RqtgXZ8p8OgvfXTQn0TwEVEYpkH57G9R4pMqmaDEz/7caGI+LAfwsEVVg0GVgJ9KH+RF3dvCM3g6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYmMhl9N; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYmMhl9N"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e267238375so9900105ad.1
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712168253; x=1712773053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5B3JXWz84qiYcR3rQf6bHYfbmbm6pzN8Ju8bR/IR/g=;
        b=jYmMhl9NdEuXZeuGSXqtfqwgejNqDDWsyyB96vETJkZ5n5jZxjnRMK8NpLUONgtkF6
         Fw4h1qk3ByBiz7RFqOyj5qjhB5wcJiFdUHyZL+nRBFeHUqyshvpc409iR60Byc9AlMn2
         SST4Dgb65hoWKUiGsL8AV8GS939BGjGR4uLRg2p6AE+g71CBoNsAI5MToEJNXE8F3lV3
         6M2a61IYEx9sOlHA9CFgdcKfe3Pt9osPgBSskWGIODSqODgS1PMElq7VORyU4Qz6XnzP
         OW+RAJEZamVCrvWAtv5Q08OhzAuKqFFmlh/8tyoxuOZ83IUDBNeqIMsTDDQO9Nipqu8Q
         UW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168253; x=1712773053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5B3JXWz84qiYcR3rQf6bHYfbmbm6pzN8Ju8bR/IR/g=;
        b=aqrWYzfRZXaJz8hF3luRsWPdKATZrrQ78YQi6teY4TPKjPy/cY2Sq6H2c92IhqGZBM
         74u2MBTI3eQYAiOJZ5KJup6FYe/IGjJ9IYFTSdQy+a9UNkkBQqwijCTNrwxcSYQe1Phl
         D2DvPmlfEh+XtHqulCVe2s7RYTdTwZzJHiBFajy7HGa59LSLBnTXOyYogTXMHS/7SKwK
         Hi4IdyjNHIVhN+We4HRTHc9ivb64DPKQJjbGihYugB+kj5dROspHKmRfN1ntV76qwD7b
         jOPAryRuQaQ/ZobKQnQF7xKVVzbc9SW/UVBsjsBQehNbFXbYsB+4/dsW2AempaHuKKf+
         CEHw==
X-Gm-Message-State: AOJu0YyV33Y0OZl7YOFnvVERpUvUZHe9k0cPn7/kbHqePDQnyxa4sgYy
	nlHtaGONATZto1paFjgpRABxmmgocF2dXJUEY8kFfpdXYnQztWviesnsMyXU
X-Google-Smtp-Source: AGHT+IHaaYOVVpSPtPkqEML+wal6Fq5N8S1aOaUtgtNLTP6dxyDKpOXcQHBsUh+b3kq6Ryf14LiEqw==
X-Received: by 2002:a17:903:1c6:b0:1e0:bc64:a37a with SMTP id e6-20020a17090301c600b001e0bc64a37amr5183180plh.8.1712168253004;
        Wed, 03 Apr 2024 11:17:33 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903120b00b001dddaa7d046sm13661758plh.29.2024.04.03.11.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:17:32 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v4 0/3] commit,add: error out when passing untracked path
Date: Wed,  3 Apr 2024 23:44:46 +0530
Message-ID: <20240403181531.59505-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402213640.139682-2-shyamthakkar001@gmail.com>
References: <20240402213640.139682-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version makes the changes as suggested by Junio. In particular,
changed exit codes from 1 to 128. And, removed unnecessary free()
calls immediately before exiting.

Ghanshyam Thakkar (2):
  builtin/commit: error out when passing untracked path with -i
  builtin/add: error out when passing untracked path with -u

Junio C Hamano (1):
  revision: optionally record matches with pathspec elements

 builtin/add.c                         | 11 +++++++++--
 builtin/checkout.c                    |  3 ++-
 builtin/commit.c                      |  7 ++++++-
 diff-lib.c                            | 11 ++++++++++-
 read-cache-ll.h                       |  4 ++--
 read-cache.c                          |  8 +++++---
 revision.h                            |  1 +
 t/t2200-add-update.sh                 | 10 ++++++++++
 t/t7501-commit-basic-functionality.sh | 16 +---------------
 9 files changed, 46 insertions(+), 25 deletions(-)

-- 
2.44.0

