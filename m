Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BC0C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9615661039
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbhJ0Hvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 03:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbhJ0Hvn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 03:51:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EA9C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:49:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d3so2488790wrh.8
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oUOtW+VMfF77w6KugTIk7kk1SNVq3GaMJS9+jVTFH/w=;
        b=iyRWfxhhoYo1xRVdGec7S9jhK97i7IIsX7QnB1epZanyBCae4Oia4rZORQrvi+M3tu
         ibkUHS5u2mDM3bLiukkmf4VIkW7PrZyQ073365U3OQVvaYmUNRt+nnCk2MRMIpbhohOF
         S1yKYwk6ST0TsAfbgPO5oK0afDr/q2+Tb/VmMqhbzAcUCj4k/90uO4uv3/zxy5DsHNiS
         /7r6kU9bHh2sRoff8C3VO/MfpnAZdO7+eFWSu7cdpblM0dcUQKs93h/HoswZctVfrRit
         A5Qazp0bKE5XkUWsRSh5XQHwrYhzjz9JEFxcFLX9eBrkhsr9ucoM5DtrzMqAJAeyjOJX
         Y4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oUOtW+VMfF77w6KugTIk7kk1SNVq3GaMJS9+jVTFH/w=;
        b=kpFhvIMlRQDAO8/2HIVT8Q6JcYZ7EyHeVro4HfrxiUrLAj5z2kXIr5oVNywvJvyLhR
         tJ9c2SInqeThbnKU5GQW8Rrz3QhOwGkmGyYsU6o/ZC2srckFOJlVwBSKor1zGWIGb3dQ
         BWmUXBiej2YOvTE5ODKuQgX7pfhKzB/AcfzK9C0eOPalHqMrXvCzGLpdAWmeoLLrHK1P
         YXtLWMZ0IV0ZhT+/dKkCa1lHfdg5jz31HS9YB4mjwlY4E3+lbZZzzQOfsbXOyMpaI4wd
         zzlAyNoGHMqqBkQWt1aKjfIBtXIjkm57nrEsiUevObBNY6gVfRPX7THin/6WqmcBvk10
         gFNw==
X-Gm-Message-State: AOAM531dX5POCNh92qaUgZCmXO/TdbeKniFSQlFr23JF121oVBp2c31g
        Xfej5tKd3sYUzifsRuKpQx4++JBeErY=
X-Google-Smtp-Source: ABdhPJzfsndfSHG7w/FUBpppFAQ3ZBIkbMRZgfDuz04LsaY1OKaIcpQdFyZ4rZKOf0hfwYsDiNDJBA==
X-Received: by 2002:a5d:6d8e:: with SMTP id l14mr38320523wrs.304.1635320956354;
        Wed, 27 Oct 2021 00:49:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5sm21702536wrg.57.2021.10.27.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:49:16 -0700 (PDT)
Message-Id: <bca013a051117473bdfbaddeeb05d519b7c76ed2.1635320952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 07:49:11 +0000
Subject: [PATCH 4/5] odb: guard against data loss checking out a huge file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Cooper <vtbassmatt@gmail.com>

This introduces an additional guard for platforms where `unsigned long`
and `size_t` are not of the same size. If the size of an object in the
database would overflow `unsigned long`, instead we now exit with an
error.

A complete fix will have to update _many_ other functions throughout the
codebase to use `size_t` instead of `unsigned long`. It will have to be
implemented at some stage.

This commit puts in a stop-gap for the time being.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 delta.h       | 6 +++---
 object-file.c | 6 +++---
 packfile.c    | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/delta.h b/delta.h
index 2df5fe13d95..8a56ec07992 100644
--- a/delta.h
+++ b/delta.h
@@ -90,15 +90,15 @@ static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
 					       const unsigned char *top)
 {
 	const unsigned char *data = *datap;
-	unsigned long cmd, size = 0;
+	size_t cmd, size = 0;
 	int i = 0;
 	do {
 		cmd = *data++;
-		size |= (cmd & 0x7f) << i;
+		size |= st_left_shift(cmd & 0x7f, i);
 		i += 7;
 	} while (cmd & 0x80 && data < top);
 	*datap = data;
-	return size;
+	return cast_size_t_to_ulong(size);
 }
 
 #endif
diff --git a/object-file.c b/object-file.c
index f233b440b22..70e456fc2a3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1344,7 +1344,7 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
 				       unsigned int flags)
 {
 	const char *type_buf = hdr;
-	unsigned long size;
+	size_t size;
 	int type, type_len = 0;
 
 	/*
@@ -1388,12 +1388,12 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
 			if (c > 9)
 				break;
 			hdr++;
-			size = size * 10 + c;
+			size = st_add(st_mult(size, 10), c);
 		}
 	}
 
 	if (oi->sizep)
-		*oi->sizep = size;
+		*oi->sizep = cast_size_t_to_ulong(size);
 
 	/*
 	 * The length must be followed by a zero byte
diff --git a/packfile.c b/packfile.c
index 755aa7aec5e..3ccea004396 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1059,7 +1059,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, unsigned long *sizep)
 {
 	unsigned shift;
-	unsigned long size, c;
+	size_t size, c;
 	unsigned long used = 0;
 
 	c = buf[used++];
@@ -1073,10 +1073,10 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 			break;
 		}
 		c = buf[used++];
-		size += (c & 0x7f) << shift;
+		size = st_add(size, st_left_shift(c & 0x7f, shift));
 		shift += 7;
 	}
-	*sizep = size;
+	*sizep = cast_size_t_to_ulong(size);
 	return used;
 }
 
-- 
gitgitgadget

