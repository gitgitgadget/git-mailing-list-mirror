Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697F3769E0
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636127; cv=none; b=dhdaedpHXcUMCtg9pEduWK4M4IbTk495jj/M2RRy+5SWEoqhN3BtKTDX9tb3FTwPYyVhKtBtWPjAz6Bm15I515bQGnLsvBC4RjlO5JPN67IupP2Rxm4ZCLuDe+fz96EzMZMc1KFlUZKXGa7Q9Lxnbtwy1zGDvbQyESujPs2M9iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636127; c=relaxed/simple;
	bh=y8b/+QWfK8qFxZ9JWjXygaDTmKfdkrp4jbW8Wy5E/Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBAorrjz+D3b6NbkVl3qzfdVUs2N2PtDY2KcCFvnAuYYluEKc0lrnupH7VI2yK7KC+RBMOnhqFE/bmbg9UQKouqWq2PtkiLiOYflWvnLoZq7mL4Izmm6WR+MDVACFltSghoYwyUtta3NZjh6T/OqTsIoJ1xJXLkZRataM8mzqDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYGEEYcI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYGEEYcI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso348055e9.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786636124; x=1787240924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1uXwf5rvlgAiKaDlmlEsT/+sww60KJJ1N1NkHr78tQM=;
        b=AYGEEYcIVnkJDIF/xzDLszN5MWA4s+zfLI/D+dwCKAsT8FhKwIVHlBF01ruvBQSRMk
         K1fpzpmjXVDslujcwg2NlzeVAuepuel1hncYaIJYVJ+yywvGbi+Wfgj2ygNapZJ7s9Im
         HPYqk9+W08MSvxvBBKsZq+kVxxK/tCHqqGT0/EC5HArr4TNjGEaRH82zW2JUjKdmq6fL
         3a5JaR8wD8JLCC8CFp10tNnw1MLxO5Vv+qVPlS9zibF+4nbcWPFckn+eZ7StJQfGDYLt
         NTNcit7JF4mswOHJ8fDDkY4i1y7bCSGuw/Hv8StNkgKJiiSSS82kWteR2BQpKOzVqbcr
         pJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786636124; x=1787240924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1uXwf5rvlgAiKaDlmlEsT/+sww60KJJ1N1NkHr78tQM=;
        b=bCDO2vRQ+rgaU207hVcyu8/PVS/nBuBgtDwAM/oUSp+Hr4b+7Rssq90jbYWrDdFAB0
         coGPd2RLQHwqYJU0+3Enry1LDqTfNwRo60aItji/O4oQhIRStjHWuWQ3ckIvfq13U6FV
         UVa9VsBKQ6mRV6wAt+dmT2RmTTM4sWENz1L27cosHT7rWo2oebbWCjKMa9lBZ0uMdKIx
         pLhJ79RQPeYXRH/6tXXpOiNKQ9T6877k8/TYd2oYHtfGBM1eHTsgcnxqchnkTKTk775c
         ok2C2z3a0lLvfkCk18RePFDpDNWH18I2XOBiO7lXKch4zD9LmY0baH7X15jXviGD9djf
         AK0w==
X-Gm-Message-State: AOJu0YyHHs7ZobECGG5j1TlkRveRsh0OvUmWlcR/WfEwFtLlGdf5yjMy
	bNdbFTOjxdARrd8AVgsC22KrP+EC3KUSFY0jky/nJ6Ux+J2NSdiaatUl0QQERA==
X-Gm-Gg: AR+sD139kXctJMIoCgKH/6afv0P0eZZgaM1ZwWzU/QHK4sFaClxcQpab8BMcYnbODxy
	4hngo1GduEkPUyl5OYba43XWKhlex/SMltRW7u2Kxx2OijsyFLfWB3dZDBxCz+FAlqOr8Cchzz2
	LBFXKpHSHuC/10/iBtPVZNaIpJ7/3TBV7n6/sXit2bDrTNz5A27hXw8dKj8k5F8sj47vD0v7GzP
	4FVBfdxO/7UYDWCN9CaSdPrHF+pRDT8vk9qCXWxzv65a5UzkweZhhYJD50XQz5PeEPR+uQqgn1h
	t03tLeLEApRoMNBN4qKViyoyyyF2X2SeIt38eRWMWgi11bBvDVolU540brtFI5hm5brP4AlIdQR
	AMqtdzBMsG7qtQajSDXI3wBv9kmGaXX9c4hmCu3BkVZPIx5JKXEZ3HZnAxWYhUvssB/KzMAL2LU
	I3FjOnodvqR6HTpJKxSYv3LRZidgT2GIa6eSF/Ea1tm/vNtVXW0nhtmRTT374pTPRHFHJ+721P+
	Pzmp4dS5WgR6Pht7GcQz85IOFkOm0KR8mM1E8cIOU/YkraKa9fzC7fMF0JBBA1/MCsIiikvlkku
	Qyg=
