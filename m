Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19A1ADC7E
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393586; cv=none; b=NbO6PaeujK4P6LBIvXHHt9927wyMCW0x+BlTIS6Gt8f/X7NZzvMabpT1VMZkmggwYH1opccOq9gxfzU1lAngrDksTr8CNVS/RwRYqIWHintqFvUpNn4ipowFX7HvMcTaXv/CbZDcG4K5lMHxrJJ694LhAt5yMORj9El3PfniwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393586; c=relaxed/simple;
	bh=PyaBD/Sc7hBvjQBUW3KATaLrrLVIfE0TAodLhq48Mb0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XkbGoP7FrgZ+n8H7EWN0rAcn1JoZMSP4UewrW4Ob4pDMLpLH1/GkGkpCpzZyeiZDIomZ53gLm/Q+FYgvTjOOMzxLi/pu23zuOhI+PhlYTqv6E4BO27OVaKwbNT1ONF533wF6EsBJx2ELTEqvqlhmj6SfDW4zx5t1Sb4qWnt5wtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0f+ByMp; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0f+ByMp"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-479d9b155deso3165650b6e.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393584; x=1777998384; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgDNeTtt+H+CTKzkdHIBt7oSXinFTX+FJ/k0/W1INaA=;
        b=i0f+ByMp4cCHNNMinoePbzXNCa6ExM1ocBYFdYOtQ6f7xG5xfYDtw4hTE4YkTPPM54
         GelncF5BTG4JziEU56IvJrGxjYu3X06OPDXY9RySY7uWxxYAJoLZkPSujjX+1UlHxdI0
         jbkE0jea6tRJaumD/UG+YfRMXP+tNXvpacxwCXOu0E9PFf1VcHPtUjyHAbZFDy7X4wpB
         pZttr+fu8hOwyTMa0ywq9Z5Kot8gxwYTZudKU4g/9D+fTdM57Ih11ZxFsStlBiY9LI+F
         ZZDSyt9m6lfTCbnamV9UxnkstRIveA99aGtloHM2WBsgrUoH8AZ1r5OZoFCV2TTd6oJ+
         u4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393584; x=1777998384;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KgDNeTtt+H+CTKzkdHIBt7oSXinFTX+FJ/k0/W1INaA=;
        b=BTiFaWI8AWe7wJZfqpyMzk1XauE4fg7/VLMIeAVFOB3VBbANuuA5jqIuGnRyRM/s/r
         26hhvB0I3W3HrS48PXxkD5Lf+Ky4Ai1uZVnxpj3E8J1lrK2YscKD9jVlSS6aUFQFjKbx
         xIq9FHA3+eSJKtA62S3OoM3VLD5UriYnO+rZ8H1GgCOZ3h92DBTMN6Nx7VA6Wldkf8cl
         yGuXWDj4Y1SlNwyEWWdJuhX/aHuNNixlkFFhUoesjCLbXKBtespRyPhOROyWqiY8dXYH
         8ViWec6AD9Apk1h3TWYc/MLbXDc33Ho3XZ7K9MqnPF1rDzUBXfULNIuewTEE6velONhe
         BNEw==
X-Gm-Message-State: AOJu0YygyGFhWfrElychQmaZokdDsAkNvuCZ6VznwyFEzOicfG6+MKSD
	J3c4/GPSNAIm+MDQ27TUuAXbIqDAIk9Lwe3gjiwSHTNxaKiCSFgS4RXD2v4uUA==
X-Gm-Gg: AeBDietBloST8ppskGTs1nInUFhANrnmH7d8kzD+Kjvp3kE9B3Rc/kbNCElTAfMDwjt
	H/unRvVa5qi5b20YBU47koUP3ySRXuztLDI7fQ+3XXqgpMVYUgzP9KJejb1YQVxQUwCpjLLUkAk
	lSmXtUiM/+V7gGsCT/2uFivLdpX0KY1vAUmz5dl3mNeBYwaKudKfyutIPEkJrTR2lvUCP19OB8J
	c7fVYSajMjoH5pwB7YQTwKN5/muA+j4BJQ244Huoj8vSoZZiYs9d8U2p/Wq4RDIzssav9oQ07rW
	2nevmnsEO+2MIotluZ8QFZIFjx2XaIg1oDjNx9t7/NdELcKKsyAUooDfbVY111hkgxTU3aRgaT3
	xwrhtKyMopZiu1ViEwh39rz98A45ZDtPRsJPpDuaaT0Jz4GRb4Ebl0fsd8wFc+48EGu47tEFhVx
	Ps/gWPYK8x2hySExzEvswNUwKSPira5SCsGM8bMOQ=
X-Received: by 2002:a05:6808:1211:b0:47b:e097:b8d with SMTP id 5614622812f47-47c2906f502mr2064569b6e.42.1777393584028;
        Tue, 28 Apr 2026 09:26:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.163.230])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7de986d82c5sm1962866a34.23.2026.04.28.09.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:26:23 -0700 (PDT)
Message-Id: <dc660106ea8511e6adc44d2b70e9a4ae8b18090e.1777393580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 16:26:15 +0000
Subject: [PATCH 1/6] index-pack, unpack-objects: use size_t for object size
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
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

