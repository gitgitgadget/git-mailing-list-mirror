Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D923DE458
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559221; cv=none; b=ZgNqlI915hesweDcBIqYzywOmh1jz9jkhLmlVEM9zrGhQ2Erm1W+ktGrymajXkuUwjNABrU2OuUsWAt0T5lWtvLIVIyT9PNCTr6Vw4afT4k44gf2m5+nRWAIo15VMHPObwmt5MnUq62USsymLLByYubaWTyEXV28EpVg+cFn4mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559221; c=relaxed/simple;
	bh=6ASQFlH6J5a8txX7YX7eIv5Tr29lFwuPW09c+M/fqf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ekA/luDLP0lcsve/OyyPHwjsGHLpNn661j+MrrGTfLMIZpdS4643x9uPngvdeNq942OkVEFsfM2n2isCH4MU3fnYvQbToFjmVRGe7Z65O4fwPIi1+6nzxRKiMw4d96yxMZ5BMfmin5juzUOX2vtdIefnP47pYzJqPCwHpgbSv8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YKu2j/u5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SqYZ0x2h; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YKu2j/u5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SqYZ0x2h"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 896A9140001F;
	Thu,  4 Jun 2026 03:46:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 04 Jun 2026 03:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780559219;
	 x=1780645619; bh=zd6WsdEzd2Ic58+wSYNvlimRR382r7mYpRv3ejaDPWE=; b=
	YKu2j/u5UhKjY3yJ1gLHKDysoqdElPutKsnnhScTVNBblWA8GveIGVARpc7kqYZB
	gKQNYfqYValdZuTRuvdDdlD77QsGWo05tQ2NBPsK5teBec2Hkyspoyfhz+uoACO3
	FUd5Aloj1Xfg6ySdacp/+ee7zd585Dm2QHst73zUI8lDDZZ4OW2b/5wjSPjPmTWl
	idIVofkDHcYKeoHxkN9im0amqjqMiAnH/JYn9rSbEEvsdAoUJSxiiCI4hUZw9jVv
	/zazWEk7Vrs7KTNYqTdt5gdMIO3EgzCiwsP9/+8X7C85aIMbbrGWqoub4em5C9IU
	QlxMKwf2kY3xkhN54kRflg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780559219; x=
	1780645619; bh=zd6WsdEzd2Ic58+wSYNvlimRR382r7mYpRv3ejaDPWE=; b=S
	qYZ0x2hKA28a5UI44Lcp90XA7zQjIRv6lpErBC/22svzpIP1sXQ1YR2OBfPaZMRn
	yDX6O6pvFllbZiTIpGDwbfr78cPdnhdW1qEU6IfMcoUJR086OInErlPmoPYDgcw8
	mB9/cpBDtCUx099iIBvifxmuut6XlghEH2fyRymL6XEHety4j9ruucpT5TUkxz55
	uf6MLhUebaBMvYYUeEO2Xdrf2ROuCYQMSthKuhhRx90WFT1YY2KsuOj2+OY1MHrJ
	E6b/AHOaIYELIqQJfK3IxWG0ffZUp9MzPKIIdxFfJHBBVXn8S1QvtKJ6l0sLHUEq
	hgKqmtKfh8blAQXG+T9cQ==
X-ME-Sender: <xms:cy0hakmNQzCOpM-wWp7Oisqm8xglwi0yu2iAcBzfO52PvKh_GoKe2A>
    <xme:cy0haq1-LS4q6CCmBkUlj80RjcDc-bAt5_seeQd9DiYtZ3sfvnnDxeVpAjR0eQzUf
    NKPfkpgUfTrn_Ehsia6n5WZrHMN227GIhQI785hkA4hC-A6pmqffcQ>
