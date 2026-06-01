Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020783D8104
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328633; cv=none; b=BaqwR4qp87E3ZlrBDJdnNDdhu9rF3IQVThDlHZjTV0DCyN+d9fj1d0isQl9ZFrlZKJqszgXEq71cCmcwTWGT8YJNfT1Vk5A1QlwHHNbstpxyhFc5ZwjJ+/nmRg3TXWhRsPeioJO1jNQYWWKH1tHNIqe1RGTaR4ejgbnqRQkbRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328633; c=relaxed/simple;
	bh=5KIWUcltrJf9e3rFqPneanZwKO/HHCtaDgLGetU9ZW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlcA4JhxZFRD+cFkNFkf3wcws/yc18QFNFR+D1gJBHAvszeNEEvECSifc9APRsIqkDXYtmpQSbX5x2wAu7DAWk4BSpI0Xv5QBEjZwUT6WzGGF+V6j18pHYE1wAh/RQedSa0MyzRaMjv+/Gjn976xZDkR6FPXM/hXGtCh/ZLkw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+PvQlim; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+PvQlim"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso93168355e9.2
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780328629; x=1780933429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9Ppbw7Mvhw0n+LOtNbpZFhHe2Dg7zlX7Ra36EcUPpo=;
        b=L+PvQlim/w7qjiHfZRgKNuTB5jNm5UuYCmAfLeC5zCWoAS8uqnlAyd27ngqe+HvAPK
         5NrQO62M3gTwDuI1rLGseFl6OQpDqwykgYbghMszEB5cm3bTyVTRA0RGtcJXYE7RQWme
         lftVdyRgWURaQg/e2c/4TAHtNGsIY8yjeA2NbPSYs+ivUa4ZioOzLUMKp1xjvgqY8/c8
         B9ouJRh0wSltJRDDMOTbOa6y5wNW7vfCZvqa4LHSoPVL3HBygPzX7Mq+TCe68GmTNXOc
         YVT6wLJy9VxIEYPC/+cUUAgsPDa0/8WtbhWGQkew/JiCp2PtHZ08+iek4Y0mnFEkkahI
         tJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328629; x=1780933429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x9Ppbw7Mvhw0n+LOtNbpZFhHe2Dg7zlX7Ra36EcUPpo=;
        b=P/dnmcZ6gnJx48DCf+XQdc74a4dcBI35OOzZYLGT1xtsd1cEHwJ+u9sI1KlANUFj5J
         kOauEPiefeW7BYSkcrIQf9Lem6muoxz5GqzwrxruJ5wy54k5ztevX/gg3HFRYzI2IlwJ
         8u2avSvbWzDAo22Qjg35OGpcxFEmBtQg9N+wPvbzKH1t0Iz/IEKcn0B+w8pokgwf30sA
         SdIcYP73ETGGHF2b8iJg9Vjyhj92FEUnYvEbdPHIOE2EUs6A9zZPwOn47F0F2R4EBx+o
         EYJXEYeSdGK/NiOgCUs6m0szJdIPHl2mIV7gmFB+Yxdjcal34FwxggPP48h0RPDW3vBv
         QkvA==
X-Gm-Message-State: AOJu0Yz6PooU9pgpgBn999d8ZIiEJjNiynkX5GOxfc3TvoToRUhqsr1E
	nuqk9GAk1Whnwr5/t5qtrkYUaBpgY1H/qZkeleLtm11Ovh3/BYyrD3+hfBqS/rsl
X-Gm-Gg: Acq92OElOs+qXWoRflDdcD6QAacupwUAhWBaNVgDazLhiMXu3W5/cSrm6Tz+z1x8L38
	v5RI6oe5u/CEtq8p6C0ntTdXHgCy3wOgHCcHT3qCzyd+ITGXxgKHwlizxC/SQDAa0UilWBQCTfR
	TGTqsrX60tsjwh2pe//hQxtB3BOmLTY3PbcXgtSyFDxPh01T0pgAuHk93HIws8eFJlKQDc4imEv
	cr2IkGDZv7M48pGDEx9gEmijrrB4osYThFDjx2mkq9W+ham6lV4kMlgNO2giI81af2ckYZEe4U1
	qotJg6Tz1ASOeknlgDk6vWrYaybMQa6qXFjYY9GWF0dREJmpJ0C7F/z3dZD8qA29movtX/A6Hj9
	n9lkYw1h307r4BU0ytCvvPObN1hnSLclWSIiwn+WaPBBdbOqqkidMpPFsalzSOKUp0Q7Kg4MdHi
	k2Oy7u2Cg1Q4vCXUJg6KMaZDQInFCI0vy9NZV9pN8rCk5ZQXHSf08OJl3OX2GMZbfwSg==
