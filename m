Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC17CC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 12:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJLMwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 08:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJLMwp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 08:52:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED6AB2DAF
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b4so26108008wrs.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkvhrL6pSIvn29G8nxOz2HMCHGro/ExqjluIFYLLR1k=;
        b=XAIChodMaL7eQVu5/Z1BkIApciQXd4h7njcfu8E31eJFcK9KtmUt8aYT+9tJk8C2oj
         seBYcP0T4NSnRO81IQb+YoX98RctFMxaqLp8camJsz45lu8TZ7Bl7gciMPOevw9l1rVI
         m4ytVJ2unwLTQKa7xeBXr9PM5jKFqoy0tXDQrBueJR2k3aTq7cpFij+xe+aPJjQiF4Hx
         GwmSLKIEvxQjtA3zIjLdd9qAZD8XkyYKnFnY0OeN6RMy63qw2CKR3ByHGA/EC2/sJnRf
         CQBJBHF1MxC1fsM/WyugOJWdmEcB9eiQ+7zbkTuE3p1Alp+O20hcLze72tJbCleuDhPg
         ywuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkvhrL6pSIvn29G8nxOz2HMCHGro/ExqjluIFYLLR1k=;
        b=IS6H4dcCrfLimQosHqrQ0dIowtdeEDXkQwxv9pNREtQACM8fnkzgXCu5OW6by9KRIH
         bPx1mmq8e7N5D5AUHExcJWcEW+bWhHh4EMJ5bKaHU8WP3UCryAFbsep/EBaMTdyF49Qz
         NEkYRp4V2Cykaz5f84IMMZfKb/EEtTFso4v62dR+rQNpYTD2qkU6G9NUQ4g799I0KFWo
         UuQezWqYAW6Ad/jOV3eNTGuJpw2VrS9yzU5XCE7y2QOPtv0W9jcYIanddZnpNHxhqQVQ
         45SkYyVd7tEslUFipE3gdE5+fjXqrshrRTPIp2+26tLmP9PYU4C6VBKWIjwmoHB9LFaD
         544w==
X-Gm-Message-State: ACrzQf3rIOtvsCBXLtmdWwgY+vQnkcVFCNxXaTd5VirxlLNnLISxGhPg
        a68EeXqPVPrmyAu70mft0hpgpujaZPg=
X-Google-Smtp-Source: AMsMyM7MoIho8isLFbeLwe88870JuYPb44pmDBw7HQ47fZi2TtQxIHSeiDoGLpgSgxQhPsnEM5aPkA==
X-Received: by 2002:a05:6000:1882:b0:230:9046:122 with SMTP id a2-20020a056000188200b0023090460122mr9088349wri.49.1665579162186;
        Wed, 12 Oct 2022 05:52:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bv10-20020a0560001f0a00b00228fa832b7asm13637314wrb.52.2022.10.12.05.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:52:41 -0700 (PDT)
Message-Id: <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 12:52:27 +0000
Subject: [PATCH v5 00/12] Bundle URIs III: Parse and download from bundle lists
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the third series building the bundle URI feature. It is built on top
of ds/bundle-uri-clone, which introduced 'git clone --bundle-uri=' where is
a URI to a bundle file. This series adds the capability of downloading and
parsing a bundle list and then downloading the URIs in that list.

The core functionality of bundle lists is implemented by creating data
structures from a list of key-value pairs. These pairs can come from a
plain-text file in Git config format, but in the future, we will support the
list being supplied by packet lines over Git's protocol v2 in the
'bundle-uri' command (reserved for the next series).

