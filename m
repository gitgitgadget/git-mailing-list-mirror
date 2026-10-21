Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564389;
	b=jOu5f3bQgMb1GgkY8Uzd35LzXN0rYnLmhTEInZ85WVuMKumRSQzlPblNXz/keqaoPzsT
	 glETUPAdHGum75KVzrO+qD0w1vKfSx+h8+Xjbv9C9g33/rCv1GwaWTSYLaT5sTNDR6pvN
	 6lr18G/sJ6X3yn/g745qz/BbGUCGjcpNOj2AbExoyhgj81ZSa2bbUkvxBMkPipfP6zqaX
	 ROtZztCvAj9lgVuWdGVTdgbV921tQ36BFFwOaHskfjsAN5gt6gW+LQgDuaKsFGOa7PCkj
	 DS0FJQ9CpDqHF6SVYPuB8HUoLI+c0Bkf+IIV7FJENks5yfjX/otb2mvCduUOrsW9Jpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DFOxXbjnpU8cR3f6xYBr/dVBgB8ZtAjxKCFcd22kbxw=;
	b=n5DMoUnnq7KbN0JrcBF6zd43CZPjvJjOb2WXpdn5mG3s3YJp9e0KoS7Ap9+wRY79e+sl
	 QHN9G7ogbW1/AXnYntijFKeYevjV0axdURidRoL4+0O+MPC/byIfOCXyMZ50qCf4Re4z1
	 yxQBJ/mah6Wh69b6erJggfUU/7PoxHNgcM3noXCHvwfxFLD/0j8/2lxbABbF4O2o2T6Ab
	 wF+BTWdiowcNyq00RPOVJwS3St5E8GoQld2eCN1GFoTIJ9N33XDCd5UcRHPEJaRHUUcwV
	 AXAyL3q3eXFJIUl+UxfrzzXYKGfAuEj9S+zmX70rtFrTKQ2Z8rktD3axqh2ltIJGCnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FpcUFHxe;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2DA606A32A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F2DA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FpcUFHxe
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e011d370dso235872f8f.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564388; x=1793169188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFOxXbjnpU8cR3f6xYBr/dVBgB8ZtAjxKCFcd22kbxw=;
        b=FpcUFHxeB0C0vYHTK43eayzjaRweiLOmHS/sxcQf16z//wQoa5zeNZyjZERDcwVQ4J
         zdDiQw0K5uQF8+Lpqi+TxIdW6mlJKTHW7fTzZb6lzK7c1u+F8zaAVrfX6jRCBwbC/C3Q
         lfp4eXGmol5wp9iQcRCaAegPEj3bsdf5wuXEH9FEJHoW8xmCbSbGbH42Zey7ZXH9FX5l
         lkMwo3Jh4ZWNXtCA2jp6IjlIF22ImrF4i0Zpxlbouk5lRQ5XqmnIsF8hnwjLGPZXQ23u
         iuTz+h8VHfvyDmz0f2kqePd6wYKhIxxrUt4pAcsfLztmSfbVk5Thod0SadGEnJT8uKbv
         gwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564388; x=1793169188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFOxXbjnpU8cR3f6xYBr/dVBgB8ZtAjxKCFcd22kbxw=;
        b=fTbBrnpTEemRN7Qwsq2/gdfjlsV1JvDEzbLhXNwkQh4owxK91mxNa1fsev65Km4zKD
         R2ihGjDZdpqA4ChjvwSj6NBKTyjSk15+plUJBQhmshFKd3+QWCkZJAIWPO9gr3S39KxG
         qsRk3DsqKM1l8luWR/Zey5JmXG6cmiU6FWtBL8qRkuCi/5mNA+Ej0gqrIhtjVEi1VtU9
         mFWU9HLBriMDvOu3HoWXh8ztmtkaEhtAxRmmFZ3YHWund9Ulh1esbxY9Ws2iSaUfBmCL
         WSaSoy6lAix3zrmOtVm1+z7s5cwwIgLRDAcIQuc2z3kxyyOjN5xKHVpZP2IMOAqcjwlr
         tmpQ==
X-Gm-Message-State: AFq9FYKVCzrH5nfpQtnLdwIMRf3qt0iIdqlTY5QOUa7JkHrzKIl/cof/
	/IEEejeQC21wopbdAfRic9+J3yU8kYzS+1OGOSX6iy0b43oLRoDA42Ed463ekQ==
