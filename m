Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77153C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 15:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbiLVPOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiLVPOY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 10:14:24 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE79D26ADB
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h7so1957473wrs.6
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBEFyH2Iusah1casB3AcsyqUjpN8rJUG9wXCMhYTcnM=;
        b=H638P3qUDZaxSoSmhowltR6AmwQMyvyx8xL98IA54s29KZeWPf04K9TNdItlXwGYh/
         geXbfQx6QcHoBzupeGjJKQwdwzxnIsY9ESIcRJjmGaE/YdG6x7TC5oVPBZ+tU3SiLx43
         UQ+tZSl67+0xSPC06U+K3eatYx5wXdpWP6GobHHd4eSgsLMVfB6zZOhrdYJRL32sP0Hs
         oM2TeHbey1ptaPIPlJ7HPWhTqTzWf3y1TUgCvD3egH5eD6t0Cd/R2GkAgAK6n7yV2TFk
         ltcNKw5o/WXdsChkpPYAJTpexFBiCgHMzVR56hejXhZINhuSK+bQMfiRx3oHX71IVTS+
         N3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBEFyH2Iusah1casB3AcsyqUjpN8rJUG9wXCMhYTcnM=;
        b=1RjQ1+qU23iSkboBP50/0Hmw4vOwzOLiGTtvBy/3rST1Ul8b+WDEgfQAM5iytnxsz3
         Ot9hba3ry7Qu5tzHn1spSyoF8ksCx2viE+im+Vgm864S0BV9kzSEcecXiEpaLN+oGnEU
         DXOQCTAI45N58UTdGuXucHQNB6+ZdBkx3C5IYk6MipDr2sl9R2DU27cVg0kcQFoA//AM
         MMlc3tZR4Ie0ugM2/rsbAVAwactL0ARMw/9DDaaxfer5cDtINk3o8YjT1XXmVPKMyoN1
         rpxQ2kKe5BGKBx2T4UEo4u8JTtESKrSvoQqhSC35w8yUKR8hg238RkP/CWI3el7q+PPn
         xUlw==
X-Gm-Message-State: AFqh2kpOEdPIk6PjVcQi8t4Zb1Ul040LG/ysA7RAGLl1qy2gqFWvV6lE
        KNVxnMzcmZgC19Xi37JvFqtcxlIed+w=
X-Google-Smtp-Source: AMrXdXsICtXyliHqMvglYFZnvBnZNZY5xGOYl8WmuK6JbP1vxWzI6Cs3iarrX+JpVKEeE4gP3vU8eA==
X-Received: by 2002:a5d:470a:0:b0:242:22e4:998f with SMTP id y10-20020a5d470a000000b0024222e4998fmr3584442wrq.55.1671722060039;
        Thu, 22 Dec 2022 07:14:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4-20020a5d4f04000000b002365cd93d05sm747775wru.102.2022.12.22.07.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:14:19 -0800 (PST)
Message-Id: <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 15:14:06 +0000
Subject: [PATCH v4 00/11] Bundle URIs IV: advertise over protocol v2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on the recent master batch that included ds/bundle-uri-....

Now that git clone --bundle-uri can download a bundle list from a plaintex
file in config format, we can use the same set of key-value pairs to
advertise a bundle list over protocol v2. At the end of this series:

 1. A server can advertise bundles when uploadPack.advertiseBundleURIs is
    enabled. The bundle list comes from the server's local config,
    specifically the bundle.* namespace.
 2. A client can notice a server's bundle-uri advertisement and request the
    bundle list if transfer.bundleURI is enabled. The bundles are downloaded
    as if the list was advertised from the --bundle-uri option.

Many patches in this series were adapted from Ævar's v2 RFC [1]. He is
retained as author and I added myself as co-author only if the modifications
were significant.

[1]
https://lore.kernel.org/git/RFC-patch-v2-01.13-2fc87ce092b-20220311T155841Z-avarab@gmail.com/

 * Patches 1-7 are mostly taken from [1], again with mostly minor updates.
   The one major difference is the packet line format being a single
   key=value format instead of a sequence of pairs. (In v3, these commits
   are significantly reorganized from [1].)

 * Patches 8-11 finish off the ability for the client to notice the
   capability, request the values, and download bundles before continuing
   with the rest of the download.

