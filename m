Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B233DB331
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002689; cv=none; b=UgyZx49KIPAe3vsr85SXGdG+n6N9A9MuwiGvFO2dfNM8DCG9gMV+F94HsyWSg+9ZtkkseZSZvyoJPWFBzCeOHXwUWuoYDaA1JF9gOBBQi0tJbPcXPu0EzSHsCqp475Zobyod7JTlBrSLrCBxFxDW1NU1164z2v2xj0YuOSxGkiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002689; c=relaxed/simple;
	bh=Bg83hM3BMA6KroK3ahMOo6FvLJdF8/aZ2jO8hrXMBds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ckyb/Zfbzhyy3rpYrFpGy4AB9d3TG+FYJqDi6OshxwU6HuaZhmaMKIkJDggVRPcPsn56uby6Bke6d9Y40XYanC/M5BtrTQmXNJ9XU7aNTvii9xNMLjAiwwYdxL8TsKcX+TVDuP5lTNS5bdjgS5ATXzu6JbmrTAfYCJdQJ1x+tMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bHq2eYxw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B5sGSEuf; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bHq2eYxw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B5sGSEuf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D1EF57A0064;
	Thu,  6 Aug 2026 03:51:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 03:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786002686;
	 x=1786089086; bh=qFpOwpmWscGAFO4J4fWwyhNBZgGJpGqo02MUEs1p0VI=; b=
	bHq2eYxwHBSK/uzxlrJYj7ZqYyvvZD6LxNpxVzYtwmxLwgQCsCGOfgRkqOghOZF9
	3b6qtKaSOmGbW10S34xmcH1+yZwPQjCIRAhC55aJoCZhqpvN70LuVNJghYPHYpCs
	xS9nsNaHweGgIFqAHCVbgrmOY9hHgdRWtnUCTABhxKFI25KR8fe0nX3eIV14DFJa
	leOXr2ltFNfGlWafiV3uajC6tEiE2Gsrn56CwaYdfyzq4L/FB12+iMTa4f4LIBtU
	qe5Km3Wgd7Yj2eIWhDL418L/n6r+ScVayywPpyjH6zOHAFbJ8Uj163gz182V6hta
	V3FgsmunXUtUfFlcn3kleQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786002686; x=
	1786089086; bh=qFpOwpmWscGAFO4J4fWwyhNBZgGJpGqo02MUEs1p0VI=; b=B
	5sGSEufKAHmTpByUbKki79125kQ7BIhgC9OBWtZkBt7EfxXr3+hdlawDqjHlk5WK
	Ttl2txTvKsCZmMy/C6YDC7hfrxYAJGgVaoJDziulOUoFA/Wc2n/XYHf2H2YMDfAK
	dNLNZWilpqdv2DK6XEGvVL5MtmdBIsU2v862r2OuJxhPQvzfw8ALEAjLsnVEYQem
	naB+XZleJMTShHFQFGCP9drPxjYtHZJqhSjL+Xqxb2yAx8vyc/zWLXJu/BWthquJ
	CHTfCKQAKeAA5KXB9WWzCvoaDveyYTSUI4fn1Z7204kENjgQMRayq8DZIUpaE8Fb
	Bz8r4/6KLMcHQm4ks7mQw==
X-ME-Sender: <xms:_jx0ajQAl8XtWbA_byGJPkFT0PWs6S0F8Gt3xRTUbk-guzFIHrnapg>
    <xme:_jx0aryOmHb0LsNd7v4K4oFxFk5bhYVW2A1nDKBvu6oN0D4UALa-z4v7OMlmPejYY
    FQALVCso6_hJIgojHVWT-spgMhgDkyqM7oe3hh-duVfLIC72eje3R0>
