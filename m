Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564387;
	b=naJ97vXCNfDb0vWtmcKJrZlApP5E23OXl2DRbm20gSmE3mES+HRzeDqEqM95UgFvuIox
	 TZ6pXKdly8GxL6t/KaXkD0NfGki6ZruOGaDn5KI8I6tw4oR5QCbVk8rlct+IyeIZEA1Dm
	 iMAur9EeDY8c5BMOzEAMyV1+4QVDubC1bi4ZtfLBKD7K5B9luzyMmIKIWy4/ktV0N6qn5
	 zPOj9qlMgKN5oUrRY/8KjB2ec6PMBYFzLEZUNF1t4v7Q/H7hnV8Y+3vRdBrbopeNYnrGQ
	 wtzTm8ax2OrGIIi+PgUBkJfFb08auKvdJDMkFvkCfTueEj1dX5yYYuIP7gh/RCRYjLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WRyHIc9hqkS84sZmub+2A+XBGc1Z506ni/G6R1OBz8c=;
	b=S1DgAK94k+/Lmk8OITRberuNFAIuPLNVq8pv0fYYEmLsPwHOVM9zI/fVxkVCeT6K8z/k
	 jNlCgaBR96ElBAhNIfI/EvOL67mrOvDzQbOzGGoBAE4tkHphGTQUNjAy7e+VNxV4i/b23
	 qzXAG6vb7aAseKYapG72k9BiJIJ/5qfI29S9vMxBsjqongbvYWV0GnKH1K5WgCY0nFCvE
	 EeFQF4h+iSQr0C+zgwSKelaL/b6sweSfdzNCB3xZuCzAOmDJijoElSZD1JqU4NTqnDVEB
	 WbanN/rImBJ24m/bp2pBO38TbZameEihzQraTL1yTm0+kGInB8sGynl7zMrCs8qbM7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PaWFNgg9;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304B2606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 304B2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PaWFNgg9
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso3834425e9.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564385; x=1793169185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WRyHIc9hqkS84sZmub+2A+XBGc1Z506ni/G6R1OBz8c=;
        b=PaWFNgg9Jv6l3Tyovy0X2XZSyfSzZcvrtFxkvB96Aw24MxrvWrt74TRNXblK9a+Ux7
         j2Ef5AkHkwMqAReoCdUV2TpHHMFIAfZhEKnCG+dUx+ET2VuAFmQXVEAkyjyosN9M8reG
         8DgRiZ9EWkke4xeElSIKYDr/cVM6Y8+/DZi33BJqVzEADwjeVoTxNoakMO08nvh914vQ
         dOvp3tlNG4PQA40hLDub3nDzq/3FTZZDN5BhE6q7dyyIwlb5Kfl2UQG2aULthRwEiOp4
         Jbwv49AYvqoFZEMeHQLISabrBElEDykW/LI9261eyPsxbinEP/XlYgs7nqgzt3/RC7jb
         wbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564385; x=1793169185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WRyHIc9hqkS84sZmub+2A+XBGc1Z506ni/G6R1OBz8c=;
        b=VzLGFB2eAZwZTgFH3Vz1pQDDsAi69pekrZh2xdjFc5KIgU/CGenKffcgwiVirdQCeH
         vCJgmd38ns3WjBxRjfDzseqGEHh1CI0dZJf/5GySfu8kzdJopY8Fjk3cqlF06XCKT81F
         6hBr7wQJ5SRSjW2dzlbsrB1AJABd0DYwQFDKoEqSNXI5lJw0wPXFlWPf6vsVEE+xrpjH
         gr2bVkTJWTqrMQvx8x/UTtX/oYNxCW/swlVK8CI9DoW0lB1Ir3hAl3aUzrmRjj/K+LCg
         Vq8SuArqMUPrMxjvg7EafnK/MBKT0Osp32fWD007YuraJ78c7QwwhpE5+bpPPS5ZRZxI
         SMeA==
X-Gm-Message-State: AFq9FYLMWsv08EN8qQq42stMJB+6IBg9E0TMZ4tWVFrx4GhDB5eTk6KO
	oipskOOVqFPzoqdY8OiNplH11SHnGJ9BQuYMiNWvMf9tDqZHNfFR2FUvbIeWOw==
X-Gm-Gg: AYBFou0b7mnPulZUgg74c2aQi5ikckem0uj05lWmE/lK9B3DWIEAXI6J7/QylIXUmtF
	sySFW4t20UQa4NByyrRQ9c8ll4KC04oAGB4E8kSEqeqtqhLCgfQN3/ZmpXNuCg8swBlTlugjHTa
	PZ10iJ7HheN8oWSUNiild+a+5wrAy6wiI7x/TWXER3ABC0JzqdLvAwQl9VN294++0Sp5HdNb0Cg
	GabJp0TI6gy2LqHN4aUTzGVONMSaHSxxv+ob6nIJ7V53M7f36n1WmCwZnMn+9S22i1mQusD5X2u
	PmDCh5fKXGuA2MfrpW3+nvEbvzGC/0EAppwXi09QoSPBZ5hID7jJxQAKfLO7SwqCFk2Elmg3lxv
	UHZydGmnUy0X1J+kEZ6qnVWAJBJ35c1W4o+F+4gvOz9A5Pdb8rk5vrxCzHUPIArOaSWmjDxBg56
	xvhPzO5b0LIVUJNMTctl/JxduKsAhYFjgDBTcKBpgnbiRi2Oag8nCrxwWv3hP8pWOZL7LVhbXXS
	btqeUGlS5U7fForUScIOikPADxikKJXFJw2Wv8JxDzLdJQI7+lOdMt1hoxEKP7VfmLBR8he0tQO
	HfxQTL0Ugf0hYJ3ao6qxsOuW+4dHaFULk2UKfCar5JC75Wj0LYqc8MQv81Gd8pStM5J9Re4ey2V
	OvRYJw5KEkp5jwy/pch2Tkr8Hd45ALob1/sdAiNYgX+l7MuCSutm+z6mZKItYFyCmoQ==
X-Received: by 2002:a05:600c:609a:b0:4a1:7bd4:d07d with SMTP id 5b1f17b1804b1-4a1fdd64e88mr18118815e9.34.1792564385249;
        Tue, 20 Oct 2026 23:33:05 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm3130790f8f.14.2026.10.20.23.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:33:04 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 01/13] loose: allow looking up in object map with source
Date: Wed, 21 Oct 2026 08:32:33 +0200
Message-ID: <20261021063245.2917625-2-christian.couder@gmail.com>
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