X-Received: by 2002:a05:600c:4e45:b0:490:ab8b:1bb3 with SMTP id 5b1f17b1804b1-490ab8b1c1amr62095205e9.18.1780328629018;
        Mon, 01 Jun 2026 08:43:49 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e07:e310:19bb:fe0b:a332:fe8a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e81ef4sm350485e9.12.2026.06.01.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:43:48 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 1/8] environment: move "trust_ctime" into `struct repo_config_values`
Date: Mon,  1 Jun 2026 16:42:04 +0100
Message-ID: <20260601154211.82370-2-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260601154211.82370-1-belkid98@gmail.com>
References: <20260423160832.114816-1-belkid98@gmail.com>
 <20260601154211.82370-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `core.trustctime` configuration is currently stored in the global
variable `trust_ctime`, which makes it shared across repository
instances in a single process.

Store it instead in `repo_config_values`, where eagerly‑parsed
repository configuration lives. `core.trustctime` is parsed eagerly
because it is used in low‑level stat‑matching functions
(`match_stat_data()`), where a lazy parse could cause unexpected
fatal errors, result in a performance regression and complicate
libification efforts. This preserves that behavior while tying the
value to the repository from which it was read, avoiding cross‑repository
state leakage and continuing the effort to reduce reliance on global
configuration state.

Update all references to use repo_config_values().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 environment.c | 4 ++--
 environment.h | 2 +-
 statinfo.c    | 6 ++++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index fc3ed8bb1c..0a9067729e 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,6 @@ static int pack_compression_seen;
 static int zlib_compression_seen;
 
 int trust_executable_bit = 1;
-int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
@@ -309,7 +308,7 @@ int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "core.trustctime")) {
-		trust_ctime = git_config_bool(var, value);
+		cfg->trust_ctime = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "core.checkstat")) {
@@ -721,4 +720,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->attributes_file = NULL;
 	cfg->apply_sparse_checkout = 0;
 	cfg->branch_track = BRANCH_TRACK_REMOTE;
+	cfg->trust_ctime = 1;
 }
diff --git a/environment.h b/environment.h
index 123a71cdc8..64d537686e 100644
--- a/environment.h
+++ b/environment.h
@@ -91,6 +91,7 @@ struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;
 	int apply_sparse_checkout;
+	int trust_ctime;
 
 	/* section "branch" config values */
 	enum branch_track branch_track;
@@ -161,7 +162,6 @@ extern char *git_work_tree_cfg;
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
-extern int trust_ctime;
 extern int check_stat;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
diff --git a/statinfo.c b/statinfo.c
index 30a164b0e6..4fc12053f4 100644
--- a/statinfo.c
+++ b/statinfo.c
@@ -3,6 +3,7 @@
 #include "git-compat-util.h"
 #include "environment.h"
 #include "statinfo.h"
+#include "repository.h"
 
 /*
  * Munge st_size into an unsigned int.
@@ -63,17 +64,18 @@ void fake_lstat_data(const struct stat_data *sd, struct stat *st)
 int match_stat_data(const struct stat_data *sd, struct stat *st)
 {
 	int changed = 0;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	if (sd->sd_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
+	if (cfg->trust_ctime && check_stat &&
 	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
 		changed |= CTIME_CHANGED;
 
 #ifdef USE_NSEC
 	if (check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
+	if (cfg->trust_ctime && check_stat &&
 	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
 		changed |= CTIME_CHANGED;
 #endif
-- 
2.53.0.155.g9f36b15afa

