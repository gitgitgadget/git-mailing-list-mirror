Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119533DC4AA
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890011; cv=none; b=pl1V/brLxdAA+5Do+MyB9zors92U7amhmLE0oI4L680xX5p/vnf3o7KB0MuK9jtbxJ1dLW6Tq0XylnmODTH8V7uyTf+6c51tdAJpFtU7xyKkmR4w9lvr3CuqtOsHiB3IzTADnir1UJEROdhApOh75U05mtti0tZlO1vMb6kAEQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890011; c=relaxed/simple;
	bh=/tMhb1hF8evtEbXZhK5bKT9POH0y47YWJ6PEXp7J+P8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XCJHigbsqQjJKEAX003Uxk8xAKcaUzIJIScK6F/CwwYMSHe1slzo8cFAyRisXzsMdl9VBYgpFM/QF6kf4PDlJN8kZwtkNcxXaK23qgJdr5WmeWr7wvy4e4QbwdlZhK0FVzd8iakAlQRpFrnPI06IVkxaxd/2ueVzpl5iHJn6ZMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv67ymPZ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv67ymPZ"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d74aa6bcdbso2658578a34.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774890008; x=1775494808; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAh2YlWtHIQUSN4USii4XmZm0LRrKAOwgLHkCDgwEYY=;
        b=Pv67ymPZHINF5qbt64YYtLzYSmvBoG+pwR0XpFG9z7brecfeu5FP3qHcf3KPiL/w4U
         Y1OeWxi4yZPCrnbmVLdFts8GA2ruMNhf3MTkZrGgGo9kQOuOm3OK0cFU0Meg+mUhKLfZ
         kLXhMkMwtS+pktrp2AlSCCfJxkUQz6Oeod604MkThteENmE+JeJ4hf4eDFG58nAoStoU
         onOD7DVVtSgtu5bwP7HL7lpizN2i4usDeBc/NNLQjyKc3eaX74z42TBzey6RNNlqeFRe
         giWpii4SA6pZ5MTpKiOb9LYrdUVhG+LuZdtUM8BOrHwMnuZIml1peZhpKuY2h3Ay7FAX
         VMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774890008; x=1775494808;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aAh2YlWtHIQUSN4USii4XmZm0LRrKAOwgLHkCDgwEYY=;
        b=lL/Knq2SKwU/asbC9Ty3wH+8LQaqzEOf02eZE2EFd6j3hNh0Aecs0UVJSBlGVWolQ8
         +s7Zr8wIagw24OtVe1I7jWm0bIxZRc9vAWULcEEVS0FUVOXpFWtNqiGRlF8gL7DQCt0W
         bM6cc5D9wfthWpR5hDq91xLKgpmhj/5p8FwZUazTMUXT4xxwXvWurTa2Zd29lk7IVKWV
         onq2NxXWSPMXEPXNtAuqaGOrGF7fV5LspY5Snn7FW/wV1aiG3b6M1C+Oab87pxTH+RXl
         E8jEbG/o5xp1KTn6hq/v7QEBMwgl+W36f4xfxM8+tZJxFzHfFajlxqGcQMREbLAzUceZ
         kIXw==
X-Gm-Message-State: AOJu0YzUw6zydKynNcEYGKYfHd14IWJnOXEFjMcHW3GYsOwrmHdYpRry
	5z9hgIbO4yE19uGV3sZARsM18G0Ei3HUSUvYT+Q0jNjaCxfXklZ1y+VSS4vuKg==
X-Gm-Gg: ATEYQzyJ4+22E3RYizttTdBrDfWv6a2sjwxhmGIygmZdXvN/iqiBFM42dHdAZ0ib6p/
	YCk28tjTDay23aToUjXEPLWdaI0mPaK63PphAl1nLYkxXBuVkA/AW9Eq1tMdt1G4fIgJHMV2O4T
	bCC9p3PpRW+lA97r2HXFijP3fO/ZmoIE9oUhBWGyliF6bH2sZ5IVhYvxa972M/7yqVRFRzEdPtu
	h/qw/EbPgb0nKSdsWDN5mV7HFKxdMxuRHSdWnHGhRPRbal0DsNhWrHIHhF1LRAF3OA3Xt3VKuWI
	rxmdyfaMmv7pG0wM3l/Bghto0+0dbBHy/wLrpykvporkB5O3viZzRKwZ+J+3V4zGYlGkpW5TDLD
	vSxWKZVtGpaJ2mrjXRoFSu6uJ+6y0HOTrcp5SpTXcWHZ1tOh8DTP0ICZD2vYfg0TNx4sWuYn0Al
	2JgK35/sIkL0E8HbD+kV3R1r0WYmQ=
X-Received: by 2002:a05:6830:6d18:b0:7d7:51af:4aa1 with SMTP id 46e09a7af769-7d9faebe97amr7374539a34.18.1774890008510;
        Mon, 30 Mar 2026 10:00:08 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a7ea668sm6142633a34.19.2026.03.30.10.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:00:07 -0700 (PDT)
Message-Id: <86b0ad100ccbcd1812b24eabd0abe1987592daa0.1774890003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 16:59:59 +0000
Subject: [PATCH v4 2/6] xdiff: use unambiguous types in xdl_bogo_sqrt()
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

There is no real square root for a negative number and size_t may not
be large enough for certain applications, replace long with uint64_t.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   | 2 +-
 xdiff/xprepare.c | 4 ++--
 xdiff/xutils.c   | 4 ++--
 xdiff/xutils.h   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 4376f943db..88708c12a3 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -348,7 +348,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	kvdf += xe->xdf2.nreff + 1;
 	kvdb += xe->xdf2.nreff + 1;
 
-	xenv.mxcost = xdl_bogosqrt(ndiags);
+	xenv.mxcost = (long)xdl_bogosqrt((uint64_t)ndiags);
 	if (xenv.mxcost < XDL_MAX_COST_MIN)
 		xenv.mxcost = XDL_MAX_COST_MIN;
 	xenv.snake_cnt = XDL_SNAKE_CNT;
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index d6e1901d2d..48fb5ce6fe 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -290,7 +290,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	/*
 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
 	 */
-	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
@@ -299,7 +299,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
-	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
 		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 77ee1ad9c8..9a999acdc0 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -23,8 +23,8 @@
 #include "xinclude.h"
 
 
-long xdl_bogosqrt(long n) {
-	long i;
+uint64_t xdl_bogosqrt(uint64_t n) {
+	uint64_t i;
 
 	/*
 	 * Classical integer square root approximation using shifts.
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 615b4a9d35..58f9d74cda 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -25,7 +25,7 @@
 
 
 
-long xdl_bogosqrt(long n);
+uint64_t xdl_bogosqrt(uint64_t n);
 int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
 		     xdemitcb_t *ecb);
 int xdl_cha_init(chastore_t *cha, long isize, long icount);
-- 
gitgitgadget