The patches are organized in this way (updated for v4):

 1. Patch 1 is a cleanup from the previous part. This allows us to simplify
    our bundle list data structure slightly.

 2. Patches 2-3 create the bundle list data structures and the logic for
    populating the list from key-value pairs.

 3. Patches 4-5 teach Git to parse "key=value" lines to construct a bundle
    list. Add unit tests that ensure this logic constructs lists correctly.
    These patches are adapted from Ævar's RFC [1] and were previously seen
    in my combined RFC [2].

 4. Patch 6 teaches Git to parse Git config files into bundle lists.

 5. Patches 7-9 implement the ability to download a bundle list and
    recursively download the contained bundles (and possibly the bundle
    lists within). This is limited by a constant depth to avoid issues with
    cycles or otherwise incorrectly configured bundle lists. This also fixes
    a previous bug when running verify_bundle() multiple times in the same
    process, as it did not clear the PREREQ_MARK flag upon leaving (see
    patch 8).

 6. Patches 10-12 suppress unhelpful warnings from user visibility.

[1]
https://lore.kernel.org/git/RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com/

[2]
https://lore.kernel.org/git/pull.1234.git.1653072042.gitgitgadget@gmail.com/

At the end of this series, users can bootstrap clones using 'git clone
--bundle-uri= ' where points to a bundle list instead of a single bundle
file.

As outlined in the design document [1], the next steps after this are:

 1. Implement the protocol v2 verb, re-using the bundle list logic from (2).
    Use this to auto-discover bundle URIs during 'git clone' (behind a
    config option). [2]
 2. Implement the 'creationToken' heuristic, allowing incremental 'git
    fetch' commands to download a bundle list from a configured URI, and
    only download bundles that are new based on the creation token values.
    [3]

I have prepared some of this work as pull requests on my personal fork so
curious readers can look ahead to where we are going:

[3]
https://lore.kernel.org/git/pull.1248.v3.git.1658757188.gitgitgadget@gmail.com

[4] https://github.com/derrickstolee/git/pull/21

[5] https://github.com/derrickstolee/git/pull/22


Updates in v5
=============

 * The bug about verify_bundle() not working multile times in the same
   process is fixed without removing the revision walk. Instead, more flags
   needed to be removed as the method cleaned up after itself.


