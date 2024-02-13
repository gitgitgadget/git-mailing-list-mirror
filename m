Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2615612EC
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857550; cv=none; b=IQeMWS2pZE+yHNcIKyWlqQQ7Mxbd9D5z1VHL5bkxRLAvxI8bLJ6dFdikClnjLaI9QyWNJSpM0jBkZm3f81ur2Xg4WskLdzpayDybxDdL9YaW5+DtLBrspyhjdzZrbtCLByeWTPDXitT0EbecWLD7KUC943+v/+LStAelBbR0lxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857550; c=relaxed/simple;
	bh=0oR8UJB7BkvLV8+AVoLG7D8rlN5I6mw1FkftJDJPCO4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fOqy80eSaPbBw8t3/IPI+sa7Z9zMI0tEVsGEtVbTmj+78pAX1LF+81SNYSgpSiGryn6Ff9xbqt1NOGa4sM9W30l/kKzVSnZSuVzvo70xZ5RHOTWSkzJyeL/0AsAQnyKW1JAEmqL1Gh8scxhOg60wt0+xV4XYcqXoPTp8ayHNZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/0JGtz7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/0JGtz7"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d10ad20955so12048231fa.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857546; x=1708462346; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmJzcER7dyAQ6IaPoa1NWpxspbx67eGtS47TAXW/aOk=;
        b=D/0JGtz7nEjKoWDBIK6nl1R1y6j2g+QBCYTR3x1qQMcKettS0lp+K02DCgPKqrKa1q
         Iccy6k/gGzNxwPSvGLWKPnmNNr+g8nVdIPxyQI4JEiPJM5iOHS/An0eg+llze8Ag89tj
         OUCHz/G6V5Kvb/RF2QKeuDWiTk1TgFBq3DB+lTLPDZLnqghMdkfFFy6p4Dw+ET3kzFjw
         F7vQlk289QhacZWMLyoPZkB9zMO5+uM04TCBq8cdJfuT5DloKlCRvOQ5H1ABKb01b01n
         LaxKpKiugLkKe1M1HadSOHUk5sfj5KcT/7B6xxutWQke8bMLF07jntVvXpC8k42x2Xtg
         1Euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857546; x=1708462346;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmJzcER7dyAQ6IaPoa1NWpxspbx67eGtS47TAXW/aOk=;
        b=D0CfQr/wrmCWF0M/67fzzY05ob+fPshr0FjnHs0g7oNX+etQyEdIhYxr1ZTSEJXFoa
         Z4ARibIdkklmj3rWkcLW3ptEiHJIdxHkUjDctypakFmjOiUTItsC4qpHmsxNnp47Svzy
         cFP+UqQcyhSGhWQiWH4mF94kTy8/MMPIjY/cVskEounmtTIxqhaWBXHLd0g6UimMCCwj
         yo6RXlLfGD3CKl5EPHqWtYUowjGikRP/1VuyziSuU06rREICKPizD3PyJKaVLoZkccuT
         Qa7rGJjT7STvvYo/W7mM+NsrSHQSjCdjqfz5Dhl9q69TpZHQGs6Qv9JIA/qgZ/tqFzGE
         vOvg==
X-Gm-Message-State: AOJu0Ywh9e0HSb5gmzyGgKZi8AXOAcdZ9Ful9N9doXtoCEcZSWrmu66Q
	alzD/WwwJJlnOPAsxfwstF6gYUEk5zXcXVFA3Rt42kauQcmTH6Tj5VGMEFHt
X-Google-Smtp-Source: AGHT+IGhYLNW+dJI6cbETArciNmQMmQCEQBwlZJgxdvLe+3uzXFxIXBpRf4BTSgnK7Fe933PuHAI0w==
X-Received: by 2002:a05:651c:314:b0:2d0:b6c4:2180 with SMTP id a20-20020a05651c031400b002d0b6c42180mr416824ljp.53.1707857546424;
        Tue, 13 Feb 2024 12:52:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id js26-20020a05600c565a00b0040fe3147babsm12654923wmb.0.2024.02.13.12.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:52:25 -0800 (PST)
Message-ID: <3fb8e0d0a7c0455cc7a5ba28c12736fd4bbbd44e.1707857541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 20:52:13 +0000
Subject: [PATCH 04/12] fsmonitor: refactor refresh callback on directory
 events
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
Cc: Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index f670c509378..b1ef01bf3cd 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -183,6 +183,35 @@ static int query_fsmonitor_hook(struct repository *r,
 	return result;
 }
 
+static void fsmonitor_refresh_callback_slash(
+	struct index_state *istate, const char *name, int len, int pos)
+{
+	int i;
+
+	/*
+	 * The daemon can decorate directory events, such as
+	 * moves or renames, with a trailing slash if the OS
+	 * FS Event contains sufficient information, such as
+	 * MacOS.
+	 *
+	 * Use this to invalidate the entire cone under that
+	 * directory.
+	 *
+	 * We do not expect an exact match because the index
+	 * does not normally contain directory entries, so we
+	 * start at the insertion point and scan.
+	 */
+	if (pos < 0)
+		pos = -pos - 1;
+
+	/* Mark all entries for the folder invalid */
+	for (i = pos; i < istate->cache_nr; i++) {
+		if (!starts_with(istate->cache[i]->name, name))
+			break;
+		istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+	}
+}
+
 static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
 	int i, len = strlen(name);
@@ -193,28 +222,7 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 			 name, pos);
 
 	if (name[len - 1] == '/') {
-		/*
-		 * The daemon can decorate directory events, such as
-		 * moves or renames, with a trailing slash if the OS
-		 * FS Event contains sufficient information, such as
-		 * MacOS.
-		 *
-		 * Use this to invalidate the entire cone under that
-		 * directory.
-		 *
-		 * We do not expect an exact match because the index
-		 * does not normally contain directory entries, so we
-		 * start at the insertion point and scan.
-		 */
-		if (pos < 0)
-			pos = -pos - 1;
-
-		/* Mark all entries for the folder invalid */
-		for (i = pos; i < istate->cache_nr; i++) {
-			if (!starts_with(istate->cache[i]->name, name))
-				break;
-			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
-		}
+		fsmonitor_refresh_callback_slash(istate, name, len, pos);
 
 		/*
 		 * We need to remove the traling "/" from the path
-- 
gitgitgadget

