Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385213;
	b=CFXi5CWGVoq2cTWp3fJ+o0maBtNyO1inA5mhfuzMXj9lJE0SzLWMLy0maq+Xf/c2whK3
	 7yWA+uCxElpvZEvDSKfOT8SV2aN/6o4prv4k8A0KuShOq9gND6LuzbT+nZk//bXPenJTg
	 6byLPLbb7NTrz7VciBeT1r+3kJdX9s/xOZU6ClpEK9IF32jSnLh8z/Ar9rQU+ZlAM/JLB
	 7P5vPkU2FD8dL0xzQMSakvsUtx2zDV5mP8BloqVSNy4HP8j55V8wRVgu039x0TUZl9e9k
	 cTp3w1fuW6DhBwXNE0hH8RVGNmxxBLwxHng9+iehiwkfzSd14O5DTWmbpAfCsy3xlIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xjsX+FiXO+LeY2q9tOk6kjY1ctXHTCv8/Io5cKen+bc=;
	b=Tac+pbGJIZP4x65+Mmo/thkrMcVxLdl8MddPhKg2Q+qm7LAqKC8WQ16fTDJKqm3CEz5G
	 icOIbbflTcSrYn6+rFb7Gkj9ToQXEq6+Nt/xNS1eC3FYEwTjaKSE2blgoxbfM7ncJ0hS7
	 2RPiISqYNc4hLVQC0T6a/Z9hYWCfj7Ku26BplMlyZKyT4f68Oa1PK8cbSxBFyWvy1z8qJ
	 EBgvDufajp/4/JXI/62V7wRa8hK3Z46mUw0ZNJ0eZXf6hgsujINQj3EKEfBUVejrk2lOL
	 78eLy2Pak3nkxmvIl1h0fh/FEbkBsHvf7Ol1dTp+z+VEta3DkJvulfId5jTqKaukHLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AxBR5KOu;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA20606A322
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 18:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AA20606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AxBR5KOu
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso9646135e9.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793385212; x=1793990012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xjsX+FiXO+LeY2q9tOk6kjY1ctXHTCv8/Io5cKen+bc=;
        b=AxBR5KOue/G0265DLAqVTjSP4Lf+dayN/bmXhP1sO+AcKqkfp6GV9E/Au8LC3E3s02
         MC4cp9A9aLTHC2GE8tNXR99akKtDEn+Msw8LI1eCtEx5yqpmiJxkkKSAYm/A9F8GUZV6
         jp3xqaI9YZ4l8Sbvd4og3tf40LSmvQRV/Vy6jlqTnD8Hpm3fs/f7Bt4ghHjFqNYnZ3UU
         9V2dOygjhDpOn1ynvqgu2FJ7hrLWkdtiqxrIR1UBblinvxlzJzEnbSmzOvaGOVYjurMM
         WZYoAQEiPrxmh7a/hRCF5xFf2nmSPPN+OZAqD2Nl2KYpq8HY95bmjbwzKBBd5NhBJrQK
         kBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385212; x=1793990012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xjsX+FiXO+LeY2q9tOk6kjY1ctXHTCv8/Io5cKen+bc=;
        b=PPYZIBcIhmuD98pW5MPY6NfncnfCO5sgpz5qIllgWBdJ8NOfyI4SkSd8FHVA/qd2XM
         rHDAcEMW4yiwmnhnbJFuobZ6dBPt2BMec1rSiNx7M/Kr/tEsrN2jjYzVU0irVcPyG+Zd
         B6Fw6Hbrh9MzQWDEm527+AL7VYky2TaE8L4sotC3QcpzaESNxyoIOKudhDk1xP+I4yM5
         93TIqZK1/YvCn66wyW4kbf4/JXkqE3RG5sBzGQ/SRAhCcj1emtkCDqBl2QVk+F3drnUC
         L14GplXug57JgPk4EZdiEZ3IQJtR1bS6gHoZvNd29xcTm/sGW9FxAH5zQf2hUZHGH8q3
         ag2A==
X-Gm-Message-State: AFq9FYL92crb4zrcrPh/rw6xqFMCRvqibG17W1Jd9Z1r7VAMu5JVJix1
	jiSwsgH3R1AqXTDJ+9CUrx8O0bo/15EWk4ndanYOB6aslnvgZBwqBgqWKEOsImsUZjg=
