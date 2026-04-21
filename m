Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F89C1C701F
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776731180; cv=none; b=HOwR1pJmQ/5WDkv7LkZ+p541VEDRghK2nSWmcv1bre+N5Dv1AQWlwXGtChXzulESAFV+fT0bojk2sF75zEDD3TPECm8kM7b9w3dMUdxB/EYC99NLErN9oT+d1DzNpgkrvGZ+IpVVlPVptcZTrZgQVm8yBYFjTNMl0ZyayOiL5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776731180; c=relaxed/simple;
	bh=z1ltuKe8gUOCeFgE7SoQNqoe+F007gsIvrUULur7IOI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=irdE1DdayU9ll2eANNLYKHqjRucuor5H8onUOu+yHkgyD6occj1qFpXH4V0LwXtMF5k4lBdEMZJo21dy4KzwGtSQmpP+cB3Y86u0BGSk6aJuXICRt6/ZhgEUnacQJjDU8/ag5IPO+z84NZgKFDplNQAvuQfI2MW40kYccFqwe9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIWEiq6h; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIWEiq6h"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506a747448dso27767011cf.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 17:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776731177; x=1777335977; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m4W7Fumc3BZgE2B6iAplnAt2D5ybnRtQ5wy/RiIHRM=;
        b=bIWEiq6hJn44zjIWbImmDMyZUsP2iY+NplfCCQOSYrXWyN5iamR1Uszv1KxRYfyOXD
         iOGLkCP5pQXWNGhsmt1nVzYxQJDnOnnnkHmHOjKow3mLMf0owUbT0GPZZ9cv228r2Dc3
         YV6NABNDFrCY7NcAXYEP6c0D4jcKt3LLnclx4nCOwy+kWSkykqf9h5Dl0LvVsBw8ZOem
         QF59kfky8E5g5ZFEPMrRaeCvY2+/Uob5LlASY8PPd3mlDfuo7u06J9VrgrfRJGfjoktp
         KOzz8wSXVIFHrmyPnLsNz3W3OScxFylfZ0KL7p6sydonGPtGtdIK8N41OdITmeQWsK4/
         /S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776731177; x=1777335977;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8m4W7Fumc3BZgE2B6iAplnAt2D5ybnRtQ5wy/RiIHRM=;
        b=T6M/LxV7NfL9gXASRCGCgI4KwlMo+Vxd9hmnUHmKX7doW4CsxS5tHVra7p3qXIefBB
         Cu/EH/2a7MzvRzBAn4GF4YL5avpLtGTqT6lW2pv/OKzFZCnnusuP1G4hcOtW+r3Ixz94
         ZbvcAYxPtFssuRbIz8LkTsXH9D+yHF/JTw40p4UfIAKo2Uepcwv0YqBlKPheaaAS/nmq
         zfbUgxGpOJ7/q8wifH9vwqcMx8KwwBMsT83VzbiSWJB2I32FXigsluSn+sCHjpOFPWdj
         eggV4p3IcINV9iNOYpFC7z4RgGJ6mr3l2hzwlwU90lXHRI5a7V6k9o26S5WkNBEx//kE
         AmpQ==
X-Gm-Message-State: AOJu0YzwXRIl8M+keYk7lvkxYlHXd3x0abvOGCc1Pb/QE7YIdUSrNqpd
	QfmNeRwNROhyL++QenOPbm/7F5QYUPp6Gpd4vFeb2k/wcVi5eJQxlB5Pm2Q46g==
X-Gm-Gg: AeBDieuS6Gj6kUTEIDOdaJH4Wek6/qcKfxzhOXNuw28Xr2YyXvSMkw/SsitSAAN1mN4
	i6rLR2HzPYu5YZwVkKBu3xPgaS2y6sLliBjGEYFA29ex1mVWS2J0EgWJZKb0bxxr2PFOOiHMF+v
	87bkEyhJ4LqE13QeLBwflBTJiEos8tQYaGj9SpfrkxFq2uBZYMTu9DRJOR6nhTvpd52U71nFwBL
	5mfNyDsQc/wR+M1j6nLh/FldU7j8+0fihC46TfGgnD+xa4ABxDimoi/cDkMqTFFrIQCL2rl6JFL
	l+wVCEU5quCUa3Cu+35Js+D9x404ZhA11JyNKnvfN4S0g52TwPtHQIoXC4NSuHzz7FsLoSuduc0
	ws9PlZePW6e4sQ+ITvq9D8H0tNjUJK0DhH7PRsWcRJEPE6rSFfrrVeM3MfMcIIcW6XVCkJ9dsBA
	ImQ5168iUnkHYTVkDXhYIgGHsDmB8yZmi5teB/X5cgflH3iAs=
X-Received: by 2002:ac8:5801:0:b0:50d:770f:ad23 with SMTP id d75a77b69052e-50e36bab74dmr237270961cf.26.1776731176829;
        Mon, 20 Apr 2026 17:26:16 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.117.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e61c191basm35475881cf.16.2026.04.20.17.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 17:26:14 -0700 (PDT)
Message-Id: <282f906d1b4767d95e2a66072c280c2294a93a9f.1776731171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Apr 2026 00:26:07 +0000
Subject: [PATCH 1/5] merge-ort: propagate callback errors from
 traverse_trees_wrapper()
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
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

traverse_trees_wrapper() saves entries from a first pass through
traverse_trees() and then replays them through the real callback
(collect_merge_info_callback).  However, the replay loop silently
discards the callback return value.  This means any error reported by
the callback during replay -- including a future check for malformed
trees -- would be ignored, allowing the merge to proceed with corrupt
state.

Capture the return value, stop the loop on negative (error) returns,
and propagate the error to the caller.  Note that the callback returns
a positive mask value on success, so we normalize non-negative returns
to 0 for the caller.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 00923ce3cd..4b8e32209d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1008,18 +1008,20 @@ static int traverse_trees_wrapper(struct index_state *istate,
 	info->traverse_path = renames->callback_data_traverse_path;
 	info->fn = old_fn;
 	for (i = old_offset; i < renames->callback_data_nr; ++i) {
-		info->fn(n,
-			 renames->callback_data[i].mask,
-			 renames->callback_data[i].dirmask,
-			 renames->callback_data[i].names,
-			 info);
+		ret = info->fn(n,
+			       renames->callback_data[i].mask,
+			       renames->callback_data[i].dirmask,
+			       renames->callback_data[i].names,
+			       info);
+		if (ret < 0)
+			break;
 	}
 
 	renames->callback_data_nr = old_offset;
 	free(renames->callback_data_traverse_path);
 	renames->callback_data_traverse_path = old_callback_data_traverse_path;
 	info->traverse_path = NULL;
-	return 0;
+	return ret < 0 ? ret : 0;
 }
 
 static void setup_path_info(struct merge_options *opt,
-- 
gitgitgadget

