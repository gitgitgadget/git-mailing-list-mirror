Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E96FBB7
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387466; cv=none; b=kc9TOcRH5r6p2/T7on6x5KMUwtjHxf3/3VmXlqkgPg/Ok0Uab57zaf9CAUP+zFyMGpVSJDtLm86C7lV6B8S+labOW5DrYq/eaP2TsdMoSVzhE8HNyy6gYrOvmbT6CuYROT7+4Z2TgVVAEeW+7psa/I3jwBAy8uMaGIveBpAnPLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387466; c=relaxed/simple;
	bh=Zb2rZ3n91uJ9QZzCf+DzAHnyKgWyohQNXoF2NMJLfwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2SzIVUYbNWfOLxjhe8tS+abKU+9sq4tn1gK3Z7fIFR85qnp31YSMVrZPtqqMkv2NiyiXbITa7V04tIVF9Jo22CK0LSYcOxl5erwB/b6bFuow2ywybCxjEoILVjIZd8ueO7k4U5fUp7XcybhdiMYDLHlJCOKXpJb2ALFFGpVN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GctpdTI0; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GctpdTI0"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-430ad286ab8so27049111cf.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711387464; x=1711992264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2NfsrsLd0gmM+HYYTMl1k0SuVIEutFba06YeUzqASo=;
        b=GctpdTI0fD3x5OB3TKn3DzC7XUXWORztD/iCwYo4/mw4eGQfbjv18qLcc4ifcY0e5t
         aLTN+HLKqPV7ycRq1h+PL4c0DBl2j/RRdi4D6lkkee+OBPs1WOHN/OvAvP9bQXFv6zwC
         xBUsblmxHOhCQLKKjt443EgyHr16vbWlLrso1GDqRBJIx0meHGd/h7aipFYxfu29APW3
         zXvX8BsqJHLgTF2nwp8XFa5EdBPyuP50+id0qdr7T3cyXG9Ai1tKPF96B+1roWmewYct
         DZbh41Fa6dAsVZPk7wFQKVEiQvVeHypvsgmtdggFEmIzD052yvbb59wBNnV4cBjQmNdu
         VMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387464; x=1711992264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2NfsrsLd0gmM+HYYTMl1k0SuVIEutFba06YeUzqASo=;
        b=Pxacz5wwmN8TgiuSBHL4sXzPN+Hjr4vOUwWvhMvO+Khf1WmnHXD0P2KZ9mWI7kvT95
         4CdLte/YVDVm68gKO8hj+BdARhDqrjMHwRaGHIvGLMYv8osEI/4UVFkZy7UTlYivYXlS
         hEco/dkeT/c+EKfUlLQ5rf7KXY0AboATNkoPHAwkkYsrkvpFHdNb0rNMfB/+jIFjVvBh
         fvW7F8EatDPWVDvWsw/CtcQAU49ULGkcP91LFFkj5QyXMWSNv4OjKrexuD5KRWjxXD7j
         f+yFUfy2OYzBO5yO0JCzuY2Diu2JyPVSe9pGtLMhzI4oBIMWJL+kBV0H9nw9hpsHwsaa
         pHVw==
X-Gm-Message-State: AOJu0YxS+LeK2tNmQbUyotumknr6jL3tZ8IUwWwEBuCoFmnsYDHJiV1d
	e13CFDs9483KXbq1JcVN2czft1QjOA17EeEz0xNTotgbVKvs8d5/VL4yJgedyjQeaGze90G98C8
	aMl0=
X-Google-Smtp-Source: AGHT+IGnvCsip3GhoxIaEVfgjLceUkIhP+L1PEPFhEiDhSg9y98ZNRXkCln7dCI8dVuZJp25t4iR8Q==
X-Received: by 2002:a05:622a:47cf:b0:431:5c17:60bf with SMTP id dp15-20020a05622a47cf00b004315c1760bfmr3067099qtb.26.1711387464033;
        Mon, 25 Mar 2024 10:24:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id eo7-20020a05622a544700b00431532ced95sm1448560qtb.27.2024.03.25.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:24:23 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:24:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/11] midx: extern a pair of shared functions
Message-ID: <b776fd528d39144780e50750bdc1013e7eb3477a.1711387439.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1711387439.git.me@ttaylorr.com>

The following commits will incrementally move code specific to writing
MIDXs from midx.c to their new home in midx-write.c.

Prepare for that by externing a pair of functions which:

  - will (temporarily) need to be called from both midx.c and
    midx-write.c, but

  - are implementation details that should not be exposed via the midx.h
    header.

Declare these functions as extern within midx-write.c, and introduce a
similar (non-extern) declaration within midx.c. This change will be
effectively reverted by the end of this series.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 10 ++++++++++
 midx.c       | 24 +++++++++++++++++-------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 214179d308..4aab273243 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1,2 +1,12 @@
 #include "git-compat-util.h"
 #include "midx.h"
+
+extern int write_midx_internal(const char *object_dir,
+			       struct string_list *packs_to_include,
+			       struct string_list *packs_to_drop,
+			       const char *preferred_pack_name,
+			       const char *refs_snapshot,
+			       unsigned flags);
+
+extern struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
+							const char *object_dir);
diff --git a/midx.c b/midx.c
index 85e1c2cd12..5f22f01716 100644
--- a/midx.c
+++ b/midx.c
@@ -23,6 +23,16 @@
 #include "list-objects.h"
 #include "pack-revindex.h"
 
+struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
+							const char *object_dir);
+
+int write_midx_internal(const char *object_dir,
+			       struct string_list *packs_to_include,
+			       struct string_list *packs_to_drop,
+			       const char *preferred_pack_name,
+			       const char *refs_snapshot,
+			       unsigned flags);
+
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
 #define MIDX_BYTE_FILE_VERSION 4
@@ -1347,7 +1357,7 @@ static int write_midx_bitmap(const char *midx_name,
 	return ret;
 }
 
-static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
+struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 							const char *object_dir)
 {
 	struct multi_pack_index *result = NULL;
@@ -1372,12 +1382,12 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 	return result;
 }
 
-static int write_midx_internal(const char *object_dir,
-			       struct string_list *packs_to_include,
-			       struct string_list *packs_to_drop,
-			       const char *preferred_pack_name,
-			       const char *refs_snapshot,
-			       unsigned flags)
+int write_midx_internal(const char *object_dir,
+			struct string_list *packs_to_include,
+			struct string_list *packs_to_drop,
+			const char *preferred_pack_name,
+			const char *refs_snapshot,
+			unsigned flags)
 {
 	struct strbuf midx_name = STRBUF_INIT;
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
-- 
2.44.0.290.g736be63234b