X-Received: by 2002:a05:600c:1906:b0:495:5e3d:15e1 with SMTP id 5b1f17b1804b1-499821fab4amr79240115e9.16.1786636124332;
        Thu, 13 Aug 2026 08:48:44 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c0:e90b:439b:8502:172e:8dcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499821217acsm60633555e9.2.2026.08.13.08.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:48:43 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 2/5] setup: extract path_allowlist_apply()
Date: Thu, 13 Aug 2026 17:47:45 +0200
Message-ID: <20260813154748.2378747-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.547.gbb97bea608.dirty
In-Reply-To: <20260807135511.1818458-1-christian.couder@gmail.com>
References: <20260807135511.1818458-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit we are going to check whether a repository is
part of an allowlist specified in a config variable.

To prepare for that let's extract existing code from
safe_directory_cb() into a new path_allowlist_apply() helper that will
help with such checks.

While at it let's make the helper's code simpler and more generic.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 setup.c | 107 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 48 deletions(-)

diff --git a/setup.c b/setup.c
index 95909e9603..39dfa1cc5f 100644
--- a/setup.c
+++ b/setup.c
@@ -1339,6 +1339,64 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
 	}
 }
 
+static void path_allowlist_apply(const char *key, const char *value,
+				 const char *target_path, int *is_match)
+{
+	char *allowed = NULL;
+	char *normalized = NULL;
+
+	if (!value || !*value) {
+		*is_match = 0;
+		return;
+	}
+
+	if (!strcmp(value, "*")) {
+		*is_match = 1;
+		return;
+	}
+
+	if (git_config_pathname(&allowed, key, value) || !allowed)
+		return;
+
+	/*
+	 * Setting the config variable to a non-absolute path makes
+	 * little sense---it won't be relative to the configuration
+	 * file the item is defined in.  Except for ".", which means
+	 * "if we are at the top level of a repository, then it is
+	 * OK", which is slightly tighter than "*" that allows
+	 * discovery.
+	 */
+	if (!is_absolute_path(allowed) && strcmp(allowed, ".")) {
+		warning(_("%s '%s' not absolute"), key, allowed);
+		goto end;
+	}
+
+	/*
+	 * A .gitconfig in $HOME may be shared across different
+	 * machines and the config variable entries may or may not
+	 * exist as paths on all of these machines.  In other words,
+	 * it is not a warning worthy event when there is no such path
+	 * on this machine---the entry may be useful elsewhere.
+	 */
+	normalized = real_pathdup(allowed, 0);
+	if (!normalized)
+		goto end;
+
+	if (ends_with(normalized, "/*")) {
+		size_t len = strlen(normalized);
+		if (!fspathncmp(normalized, target_path, len - 1))
+			*is_match = 1;
+		goto end;
+	}
+
+	if (!fspathcmp(target_path, normalized))
+		*is_match = 1;
+
+end:
+	free(normalized);
+	free(allowed);
+}
+
 struct safe_directory_data {
 	char *path;
 	int is_safe;
@@ -1352,54 +1410,7 @@ static int safe_directory_cb(const char *key, const char *value,
 	if (strcmp(key, "safe.directory"))
 		return 0;
 
-	if (!value || !*value) {
-		data->is_safe = 0;
-	} else if (!strcmp(value, "*")) {
-		data->is_safe = 1;
-	} else {
-		char *allowed = NULL;
-
-		if (!git_config_pathname(&allowed, key, value) && allowed) {
-			char *normalized = NULL;
-
-			/*
-			 * Setting safe.directory to a non-absolute path
-			 * makes little sense---it won't be relative to
-			 * the configuration file the item is defined in.
-			 * Except for ".", which means "if we are at the top
-			 * level of a repository, then it is OK", which is
-			 * slightly tighter than "*" that allows discovery.
-			 */
-			if (!is_absolute_path(allowed) && strcmp(allowed, ".")) {
-				warning(_("safe.directory '%s' not absolute"),
-					allowed);
-				goto next;
-			}
-
-			/*
-			 * A .gitconfig in $HOME may be shared across
-			 * different machines and safe.directory entries
-			 * may or may not exist as paths on all of these
-			 * machines.  In other words, it is not a warning
-			 * worthy event when there is no such path on this
-			 * machine---the entry may be useful elsewhere.
-			 */
-			normalized = real_pathdup(allowed, 0);
-			if (!normalized)
-				goto next;
-
-			if (ends_with(normalized, "/*")) {
-				size_t len = strlen(normalized);
-				if (!fspathncmp(normalized, data->path, len - 1))
-					data->is_safe = 1;
-			} else if (!fspathcmp(data->path, normalized)) {
-				data->is_safe = 1;
-			}
-		next:
-			free(normalized);
-			free(allowed);
-		}
-	}
+	path_allowlist_apply(key, value, data->path, &data->is_safe);
 
 	return 0;
 }
-- 
2.55.0.565.gc116661202