X-ME-Received: <xmr:cy0hanprlMRt7_pjoL_HvbSSV6pDLWUDJGryDL3WYjGOgeRYYjpZf_cS5BZCjrhu-AglMOaa0G2bwVaMmI-h6zjrPJg0NtJmpw7KXQkXoyI>
X-ME-Proxy-Cause: dmFkZTGhxnEHpPYRfkYwrVk9CvMD/gy9+RwFxuxewttP632BuodwIhLBPqS0tGa/W0UmLv
    7dRtKxJAyCQXYHS1ssdOVK4eYn6AQPxqA2nPPXNw33ZvSAryoaIVsd9m2fF98906KDu89E
    0dwdOj/gFzkYPI2rh7o0xGlm56B6RVfGjglopqL39L4tATVvd1Z2/tUfcF9LAKFfVywOx4
    9kQmC+TuR6fWOqXkOMYNzMgYGfd1SXpHm/N0LhqxKv8HZrQ4j+pd53HQ7tm61Lb1dGIavo
    hGfj9Ry8AN4Mg7aMmuQhyLLzW5lBB/9q46FjrRfoBhVa/sD93g86VYmknHPMphOd72Rxjc
    gJcfjmOdHWYK2Hx6ZJVulhQp4F2nFvSXUbCWB5Au3wKrs9z7Gb8ubZmHUvWdeCcY6EmPjH
    Uj4n3pJ2AgrWndDK4u0axp/jqBlo8UH3yyH0WRIzaOT0yPEJD0kvgiK2bxX/qhT7TzMaSo
    kB6Zz7GZCyK9irz0664xruoIJh3yx24brT9R4JVWNHo8jmhnPybOmc6XG/I9JwEC2HxCy5
    WWsYh/5yEWv8x0wsJaB9W9fh5Iid3oxQ3Zzf2F1/fciQ61Gttho3lslJi6ZAzyHvFdQI1H
    usy8cQVRbsLPAxAICVw8mrs2qliaM7fcuuxC9ZY7kUsC49vPAEf2ISMR1F9A
X-ME-Proxy: <xmx:cy0havdsWcW4wlcr_Gn4Bm8liBiCBPPPZSY0zRJ_BvQQ52V1kIDLJQ>
    <xmx:cy0hauqE7rGwWdkfBNRCNTUmrP22Y9y7NRhQBApYJ5_SAJbZ00MQFg>
    <xmx:cy0haoEhR9APNAWw1RY2s10nKSWhkO_bB0MbP6G2dB8LqwLULMzsPw>
    <xmx:cy0hams9Ot_jOrvgbQUFCb9dCSa_ycrOWcv8w5pwbao_C32W7p5fHw>
    <xmx:cy0hajLu6LDpKPTN3IuaLfrUw-1q8qMRIYbgXHTe45ld5A14VqrXlXzP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 03:46:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c64400d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 07:46:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 09:46:32 +0200