One thing that is not handled here but could be handled in a future change
is to disconnect from the origin Git server while downloading the bundle
URIs, then reconnecting afterwards. This does not make any difference for
HTTPS, but SSH may benefit from the reduced connection time. The git clone
--bundle-uri option did not suffer from this because the bundles are
downloaded before the server connection begins.

After this series, there is one more before the original scope of the plan
is complete: using creation tokens as a heuristic. See [2] for the RFC
version of those patches.

[2] https://github.com/derrickstolee/git/pull/22


Updates in v4
=============

This version includes squashed-in versions of the fixups that were
previously known as ds/bundle-uri-4-fixup.

 * Some unused parameters are now marked with UNUSED, since we are
   introducing those parameters for the first time. In one case an unused
   parameter should have been used in repo_config_...() instead of
   git_config_...().
 * The GIT_TEST_BUNDLE_URI environment variable is removed in favor of the
   transfer.bundleURI config option in all cases.
 * A stale commit message is fixed to no longer refer to a rename that was
   split into a different commit as part of v3.
 * The documentation comment for fetch_bundle_list() explicitly defines a
   non-zero return value as an error.


Updates in v3
=============

Most of these updates are due to Victoria's very thorough review. Thanks!

 * What was patch 2 was split to be better understood.
 * The new patch 2 is only the new test script infrastructure for testing
   whether or not the server provides the bundle-uri capability. It is
   extended with other more complicated examples in later patches. The name
   was rewritten from lib-t5730-*.sh to lib-bundle-uri-protocol.sh and the
   variable names are renamed with the BUNDLE_URI_ prefix.
 * The new patch 3 performs the basic client interaction with the
   'bundle-uri' command, while still not being fully wired up on the server
   side. The tests do check that the client requests the bundle-uri command
   after seeing it in the server's capabilities. One important difference
   from earlier is that the check for server_supports_v2() was moved into
   the get_bundle_uri() method (underneath the vtable) because we need to
   check the handshake before calling that method. It makes most sense to
   put the handshake call there, so do it from the start.
 * Patch 4 carefully tests how the transfer.bundleURI config blocks the
   client-side request of the bundle-uri command. Later tests will use the
   GIT_TEST_BUNDLE_URI environment variable instead.
 * The new Patch 5 renames got_remote_heads to finished_handshake in 'struct
   git_transport_data' and that's it. That new value is then used in patch 6
   to indicate if we need to request the handshake in the bundle URI logic.
 * Patch 6 creates the ls-remote helper in 'test-tool bundle-uri' as before,
   but now only makes use of the finished_handshake member instead of
   creating a new one. The test helper represents an example consumer of
   transport_get_remote_bundle_uri() without first doing the server-side
   handshake, which motivates several of the placements of code within that
   method and get_bundle_uri() earlier in the series. The "quiet" option is
   also removed to simplify the test helper and to always communicate the
   inner errors to the user.
 * Patch 7 adds the server-side listing of bundle.* config values. The test
   scripts around these config values have been cleaned up since the
   previous version.
 * Patch 8 has another iteration of strbuf_strip_file_from_path() taking the
   feedback from Victoria and Ævar.
 * Patch 9 adds the relative path logic. The definition of the base path is
   clarified in the commit message and comments. An additional test shows
   what happens if the server advertises too many parent paths
   (unfortunately, a die(), and this is marked for cleanup later).
 * Patch 10 is identical to the old patch 8.
 * Patch 11 completes the work by having the client download the bundles
   provided by the server list. It fixes an if/else that should have been an
   if/else-if. A new test checks that the --bundle-uri=X option overrides
   the server advertisement.


Updates in v2
=============

 * Commit messages now refer to protocol v2 "commands" not "verbs".
 * Several edits were made to gitprotocol-v2.txt thanks to Victoria's
   thorough review.
 * strbuf_parent_directory() is renamed strbuf_strip_file_from_path() to
   make it more clear how it behaves when ending with a slash.

Thanks,

 * Stolee

Derrick Stolee (6):
  transport: rename got_remote_heads
  bundle-uri: serve bundle.* keys from config
  strbuf: introduce strbuf_strip_file_from_path()
  bundle-uri: allow relative URLs in bundle lists
  bundle-uri: download bundles from an advertised list
  clone: unbundle the advertised bundles

