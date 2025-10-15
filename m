Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0E30DEBF
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567285; cv=none; b=CmIAbI7HwugSbfy2byNM6rwsQJvUgGoytq05zc5A9PMOTYc2+H3+awt0qw5Pi+7566HMgaVC8r43ibtDYEy5utH4n7XQxoJ04WXUpDFq9unW9veuMbUCiduun2gbgIFDdR/Z2Pmetx8NxZn6ltXXyMdaMYSnihDVtbKYyUjfeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567285; c=relaxed/simple;
	bh=I/44uHjGjpx+4chVJJCLvNwAHYgYJcnY8w33IZabcl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6BBMGN5rXqV3pumsU1sP9fTd3uvhnFBSe5bnwkSyBUjBFeCtQ8BnLKl92T4+wCQfztx7JZhhir6m1urykHYTog6a1Lhxi5fadx/dLzqbYQZa3UXMZGK/HqzpsPI6yZuIssvBJ0OzlyxCGouuBQW4icvc1qiPpKau/ZTtZVFWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=U19zzyrG; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="U19zzyrG"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d5fb5e34cso922187b3.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567283; x=1761172083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4qPOvw6rx3HN/mTB+9cOzR9UlUefmfnoo8XwoSP+/Q=;
        b=U19zzyrGstIeFnAMOxD/S61EvU/K9OIajSfDDCvyTkwtcw454MDJjKaTM63MXLIF1h
         3moEUqG2ZCoH8o3bR/6nLhj/uqxl/JAMwXTGsVL3566r7nHDc9vkNpijx4iyRY7fnz1A
         QZxhsLoVJ+rJ7GM2kEJLt7hbvkWSZCqmCsu8vyBfI2/idERuIomnz0W5l+WEL07zr90n
         ok7bYk8ogDjelLu+7mv1G6KXGTSKJA+0BBlFVwtcbvU6stc43elQlH2FJYVZ6uzKQSQq
         SZm298e4wD2GWla1jAmVF5ASvRum6rIW0Ak74QH5PEYeD2KHQZwugUz6Aere5zrU87JS
         rHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567283; x=1761172083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4qPOvw6rx3HN/mTB+9cOzR9UlUefmfnoo8XwoSP+/Q=;
        b=IfEAmww30r0sHAe4EF+mcmNdzoZ1Kojo5PGeuEq5dksDLoUE0HW2YxLkQEcsIKmjO4
         7PMaJrYzRHW6lh+2rxQyVCN/bf5tkSrXHG3OcK4/taR254JQqpTNbXOj7byRBQXOJz46
         ZpPlW8MuIHWus/uaNYt1Dx/6x+7A0gWCIJKQqOXvknrBQpwu4I6gA5GFn4tJBXP6B0tl
         O592uCWKc6UiTk6pNbXtYo4TSRhtTgAOwi+zM+zTeVxmBq/UggQv18ITpFlQNf6NCHE1
         dJ1jHjHu6jzU1HCSDSd/6lajkRirO7zeU+ZccuP6IWbv9uXK0LFq6vwFvsBmCsZrO95E
         Eovw==
X-Gm-Message-State: AOJu0YyWCmbxt0jwvKWKO1JEnbLwdTyR1J10caOeXsDSCvIwbNmKy8bm
	72j8VH5Ca+PW3PseMkGedsim6eePA0OKGx02NQhbfWhr0ZKbZ32DQBB05CAVaU/tEyHVJsn4rnX
	SG9LOKZE8Wg==
X-Gm-Gg: ASbGncsI4xYqNT9qKVWlt1v0Q0TVHQ5gbFIfD7HXCuHAdkuWKzQsT09PuuCYnRsu7hx
	XZE7cZWvQWNztWincKHjXglUYiKjcVEtI3kveVnBXHAECDQ59epVTXfEaxOOtcqGAlslaRpJs+D
	IoBlpSvCdtSOjliOrbTFI/m/Gcu/z4FX+3LbdnLszl2fQt9O26OWDGFeQsEd6ULWzkf0QvU4RcP
	qCx3Rr9kXOSjDjcvRBA6rz+5QcFjOzzBwisOzwl76KO8MeU46sP7SWM63DD85odygNlxb7Vbrt+
	h2CnV96fKY1w/89/DRKiY2NOxPdRNoj/RLDLr6YAFW1mMWIZJN49E9qiaIUKH2CdNN/j7odrBqF
	fioVLXQQ5ekMxDk9k5W58HqsgGr8P9N9SX+TNamx5TsAV8AeUnGBGpAIc50qwKRkAxM8h112rZX
	eGnLSyG9Jl/n5H6QAMnePcF+/tBLYeMhzNEWLjypa4E0dizz28YCZK2P8qmjUHJyAgnyzlX4iDG
	zrpu4c=
