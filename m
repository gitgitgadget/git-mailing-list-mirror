Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8229C25B0E
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiHLUK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiHLUKY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:10:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F3E6170
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso4249629wmh.5
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=xaq56Rl8bLPagpqjbO++lmBP3hXLa2NqjQVahNRU7P0=;
        b=FluwU7rfHskeQkN9KWybW/s1gmBXavcWxXM4Lm2vWJ+2MGVsYqAyjpbVjaOF3H4oPr
         Pcxe4WeKnbJt7y7Fg55EhTKHJx+xEGwK7C97J9tAEWqqGDXgs3K8ZSlHSQMuGbGHyLjf
         +MSFvZPtk9XQ6q/JRuOAod+u4hu4SWVfSpDTqC8jlcC6ZPWc5jMEQZK6r1qbCl7QlTps
         5xBPakIl86qnBCoaYS7qtMv/lVjsMkA2YsdrYSxjwDtsJospw1O+GtpYet2PznSurOmC
         zdIg0lc3O7KHStVyxYZCVxzUgbyhe5N35gayX/t27toJ0d2Qau6y5EBLzJu46mxztwsz
         YKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=xaq56Rl8bLPagpqjbO++lmBP3hXLa2NqjQVahNRU7P0=;
        b=egiwcdxXQiqog39JrPkapxWFEYmeAF0BX9gUyi5JKZ6XX38Xxc7gIPEYHHA9dwJu21
         qGxkYqY0tkz94nqLbgnW7ZmZd2zhh/zu6iPaB6gtV1z3YrYNkb//861vqRQflk5Kvgpf
         hgFraNkIQShZbcrbjhYLUNE6I/Mg5ZAPD/10Q6c1IZ6D8EDPAyh/1K3b8lsvoEFtKt3R
         uKvSKGZeO6+plVQp+Hy6H15ji55LmjKZp6Gy98C2vONY/JEASYtr6rA8SzLyZ7poCCfK
         yj5IE1UdjUA8gvObyajgnY0pQ1nvjl8n64tr40ggb9laM/S7QzmX6Tb6sF+VVdnyyjY+
         TjJQ==
X-Gm-Message-State: ACgBeo3AMdpURA/uQEnsXm4ICTPQRfufHPE0SsnWc6YQiQ7FvWfQm8qI
        NCs97MqKzsK3J+jzk4FfYfiC/qqLRoU=
X-Google-Smtp-Source: AA6agR4IxkwqiWj6r2WlPF2M/UCFb04Yd95+BHj+BuG8sYc4RR26yv8+ug1dpCwc9crsmYzTRPrrVg==
X-Received: by 2002:a05:600c:384c:b0:3a4:a146:2a04 with SMTP id s12-20020a05600c384c00b003a4a1462a04mr3551885wmr.176.1660335020979;
        Fri, 12 Aug 2022 13:10:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10-20020a05600c348a00b003a531c7aa66sm584748wmq.1.2022.08.12.13.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 13:10:20 -0700 (PDT)
Message-Id: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 20:10:08 +0000
Subject: [PATCH v4 00/11] Generalize 'scalar diagnose' into 'git diagnose' and 'git bugreport
 --diagnose'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the preparation for moving Scalar out of 'contrib/' and into Git,
this series moves the functionality of 'scalar diagnose' into a new builtin
('git diagnose') and a new option ('--diagnose') for 'git bugreport'. This
change further aligns Scalar with the objective [1] of having it only
contain functionality and settings that benefit large Git repositories, but
not all repositories. The diagnostics reported by 'scalar diagnose' relevant
for investigating issues in any Git repository, so generating them should be
part of a "normal" Git builtin.

The series is organized as follows:

 * Miscellaneous fixes for the existing 'scalar diagnose' implementation
 * Moving the code for generating diagnostics into a common location in the
   Git tree
 * Implementing 'git diagnose'
 * Implementing 'git bugreport --diagnose'
 * Updating the Scalar roadmap

Finally, despite 'scalar diagnose' now being nothing more than a wrapper for
'git bugreport --diagnose', it is not being deprecated in this series.
Although deprecation -> removal could be a future cleanup effort, 'scalar
diagnose' is kept around for now as an alias for users already accustomed to
using it in 'scalar'.


