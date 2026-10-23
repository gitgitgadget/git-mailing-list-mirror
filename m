Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740378;
	b=gGxY74C5zBJTRp+un5y1ZxYS4stfkEOyaYuZCm6XnjYUzvmG3ez9J3GVwKB7CWsF47e/
	 /bJ6EDWq1QRxVDkzAtIchO45SeXf2CSxIo6iXqtIIFMx0s50ZLmRm0ZUc9wONY5Ny7yjd
	 L+rOhNcKKQxZkTE2FwD8LZ/tuyXQFgJMow1gYO9osJz8IoNFbomA6Jv4VbnEy1qFzJhsI
	 fX5j/j9d8PZ7oVvsdFCW0TNX7Uz7UkLnQWbE+uq181iuW4DkPWqkVgLgQuUwJNyUb762i
	 JDngoFRnkoaSqxSnIPswZNKgi3M8spLWvZvgLktO5MeLnuwc4uvyeAfbeVuzbq/FzDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WRyHIc9hqkS84sZmub+2A+XBGc1Z506ni/G6R1OBz8c=;
	b=uTtMcXwjZiT9PVYBd/t4XXUX5Df9Yz/3zE79f0UGaihPJgVZTzSzUvw8SNuxLUdIezWm
	 jB1d2Y+TUcsZHOcOG7LAPdFNJldZ6xgQio4uW1QyC80OYMM6SAVdRhg8nOILmt3gHbic7
	 AneovPoEWYGdPR5kIO/weJCYCrKQ2PSBSi3QQJDLRVQOZFG9+uGdqlNmCuo3IZZntqSmL
	 Sik2aNPDqFQ9bTZrc6BaorI+54ydEN4DH+j3tvZBWL04VAlYnVIdkYEv4UJuFOuFWFbK1
	 G61qboipl3sgKYSebwcvV+7gm4iG0tub5Z4X3Vw3l0hI8UofGZK4S/Zvma8SyKOzVwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=psmmEd1e;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAEB606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DAEB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=psmmEd1e
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e00eee27dso310929f8f.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740377; x=1793345177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WRyHIc9hqkS84sZmub+2A+XBGc1Z506ni/G6R1OBz8c=;
        b=psmmEd1ePcxMVjwGEtvwpwD+psrbriKWPN6aeGCqwv8B5Y6qk7irsDBlGKAVU9d6wJ
         kkQBgVYUggffL73UeBjNfI8GO2ywUnY6UQkfg06j7nL3OHuz/NSJ4CIH5UWVogna2sN9
         PYBBTGl6nP6/TcfSesh6u8+OZYKwJvsqKgKFBV9XrEMbrCPrnm3REeMgrRefT34NJMBf
         fvx4lzoVDeFcKjNPApVRg7HLSU46kAxET7kR1jdwaLXS3F24te0sJVzE2abrJpqnO52O
         ofr0FTxzmiXGLTCMirkAsjcELboK9GpZsNB7/Vx3hIsTUr2tKLKd45YfNEorsNtbqpps
         tcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740377; x=1793345177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WRyHIc9hqkS84sZmub+2A+XBGc1Z506ni/G6R1OBz8c=;
        b=Wgnzsu8Uk8PJQfgdQzmyrhWa2QBlwOayl7Ip3FyGgNwkM2a+j2nSLf2gFki2bZB7RJ
         U/BjsLH1g4LtCdTkbh96xp0Ujl15KZt77OliRySjX/DEeLl5wLy5v5XS87R30VQLY8Iz
         C0c79IA6UYX+iGBVZ4eBx6DxLlJ2oZ5rgVnriopYUFaSios33GVX2L6+hKVnU37Egdj/
         ayzerhZHPF+ddOZycrSoqY5ZstHCELhUWVtaKTZ1Qv2rmB0Zru/UBHGQmGdOXObTQj5X
         KrCD2oxE+2oPw4ksPfYhWv1rXDElgBLbbqEp/mtCnrhyPYWwPZ1SplOqvceYqBNfozyS
         sJhQ==
X-Gm-Message-State: AFq9FYJygstIzLtWDRZFMKyMyBQGUpjjXl3wnjvSHicsmbaB5kMtjtAq
	IZrE5kYZ3vX6fCbaEE1QM8a91A0s8hPuT4B7/+g4A8wQuTL3doDwik2GyiDpqA==
