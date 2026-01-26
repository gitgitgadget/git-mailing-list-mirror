Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170C2ED873
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424568; cv=none; b=AhftQ51YtGrntbo7zj/Lt58UVZ1CEjUonQVvyJ8P5oqN/fhBgV3hMl6MkNZj4kf/wiywJ5gxQydp9n82gc0AZNwqd6lIECEVmzDogMeEFzXp/0m+ZTJEf5ky1CxGJf8Y8Vob8WpL07NZqQnV0GINJmshaNKCHENIiPR9w8tF3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424568; c=relaxed/simple;
	bh=8lsSstAk9NUPvaDJuoU7JjJK24EKjkuaYvbFEc0qTVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr2xniVSQ+3pRBc7GtXGnqCc/UQ3O/NelphCDy0Y/r7YJFPy5/51lzL2RHSQ/mn4ZuAkPHvNwXGMIOujbCRFBotNgUmhOuJg8e07GaN4U0CbJZRYfM0y+E3quhSz94mU5kgCj4rBd19lRMOrL+C/b7ymfKiVQ4QC4nZety92BhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2OptI1H; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2OptI1H"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so45786615e9.2
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 02:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769424566; x=1770029366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QUic+D+HlW5Xo1EDsNcur5TYoc56pE/tI72cYgK3BaQ=;
        b=l2OptI1HkUc7Ka883U5qn8Yn7WS43hIngb5YVrHCWaZQl5q0SvUGF4nb5F2W7hBg9U
         YyLqDrwwMwHQJ9kPITqU4735XGgC0m7Ggak34gixWSl8UB6GVEq29tnn+8khBah0Z3nO
         7AXRjs9Horj/X0Beq5OTfIpNtwfMsh/bLwHot/g2jfSf6MqqESaFh5Pl1eGNnvovRuP3
         I0MCNPud1FdE2I8tvXRNqT1ARb5ZXZcijcgm47pzdHab9Ri1g+LHGSioVHpP4+H7PABJ
         ho/8KFv+pkWWPBqM21HczbBaWDloTVDHp7JR9TKq7q+S7yZ2Y5UuR7Wj//ezUwwbyolX
         0oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424566; x=1770029366;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUic+D+HlW5Xo1EDsNcur5TYoc56pE/tI72cYgK3BaQ=;
        b=X5nxhVJyFocDvB45DIy0y1K7m3wJA/Agk5+oOM0s8zFJf6SwjWtLVCCPzpGhlkSSjW
         lTQ5qrgoqe+s2gUCeJho/E2Fs1DRjVx2vpr2YnZDPfvzkGwCG0taUqUnAElrdmNt1BAK
         xSwoW0m0VA32srN+jnQmL4TJcyRV0wMPCH8/Cq8+CJhGGua7s9jdxFc19QtfIMneaqxG
         klphF9JIfDsyxAq9RHcyq0jAUWpHB6ZsOzWje0wrCoZF4IUdxytv2TlPcF741j7FlYw/
         aXekFpnQZArhVwBP1CfHhYKQlUnzs+1kW8VGZYMREehnwbILr1Mp34KBZnesOWHbQoBv
         +XTA==
X-Gm-Message-State: AOJu0YySe1c6xpbVLYBKDC7scToZ/h3FFTbf4gLFY6/CS+9EPDKDtxTG
	7i1KkzRZ/XSc50nuRyCbjcLWjvUd/fFMtq0VvnqWovWvT5f9vAzEfjdZsHsvEo59
X-Gm-Gg: AZuq6aLXAc3Ut6jV9DOhT5D90jdRm6Qu8V/OkR4txiltHY44u3F2lX23MDECHSJKW8l
	PKVnGM8IAFgRUb8TIFF7JAAFW1AtsWZDVcMKx25ZgYlLTObKHu3FobFOs5dG70Y8MSqalBqexVN
	rteqz0HVN7RGRaIux99U+39GeH59FouWyLJZXlDrje+Wce+LXo9DBlfr95Gochq4VgGsRqwAoHy
	U66Pm2Yl6borjByRV7T47/VP/bcC44GwwCIcydiQxQMW4SGPCpexK25cxGtQNBWVp9krguT+WVm
	nbFUpAa6Ffx1P2lfh/LMxnMehKchkP5ZseGzhQlsclvNHsOo2YfjAWQNM6cz8eBUTMRsnWKLcR/
	nREsygfxcEdvSh8LVnIe6D/y4D15HbvdNfefq1VNAZ2r326bONoBlFTBKhOzdXCsSKtSZruCPwA
	36CM6igKklqndYDpI=
X-Received: by 2002:a05:600c:35ce:b0:47d:3ead:7440 with SMTP id 5b1f17b1804b1-4805d06c428mr68475005e9.32.1769424565334;
        Mon, 26 Jan 2026 02:49:25 -0800 (PST)
Received: from berwick ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e7156dsm30063907f8f.20.2026.01.26.02.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:49:24 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/2] xdiff: remove unused data from xdlclass_t
Date: Mon, 26 Jan 2026 10:48:52 +0000
Message-ID: <0d251dfba505fe401d46bea912ec107eed0c6ac5.1769424529.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1769424529.git.phillip.wood@dunelm.org.uk>
References: <cover.1769424529.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Prior to commit 6d507bd41a (xdiff: delete fields ha, line, size
in xdlclass_t in favor of an xrecord_t, 2025-09-26) xdlclass_t
carried a copy of all the fields in xrecord_t. That commit embedded
xrecord_t in xdlclass_t to make it easier to change the types of
the fields in xrecord_t. However commit 6a26019c81 (xdiff: split
xrecord_t.ha into line_hash and minimal_perfect_hash, 2025-11-18)
added the "minimal_perfect_hash" field to xrecord_t which is not
used by xdlclass_t. To avoid wasting space stop copying the whole
of xrecord_t and just copy the pointer and length that we need to
intern the line. Together with the previous commit this effectively
reverts 6d507bd41a.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xprepare.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 08e5d3f4dfa..cd4fc405eb1 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -36,7 +36,8 @@
 typedef struct s_xdlclass {
 	uint64_t line_hash;
 	struct s_xdlclass *next;
-	xrecord_t rec;
+	const uint8_t *ptr;
+	size_t size;
 	long idx;
 	long len1, len2;
 } xdlclass_t;
@@ -101,7 +102,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 	hi = XDL_HASHLONG(line_hash, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
 		if (rcrec->line_hash == line_hash &&
-				xdl_recmatch((const char *)rcrec->rec.ptr, (long)rcrec->rec.size,
+				xdl_recmatch((const char *)rcrec->ptr, (long)rcrec->size,
 					(const char *)rec->ptr, (long)rec->size, cf->flags))
 			break;
 
@@ -115,7 +116,8 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 				return -1;
 		cf->rcrecs[rcrec->idx] = rcrec;
 		rcrec->line_hash = line_hash;
-		rcrec->rec = *rec;
+		rcrec->ptr = rec->ptr;
+		rcrec->size = rec->size;
 		rcrec->len1 = rcrec->len2 = 0;
 		rcrec->next = cf->rchash[hi];
 		cf->rchash[hi] = rcrec;
-- 
2.52.0.362.g884e03848a9

