Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85E3E3D86
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914513; cv=none; b=POF6p+L4gWicFN5FZqU44YOR6/YxVOn8PasQYESBDe29mOYkDWZrYfpjgkOjpLUfjUY6fOzLLv++eWqvflyi6Rvc1dqQShIXEngKU/wAzu6Pl8B9gD4rN+CkUsiAYTezcUCdBVh9mcEKTiNh1uZz2DKRMu87jjdAskAOwOsRPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914513; c=relaxed/simple;
	bh=PyaBD/Sc7hBvjQBUW3KATaLrrLVIfE0TAodLhq48Mb0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=shmT5n2vo8SHfQJ7iO2vmGZ0kR5DUdUunT4viYuFF9A2Fx5d8JEGHEF/2dr1Z1E5iUIrJvQ6ev6Xi7NtDyLl/j8dYDy4ER7S/YsPqKZOEGd8c9FFEJnBs492YjLQiULI2Frb3Sbtde07kMWOzrBL0Ak04TvmkVLZloTm+h3QoKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiZ30XUV; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiZ30XUV"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d67a483d3eso498232585a.1
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914511; x=1778519311; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgDNeTtt+H+CTKzkdHIBt7oSXinFTX+FJ/k0/W1INaA=;
        b=CiZ30XUVgsJwq/sRJcGrB7Cf+K16SPxhlC8nDPTWtrXCgyl08SNYdXc2y+eEuv5Z0K
         CqYBMzGbjtEJuJZ/Dq+1ITNikS6CMvKvBdMGiW/dStliuAXbLJUP+e49dljMBzmiIcM1
         CzXXgBsunERKKYKrbVqVX5ZP+pux5rkywlDLlB3e80n7JnEA6o5IQyrJMz58jhbjosTS
         mKLQmwp9tr9/MAbGp8p/mB27EI9nIpDMtSfrV11bh4OqxzqQBScE29dbKSqthxdvmEkY
         Xas/v3HyyLbw7ZpWa6OnP+UyDOa3cSQpwHpz/PRizs9bR6zjMB7qdyVpkMdm3EJ2hgSC
         UCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914511; x=1778519311;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KgDNeTtt+H+CTKzkdHIBt7oSXinFTX+FJ/k0/W1INaA=;
        b=JL3n7WvN7rPcYW76+NE2h/kaF6P6wxpB6vvy6PuLiiHxfMQCn+oeYZCnUcxkpPbFDt
         B+3cB6EJhXh1kS8LzAeXQcLD1CY0Z8lQp0h+CxBlFrv47FSR+ahGhY7llYK9x1LifMkG
         FvH4ITXXeC9/FhZlKjLtIfvQv1q5AK7hbxmbOt49aWTqyMHFjxVvrBrgUxwx58M8jaL8
         PZ7ctaOqKov7AfcVPAVvXDrlZUbMjEkDIuBf7t/mL/2NXHNIfuu8o2yaMCPtFDvT1QRf
         gihgG6iHtGP5M45TRVUkQG3SMDrJc4icPA0ToSIkeooa7z0wG48W+2YkNRdVXDMiR2nP
         NruQ==
X-Gm-Message-State: AOJu0YxxZSiQAc28tk3XuLQxUTE+G1udfPLdTYf58WXSXUJijt8V3out
	qPzB2scidlSJR7BVCSrzDgxGZeYw85dZ2SuoC8/AiA3O7uMHKrmStoQpHZnPQ/LG
