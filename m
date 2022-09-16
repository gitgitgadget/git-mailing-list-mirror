Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD36CECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 17:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIPR3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 13:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPR3u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 13:29:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658D823BF8
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 10:29:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq9so37084731wrb.4
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=DikD6ezfSHlPHNEyNPxVzvSnmHsV3Q1+7SY9VfCR8nA=;
        b=BpidXqSL7iIlIbUDzM/beM66/nL6XmXecShK+ID7vHYBdmCiNcY2mVtwIFygOX6qtd
         p0DkkiiE9W06eIMdHpqJx/scO0209KYmRs440oiWVR2D5q404V/0RCK3u8NtIxvc2GG6
         FdwCtCecc613R9M9tF3sLRJGOtaud2Bcv25uCDOF0mDWUxtl6n6uXX+lJIaw9Lh0/yDz
         V2SCbwPBiyeqzuBWWfFL2UIYNrCGjoYE2pr0lNLl8lAkY9Po0gawJRkSBFsNci1KFl9+
         851ZNdploWaOo1AHQjrsSqtjfB9UCZDcH4yprQdsHsOVrhRFfOyPNASzgcNBvrtbPVtC
         HsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DikD6ezfSHlPHNEyNPxVzvSnmHsV3Q1+7SY9VfCR8nA=;
        b=hSlWvnRS6YZMCrDDfqmF9SbQgAU1ZY5rt1fS128QPkm0e0cGAKEsA0+/N4ZLUwsxNh
         TrZzdMrXYmyn4Gy1x0aHmvMD5NlcMTUfAqyvsdWKfeNAEXAIHgRGlyOhUgu2XkDa4GO6
         2CnooJUcjLey2VDKCgx+cT8qkVeAw0w7tLvCXT6gP3oPOI4pbLz/pDFJlSlBo1IiuZUb
         oMxX1k3aBtNUYlQOx5pGAL433/pLmuFHHpfRZO9raPlYDFccI/WBiFr5Qkwpy48uyXmK
         eiCHS0QDJszMvRd2q4D7+X7Xb7QnVcl8+IxP+70u21raU+ZXVr2mAKCF5lKTXOjpttFR
         1b/A==
X-Gm-Message-State: ACrzQf0OH/x5xprKWGves7HNpxRZ9GFEIfU9iYMw3JMkWYK31d87e8LZ
        p/MidgYI/Py7aSplDzxG4kIrLd7yZyw=
X-Google-Smtp-Source: AMsMyM4u27GR3D5XB72KmDUqes46tzuw25tJ8H5j+WfQAqTMViaBSEcWEZbqV332IL0RMDiZNd1pKg==
X-Received: by 2002:adf:aacf:0:b0:22a:4edf:c276 with SMTP id i15-20020adfaacf000000b0022a4edfc276mr3755146wrc.38.1663349385468;
        Fri, 16 Sep 2022 10:29:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y9-20020a05600c20c900b003a541d893desm2626680wmm.38.2022.09.16.10.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 10:29:44 -0700 (PDT)
Message-Id: <pull.1351.v2.git.1663349383852.gitgitgadget@gmail.com>
In-Reply-To: <pull.1351.git.1663078962231.gitgitgadget@gmail.com>
References: <pull.1351.git.1663078962231.gitgitgadget@gmail.com>
From:   "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 17:29:43 +0000
Subject: [PATCH v2] fuzz: add basic fuzz testing for git command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Arthur Chan <arthur.chan@adalogics.com>,
        Arthur Chan <arthur.chan@adalogics.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Arthur Chan <arthur.chan@adalogics.com>

fuzz-cmd-base.c / fuzz-cmd-base.h provides base functions for
fuzzing on git command which are compatible with libFuzzer
(and possibly other fuzzing engines).
fuzz-cmd-status.c provides first git command fuzzing target
as a demonstration of the approach.