Subject: [PATCH v3 8/8] setup: construct object database in
 `apply_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-b4-pks-setup-centralize-odb-creation-v3-8-0691834f318a@pks.im>
References: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
In-Reply-To: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

With the preceding changes we now always construct the repository's
object database before applying the repository format. Remove this
duplication by constructing it in `apply_repository_format()` instead.

Note that we create the object database _after_ having set up the
repository's hash algorithm, but _before_ setting the compat hash
algorithm. This is intentional:

  - Constructing the object database may require knowledge of its
    intended object format.

  - Setting up the compatibility hash requires the object database to be
    initialized already, because we immediately read the loose object
    map.

The first point is sensible, the second maybe a little less so. Ideally,
it should be the responsibility of the object database itself to
initialize any data structures required for the compatibility hash. But
this would require further changes, so this is kept as-is for now.

Further note that this requires us to move handling of the environment
variables GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES into
the repository format, as well. This allows the caller more flexibility
around whether or not those environment variables are being honored, as
we want to respect them in "setup.c", but not in "repository.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c |  4 +---
 setup.c      | 45 +++++++++++++++++++++------------------------
 setup.h      | 10 ++++++++++
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/repository.c b/repository.c
index 61dfbb8be6..187dd471c4 100644
--- a/repository.c
+++ b/repository.c
@@ -291,13 +291,11 @@ int repo_init(struct repository *repo,
 	if (read_repository_format_from_commondir(&format, repo->commondir))
 		goto error;
 
-	if (apply_repository_format(repo, &format, &err) < 0) {
+	if (apply_repository_format(repo, &format, 0, &err) < 0) {
 		warning("%s", err.buf);
 		goto error;
 	}
 
-	repo->objects = odb_new(repo, NULL, NULL);
-
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
diff --git a/setup.c b/setup.c
index 4a8d6230b1..513fc88749 100644
--- a/setup.c
+++ b/setup.c
@@ -1752,12 +1752,22 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 
 int apply_repository_format(struct repository *repo,
 			    const struct repository_format *format,
+			    enum apply_repository_format_flags flags,
 			    struct strbuf *err)
 {
+	char *object_directory = NULL, *alternate_object_directories = NULL;
+
 	if (verify_repository_format(format, err) < 0)
 		return -1;
 
+	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
+		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
+		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
+	}
+
 	repo_set_hash_algo(repo, format->hash_algo);
+	repo->objects = odb_new(repo, object_directory,
+				alternate_object_directories);
 	repo_set_compat_hash_algo(repo, format->compat_hash_algo);
 	repo_set_ref_storage_format(repo,
 				    format->ref_storage_format,
@@ -1773,6 +1783,8 @@ int apply_repository_format(struct repository *repo,
 	repo->repository_format_precious_objects =
 		format->precious_objects;
 
+	free(alternate_object_directories);
+	free(object_directory);
 	return 0;
 }
 
@@ -1785,7 +1797,8 @@ int apply_repository_format(struct repository *repo,
  * If successful and fmt is not NULL, fill fmt with data.
  */
 static void check_and_apply_repository_format(struct repository *repo,
-					      struct repository_format *fmt)
+					      struct repository_format *fmt,
+					      enum apply_repository_format_flags flags)
 {
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -1794,7 +1807,7 @@ static void check_and_apply_repository_format(struct repository *repo,
 		fmt = &repo_fmt;
 
 	check_repository_format_gently(repo_get_git_dir(repo), fmt, NULL);
-	if (apply_repository_format(repo, fmt, &err) < 0)
+	if (apply_repository_format(repo, fmt, flags, &err) < 0)
 		die("%s", err.buf);
 	startup_info->have_repository = 1;
 
@@ -1874,15 +1887,9 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 	}
 
 	if (is_git_directory(".")) {
-		struct strvec to_free = STRVEC_INIT;
-
 		set_git_dir(repo, ".", 0);
-		repo->objects = odb_new(repo,
-					getenv_safe(&to_free, DB_ENVIRONMENT),
-					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-		check_and_apply_repository_format(repo, NULL);
-
-		strvec_clear(&to_free);
+		check_and_apply_repository_format(repo, NULL,
+						  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
 		return path;
 	}
 
@@ -2034,8 +2041,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	    startup_info->have_repository ||
 	    /* GIT_DIR_EXPLICIT */
 	    getenv(GIT_DIR_ENVIRONMENT)) {
-		struct strvec to_free = STRVEC_INIT;
-
 		if (!repo->gitdir) {
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
@@ -2046,17 +2051,13 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
 
-			repo->objects = odb_new(repo,
-						getenv_safe(&to_free, DB_ENVIRONMENT),
-						getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-			if (apply_repository_format(repo, &repo_fmt, &err) < 0)
+			if (apply_repository_format(repo, &repo_fmt,
+						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 				die("%s", err.buf);
 
 			clear_repository_format(&repo_fmt);
 			strbuf_release(&err);
 		}
-
-		strvec_clear(&to_free);
 	}
 	/*
 	 * Since precompose_string_if_needed() needs to look at
@@ -2805,7 +2806,6 @@ int init_db(struct repository *repo,
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	struct strvec to_free = STRVEC_INIT;
 
 	if (real_git_dir) {
 		struct stat st;
@@ -2826,16 +2826,14 @@ int init_db(struct repository *repo,
 	}
 	startup_info->have_repository = 1;
 
-	repo->objects = odb_new(repo, getenv_safe(&to_free, DB_ENVIRONMENT),
-				getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-
 	/*
 	 * Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_and_apply_repository_format(repo, &repo_fmt);
+	check_and_apply_repository_format(repo, &repo_fmt,
+					  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
 
 	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
@@ -2892,7 +2890,6 @@ int init_db(struct repository *repo,
 	}
 
 	clear_repository_format(&repo_fmt);
-	strvec_clear(&to_free);
 	free(original_git_dir);
 	return 0;
 }
diff --git a/setup.h b/setup.h
index efbb82fdbf..19679fe78f 100644
--- a/setup.h
+++ b/setup.h
@@ -221,6 +221,15 @@ void clear_repository_format(struct repository_format *format);
 int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err);
 
+enum apply_repository_format_flags {
+	/*
+	 * Honor environment variables when applying the repository format to
+	 * the repository. For now, this only covers environment variables that
+	 * relate to the object database.
+	 */
+	APPLY_REPOSITORY_FORMAT_HONOR_ENV = (1 << 0),
+};
+
 /*
  * Apply the given repository format to the repo. This initializes extensions
  * and basic data structures required for normal operation. Returns 0 on
@@ -229,6 +238,7 @@ int verify_repository_format(const struct repository_format *format,
  */
 int apply_repository_format(struct repository *repo,
 			    const struct repository_format *format,
+			    enum apply_repository_format_flags flags,
 			    struct strbuf *err);
 
 const char *get_template_dir(const char *option_template);

-- 
2.54.0.1064.gd145956f57.dirty

