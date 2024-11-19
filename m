Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FE01D0B9B
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030626; cv=none; b=Zye4rL53wEZtgpEpfpDBxyvldJ73PhduPfCmV8MoxOo2cAQ4KYimdf5NkW8X87B30v1rYBsViC6fR9HtINkn4HywAsqFI/UpV50sV0qCbgSLJxfHOR3NwkzLUvHaeCjzOAwWuKsSLGhRKKJIMRmk7qyDN/QkShJGMFN+/w85Zf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030626; c=relaxed/simple;
	bh=4FGXJhrae13n8KrE5hoTfISREt6HbuuOZXqk7YgyJhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KawvYXAtKZcc4AjFOXkuBozgc/4eLRUow4Tsv/1WjV80Ft5XFHNfVOWpChIXYbqXjcJqouYAVgTGInkTmKzEv0AXApl1FrZpAcK2ZKYkfH5Ze3/Fqw46Lv7KjC+BiGgxMpnSqIXkzHIK0qL9o8GgmDdy1iYM1K7omk0DUndwqFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsKfLCfD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsKfLCfD"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cfc19065ffso1222263a12.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732030623; x=1732635423; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSVcWDgZyHlNFFEtLuqEKQITPLwP2nkZyjPt23yFoBA=;
        b=HsKfLCfDXqSGNeH9BqBtCjEYtbLu7czGYTY9COg2YxGDSh7+KBprGoMQKyNuVkYJ/y
         pSO8Y9qOSOoUnwUU4AMYEHi+oVbtgbVr8BPfaklXWKhRpXdstOFCCEjbsbqktYgehxor
         TqUeDqMq6PrXRMtL58nybSEwJCMekrixaCapVX4VUoCzDHcKAvYFN87n3XS3bW3QJPJv
         6UmiKHwLwHXUgglR0NqktchqLI5+sGN+yZVq/hg6wxBUwzsDXEBbLrk3lRxpt4Vtccr9
         uIZRsVRMJa+v6vYcz17zSe1wZ2Howqymi0lV+LHgsR3+MQsvwP92szDZVd5qcs7rCH4I
         7+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030623; x=1732635423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSVcWDgZyHlNFFEtLuqEKQITPLwP2nkZyjPt23yFoBA=;
        b=Rf0+MhBKpO2ulAv2jC3N3wgGIpVXl4uXGCYu/HcHsJdWqQtVDLnLv5NUtgiC5K7Ixy
         JeZirUcg2XfyEb4Y1guf3kghFPcWMl4NuHm65ZP5QmRABBfrnk4Pz2IiIiKbAG6TCmTB
         yU7cuWZJs4SVqE4SXRoH7rjTm9FuLFUxVNRfd30mCly4tJVrC1CKHX/zc3GzuUUyk+U+
         cPbM5Ja3b6IB06mLvinB9io+TFf3ogCnIA8D3WcgkYoJ/LN6qdUMYiQvc+5yMQxByUYT
         KuChViU4ByDb+PoKoDSZI6VW+pQZSHslWqT/vUNR0HMgtzuYX/P6PGQ+vsiDTB/3IB3z
         KucA==
X-Gm-Message-State: AOJu0Yy7Rs317nv8mNXz1ZfnTzOEYzds+sOyIQnVmq9+oYyW+zjiTsP0
	hnkzcMVbymRrnxsa2CExfdH0+H+sTXv1CAKP7DT5w3cJZ1jlLJ1REsfHk7ud
X-Google-Smtp-Source: AGHT+IGH+jJmDb7UkuZ9FrLBi+0g+LV/hKI0b8vbNNA+TyEiQbXYlhBw6FjQBt2ciz2VnEwCIZHZMg==
X-Received: by 2002:a17:907:3d86:b0:a9f:508:5924 with SMTP id a640c23a62f3a-aa483525ef4mr1657315466b.43.1732030622791;
        Tue, 19 Nov 2024 07:37:02 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4e7bfsm661900566b.42.2024.11.19.07.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:37:02 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Nov 2024 16:36:44 +0100
Subject: [PATCH v2 05/10] midx-write: pass down repository to
 `write_midx_file[_only]`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-5-e2f607174efc@gmail.com>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, shejialuo@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5314; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=4FGXJhrae13n8KrE5hoTfISREt6HbuuOZXqk7YgyJhw=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnPLCYR3x4YxAGVA3+DgYVzCHFwMguEH7WjFaki
 ltB7Qd8XtOJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzywmAAKCRA+1Z8kjkaM
 f8B4C/4nSWbizeArB8p18kiXrJvf82TN2Zav50FNhMRqo3hc2OHDAuTxEDLnvMnShQhM/8TCOwH
 wKJmJyS30uE+ciBMOFtviAs7IHLYTby5T0CkGZc94tCQtoow1f44gxBaxILHwMvmySJNYVawQLi
 mhaOk4Bus2fE4w5+ixtkr4Jc9dhB0oFNS2oCNLP6Lj+gJhV1fGZ8/OEmTmQnMdmsoyP5SoIC5GX
 g7i5b6JqNcRyfCLNlyLcJaLaudPSEEZwu+ET23KDFYodGWtFqsaNpvqfv8POIxFo9aI/thkMilt
 0CaceHtqAtuHzr09GuTiofMov+wEItqba8MKejWjjAskJCq7TToQLga2A1ro0qJkKeA1nLCO8Sx
 GClGEPUq7xUY2BZaO6S4YSK5Mc5QTLg/lsVEkeLYR3k2sr0CQWM9YDxbzf7g9vIymzxi/03Qk4j
 wXrM3slgA6GzroOUL3Hd5wVc4J55ILtrR1qsOu2T6UWMEuAPUc48Kp5hpLkKRPdiXqmqY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In a previous commit, we passed the repository field to all