CC: Josh Steadmon <steadmon@google.com>
CC: David Korczynski <david@adalogics.com>
Signed-off-by: Arthur Chan <arthur.chan@adalogics.com>
---
    fuzz: add basic fuzz testing for git command
    
    An initial attempt to create LibFuzzer compatible fuzzer for git
    command. fuzz-cmd-base.c / fuzz-cmd-base.h provides base functions for
    fuzzing on git command which are compatible with libFuzzer (and possibly
    other fuzzing engines). fuzz-cmd-status.c provides first git command
    fuzzing target as a demonstration of the approach.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1351%2Farthurscchan%2Ffuzz-git-cmd-status-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1351/arthurscchan/fuzz-git-cmd-status-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1351

Range-diff vs v1:

 1:  11a09cef59a ! 1:  9100c7c8e51 fuzz: add basic fuzz testing for git command
     @@ Commit message
          as a demonstration of the approach.
      
          CC: Josh Steadmon <steadmon@google.com>
     +    CC: David Korczynski <david@adalogics.com>
          Signed-off-by: Arthur Chan <arthur.chan@adalogics.com>
      
       ## .gitignore ##
     @@ .gitignore
       /GIT-LDFLAGS
      
       ## Makefile ##
     -@@ Makefile: ETAGS_TARGET = TAGS
     - FUZZ_OBJS += fuzz-commit-graph.o
     - FUZZ_OBJS += fuzz-pack-headers.o
     - FUZZ_OBJS += fuzz-pack-idx.o
     -+FUZZ_OBJS += fuzz-cmd-status.o
     +@@ Makefile: SCRIPTS = $(SCRIPT_SH_GEN) \
     + 
     + ETAGS_TARGET = TAGS
     + 
     +-FUZZ_OBJS += fuzz-commit-graph.o
     +-FUZZ_OBJS += fuzz-pack-headers.o
     +-FUZZ_OBJS += fuzz-pack-idx.o
     ++FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
     ++FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
     ++FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
     ++FUZZ_OBJS += oss-fuzz/fuzz-cmd-status.o
       .PHONY: fuzz-objs
       fuzz-objs: $(FUZZ_OBJS)
       
     -@@ Makefile: LIB_OBJS += fsck.o
     - LIB_OBJS += fsmonitor.o
     - LIB_OBJS += fsmonitor-ipc.o
     - LIB_OBJS += fsmonitor-settings.o
     -+LIB_OBJS += fuzz-cmd-base.o
     - LIB_OBJS += gettext.o
     - LIB_OBJS += gpg-interface.o
     - LIB_OBJS += graph.o
     +@@ Makefile: LIB_OBJS += oid-array.o
     + LIB_OBJS += oidmap.o
     + LIB_OBJS += oidset.o
     + LIB_OBJS += oidtree.o
     ++LIB_OBJS += oss-fuzz/fuzz-cmd-base.o
     + LIB_OBJS += pack-bitmap-write.o
     + LIB_OBJS += pack-bitmap.o
     + LIB_OBJS += pack-check.o
      
     - ## fuzz-cmd-base.c (new) ##
     + ## oss-fuzz/fuzz-cmd-base.c (new) ##
      @@
      +#include "cache.h"
      +#include "fuzz-cmd-base.h"
     @@ fuzz-cmd-base.c (new)
      + * random data. The random data normally come from the fuzzing engine
      + * LibFuzzer in order to create randomization of the git file worktree
      + * and possibly messing up of certain git config file to fuzz different
     -+ * git command execution logic.
     ++ * git command execution logic. Return -1 if it fails to create the file.
      + */
     -+void randomize_git_file(char *dir, char *name, char *data_chunk, int data_size) {
     -+   char fname[256];
     -+   FILE *fp;
     -+
     -+   snprintf(fname, 255, "%s/%s", dir, name);
     -+
     -+   fp = fopen(fname, "wb");
     -+   if (fp) {
     -+      fwrite(data_chunk, 1, data_size, fp);
     -+      fclose(fp);
     -+   }
     ++int randomize_git_file(char *dir, char *name, char *data, int size)
     ++{
     ++	FILE *fp;
     ++	int ret = 0;
     ++	struct strbuf fname = STRBUF_INIT;
     ++
     ++	strbuf_addf(&fname, "%s/%s", dir, name);
     ++
     ++	fp = fopen(fname.buf, "wb");
     ++	if (fp)
     ++	{
     ++		fwrite(data, 1, size, fp);
     ++	}
     ++	else
     ++	{
     ++		ret = -1;
     ++	}
     ++
     ++	fclose(fp);
     ++	strbuf_release(&fname);
     ++
     ++	return ret;
      +}
      +
      +/*
     -+ * This function is the variants of the above functions which takes
     -+ * in a set of target files to be processed. These target file are
     ++ * This function is a variant of the above function which takes
     ++ * a set of target files to be processed. These target file are
      + * passing to the above function one by one for content rewrite.
     ++ * The data is equally divided for each of the files, and the
     ++ * remaining bytes (if not divisible) will be ignored.
      + */
     -+void randomize_git_files(char *dir, char *name_set[], int files_count, char *data, int size) {
     -+   int data_size = size / files_count;
     -+
     -+   for(int i=0; i<files_count; i++) {
     -+      char *data_chunk = malloc(data_size);
     -+      memcpy(data_chunk, data + (i * data_size), data_size);
     -+
     -+      randomize_git_file(dir, name_set[i], data_chunk, data_size);
     -+
     -+      free(data_chunk);
     -+   }
     ++void randomize_git_files(char *dir, char *name_set[],
     ++	int files_count, char *data, int size)
     ++{
     ++	int i;
     ++	int data_size = size / files_count;
     ++	char *data_chunk = xmallocz_gently(data_size);
     ++
     ++	if (!data_chunk)
     ++	{
     ++		return;
     ++	}
     ++
     ++	for (i = 0; i < files_count; i++)
     ++	{
     ++		memcpy(data_chunk, data + (i * data_size), data_size);
     ++		randomize_git_file(dir, name_set[i], data_chunk, data_size);
     ++	}
     ++	free(data_chunk);
      +}
      +
      +/*
      + * Instead of randomizing the content of existing files. This helper
      + * function helps generate a temp file with random file name before
      + * passing to the above functions to get randomized content for later
     -+ * fuzzing of git command
     ++ * fuzzing of git command.
      + */
     -+void generate_random_file(char *data, int size) {
     -+   unsigned char *hash = malloc(size);
     -+   char *fname = malloc((size*2)+12);
     -+   char *data_chunk = malloc(size);
     -+
     -+   memcpy(hash, data, size);
     -+   memcpy(data_chunk, data + size, size);
     -+
     -+   snprintf(fname, size*2+11, "TEMP-%s-TEMP", hash_to_hex(hash));
     -+   randomize_git_file(".", fname, data_chunk, size);
     -+
     -+   free(hash);
     -+   free(fname);
     -+   free(data_chunk);
     ++void generate_random_file(char *data, int size)
     ++{
     ++	unsigned char *hash = xmallocz_gently(size);
     ++	char *data_chunk = xmallocz_gently(size);
     ++	struct strbuf fname = STRBUF_INIT;
     ++
     ++	if (!hash || !data_chunk)
     ++	{
     ++		return;
     ++	}
     ++
     ++	memcpy(hash, data, size);
     ++	memcpy(data_chunk, data + size, size);
     ++
     ++	strbuf_addf(&fname, "TEMP-%s-TEMP", hash_to_hex(hash));
     ++	randomize_git_file(".", fname.buf, data_chunk, size);
     ++
     ++	free(hash);
     ++	free(data_chunk);
     ++	strbuf_release(&fname);
      +}
      +
      +/*
     @@ fuzz-cmd-base.c (new)
      + * of git commands.
      + */
      +void generate_commit(char *data, int size) {
     -+   int ret = 0;
     -+   char *data_chunk = malloc(size * 2);
     -+   memcpy(data_chunk, data, size * 2);
     ++	char *data_chunk = xmallocz_gently(size * 2);
     ++
     ++	if (!data_chunk)
     ++	{
     ++		return;
     ++	}
     ++
     ++	memcpy(data_chunk, data, size * 2);
     ++	generate_random_file(data_chunk, size);
      +
     -+   generate_random_file(data_chunk, size);
     -+   ret += system("git add TEMP-*-TEMP");
     -+   ret += system("git commit -m\"New Commit\"");
     ++	free(data_chunk);
      +
     -+   free(data_chunk);
     ++	if (system("git add TEMP-*-TEMP") || system("git commit -m\"New Commit\""))
     ++	{
     ++		// Just skip the commit if fails
     ++		return;
     ++	}
      +}
      +
      +/*
      + * In some cases, there maybe some fuzzing logic that will mess
      + * up with the git repository and its configuration and settings.
     -+ * This function aims to reset the git repository into the default
     -+ * base settings before each round of fuzzing.
     ++ * This function integrates into the fuzzing processing and
     ++ * reset the git repository into the default
     ++ * base settings befire each round of fuzzing.
      + */
     -+int reset_git_folder(void) {
     -+   int ret = 0;
     -+
     -+   ret += system("rm -rf ./.git");
     -+   ret += system("rm -f ./TEMP-*-TEMP");
     -+   ret += system("git init");
     -+   ret += system("git config --global user.name \"FUZZ\"");
     -+   ret += system("git config --global user.email \"FUZZ@LOCALHOST\"");
     -+   ret += system("git config --global --add safe.directory '*'");
     -+   ret += system("git add ./TEMP_1 ./TEMP_2");
     -+   ret += system("git commit -m\"First Commit\"");
     -+
     -+   return ret;
     ++int reset_git_folder(void)
     ++{
     ++	int ret = 0;
     ++
     ++	ret += system("rm -rf ./.git");
     ++	ret += system("rm -f ./TEMP-*-TEMP");
     ++
     ++	if (system("git init") ||
     ++		system("git config --global user.name \"FUZZ\"") ||
     ++		system("git config --global user.email \"FUZZ@LOCALHOST\"") ||
     ++		system("git config --global --add safe.directory '*'") ||
     ++		system("git add ./TEMP_1 ./TEMP_2") ||
     ++		system("git commit -m\"First Commit\""))
     ++	{
     ++		return -1;
     ++	}
     ++
     ++	return 0;
      +}
      +
      +/*
     @@ fuzz-cmd-base.c (new)
      + * data to increase randomization of the fuzzing target and allow
      + * more path of fuzzing to be covered.
      + */
     -+int get_max_commit_count(int data_size, int git_files_count, int hash_size) {
     -+   int count = (data_size - 4 - git_files_count * 2) / (hash_size * 2);
     ++int get_max_commit_count(int data_size, int git_files_count, int hash_size)
     ++{
     ++	int count = (data_size - 4 - git_files_count * 2) / (hash_size * 2);
      +
     -+   if(count > 20) {
     -+      count = 20;
     -+   }
     ++	if (count > 20)
     ++	{
     ++		count = 20;
     ++	}
      +
     -+   return count;
     ++	return count;
      +}
      
     - ## fuzz-cmd-base.h (new) ##
     + ## oss-fuzz/fuzz-cmd-base.h (new) ##
      @@
      +#ifndef FUZZ_CMD_BASE_H
      +#define FUZZ_CMD_BASE_H
      +
      +#define HASH_SIZE 20
      +
     -+void randomize_git_files(char *dir, char *name_set[], int files_count, char *data, int size);
     -+void randomize_git_file(char *dir, char *name, char *data_chunk, int data_size);
     ++int randomize_git_file(char *dir, char *name, char *data, int size);
     ++void randomize_git_files(char *dir, char *name_set[],
     ++	int files_count, char *data, int size);
      +void generate_random_file(char *data, int size);
      +void generate_commit(char *data, int size);
      +int reset_git_folder(void);
     @@ fuzz-cmd-base.h (new)
      +
      +#endif
      
     - ## fuzz-cmd-status.c (new) ##
     + ## oss-fuzz/fuzz-cmd-status.c (new) ##
      @@
      +#include "builtin.h"
      +#include "repository.h"
     @@ fuzz-cmd-status.c (new)
      +
      +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
      +
     -+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
     -+   int no_of_commit;
     -+   int max_commit_count;
     -+   char *argv[2];
     -+   char *data_chunk;
     -+   char *basedir = "./.git";
     -+
     -+   /*
     -+    *  Initialize the repository
     -+    */
     -+   initialize_the_repository();
     -+
     -+   max_commit_count = get_max_commit_count(size, 0, HASH_SIZE);
     -+
     -+   /*
     -+    * End this round of fuzzing if the data is not large enough
     -+    */
     -+   if (size <= (HASH_SIZE * 2 + 4)) {
     -+      repo_clear(the_repository);
     -+      return 0;
     -+   }
     -+
     -+   if (reset_git_folder()) {
     -+      repo_clear(the_repository);
     -+      return 0;
     -+   }
     -+
     -+   /*
     -+    * Generate random commit
     -+    */
     -+   no_of_commit = (*((int *)data)) % max_commit_count + 1;
     -+   data += 4;
     -+   size -= 4;
     -+
     -+   for (int i=0; i<no_of_commit; i++) {
     -+      data_chunk = malloc(HASH_SIZE * 2);
     -+      memcpy(data_chunk, data, HASH_SIZE * 2);
     -+      generate_commit(data_chunk, HASH_SIZE);
     -+      data += (HASH_SIZE * 2);
     -+      size -= (HASH_SIZE * 2);
     -+      free(data_chunk);
     -+   }
     -+
     -+   /*
     -+    * Final preparing of the repository settings
     -+    */
     -+   repo_clear(the_repository);
     -+   repo_init(the_repository, basedir, ".");
     -+
     -+   /*
     -+    * Calling target git command
     -+    */
     -+   argv[0] = "status";
     -+   argv[1] = "-v";
     -+   cmd_status(2, (const char **)argv, (const char *)"");
     -+
     -+   repo_clear(the_repository);
     -+
     -+   return 0;
     ++int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
     ++{
     ++	int i;
     ++	int no_of_commit;
     ++	int max_commit_count;
     ++	char *argv[2];
     ++	char *data_chunk;
     ++	char *basedir = "./.git";
     ++
     ++	/*
     ++	 *  Initialize the repository
     ++	 */
     ++	initialize_the_repository();
     ++
     ++	max_commit_count = get_max_commit_count(size, 0, HASH_SIZE);
     ++
     ++	/*
     ++	 * End this round of fuzzing if the data is not large enough
     ++	 */
     ++	if (size <= (HASH_SIZE * 2 + 4) || reset_git_folder())
     ++	{
     ++		repo_clear(the_repository);
     ++		return 0;
     ++	}
     ++
     ++
     ++	/*
     ++	 * Generate random commit
     ++	 */
     ++	no_of_commit = (*((int *)data)) % max_commit_count + 1;
     ++	data += 4;
     ++	size -= 4;
     ++
     ++	data_chunk = xmallocz_gently(HASH_SIZE * 2);
     ++
     ++	if (!data_chunk)
     ++	{
     ++		repo_clear(the_repository);
     ++		return 0;
     ++	}
     ++
     ++	for (i = 0; i < no_of_commit; i++)
     ++	{
     ++		memcpy(data_chunk, data, HASH_SIZE * 2);
     ++		generate_commit(data_chunk, HASH_SIZE);
     ++		data += (HASH_SIZE * 2);
     ++		size -= (HASH_SIZE * 2);
     ++	}
     ++
     ++	free(data_chunk);
     ++
     ++	/*
     ++	 * Final preparing of the repository settings
     ++	 */
     ++	repo_clear(the_repository);
     ++	if (repo_init(the_repository, basedir, "."))
     ++	{
     ++		repo_clear(the_repository);
     ++		return 0;
     ++	}
     ++
     ++	/*
     ++	 * Calling target git command
     ++	 */
     ++	argv[0] = "status";
     ++	argv[1] = "-v";
     ++	cmd_status(2, (const char **)argv, (const char *)"");
     ++
     ++	repo_clear(the_repository);
     ++	return 0;
      +}
     +
     + ## fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c ##
     +
     + ## fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c ##
     +
     + ## fuzz-pack-idx.c => oss-fuzz/fuzz-pack-idx.c ##


 .gitignore                                    |   2 +
 Makefile                                      |   8 +-
 oss-fuzz/fuzz-cmd-base.c                      | 159 ++++++++++++++++++
 oss-fuzz/fuzz-cmd-base.h                      |  14 ++
 oss-fuzz/fuzz-cmd-status.c                    |  79 +++++++++
 .../fuzz-commit-graph.c                       |   0
 .../fuzz-pack-headers.c                       |   0
 fuzz-pack-idx.c => oss-fuzz/fuzz-pack-idx.c   |   0
 8 files changed, 259 insertions(+), 3 deletions(-)
 create mode 100644 oss-fuzz/fuzz-cmd-base.c
 create mode 100644 oss-fuzz/fuzz-cmd-base.h
 create mode 100644 oss-fuzz/fuzz-cmd-status.c
 rename fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c (100%)
 rename fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c (100%)
 rename fuzz-pack-idx.c => oss-fuzz/fuzz-pack-idx.c (100%)

diff --git a/.gitignore b/.gitignore
index 80b530bbed2..5d0ce214164 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,8 @@
 /fuzz_corpora
 /fuzz-pack-headers
 /fuzz-pack-idx
+/fuzz-cmd-base
+/fuzz-cmd-status
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
diff --git a/Makefile b/Makefile
index c6e126e54c2..4aafe20489e 100644
--- a/Makefile
+++ b/Makefile
@@ -686,9 +686,10 @@ SCRIPTS = $(SCRIPT_SH_GEN) \
 
 ETAGS_TARGET = TAGS
 
-FUZZ_OBJS += fuzz-commit-graph.o
-FUZZ_OBJS += fuzz-pack-headers.o
-FUZZ_OBJS += fuzz-pack-idx.o
+FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
+FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
+FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
+FUZZ_OBJS += oss-fuzz/fuzz-cmd-status.o
 .PHONY: fuzz-objs
 fuzz-objs: $(FUZZ_OBJS)
 
@@ -1009,6 +1010,7 @@ LIB_OBJS += oid-array.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
 LIB_OBJS += oidtree.o
+LIB_OBJS += oss-fuzz/fuzz-cmd-base.o
 LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-check.o
diff --git a/oss-fuzz/fuzz-cmd-base.c b/oss-fuzz/fuzz-cmd-base.c
new file mode 100644
index 00000000000..25fb7b838f0
--- /dev/null
+++ b/oss-fuzz/fuzz-cmd-base.c
@@ -0,0 +1,159 @@
+#include "cache.h"
+#include "fuzz-cmd-base.h"
+
+
+/*
+ * This function is used to randomize the content of a file with the
+ * random data. The random data normally come from the fuzzing engine
+ * LibFuzzer in order to create randomization of the git file worktree
+ * and possibly messing up of certain git config file to fuzz different
+ * git command execution logic. Return -1 if it fails to create the file.
+ */
+int randomize_git_file(char *dir, char *name, char *data, int size)
+{
+	FILE *fp;
+	int ret = 0;
+	struct strbuf fname = STRBUF_INIT;
+
+	strbuf_addf(&fname, "%s/%s", dir, name);
+
+	fp = fopen(fname.buf, "wb");
+	if (fp)
+	{
+		fwrite(data, 1, size, fp);
+	}
+	else
+	{
+		ret = -1;
+	}
+
+	fclose(fp);
+	strbuf_release(&fname);
+
+	return ret;
+}
+
+/*
+ * This function is a variant of the above function which takes
+ * a set of target files to be processed. These target file are
+ * passing to the above function one by one for content rewrite.
+ * The data is equally divided for each of the files, and the
+ * remaining bytes (if not divisible) will be ignored.
+ */
+void randomize_git_files(char *dir, char *name_set[],
+	int files_count, char *data, int size)
+{
+	int i;
+	int data_size = size / files_count;
+	char *data_chunk = xmallocz_gently(data_size);
+
+	if (!data_chunk)
+	{
+		return;
+	}
+
+	for (i = 0; i < files_count; i++)
+	{
+		memcpy(data_chunk, data + (i * data_size), data_size);
+		randomize_git_file(dir, name_set[i], data_chunk, data_size);
+	}
+	free(data_chunk);
+}
+
+/*
+ * Instead of randomizing the content of existing files. This helper
+ * function helps generate a temp file with random file name before
+ * passing to the above functions to get randomized content for later
+ * fuzzing of git command.
+ */
+void generate_random_file(char *data, int size)
+{
+	unsigned char *hash = xmallocz_gently(size);
+	char *data_chunk = xmallocz_gently(size);
+	struct strbuf fname = STRBUF_INIT;
+
+	if (!hash || !data_chunk)
+	{
+		return;
+	}
+
+	memcpy(hash, data, size);
+	memcpy(data_chunk, data + size, size);
+
+	strbuf_addf(&fname, "TEMP-%s-TEMP", hash_to_hex(hash));
+	randomize_git_file(".", fname.buf, data_chunk, size);
+
+	free(hash);
+	free(data_chunk);
+	strbuf_release(&fname);
+}
+
+/*
+ * This function helps to generate random commit and build up a
+ * worktree with randomization to provide a target for the fuzzing
+ * of git commands.
+ */
+void generate_commit(char *data, int size) {
+	char *data_chunk = xmallocz_gently(size * 2);
+
+	if (!data_chunk)
+	{
+		return;
+	}
+
+	memcpy(data_chunk, data, size * 2);
+	generate_random_file(data_chunk, size);
+
+	free(data_chunk);
+
+	if (system("git add TEMP-*-TEMP") || system("git commit -m\"New Commit\""))
+	{
+		// Just skip the commit if fails
+		return;
+	}
+}
+
+/*
+ * In some cases, there maybe some fuzzing logic that will mess
+ * up with the git repository and its configuration and settings.
+ * This function integrates into the fuzzing processing and
+ * reset the git repository into the default
+ * base settings befire each round of fuzzing.
+ */
+int reset_git_folder(void)
+{
+	int ret = 0;
+
+	ret += system("rm -rf ./.git");
+	ret += system("rm -f ./TEMP-*-TEMP");
+
+	if (system("git init") ||
+		system("git config --global user.name \"FUZZ\"") ||
+		system("git config --global user.email \"FUZZ@LOCALHOST\"") ||
+		system("git config --global --add safe.directory '*'") ||
+		system("git add ./TEMP_1 ./TEMP_2") ||
+		system("git commit -m\"First Commit\""))
+	{
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * This helper function returns the maximum number of commit can
+ * be generated by the provided random data without reusing the
+ * data to increase randomization of the fuzzing target and allow
+ * more path of fuzzing to be covered.
+ */
+int get_max_commit_count(int data_size, int git_files_count, int hash_size)
+{
+	int count = (data_size - 4 - git_files_count * 2) / (hash_size * 2);
+
+	if (count > 20)
+	{
+		count = 20;
+	}
+
+	return count;
+}
diff --git a/oss-fuzz/fuzz-cmd-base.h b/oss-fuzz/fuzz-cmd-base.h
new file mode 100644
index 00000000000..ed9ef62d554
--- /dev/null
+++ b/oss-fuzz/fuzz-cmd-base.h
@@ -0,0 +1,14 @@
+#ifndef FUZZ_CMD_BASE_H
+#define FUZZ_CMD_BASE_H
+
+#define HASH_SIZE 20
+
+int randomize_git_file(char *dir, char *name, char *data, int size);
+void randomize_git_files(char *dir, char *name_set[],
+	int files_count, char *data, int size);
+void generate_random_file(char *data, int size);
+void generate_commit(char *data, int size);
+int reset_git_folder(void);
+int get_max_commit_count(int data_size, int git_files_count, int hash_size);
+
+#endif
diff --git a/oss-fuzz/fuzz-cmd-status.c b/oss-fuzz/fuzz-cmd-status.c
new file mode 100644
index 00000000000..eb87d1ed13d
--- /dev/null
+++ b/oss-fuzz/fuzz-cmd-status.c
@@ -0,0 +1,79 @@
+#include "builtin.h"
+#include "repository.h"
+#include "fuzz-cmd-base.h"
+
+int cmd_status(int argc, const char **argv, const char *prefix);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	int i;
+	int no_of_commit;
+	int max_commit_count;
+	char *argv[2];
+	char *data_chunk;
+	char *basedir = "./.git";
+
+	/*
+	 *  Initialize the repository
+	 */
+	initialize_the_repository();
+
+	max_commit_count = get_max_commit_count(size, 0, HASH_SIZE);
+
+	/*
+	 * End this round of fuzzing if the data is not large enough
+	 */
+	if (size <= (HASH_SIZE * 2 + 4) || reset_git_folder())
+	{
+		repo_clear(the_repository);
+		return 0;
+	}
+
+
+	/*
+	 * Generate random commit
+	 */
+	no_of_commit = (*((int *)data)) % max_commit_count + 1;
+	data += 4;
+	size -= 4;
+
+	data_chunk = xmallocz_gently(HASH_SIZE * 2);
+
+	if (!data_chunk)
+	{
+		repo_clear(the_repository);
+		return 0;
+	}
+
+	for (i = 0; i < no_of_commit; i++)
+	{
+		memcpy(data_chunk, data, HASH_SIZE * 2);
+		generate_commit(data_chunk, HASH_SIZE);
+		data += (HASH_SIZE * 2);
+		size -= (HASH_SIZE * 2);
+	}
+
+	free(data_chunk);
+
+	/*
+	 * Final preparing of the repository settings
+	 */
+	repo_clear(the_repository);
+	if (repo_init(the_repository, basedir, "."))
+	{
+		repo_clear(the_repository);
+		return 0;
+	}
+
+	/*
+	 * Calling target git command
+	 */
+	argv[0] = "status";
+	argv[1] = "-v";
+	cmd_status(2, (const char **)argv, (const char *)"");
+
+	repo_clear(the_repository);
+	return 0;
+}
diff --git a/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
similarity index 100%
rename from fuzz-commit-graph.c
rename to oss-fuzz/fuzz-commit-graph.c
diff --git a/fuzz-pack-headers.c b/oss-fuzz/fuzz-pack-headers.c
similarity index 100%
rename from fuzz-pack-headers.c
rename to oss-fuzz/fuzz-pack-headers.c
diff --git a/fuzz-pack-idx.c b/oss-fuzz/fuzz-pack-idx.c
similarity index 100%
rename from fuzz-pack-idx.c
rename to oss-fuzz/fuzz-pack-idx.c

base-commit: dd3f6c4cae7e3b15ce984dce8593ff7569650e24
-- 
gitgitgadget