X-Gm-Gg: AYBFou0L88VuM05ZRmBC4red5/xNWZncE3qlKZHpM68/Kib08kucI/UHQ3tSIR6JKmn
	4hsSv80Pq4A4q5NzYbo1vJw7Ra36cjBgPKGs7QuG7UZeWMzV1uOdH5aeHAFz19JR7NMLVbo/E8e
	g2U163Ms5R0SfS7MHn2jdghzyjVJlamFbEzAQHiaBnviMmYctId7xXUXJJYwczXKkdS+RddYLcB
	o/Mz4xdhJGGPk1NZJEY1jcZQPiL6k4LYORUr82rNhfiajjvUlwiS3jLGGRvrDEzKSwbe4ZYvocE
	dX3jnAoENs30YsUOQLNu95rZ6gIx8nl2HyQJP+3XSCwWCCCXQqM0rS001D/ALAxV46uj+cOZuhc
	Ioig8aHH0vo6xaU89jqWEArM8wcIIAeQeudhQCCkIJJ2w7Ud1zA94ElrsXuVkNgG8MRqAxPmb6j
	9Xy1AZ/fnfzewOFoafaq9E/asG3BC0jMKDpZ2VdaQ9ekDa86M4rxj3+d/J3Jsgk1KVqMeLLPgCG
	mBvGhKWiPcj+0ATUgTWiDu6I8qns2S35MIL31YArETDM63CxirMiz9gBXSfiENwc6l+LXaTiWgO
	3DMATPH7XgQeBGdmue2QcD3ze+m2H4xisYlFfzJdO5b81yPQPF5IB2enul6YZYNDyAnL56xM5/B
	5JLDXj1bfcSQNkra30bBsDjH24//I2N7TkPA3wwUZxRKTSN94OAuHOkWNxxOqPQaIgg==
X-Received: by 2002:a05:6000:46dc:b0:48d:f7ef:721f with SMTP id ffacd0b85a97d-48e3859dd7amr1126825f8f.11.1792740376788;
        Fri, 23 Oct 2026 00:26:16 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38055da4sm3228024f8f.43.2026.10.23.00.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:26:16 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 01/13] loose: allow looking up in object map with source
Date: Fri, 23 Oct 2026 09:25:46 +0200
Message-ID: <20261023072559.3204273-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261023072559.3204273-1-christian.couder@gmail.com>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
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

In preparation for wiring up object mapping into the ODB abstraction,
add a function which can map object IDs based on a struct
odb_source_loose and use it in the existing function.  This preserves
the same behavior, but allows us to make use of it elsewhere in the
future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 loose.c | 41 +++++++++++++++++++++++++++++------------
 loose.h |  5 +++++
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/loose.c b/loose.c
index d6a2bb5ba3..fe8f540979 100644
--- a/loose.c
+++ b/loose.c
@@ -225,27 +225,44 @@ int repo_add_loose_object_map(struct odb_source_loose *loose,
 	return 0;
 }
 
+int source_loose_object_map_oid(struct odb_source_loose *loose,
+				const struct object_id *src,
+				const struct git_hash_algo *to,
+				struct object_id *dest)
+{
+	kh_oid_map_t *map;
+	khiter_t pos;
+	struct loose_object_map *loose_map = loose->map;
+	struct repository *repo = loose->base.odb->repo;
+
+	if (!loose_map)
+		return -1;
+	map = (to == repo->compat_hash_algo) ?
+		loose_map->to_compat :
+		loose_map->to_storage;
+	pos = kh_get_oid_map(map, *src);
+	if (pos < kh_end(map)) {
+		oidcpy(dest, kh_value(map, pos));
+		return 0;
+	}
+	return -1;
+}
+
 int repo_loose_object_map_oid(struct repository *repo,
 			      const struct object_id *src,
 			      const struct git_hash_algo *to,
 			      struct object_id *dest)
 {
 	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
-	kh_oid_map_t *map;
-	khiter_t pos;
 
 	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
-		struct loose_object_map *loose_map = dir->loose->map;
-		if (!loose_map)
+		int ret;
+
+		if (!dir->loose)
 			continue;
-		map = (to == repo->compat_hash_algo) ?
-			loose_map->to_compat :
-			loose_map->to_storage;
-		pos = kh_get_oid_map(map, *src);
-		if (pos < kh_end(map)) {
-			oidcpy(dest, kh_value(map, pos));
-			return 0;
-		}
+		ret = source_loose_object_map_oid(dir->loose, src, to, dest);
+		if (ret != -1)
+			return ret;
 	}
 	return -1;
 }
diff --git a/loose.h b/loose.h
index ed663ac550..f3b1e47363 100644
--- a/loose.h
+++ b/loose.h
@@ -24,4 +24,9 @@ int repo_add_loose_object_map(struct odb_source_loose *loose,
 int repo_read_loose_object_map(struct repository *repo);
 int repo_write_loose_object_map(struct repository *repo);
 
+int source_loose_object_map_oid(struct odb_source_loose *loose,
+				const struct object_id *src,
+				const struct git_hash_algo *to,
+				struct object_id *dest);
+
 #endif
-- 
2.56.0.215.g47fdf2208c

