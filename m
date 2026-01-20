Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6D426EB3
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918196; cv=none; b=H1Y3r1nlXkiusi/qd/+T0pEAwrX/pmb/J9cqw/c3+qPRGFqLcWodEjP8S47xqZweFbBchi1AdRthxOgtcRT92yGHbjtadN5CBqhP07Rc1nTW5noTZuj2WwmLoCBb7/qrn9CevnHSAOR5W8mrEFOIDQm+id8jiK+D8MVlwA9KBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918196; c=relaxed/simple;
	bh=lcZeW2Ite/eFMHBfM1pei5UAI6gFfsuCz4nFHXk7McU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQqNq4dcZ2wZtJKzArbml9zljcc+8Nq6medOxBBM+Qvt4V3auxjm2QrrSbzeZhjVV6eG4m8MTC8xo5T60q9+eebTZuIhhP3vGdfibQN1nSqhnnPvuiL0h5aVO1hQhG+HXImzIT5O+S9td2tkgXLhaXqjEA/F/oMF+/sAnmJ5NuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f49f2UFo; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f49f2UFo"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c30f0f12eso3047240a91.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 06:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768918194; x=1769522994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHgyB2RGyAZMudlZRoia3EljoXz46ey3rlIoLv5gOV8=;
        b=f49f2UFodDaU6c3tugGBvv3WjpoRHZe1gI/7got3cV2osll/pZbXoFZS1asR9uSGVC
         76tXPQ21AmIDTxc4q4fLgZ7BegI45VSqU8heSflZ/0gzmPi3mNej20PXv0fYodWaZqfT
         QqepdxqzuzXuNRf4q971Lg61+ZP5QAh8Zn9e/O75vcNBNYJNlcWgfONHbzszbpakcT0M
         9FM8vH/TChQkPE5J0J+Z9YuCxJ9vzY+GZX7rsEAYId2PM/H9QfTMI2k+aidb1xoTHIaN
         05/Ut7Qwatlo5o8307q+OY/23ZWK+IB9JKMctBesBuOsdVteEBZy4eBLICLUb5Y/vLpb
         s7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768918194; x=1769522994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wHgyB2RGyAZMudlZRoia3EljoXz46ey3rlIoLv5gOV8=;
        b=TfM+bS/IrlY/p0Jrp65bGO6u2hepzloDdzfkg23nquRokn591hzCWmlNA0m4UvG992
         RXz+ADnBH2Ghnw9XIjKsrmRt0ITwoOkT3Iwbu95+W1JNAQKJ8/7t4QDqoacTPfDCt1jw
         tcIzkTrCmbM0bZQ3QfKOjiRsGJoA8DVKwCR9yjFYFcSBBakIJj5v8SKbiGpQwsqVzAGt
         WakTTm2WIxJLcu6D38BHrlJQYR7mokKab7ByTZFd4Q57wh+YStz/EuoAOwFRZt54KLnl
         G/NiiwGmiyn4tsoVemN7sT4fkhnXlcsyOE49XIQHIluEbXepaf9/facEYXmTNQ5y6Z/u
         CBzg==
X-Gm-Message-State: AOJu0YxT0BrVzV35SpMepGwlsX3CHkqVGd2ytxTnj+TfMkLX8kUQv6Jb
	69/c2zlcmG5MHwTLR4UWZvtVdHKAfUQELYlgLF1TTngaIE4unrKgB1MlqEQhxQ==
X-Gm-Gg: AZuq6aJbiDiDt8KfkanJN15Ede+bVOuVMaLJcM1w2VCZqlQisuPBG5J9MrT5wTjOcbF
	HjLRyD1fjxsict77gColWemSR3Jj5S8Wn7eTGNklqSxDwaWTzE+B+ulPElVn9cGeTPs3TGA2MO2
	zXlk3Gi/0ni9q0MxlITgs/cRq25SP1BW+EHVTyO8qxxTQiMLfnFIDJ6nMFpIfXaTMl6fpA7BJqo
	286DZMyUZCOzy01+35MqaOn4lNTjq/UXfgBw7/BDN64Uvif1ufII0AOPVICuRR+ewIv3DfvW9aC
	wz8mkcWI9UdBFZOZTqe1CToQdbE1olZcD1Zcv5P7vrya0BpBg3PprKYAMBGKLFR+gtyB3Jax2Vp
	dgIw/ZeLmgcjPWl9M3kRxtIAY5fRnSOBwXTFEh2XDKeihX49+8A4IQN0Y6FnD+xYS2IbUnCfMdz
	O2aGBdZwBcE8VnJJ3szq4BCf/MmVoYhN5ncNXlTQ32p8Sndw==