Changes since V3
================

 * Moved 'parse-options.h' import in 'diagnose.h' into the commit where it's
   first needed.
 * Removed a redundant 'if (!res)' condition gating the final "Diagnostics
   complete" message in 'create_diagnostics_archive()'.
 * Improved error reporting in 'create_diagnostics_archive()'. I was
   originally going to modify the "failed to write archive" error to trigger
   whenever 'create_diagnostics_archive()' returned a nonzero value [2].
   However, while working on it I realized the message would no longer be
   tied to a failure of 'write_archive()', making it less helpful in
   pinpointing an issue. To address the original issue
   ('add_directory_to_archiver()' silently failing in
   'create_diagnostics_archive()'), I instead refactored those calls into a
   loop and added the error message. Now, there's exactly one error message
   printed for each possible early exit scenario from
   'create_diagnostics_archive()', hopefully avoiding both redundancy &
   under-reporting.


Changes since V2
================

 * Replaced 'int include_everything' arg to 'create_diagnostic_archive()'
   with 'enum diagnose_mode mode'.
 * Replaced '--all' with configurable '--mode' option in 'git diagnose';
   moved 'option_parse_diagnose()' into 'diagnose.c' so that it can be used
   for both 'git bugreport --diagnose' and 'git diagnose --mode'.
 * Split "builtin/diagnose.c: gate certain data behind '--all'" (formerly
   patch 7/10) into "diagnose.c: add option to configure archive contents"
   (patch 6/11) and "builtin/diagnose.c: add '--mode' option" (patch 8/11).
 * Added '--no-diagnose' for 'git bugreport'. I was initially going to use
   '--diagnose=none', but '--no-diagnose' was easier to configure when using
   the shared 'option_parse_diagnose()' function .
 * Updated usage strings, option descriptions, and documentation files for
   'mode' option. To avoid needing to keep multiple lists of valid 'mode'
   values up-to-date, format mode value as <mode> everywhere except option
   description in 'git-diagnose.txt', where the values are listed. The
   documentation of '--diagnose' in 'git-bugreport.txt' links to
   'git-diagnose.txt' and explicitly calls out that details on 'mode' can be
   found there.
 * Reworded 'git diagnose' and 'git bugreport' command & option
   documentation.
 * Added additional checks to 't0091-bugreport.sh' and 't0092-diagnose.sh'
   tests
 * Moved '#include "cache.h" from 'diagnose.h' to 'diagnose.c'.
 * Fixed '--output-directory' usage string in 'builtin/diagnose.c'.
 * Replaced 'die()' with 'die_errno()' in error triggered when leading
   directories of archive cannot be created.
 * Changed hardcoded '-1' error exit code in 'scalar diagnose' to returning
   the exit code from 'git diagnose --mode=all'.


