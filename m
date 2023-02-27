Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B412AC64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 15:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjB0P2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjB0P20 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 10:28:26 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF2630E2
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:23 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso7029176wmi.4
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM1AKE45jlTSYxQ9N+zdTWslW60uWlU16QvGMmKs9Rw=;
        b=RkOtK7xcELttVq+wsVQTlcuZ/MLqmKc/wxt0CR66xXcCmXfrMt5Earz1v5CjxqdMZC
         foS4NIjI+HchUGxLkD19PA+7oKJtA4raKPrprDRnGOq2JijFQWkeu2IxQH3O01hEXWWJ
         65RzfZ594PTMoScMmQC3Aj9TEpwzRE0ifc+soiHVXxV8Ncg2f8Y67zCXVXhOArVjzBHq
         RmSYxU5bm0LOX9VO3uCSD7QL87CWLj1alIFEsB3Sjl/n+kSDpF+yFT007p3X6TFdTOFI
         TijFHuH/9YPLkXcNh/PFlR6NxYiq4JhRs/q4fmTchIcaTnsEyybkaNgbjQA0HkAsdiiZ
         6+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jM1AKE45jlTSYxQ9N+zdTWslW60uWlU16QvGMmKs9Rw=;
        b=S5l3x5U6bar+YUDa9Zi5TdUwvN59wMdmmJNgOV/sUXvWMRAHfbJnRkXc5s0NyyxFgW
         PJJqZ3hDbxpJvSpmGs1DxoGATBmtd8rYOBjSBh2ZGgA0m2Ed5skHjX4LiH16zpmS2kle
         rSJP+kzUYAKkyoFYFRUXLxI/GzbS4uqiKJYOzZ//raKd0oyb4eXZU/sybZGDglgRCO36
         LnmB3/1lhZ8UtMhX1+Pr9byr8VCZro3MKVuWMRqL/LDnPKsu40eqRtp/sGeB80vJap+v
         jo+/55KJV/srxdEnt8nw5Eobdw9Cz2sNdXzgPp0IEyG+ZGBpdTumGHJzkeAT4RMosPS6
         KDEg==
X-Gm-Message-State: AO0yUKWSPrHfydqDu+qFxB9QP1GG0Jo5ag/IcFrxxI83fGldeqUBsPML
        0BdEb44dGrEz9hvG56+Pqi4Nc7NmnnQ=
X-Google-Smtp-Source: AK7set8/WQImvse48sCCVe3Gh+7L8jDXfQAAwh3779JUZuiOqechqUH3mFqm+nUxvxblFUz3X1gPzA==
X-Received: by 2002:a05:600c:3318:b0:3ea:dc39:e8b1 with SMTP id q24-20020a05600c331800b003eadc39e8b1mr10044208wmp.12.1677511701656;
        Mon, 27 Feb 2023 07:28:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7-20020adffcc7000000b002c7163660a9sm7558250wrs.105.2023.02.27.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:28:21 -0800 (PST)
Message-Id: <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
References: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 15:28:07 +0000
Subject: [PATCH v3 00/13] Clarify API for dir.[ch] and unpack-trees.[ch] -- mark relevant fields as
 internal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

 * Two new patches:
   * one patch (2nd in the series) that fixes a bug in unpack-trees due to
     the code never having been updated to setup_standard_excludes() + adds
     a test to avoid regressing that bug it
   * a preliminary patch that fixes a separate latent issue in the modified
     testfile referenced above, so that the new test listed above will
     actually work on all platforms.

Changes since v1 (thanks to Jonathan Tan for the careful reviews!)

 * Clear o->pl when freeing pl, to avoid risking use-after-free.
 * Initialize o->result in update_sparsity() since it is actually used (by
   check_ok_to_remove()).

Some time ago, I noticed that struct dir_struct and struct
unpack_trees_options both have numerous fields meant for internal use only,
most of which are not marked as such. This has resulted in callers
accidentally trying to initialize some of these fields, and in at least one
case required a fair amount of review to verify other changes were okay --
review that would have been simplified with the apriori knowledge that a
combination of multiple fields were internal-only[1]. Looking closer, I
found that only 6 out of 18 fields in dir_struct were actually meant to be
public[2], and noted that unpack_trees_options also had 11 internal-only
fields (out of 36).

This patch is primarily about moving internal-only fields within these two
structs into an embedded internal struct. Patch breakdown:

 * Patches 1-3: Restructuring dir_struct
   * Patch 1: Splitting off internal-use-only fields
   * Patch 2: Add important usage note to avoid accidentally using
     deprecated API
   * Patch 3: Mark output-only fields as such
 * Patches 4-11: Restructuring unpack_trees_options
   * Patches 4-6: Preparatory cleanup
   * Patches 7-10: Splitting off internal-use-only fields
   * Patch 11: Mark output-only field as such

To make the benefit more clear, here are compressed versions of dir_struct
both before and after the changes. First, before:

struct dir_struct {
    int nr;
    int alloc;
    int ignored_nr;
    int ignored_alloc;
    enum [...] flags;
    struct dir_entry **entries;
    struct dir_entry **ignored;
    const char *exclude_per_dir;
#define EXC_CMDL 0
#define EXC_DIRS 1
#define EXC_FILE 2
    struct exclude_list_group exclude_list_group[3];
    struct exclude_stack *exclude_stack;
    struct path_pattern *pattern;
    struct strbuf basebuf;
    struct untracked_cache *untracked;
    struct oid_stat ss_info_exclude;
    struct oid_stat ss_excludes_file;
    unsigned unmanaged_exclude_files;
    unsigned visited_paths;
    unsigned visited_directories;
};


And after the changes:

