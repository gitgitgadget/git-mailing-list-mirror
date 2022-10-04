Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7705CC4332F
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 12:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJDMe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 08:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJDMe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 08:34:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAA2564DB
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 05:34:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l8so8789792wmi.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=qNMI2dxMTQ8jz9NQuQr0AiIkKp0bij6UVWUHvtKk3pg=;
        b=ez0wrFslyTMXa/T1lPd1UIQ8sEDN0/qMUaOgLjKEIsq00xwQ3Fzv11ZEpka+cDY7IE
         bepLJLf6ZreqMb/h28NsFT3ORKCpVfLFXaVFfiCsGTrl/2sPzV37hw8iBw56YcMSmqgI
         5JNPaE48cwFTXFyRoC6AxwEIy7zAW9DBLQy3mLA3jD2J+9wLScyCkvMV2P5tomRvKmRE
         dYIFH/LwhQoDjfnTahufByu+ZPzitapgluvsYY4740aLnqDIFQ4I5qoasHmpdHsKlp0j
         wpSr4c1fV5G8tdx7a1eppe5b4GjWpy+yMZIgnewfzG2RQFbG/GAE5EsTNLgkCvFnJLmW
         I7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qNMI2dxMTQ8jz9NQuQr0AiIkKp0bij6UVWUHvtKk3pg=;
        b=4keO/uxxnSkuohi6vdh0+ydcItYyaLu/HOc1+3fHRUlafj+WyVz3hNbwW8W4CE3d+b
         wiwqkRZ5UzexBj90C42Brq/8aHgjoCHW5cqm8ZOATja6ErGRmm19Ly+TlgYFkwgTH14A
         nw1oDu65ERwZztDYPDERCS191RvW83rVQpMBbzAG5Yxn1KxxOAb2h8TPUTDB3TuVU6I5
         7u1b8d1C33DTnNW5TNQjMXdSIWHkJcX7VHLYXD8U98DhXWw6YqDujh/9FRbu04V2cOYC
         QOsZ7AdrTwloWz2OEIV7Bf/dQd5G3MOW1ndo7CWUDyiLZhJqZqN2/8b+40g8xopKrxBz
         yVMA==
X-Gm-Message-State: ACrzQf0yY9c2PitZNG99DV+CauSGIDMdcYw47MuBIS2pvkfrM4H+o1D3
        qx1z8TLueOf8zDWv2qAxgyHyG5pso2U=
X-Google-Smtp-Source: AMsMyM53+VwdHbc0FZgGiF8GG1S3wIIT5qLIcqPbDHWtCNtP6+X4Lmoj81FFo+zPDBms6XUWnzZv5A==
X-Received: by 2002:a05:600c:474c:b0:3b4:cbca:5677 with SMTP id w12-20020a05600c474c00b003b4cbca5677mr9685602wmo.76.1664886862805;
        Tue, 04 Oct 2022 05:34:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d5606000000b00228d52b935asm12828003wrv.71.2022.10.04.05.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 05:34:22 -0700 (PDT)
Message-Id: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
References: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 12:34:11 +0000
Subject: [PATCH v3 0/9] Bundle URIs III: Parse and download from bundle lists
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

The patches are organized in this way:

 1. Patches 1-2 are cleanups from the previous part. The first was
    recommended by Teng Long and the second allows us to simplify our bundle
    list data structure slightly.

 2. Patches 3-4 create the bundle list data structures and the logic for
    populating the list from key-value pairs.

 3. Patches 5-6 teach Git to parse "key=value" lines to construct a bundle
    list. Add unit tests that ensure this logic constructs lists correctly.
    These patches are adapted from Ævar's RFC [1] and were previously seen
    in my combined RFC [2].

 4. Patch 7 teaches Git to parse Git config files into bundle lists.

 5. Patches 8-9 implement the ability to download a bundle list and
    recursively download the contained bundles (and possibly the bundle
    lists within). This is limited by a constant depth to avoid issues with
    cycles or otherwise incorrectly configured bundle lists.

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

Derrick Stolee (7):
  bundle-uri: use plain string in find_temp_filename()
  bundle-uri: create bundle_list struct and helpers
  bundle-uri: create base key-value pair parsing
  bundle-uri: parse bundle list in config format
  bundle-uri: limit recursion depth for bundle lists
  bundle-uri: fetch a list of bundles
  bundle-uri: suppress stderr from remote-https