X-Received: by 2002:a17:90b:3b8f:b0:340:f05a:3ed3 with SMTP id 98e67ed59e1d1-352c400659bmr2020784a91.17.1768918194293;
        Tue, 20 Jan 2026 06:09:54 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd7:6181:2062:a538:8b6f:d4b5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352d5a3ea3dsm1362250a91.3.2026.01.20.06.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:09:53 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH 1/3] show-index: implement automatic hash detection
Date: Tue, 20 Jan 2026 19:35:39 +0530
Message-ID: <20260120140901.517928-2-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git show-index is run outside a repository,
it currently falls back to SHA-1 unless the hash algorithm
is explicitly specified via --object-format.
This can lead to failures when reading SHA-256 pack index files.

To prevent this add an automatic hash algorithm detection,
as suggested by an existing TODO comment in the code.

For v2 index files, the fixed size can be computed and then,
the overall file size combined with the number of objects,
can be used to compute the hash size of the objects.
Since SHA-1 and SHA-256 use fixed hash sizes (20 and 32 bytes,
respectively), the hash algorithm can be determined.

This detection is limited in scope. It only applies when the
index file does not contain any 64-bit offset entries, which introduce
additional variable-sized data into the file layout. When such offsets are
present, automatic detection becomes irrelevant, and the user is instead
required to specify the hash algorithm explicitly using --object-format.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 builtin/show-index.c | 45 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index 2c3e2940ce..be62edc57b 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -40,17 +40,6 @@ int cmd_show_index(int argc,
 		repo_set_hash_algo(the_repository, hash_algo);
 	}
 
-	/*
-	 * Fallback to SHA1 if we are running outside of a repository.
-	 *
-	 * TODO: Figure out and implement a way to detect the hash algorithm in use by the
-	 *       the index file passed in and use that instead.
-	 */
-	if (!the_hash_algo)
-		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
-
-	hashsz = the_hash_algo->rawsz;
-
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
 		die("unable to read header");
 	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
@@ -71,6 +60,40 @@ int cmd_show_index(int argc,
 			die("corrupt index file");
 		nr = n;
 	}
+
+	/* detection of hash algorithm
+	Only works for small files, i.e without large offsets */
+	if(!the_hash_algo && version == 2) {
+		struct stat st;
+		size_t file_base_size;
+		size_t table_size;
+		size_t size_rem;
+		size_t hash_size;
+
+		if(fstat(0, &st) || !S_ISREG(st.st_mode))
+			die(_("unable to detect hash from non-regular file"));
+		
+		file_base_size = 8 + (256 * 4);
+		table_size = file_base_size + (nr * 4 * 4);
+		size_rem = st.st_size - table_size;
+		hash_size = size_rem / (nr + 2);
+
+		if(hash_size == GIT_SHA1_RAWSZ) {
+			repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+		} else if(hash_size == GIT_SHA256_RAWSZ) {
+			repo_set_hash_algo(the_repository, GIT_HASH_SHA256);
+		} else {
+			die(_("unable to detect hash algorithm, "
+					"use --object-format option"));
+		}
+	}
+
+	/* Final fallback to SHA1 */
+	if(!the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
+	hashsz = the_hash_algo->rawsz;
+
 	if (version == 1) {
 		for (i = 0; i < nr; i++) {
 			unsigned int offset, entry[(GIT_MAX_RAWSZ + 4) / sizeof(unsigned int)];
-- 
2.52.0