Changes since V1
================

 * Reorganized patches to fix minor issues (e.g., more gently adding
   directories to the archive) of 'scalar diagnose' in 'scalar.c', before
   the code is moved out of that file.
 * (Almost) entirely redesigned the UI for generating diagnostics. The new
   approach avoids cluttering 'git bugreport' with a mode that doesn't
   actually generate a report. Now, there are distinct options for different
   use cases: generating extra diagnostics with a bug report ('git bugreport
   --diagnose') and generating diagnostics for personal debugging/addition
   to an existing bug report ('git diagnose').
 * Moved 'get_disk_info()' into 'compat/'.
 * Moved 'create_diagnostics_archive()' into a new 'diagnose.c', as it now
   has multiple callers.
 * Updated command & option documentation to more clearly guide users on how
   to use the new options.
 * Added the '--all' (and '--diagnose=all') option to change the default
   behavior of diagnostics generation to exclude '.git' directory contents.
   For many bug reporters, this would reveal private repository contents
   they don't want to expose to the public mailing list. This has the added
   benefit of creating much smaller archives by default, which will be more
   likely to successfully send to the mailing list.

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/pull.1275.v2.git.1657584367.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/32f2cadc-556e-1cd5-a238-c8f1cdaaf470@github.com/

Victoria Dye (11):
  scalar-diagnose: use "$GIT_UNZIP" in test
  scalar-diagnose: avoid 32-bit overflow of size_t
  scalar-diagnose: add directory to archiver more gently
  scalar-diagnose: move 'get_disk_info()' to 'compat/'
  scalar-diagnose: move functionality to common location
  diagnose.c: add option to configure archive contents
  builtin/diagnose.c: create 'git diagnose' builtin
  builtin/diagnose.c: add '--mode' option
  builtin/bugreport.c: create '--diagnose' option
  scalar-diagnose: use 'git diagnose --mode=all'
  scalar: update technical doc roadmap

 .gitignore                         |   1 +
 Documentation/git-bugreport.txt    |  18 ++
 Documentation/git-diagnose.txt     |  65 +++++++
 Documentation/technical/scalar.txt |   9 +-
 Makefile                           |   2 +
 builtin.h                          |   1 +
 builtin/bugreport.c                |  27 ++-
 builtin/diagnose.c                 |  61 +++++++
 compat/disk.h                      |  56 ++++++
 contrib/scalar/scalar.c            | 271 +----------------------------
 contrib/scalar/t/t9099-scalar.sh   |   8 +-
 diagnose.c                         | 269 ++++++++++++++++++++++++++++
 diagnose.h                         |  17 ++
 git-compat-util.h                  |   1 +
 git.c                              |   1 +
 t/t0091-bugreport.sh               |  48 +++++
 t/t0092-diagnose.sh                |  60 +++++++
 17 files changed, 637 insertions(+), 278 deletions(-)
 create mode 100644 Documentation/git-diagnose.txt
 create mode 100644 builtin/diagnose.c
 create mode 100644 compat/disk.h
 create mode 100644 diagnose.c
 create mode 100644 diagnose.h
 create mode 100755 t/t0092-diagnose.sh


base-commit: 4af7188bc97f70277d0f10d56d5373022b1fa385
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1310%2Fvdye%2Fscalar%2Fgeneralize-diagnose-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1310/vdye/scalar/generalize-diagnose-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1310

Range-diff vs v3:

  1:  f5ceb9c7190 =  1:  f5ceb9c7190 scalar-diagnose: use "$GIT_UNZIP" in test
  2:  78a93eb95bb =  2:  78a93eb95bb scalar-diagnose: avoid 32-bit overflow of size_t
  3:  22ee8ea5a1e =  3:  22ee8ea5a1e scalar-diagnose: add directory to archiver more gently
  4:  18f2ba4e0cd =  4:  18f2ba4e0cd scalar-diagnose: move 'get_disk_info()' to 'compat/'
  5:  7a51fad87a8 !  5:  c19f3632d4f scalar-diagnose: move functionality to common location
     @@ diagnose.c (new)
      +		goto diagnose_cleanup;
      +	}
      +
     -+	if (!res)
     -+		fprintf(stderr, "\n"
     -+			"Diagnostics complete.\n"
     -+			"All of the gathered info is captured in '%s'\n",
     -+			zip_path->buf);
     ++	fprintf(stderr, "\n"
     ++		"Diagnostics complete.\n"
     ++		"All of the gathered info is captured in '%s'\n",
     ++		zip_path->buf);
      +
      +diagnose_cleanup:
      +	if (archiver_fd >= 0) {
  6:  0a6c55696d8 !  6:  710b67e5776 diagnose.c: add option to configure archive contents
     @@ Commit message
          match existing functionality), but more callers will be introduced in
          subsequent patches.
      
     +    Finally, refactor from a hardcoded set of 'add_directory_to_archiver()'
     +    calls to iterative invocations gated by 'DIAGNOSE_ALL'. This allows for
     +    easier future modification of the set of directories to archive and improves
     +    error reporting when 'add_directory_to_archiver()' fails.
     +
          Helped-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
       	strbuf_release(&zip_path);
      
       ## diagnose.c ##
     +@@
     + #include "object-store.h"
     + #include "packfile.h"
     + 
     ++struct archive_dir {
     ++	const char *path;
     ++	int recursive;
     ++};
     ++
     + static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
     + 				   const char *file_name, void *data)
     + {
      @@ diagnose.c: static int add_directory_to_archiver(struct strvec *archiver_args,
       	return res;
       }
     @@ diagnose.c: static int add_directory_to_archiver(struct strvec *archiver_args,
       {
       	struct strvec archiver_args = STRVEC_INIT;
       	char **argv_copy = NULL;
     -@@ diagnose.c: int create_diagnostics_archive(struct strbuf *zip_path)
     + 	int stdout_fd = -1, archiver_fd = -1;
       	struct strbuf buf = STRBUF_INIT;
     - 	int res;
     - 
     +-	int res;
     ++	int res, i;
     ++	struct archive_dir archive_dirs[] = {
     ++		{ ".git", 0 },
     ++		{ ".git/hooks", 0 },
     ++		{ ".git/info", 0 },
     ++		{ ".git/logs", 1 },
     ++		{ ".git/objects/info", 0 }
     ++	};
     ++
      +	if (mode == DIAGNOSE_NONE) {
      +		res = 0;
      +		goto diagnose_cleanup;
      +	}
     -+
     + 
       	stdout_fd = dup(STDOUT_FILENO);
       	if (stdout_fd < 0) {
     - 		res = error_errno(_("could not duplicate stdout"));
      @@ diagnose.c: int create_diagnostics_archive(struct strbuf *zip_path)
       	loose_objs_stats(&buf, ".git/objects");
       	strvec_push(&archiver_args, buf.buf);
     @@ diagnose.c: int create_diagnostics_archive(struct strbuf *zip_path)
      -	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
      -	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
      -	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
     +-		goto diagnose_cleanup;
      +	/* Only include this if explicitly requested */
     -+	if (mode == DIAGNOSE_ALL &&
     -+	    ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
     -+	     (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
     -+	     (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
     -+	     (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
     -+	     (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0))))
     - 		goto diagnose_cleanup;
     ++	if (mode == DIAGNOSE_ALL) {
     ++		for (i = 0; i < ARRAY_SIZE(archive_dirs); i++) {
     ++			if (add_directory_to_archiver(&archiver_args,
     ++						      archive_dirs[i].path,
     ++						      archive_dirs[i].recursive)) {
     ++				res = error_errno(_("could not add directory '%s' to archiver"),
     ++						  archive_dirs[i].path);
     ++				goto diagnose_cleanup;
     ++			}
     ++		}
     ++	}
       
       	strvec_pushl(&archiver_args, "--prefix=",
     + 		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
      
       ## diagnose.h ##
      @@
     - #define DIAGNOSE_H
       
       #include "strbuf.h"
     -+#include "parse-options.h"
       
      -int create_diagnostics_archive(struct strbuf *zip_path);
      +enum diagnose_mode {
  7:  bf3c073a985 =  7:  b58d13325b2 builtin/diagnose.c: create 'git diagnose' builtin
  8:  3da0cb725c9 !  8:  82be069e5e9 builtin/diagnose.c: add '--mode' option
     @@ builtin/diagnose.c: int cmd_diagnose(int argc, const char **argv, const char *pr
       
      
       ## diagnose.c ##
     -@@
     - #include "object-store.h"
     - #include "packfile.h"
     +@@ diagnose.c: struct archive_dir {
     + 	int recursive;
     + };
       
      +struct diagnose_option {
      +	enum diagnose_mode mode;
     @@ diagnose.c
       {
      
       ## diagnose.h ##
     +@@
     + #define DIAGNOSE_H
     + 
     + #include "strbuf.h"
     ++#include "parse-options.h"
     + 
     + enum diagnose_mode {
     + 	DIAGNOSE_NONE,
      @@ diagnose.h: enum diagnose_mode {
       	DIAGNOSE_ALL
       };
  9:  1a1eb2c9806 =  9:  718e3f43484 builtin/bugreport.c: create '--diagnose' option
 10:  d22674752f0 = 10:  94b32eacdd5 scalar-diagnose: use 'git diagnose --mode=all'
 11:  b64475f5b17 = 11:  728f8b81fd0 scalar: update technical doc roadmap

-- 
gitgitgadget
