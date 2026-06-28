Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35AF3A4513
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782649567; cv=none; b=P/8FYfDgDlZpFAhAiU2koL99A0s/FkLMW0LEuXwRiT78FuEUgMegbUrzdGNAy8yga59sGGY+LZu/utbDpgkppSzbsSmxufYyW3Fl22wVLpYii1Ln/3yWqrDWp6Z6Utxg5rcJ+tbv7WA04joUk/LjgG9DWbMFxM+5q5zoyyJr2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782649567; c=relaxed/simple;
	bh=GYywbh5Tuafc+ZixVAHXgyokzOFuWk0CjgtbXlFkddM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PxZpfOCU1LOzEdouJIVtOgj8afVMJZmJSt2rALSJXOR5cqAbLEZr3GmBo4KLSmilSV9AO08p5T3WVarMcgTys1sTzwzgh4DDqtLXvrArgXeoyhx0xSysJO2PiCODgSZouJjcWrqXs+7hQGNnDfb27x1Z6J3kyLB1BJNC0H8HXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjCPdCgS; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjCPdCgS"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e50979c71so4111285a.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 05:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782649565; x=1783254365; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KsaLLvYXsjzuo1Ug61lLQQ/odx54Nk1RFz8SapbpYY=;
        b=OjCPdCgSCir8fcCGRjzYM8gfVQm0J1Ykh7PrDc+XCydM8cKsZ8qK4HSOIcPwkRJAz/
         8de44Bp0jNwpEzhXOft5Yd2BUCLsVkGrbz/hluUHoRkHO7NTuPmM3eNUcHTpQEfoNj0D
         eCmniye1MCm+YKxWNt4GM9Bn07PGr2whFHb5zU89xtXgDtrD0O2iuhwgVTloQUnLPw6C
         PiE0MMDJoTZ/46DOp154sXyo3uUikyVfT+fd033sxd+UrzPyTIxwOiEKjQstoYtzweb6
         X+dZiqLu51oGi+y1FfYdFuNp1Vl0OEyyXxnQgs8exeSyLcUns4eTpQTZamytDppaHuUi
         BzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782649565; x=1783254365;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1KsaLLvYXsjzuo1Ug61lLQQ/odx54Nk1RFz8SapbpYY=;
        b=JyeIWRsxQzeZUtfY/IhsXgPIay/LGSGr4hhJDJnDDRZKHUcaXCMvDofA7NamODpc5B
         arsIGW/2n7psnn9sEXMVb1bZ3nosmU39C6RxDJdDRB/DBKKCKLDLCNKubEc+cxD5G25Y
         tcyhwfALt5t7Y6bkF11aYhO0RkqGll1O+GftVDfLZKDfZuLdSIzNyG0C+P2HEORdYoo3
         lE8ZFTyhhk2daLIh6OG9OtsM2qR1FMrgvhIHUfq9N6TCqqRoN7+pfKpCiEbNf7a4bqw7
         ejSxsT8FetLwgKAbUWqWFfD3dl1eNncspaD8rnRDbGFRkI+iVK4FzwN/5BUVAlv6NI5E
         uX3Q==
X-Gm-Message-State: AOJu0YxJhXfpyJ5b5P5yo9rgEyejuxlfjaQQ2HLIXk6owornqiE3ipcB
	PCeeZ9Shjt4dT1D3QvgmUaKNp8ObPZ2zAoXqVjb4gatwl5Md5/kRqCsHJ02tfQ==
X-Gm-Gg: AfdE7cmEPAjm3CxbEQ/vifNxRi/GKAQim7gBxJfWVL5/OVEqaJHE6WVnvpjj2sCbjJ+
	yqAYd+W8XeOiRljBBxOIo2fLsdEHwgcxRxokEbbTDaZd93m832PfCrn5PMvsG4thHJMknkzFBF6
	pILvBlCFFCUkb+5kSnYnAOMfd7sOsZTgHZFPx2hTQZ7phDIZifybkTfj0dAZRQ1RzVtQQdlaEWh
	ml/bNiLTFjZ2d8VA0t6nDsoBkMiuk2HV1IgOmbU7XIR0XGhlvEEDkAhJn7dJ3Ra3JKPFEqDPXmd
	HxjmRRgGLHlfbUa2ROHvpK04jN3saC3sN1RIyMBECzBofSGMtY0AuzaPtI9Y47KMvEpDqdTOx6n
	TnMeD5I/uZ3njK8g6cpt6a2tdvJZA7HRb/jFQEjxXEfXJJ75H0UvhfCM9jLYQMAfeKDk53gh+Zk
	OgDzQtX9ILUKsfjYZD
X-Received: by 2002:a05:620a:1b87:b0:92b:8c84:3e5c with SMTP id af79cd13be357-92b8c8442b8mr904287285a.12.1782649564721;
        Sun, 28 Jun 2026 05:26:04 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004ac1b8sm1722675585a.36.2026.06.28.05.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 05:26:03 -0700 (PDT)
Message-Id: <4db485b48aae810eeba28ea4feb47401ab352e88.1782649547.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
	<pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 12:25:44 +0000
Subject: [PATCH v4 6/8] commit-reach: remove unused nonstale_queue dedup
 wrappers
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

nonstale_queue_put_dedup() and nonstale_queue_get_dedup() became
unused after the previous commit. The core nonstale_queue functions
remain in use by ahead_behind().

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9ae306f60c..176ffd68d0 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -79,24 +79,6 @@ static void clear_nonstale_queue(struct nonstale_queue *queue)
 	queue->max_nonstale = NULL;
 }
 
-static void nonstale_queue_put_dedup(struct nonstale_queue *queue,
-				     struct commit *c)
-{
-	if (c->object.flags & ENQUEUED)
-		return;
-	c->object.flags |= ENQUEUED;
-	nonstale_queue_put(queue, c);
-}
-
-static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
-{
-	struct commit *commit = nonstale_queue_get(queue);
-
-	if (commit)
-		commit->object.flags &= ~ENQUEUED;
-	return commit;
-}
-
 /*
  * Priority queue with per-side commit counters for paint_down_to_common().
  * Each non-stale queued commit occupies exactly one bucket: PARENT1-only,
-- 
gitgitgadget