Ævar Arnfjörð Bjarmason (2):
  bundle-uri: create "key=value" line parsing
  bundle-uri: unit test "key=value" parsing

 Documentation/config.txt        |   2 +
 Documentation/config/bundle.txt |  24 ++
 Makefile                        |   1 +
 bundle-uri.c                    | 449 ++++++++++++++++++++++++++++++--
 bundle-uri.h                    |  93 +++++++
 config.c                        |   2 +-
 config.h                        |   1 +
 t/helper/test-bundle-uri.c      |  95 +++++++
 t/helper/test-tool.c            |   1 +
 t/helper/test-tool.h            |   1 +
 t/t5558-clone-bundle-uri.sh     | 143 ++++++++++
 t/t5750-bundle-uri-parse.sh     | 171 ++++++++++++
 t/test-lib-functions.sh         |  11 +
 13 files changed, 976 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/config/bundle.txt
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100755 t/t5750-bundle-uri-parse.sh


base-commit: e21e663cd1942df29979d3e01f7eacb532727bb7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1333%2Fderrickstolee%2Fbundle-redo%2Flist-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1333/derrickstolee/bundle-redo/list-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1333

Range-diff vs v2:

  1:  2ca431e6c37 <  -:  ----------- bundle-uri: short-circuit capability parsing
  2:  ee6c4b824c2 =  1:  48beccb0f5e bundle-uri: use plain string in find_temp_filename()
  3:  d9812440594 =  2:  f0c4457951c bundle-uri: create bundle_list struct and helpers
  4:  70daef66833 !  3:  430e01cd2a4 bundle-uri: create base key-value pair parsing
     @@ bundle-uri.c: int for_all_bundles_in_list(struct bundle_list *list,
       
      +/**
      + * Given a key-value pair, update the state of the given bundle list.
     -+ * Returns 0 if the key-value pair is understood. Returns 1 if the key
     ++ * Returns 0 if the key-value pair is understood. Returns -1 if the key
      + * is not understood or the value is malformed.
      + */
      +MAYBE_UNUSED
  5:  4df3f834029 !  4:  cd915d57f3b bundle-uri: create "key=value" line parsing
     @@ Commit message
      
       ## bundle-uri.c ##
      @@ bundle-uri.c: int for_all_bundles_in_list(struct bundle_list *list,
     -  * Returns 0 if the key-value pair is understood. Returns 1 if the key
     +  * Returns 0 if the key-value pair is understood. Returns -1 if the key
        * is not understood or the value is malformed.
        */
      -MAYBE_UNUSED
  6:  91c5b58f011 !  5:  4d8cac67f66 bundle-uri: unit test "key=value" parsing
     @@ bundle-uri.c: int for_all_bundles_in_list(struct bundle_list *list,
      +
       /**
        * Given a key-value pair, update the state of the given bundle list.
     -  * Returns 0 if the key-value pair is understood. Returns 1 if the key
     +  * Returns 0 if the key-value pair is understood. Returns -1 if the key
      
       ## bundle-uri.h ##
      @@ bundle-uri.h: int for_all_bundles_in_list(struct bundle_list *list,
  7:  1492b8f5ef0 =  6:  0ecae3a44b3 bundle-uri: parse bundle list in config format
  8:  b5d570082fa =  7:  7e6b32313b0 bundle-uri: limit recursion depth for bundle lists
  9:  a6ab8f7c699 !  8:  46799648b4c bundle-uri: fetch a list of bundles
     @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
      +	 */
      +	if (!res)
      +		ctx->count++;
     -+	return res;
     ++
     ++	/*
     ++	 * In BUNDLE_MODE_ANY, we need to continue iterating until we find
     ++	 * a bundle that works, so do not signal a failure here.
     ++	 */
     ++	return ctx->mode == BUNDLE_MODE_ANY ? 0 : res;
      +}
      +
      +static int download_bundle_list(struct repository *r,
     @@ bundle-uri.c: static int fetch_bundle_uri_internal(struct repository *r,
       	return result;
       }
       
     -+struct attempt_unbundle_context {
     -+	struct repository *r;
     -+	int success_count;
     -+	int failure_count;
     -+};
     -+
     ++/**
     ++ * This loop iterator breaks the loop with nonzero return code on the
     ++ * first successful unbundling of a bundle.
     ++ */
      +static int attempt_unbundle(struct remote_bundle_info *info, void *data)
      +{
     -+	struct attempt_unbundle_context *ctx = data;
     ++	struct repository *r = data;
      +
     -+	if (info->unbundled || !unbundle_from_file(ctx->r, info->file)) {
     -+		ctx->success_count++;
     ++	if (!info->file || info->unbundled)
     ++		return 0;
     ++
     ++	if (!unbundle_from_file(r, info->file)) {
      +		info->unbundled = 1;
     -+	} else {
     -+		ctx->failure_count++;
     ++		return 1;
      +	}
      +
      +	return 0;
     @@ bundle-uri.c: static int fetch_bundle_uri_internal(struct repository *r,
      +static int unbundle_all_bundles(struct repository *r,
      +				struct bundle_list *list)
      +{
     -+	int last_success_count = -1;
     -+	struct attempt_unbundle_context ctx = {
     -+		.r = r,
     -+	};
     -+
      +	/*
      +	 * Iterate through all bundles looking for ones that can
      +	 * successfully unbundle. If any succeed, then perhaps another
      +	 * will succeed in the next attempt.
     ++	 *
     ++	 * Keep in mind that a non-zero result for the loop here means
     ++	 * the loop terminated early on a successful unbundling, which
     ++	 * signals that we can try again.
      +	 */
     -+	while (last_success_count < ctx.success_count) {
     -+		last_success_count = ctx.success_count;
     -+
     -+		ctx.success_count = 0;
     -+		ctx.failure_count = 0;
     -+		for_all_bundles_in_list(list, attempt_unbundle, &ctx);
     -+	}
     -+
     -+	if (ctx.success_count)
     -+		git_config_set_multivar_gently("log.excludedecoration",
     -+						"refs/bundle/",
     -+						"refs/bundle/",
     -+						CONFIG_FLAGS_FIXED_VALUE |
     -+						CONFIG_FLAGS_MULTI_REPLACE);
     -+
     -+	if (ctx.failure_count)
     -+		warning(_("failed to unbundle %d bundles"),
     -+			ctx.failure_count);
     ++	while (for_all_bundles_in_list(list, attempt_unbundle, r)) ;
      +
      +	return 0;
      +}
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with file:// bundle' '
      +		uri = file://$(pwd)/clone-from/bundle-4.bundle
      +	EOF
      +
     -+	git clone --bundle-uri="file://$(pwd)/bundle-list" . clone-list-file &&
     -+	for oid in $(git -C clone-from for-each-ref --format="%(objectname)")
     -+	do
     -+		git -C clone-list-file rev-parse $oid || return 1
     -+	done
     ++	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-list-file &&
     ++	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     ++	git -C clone-list-file cat-file --batch-check <oids
      +'
      +
     ++test_expect_success 'clone bundle list (file, any mode)' '
     ++	cat >bundle-list <<-EOF &&
     ++	[bundle]
     ++		version = 1
     ++		mode = any
     ++
     ++	# Does not exist. Should be skipped.
     ++	[bundle "bundle-0"]
     ++		uri = $HTTPD_URL/bundle-0.bundle
     ++
     ++	[bundle "bundle-1"]
     ++		uri = $HTTPD_URL/bundle-1.bundle
     ++
     ++	# Does not exist. Should be skipped.
     ++	[bundle "bundle-5"]
     ++		uri = $HTTPD_URL/bundle-5.bundle
     ++	EOF
     ++
     ++	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-any-file &&
     ++	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     ++	git -C clone-any-file cat-file --batch-check <oids
     ++'
      +
       #########################################################################
       # HTTP tests begin here
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone HTTP bundle' '
      +		uri = $HTTPD_URL/bundle-4.bundle
      +	EOF
      +
     -+	git clone --bundle-uri="$HTTPD_URL/bundle-list" . clone-list-http &&
     -+	for oid in $(git -C clone-from for-each-ref --format="%(objectname)")
     -+	do
     -+		git -C clone-list-http rev-parse $oid || return 1
     -+	done
     ++	git clone --bundle-uri="$HTTPD_URL/bundle-list" clone-from clone-list-http &&
     ++	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     ++	git -C clone-list-http cat-file --batch-check <oids
     ++'
     ++
     ++test_expect_success 'clone bundle list (HTTP, any mode)' '
     ++	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
     ++	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
     ++	[bundle]
     ++		version = 1
     ++		mode = any
     ++
     ++	# Does not exist. Should be skipped.
     ++	[bundle "bundle-0"]
     ++		uri = $HTTPD_URL/bundle-0.bundle
     ++
     ++	[bundle "bundle-1"]
     ++		uri = $HTTPD_URL/bundle-1.bundle
     ++
     ++	# Does not exist. Should be skipped.
     ++	[bundle "bundle-5"]
     ++		uri = $HTTPD_URL/bundle-5.bundle
     ++	EOF
     ++
     ++	git clone --bundle-uri="$HTTPD_URL/bundle-list" clone-from clone-any-http &&
     ++	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
     ++	git -C clone-any-http cat-file --batch-check <oids
      +'
      +
       # Do not add tests here unless they use the HTTP server, as they will
  -:  ----------- >  9:  d84544859e4 bundle-uri: suppress stderr from remote-https

-- 
gitgitgadget
