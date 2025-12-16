Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF70339868
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899237; cv=none; b=gEL9Yj/iXcMqJmdLgoujUp4MScd4Ph0S9TLXNfygT+GWhCry0GHxcVoH/qfgKY7Er5EN4dmK47oP6KnJ4mX18HEhgChQqDXwE2e2zx+UlXWax4fTgRvS2eASwOCe4gtCfsqQlZ5IOcKAR+jclcd7Bba/moriiUJ1tkjW2VC3IdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899237; c=relaxed/simple;
	bh=NmTss/FzLG7XJKShyw1sC73lrf1dHvdWKeKGHsfjcoE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oJwIlxn4FKnZAzfO/N+O4TdkUbjdJQEw7DhQVnfZwxzLKUWkp+WYBcyaoihJwdxB+mlS27RmP7SDn8h2yNAzHwCdAt7k7/NlBjZkVByrHhG35EwpxS0hQb/E1Qe78jpe5n6S4zQJDsDh/wKAAgWdSPotBD8dT+BgOLZaIMP7PMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKmAAjOU; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKmAAjOU"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-889a865bc1dso29233796d6.0
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 07:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765899234; x=1766504034; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EMyK60odYHGLkADniMqe7dI7qtrsT6YVFeAaVR4KS8=;
        b=hKmAAjOUDpFq6P+7S3SH1esx5ZqfC7IRCq6hMY213o4yu35N3HyIGX5K2JRF4mlp8J
         KI3bgoCx4eVaa16BLAPpFnc5AalNjYdJo0nyVqPAiaaQ9DtRTotRmGfpJligvMzq1fTN
         4piovPBUYZa2skd5qe/9wu5OFTrhI8cKSkSofng5k2lSw+KLKajuUgBi0RuYCkkzWqde
         H1lryk98tdYSMP4nhs+YHhkdxxCKBDu+300c6Blih4ZiR5zo872wX/o5/nsTh3cih0TC
         KCYqdXTmLAyQrwqIK/MaSg6vv9JjuLekxBo5q/dyWtlKPS2Bo0PhrGMedpUGfRWJOHaM
         czQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765899234; x=1766504034;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8EMyK60odYHGLkADniMqe7dI7qtrsT6YVFeAaVR4KS8=;
        b=ApKK4/6528jPHvx4lwH2470U2DK7N5jQwtHz8EiDlxhmua4Pormw3XKHF9MPR50L+5
         2KvrA1AyRbUUm8iBVghdSmJs9TFodJnX3sqVsblkixA+rWvsPXZK+XwI6pMbqCLKgiMA
         0z4uA5d4rtd7hygglm6pGwx58yz6tSlmOKMD6ELAdCxhmng8G7wDUoK7YoaDnw+mrVad
         IQkUA7rbDKJMNkIqVMq3HEHLj9bdJOSMRbLl3XTPUzRgLHKFsivusIy1o/F9gBCh/RNU
         6BfK5CIFYFkO+adXEETeT94sRLB3DKF1jGJmkoRNnNEvzKteJSGyUnpfrdBPdByN0ewo
         fBVA==
X-Gm-Message-State: AOJu0Yw/wlK6acmWq5AZo7tJpBa2KX8HZbLCaWipYdxUQVYw+uii267t
	XpwnNGi2pM7IMrb9t20PbGhP5m6UH8vRJyWkU94N4wdE3neWupUl9oUzcjWmtQ==
X-Gm-Gg: AY/fxX6QoPU30Cdd4S+CNHEEpG4/gMKxNeQ/pN6DrN2mMd8yVYSr6c5Jrk6tPhYAYpI
	Z/VlpfybiiE52OnLuLb09phRHQgkR5+m39uU98uKn6qeNFOgQvp47QO59AfV/hmwRHTyWTCZZhu
	8Z9ZjTk8zk/2Ih4yG6/C8F8Rq3RBwlQTVAdkeYQXE06GZdNkU93X2Cc3iaAKeYPrGxdyFaGTKPJ
	6Mvs3pUjyV3VxwitzWxWvl4TsqLWZFmy8JMqtlCFRO2X1py17rukQue+DlKbuJB0NutiM3KTqqk
	ZFwreOKKrpLKV6qSFv9oz+tBm08cfvIVh+71c7Y+mGZfcE08obFcN29EpJ3uuTthDeelGSjtW9J
	TaNWUqFbucibAHnrVBDuHRHKgfRQIqhiIrD4PZCvWuP0vTkJd6IN6KWhS6wwq8xBLjr89XWkb64
	cnwOglY/fK2g==
X-Google-Smtp-Source: AGHT+IFS29Zwy2AZGF/aQSje9lTDUe9HqnD/I4rGTh6RnPmc56Ou62PHiIbh73yqVLT6WfRPKUXYWQ==
X-Received: by 2002:a0c:eac5:0:b0:88a:2c78:d625 with SMTP id 6a1803df08f44-88a2c78d6camr102341766d6.48.1765899233490;
        Tue, 16 Dec 2025 07:33:53 -0800 (PST)
Received: from [127.0.0.1] ([4.246.135.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b44441sm75315456d6.8.2025.12.16.07.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:33:52 -0800 (PST)
Message-Id: <31497b019886698aacebbbc6a464a7c0124f31c4.1765899229.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 15:33:46 +0000
Subject: [PATCH 2/5] init: do parse _all_ core.* settings early
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In Git for Windows, `has_symlinks` is set to 0 by default. Therefore, we
need to parse the config setting `core.symlinks` to know if it has been
set to `true`. In `git init`, we must do that before copying the
templates because they might contain symbolic links.

Even if the support for symbolic links on Windows has not made it to
upstream Git yet, we really should make sure that all the `core.*`
settings are parsed before proceeding, as they might very well change
the behavior of `git init` in a way the user intended.

This fixes https://github.com/git-for-windows/git/issues/3414

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 environment.c | 4 ++--
 environment.h | 2 ++
 setup.c       | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/environment.c b/environment.c
index a770b5921d..b65b85a01f 100644
--- a/environment.c
+++ b/environment.c
@@ -324,8 +324,8 @@ next_name:
 	return (current & ~negative) | positive;
 }
 
-static int git_default_core_config(const char *var, const char *value,
-				   const struct config_context *ctx, void *cb)
+int git_default_core_config(const char *var, const char *value,
+			    const struct config_context *ctx, void *cb)
 {
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
diff --git a/environment.h b/environment.h
index 51898c99cd..e61f843fdb 100644
--- a/environment.h
+++ b/environment.h
@@ -106,6 +106,8 @@ const char *strip_namespace(const char *namespaced_ref);
 
 int git_default_config(const char *, const char *,
 		       const struct config_context *, void *);
+int git_default_core_config(const char *var, const char *value,
+			    const struct config_context *ctx, void *cb);
 
 /*
  * TODO: All the below state either explicitly or implicitly relies on
diff --git a/setup.c b/setup.c
index 7086741e6c..42e4e7a690 100644
--- a/setup.c
+++ b/setup.c
@@ -2611,7 +2611,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * have set up the repository format such that we can evaluate
 	 * includeIf conditions correctly in the case of re-initialization.
 	 */
-	repo_config(the_repository, platform_core_config, NULL);
+	repo_config(the_repository, git_default_core_config, NULL);
 
 	safe_create_dir(the_repository, git_dir, 0);
 
-- 
gitgitgadget

