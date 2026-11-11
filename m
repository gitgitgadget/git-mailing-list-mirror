Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385540;
	b=pqmQ5BPjL4xyfDzow5R5HzMn5n+4ZO7NEDZHuBhCg0J5gEclnKZOigWxjg1eWtjjuYVD
	 9/4Ju1LXc1WF955pFv7Shj0qvBK2ljAm5VV6Weq/qcwpXr7xG3ngU9cRf7EShgnnlArhk
	 haeooAZ6TjekKlqr6dmhljy/BkJZbNubxA1zMklY2RNY2HwSptYscf/WOiVhBT1m7yTXk
	 5+zVx5xxry7rsJkpLApHJYkHFWxkvAypyl6961YTftKaGb35V4+JL/Aw0xhyVdO5sQiii
	 RpgWAjMhj4xp75ieRuaQ/Vo+/sjr4fy7ZJOLLWoxirjYBaL1bBprJ61nodfNmd4e4AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=UnuhPlSBvdlc7ZNcT3lGDDyuIAzqJtSwO1YIGCcilPU=;
	b=LqFs9hWq/c4cKXdlXJem1l6yWS5/dQyeSMHmM0iB0pHcNd10dTAzMq7zgJjBqPNyOqSN
	 lglU0bemL5pgNnGaJEMerKYAxW0RTa0DYZYM8isTCuqg8HhO61/rr2arqG1J6urIfblzX
	 23U4yEwkXS+KuQs142nxJmef+U3RNbd7vGDCP0T0L35UsYnGcY1HhsJYkKKQVkqtQMtvq
	 bsTmirw7viXu3jCRe+zYm08xAECNn3gckXq5TqoxIqTfZqKXwEcf5iKCb7/MtFaBWIieV
	 bG3MSMJW0vMIbs6llvPvCXy6ekduSd64ia+27iU2AgTUxNM4bEQWSFbWz56f8QpK3IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NLYfJGyF;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2F606A320
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D2F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NLYfJGyF
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91eed03da8bso27331336d6.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 00:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794385539; x=1794990339; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UnuhPlSBvdlc7ZNcT3lGDDyuIAzqJtSwO1YIGCcilPU=;
        b=NLYfJGyFCLBfSX/7OpPYz2G9DQbfpccw8emHLysuTV2i1ON+lD9J68P/pX5wYDRZ1c
         cdPd4Nha9aUQokCy6ELh+4NZGy5O8pzeaTHJiCSfZWFn+jkaONXERLpp1wsoQV2PSNeb
         v7LqpXi34JycBFxrl+ZP/M9Oz5EoOtqlIbYxE4qcKxDt0CYc5h+buWKhDYQOgRIyIZTY
         6CKveZ4rXkpE6m02xB7gqYH2q4NoBsygLZmo3f9iReX4QrL8uDYJuQeO927Sc69OTqa2
         Eh8A1JEh+N7oCeZ69YKcL/jJVE6hFjb5aOBM24lAWh+pA5engT56emIhhm0Ts+hhsFn+
         vopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794385539; x=1794990339;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnuhPlSBvdlc7ZNcT3lGDDyuIAzqJtSwO1YIGCcilPU=;
        b=zjYKO5X9N18iQn+hlMwHY3H1Iz9GAIrOarE6/CQSZQVeDAca0fkghGHWeZjoHyrHTO
         euEZ2ZlsD8U8OcIvpxgkcU9XLI/PyxxibeaeIMcmcg0b7b7y4RfCbP6el7ZmFDhre9Sq
         bhqpgOgDwqZOmrhNiY5LJIj3m/O6UhU2gTOQqrGL0vzrU70G+PVE9xLyYkyrbZcS4aQ/
         +TV17P/RkDdQZHhGPWrDIBPVpMa2hPj6PFggSrM5LR0CHAMY60FhGor1N0Qd2IJ/TF+x
         n2nkV/KfNpOgnkMKfLQ8lIOrRoVSOvHfequtkqRofggD0cXlHLyfhm63phRsgWw1iO2V
         3Zgw==
X-Gm-Message-State: APuU4Z+BFOCbj5Omv1QndoM1V4mdUVWuu7IuwgQlvrhAWg2mpol5e0x0
	M/vo96bUcXYGyJkC/TWH+wOoHFa/8qtDV+95/uk6qfkT8UcAWNXXhqOJOO5oTw==
