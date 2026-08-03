Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC153378824
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750644; cv=none; b=UKe5C8Gal3NA2uW1r9jc2h6dyJjH9cgduXJKD3XKmklkCkyOo3klnG5FgwtlEqHI+zctM+dDglOBusCoR8KGc1iZPfMmUL/k357zYDUC3QJ2E3eKdUkYty6R3P6I8PAT9hXQfsnbZqHsme9HCBghjasqsf7X/Y4qpYZDrno63iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750644; c=relaxed/simple;
	bh=jsLDMlL1xhCOgtL38ATD1qD1yldSvX1E3x99t/GZpTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6kYkJoMCS/N4XnGdW8weoac2v3ZcRJJHhBiUbRUeULeXcK6TJUxLVnotEABDgujJ6oI3MxC9Hud4Wcu2kf0IUOi1byFZoD0Q82thuC/Omz6quSmgK0B6U9SE3Ud6617quwIFw7pPWoXiyGTvqR6Y6DOSw26JGJOkHePtG+kpAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2/TlI3y; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2/TlI3y"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso8145095e9.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 02:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785750641; x=1786355441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QV/2Jl6qu/68NvHhOxeg/sem5uGu9OyRThAR59SLFPE=;
        b=b2/TlI3yPVKVus3o8+MXwfAm/7XpBIfkHvZRxxWU7mPQXTLmB/i74KhD8vnTpTpwQD
         SKlE9ieXaSOisDVNHKy1V5riBtIavXmfTew+0AKd3fj98kpDeS7PVb6Hh07cAPgEP8wf
         y6uOuZanOeDX65KyUr30cSpLQTqBI3CJhBHLtfBW2e/cwlD6G5tG+urw1NtY/k9peiBy
         rWBgwZySW35iEoM3cLwZVBWnGcrJx2LKS4wX6P0aS3BEz76A10nfvyfjjglDdtnrsNnE
         Cgo1yhA0Q8QClXdTwbZcomvcoG1o0G0m6buO+m1lAbYXj9Ej77P/b5GKxx+tQbOP6igZ
         PsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750641; x=1786355441;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QV/2Jl6qu/68NvHhOxeg/sem5uGu9OyRThAR59SLFPE=;
        b=EZEhOGEff853hRdT0v43LRgrP7ysWyq4mpltqTXsvWQrBJxyLKb9ZMEG0Yymu8KHwJ
         gDx2I9gEVGp8j+u5QYqPQI4rWHEBHJkZ8BMknV9R7bwcOR0mya8EnAyRY65o0K6/XsYz
         N/hoesqClLyo14VWnBGZFU23E39OBr7CLl9eZEKrs39ZKdoStTENCKDNPGJ0xyHQCrQn
         fYoqhPxhH+pkzqiaOh5ER3IQ9RQNeJWxxROI4zXV6ZbOBAfkWale6f01A1ziwHIPE/ff
         IYgvhuuseYNPLDicuCIjSaKNPNCEMVpyVCpo5t4KthMXsMNJfWr1diI0iH4uhXxZ1ViB
         nfbg==
X-Gm-Message-State: AOJu0Yzvh1sHLGyVb6+DI3Wpg0pC9JZ1++KDl53zgfp0Si/Evi2pFZ9f
	HIVdzYXXV+tuUpHnURsLRD/nf7EQ1KHqtdHs27xmalf7OFg1TvOkjYqqAL3CsQ==
X-Gm-Gg: AR+sD13O+UPRg7pt5fZl6YQS83W+oiqjVp+dNoCZ83tvLDNH6f4JMK5V1z2OczAkKER
	xnVjPxM+k7p48gatq/zvDhCDe8bJ7arAtBKFTRWe6gql/PPeKMzfhJm1cOBIW9jgTpPTqNuafZA
	1TTc2FgyCqq3CwFzMqKa2Xic7+NcwpApyMZ2S59K82qB4UmL3WPG8kh+LjnCU00/KrJYegg2+3U
	fgKIlm8irX2Fl74wqa1SkwT24OU6MZc/RK7rrRLLvd8bCdgBGZmpkYLrUssVv8jG4kxv1Xtl/6T
	8nkiiG5gwZD5rht7YMt0OvDlkpZazKhuGz2XqqTM9GhLBDkz5sxjQ/Bn1VgGgSpeA9U24cr638Z
	FEmAUa4BRGZoFKswihYX3d19qzfSYd6Ryurnb0PJYyxGVvl8r4ZQHIlR2YzhPaUApMQe3kqkp+u
	anVP1k2lQ4jVkpbpa5u8IuP1nEb2A93WdxusSvh2KC3LywN9r5JKg5kqdCFINUND3t
X-Received: by 2002:a05:600d:6405:20b0:495:5e86:4e11 with SMTP id 5b1f17b1804b1-4980c672c9fmr154257795e9.12.1785750641065;
        Mon, 03 Aug 2026 02:50:41 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b67529sm225414585e9.8.2026.08.03.02.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:50:40 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Harald Nordgren <haraldnordgren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Matt Hunter <m@lfurio.us>,
	Patrick Steinhardt <ps@pks.im>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v10 3.2/3.7] fixup! history: add squash subcommand to fold a range
Date: Mon,  3 Aug 2026 10:49:22 +0100
Message-ID: <a6db74f8767622e8d1327e760b504298c25878f8.1785750108.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1785750108.git.phillip.wood@dunelm.org.uk>
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com> <cover.1785750108.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunlem.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Look for BOTTOM commit instead of an UNINTERESTING commit

There are a number of reasons why a commit may be marked as
UNINTERESTING, we are specifically interested in finding a BOTTOM commit
that marks the bottom of the commit range that is being squashed.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/history.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/history.c b/builtin/history.c
index 1d6d934bbe..64c9914c2f 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1066,7 +1066,7 @@ static int resolve_squash_range(struct repository *repo,
 	 * bottom commit cannot be squashed.
 	 */
 	for (i = 0; i < revs.cmdline.nr; i++)
-		if (revs.cmdline.rev[i].flags & UNINTERESTING)
+		if (revs.cmdline.rev[i].flags & BOTTOM)
 			break;
 	if (i == revs.cmdline.nr) {
 		ret = error(_("not a '<base>..<tip>' revision range"));
-- 
2.54.0.200.gfd8d68259e3

