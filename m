Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCCB35A39B
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235789; cv=none; b=EJXH7wrNJnX7wLD+66iakAu3epa7MtTSMiZwY/wZCRybz5sKgN0wl39KpNviTSYSZzWeQxQ2rXd9GpoE7tES5/AGrsRsY8lvDOqXE0ojk+j+LvGARRLK0EEddONy7CxSS+L9CFbmQpGX3bsTclrrSF6twTh2VFldxPknpWK+x9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235789; c=relaxed/simple;
	bh=02WURZcZvL7f5bpDeQpVEnldAZd3vQySpU5VPJCKRQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lt8xo/LX+blQ5KVGRDpJNj51osEENLSXxzMYbkkko2hYnktXJVFy1euZN9jlTHfHGOqB+RnT3U4zrt/snB9SmmAQbwtU3RCa2eD9pwnkHlpa5zVBltd9U3gtxS0Xke1YZNwbKIGvocw61eD5xqmr2CHUj4RturExZYR4tyOX0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8KJuQL/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8KJuQL/"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4398dd671daso2816017f8f.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 15:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772235786; x=1772840586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94rpIcLxgG7UBMY7yN7x4K5rb5sZ4hArbRLyH+Tf7Ng=;
        b=I8KJuQL/CcPUwXGjzHAk2827Rc335dykp112QuNZ4aK3cduhMfN+CFYWkM+Y91APFJ
         ztIrK8rZplxn9KxebniCwsgcHFb49gsD4SsYPOMNCw7Zp/bzaeRBVdd31+PMcEwjWNKO
         gv3MhF4c54RA3/EWSnqAtgdJDomHyfDJq+QvrAdc2c8hQ8s46PcRQP4lIriOvZ1tIvEB
         xRW1c8Zijqy4GJ/E3pw3OpKcLhhLD/S2TrMY9l14ur5gUoArXTejr7rXSY59+bweSBRh
         QmFNN05VRbu06LAwLzOYqfhFWjEyQuFj/0luvf9/5T59utstx699Ow0qhnWYmAx8y6Ph
         pX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772235786; x=1772840586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=94rpIcLxgG7UBMY7yN7x4K5rb5sZ4hArbRLyH+Tf7Ng=;
        b=TvAkTJmaLsT3txJvW+AMFhrj6FVo3ZzwP43RKGcluzIFsaFCy5FrwKlcDR3kEfR+OB
         XN9ck5WEDLRVXr/hNB+pPsURyHIm/A/1l70ZGr51h7/Sv8Ey+yBfmKiTfnbUmDwnhaVu
         fMbyPTyZLhSNeYippqFXaQ3DBVSb8L/NRtdwArnesN7N7maXFLv2+UgfgBfNFgVyzktC
         D2SVmsgk14RRZhwEzNpPgdDmD7rMmRbBEFvlsMNuG9AIRqbu89ZwSBbS4uGivrlIuGZC
         aLKVeYFcA/BwLARznJSrqtNgnZp8VSY8qV3nxcs6+Qtd8+SsG8lxIuOW88TvVxZZj1ua
         QrFg==
X-Gm-Message-State: AOJu0YyMpM06LPTwZPCChhpjzgJey/JJW+kdx0/pzv7GWr4aKY3ly38d
	dCGhD3Tc8eCGar9146bMDncMkepRdZen3QOTLuqWX3D78x89/+8XU2Xgr5ruGF3k
X-Gm-Gg: ATEYQzwps3tBqqzqOX+V6RH1g5K5pW+7qQnT+t6lUOyc2eonQ9ckMAuaI+SPTQHt1Dl
	f3sKN4tADKa3DjxKOr80ZLvWbNN6C373DzbOdFvzm9BFrhJyfQq4yGEbdz8YO5D1MP88Pc02MtJ
	itzQUraWdh9rW0e3/FqGr9BSzfGLxGUGKyeoTDsWU7DhHK4MXdWG8gse3MBtklCf/Lc14u172Ck
	6YD5DHJrFrXz+JQ6wrjY4qrUoI4maCwRYKyNrKV1qbt4pBbRvm3COEzFrbi78XQ6c7lp6MoBYeh
	HH+yrReTexwbiZWu77YT16UzJ0MGDSJmElhVruvZbnX+ixAm5XczLWObGN5hfKzMtGemMPFsCJI
	uwN5ORUlZvm3kuoI//bWDUiAYt1IrNvPfo4VcqnB/AEDArc7O5ggJykgaEse76Jk1XLQAnxInjL
	lvsmsN0pgFVvpCsvjNSrXMSOtjJklBZqIG5OrOruleUccxB9sOpQda
X-Received: by 2002:a05:6000:2081:b0:437:711c:8754 with SMTP id ffacd0b85a97d-4399de0b754mr7738292f8f.7.1772235785923;
        Fri, 27 Feb 2026 15:43:05 -0800 (PST)
Received: from localhost.localdomain ([105.113.107.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b40esm9710899f8f.36.2026.02.27.15.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:43:05 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH 4/5] odb: use oidmap_clear_with_free() to release replace_map entries
Date: Sat, 28 Feb 2026 00:42:12 +0100
Message-ID: <20260227234213.17633-5-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227234213.17633-1-kuforiji98@gmail.com>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kufoiji <kuforiji98@gmail.com>

Replace the direct oidmap_clear() call in odb_free() with
oidmap_clear_with_free(), and introduce a free_replace_map_entry()
helper to properly free each struct replace_object stored in the map.

This centralizes cleanup logic and ensures entries are released
correctly via a dedicated callback.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 odb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/odb.c b/odb.c
index 1679cc0465..8ca497203f 100644
--- a/odb.c
+++ b/odb.c
@@ -14,6 +14,7 @@
 #include "object-file-convert.h"
 #include "object-file.h"
 #include "odb.h"
+#include "oidmap.h"
 #include "packfile.h"
 #include "path.h"
 #include "promisor-remote.h"
@@ -1089,6 +1090,13 @@ void odb_close(struct object_database *o)
 	close_commit_graph(o);
 }
 
+static void free_replace_map_entry(void *e)
+{
+	struct replace_object *entry =
+		container_of(e, struct replace_object, original);
+	free(entry);
+}
+
 static void odb_free_sources(struct object_database *o)
 {
 	while (o->sources) {
@@ -1109,7 +1117,8 @@ void odb_free(struct object_database *o)
 
 	free(o->alternate_db);
 
-	oidmap_clear(&o->replace_map, 1);
+	if (o->replace_map_initialized)
+		oidmap_clear_with_free(&o->replace_map, free_replace_map_entry);
 	pthread_mutex_destroy(&o->replace_mutex);
 
 	odb_close(o);
-- 
2.43.0

