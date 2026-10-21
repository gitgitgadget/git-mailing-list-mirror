Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564405;
	b=1X6jzozc13l5heFERhaz0glh70bXdzdOfov3R8dg4YzXWnTTTVTW9KEd4jDEft+2ZTlu
	 pC/Wj2Cr0t4c9Cbyajz/mYhkae+l+Go/vYg0yHAPyPsX5nZOO12pYBoVNGOTqCVTqBFmI
	 Rz610aglhrFsXy2ZehyYEvdUu8NZTEP/StE5DoNj94HB1BhigtqSb+BDTajUZkFgB+m/l
	 Wbq4dDGeHMwDuKH3EnQtDyuLQT1NJcFm3bLay+Dv+OtEEW9U4lCu2iJLwhQSspQMUiefi
	 JtrsVptlMzkbQBqGr7kLprf7ffcwz92y7xRfF7CmJouvnZvLqQyYjfZnRATN/Wh31Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z1qgCZbhvFch6UnvjHpuT6WErWPuWQRZDUI56rGGsrA=;
	b=sU4vQSeQlf22pog9iBm05VMDVfRLGtVIhm85pwO55846ihCY5F6OxQy8ruzA4lhKWFzU
	 uULl8SNzTz/AE7E5FNkCaChVH6dfCaHPG+XA86RgS3y7BbT28sDJd+w++uw3Y8ztEAec4
	 j3CqbwXX9t01258/J/RKjEPEAcpNCkKYx0U3ON36Vyi+2IepD2Z+Vml9teLLPYmeNLKAw
	 7KI5l2+siv/MVKTcWnhJVgpV8wIh9k1aW5j0U3gGtX7x/1C9tA+zIjAWKGFLAU4YMmuEK
	 VxDUwE7KqCHY3mIymeCYuHCYWd5ZolS5hlxn7iBTo2at+CX6uAyYYp6AZ3aV6N9aB+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HlnKu23i;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2FC60A262C
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA2FC60A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HlnKu23i
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b060ec084so239952f8f.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564403; x=1793169203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z1qgCZbhvFch6UnvjHpuT6WErWPuWQRZDUI56rGGsrA=;
        b=HlnKu23iy2kCGwkONztUVxl9tmQ89976w6a0VPIkqat4YugFvtX3OGkakTLAQCJ03H
         7c/JFpoog0t8G0gIiUGmXS3AcLmNRPDVKZFlarfcR+nx/oPvZ4Q5IsvmGx02bwscCd2p
         RK66hy7/U+sJdsF7NX3viWLs01VMVrftiSl9yABBBtJj+L48e1z9xmq5EawsNcvXfbMQ
         pq6J42c+ev05jD3EdU6lYFWrk08peiY9ylvrjANF71PvOgIeDRdayqDAduy3CyHyUyOS
         JCwkUF4J7Why8n6kMGAnUEwcCZlchj6yaCT9CD8hoPVTqdQnlKwlhKVmQe2kKBIN0m83
         aElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564403; x=1793169203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z1qgCZbhvFch6UnvjHpuT6WErWPuWQRZDUI56rGGsrA=;
        b=B1RI46Ek6xiLQoQSfGKTDrR1dVOH9ZX2CxASthzmTZJTto6ZQef+LZGjAY5Th0Oa07
         +g2Tv/0ynwxC8Zi2X5V6JruoIaeXORH6vN+p6opBnC2ckvUwsfuGRg1eByMK0AegAYKd
         P6E6HavheCJI2OCd8VJz0HFwqUd3EciYMmbGKvEr96rrsReysj02Pby5uYbIbJSukuNV
         +PGxgInnq+Fdm4CjnFlxlHYnRVcqXbbdFxeJw1LHN36zNMMtW+YyhEV0gAwTnW3ksr4C
         MLt7x4w2la5usqxJMKVDpt8YEA6Oc8zAADpF91o3QEgP7H5/RfANUc/+yXbaTuaPsC4x
         xNKA==
X-Gm-Message-State: AFq9FYL9P9+Z1kH7Rw7GM0JJkCZa6HUTk/CyCXKaKmKlfeU3hHlnDaCQ
	lCgjzG8NOIdfR5AeWfhPmZrSqYwxcpHMDsoZ72H6dau6762K2ifYyoMV24Zgww==
X-Gm-Gg: AYBFou3hzlk7AvAitRo9TAdQxU8HRjVDeCHx5NMKcBp+9xARAM2q/sIfY6/IXf2lwJU
	AZjb/7qkbZfZsP8XFEckAe2HyPFPoULMHhZWrAeFdR3+1ewgY/9F67uUtgcyCobhgCYYWFcuox/
	/lFE8ANOUroIkRW49RiKmfJUpZ+/pl7qnOBKK9+90KuIoE5n5EpMHziuqUroxGJLErx5Zexax6J
	uhpzJnCRWBLFq9YUoQXdyboXYho2C3bU16w6VlT12IFuMRAHInOUlfvTvF8CV8Q603O9bYLxrdN
	N1GVUB/hta6/8T3WRa1cJpdu8l5qZEt3vO+DZQvW3n9+Pb+G8cxezBdvCa7Z1s/NO9zjGTeN0v4
	YeOpCiqReeqEaqZVSnz6jFj3JU8DS7uK7bYXI2oaNOgtettUboHdufXITiA9LvfSCEMypYGazP+
	hGGfDveuWu/UKVeSKlqQNSE5UCd00NV0Cxv/YprBwrcPx+hSMe5eYV4AlmGUUYzpwcNgSjbcvoL
	9Rl1Zm781MOwyHh5y6vGN6tw5QG5JZk5HYl7PcRzao84HGsUvSwOPLAgIOF4Ul0sT7zRkP166jn
	nOsvwR+TySlg0pIfV58n32wnSIiaI38Dnn2wkpbIlFgwpGmic/YHTXu4ijUcG+6D/YLXZOoLIeV
	nfNJl+8oiMnaKNxwA+vJhZ1W46W88nod5Sep06E2hAWp6iIzRH3QMH1sqhwoR1OEHnA==