X-Gm-Gg: AeBDieu9LSyMKxpf3LocWTAoX099rZI+Nf6M1Y8KBlhhrsNyzqwOBtbHot1I/SBUezt
	D3vZIREZDu8/8awRGANX6e+NzjxRTThwYHHpSuK/Z4zwR/BPLp5YniuJuybM/P5YYSGxyD3Dz1/
	84b5sD07kCxINXzzjMeLNFxPuPluinZPPz4AYhp3bGXkGNQB4dtW/G3XpgGAMCG2ae2Fx/66i/R
	bHgQ5Vhn2YrFoW889EpVdBJm/WsKlaaIMykxSgood6fcMqINGiBuAvr5eqzP6Q76Th+obr9hVx4
	pLVRgbtyLPWbwxb8lPyz7omS0GuFbJyJoaiAAKMTx2lF/Vs56yCVbRNLbIiDBcXJmT3GxiN15WE
	Hu82IOKsvUFZRhWevo8LDGujfOPTQd6Y64ORb6SbUq9/7vDvF1gLN311f1usCZT1hoz7X7LP+a6
	/A4yucit/yMTeDu5iSo0z/btfNM0qEvo8z8F9w
X-Received: by 2002:a05:620a:7114:b0:8ef:15cf:3fd3 with SMTP id af79cd13be357-8fd18a2cce0mr1709754385a.58.1777914510781;
        Mon, 04 May 2026 10:08:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.231.101.45])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a80784sm1108824385a.12.2026.05.04.10.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:08:30 -0700 (PDT)
Message-Id: <dc660106ea8511e6adc44d2b70e9a4ae8b18090e.1777914508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
	<pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 17:08:18 +0000
Subject: [PATCH v2 01/11] index-pack, unpack-objects: use size_t for object
 size
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
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When unpacking objects from a packfile, the object size is decoded
from a variable-length encoding. On platforms where unsigned long is
32-bit (such as Windows, even in 64-bit builds), the shift operation
overflows when decoding sizes larger than 4GB. The result is a
truncated size value, causing the unpacked object to be corrupted or
rejected.

Fix this by changing the size variable to size_t, which is 64-bit on
64-bit platforms, and ensuring the shift arithmetic occurs in 64-bit
space.

This was originally authored by LordKiRon <https://github.com/LordKiRon>,
who preferred not to reveal their real name and therefore agreed that I
take over authorship.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/index-pack.c     | 9 +++++----
 builtin/unpack-objects.c | 5 +++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ca7784dc2c..cc660582e9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -37,7 +37,7 @@ static const char index_pack_usage[] =
 
 struct object_entry {
 	struct pack_idx_entry idx;
-	unsigned long size;
+	size_t size;
 	unsigned char hdr_size;
 	signed char type;
 	signed char real_type;
@@ -469,7 +469,7 @@ static int is_delta_type(enum object_type type)
 	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
 }
 
-static void *unpack_entry_data(off_t offset, unsigned long size,
+static void *unpack_entry_data(off_t offset, size_t size,
 			       enum object_type type, struct object_id *oid)
 {
 	static char fixed_buf[8192];
@@ -524,7 +524,8 @@ static void *unpack_raw_entry(struct object_entry *obj,
 			      struct object_id *oid)
 {
 	unsigned char *p;
-	unsigned long size, c;
+	size_t size;
+	unsigned long c;
 	off_t base_offset;
 	unsigned shift;
 	void *data;
@@ -542,7 +543,7 @@ static void *unpack_raw_entry(struct object_entry *obj,
 		p = fill(1);
 		c = *p;
 		use(1);
-		size += (c & 0x7f) << shift;
+		size += ((size_t)c & 0x7f) << shift;
 		shift += 7;
 	}
 	obj->size = size;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e01cf6e360..59a36c2481 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -533,7 +533,8 @@ static void unpack_one(unsigned nr)
 {
 	unsigned shift;
 	unsigned char *pack;
-	unsigned long size, c;
+	size_t size;
+	unsigned long c;
 	enum object_type type;
 
 	obj_list[nr].offset = consumed_bytes;
@@ -548,7 +549,7 @@ static void unpack_one(unsigned nr)
 		pack = fill(1);
 		c = *pack;
 		use(1);
-		size += (c & 0x7f) << shift;
+		size += ((size_t)c & 0x7f) << shift;
 		shift += 7;
 	}
 
-- 
gitgitgadget