struct dir_struct {
    enum [...] flags;
    int nr; /* output only */
    int ignored_nr; /* output only */
    struct dir_entry **entries; /* output only */
    struct dir_entry **ignored; /* output only */
    struct untracked_cache *untracked;
    const char *exclude_per_dir; /* deprecated */
    struct dir_struct_internal {
        int alloc;
        int ignored_alloc;
#define EXC_CMDL 0
#define EXC_DIRS 1
#define EXC_FILE 2
        struct exclude_list_group exclude_list_group[3];
        struct exclude_stack *exclude_stack;
        struct path_pattern *pattern;
        struct strbuf basebuf;
        struct oid_stat ss_info_exclude;
        struct oid_stat ss_excludes_file;
        unsigned unmanaged_exclude_files;
        unsigned visited_paths;
        unsigned visited_directories;
    } internal;
};


The former version has 18 fields (and 3 magic constants) which API users
will have to figure out. The latter makes it clear there are only at most 2
fields you should be setting upon input, and at most 4 which you read at
output, and the rest (including all the magic constants) you can ignore.

[0] Search for "Extremely yes" in
https://lore.kernel.org/git/CAJoAoZm+TkCL0Jpg_qFgKottxbtiG2QOiY0qGrz3-uQy+=waPg@mail.gmail.com/
[1]
https://lore.kernel.org/git/CABPp-BFSFN3WM6q7KzkD5mhrwsz--St_-ej5LbaY8Yr2sZzj=w@mail.gmail.com/
[2]
https://lore.kernel.org/git/CABPp-BHgot=CPNyK_xNfog_SqsNPNoCGfiSb-gZoS2sn_741dQ@mail.gmail.com/

Elijah Newren (13):
  t2021: fix platform-specific leftover cruft
  unpack-trees: heed requests to overwrite ignored files
  dir: separate public from internal portion of dir_struct
  dir: add a usage note to exclude_per_dir
  dir: mark output only fields of dir_struct as such
  unpack-trees: clean up some flow control
  sparse-checkout: avoid using internal API of unpack-trees
  sparse-checkout: avoid using internal API of unpack-trees, take 2
  unpack_trees: start splitting internal fields from public API
  unpack-trees: mark fields only used internally as internal
  unpack-trees: rewrap a few overlong lines from previous patch
  unpack-trees: special case read-tree debugging as internal usage
  unpack-trees: add usage notices around df_conflict_entry

 builtin/read-tree.c           |  10 +-
 builtin/sparse-checkout.c     |   4 +-
 dir.c                         | 114 ++++++++--------
 dir.h                         | 110 ++++++++-------
 t/t2021-checkout-overwrite.sh |  16 ++-
 unpack-trees.c                | 247 ++++++++++++++++++----------------
 unpack-trees.h                |  42 +++---
 7 files changed, 292 insertions(+), 251 deletions(-)


base-commit: 06dd2baa8da4a73421b959ec026a43711b9d77f9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1149%2Fnewren%2Fclarify-api-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1149/newren/clarify-api-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1149

Range-diff vs v2:

  -:  ----------- >  1:  7bbc4577a57 t2021: fix platform-specific leftover cruft
  -:  ----------- >  2:  8ffdb6c8a8a unpack-trees: heed requests to overwrite ignored files
  1:  7f59ad548d0 =  3:  879a93ac2d7 dir: separate public from internal portion of dir_struct
  2:  239b10e1181 !  4:  4ce9fae5e7f dir: add a usage note to exclude_per_dir
     @@ Metadata
       ## Commit message ##
          dir: add a usage note to exclude_per_dir
      
     +    As evidenced by the fix a couple commits ago, places in the code using
     +    exclude_per_dir are likely buggy and should be adapted to call
     +    setup_standard_excludes() instead.  Unfortunately, the usage of
     +    exclude_per_dir has been hardcoded into the arguments ls-files accepts,
     +    so we cannot actually remove it.  Add a note that it is deprecated and
     +    no other callers should use it directly.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## dir.h ##
  3:  b8aa14350d3 =  5:  12344400fa0 dir: mark output only fields of dir_struct as such
  4:  f5a58123034 =  6:  4e86e39506c unpack-trees: clean up some flow control
  5:  975dec0f0eb =  7:  cd3d4894afb sparse-checkout: avoid using internal API of unpack-trees
  6:  429f195dcfe =  8:  09140cb2ac5 sparse-checkout: avoid using internal API of unpack-trees, take 2
  7:  993da584dbb !  9:  27f2d477116 unpack_trees: start splitting internal fields from public API
     @@ unpack-trees.c: static int verify_clean_subdirectory(const struct cache_entry *c
       
       	memset(&d, 0, sizeof(d));
      -	if (o->dir)
     --		d.exclude_per_dir = o->dir->exclude_per_dir;
      +	if (o->internal.dir)
     -+		d.exclude_per_dir = o->internal.dir->exclude_per_dir;
     + 		setup_standard_excludes(&d);
       	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
       	dir_clear(&d);
     - 	free(pathbuf);
      @@ unpack-trees.c: static int check_ok_to_remove(const char *name, int len, int dtype,
       	if (ignore_case && icase_exists(o, name, len, st))
       		return 0;
  8:  8ecb24a45f0 = 10:  4236c0d80c7 unpack-trees: mark fields only used internally as internal
  9:  36ca49c3624 = 11:  76f4a544e4b unpack-trees: rewrap a few overlong lines from previous patch
 10:  5af04d7fe23 = 12:  ee36935adb5 unpack-trees: special case read-tree debugging as internal usage
 11:  c4f31237634 = 13:  6575c007577 unpack-trees: add usage notices around df_conflict_entry

-- 
gitgitgadget
