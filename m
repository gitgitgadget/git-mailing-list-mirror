Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FB2DA760
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468919; cv=none; b=uOupGFpQICCb258mmYaekQXI/0/ma2JHGl6qA2t/vPyiKhHGNUn/4BQ8JDuGnkzHNNHy6ofGut8Q4ijtXN2aFbTkMtkv4ba44tHRS0MxRK0jP+5TIumJg23qBopRHZMQxUx1ty7LOUMuwFb66AA6NmpQXWr81vcmTtEuBiJtbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468919; c=relaxed/simple;
	bh=umP8Xttt2i0w5mytegOPtCF6mncpmH8Q3T0A2P6b57M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ivzkh4R2ENLsRZ7BKj105lK8vbFwgWCOFJ7YTKqSLHKxS+99WU290t7TJkPJ0xrjupFyDJyqxTyXAOGLyhCqNirVj3RgZPsvhlxMK024JIMGp47P/WAaBZUBqruvdsTdIZY3y0pm52elOnRmtR+9zr17X/IPUlzPB1whYIU00QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgkTtzKJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgkTtzKJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2953ad5517dso1287455ad.0
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 14:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762468917; x=1763073717; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovjc0x6hy6GDLiO0T8l+I3/dxbdgB3kEwMVSxZbqjNA=;
        b=NgkTtzKJOgPCoZZsOk4keo5du3qMCsdmzTmulNnXeIEfuqADWPFKb2r1WivCsoniPb
         uAFU+iTCfkprkK2b3diAOX5I9WWxW2w+NcNwFzk+M7BH5W3So63WxWt7bJWfDWBkcuQa
         wVeCXNGuVUKKpZX5X6Wf3qQwgFCo2WDJjjvM0dp5oN2jrbzsGBdIWhxfFIAeGRqeYH3P
         NYWP0S910O0gtKngp1QxYJ4sSsFWZa2lbNbzf7RIEyx+IfrGAugMpvut3z0rLfW/8VCV
         rS20z2mzTfd/wGFg/0vOHeZabBgSGXoDBcsK8HMgbpIijPnSh38TecsUTbtCPIjHnmWO
         2Zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762468917; x=1763073717;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ovjc0x6hy6GDLiO0T8l+I3/dxbdgB3kEwMVSxZbqjNA=;
        b=EcslMpKt/dM3xoe5UTp879mvuqtrVxfqxCi3+3ZRtNsgqTFlWgiyXIAfDmENG0yLcR
         7YgTFiTIL/rZIOfIDuzKrro+UGJemVX5HDqBlpoAjgAOYldIby1OaUUyEO2VdSbxarVd
         YgVwXQtvKrJVOA1AHNveGRyVeMGfDdmC3csbIjCJaDUL6hVDz4KerUrgEVtRa2jp7Qs8
         I+RRR/6t/x3XMIh5kni6dYM3BDIlgFY3rswJaYqVchNRDYtNp5AFGx/QPyvkRr42hxri
         h0wemocUNADxUkpIJTuLweOe6571L8IO5DVvCoE8JyJ9W+DdT6zXvZ1lk9otuM9Mrydo
         2UGA==
X-Gm-Message-State: AOJu0YzmywBreaF78ZJ9Axp7ii6jbXve3BfXvmuotkMLmsJ1GfvjTNDY
	akMMeOIIv52OV0gj5fupi2bdhm49ZOXb/5D/JRgIlUNf1ke5SSNo1atCpyMopg==
X-Gm-Gg: ASbGncu8jV8U4JIpXXH9fClJT3OR/hO8gur/uE1a7fD5hcfvBq1UHGHK709U72WqVSi
	5/Tgnuk30f00ddrDTrJTg8dLIXJ2jLblsh1Y33rlVBn9+5vGjzVKi9BnE/dBJ814ZfdIlHWyR1c
	69suEl5DKQmT7NtRWmGg/YazAPdgz80MhHRh449+G0mxjE0AWcjPHq/iGhr6jb0E7FEwQioHIm+
	5zWrrFCyiHHJ2yo7DUdQ2SyARoiq5MPhWp+uMY3gMEmNvCn7Mgbu+JJgauLsfln6HZwsU0kNHjP
	EUwNZ9mjBwKbf/e4CGee3MD0p+wdQn7EhkGCK8yw1twGdT0nXXVBleydRGiXvtqWVLMEemChzd6
	915rxXO7omd0a59Xk5sK+a1RpOHiJbWyWon/6fOId4YCbiVvlrNSbKrUTfSoe0bsExx/tkvuJKm
	5u
X-Google-Smtp-Source: AGHT+IGVp99b5PIBPtmLUEPNoq5HuLIA6pK2TzP8TBUNslw78bgpgvJgA0xmxF5lvfY9QQyKE8IElQ==
X-Received: by 2002:a17:903:41ce:b0:295:bba:9734 with SMTP id d9443c01a7336-297c0403d70mr16107345ad.24.1762468917003;
        Thu, 06 Nov 2025 14:41:57 -0800 (PST)
Received: from [127.0.0.1] ([68.220.59.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650e5a33bsm39403885ad.47.2025.11.06.14.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 14:41:56 -0800 (PST)
Message-Id: <e81a5d2bd23add19e04184f6b37910bc89a514a5.1762468914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
References: <pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
	<pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Nov 2025 22:41:53 +0000
Subject: [PATCH v5 1/2] xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

The XDF_DIFF_ALGORITHM_MASK bit mask only includes bits for the patience
and histogram diffs, not for the minimal one. This means that when
reseting the diff algorithm to the default one, one needs to separately
clear the bit for the minimal diff. There are places in the code that fail
to do that: merge-ort.c and builtin/merge-file.c.

Add the XDF_NEED_MINIMAL bit to the bit mask, and remove the separate
clearing of this bit in the places where it hasn't been forgotten.

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
---
 diff.c        | 2 --
 merge-ort.c   | 2 --
 xdiff/xdiff.h | 2 +-
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 87fa16b730..6ce3591c5b 100644
--- a/diff.c
+++ b/diff.c
@@ -3526,8 +3526,6 @@ static int set_diff_algorithm(struct diff_options *opts,
 	if (value < 0)
 		return -1;
 
-	/* clear out previous settings */
-	DIFF_XDL_CLR(opts, NEED_MINIMAL);
 	opts->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
 	opts->xdl_opts |= value;
 
diff --git a/merge-ort.c b/merge-ort.c
index 29858074f9..9b2b0fce7e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5495,8 +5495,6 @@ int parse_merge_opt(struct merge_options *opt, const char *s)
 		long value = parse_algorithm_value(arg);
 		if (value < 0)
 			return -1;
-		/* clear out previous settings */
-		DIFF_XDL_CLR(opt, NEED_MINIMAL);
 		opt->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
 		opt->xdl_opts |= value;
 	}
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 2cecde5afe..dc370712e9 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -43,7 +43,7 @@ extern "C" {
 
 #define XDF_PATIENCE_DIFF (1 << 14)
 #define XDF_HISTOGRAM_DIFF (1 << 15)
-#define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF)
+#define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF | XDF_NEED_MINIMAL)
 #define XDF_DIFF_ALG(x) ((x) & XDF_DIFF_ALGORITHM_MASK)
 
 #define XDF_INDENT_HEURISTIC (1 << 23)
-- 
gitgitgadget