X-Google-Smtp-Source: AGHT+IF/E0WeoP45quXmD5gwuCa0zzhLD+p1jjaVJJqMZj8BQNDwIYpF3t6P3ME+su5nYOna88n3+g==
X-Received: by 2002:a05:690c:6809:b0:720:5e0:310c with SMTP id 00721157ae682-782a90b33c2mr8091647b3.9.1760567282951;
        Wed, 15 Oct 2025 15:28:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828d7bcf58sm2748567b3.28.2025.10.15.15.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:02 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 14/49] repack: remove 'prepare_pack_objects' from the
 builtin
Message-ID: <0c32c3c9b6af2e4c5ab3e506a192a9c487d114fb.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

Now that the 'prepare_pack_objects' function no longer refers to
external, static variables, move it out to repack.h as generic
functionality.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 34 ----------------------------------
 repack.c         | 35 +++++++++++++++++++++++++++++++++++
 repack.h         |  5 +++++
 3 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index f4af830353..ff93654cfe 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -288,40 +288,6 @@ static void collect_pack_filenames(struct existing_packs *existing,
 	strbuf_release(&buf);
 }
 
-static void prepare_pack_objects(struct child_process *cmd,
-				 const struct pack_objects_args *args,
-				 const char *out)
-{
-	strvec_push(&cmd->args, "pack-objects");
-	if (args->window)
-		strvec_pushf(&cmd->args, "--window=%s", args->window);
-	if (args->window_memory)
-		strvec_pushf(&cmd->args, "--window-memory=%s", args->window_memory);
-	if (args->depth)
-		strvec_pushf(&cmd->args, "--depth=%s", args->depth);
-	if (args->threads)
-		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
-	if (args->max_pack_size)
-		strvec_pushf(&cmd->args, "--max-pack-size=%lu", args->max_pack_size);
-	if (args->no_reuse_delta)
-		strvec_pushf(&cmd->args, "--no-reuse-delta");
-	if (args->no_reuse_object)
-		strvec_pushf(&cmd->args, "--no-reuse-object");
-	if (args->name_hash_version)
-		strvec_pushf(&cmd->args, "--name-hash-version=%d", args->name_hash_version);
-	if (args->path_walk)
-		strvec_pushf(&cmd->args, "--path-walk");
-	if (args->local)
-		strvec_push(&cmd->args,  "--local");
-	if (args->quiet)
-		strvec_push(&cmd->args,  "--quiet");
-	if (args->delta_base_offset)
-		strvec_push(&cmd->args,  "--delta-base-offset");
-	strvec_push(&cmd->args, out);
-	cmd->git_cmd = 1;
-	cmd->out = -1;
-}
-
 struct write_oid_context {
 	struct child_process *cmd;
 	const struct git_hash_algo *algop;
diff --git a/repack.c b/repack.c
index a1f5b796fb..91b6e1cc09 100644
--- a/repack.c
+++ b/repack.c
@@ -1,5 +1,40 @@
 #include "git-compat-util.h"
 #include "repack.h"
+#include "run-command.h"
+
+void prepare_pack_objects(struct child_process *cmd,
+			  const struct pack_objects_args *args,
+			  const char *out)
+{
+	strvec_push(&cmd->args, "pack-objects");
+	if (args->window)
+		strvec_pushf(&cmd->args, "--window=%s", args->window);
+	if (args->window_memory)
+		strvec_pushf(&cmd->args, "--window-memory=%s", args->window_memory);
+	if (args->depth)
+		strvec_pushf(&cmd->args, "--depth=%s", args->depth);
+	if (args->threads)
+		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
+	if (args->max_pack_size)
+		strvec_pushf(&cmd->args, "--max-pack-size=%lu", args->max_pack_size);
+	if (args->no_reuse_delta)
+		strvec_pushf(&cmd->args, "--no-reuse-delta");
+	if (args->no_reuse_object)
+		strvec_pushf(&cmd->args, "--no-reuse-object");
+	if (args->name_hash_version)
+		strvec_pushf(&cmd->args, "--name-hash-version=%d", args->name_hash_version);
+	if (args->path_walk)
+		strvec_pushf(&cmd->args, "--path-walk");
+	if (args->local)
+		strvec_push(&cmd->args,  "--local");
+	if (args->quiet)
+		strvec_push(&cmd->args,  "--quiet");
+	if (args->delta_base_offset)
+		strvec_push(&cmd->args,  "--delta-base-offset");
+	strvec_push(&cmd->args, out);
+	cmd->git_cmd = 1;
+	cmd->out = -1;
+}
 
 void pack_objects_args_release(struct pack_objects_args *args)
 {
diff --git a/repack.h b/repack.h
index 12632d7fec..3f7ec20735 100644
--- a/repack.h
+++ b/repack.h
@@ -21,6 +21,11 @@ struct pack_objects_args {
 
 #define PACK_OBJECTS_ARGS_INIT { .delta_base_offset = 1 }
 
+struct child_process;
+
+void prepare_pack_objects(struct child_process *cmd,
+			  const struct pack_objects_args *args,
+			  const char *out);
 void pack_objects_args_release(struct pack_objects_args *args);
 
 #endif /* REPACK_H */
-- 
2.51.0.540.ga7423965ad8

