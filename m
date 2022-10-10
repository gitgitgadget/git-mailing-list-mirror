Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D30AC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJJQE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJJQEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:04:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B606DAE6
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a3so17773697wrt.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ii8BFOLHHzSwwZYr3pME3vNkOebH+ksMuYqnY3MjhmA=;
        b=MFblgIqCPjPnz7uc7fW2mOoNKxoXvtSGH7FZOJkqXgmnX3rvkdIzt3kRa0BWemzngS
         Z71rxD3wmfz+jnkxoUhSwg3g1+hhWZ8K0ozX3Q8I5iyhxHgyFZsk54YKUfqr+pDFNFhe
         k2JBZePIjFbnu1WDlt8Let0h19XDpIh9GpD7Q+r/1q+WTqHDYk+/BfIoxaBlSuhh52jy
         eAvTrI1uQCF1pRdHbOhU3nzuVK0dkezXiwLJpOoMqdu+l4irROHOSW2/DDeS/OA1Vxnj
         08p7im+GRBoVXR8en+e1b+EQtAFcVbZtiJvl4vBZPRVOn0bYY1m2qKurtD+mjEt9eMW3
         BmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ii8BFOLHHzSwwZYr3pME3vNkOebH+ksMuYqnY3MjhmA=;
        b=1XYJJ7jwJIa1Cb0HDDFOMU6TgnV/p4QHCAusoptkjZm0a+gYpcWlrsCaHwX6mQWoea
         uohbGaruIcAQt7/yX4ozZx/gLAa23T8R6d7fCf/y5BmClYGn3XP2HNWTvu1rccCQAZu2
         cdgmmxaw5lL5YFHnbp7T72aCoeVl7WTvlmmiupIRZn7GJXiW/VmvPNNmUg2OJ3cLVMbx
         T6yg4us4lBR+Xm1Me+KpnTEKzLQyrxIDR6CRCK4DzpprRJfTI4uY+JyccJxf6+ocIMHD
         ARJLJG9hnk9nf6coSw0VkZ+hJrTcXSX7KQdbnDKpSlw63odHSSgGAMz9g7Dtd4NyOIQJ
         P0aA==
X-Gm-Message-State: ACrzQf2ecKTV+EagSTuV+vMhXpOQWcjWe15gLKlQD5kKe+VrPQMsBXww
        2fWKxDrHno7Sq9Gf3BMoumv45l9Tcdg=
X-Google-Smtp-Source: AMsMyM4SDRi8dT4PxafZo09oYddJ9AqKfgHmB2aMJcH8a6E7RSGdbJKlHNjj5KTHAXkbidcqGXhMtQ==
X-Received: by 2002:adf:e8cb:0:b0:22c:d929:e82d with SMTP id k11-20020adfe8cb000000b0022cd929e82dmr11935159wrn.224.1665417860845;
        Mon, 10 Oct 2022 09:04:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c154b00b003a3442f1229sm18194977wmg.29.2022.10.10.09.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:04:20 -0700 (PDT)
Message-Id: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
References: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 16:04:08 +0000
Subject: [PATCH v4 00/11] Bundle URIs III: Parse and download from bundle lists
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
    cycles or otherwise incorrectly configured bundle lists. We also need to
    be careful when verifying the bundles due to ref caches, so some flags
    are added to unbundle() and verify_bundle().

 6. Patches 10-11 suppress unhelpful warnings from user visibility.

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

Derrick Stolee (9):
  bundle-uri: use plain string in find_temp_filename()
  bundle-uri: create bundle_list struct and helpers
  bundle-uri: create base key-value pair parsing
  bundle-uri: parse bundle list in config format
  bundle-uri: limit recursion depth for bundle lists
  bundle: add flags to verify_bundle(), skip walk
  bundle-uri: fetch a list of bundles
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
 bundle.c                        |  22 +-
 bundle.h                        |  16 +-
 config.c                        |   2 +-
 config.h                        |   1 +
 t/helper/test-bundle-uri.c      |  95 +++++++
 t/helper/test-tool.c            |   1 +
 t/helper/test-tool.h            |   1 +
 t/t5558-clone-bundle-uri.sh     | 275 +++++++++++++++++++
 t/t5750-bundle-uri-parse.sh     | 171 ++++++++++++
 t/test-lib-functions.sh         |  11 +
 transport.c                     |   2 +-
 17 files changed, 1149 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/config/bundle.txt
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100755 t/t5750-bundle-uri-parse.sh


base-commit: e21e663cd1942df29979d3e01f7eacb532727bb7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1333%2Fderrickstolee%2Fbundle-redo%2Flist-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1333/derrickstolee/bundle-redo/list-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1333