Updates in v4
=============

 * Properly updated the patch outline.

 * Jonathan Tan asked for more tests, and this revealed some interesting
   behaviors which I have now either fixed or made explicit:
   
   1. In "all" mode, we try to download and apply all bundles. Do not fail
      if a single bundle download fails.
   2. Previously, not all bundles were being applied, and this was noticed
      by the added checks for the refs/bundles/* refs at the end of the
      tests. This revealed the need for removing the reachability walk from
      verify_bundle() since the written refs/bundles/* refs were not being
      picked up by the loose ref cache. Since removing the reachability walk
      seemed like the faster (for users) option, I went that direction.
   3. While running those tests and examining the output carefully, I
      noticed several error messages related to missing prerequisites due to
      attempting unbundling in a random order. This doesn't appear in the
      later creationToken version, so I hadn't noticed it at the tip of my
      local work. These messages are removed with a new quiet mode for
      verify_bundle().


Updates in v3
=============

 * Fixed a comment about a return value of -1.
 * Fixed and tested scenario where early URIs fail in "any" mode and Git
   should try the rest of the list.
 * Instead of using 'success_count' and 'failure_count', use the iterator
   return value to terminate the "all" mode loop early.


Updates in v2
=============

Thank you to all of the voices who chimed in on the previous version. I'm
sorry it took so long for me to get a new version.

 * I've done a rather thorough overhaul to minimize how often later patches
   rewrite portions of earlier patches.

 * We no longer use a strbuf in struct remote_bundle_info. Instead, use a
   'char *' and only in the patch where it is first used.

 * The config documentation is more clearly indicating that the bundle.*
   section has no effect in the repository config (at the moment, which will
   change in the next series).

 * The bundle.version value is now parsed using git_parse_int().

 * The config key is now parsed using parse_config_key().

 * Commit messages clarify more about the context of the change in the
   bigger picture of the bundle URI effort.

 * Some printf()s are correctly changed to fprintf()s.

 * The test helper CLI is unified across the two modes. They both take a
   filename now.

 * The count of downloaded bundles is now only updated after a successful
   download, allowing the "any" mode to keep trying after a failure.

Thanks,

 * Stolee

Derrick Stolee (10):
  bundle-uri: use plain string in find_temp_filename()
  bundle-uri: create bundle_list struct and helpers
  bundle-uri: create base key-value pair parsing
  bundle-uri: parse bundle list in config format
  bundle-uri: limit recursion depth for bundle lists
  bundle: properly clear all revision flags
  bundle-uri: fetch a list of bundles
  bundle: add flags to verify_bundle()
  bundle-uri: quiet failed unbundlings
  bundle-uri: suppress stderr from remote-https

Ævar Arnfjörð Bjarmason (2):
  bundle-uri: create "key=value" line parsing
  bundle-uri: unit test "key=value" parsing

 Documentation/config.txt        |   2 +
 Documentation/config/bundle.txt |  24 ++
 Makefile                        |   1 +
 builtin/bundle.c                |   5 +-
 bundle-uri.c                    | 458 ++++++++++++++++++++++++++++++--
 bundle-uri.h                    |  93 +++++++
 bundle.c                        |  42 +--
 bundle.h                        |  15 +-
 config.c                        |   2 +-
 config.h                        |   1 +
 t/helper/test-bundle-uri.c      |  95 +++++++
 t/helper/test-tool.c            |   1 +
 t/helper/test-tool.h            |   1 +
 t/t5558-clone-bundle-uri.sh     | 275 +++++++++++++++++++
 t/t5750-bundle-uri-parse.sh     | 171 ++++++++++++
 t/test-lib-functions.sh         |  11 +
 transport.c                     |   2 +-
 17 files changed, 1156 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/config/bundle.txt
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100755 t/t5750-bundle-uri-parse.sh


base-commit: e21e663cd1942df29979d3e01f7eacb532727bb7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1333%2Fderrickstolee%2Fbundle-redo%2Flist-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1333/derrickstolee/bundle-redo/list-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1333

Range-diff vs v4:

  1:  48beccb0f5e =  1:  48beccb0f5e bundle-uri: use plain string in find_temp_filename()
  2:  f0c4457951c =  2:  f0c4457951c bundle-uri: create bundle_list struct and helpers
  3:  430e01cd2a4 =  3:  430e01cd2a4 bundle-uri: create base key-value pair parsing
  4:  cd915d57f3b =  4:  cd915d57f3b bundle-uri: create "key=value" line parsing
  5:  4d8cac67f66 =  5:  4d8cac67f66 bundle-uri: unit test "key=value" parsing
  6:  0ecae3a44b3 =  6:  0ecae3a44b3 bundle-uri: parse bundle list in config format
  7:  7e6b32313b0 =  7:  7e6b32313b0 bundle-uri: limit recursion depth for bundle lists
  -:  ----------- >  8:  8dc5a8e4e63 bundle: properly clear all revision flags
  9:  6b9c764c6b3 =  9:  51e9b8474fb bundle-uri: fetch a list of bundles
  8:  83f2cd893a4 ! 10:  fba3a4a117e bundle: add flags to verify_bundle(), skip walk
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    bundle: add flags to verify_bundle(), skip walk
     +    bundle: add flags to verify_bundle()
      
     -    The verify_bundle() method checks if a bundle can be applied to a given
     -    repository. This not only verifies that certain commits exist in the
     -    repository, but Git also checks that these commits are reachable.
     -
     -    This behavior dates back to the original git-bundle builtin written in
     -    2e0afafebd8 (Add git-bundle: move objects and references by archive,
     -    2007-02-22), but the message does not go into detail why the
     -    reachability check is important.
     -
     -    Since verify_bundle() is called from unbundle(), we need to add an
     -    option to pipe the flags through that method.
     -
     -    When unbundling from a list of bundles, Git will create refs that point
     -    to the tips of the latest bundle, which makes this reachability walk
     -    succeed, in theory. However, the loose refs cache does not get
     -    invalidated and hence the reachability walk fails. By disabling the
     -    reachability walk in the bundle URI code, we can get around this
     -    reachability check.
     +    The verify_bundle() method has a 'verbose' option, but we will want to
     +    extend this method to have more granular control over its output. First,
     +    replace this 'verbose' option with a new 'flags' option with a single
     +    possible value: VERIFY_BUNDLE_VERBOSE.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
      +	 * a reachable ref pointing to the new tips, which will reach
      +	 * the prerequisite commits.
      +	 */
     -+	if ((result = unbundle(r, &header, bundle_fd, NULL,
     -+			       VERIFY_BUNDLE_SKIP_REACHABLE)))
     ++	if ((result = unbundle(r, &header, bundle_fd, NULL, 0)))
       		return 1;
       
       	/*
     @@ bundle.c: static int list_refs(struct string_list *r, int argc, const char **arg
       	/*
       	 * Do fast check, then if any prereqs are missing then go line by line
      @@ bundle.c: int verify_bundle(struct repository *r,
     - 			error("%s", message);
       		error("%s %s", oid_to_hex(oid), name);
       	}
     --	if (revs.pending.nr != p->nr)
     -+	if (revs.pending.nr != p->nr ||
     -+	    (flags & VERIFY_BUNDLE_SKIP_REACHABLE))
     - 		goto cleanup;
     - 	req_nr = revs.pending.nr;
     - 	setup_revisions(2, argv, &revs, NULL);
     -@@ bundle.c: int verify_bundle(struct repository *r,
     - 			clear_commit_marks(commit, ALL_REV_FLAGS);
     - 	}
       
      -	if (verbose) {
      +	if (flags & VERIFY_BUNDLE_VERBOSE) {
     @@ bundle.h: int read_bundle_header_fd(int fd, struct bundle_header *header,
      +
      +enum verify_bundle_flags {
      +	VERIFY_BUNDLE_VERBOSE = (1 << 0),
     -+	VERIFY_BUNDLE_SKIP_REACHABLE = (1 << 1)
      +};
      +
      +int verify_bundle(struct repository *r, struct bundle_header *header,
 10:  1cae3096624 ! 11:  2e0bfa834f1 bundle-uri: quiet failed unbundlings
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     + ## builtin/bundle.c ##
     +@@ builtin/bundle.c: static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
     + 	}
     + 	close(bundle_fd);
     + 	if (verify_bundle(the_repository, &header,
     +-			  quiet ? 0 : VERIFY_BUNDLE_VERBOSE)) {
     ++			  quiet ? VERIFY_BUNDLE_QUIET : VERIFY_BUNDLE_VERBOSE)) {
     + 		ret = 1;
     + 		goto cleanup;
     + 	}
     +
       ## bundle-uri.c ##
      @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *file)
     + 	 * a reachable ref pointing to the new tips, which will reach
       	 * the prerequisite commits.
       	 */
     - 	if ((result = unbundle(r, &header, bundle_fd, NULL,
     --			       VERIFY_BUNDLE_SKIP_REACHABLE)))
     -+			       VERIFY_BUNDLE_SKIP_REACHABLE | VERIFY_BUNDLE_QUIET)))
     +-	if ((result = unbundle(r, &header, bundle_fd, NULL, 0)))
     ++	if ((result = unbundle(r, &header, bundle_fd, NULL,
     ++			       VERIFY_BUNDLE_QUIET)))
       		return 1;
       
       	/*
     @@ bundle.h: int create_bundle(struct repository *r, const char *path,
       
       enum verify_bundle_flags {
       	VERIFY_BUNDLE_VERBOSE = (1 << 0),
     --	VERIFY_BUNDLE_SKIP_REACHABLE = (1 << 1)
     -+	VERIFY_BUNDLE_SKIP_REACHABLE = (1 << 1),
     -+	VERIFY_BUNDLE_QUIET = (1 << 2),
     ++	VERIFY_BUNDLE_QUIET = (1 << 1),
       };
       
       int verify_bundle(struct repository *r, struct bundle_header *header,
 11:  52a575f8a69 = 12:  5729ff2af4b bundle-uri: suppress stderr from remote-https

-- 
gitgitgadget