X-ME-Received: <xmr:_jx0at27a5r6AsaIT5cZ3ucnUFPc3K5OlL3ST__yLfTCqug2Co6h58sBdppRjaQbIDbTZphs0Pm3-SWVSpsrXUm3ynhO6U3c7d58MnQYxHI>
X-ME-Proxy-Cause: dmFkZTEtzha/e+/fLcr4yLYpFwljivEi4kiTD7GQZPS8Iw0t2O9ajSX2+zUSgp9R1U7o7/
    hmHI+bz0bFhYZWQWsopHriyW8MDU5aGaxS/Ka5E1xvBCiYuRw74vzVpofzEXygJ1CwqDlG
    9MK5XFO9NkVkUvYdezd7H/YB5y5u+Kd3CVS2NtPW3YgPmy5Z8yRnFeh6G4pRMZORW6pnsn
    MVklV1UcYGQBbOa6rKltEdQPLJLC3eZHnHD7G+UXpSJ2eKBLWwYzrr+h2+pufPwNDlElaq
    hGTFGng084YkBjiId1Qpsg1lA0yeLxZrliGnN9/Z1rO+VHoSsgHcG3jlFfU1PzSAzMcklR
    7E45qSztQ34HwIcDgCfmwUrl2Fd8e3Zgn/WNbrrToo11b7Q7ZI3GwxTln27zjuzGBxmCP2
    XmLXf/G26AUpoAtHpMIaC91eel7deaTjzCtjZqfwKQ5EVT9pc04vA3ABMspSpHkzkYeM3j
    VbJG1+9UvxfpYO2dv6lTvgcgYFu/6VHLxr6LTS1nrZgIedT6Owq2qxi6GpvGOXkrVhi+pX
    gTpYjDYCYqGoQLHsqzJ4Zby0ojgor+be3qTLg8zi+nzM7iXGeKxoACn1r8kB4OYuhE7iKT
    fIK8bk7xSVEVQz1F+tEPTr48IZ1JQ4QhJTK3Erdonpm//ney3wGD+Or4697w
X-ME-Proxy: <xmx:_jx0ah6ZgznbNCrnwdFVC-aXt0UgFJdjO7aN4brHe201j1clU1U4Gw>
    <xmx:_jx0aoVbgpFLha7P151_wUtHouo2thgAU7lb59WJT8O4v5HriItBEg>
    <xmx:_jx0aoDD7BX596yBLJd_kbtwWwZwJYUR4ewxQYVMylajP1dekfGMcQ>
    <xmx:_jx0av5QX89_Jz7TMuDEcUq4bxE_rDdwFKnwGDiWltifwt6oyaMuvg>
    <xmx:_jx0ak3uY53uboqi_hL1DNSTr7mDchTcM67uhSdiWBFovRni6_2PZU55>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 03:51:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e3d2837 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 07:51:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Aug 2026 09:51:04 +0200
Subject: [PATCH v4 6/6] odb: make creation of on-disk structures pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-pks-odb-create-on-disk-v4-6-ba8b4fdd2e3c@pks.im>
References: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
In-Reply-To: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

When creating a new "files" object database source we have to create a
couple of directories. These directories are of course specific to this
particular backend, and a different backend may require a setup that is
completely different.

Make the creation of on-disk structures pluggable to accommodate for
this.

Note that there is one exception though: the "objects" directory must
exist in a repository regardless of which backend is in use. If it
doesn't exist then the repository is not treated as a Git repository at
all. Consequently, we create this directory regardless of the backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 19 +++++++++++++++++++
 odb/source.h       | 23 +++++++++++++++++++++++
 setup.c            | 34 ++++++++++++++++++----------------
 3 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 4138758511..0db6e681fe 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -9,6 +9,7 @@
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
 #include "packfile.h"
+#include "path.h"
 #include "strbuf.h"
 #include "write-or-die.h"
 
@@ -41,6 +42,23 @@ static void odb_source_files_close(struct odb_source *source)
 	odb_source_close(&files->packed->base);
 }
 