X-Gm-Gg: AYBFou0njnCLMDGEDBADLzn9gVRV9pZM3R/jkqyg5NjWlsSRGZXFC1h3tbtQUT4po73
	t62+WU8vjepQCQMNXOxcX8rAzARbzvhtIjDL+eN3V31XkUln9SlI1jYoT0whJAKnG9rngu4DA43
	XY04eG8Z1zFU7evWyNh4ZvxX3N4iseNXBl+1/oVocC8+zLLfPZph9yovc0NRRlwnZmLdPh+QbQ6
	R01M41nSLFEKR5OPs23tY8qOgM40oDudG3K4LuEOwereWD2s7NK29dCTw2dnSLUJYSeOEWadhhs
	jxZnx7im+zaIrcIjfyfPlV4k7iZC2zkDO4M+zrxVjId7fMJx988IJeOxo9h7e8I/5qXv//HxdeQ
	JpJORsTDr2hGwrJqKh8Ia+c77bZGcAku7jz2b5GB02l9e2Y9tTmNYDGZiumjb0ZAXhQpDW7Q2KD
	E50b8JTq0AhsAGrQ0fAszHT4E1n/uq5R4SLJeDZw36fzK2Lxm7HTgyNgHYXYe1/KV72zss43cs3
	wckuaNP4aaFLvpXy4fWoWEEE40ymbNHOe+x8X2TWCdHH1oBFJliWWMvoygCof44DZ6uP1NugCtM
	F88cF8saXAp4cBwSqqpweaASB9PmzWto/Q==
X-Received: by 2002:a05:620a:2796:b0:93c:a40d:e3cf with SMTP id af79cd13be357-947afcd6115mr261301085a.1.1794385538939;
        Wed, 11 Nov 2026 00:25:38 -0800 (PST)
Received: from [127.0.0.1] ([52.186.174.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7d6964sm434184385a.34.2026.11.11.00.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:25:38 -0800 (PST)
Message-Id: <pull.2305.v4.git.1794385537870.gitgitgadget@gmail.com>
In-Reply-To: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 08:25:37 +0000
Subject: [PATCH v4] archive: remove USE_THE_REPOSITORY_VARIABLE from archival
 modules
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

Refactor archive-tar.c and builtin/archive.c to clean up archiver
initialization order and header dependencies.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] archive: remove USE_THE_REPOSITORY_VARIABLE from
    archival modules
    
    Refactored archive-tar.c, archive-zip.c, archive.c, and supporting files
    to use explicit struct repository *repo pointers instead of global
    repository variables.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2305%2Fpoojarysrujith%2Farchive-libification-refactor-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2305/poojarysrujith/archive-libification-refactor-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2305

Range-diff vs v3:

 1:  01c3cc2573 < -:  ---------- submodule: use the submodule repository to abbreviate commits
 2:  398b54f00a ! 1:  29130b6eb2 archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules
     @@ Metadata
       ## Commit message ##
          archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules
      
     -    Refactor archive-tar.c, archive-zip.c, archive.c, and supporting files
     -    to clean up archiver initialization functions and header dependencies.
     +    Refactor archive-tar.c and builtin/archive.c to clean up archiver
     +    initialization order and header dependencies.
      
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      
       ## archive-tar.c ##
     -@@
     -  */
     - 
     - #define USE_THE_REPOSITORY_VARIABLE
     --
     - #include "git-compat-util.h"
     - #include "config.h"
     - #include "gettext.h"
     -@@ archive-tar.c: static void write_global_extended_header(struct archiver_args *args)
     - 	if (oid)
     - 		strbuf_append_ext_header(&ext_header, "comment",
     - 					 oid_to_hex(oid),
     --					 the_hash_algo->hexsz);
     -+					 args->repo->hash_algo->hexsz);
     - 	if (args->time > USTAR_MAX_MTIME) {
     - 		strbuf_append_ext_header_uint(&ext_header, "mtime",
     - 					      args->time);
     -@@ archive-tar.c: static struct archiver tar_archiver = {
     - void init_tar_archiver(void)
     - {
     +@@ archive-tar.c: void init_tar_archiver(void)
       	int i;
     -+	repo_config(the_repository, git_tar_config, NULL);
       	register_archiver(&tar_archiver);
       
     ++	/* Set built-in defaults first so user config can override them */
       	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
       	tar_filter_config("tar.tgz.remote", "true", NULL);
       	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
       	tar_filter_config("tar.tar.gz.remote", "true", NULL);
     --	repo_config(the_repository, git_tar_config, NULL);
     ++
     ++	/* Load repository config so user settings override the defaults above */
     + 	repo_config(the_repository, git_tar_config, NULL);
     ++
       	for (i = 0; i < nr_tar_filters; i++) {
       		/* omit any filters that never had a command configured */
       		if (tar_filters[i]->filter_command)
     -
     - ## builtin/archive.c ##
     -@@
     -  * Copyright (c) 2006 Franck Bui-Huu
     -  * Copyright (c) 2006 Rene Scharfe
     -  */
     -+#define USE_THE_REPOSITORY_VARIABLE
     - #include "builtin.h"
     - #include "archive.h"
     - #include "gettext.h"


 archive-tar.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/archive-tar.c b/archive-tar.c
index a1c66024d4..1b376d048a 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -531,11 +531,15 @@ void init_tar_archiver(void)
 	int i;
 	register_archiver(&tar_archiver);
 
+	/* Set built-in defaults first so user config can override them */
 	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tgz.remote", "true", NULL);
 	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tar.gz.remote", "true", NULL);
+
+	/* Load repository config so user settings override the defaults above */
 	repo_config(the_repository, git_tar_config, NULL);
+
 	for (i = 0; i < nr_tar_filters; i++) {
 		/* omit any filters that never had a command configured */
 		if (tar_filters[i]->filter_command)

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