Ævar Arnfjörð Bjarmason (5):
  protocol v2: add server-side "bundle-uri" skeleton
  t: create test harness for 'bundle-uri' command
  clone: request the 'bundle-uri' command when available
  bundle-uri client: add boolean transfer.bundleURI setting
  bundle-uri client: add helper for testing server

 Documentation/config/transfer.txt      |   6 +
 Documentation/gitprotocol-v2.txt       | 201 +++++++++++++++++++++++
 builtin/clone.c                        |  21 +++
 bundle-uri.c                           |  87 +++++++++-
 bundle-uri.h                           |  35 ++++
 connect.c                              |  44 +++++
 remote.h                               |   5 +
 serve.c                                |   6 +
 strbuf.c                               |   6 +
 strbuf.h                               |  11 ++
 t/helper/test-bundle-uri.c             |  48 ++++++
 t/lib-bundle-uri-protocol.sh           | 216 +++++++++++++++++++++++++
 t/t5601-clone.sh                       |  59 +++++++
 t/t5701-git-serve.sh                   |  40 ++++-
 t/t5730-protocol-v2-bundle-uri-file.sh |  17 ++
 t/t5731-protocol-v2-bundle-uri-git.sh  |  17 ++
 t/t5732-protocol-v2-bundle-uri-http.sh |  17 ++
 t/t5750-bundle-uri-parse.sh            |  82 ++++++++++
 t/t9119-git-svn-info.sh                |   2 +-
 t/test-lib-functions.sh                |   7 +
 transport-helper.c                     |  13 ++
 transport-internal.h                   |   7 +
 transport.c                            |  87 ++++++++--
 transport.h                            |  19 +++
 24 files changed, 1041 insertions(+), 12 deletions(-)
 create mode 100644 t/lib-bundle-uri-protocol.sh
 create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
 create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
 create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh


base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1400%2Fderrickstolee%2Fbundle-redo%2Fadvertise-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1400/derrickstolee/bundle-redo/advertise-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1400

