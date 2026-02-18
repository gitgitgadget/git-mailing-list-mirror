Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D4274B4A
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771391967; cv=none; b=to3puGa3vvV72n0onEviTdbhpEDWDg5ivdd6Oh5eJVFPzwh4C17A/CFgrSZdxLvWVe5g0PW4cF9/Kf8x/nPFoF1OqPY+jr7lOCTiOKa4YgTdkx3Wtwh9ekKXhQCpK5L4Oo9aAOev8qdpSiueXdbhahamTjXev4PjgLoHCEdZVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771391967; c=relaxed/simple;
	bh=csSVK3N1QssLrWmw33O7qCU+nrUU2u/vVZ1KOI9u2Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slp9h/Q6wUOqLmAWwLFeUYa++GnSGgFA5MY20jQV7vCxcyDU34GHZYVh//6ViUi7kF2f96amTxhC3nS0gHSWqBI+LpeT+WIZNPDbs8pR+m0bn2GuUrgUwNzIjFeDFfVLypibLNHYv2aLO3Cfa2EA421wDFmvloH64A9iuDjjWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UothtmFi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UothtmFi"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a9633ef0d6so6171725ad.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 21:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771391965; x=1771996765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06dsEFL9vV7quEJgdH+3euCX4f5+36jAo41j7/3nfNA=;
        b=UothtmFirgSLfHa4bUjdvzGF7PYp/ePSsqOBoZV8xfihl0EXa+/N7MEWkCHSW7ji8n
         JEAlZR2sOGn240K+Kf/jSKdpWf0+Eh3dew5chp1+i1TL88Ms/ElyjGP6V+Oa4lv7u14T
         tECQFclY2LKxABoFRBMQ7eAdbvKp7gyvaJBKrGSyv1M4d0+QuWPEJBBKEq0usWk7cyUI
         0i0nNwULwgNypdc5wzKHUDuyVdr9MYDWkVthCIJMrGD5dAZYJQQXRimPjjTFeQbt1cdZ
         Z9s2OHZt6BOdFpQjZLsylR7vHAE0BfIG5baHguPwL0IkgsJLzkVNtuHlgCrlrNg5f45b
         b97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771391965; x=1771996765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=06dsEFL9vV7quEJgdH+3euCX4f5+36jAo41j7/3nfNA=;
        b=hfP5DKmJQ+na3fegjcpHQJruSj+Y43vm0uRt9YMN0MD2qqh2GEATPxIxLLqlbneUcB
         3TZyhtLtEUW341cJVXQn+4TWemLLEe2VmDHr77S0rBGVKxXqDKZBnLyvr1iOZkX3USeg
         1k4lGUcuEerxAKpWYKkDthoudw5xcbtUbXI4qMnKQhwjlYqtg61YIk2Uss6n3RK/sWUO
         ISVnrj1Rz6tXZemj+ugGs+aJlk+JrGO697rLt+QViMdzfl0EBByFsJH41bo+YdmrM3Xu
         o9Xid3aqO8mNTHmtqopsz2BjFLrOD5q1o2gSX8NhHP8h2bvnozE7bIdblMXH7ugg8h9X
         +JTg==
X-Gm-Message-State: AOJu0YzBpP7r7VVMrWjDDtRPrEkcr6muRQ/ZZ2mg/hTSRwI7JgK8l8uC
	cP4lDQjXhVZVY5GIWDASQkJ25oAWh53RaApn5Rao8CclyT/JS8TNMRDxvkm9PA==
X-Gm-Gg: AZuq6aK8bbBwVuR7e7U/i1bFJjndpmqi9yYDwfHQ6HIri5fYae6MLjB2MBpy/EV4M3v
	lrRnTSCKRUHxrVlp5WcbEXR0xvzpB8mso82Fr0rdUeRU5eZVq3ZOd2BC6gThJf/YmDx0YYwM7Ds
	yST6h2syjuIx30rcSfVPFj1MN3KrwHN+5Q4rCK9YjDkYCXCYDg//u+jF4sqeSwkw9ZdxQQIzHas
	jTP+QnZ8uGdd7AU8maJlodqxAS3fuHzhSULPD2epXTQOYxUnQ5i2b91fjaBaRzmIjOebMGscKX9
	pbQEYkUD1zHha0mmLmYYSGZTpKDYQWdhIVI8Z1apWh3s5GJuaqMiUT2Ab7lu0slQI16l8N6RVv2
	rTSXaWDesj+9u/l8AvzYZZCbnFM+z1pDit57iaYGvoN+GQA0VUVky4NG28bTldb8nR4IhbXi4xE
	BR/qdnjp7sVr4K+maPvyAwKq4FjuHpLdKPReRYD78=
