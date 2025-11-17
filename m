Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D69314D3E
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763366678; cv=none; b=CMdcg0RTiUlSTKnm4Cb/GXZwkHwpLHiZPOmtYqqddT14gxpuD/3ZwjLgex8xqxiKUMQfqXdrEpKFskko/gCoNxEk4k2sv3VllWYxLDZEliLLYZsejQp00LG17FidCnZuPT7QM9PWRkZeBMcCQutOQPaOKQmHOaEpy989Xz0vRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763366678; c=relaxed/simple;
	bh=VUvSJQJIn3YTcgiSaWCmUg0FFa02AAZiYLRbpoIrQKE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IXS2BjfaRI7cgwGG5Ln+xxS0FwqBu5Ob3s25MP0HILo+RbdjEq+C6wceiqFnyREI0UaJ3hIg0lKnqokV2G0GDLgnXzMHK+TCH+im9pIflEABEzzLudlvE6ZfSOL5MYCP9lrflIoFtxA5sO8Anw4qlvqQsBxVLMFXBpGreQrBsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHXxtba7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHXxtba7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-298250d7769so26237335ad.0
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 00:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763366676; x=1763971476; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oYmaq/d8Mry/0RMhSuS6d2i+YwJ1D2Xhm1tUJyqaGE=;
        b=RHXxtba7npe1I3yPOCDDhNpm6UtsXkDOB80vTvW32YsY/4nPQW3wd9xINcHEaig2Sv
         VE/JqPnwoVWZaZyj69PhcOIB8j+d45CjMD/5v4wGalEtc/7Sxhyc4L5vqF7tx1Fyhc+I
         SokZHr3+42saJD4i/2fjmPK3tdbwHrat5/YijHSbmvjfg4WbXgKS8G45WdFnO3KT0sG2
         EHpyckzy6wgBNfgoDZ82b3Ggeh1/NdJORlvM2z0ZzIVg+fq8SNLpGtX5ZnicWLf2Nsep
         peGr3tntPfXWapnR/Yu42n3huXYnTrBI9QX04fwpmxk2T9qau++jNfk6Y99wW9DnN2nd
         HaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763366676; x=1763971476;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1oYmaq/d8Mry/0RMhSuS6d2i+YwJ1D2Xhm1tUJyqaGE=;
        b=LIDtjL57kXE+Mq04FA6ghRSzSWRVo3hoZ8Fiz+MeaUHPAeYZKvh3NlBjWYBNNjAV16
         s/NKj2hZF5vb0IN2wok7aX7l3SV82bOoe+brSl3ggzYuiG7bCtwohCOBUlhh8fEWxlx/
         dZg8sj4RdHqs1oYuWOd+vCdzx//0kOlwTofIyiRvAH7ZEFnN77fIUQo3XziD7AS7ekgt
         eeFiyJ3HTYXy0OdOxOGfTmn4dlt2BZHomodVtEVJ5TroWGXFegE5WWh+FG5KT56JkdVw
         uPXKf3K5RoigyogJK0xGirJQEzZpqPU5mNESMS5Tkd8MnbyB+CB3yQn3oTKfu0HbVk59
         03ZQ==
X-Gm-Message-State: AOJu0YyfD6M4GTL90fbB/NbHb5me/m85ZDT/gsMYJXPGQt/U1yVX/dF/
	Kiwngx9S5Wbc/p3BjbQG1TR763dPgVUXvSZlSfj0kwWUTloigw9MEKsVhui4YPIU
X-Gm-Gg: ASbGncsVfITMLqOXbK21bQQHe0PYvJi2wAkLTqa4ATdKOTXx6Gwg+y8bIa7TUfcD1X9
	wab1l30zREzZQ+qBHdXHgKE8jpThJKXNYZOSLj5TnY6zqS4bPk3vX1Qh4j5L4RmhJUG+wWB9nlP
	+tFio6enpOtqlrVUqRKkhxv2U9iwNBpVa8XV8fVNl5kYabNL70KjXbOt8Mj3c2BqNDcc/5IqPsp
	pN4ZEg1ZybyX2CUZuLqMWSxCGW/VWvqaQqemyU1IYDzaklWRViu8RiSjkfBAY9QkCN4MTGhf1ga
	Tcnk6ZDRiioJ6QK3bZ86B1MUHhHp+1wjLEqS86oD7iN48lBKNnVA34dTsmbQaR6MJsgsn7FMlD1
	OHtbeJondx/aOFBhw2f34iG1H7zgEwHeIYN5Tk2rLDYzOQBWCJMsRXVC72X7cvAUpbLABsZ3Ryr
	xbS8+aE9CkgCN0
X-Google-Smtp-Source: AGHT+IES25/YoYhTxVKuhqSRbmd2irhi5UTB9Te9REfZhThtrRB4Fog+5IAGQ8SS+SlB4934N6aBHA==
X-Received: by 2002:a05:7022:1608:b0:119:e569:f279 with SMTP id a92af1059eb24-11b41200308mr4630695c88.34.1763366675529;
        Mon, 17 Nov 2025 00:04:35 -0800 (PST)
Received: from [127.0.0.1] ([52.161.74.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088625sm46435337c88.8.2025.11.17.00.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 00:04:34 -0800 (PST)
Message-Id: <48467154368ae0970f526d169528e4b199e690ed.1763366672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2075.v6.git.git.1763366672.gitgitgadget@gmail.com>
References: <pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
	<pull.2075.v6.git.git.1763366672.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Nov 2025 08:04:31 +0000
Subject: [PATCH v6 1/2] xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
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
 diff.c        | 1 -
 merge-ort.c   | 1 -
 xdiff/xdiff.h | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 87fa16b730..cdcd11f1f7 100644
--- a/diff.c
+++ b/diff.c
@@ -3527,7 +3527,6 @@ static int set_diff_algorithm(struct diff_options *opts,
 		return -1;
 
 	/* clear out previous settings */
-	DIFF_XDL_CLR(opts, NEED_MINIMAL);
 	opts->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
 	opts->xdl_opts |= value;
 
diff --git a/merge-ort.c b/merge-ort.c
index 29858074f9..23e2b64c79 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5496,7 +5496,6 @@ int parse_merge_opt(struct merge_options *opt, const char *s)
 		if (value < 0)
 			return -1;
 		/* clear out previous settings */
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