Range-diff vs v3:

  1:  beae335b855 !  1:  5ba91813de3 protocol v2: add server-side "bundle-uri" skeleton
     @@ bundle-uri.c: cleanup:
      + * API for serve.c.
      + */
      +
     -+int bundle_uri_advertise(struct repository *r, struct strbuf *value)
     ++int bundle_uri_advertise(struct repository *r, struct strbuf *value UNUSED)
      +{
      +	static int advertise_bundle_uri = -1;
      +
     @@ bundle-uri.c: cleanup:
      +		goto cached;
      +
      +	advertise_bundle_uri = 0;
     -+	git_config_get_maybe_bool("uploadpack.advertisebundleuris", &advertise_bundle_uri);
     ++	repo_config_get_maybe_bool(r, "uploadpack.advertisebundleuris", &advertise_bundle_uri);
      +
      +cached:
      +	return advertise_bundle_uri;
  2:  fcdfef2012a =  2:  3267a5b3b37 t: create test harness for 'bundle-uri' command
  3:  a0188ae39c6 =  3:  5bf6fe55771 clone: request the 'bundle-uri' command when available
  4:  e46118e60f7 !  4:  876dd3f221f bundle-uri client: add boolean transfer.bundleURI setting
     @@ Commit message
          can set it to 'true' to enable checking for bundle URIs from the origin
          Git server using protocol v2.
      
     -    To enable this setting by default in the correct tests, add a
     -    GIT_TEST_BUNDLE_URI environment variable.
     -
          Co-authored-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     @@ t/lib-bundle-uri-protocol.sh: test_expect_success "connect with $BUNDLE_URI_PROT
      +	test_when_finished "rm -rf log cloned cloned2" &&
       
       	GIT_TRACE_PACKET="$PWD/log" \
     -+	GIT_TEST_BUNDLE_URI=0 \
       	git \
     ++		-c transfer.bundleURI=false \
       		-c protocol.version=2 \
       		clone "$BUNDLE_URI_REPO_URI" cloned \
     + 		>actual 2>err &&
      @@ t/lib-bundle-uri-protocol.sh: test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
       	# Server advertised bundle-uri capability
       	grep "< bundle-uri" log &&
     @@ transport.c: int transport_get_remote_bundle_uri(struct transport *transport)
       
      +	/*
      +	 * Don't request bundle-uri from the server unless configured to
     -+	 * do so by GIT_TEST_BUNDLE_URI=1 or transfer.bundleURI=true.
     ++	 * do so by the transfer.bundleURI=true config option.
      +	 */
     -+	if (!git_env_bool("GIT_TEST_BUNDLE_URI", 0) &&
     -+	    (git_config_get_bool("transfer.bundleuri", &value) || !value))
     ++	if (git_config_get_bool("transfer.bundleuri", &value) || !value)
      +		return 0;
      +
       	if (!vtable->get_bundle_uri)
  5:  b009b4f58ea =  5:  8f5a483c329 transport: rename got_remote_heads
  6:  46a58e83caf !  6:  13e4c82e338 bundle-uri client: add helper for testing server
     @@ Commit message
      
          In the "git clone" case we'll have already done the handshake(),
          but not here. Add an extra case to check for this handshake in
     -    get_bundle_uri() for ease of use for future callers. Rename the existing
     -    'got_remote_heads' to 'finished_handshake' to make it more clear what
     -    that bit represents.
     +    get_bundle_uri() for ease of use for future callers.
      
          Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     @@ t/lib-bundle-uri-protocol.sh: test_expect_success "clone with $BUNDLE_URI_PROTOC
       	grep "> command=bundle-uri" log
       '
      +
     ++# The remaining tests will all assume transfer.bundleURI=true
     ++#
     ++# This test can be removed when transfer.bundleURI is enabled by default.
     ++test_expect_success 'enable transfer.bundleURI for remaining tests' '
     ++	git config --global transfer.bundleURI true
     ++'
     ++
      +test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol v2" '
      +	test_config -C "$BUNDLE_URI_PARENT" \
      +		bundle.only.uri "$BUNDLE_URI_BUNDLE_URI_ESCAPED" &&
  7:  acc5a8f57f9 !  7:  c9b7d8779e4 bundle-uri: serve bundle.* keys from config
     @@ t/lib-bundle-uri-protocol.sh: test_expect_success "test bundle-uri with $BUNDLE_
      +		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED
       	EOF
       
     -+	GIT_TEST_BUNDLE_URI=1 \
       	test-tool bundle-uri \
     - 		ls-remote \
     - 		"$BUNDLE_URI_REPO_URI" \
      @@ t/lib-bundle-uri-protocol.sh: test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol
       	[bundle]
       		version = 1
       		mode = all
      +	[bundle "only"]
      +		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED
     - 	EOF
     - 
     -+	GIT_TEST_BUNDLE_URI=1 \
     ++	EOF
     ++
      +	test-tool bundle-uri \
      +		ls-remote \
      +		"$BUNDLE_URI_REPO_URI" \
     @@ t/lib-bundle-uri-protocol.sh: test_expect_success "test bundle-uri with $BUNDLE_
      +		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED-2.bdl
      +	[bundle "bundle3"]
      +		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED-3.bdl
     -+	EOF
     -+
     -+	GIT_TEST_BUNDLE_URI=1 \
     + 	EOF
     + 
       	test-tool bundle-uri \
     - 		ls-remote \
     - 		"$BUNDLE_URI_REPO_URI" \
  8:  1eec3426aee =  8:  d13bd6cd95d strbuf: introduce strbuf_strip_file_from_path()
  9:  48731438d6a !  9:  a188b38399d bundle-uri: allow relative URLs in bundle lists
     @@ bundle-uri.h: struct bundle_list {
      +	 * In the case of the 'bundle-uri' protocol v2 command, the base
      +	 * URI is the URI of the Git remote.
      +	 *
     -+	 * Otherewise, the bundle list was downloaded over HTTP from some
     -+	 * known URI.
     ++	 * Otherwise, the bundle list was downloaded over HTTP from some
     ++	 * known URI. 'baseURI' is set to that value.
      +	 *
      +	 * The baseURI is used as the base for any relative URIs
      +	 * advertised by the bundle list at that location.
     @@ t/t5750-bundle-uri-parse.sh: test_expect_success 'parse config format: just URIs
      
       ## transport.c ##
      @@ transport.c: int transport_get_remote_bundle_uri(struct transport *transport)
     - 	    (git_config_get_bool("transfer.bundleuri", &value) || !value))
     + 	if (git_config_get_bool("transfer.bundleuri", &value) || !value)
       		return 0;
       
      +	if (!transport->bundles->baseURI)
 10:  69bf154bec6 ! 10:  72ca6f4254f bundle-uri: download bundles from an advertised list
     @@ bundle-uri.c: cleanup:
       	return result;
       }
       
     -+int fetch_bundle_list(struct repository *r, const char *uri, struct bundle_list *list)
     ++int fetch_bundle_list(struct repository *r, struct bundle_list *list)
      +{
      +	int result;
      +	struct bundle_list global_list;
     @@ bundle-uri.h: int bundle_uri_parse_config_format(const char *uri,
      + * bundle-uri protocol v2 verb) at the given uri, fetch and unbundle the
      + * bundles according to the bundle strategy of that list.
      + *
     -+ * Returns non-zero if no bundle information is found at the given 'uri'.
     ++ * It is expected that the given 'list' is initialized, including its
     ++ * 'baseURI' value.
     ++ *
     ++ * Returns non-zero if there was an error trying to download the list
     ++ * or any of its advertised bundles.
      + */
      +int fetch_bundle_list(struct repository *r,
     -+		      const char *uri,
      +		      struct bundle_list *list);
      +
       /**
 11:  7e1819162b6 ! 11:  46ab2b05b15 clone: unbundle the advertised bundles
     @@ Commit message
          when the client has chosen to enable the feature.
      
          Teach Git to download and unbundle the data advertised by those bundles
     -    during 'git clone'.
     +    during 'git clone'. This takes place between the ref advertisement and
     +    the object data download, and stateful connections will linger while
     +    the client downloads bundles. In the future, we should consider closing
     +    the remote connection during this process.
      
          Also, since the --bundle-uri option exists, we do not want to mix the
          advertised bundles with the user-specified bundles.
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      +			if (repo_init(the_repository, git_dir, work_tree))
      +				warning(_("failed to initialize the repo, skipping bundle URI"));
      +			else if (fetch_bundle_list(the_repository,
     -+						   remote->url[0],
      +						   transport->bundles))
      +				warning(_("failed to fetch advertised bundles"));
      +		} else {
     @@ t/lib-bundle-uri-protocol.sh: test_expect_success "connect with $BUNDLE_URI_PROT
      +	test_when_finished "rm -rf log* cloned*" &&
       
       	GIT_TRACE_PACKET="$PWD/log" \
     - 	GIT_TEST_BUNDLE_URI=0 \
     + 	git \
      @@ t/lib-bundle-uri-protocol.sh: test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
       	grep "< bundle-uri" log &&
       
     @@ t/lib-bundle-uri-protocol.sh: test_expect_success "clone with $BUNDLE_URI_PROTOC
      +	! grep "> command=bundle-uri" log3
       '
       
     - test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol v2" '
     + # The remaining tests will all assume transfer.bundleURI=true
      
       ## t/t5601-clone.sh ##
      @@ t/t5601-clone.sh: test_expect_success 'reject cloning shallow repository using HTTP' '
     @@ t/t5601-clone.sh: test_expect_success 'reject cloning shallow repository using H
      +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
      +		bundle.everything.uri "$HTTPD_URL/everything.bundle" &&
      +
     -+	GIT_TEST_BUNDLE_URI=1 \
      +	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
     -+		git -c protocol.version=2 clone \
     ++		git -c protocol.version=2 \
     ++		    -c transfer.bundleURI=true clone \
      +		$HTTPD_URL/smart/repo2.git repo2 &&
      +	cat >pattern <<-EOF &&
      +	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/everything.bundle"\]
     @@ t/t5601-clone.sh: test_expect_success 'reject cloning shallow repository using H
      +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
      +		bundle.new.uri "$HTTPD_URL/new.bundle" &&
      +
     -+	GIT_TEST_BUNDLE_URI=1 \
      +	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
     -+		git -c protocol.version=2 clone \
     ++		git -c protocol.version=2 \
     ++		    -c transfer.bundleURI=true clone \
      +		$HTTPD_URL/smart/repo3.git repo3 &&
      +
      +	# We should fetch _both_ bundles

-- 
gitgitgadget