subcommands in the `builtin/` directory. Utilize this to pass the
repository field down to the `write_midx_file[_only]` functions to
remove the usage of `the_repository` global variables.

With this, all usage of global variables in `midx-write.c` is removed,
hence, remove the `USE_THE_REPOSITORY_VARIABLE` guard from the file.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/multi-pack-index.c |  6 +++---
 builtin/repack.c           |  2 +-
 midx-write.c               | 22 +++++++++-------------
 midx.h                     | 10 ++++------
 4 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 85e40a4b6d3e47e9ec1ec27c094455e5ba75b5b0..2a938466f53aaa11096170554fe11a4ed46a25e4 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -120,7 +120,7 @@ static void read_packs_from_stdin(struct string_list *to)
 
 static int cmd_multi_pack_index_write(int argc, const char **argv,
 				      const char *prefix,
-				      struct repository *repo UNUSED)
+				      struct repository *repo)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_write_options[] = {
@@ -165,7 +165,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 		read_packs_from_stdin(&packs);
 
-		ret = write_midx_file_only(opts.object_dir, &packs,
+		ret = write_midx_file_only(repo, opts.object_dir, &packs,
 					   opts.preferred_pack,
 					   opts.refs_snapshot, opts.flags);
 
@@ -176,7 +176,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 	}
 
-	ret = write_midx_file(opts.object_dir, opts.preferred_pack,
+	ret = write_midx_file(repo, opts.object_dir, opts.preferred_pack,
 			      opts.refs_snapshot, opts.flags);
 
 	free(opts.refs_snapshot);
diff --git a/builtin/repack.c b/builtin/repack.c
index 96a4fa234bddfd2b63c8d9733379d9b1012a4014..9c21fc482dfb387c818c0d0a74f781848b5a0953 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1569,7 +1569,7 @@ int cmd_repack(int argc,
 		unsigned flags = 0;
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
-		write_midx_file(repo_get_object_directory(the_repository),
+		write_midx_file(the_repository, repo_get_object_directory(the_repository),
 				NULL, NULL, flags);
 	}
 
diff --git a/midx-write.c b/midx-write.c
index 1c355cdf8db4e9fed61a4aabf61a237ad26181ce..1bc2f5256916e69924245951f654c1047ffeab84 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
@@ -1505,24 +1503,22 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	return result;
 }
 
-int write_midx_file(const char *object_dir,
+int write_midx_file(struct repository *r, const char *object_dir,
 		    const char *preferred_pack_name,
-		    const char *refs_snapshot,
-		    unsigned flags)
+		    const char *refs_snapshot, unsigned flags)
 {
-	return write_midx_internal(the_repository, object_dir, NULL, NULL,
-				   preferred_pack_name, refs_snapshot, flags);
+	return write_midx_internal(r, object_dir, NULL, NULL,
+				   preferred_pack_name, refs_snapshot,
+				   flags);
 }
 
-int write_midx_file_only(const char *object_dir,
+int write_midx_file_only(struct repository *r, const char *object_dir,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
-			 const char *refs_snapshot,
-			 unsigned flags)
+			 const char *refs_snapshot, unsigned flags)
 {
-	return write_midx_internal(the_repository, object_dir, packs_to_include,
-				   NULL, preferred_pack_name, refs_snapshot,
-				   flags);
+	return write_midx_internal(r, object_dir, packs_to_include, NULL,
+				   preferred_pack_name, refs_snapshot, flags);
 }
 
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
diff --git a/midx.h b/midx.h
index 3b0ac4d8788b373c59fe69ca2d78e9d914702bc0..c37ad5b5242b56d21fd76bd59957a1bdb82786ec 100644
--- a/midx.h
+++ b/midx.h
@@ -123,15 +123,13 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
  * Variant of write_midx_file which writes a MIDX containing only the packs
  * specified in packs_to_include.
  */
-int write_midx_file(const char *object_dir,
-		    const char *preferred_pack_name,
-		    const char *refs_snapshot,
+int write_midx_file(struct repository *r, const char *object_dir,
+		    const char *preferred_pack_name, const char *refs_snapshot,
 		    unsigned flags);
-int write_midx_file_only(const char *object_dir,
+int write_midx_file_only(struct repository *r, const char *object_dir,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
-			 const char *refs_snapshot,
-			 unsigned flags);
+			 const char *refs_snapshot, unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);

-- 
2.47.0