X-Gm-Gg: AYBFou0awS3I8ggfwhCiNOZHYLMHH7PftavRLbdjI+V11yyEQsSaUIAfQ9iZ63c7/Ih
	nmnfgYr7rDF0xFBVYU4JQQk+IiMnOCxnDbApXISikRiZE3Pa+dzCUdcnB5+vNf+76fT0yUs9DIp
	zEQo24pfu/O1Tlwfy/A4phkChfR9ynuu5fvhhEXGizwYug89EPdZNeVJC+n1cgWhVgL/RA/EPTH
	+T3rhBv/k2IUX67MJyRR0VufVJqT6NBk8eoPR2BYdDUTr7i6enb0omcS2AyV9sI6D3myb2Sfb3s
	xKZskKRamXpHjgEJ3fwRTM2rAql4Vk/EEsQipz4rnBDS+Lq4jxGdkAGbXHtMFwUnJ0yvfHksOe1
	xnr6aCaCGiEIc+nw4TccHNG8blQNNwWaQz4ZylU/uIIcRUBgYESu/vl/OOLsZb57p38N0IQGONA
	xaVgFmoa91BwVO/bEHKrS8/EUTwjZ/FBHqvifARLJGcCVC1epEE8daZQ9RmCzwXxbOc1u1VrzGV
	WA8BhpFLDitt9iDTV3BNZ7YxIw9nPO+htZb1Aari1xAOzYGPEBHhiavPmdAPJy9YgSQIW0Gbtia
	QxGB84uvkhG6m1tsXmVaCkHQAbgBlA3zIJ6haRmDbcYQ/U/fym2KH1lJ2yP3idULfRftmSMrNtX
	uSWt8iEnabHpc9YBwNVXSL+3V72mnBksdpyvc5A71VM3kDtbKuA5SwP3BXs2S6GPcpfE=
X-Received: by 2002:a05:6000:4026:b0:48d:f36e:ccc0 with SMTP id ffacd0b85a97d-48e263a7b5amr1862155f8f.0.1792564387825;
        Tue, 20 Oct 2026 23:33:07 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm3130790f8f.14.2026.10.20.23.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:33:07 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 03/13] loose: add a flag to control whether we write mapped OIDs
Date: Wed, 21 Oct 2026 08:32:35 +0200
Message-ID: <20261021063245.2917625-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261021063245.2917625-1-christian.couder@gmail.com>
References: <20261021063245.2917625-1-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Right now, we always write the object to the loose object map.  However,
in the future, we'll need to temporarily store some object ID mappings
in memory so that we can rewrite other objects, such as when we're
indexing packs.  Let's make this easier by setting a flag indicating
whether we want to write this to disk.

The bottom six bits will be used for an object type in a future commit,
so pick 1 << 6 as the write bit to avoid conflicts.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 loose.c            | 5 +++--
 loose.h            | 6 +++++-
 odb/source-loose.c | 4 ++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/loose.c b/loose.c
index 8d7ea27448..090681b4b3 100644
--- a/loose.c
+++ b/loose.c
@@ -212,7 +212,8 @@ static int write_one_object(struct odb_source_loose *loose,
 
 int source_add_loose_object_map(struct odb_source_loose *loose,
 				const struct object_id *oid,
-				const struct object_id *compat_oid)
+				const struct object_id *compat_oid,
+				int flags)
 {
 	int inserted = 0;
 
@@ -220,7 +221,7 @@ int source_add_loose_object_map(struct odb_source_loose *loose,
 		return 0;
 
 	inserted = insert_loose_map(loose, oid, compat_oid);
-	if (inserted)
+	if (inserted && (flags & OBJ_MAP_WRITE))
 		return write_one_object(loose, oid, compat_oid);
 	return 0;
 }
diff --git a/loose.h b/loose.h
index 6f0c8554ca..19d3be26a3 100644
--- a/loose.h
+++ b/loose.h
@@ -3,6 +3,9 @@
 
 #include "khash.h"
 
+/* Should we write this object to disk? */
+#define OBJ_MAP_WRITE            (1 << 6)
+
 struct repository;
 struct odb_source_loose;
 
@@ -27,6 +30,7 @@ int source_loose_object_map_oid(struct odb_source_loose *loose,
 				struct object_id *dest);
 int source_add_loose_object_map(struct odb_source_loose *loose,
 				const struct object_id *oid,
-				const struct object_id *compat_oid);
+				const struct object_id *compat_oid,
+				int flags);
 
 #endif
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 3c0c85f3e3..b58184f31d 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -848,7 +848,7 @@ static int odb_source_loose_write_object(struct odb_source *source,
 		return -1;
 
 	if (compat_oid)
-		return source_add_loose_object_map(loose, oid, compat_oid);
+		return source_add_loose_object_map(loose, oid, compat_oid, OBJ_MAP_WRITE);
 
 	return 0;
 }
@@ -970,7 +970,7 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 	err = finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
 					 FOF_SKIP_COLLISION_CHECK);
 	if (!err && compat)
-		err = source_add_loose_object_map(loose, oid, &compat_oid);
+		err = source_add_loose_object_map(loose, oid, &compat_oid, OBJ_MAP_WRITE);
 cleanup:
 	strbuf_release(&tmp_file);
 	strbuf_release(&filename);
-- 
2.56.0.215.g47fdf2208c