Range-diff vs v3:

  1:  48beccb0f5e =  1:  48beccb0f5e bundle-uri: use plain string in find_temp_filename()
  2:  f0c4457951c =  2:  f0c4457951c bundle-uri: create bundle_list struct and helpers
  3:  430e01cd2a4 =  3:  430e01cd2a4 bundle-uri: create base key-value pair parsing
  4:  cd915d57f3b =  4:  cd915d57f3b bundle-uri: create "key=value" line parsing
  5:  4d8cac67f66 =  5:  4d8cac67f66 bundle-uri: unit test "key=value" parsing
  6:  0ecae3a44b3 =  6:  0ecae3a44b3 bundle-uri: parse bundle list in config format
  7:  7e6b32313b0 =  7:  7e6b32313b0 bundle-uri: limit recursion depth for bundle lists
  -:  ----------- >  8:  83f2cd893a4 bundle: add flags to verify_bundle(), skip walk
  8:  46799648b4c !  9:  6b9c764c6b3 bundle-uri: fetch a list of bundles
     @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
      +		ctx->count++;
      +
      +	/*
     -+	 * In BUNDLE_MODE_ANY, we need to continue iterating until we find
     -+	 * a bundle that works, so do not signal a failure here.
     ++	 * To be opportunistic as possible, we continue iterating and
     ++	 * download as many bundles as we can, so we can apply the ones
     ++	 * that work, even in BUNDLE_MODE_ALL mode.
      +	 */
     -+	return ctx->mode == BUNDLE_MODE_ANY ? 0 : res;
     ++	return 0;
      +}
      +
      +static int download_bundle_list(struct repository *r,
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with file:// bundle' '
      +
      +	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-list-file &&
      +	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     -+	git -C clone-list-file cat-file --batch-check <oids
     ++	git -C clone-list-file cat-file --batch-check <oids &&
     ++
     ++	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
     ++	grep "refs/bundles/" refs >actual &&
     ++	cat >expect <<-\EOF &&
     ++	refs/bundles/base
     ++	refs/bundles/left
     ++	refs/bundles/merge
     ++	refs/bundles/right
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'clone bundle list (file, all mode, some failures)' '
     ++	cat >bundle-list <<-EOF &&
     ++	[bundle]
     ++		version = 1
     ++		mode = all
     ++
     ++	# Does not exist. Should be skipped.
     ++	[bundle "bundle-0"]
     ++		uri = file://$(pwd)/clone-from/bundle-0.bundle
     ++
     ++	[bundle "bundle-1"]
     ++		uri = file://$(pwd)/clone-from/bundle-1.bundle
     ++
     ++	[bundle "bundle-2"]
     ++		uri = file://$(pwd)/clone-from/bundle-2.bundle
     ++
     ++	# No bundle-3 means bundle-4 will not apply.
     ++
     ++	[bundle "bundle-4"]
     ++		uri = file://$(pwd)/clone-from/bundle-4.bundle
     ++
     ++	# Does not exist. Should be skipped.
     ++	[bundle "bundle-5"]
     ++		uri = file://$(pwd)/clone-from/bundle-5.bundle
     ++	EOF
     ++
     ++	GIT_TRACE2_PERF=1 \
     ++	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-all-some &&
     ++	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     ++	git -C clone-all-some cat-file --batch-check <oids &&
     ++
     ++	git -C clone-all-some for-each-ref --format="%(refname)" >refs &&
     ++	grep "refs/bundles/" refs >actual &&
     ++	cat >expect <<-\EOF &&
     ++	refs/bundles/base
     ++	refs/bundles/left
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'clone bundle list (file, all mode, all failures)' '
     ++	cat >bundle-list <<-EOF &&
     ++	[bundle]
     ++		version = 1
     ++		mode = all
     ++
     ++	# Does not exist. Should be skipped.
     ++	[bundle "bundle-0"]
     ++		uri = file://$(pwd)/clone-from/bundle-0.bundle
     ++
     ++	# Does not exist. Should be skipped.
     ++	[bundle "bundle-5"]
     ++		uri = file://$(pwd)/clone-from/bundle-5.bundle
     ++	EOF
     ++
     ++	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-all-fail &&
     ++	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     ++	git -C clone-all-fail cat-file --batch-check <oids &&
     ++
     ++	git -C clone-all-fail for-each-ref --format="%(refname)" >refs &&
     ++	! grep "refs/bundles/" refs
      +'
      +
      +test_expect_success 'clone bundle list (file, any mode)' '
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with file:// bundle' '
      +
      +	# Does not exist. Should be skipped.
      +	[bundle "bundle-0"]
     -+		uri = $HTTPD_URL/bundle-0.bundle
     ++		uri = file://$(pwd)/clone-from/bundle-0.bundle
      +
      +	[bundle "bundle-1"]
     -+		uri = $HTTPD_URL/bundle-1.bundle
     ++		uri = file://$(pwd)/clone-from/bundle-1.bundle
      +
      +	# Does not exist. Should be skipped.
      +	[bundle "bundle-5"]
     -+		uri = $HTTPD_URL/bundle-5.bundle
     ++		uri = file://$(pwd)/clone-from/bundle-5.bundle
      +	EOF
      +
      +	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-any-file &&
      +	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     -+	git -C clone-any-file cat-file --batch-check <oids
     ++	git -C clone-any-file cat-file --batch-check <oids &&
     ++
     ++	git -C clone-any-file for-each-ref --format="%(refname)" >refs &&
     ++	grep "refs/bundles/" refs >actual &&
     ++	cat >expect <<-\EOF &&
     ++	refs/bundles/base
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'clone bundle list (file, any mode, all failures)' '
     ++	cat >bundle-list <<-EOF &&
     ++	[bundle]
     ++		version = 1
     ++		mode = any
     ++
     ++	# Does not exist. Should be skipped.
     ++	[bundle "bundle-0"]
     ++		uri = $HTTPD_URL/bundle-0.bundle
     ++
     ++	# Does not exist. Should be skipped.
     ++	[bundle "bundle-5"]
     ++		uri = $HTTPD_URL/bundle-5.bundle
     ++	EOF
     ++
     ++	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-any-fail &&
     ++	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     ++	git -C clone-any-fail cat-file --batch-check <oids &&
     ++
     ++	git -C clone-any-fail for-each-ref --format="%(refname)" >refs &&
     ++	! grep "refs/bundles/" refs
      +'
      +
       #########################################################################
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone HTTP bundle' '
      +
      +	git clone --bundle-uri="$HTTPD_URL/bundle-list" clone-from clone-any-http &&
      +	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     -+	git -C clone-any-http cat-file --batch-check <oids
     ++	git -C clone-any-http cat-file --batch-check <oids &&
     ++
     ++	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
     ++	grep "refs/bundles/" refs >actual &&
     ++	cat >expect <<-\EOF &&
     ++	refs/bundles/base
     ++	refs/bundles/left
     ++	refs/bundles/merge
     ++	refs/bundles/right
     ++	EOF
     ++	test_cmp expect actual
      +'
      +
       # Do not add tests here unless they use the HTTP server, as they will
  -:  ----------- > 10:  1cae3096624 bundle-uri: quiet failed unbundlings
  9:  d84544859e4 ! 11:  52a575f8a69 bundle-uri: suppress stderr from remote-https
     @@ bundle-uri.c: static int download_https_uri_to_file(const char *file, const char
       
      
       ## t/t5558-clone-bundle-uri.sh ##
     -@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (file, any mode)' '
     +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (file, all mode, some failures)' '
     + 	git clone --bundle-uri="file://$(pwd)/bundle-list" \
     + 		clone-from clone-all-some 2>err &&
     + 	! grep "Repository lacks these prerequisite commits" err &&
     ++	! grep "fatal" err &&
     ++	grep "warning: failed to download bundle from URI" err &&
     + 
     + 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     + 	git -C clone-all-some cat-file --batch-check <oids &&
     +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (file, all mode, all failures)' '
     + 	git clone --bundle-uri="file://$(pwd)/bundle-list" \
     + 		clone-from clone-all-fail 2>err &&
     + 	! grep "Repository lacks these prerequisite commits" err &&
     ++	! grep "fatal" err &&
     ++	grep "warning: failed to download bundle from URI" err &&
     + 
     + 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     + 	git -C clone-all-fail cat-file --batch-check <oids &&
     +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (file, any mode, all failures)' '
       		uri = $HTTPD_URL/bundle-5.bundle
       	EOF
       
     --	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-any-file &&
     +-	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-any-fail &&
      +	git clone --bundle-uri="file://$(pwd)/bundle-list" \
     -+		clone-from clone-any-file 2>err &&
     ++		clone-from clone-any-fail 2>err &&
      +	! grep "fatal" err &&
      +	grep "warning: failed to download bundle from URI" err &&
      +
       	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     - 	git -C clone-any-file cat-file --batch-check <oids
     - '
     + 	git -C clone-any-fail cat-file --batch-check <oids &&
     + 
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (HTTP, any mode)' '
       		uri = $HTTPD_URL/bundle-5.bundle
       	EOF
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (HTTP, any m
      +	grep "warning: failed to download bundle from URI" err &&
      +
       	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     - 	git -C clone-any-http cat-file --batch-check <oids
     - '
     + 	git -C clone-any-http cat-file --batch-check <oids &&
     + 

-- 
gitgitgadget