X-Gm-Gg: AYBFou0vbYDlPG3BdP7RKsDQp4dkCeaVvwGuWBx+8LhU0HdIThYfC7AxwdlnNXWZLEQ
	15dSH9P/Cx4Qnm03cvO2QZNMsm2lGBY8MriPDP1JrCZWEaL6l8lWrwf80Oy89vW9YLDXHC3oDCg
	SSdHaNzIRooyOjQ9dz47ir2Sn1j0Tzaj9zCOeX+vgdKVTWqkkchar4uobzMEAsKbylLKL0GtaIj
	QiMDzx6YigLwYhA7sq/KUzBVDSuiw1WShfLBNBHpEooLULXRaz9vDlFivwRCkh7lbgsrZV/fDLZ
	OOnKxiBDxgqoH9cRNd/8ySDxcJ8iZ2Y7b3vTG2xekp/oolf002EXSuydFL95P2igPzO7UbftDaO
	WEIyk2U2hFypCaJe176z8qxwPMGOhZRomUW093ggoR/+BWf+gXttnHZc+ZkJuLzOzI5vjbWqov/
	X6nWaDYN+CarL7ecahZTyQNwEiZEG37koFbwXWiXEGZTXcAlgKjABXIXO0O0KjJj/K5VsPLOkIM
	OWlQ1iUDmXnJQkXvD8scXykKdFMrWQyWUI77L3IhnIwi6yzj/ijjjeNgPpQ8q69rCitXgPNokbh
	h2uRnflvEVkiG/aYxzA1cBM75DtXxyfkygwcQ5+4u9LkVL9jybiRqMBCIUM0E0Oc1MQk8gviMNL
	za1ki8JXOcQoxJJichj/70cKax/voYLzJRJNpdP3WtoSkTN9daz7H5E3fDtNvJWDw5I/QTL+MhT
	LIxgxN9DxjQBM3axWKqd07bLcsFUYADq3AMX/bzJRPddSKf7s=
X-Received: by 2002:a05:600c:6216:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4ac1737c533mr68437655e9.9.1793385211274;
        Fri, 30 Oct 2026 11:33:31 -0700 (PDT)
Received: from localhost.localdomain ([105.113.81.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a7d1sm4520956f8f.38.2026.10.30.11.33.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 11:33:30 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] name-hash: use istate->repo instead of the_repository
Date: Fri, 30 Oct 2026 19:32:18 +0100
Message-ID: <20261030183218.32630-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
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

hash_index_entry(), lookup_lazy_params(), and remove_name_hash()
already receive the index, but read core.ignoreCase through
the_repository. The setting belongs to the repository that owns
the index. An index for another repository would still follow the
setting of the_repository.

Read it from istate->repo instead. Drop USE_THE_REPOSITORY_VARIABLE,
as nothing else in the file uses the_repository.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
I checked whether istate->repo can be NULL here: it is set whenever
an index is initialized, and repo_ignore_case() returns 0 for a NULL
repository anyway.

 name-hash.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 83757db874..98e170851e 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2008 Linus Torvalds
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -126,7 +125,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		hashmap_add(&istate->name_hash, &ce->ent);
 	}
 
-	if (repo_ignore_case(the_repository))
+	if (repo_ignore_case(istate->repo))
 		add_dir_entry(istate, ce);
 }
 
@@ -207,7 +206,7 @@ static int lookup_lazy_params(struct index_state *istate)
 	 * code to build the "istate->name_hash".  We don't
 	 * need the complexity here.
 	 */
-	if (!repo_ignore_case(the_repository))
+	if (!repo_ignore_case(istate->repo))
 		return 0;
 
 	nr_cpus = online_cpus();
@@ -651,7 +650,7 @@ void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
 	ce->ce_flags &= ~CE_HASHED;
 	hashmap_remove(&istate->name_hash, &ce->ent, ce);
 
-	if (repo_ignore_case(the_repository))
+	if (repo_ignore_case(istate->repo))
 		remove_dir_entry(istate, ce);
 }
 

base-commit: b9e5cff1803ab24582201ef059516eb16014b9d9
-- 
2.56.0

