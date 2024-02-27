Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406C13B2AC
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040506; cv=none; b=aXlXRWVPWQRB/czywfNv6/OMMoRKy3nPoxjkBLs9wJB8MugkbellWfV9+5jq+EFToJ2oo1w06Rd4UG/nO1vzR2t4R4J5CJOiLv8iBOQsaqx+K0ZN5WLWfimeD7vAxwaIV1RL/bDBT5U28W216jvaHm4i9toq9JNaXDQ/0g5rjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040506; c=relaxed/simple;
	bh=CIKQ8Bb1sUrqihQ5MJIFUcbno3QB/yb6ILzqtp+yaVo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lsmG1g7MpeSY6nnnzqyqL2/Nuh0EC/TgfdmHbhAOCsykf6szwyRfAT5ODFY6dj+TuDvZLu7U69K+R16KaY2W4AzTHnP2Y2gj1dCx2kTKJqR7ULJMIixj+ewGFu1Pf/lrMxnKfm/OnZgy2YIfns3R8lnpNLE1AdQZKp7TqBvgctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9k96jxl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9k96jxl"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412ad927275so4084025e9.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 05:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709040502; x=1709645302; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTSR9XKJE4GOW6G6lNSpqCjAzTbfFv8qkdL27MvMrxQ=;
        b=b9k96jxlK1Ox8I3q3wX+3vRml+0eIfDS573uKMlfk+Q6Ksr4z7KUGeo6aScYFPOY14
         HLCB5DdEwlJ4zN4p8OiZou7e+MTBatSMoX3tI2KojMB0raGi94+iCIUzSTRh8A36vAIo
         12//f8M87xijuTXt1lb4SqnLLozTs6YsNBHY4atlCpihzACXrJK6YRpveri7Y2eVLevY
         LDgyK+2IZoVhQr8EsvAFs8T9oV6n7x0ZkjIV2TwJ5DrVNBhRrtpDBv/BcAHvxnpkjv2o
         zE+CEwbfNPGaP8Jku40CHIJY64HS/l+PL9omlcI5be7IoPG9vZniRUU9Qd5Ty1CbXtkT
         Q09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040502; x=1709645302;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTSR9XKJE4GOW6G6lNSpqCjAzTbfFv8qkdL27MvMrxQ=;
        b=Sk9Cpxky5L/pczIYDUw2+GgoM7cmysY7PpRLl/V9U+TXLaiEKiZqKO8i/JM2WMw1R0
         IGcdJjAR5TGSYoSHOoA72JzxyFI2mydB79TDrsRRWaXG+/EV+tmKT/I9eh6JR2DN+4Zm
         +kPDDU1gPkQylB0hE144ZQVYyOEijMYIBMPYDPWEUbHvj4MZJSHxvzo2K7hwdELSJxlm
         aMLlsnu76vUs5ptGRyExqgYW4MtjNxZk/m637bux7kXBAY0KF3MslK+CCBb22Up1BILS
         pSs3Vk7Ecu+K4N3meFytGIWAsg8KEVLirvbiJYr2Tq1TdY40VNb3ps0DUN3MwUsk7Vhu
         FKXA==
X-Gm-Message-State: AOJu0YxKqW7cNkuOApfhd6uY0SIbNzVrTp0rlZCbE5/MSO0vX9Xvoyue
	wysEmgVVygpxPRhJ5otak7D4CXdJjl+NlLMl+LkTNwUhCh9DPA7Rp4Gnw/Ov
X-Google-Smtp-Source: AGHT+IG8U7JKQBpqSX4ec54gBq4ZFXhOAuzxWYAW/omxTE1AIBL7VTdN13j5CpKhohT8yIQ9AyLIYw==
X-Received: by 2002:a05:600c:1d9c:b0:412:afed:5cfb with SMTP id p28-20020a05600c1d9c00b00412afed5cfbmr562914wms.15.1709040502466;
        Tue, 27 Feb 2024 05:28:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q16-20020adffed0000000b0033ce06c303csm11374554wrs.40.2024.02.27.05.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:28:21 -0800 (PST)
Message-ID: <6e4e409cd43bcf445f811e171958ef4a169a0163.1709040499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 13:28:07 +0000
Subject: [PATCH v3 01/11] paint_down_to_common: plug two memory leaks
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a commit is missing, we return early (currently pretending that no
merge basis could be found in that case). At that stage, it is possible
that a merge base could have been found already, and added to the
`result`, which is now leaked.

The priority queue has a similar issue: There might still be a commit in
that queue.

Let's release both, to address the potential memory leaks.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/commit-reach.c b/commit-reach.c
index a868a575ea1..7ea916f9ebd 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -105,8 +105,11 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 			parents = parents->next;
 			if ((p->object.flags & flags) == flags)
 				continue;
-			if (repo_parse_commit(r, p))
+			if (repo_parse_commit(r, p)) {
+				clear_prio_queue(&queue);
+				free_commit_list(result);
 				return NULL;
+			}
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
 		}
-- 
gitgitgadget