X-Received: by 2002:a5d:588d:0:b0:488:7496:15b5 with SMTP id ffacd0b85a97d-48e264dcfd3mr1699443f8f.47.1792564403088;
        Tue, 20 Oct 2026 23:33:23 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm3130790f8f.14.2026.10.20.23.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:33:22 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 13/13] doc: move pack index v3 documentation
Date: Wed, 21 Oct 2026 08:32:45 +0200
Message-ID: <20261021063245.2917625-14-christian.couder@gmail.com>
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

Right now, we have our pack index v3 documentation in the hash function
transition document.  However, now that we've implemented pack index v3,
people will look for the index documentation in the normal place, so
copy it there.

We preserve it in the hash function transition document for
compatibility.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/gitformat-pack.adoc | 75 +++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/gitformat-pack.adoc b/Documentation/gitformat-pack.adoc
index 3416edceab..19afbc881e 100644
--- a/Documentation/gitformat-pack.adoc
+++ b/Documentation/gitformat-pack.adoc
@@ -318,6 +318,81 @@ Pack file entry: <+
 
     Index checksum of all of the above.
 
+== Version 3 pack-*.idx files have the format:
+
+  - A header appears at the beginning and consists of the following:
+    * The 4-byte pack index signature: '\377t0c'
+    * 4-byte version number: 3
+    * 4-byte length of the header section, including the signature and
+      version number
+    * 4-byte number of objects contained in the pack
+    * 4-byte number of object formats in this pack index: 1 or 2
+    * For each object format:
+      ** 4-byte format identifier (e.g., 'sha1' for SHA-1)
+      ** 4-byte length in bytes of shortened object names. This is the
+        shortest possible length needed to make names in the shortened
+        object name table unambiguous.
+      ** 8-byte integer, recording where tables relating to this format
+        are stored in this index file, as an offset from the beginning.
+    * 8-byte offset to the trailer from the beginning of this file.
+    * Zero or more additional key/value pairs (4-byte key, 4-byte
+      value). Only one key is supported: 'PSRC'. See the "Loose objects
+      and unreachable objects" section of the hash function transition
+      document (`Documentation/technical/hash-function-transition.adoc`)
+      for supported values and how this is used.  All other keys are reserved. Readers must ignore
+      unrecognized keys.
+  - Zero or more NUL bytes. This can optionally be used to improve the
+    alignment of the full object name table below.
+  - Tables for the first object format:
+    * A sorted table of shortened object names.  These are prefixes of
+      the names of all objects in this pack file, packed together
+      without offset values to reduce the cache footprint of the binary
+      search for a specific object name.
+
+    * A table of full object names in pack order. This allows resolving
+      a reference to "the nth object in the pack file" (from a
+      reachability bitmap or from the next table of another object
+      format) to its object name.
+
+    * A table of 4-byte values mapping object name order to pack order.
+      For an object in the table of sorted shortened object names, the
+      value at the corresponding index in this table is the index in the
+      previous table for that same object.
+      This can be used to look up the object in reachability bitmaps or
+      to look up its name in another object format.
+
+    * A table of 4-byte CRC32 values of the packed object data, in the
+      order that the objects appear in the pack file. This is to allow
+      compressed data to be copied directly from pack to pack during
+      repacking without undetected data corruption.
+
+    * A table of 4-byte offset values. The index of this table in pack order
+      indicates where that object can be found in the pack file. These are
+      usually 31-bit pack file offsets, but large offsets are encoded as
+      an index into the next table with the most significant bit set.
+
+    * A table of 8-byte offset entries (empty for pack files less than
+      2 GiB). Pack files are organized with heavily used objects toward
+      the front, so most object references should not need to refer to
+      this table.
+  - Zero or more NUL bytes.
+  - Tables for the second object format, with the same layout as above,
+    up to and not including the table of CRC32 values.
+  - Zero or more NUL bytes.
+  - The trailer consists of the following:
+    * A copy of the hash checksum at the end of the corresponding
+      packfile.
+
+    * Hash checksum of all of the above.
+
+Note that the two hashes at the end of the index file are in whatever the
+repository's main algorithm is.  In the usual case when there are multiple
+algorithms, the main algorithm will be SHA-256 and the compatibility algorithm
+will be SHA-1.  Git always writes the main algorithm first, but doesn't require this.
+
+All 4-byte numbers are in network order and must be 4-byte aligned in the file,
+so the NUL padding may be required in some cases.
+
 == pack-*.rev files have the format:
 
   - A 4-byte magic number '0x52494458' ('RIDX').
-- 
2.56.0.215.g47fdf2208c

