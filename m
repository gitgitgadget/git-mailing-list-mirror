Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C61362
	for <git@vger.kernel.org>; Thu, 29 May 2025 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748546462; cv=none; b=fWlwPWn6IfBekEZ53T/UUymqN//LrrVPNx4EzHIc89FLDigcgysc4cNOMDcLM1VukUCpzEvT2JC1KAtFSnLw4XKoy/4XPaTzBtKmjJL1IjN7xCwN8Yrz51+nr0bwDpT9dQ4gE+gPLa01a5GIAPPSQ+o+CDb/DuJi6yqw+xDA8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748546462; c=relaxed/simple;
	bh=UdSTjfOLMmnf05qlH4g59RkSYkM4+riML8n7tMfOWDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zd/IwoybqmZ+D2Hl2ZqfHWFeJcdSQhU99oTNn6cM4iUTCogD2x0lNNVlQUvvaYkT+Fir/hUXeWx18dLh/iSwcXHFjNYyqb8o6CR8lLXz4IA2s3/00Q02YCtt2dTOZOGEB1/SMCGRF4bxs0yd0DGgRFyp2nIrf7qSUy+F5umc6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlvXDUpl; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlvXDUpl"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-52eec011ff2so388366e0c.1
        for <git@vger.kernel.org>; Thu, 29 May 2025 12:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748546459; x=1749151259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OtDDLdBxGTdPfGNCeWSLJkNucsUJM8O/Kg5CSGSfls=;
        b=YlvXDUpltrtGOLfI4lTpY/7V0xlxBAZg8eQZq4J8PEui/nmScuNOCKvdFt5i4rPbHR
         obxVIWJrosdQKN4HNQu3zmxWxvwgl+XdstGYAomd3fj2o6S8zPWLh14SL4mP6mNnxjzb
         +MX3mMx9rBI6N3343ssRu8BMn8pWUejGBX2vgcY8IG8UtHlNVNhhy0rT3utBrAeVP2zq
         yu8CnE0rpDbWCBE7L58vNPb28bv4B4HrF51106Ao6b/BFnRi7p34WNzmvZ6zK944xEMS
         oar8gNiHfK6yzUk+WjnBgzK0dg/zcNMx6h5RAZ9tJulx12Uia2c1ON/EozaLJ7DEMMHF
         ooXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748546459; x=1749151259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OtDDLdBxGTdPfGNCeWSLJkNucsUJM8O/Kg5CSGSfls=;
        b=sTO6MV5xvHsoVquwwbwaeNbxOKLJ+MK3jkSwrhEdVsIVdVsAE5I44YPCQ0fu9v+UkZ
         IklV5YfffutaERc+PdbeotmzC0dGv00Sb/OrBsezKuf3BNxPd3W07xWHSBR/QPKzfeOT
         Hy9+8RUdm67d0QBtp44dYtgtMwwh24nPKpk/6Ti3AZRB/1Rg2BiR41I4ZdX3vNSv8VDr
         BS6lWpDSaBpKfuXO1jGgyC8oA5HSSQmHfkXdj1Y9n+gZrVIidoWbKx1TFgptOLDANmbj
         iteZTjByCIH87M4tU2403PtAz5q5BhIlw6LMUw1Jd6/jcFbrM+ER3WoSvIhWQ4P2XnWC
         ktxQ==
X-Gm-Message-State: AOJu0YwwSbxIJ0yyfka3z9YvEdI5rcEad2cvUGP2kq5mESdkvA35fGE9
	dr9gDTgBM11LZf0OPQqgSsvtTns1xWB4PP/lSFoyd961rHMkU+EuKIGyLZfmF1+A
X-Gm-Gg: ASbGncszvblHq/wKFVSnlGcyI/nyDKhjiqxGUmDJk1W3DSHa1gyUvicqCCulASuattg
	7RG8YhXGXxB9wNpmaKOExrYaakcvlNloaJg9Uzlyf2kTH8pgaOdkd9LmtZmVUEwJRVnFttCcZ37
	g/V06IoTI7LPj3EJNLpXk27smLDfmYpuR3XTAEc59JKgazK4Cm8cjAzCQjQZIlGUUxHlhDMMhnN
	kjrMIIT9muIuENIkD+wbm9jbyVvq/xFVMjjvjGAQNGT2BaYRCFtC+v2h55/lUEjWqfM+Mh5N4wY
	tUWqzBQIVlT8XA3MDCFdN2h6WexzB8VGBDMMTpr44fxZuIPUFZDg4JT6fXEQDbxAt1FYpbZnn//
	nIPLEIA==