+static int odb_source_files_create_on_disk(struct odb_source *source)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	safe_create_dir(source->odb->repo, source->path, 1);
+
+	strbuf_addf(&path, "%s/pack", source->path);
+	safe_create_dir(source->odb->repo, path.buf, 1);
+
+	strbuf_reset(&path);
+	strbuf_addf(&path, "%s/info", source->path);
+	safe_create_dir(source->odb->repo, path.buf, 1);
+
+	strbuf_release(&path);
+	return 0;
+}
+
 static void odb_source_files_prepare(struct odb_source *source,
 				     enum odb_prepare_flags flags)
 {
@@ -271,6 +289,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 
 	files->base.free = odb_source_files_free;
 	files->base.close = odb_source_files_close;
+	files->base.create_on_disk = odb_source_files_create_on_disk;
 	files->base.prepare = odb_source_files_prepare;
 	files->base.read_object_info = odb_source_files_read_object_info;
 	files->base.read_object_stream = odb_source_files_read_object_stream;
diff --git a/odb/source.h b/odb/source.h
index ab16d152f4..4abc418bdd 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -89,6 +89,18 @@ struct odb_source {
 	 */
 	void (*close)(struct odb_source *source);
 
+	/*
+	 * This callback is expected to create on-disk data structures that are
+	 * required for this source to operate.
+	 *
+	 * The callback is expected to return 0 on success, a negative error
+	 * code otherwise.
+	 *
+	 * This callback may be NULL in case the source does not need any
+	 * on-disk setup.
+	 */
+	int (*create_on_disk)(struct odb_source *source);
+
 	/*
 	 * This callback is expected to prepare the source so that it becomes
 	 * ready for use. It optionally clears underlying caches of the object
@@ -316,6 +328,17 @@ static inline void odb_source_close(struct odb_source *source)
 	source->close(source);
 }
 
+/*
+ * Create on-disk data structures that are required for this source to operate
+ * correctly. Returns 0 on success, a negative error code otherwise.
+ */
+static inline int odb_source_create_on_disk(struct odb_source *source)
+{
+	if (!source->create_on_disk)
+		return 0;
+	return source->create_on_disk(source);
+}
+
 /*
  * Prepare the object database source and clear any caches. Depending on the
  * backend used this may have the effect that concurrently-written objects
diff --git a/setup.c b/setup.c
index e39a1646bb..1f65f69534 100644
--- a/setup.c
+++ b/setup.c
@@ -2649,25 +2649,27 @@ static int create_default_files(struct repository *repo,
 
 static void create_object_database(struct repository *repo)
 {
-	struct strbuf path = STRBUF_INIT;
-	size_t baselen;
+	/*
+	 * Create the "objects" directory in the common directory. This is done
+	 * so that the repository can be discovered regardless of the backend
+	 * used.
+	 *
+	 * Note that we only do this in case the object directory wasn't
+	 * overwritten via an environment variable. If it _is_ being overridden
+	 * then we skip this step, as the repository won't be discoverable
+	 * anyway without the environment variable.
+	 */
+	if (!getenv(DB_ENVIRONMENT)) {
+		struct strbuf objects_dir = STRBUF_INIT;
+		repo_common_path_append(repo, &objects_dir, "objects");
+		safe_create_dir(repo, objects_dir.buf, 1);
+		strbuf_release(&objects_dir);
+	}
 
 	repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
 
-	strbuf_addstr(&path, repo_get_object_directory(repo));
-	baselen = path.len;
-
-	safe_create_dir(repo, path.buf, 1);
-
-	strbuf_setlen(&path, baselen);
-	strbuf_addstr(&path, "/pack");
-	safe_create_dir(repo, path.buf, 1);
-
-	strbuf_setlen(&path, baselen);
-	strbuf_addstr(&path, "/info");
-	safe_create_dir(repo, path.buf, 1);
-
-	strbuf_release(&path);
+	if (odb_source_create_on_disk(repo->objects->sources) < 0)
+		die(_("failed creating object database"));
 }
 
 static void separate_git_dir(const char *git_dir, const char *git_link)

-- 
2.55.0.679.g6767b8d81c.dirty