X-Received: by 2002:a05:6a00:4ba7:b0:823:b2c:4aa9 with SMTP id d2e1a72fcca58-824c5ec6f5fmr9498722b3a.2.1771391964903;
        Tue, 17 Feb 2026 21:19:24 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a661sm15047688b3a.50.2026.02.17.21.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 21:19:24 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: [PATCH v5 1/2] setup: distingush ENOENT from other stat errors
Date: Wed, 18 Feb 2026 13:18:49 +0800
Message-ID: <20260218051850.164972-2-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218051850.164972-1-a3205153416@gmail.com>
References: <20260217084124.150366-1-a3205153416@gmail.com>
 <20260218051850.164972-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, 'read_gitfile_gently()' treats all 'stat()' failures as
generic errors. This prevents distinguishing between a missing file and
real errors like permission denied (fatal).

Introduce 'READ_GITFILE_ERR_STAT_ENOENT' and 'READ_GITFILE_ERR_IS_A_DIR'.

Updata 'read_gitfile_error_die()' to handle these cases:

1. Return for happy cases ('ENOENT', 'IS_A_DIR');
2. Die for fatal cases ('STAT_FAILED', 'NOT_A_FILE');

This prepares for error handling in the next commit.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 setup.c | 17 +++++++++++++----
 setup.h |  2 ++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index c8336eb20e..0ca129623e 100644
--- a/setup.c
+++ b/setup.c
@@ -897,10 +897,13 @@ int verify_repository_format(const struct repository_format *format,
 void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 {
 	switch (error_code) {
+	case READ_GITFILE_ERR_STAT_ENOENT:
+	case READ_GITFILE_ERR_IS_A_DIR:
+		return;
 	case READ_GITFILE_ERR_STAT_FAILED:
+		die(_("error reading %s"), path);
 	case READ_GITFILE_ERR_NOT_A_FILE:
-		/* non-fatal; follow return path */
-		break;
+		die(_("invalid %s: not a regular file"), path);
 	case READ_GITFILE_ERR_OPEN_FAILED:
 		die_errno(_("error opening '%s'"), path);
 	case READ_GITFILE_ERR_TOO_LARGE:
@@ -941,8 +944,14 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	static struct strbuf realpath = STRBUF_INIT;
 
 	if (stat(path, &st)) {
-		/* NEEDSWORK: discern between ENOENT vs other errors */
-		error_code = READ_GITFILE_ERR_STAT_FAILED;
+		if (errno == ENOENT)
+			error_code = READ_GITFILE_ERR_STAT_ENOENT;
+		else
+			error_code = READ_GITFILE_ERR_STAT_FAILED;
+		goto cleanup_return;
+	}
+	if (S_ISDIR(st.st_mode)) {
+		error_code = READ_GITFILE_ERR_IS_A_DIR;
 		goto cleanup_return;
 	}
 	if (!S_ISREG(st.st_mode)) {
diff --git a/setup.h b/setup.h
index 0738dec244..ed4b13f061 100644
--- a/setup.h
+++ b/setup.h
@@ -36,6 +36,8 @@ int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_NO_PATH 6
 #define READ_GITFILE_ERR_NOT_A_REPO 7
 #define READ_GITFILE_ERR_TOO_LARGE 8
+#define READ_GITFILE_ERR_STAT_ENOENT 9
+#define READ_GITFILE_ERR_IS_A_DIR 10
 void read_gitfile_error_die(int error_code, const char *path, const char *dir);
 const char *read_gitfile_gently(const char *path, int *return_error_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
-- 
2.43.0