X-Google-Smtp-Source: AGHT+IE5q8m+JYSv+QnvohuQwFBICXmOSUg3gD89O3MZsWN5HxST7BX4Cut2PWsU1S3s1+bVksxgyA==
X-Received: by 2002:a05:6122:1d94:b0:530:5f5a:1362 with SMTP id 71dfb90a1353d-53081101b63mr741452e0c.10.1748546458935;
        Thu, 29 May 2025 12:20:58 -0700 (PDT)
Received: from localhost.localdomain ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074ad9dc8sm1754464e0c.20.2025.05.29.12.20.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 May 2025 12:20:58 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH 1/2] MyFirstContribution: use struct repository in examples
Date: Thu, 29 May 2025 16:20:35 -0300
Message-Id: <20250529192036.75408-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250529192036.75408-1-lucasseikioshiro@gmail.com>
References: <20250529192036.75408-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the parameter `struct repository *repo` to the cmd_walken function.

Since commit 9b1cb50, all the cmd_* have the `repo` parameter and new
commands must follow this convention, so the documentation should also
be changed.

Also change the `git_config` calls to `repo_config`, also passing the
`repo` parameter.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/MyFirstObjectWalk.adoc | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
index f03753dfc0..29d26abb47 100644
--- a/Documentation/MyFirstObjectWalk.adoc
+++ b/Documentation/MyFirstObjectWalk.adoc
@@ -43,7 +43,7 @@ Open up a new file `builtin/walken.c` and set up the command handler:
 #include "builtin.h"
 #include "trace.h"
 
-int cmd_walken(int argc, const char **argv, const char *prefix)
+int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
 {
 	trace_printf(_("cmd_walken incoming...\n"));
 	return 0;
@@ -86,7 +86,7 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 Also add the relevant line in `builtin.h` near `cmd_version()`:
 
 ----
-int cmd_walken(int argc, const char **argv, const char *prefix);
+int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo);
 ----
 
 Include the command in `git.c` in `commands[]` near the entry for `version`,
@@ -193,7 +193,7 @@ initialization functions.
 
 Next, we should have a look at any relevant configuration settings (i.e.,
 settings readable and settable from `git config`). This is done by providing a
-callback to `git_config()`; within that callback, you can also invoke methods
+callback to `repo_config()`; within that callback, you can also invoke methods
 from other components you may need that need to intercept these options. Your
 callback will be invoked once per each configuration value which Git knows about
 (global, local, worktree, etc.).
@@ -221,14 +221,14 @@ static int git_walken_config(const char *var, const char *value,
 }
 ----
 
-Make sure to invoke `git_config()` with it in your `cmd_walken()`:
+Make sure to invoke `repo_config()` with it in your `cmd_walken()`:
 
 ----
-int cmd_walken(int argc, const char **argv, const char *prefix)
+int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
 {
 	...
 
-	git_config(git_walken_config, NULL);
+	repo_config(repo, git_walken_config, NULL);
 
 	...
 }
@@ -250,14 +250,14 @@ We'll also need to include the `revision.h` header:
 
 ...
 
-int cmd_walken(int argc, const char **argv, const char *prefix)
+int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
 {
 	/* This can go wherever you like in your declarations.*/
 	struct rev_info rev;
 	...
 
 	/* This should go after the git_config() call. */
-	repo_init_revisions(the_repository, &rev, prefix);
+	repo_init_revisions(repo, the_repository, &rev, prefix);
 
 	...
 }
@@ -305,7 +305,7 @@ Then let's invoke `final_rev_info_setup()` after the call to
 `repo_init_revisions()`:
 
 ----
-int cmd_walken(int argc, const char **argv, const char *prefix)
+int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
 {
 	...
 
-- 
2.39.5 (Apple Git-154)

