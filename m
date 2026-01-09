Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102E3366559
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989128; cv=none; b=ASybXx5VjTP/7eKrwaPxV1G+8kBQoM5NtgTzyOHkk8x27HjLX9MI7qJpIk0yW+EQDv8OcxAwMM7SFdWTC2/w+hn2OjPnLoweUEmdauZavgxT5zF9grXZ+U32sMj4Q1B9c9mD6sJtDExoVrcvQGwuG3N5nPhiW+V9tE1A7sjrOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989128; c=relaxed/simple;
	bh=NmTss/FzLG7XJKShyw1sC73lrf1dHvdWKeKGHsfjcoE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oPbOAHBYkvLb3NsPP1KmgvcHO1LKkiOtZBb5+N7vMaObo4J0eGQw9169iksL2huHxKrR0Dafad2hjtlebAzYaje4uTSDOCmEMGvd0ozNLOlhY5Bb4ZQeqhPUWaEe3jRzETv7p/TmjD+1EKEyL/ao1YTptR0RAtmG/z4EKINXhnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU0g3do9; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU0g3do9"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ac3d5ab81bso3242000eec.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989124; x=1768593924; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EMyK60odYHGLkADniMqe7dI7qtrsT6YVFeAaVR4KS8=;
        b=kU0g3do9taIh33vBC7nID2FOKWSRtiw+Hpyy4P8mHT2dHniX4Ihsjv4hW1n9HE+r8A
         0vTrUeQYA/fjMOQbNZuiSFtfcVlXtPb0aZP5l07tZny3bgojdlsuHyK0aZ+UJlL3N4jZ
         D6V27augY/i/X74KFRm/ltdfVUpBeNodA2o3MljOa7HKC3iF6KRLYH9KxWCfEsZgaPUf
         gslo5n8XKv8TMtg+/+4I02sQWCMoe0RHajKpGiBWYRNFWT4cje5d4CqwQq73XYzSZ4iV
         qburpWvqbOXCplwqKT/NO7B6yKtJnXdZapQyfoD+aonKVQyF8KfKnmNdm1jwC9PoytLa
         pkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989124; x=1768593924;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8EMyK60odYHGLkADniMqe7dI7qtrsT6YVFeAaVR4KS8=;
        b=BZEidepMlVE4IeS7DR+0nXmYYKAcMrLkUqEWANGOTneX3OE/BDIaKSya+7SJHXJhVs
         1cjNDcD0gThX7YhVOW4g65P8Axn5ZEM2FUI++cTEDh5A37d4IEOxWJpzkY7gqQvWA/Ky
         KFfTAEL6NSTzU7hiaf9D5bBqmzBKsuW57MwOECobcPbtrSP9siAa7tWXQIcfFYdLVLll
         kzJ/oP2olfsdxUz+wu9rCD57ILo8CSxn6Gc/1jTGpvrrxMa+Xoavg/6c6Dr1/czmAYzW
         OxEGQgTASqE/ZmVNP9VB1n9uFTWMw25Hku1USTlPz0x3Co6M7zvpDY3uxcK+XH/NiPiu
         neEA==
X-Gm-Message-State: AOJu0YzlLiGJnlPpEaMlPcNqX/oBSArhIJXpcww//5/+LXcByuB5f1yI
	S5qugi/zqForG92fKrSai7lhQA8G+BrAmXSUJm6cZ7IimqpuXULfsa0v1xVyXA==
X-Gm-Gg: AY/fxX4KFi9WjagIXJPEw04Tv62uzYAGyuX7ZmSjcoHQN1BOZP4tWAAaXtp4f6WrEMU
	FVJSviw45CQJEkUh0YzZOaJFkIUZuonnTZ7tHEkk3dG6lbUVprZWAWBKBEu3IX+WQIbHek3ZgI0
	BEQM65Wju+SLepSg8C+48YJSW3OabUyFuLFkmsbdt92fKshWbByEjTA5HAaHfu8l567F7/6eAGb
	LZetfizERy08oZlW5AQitCQJ1P78R6b9IKuMbNAnoM27Eqi9YAScXOIzpZb46QQbR4TI2oMc7C6
	+Whcw+gsBW3svHYcX4PO1qBVAgT5z1jDTa5+3e8fbqbKB+fFfVri0kLUyX1XeGbhfofSQwiyzwr
	Ze85iKSBILQ4hElK2IAV3Obc3cTHLUZr0RxMuhiuOfCS3ZHfqWua6yUGtA2cFL2W7hR30BNW6dY
	dYTjElHeyNQvTDA3s=
X-Google-Smtp-Source: AGHT+IHuDpysxhVgRQMa6+1u/B0a33+6HPj5sKTZZOlJ+z6NS7BVShpCx0IjqiFjOe8pM7C/tWBoAQ==
X-Received: by 2002:a05:7300:d103:b0:2ae:6024:7a49 with SMTP id 5a478bee46e88-2b17d341f19mr5653241eec.30.1767989124330;
        Fri, 09 Jan 2026 12:05:24 -0800 (PST)
Received: from [127.0.0.1] ([172.184.211.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b16e4sm11526033eec.26.2026.01.09.12.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:23 -0800 (PST)
Message-Id: <9fee7bd16f52590c497124e81af495f76b162baf.1767989109.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
	<pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:06 +0000
Subject: [PATCH v2 2/5] init: do parse _all_ core.* settings early
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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

