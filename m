Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E0EC47089
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 17:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiLERwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 12:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiLERvk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:40 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5293892
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 09:50:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay8-20020a05600c1e0800b003d0808d2826so6254757wmb.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 09:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hqupdly3Sp8Qgj1V/STS+fAIvHHyuxutHYwgjcl2Bs=;
        b=aBERykoCc3b3Nsl5QkQReugGOs8rR8/PIcpkyTZx3UXq8iKB7q1qXO8+Mg2sJyohwN
         lJFcGuel+bPGVd7Hriuv1u74mmfNGLCrQjsAnd5RpSeyV1tqOuyvoKlDBXYbI3iwq5CN
         sIX3Baxo8pzPauI7V+Y8hfBt6Ih8J73RZOTywiPYbWM7M6VXrEqF5uQrett2mIXsSciZ
         lZKb0kmhi77vT8odyyVxNf+1seiwl+5u/kG6ixATaJ4t0LYiRt3vgbxslJ1cf7GX20tK
         MBO3RStuHznGvFtEZfsVy/sWL8JdqEbC1zH+Glndcwg4FjAo6MiKneltZ3AqZExU4y+V
         Ds0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hqupdly3Sp8Qgj1V/STS+fAIvHHyuxutHYwgjcl2Bs=;
        b=h7Pdreh0H6OVBDMy27nSlcGExdSJEgIBfyKz0wEiNs5MClg15zqSqKxTu7JT8DnP0G
         XwxPPyCjysbnK4QsZaRQyPh9vXfknbjV1zUEDnS45ZQnfGkobW7PRthkuRrXgOAqxqSF
         kfv53wnmbI2MVQIJRa2iAWfOmj6P+uasSE6MrLYvgP2XAyTKyKWHcQsCFz7tJMbPKzzG
         NsfsE4MLetw1WRZb94Vv4DCBHGnoWC2VIjSeiNCBypLuXrWc/aoKVRDHmWnr4aWK+m8d
         3Pk0D/SGpO3nyF63WUUECd9A1eXVDnR6GHWqvKRHiXbyQBDIDeBWH31B+VdlrzV78viV
         3XoQ==
X-Gm-Message-State: ANoB5pnSg8Wi7ZauLlKer8CVeMSVWOdj3avLpnVYHTeS6HgPw3Afzc2R
        CvrjdfD84q7CDkd58kFTBht3+FpCvmU=
X-Google-Smtp-Source: AA0mqf4ug7RPlAWSDz18NjquvEfpVyqw67+nY0zGPduPKHQC4818KSZO30D2dW+mfGrDcNVXz7/LDg==
X-Received: by 2002:a05:600c:3501:b0:3c7:4f0:77b3 with SMTP id h1-20020a05600c350100b003c704f077b3mr46683273wmq.93.1670262641545;
        Mon, 05 Dec 2022 09:50:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c305300b003cf6a55d8e8sm17309163wmh.7.2022.12.05.09.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:50:41 -0800 (PST)
Message-Id: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 17:50:28 +0000
Subject: [PATCH v3 00/11] Bundle URIs IV: advertise over protocol v2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
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
 builtin/clone.c                        |  22 +++
 bundle-uri.c                           |  87 +++++++++-
 bundle-uri.h                           |  32 ++++
 connect.c                              |  44 +++++
 remote.h                               |   5 +
 serve.c                                |   6 +
 strbuf.c                               |   6 +
 strbuf.h                               |  11 ++
 t/helper/test-bundle-uri.c             |  48 ++++++
 t/lib-bundle-uri-protocol.sh           | 212 +++++++++++++++++++++++++
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
 transport.c                            |  88 ++++++++--
 transport.h                            |  19 +++
 24 files changed, 1036 insertions(+), 12 deletions(-)
 create mode 100644 t/lib-bundle-uri-protocol.sh
 create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
 create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
 create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh


base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1400%2Fderrickstolee%2Fbundle-redo%2Fadvertise-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1400/derrickstolee/bundle-redo/advertise-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1400

Range-diff vs v2:

  1:  beae335b855 =  1:  beae335b855 protocol v2: add server-side "bundle-uri" skeleton
  -:  ----------- >  2:  fcdfef2012a t: create test harness for 'bundle-uri' command
  2:  0d85aef965d !  3:  a0188ae39c6 bundle-uri client: add minimal NOOP client
     @@ Metadata
      Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## Commit message ##
     -    bundle-uri client: add minimal NOOP client
     +    clone: request the 'bundle-uri' command when available
      
     -    Set up all the needed client parts of the "bundle-uri" protocol
     -    extension, without actually doing anything with the bundle URIs.
     +    Set up all the needed client parts of the 'bundle-uri' protocol v2
     +    command, without actually doing anything with the bundle URIs.
      
     -    I.e. if the server says it supports "bundle-uri" we'll issue a
     -    command=bundle-uri after command=ls-refs when we're cloning. We'll
     -    parse the returned output using the code already tested for in
     -    t5750-bundle-uri-parse.sh.
     +    If the server says it supports 'bundle-uri' teach Git to issue the
     +    'bundle-uri' command after the 'ls-refs' during 'git clone'. The
     +    returned key=value pairs are passed to the bundle list code which is
     +    tested using a different ingest mechanism in t5750-bundle-uri-parse.sh.
      
     -    What we aren't doing is actually acting on that data, i.e. downloading
     -    the bundle(s) before we get to doing the command=fetch, and adjusting
     -    our negotiation dialog appropriately. I'll do that in subsequent
     -    commits.
     +    At this point, Git does nothing with that bundle list. It will not
     +    download any of the bundles. That will come in a later change after
     +    these protocol bits are finalized.
      
     -    There's a question of what level of encapsulation we should use here,
     -    I've opted to use connect.h in clone.c, but we could also e.g. make
     -    transport_get_remote_refs() invoke this, i.e. make it implicitly get
     -    the bundle-uri list for later steps.
     -
     -    This approach means that we don't "support" this in "git fetch" for
     -    now. I'm starting with the case of initial clones, although as noted
     -    in preceding commits to the protocol documentation nothing about this
     -    approach precludes getting bundles on incremental fetches.
     -
     -    For the t5732-protocol-v2-bundle-uri-http.sh it's not easy to set
     -    environment variables for git-upload-pack (it's started by Apache), so
     -    let's skip the test under T5730_HTTP, and add unused T5730_{FILE,GIT}
     -    prerequisites for consistency and future use.
     +    The no-op client is initially used only by 'git clone' to test the basic
     +    functionality, and eventually will bootstrap the initial download of Git
     +    objects during a fresh clone. The bundle URI client will not be
     +    integrated into other fetches until a mechanism is created to select a
     +    subset of bundles for download.
      
          Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## builtin/clone.c ##
     -@@
     - #include "iterator.h"
     - #include "sigchain.h"
     - #include "branch.h"
     -+#include "connect.h"
     - #include "remote.h"
     - #include "run-command.h"
     - #include "connected.h"
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       	if (refs)
       		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
       
      
     - ## bundle-uri.c ##
     -@@ bundle-uri.c: int bundle_uri_advertise(struct repository *r, struct strbuf *value)
     - {
     - 	static int advertise_bundle_uri = -1;
     - 
     -+	if (value &&
     -+	    git_env_bool("GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE", 0))
     -+		strbuf_addstr(value, "test-unknown-capability-value");
     -+
     - 	if (advertise_bundle_uri != -1)
     - 		goto cached;
     - 
     -
       ## connect.c ##
      @@
       #include "version.h"
     @@ connect.c: static void send_capabilities(int fd_out, struct packet_reader *reade
      +	packet_write_fmt(fd_out, "command=bundle-uri\n");
      +	packet_delim(fd_out);
      +
     -+	/* Send options */
     -+	if (git_env_bool("GIT_TEST_PROTOCOL_BAD_BUNDLE_URI", 0))
     -+		packet_write_fmt(fd_out, "test-bad-client\n");
      +	packet_flush(fd_out);
      +
      +	/* Process response from server */
     @@ remote.h: struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
       
       /*
      
     - ## t/lib-t5730-protocol-v2-bundle-uri.sh (new) ##
     -@@
     -+# Included from t573*-protocol-v2-bundle-uri-*.sh
     -+
     -+T5730_PARENT=
     -+T5730_URI=
     -+T5730_BUNDLE_URI=
     -+case "$T5730_PROTOCOL" in
     -+file)
     -+	T5730_PARENT=file_parent
     -+	T5730_URI="file://$PWD/file_parent"
     -+	T5730_BUNDLE_URI="$T5730_URI/fake.bdl"
     -+	test_set_prereq T5730_FILE
     -+	;;
     -+git)
     -+	. "$TEST_DIRECTORY"/lib-git-daemon.sh
     -+	start_git_daemon --export-all --enable=receive-pack
     -+	T5730_PARENT="$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent"
     -+	T5730_URI="$GIT_DAEMON_URL/parent"
     -+	T5730_BUNDLE_URI="https://example.com/fake.bdl"
     -+	test_set_prereq T5730_GIT
     -+	;;
     -+http)
     -+	. "$TEST_DIRECTORY"/lib-httpd.sh
     -+	start_httpd
     -+	T5730_PARENT="$HTTPD_DOCUMENT_ROOT_PATH/http_parent"
     -+	T5730_URI="$HTTPD_URL/smart/http_parent"
     -+	T5730_BUNDLE_URI="https://example.com/fake.bdl"
     -+	test_set_prereq T5730_HTTP
     -+	;;
     -+*)
     -+	BUG "Need to pass valid T5730_PROTOCOL (was $T5730_PROTOCOL)"
     -+	;;
     -+esac
     -+
     -+test_expect_success "setup protocol v2 $T5730_PROTOCOL:// tests" '
     -+	git init "$T5730_PARENT" &&
     -+	test_commit -C "$T5730_PARENT" one &&
     -+	git -C "$T5730_PARENT" config uploadpack.advertiseBundleURIs true
     -+'
     + ## t/lib-bundle-uri-protocol.sh ##
     +@@ t/lib-bundle-uri-protocol.sh: test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: hav
     + 	# Server advertised bundle-uri capability
     + 	grep "< bundle-uri" log
     + '
      +
     -+# Poor man's URI escaping. Good enough for the test suite whose trash
     -+# directory has a space in it. See 93c3fcbe4d4 (git-svn: attempt to
     -+# mimic SVN 1.7 URL canonicalization, 2012-07-28) for prior art.
     -+test_uri_escape() {
     -+	sed 's/ /%20/g'
     -+}
     -+
     -+case "$T5730_PROTOCOL" in
     -+http)
     -+	test_expect_success "setup config for $T5730_PROTOCOL:// tests" '
     -+		git -C "$T5730_PARENT" config http.receivepack true
     -+	'
     -+	;;
     -+*)
     -+	;;
     -+esac
     -+T5730_BUNDLE_URI_ESCAPED=$(echo "$T5730_BUNDLE_URI" | test_uri_escape)
     -+
     -+test_expect_success "connect with $T5730_PROTOCOL:// using protocol v2: no bundle-uri" '
     -+	test_when_finished "rm -f log" &&
     -+	test_when_finished "git -C \"$T5730_PARENT\" config uploadpack.advertiseBundleURIs true" &&
     -+	git -C "$T5730_PARENT" config uploadpack.advertiseBundleURIs false &&
     ++test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: request bundle-uris" '
     ++	test_when_finished "rm -rf log cloned" &&
      +
      +	GIT_TRACE_PACKET="$PWD/log" \
      +	git \
      +		-c protocol.version=2 \
     -+		ls-remote --symref "$T5730_URI" \
     -+		>actual 2>err &&
     -+
     -+	# Server responded using protocol v2
     -+	grep "< version 2" log &&
     -+
     -+	! grep bundle-uri log
     -+'
     -+
     -+test_expect_success "connect with $T5730_PROTOCOL:// using protocol v2: have bundle-uri" '
     -+	test_when_finished "rm -f log" &&
     -+
     -+	test_config -C "$T5730_PARENT" \
     -+		uploadpack.bundleURI "$T5730_BUNDLE_URI_ESCAPED" &&
     -+
     -+	GIT_TRACE_PACKET="$PWD/log" \
     -+	git \
     -+		-c protocol.version=2 \
     -+		ls-remote --symref "$T5730_URI" \
     ++		clone "$BUNDLE_URI_REPO_URI" cloned \
      +		>actual 2>err &&
      +
      +	# Server responded using protocol v2
      +	grep "< version 2" log &&
      +
      +	# Server advertised bundle-uri capability
     -+	grep bundle-uri log
     -+'
     ++	grep "< bundle-uri" log &&
      +
     -+test_expect_success !T5730_HTTP "bad client with $T5730_PROTOCOL:// using protocol v2" '
     -+	test_when_finished "rm -f log" &&
     -+
     -+	test_config -C "$T5730_PARENT" uploadpack.bundleURI \
     -+		"$T5730_BUNDLE_URI_ESCAPED" &&
     -+
     -+	cat >err.expect <<-\EOF &&
     -+	Cloning into '"'"'child'"'"'...
     -+	EOF
     -+	case "$T5730_PROTOCOL" in
     -+	file)
     -+		cat >fatal-bundle-uri.expect <<-\EOF
     -+		fatal: bundle-uri: unexpected argument: '"'"'test-bad-client'"'"'
     -+		EOF
     -+		;;
     -+	*)
     -+		cat >fatal.expect <<-\EOF
     -+		fatal: read error: Connection reset by peer
     -+		EOF
     -+		;;
     -+	esac &&
     -+
     -+	test_when_finished "rm -rf child" &&
     -+	test_must_fail ok=sigpipe env \
     -+		GIT_TRACE_PACKET="$PWD/log" \
     -+		GIT_TEST_PROTOCOL_BAD_BUNDLE_URI=true \
     -+		git -c protocol.version=2 \
     -+		clone "$T5730_URI" child \
     -+		>out 2>err &&
     -+	test_must_be_empty out &&
     -+
     -+	grep -v -e ^fatal: -e ^error: err >err.actual &&
     -+	test_cmp err.expect err.actual &&
     -+
     -+	case "$T5730_PROTOCOL" in
     -+	file)
     -+		# Due to general race conditions with client/server replies we
     -+		# may or may not get "fatal: the remote end hung up
     -+		# expectedly" here
     -+		grep "^fatal: bundle-uri:" err >fatal-bundle-uri.actual &&
     -+		test_cmp fatal-bundle-uri.expect fatal-bundle-uri.actual
     -+		;;
     -+	*)
     -+		grep "^fatal:" err >fatal.actual &&
     -+		# Due to the same race conditions this might be
     -+		# "fatal: read error: Connection reset by peer", "fatal: the remote end
     -+		# hung up unexpectedly" etc.
     -+		cat fatal.actual &&
     -+		test_file_not_empty fatal.actual
     -+		;;
     -+	esac &&
     -+
     -+	grep "clone> test-bad-client$" log >sent-bad-request &&
     -+	test_file_not_empty sent-bad-request
     ++	# Client issued bundle-uri command
     ++	grep "> command=bundle-uri" log
      +'
      
     - ## t/t5730-protocol-v2-bundle-uri-file.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description="Test bundle-uri with protocol v2 and 'file://' transport"
     -+
     -+TEST_NO_CREATE_REPO=1
     -+
     -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     -+
     -+. ./test-lib.sh
     -+
     -+# Test protocol v2 with 'file://' transport
     -+#
     -+T5730_PROTOCOL=file
     -+. "$TEST_DIRECTORY"/lib-t5730-protocol-v2-bundle-uri.sh
     -+
     -+test_expect_success "unknown capability value with $T5730_PROTOCOL:// using protocol v2" '
     -+	test_when_finished "rm -f log" &&
     -+
     -+	test_config -C "$T5730_PARENT" \
     -+		uploadpack.bundleURI "$T5730_BUNDLE_URI_ESCAPED" &&
     -+
     -+	GIT_TRACE_PACKET="$PWD/log" \
     -+	GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE=true \
     -+	git \
     -+		-c protocol.version=2 \
     -+		ls-remote --symref "$T5730_URI" \
     -+		>actual 2>err &&
     -+
     -+	# Server responded using protocol v2
     -+	grep "< version 2" log &&
     -+
     -+	grep "> bundle-uri=test-unknown-capability-value" log
     -+'
     -+
     -+test_done
     -
     - ## t/t5731-protocol-v2-bundle-uri-git.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description="Test bundle-uri with protocol v2 and 'git://' transport"
     -+
     -+TEST_NO_CREATE_REPO=1
     -+
     -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     -+
     -+. ./test-lib.sh
     -+
     -+# Test protocol v2 with 'git://' transport
     -+#
     -+T5730_PROTOCOL=git
     -+. "$TEST_DIRECTORY"/lib-t5730-protocol-v2-bundle-uri.sh
     -+
     -+test_done
     -
     - ## t/t5732-protocol-v2-bundle-uri-http.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description="Test bundle-uri with protocol v2 and 'git://' transport"
     -+
     -+TEST_NO_CREATE_REPO=1
     -+
     -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     -+
     -+. ./test-lib.sh
     -+
     -+# Test protocol v2 with 'git://' transport
     -+#
     -+T5730_PROTOCOL=http
     -+. "$TEST_DIRECTORY"/lib-t5730-protocol-v2-bundle-uri.sh
     -+
     -+test_done
     -
       ## transport-helper.c ##
      @@ transport-helper.c: static struct ref *get_refs_list_using_list(struct transport *transport,
       	return ret;
     @@ transport.c: static struct ref *get_refs_via_connect(struct transport *transport
      +		init_bundle_list(transport->bundles);
      +	}
      +
     ++	/*
     ++	 * "Support" protocol v0 and v2 without bundle-uri support by
     ++	 * silently degrading to a NOOP.
     ++	 */
     ++	if (!server_supports_v2("bundle-uri", 0))
     ++		return 0;
     ++
      +	packet_reader_init(&reader, data->fd[0], NULL, 0,
      +			   PACKET_READ_CHOMP_NEWLINE |
      +			   PACKET_READ_GENTLE_ON_EOF);
     @@ transport.c: int transport_fetch_refs(struct transport *transport, struct ref *r
      +	const struct transport_vtable *vtable = transport->vtable;
      +
      +	/* Check config only once. */
     -+	if (transport->got_remote_bundle_uri++)
     ++	if (transport->got_remote_bundle_uri)
      +		return 0;
     ++	transport->got_remote_bundle_uri = 1;
      +
     -+	/*
     -+	 * "Support" protocol v0 and v2 without bundle-uri support by
     -+	 * silently degrading to a NOOP.
     -+	 */
     -+	if (!server_supports_v2("bundle-uri", 0))
     -+		return 0;
     -+
     -+	/*
     -+	 * This is intentionally below the transport.injectBundleURI,
     -+	 * we want to be able to inject into protocol v0, or into the
     -+	 * dialog of a server who doesn't support this.
     -+	 */
      +	if (!vtable->get_bundle_uri)
      +		return error(_("bundle-uri operation not supported by protocol"));
      +
  5:  93397468931 !  4:  e46118e60f7 bundle-uri client: add boolean transfer.bundleURI setting
     @@ Documentation/config/transfer.txt: transfer.unpackLimit::
      +	bundles before continuing the clone through the Git protocol.
      +	Defaults to `false`.
      
     - ## t/lib-t5730-protocol-v2-bundle-uri.sh ##
     -@@
     - # Included from t573*-protocol-v2-bundle-uri-*.sh
     + ## t/lib-bundle-uri-protocol.sh ##
     +@@ t/lib-bundle-uri-protocol.sh: test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: hav
     + '
       
     -+GIT_TEST_BUNDLE_URI=1
     -+export GIT_TEST_BUNDLE_URI
     + test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: request bundle-uris" '
     +-	test_when_finished "rm -rf log cloned" &&
     ++	test_when_finished "rm -rf log cloned cloned2" &&
     + 
     + 	GIT_TRACE_PACKET="$PWD/log" \
     ++	GIT_TEST_BUNDLE_URI=0 \
     + 	git \
     + 		-c protocol.version=2 \
     + 		clone "$BUNDLE_URI_REPO_URI" cloned \
     +@@ t/lib-bundle-uri-protocol.sh: test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
     + 	# Server advertised bundle-uri capability
     + 	grep "< bundle-uri" log &&
     + 
     ++	# Client did not issue bundle-uri command
     ++	! grep "> command=bundle-uri" log &&
     ++
     ++	GIT_TRACE_PACKET="$PWD/log" \
     ++	git \
     ++		-c transfer.bundleURI=true \
     ++		-c protocol.version=2 \
     ++		clone "$BUNDLE_URI_REPO_URI" cloned2 \
     ++		>actual 2>err &&
      +
     - T5730_PARENT=
     - T5730_URI=
     - T5730_BUNDLE_URI=
     ++	# Server responded using protocol v2
     ++	grep "< version 2" log &&
     ++
     ++	# Server advertised bundle-uri capability
     ++	grep "< bundle-uri" log &&
     ++
     + 	# Client issued bundle-uri command
     + 	grep "> command=bundle-uri" log
     + '
      
       ## transport.c ##
      @@ transport.c: int transport_fetch_refs(struct transport *transport, struct ref *refs)
       
     - int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
     + int transport_get_remote_bundle_uri(struct transport *transport)
       {
      +	int value = 0;
       	const struct transport_vtable *vtable = transport->vtable;
       
       	/* Check config only once. */
     -@@ transport.c: int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
     +@@ transport.c: int transport_get_remote_bundle_uri(struct transport *transport)
       		return 0;
     + 	transport->got_remote_bundle_uri = 1;
       
     - 	/*
     --	 * This is intentionally below the transport.injectBundleURI,
     --	 * we want to be able to inject into protocol v0, or into the
     --	 * dialog of a server who doesn't support this.
     -+	 * Don't use bundle-uri at all, if configured not to. Only proceed
     -+	 * if GIT_TEST_BUNDLE_URI=1 or transfer.bundleURI=true.
     - 	 */
     ++	/*
     ++	 * Don't request bundle-uri from the server unless configured to
     ++	 * do so by GIT_TEST_BUNDLE_URI=1 or transfer.bundleURI=true.
     ++	 */
      +	if (!git_env_bool("GIT_TEST_BUNDLE_URI", 0) &&
      +	    (git_config_get_bool("transfer.bundleuri", &value) || !value))
      +		return 0;
      +
     - 	if (!vtable->get_bundle_uri) {
     - 		if (quiet)
     - 			return -1;
     + 	if (!vtable->get_bundle_uri)
     + 		return error(_("bundle-uri operation not supported by protocol"));
     + 
  -:  ----------- >  5:  b009b4f58ea transport: rename got_remote_heads
  3:  c3269a24b57 !  6:  46a58e83caf bundle-uri client: add helper for testing server
     @@ Commit message
          for issuing protocol v2 "bundle-uri" commands to a server, and to the
          parsing routines in bundle-uri.c.
      
     -    Since in the "git clone" case we'll have already done the handshake(),
     -    but not here, introduce a "got_advertisement" state along with
     -    "got_remote_heads". It seems to me that the "got_remote_heads" is
     -    badly named in the first place, and the whole logic of eagerly getting
     -    ls-refs on handshake() or not could be refactored somewhat, but let's
     -    not do that now, and instead just add another self-documenting state
     -    variable.
     +    In the "git clone" case we'll have already done the handshake(),
     +    but not here. Add an extra case to check for this handshake in
     +    get_bundle_uri() for ease of use for future callers. Rename the existing
     +    'got_remote_heads' to 'finished_handshake' to make it more clear what
     +    that bit represents.
      
          Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     - ## builtin/clone.c ##
     -@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 	 * Populate transport->got_remote_bundle_uri and
     - 	 * transport->bundle_uri. We might get nothing.
     - 	 */
     --	transport_get_remote_bundle_uri(transport);
     -+	transport_get_remote_bundle_uri(transport, 1);
     - 
     - 	if (mapped_refs) {
     - 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
     -
       ## t/helper/test-bundle-uri.c ##
      @@
       #include "bundle-uri.h"
     @@ t/helper/test-bundle-uri.c: usage:
      +	if (server_options.nr)
      +		transport->server_options = &server_options;
      +
     -+	if (transport_get_remote_bundle_uri(transport, 0) < 0) {
     ++	if (transport_get_remote_bundle_uri(transport) < 0) {
      +		error(_("could not get the bundle-uri list"));
      +		status = 1;
      +		goto cleanup;
     @@ t/helper/test-bundle-uri.c: int cmd__bundle_uri(int argc, const char **argv)
       
       usage:
      
     - ## t/lib-t5730-protocol-v2-bundle-uri.sh ##
     -@@ t/lib-t5730-protocol-v2-bundle-uri.sh: esac
     - test_expect_success "setup protocol v2 $T5730_PROTOCOL:// tests" '
     - 	git init "$T5730_PARENT" &&
     - 	test_commit -C "$T5730_PARENT" one &&
     --	git -C "$T5730_PARENT" config uploadpack.advertiseBundleURIs true
     -+	git -C "$T5730_PARENT" config uploadpack.advertiseBundleURIs true &&
     -+	git -C "$T5730_PARENT" config bundle.version 1 &&
     -+	git -C "$T5730_PARENT" config bundle.mode all
     + ## t/lib-bundle-uri-protocol.sh ##
     +@@ t/lib-bundle-uri-protocol.sh: test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
     + 	# Client issued bundle-uri command
     + 	grep "> command=bundle-uri" log
       '
     - 
     - # Poor man's URI escaping. Good enough for the test suite whose trash
     -@@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success "connect with $T5730_PROTOCOL:// using protocol v2: no bundl
     - 	git -C "$T5730_PARENT" config uploadpack.advertiseBundleURIs false &&
     - 
     - 	GIT_TRACE_PACKET="$PWD/log" \
     --	git \
     --		-c protocol.version=2 \
     --		ls-remote --symref "$T5730_URI" \
     -+	test-tool bundle-uri \
     -+		ls-remote "$T5730_URI" \
     - 		>actual 2>err &&
     - 
     - 	# Server responded using protocol v2
     -@@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success "connect with $T5730_PROTOCOL:// using protocol v2: have bun
     - 	test_when_finished "rm -f log" &&
     - 
     - 	test_config -C "$T5730_PARENT" \
     --		uploadpack.bundleURI "$T5730_BUNDLE_URI_ESCAPED" &&
     -+		bundle.only.uri "$T5730_BUNDLE_URI_ESCAPED" &&
     - 
     - 	GIT_TRACE_PACKET="$PWD/log" \
     --	git \
     --		-c protocol.version=2 \
     --		ls-remote --symref "$T5730_URI" \
     -+	test-tool bundle-uri \
     -+		ls-remote "$T5730_URI" \
     - 		>actual 2>err &&
     - 
     - 	# Server responded using protocol v2
     -@@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success "connect with $T5730_PROTOCOL:// using protocol v2: have bun
     - test_expect_success !T5730_HTTP "bad client with $T5730_PROTOCOL:// using protocol v2" '
     - 	test_when_finished "rm -f log" &&
     - 
     --	test_config -C "$T5730_PARENT" uploadpack.bundleURI \
     --		"$T5730_BUNDLE_URI_ESCAPED" &&
     -+	test_config -C "$T5730_PARENT" \
     -+		bundle.only.uri "$T5730_BUNDLE_URI_ESCAPED" &&
     - 
     - 	cat >err.expect <<-\EOF &&
     - 	Cloning into '"'"'child'"'"'...
     -@@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success !T5730_HTTP "bad client with $T5730_PROTOCOL:// using protoc
     - 	grep "clone> test-bad-client$" log >sent-bad-request &&
     - 	test_file_not_empty sent-bad-request
     - '
     -+
     -+test_expect_success "ls-remote with $T5730_PROTOCOL:// using protocol v2" '
     -+	test_when_finished "rm -f log" &&
      +
     -+	test_config -C "$T5730_PARENT" \
     -+		bundle.only.uri "$T5730_BUNDLE_URI_ESCAPED" &&
     ++test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol v2" '
     ++	test_config -C "$BUNDLE_URI_PARENT" \
     ++		bundle.only.uri "$BUNDLE_URI_BUNDLE_URI_ESCAPED" &&
      +
      +	# All data about bundle URIs
      +	cat >expect <<-EOF &&
     @@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success !T5730_HTTP "bad clie
      +		version = 1
      +		mode = all
      +	EOF
     -+	GIT_TRACE_PACKET="$PWD/log" \
     ++
      +	test-tool bundle-uri \
      +		ls-remote \
     -+		"$T5730_URI" \
     ++		"$BUNDLE_URI_REPO_URI" \
      +		>actual &&
      +	test_cmp_config_output expect actual
      +'
      +
     -+test_expect_success "ls-remote with $T5730_PROTOCOL:// using protocol v2 and extra data" '
     -+	test_when_finished "rm -f log" &&
     -+
     -+	test_config -C "$T5730_PARENT" \
     -+		bundle.only.uri "$T5730_BUNDLE_URI_ESCAPED" &&
     ++test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol v2 and extra data" '
     ++	test_config -C "$BUNDLE_URI_PARENT" \
     ++		bundle.only.uri "$BUNDLE_URI_BUNDLE_URI_ESCAPED" &&
      +
      +	# Extra data should be ignored
     -+	test_config -C "$T5730_PARENT" bundle.only.extra bogus &&
     ++	test_config -C "$BUNDLE_URI_PARENT" bundle.only.extra bogus &&
      +
      +	# All data about bundle URIs
      +	cat >expect <<-EOF &&
     @@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success !T5730_HTTP "bad clie
      +		version = 1
      +		mode = all
      +	EOF
     -+	GIT_TRACE_PACKET="$PWD/log" \
     ++
      +	test-tool bundle-uri \
      +		ls-remote \
     -+		"$T5730_URI" \
     ++		"$BUNDLE_URI_REPO_URI" \
      +		>actual &&
      +	test_cmp_config_output expect actual
      +'
      
       ## transport.c ##
     -@@ transport.c: struct git_transport_data {
     - 	struct git_transport_options options;
     - 	struct child_process *conn;
     - 	int fd[2];
     -+	unsigned got_advertisement : 1;
     - 	unsigned got_remote_heads : 1;
     - 	enum protocol_version version;
     - 	struct oid_array extra_have;
     -@@ transport.c: static struct ref *handshake(struct transport *transport, int for_push,
     - 		BUG("unknown protocol version");
     - 	}
     - 	data->got_remote_heads = 1;
     -+	data->got_advertisement = 1;
     - 	transport->hash_algo = reader.hash_algo;
     - 
     - 	if (reader.line_peeked)
      @@ transport.c: static int get_bundle_uri(struct transport *transport)
       		init_bundle_list(transport->bundles);
       	}
       
     -+	if (!data->got_advertisement) {
     -+		struct ref *refs;
     -+		struct git_transport_data *data = transport->data;
     -+		enum protocol_version version;
     ++	if (!data->finished_handshake) {
     ++		struct ref *refs = handshake(transport, 0, NULL, 0);
      +
     -+		refs = handshake(transport, 0, NULL, 0);
     -+		version = data->version;
     -+
     -+		switch (version) {
     -+		case protocol_v2:
     -+			assert(!refs);
     -+			break;
     -+		case protocol_v0:
     -+		case protocol_v1:
     -+		case protocol_unknown_version:
     -+			assert(refs);
     -+			break;
     -+		}
     ++		if (refs)
     ++			free_refs(refs);
      +	}
      +
     -+	/*
     -+	 * "Support" protocol v0 and v2 without bundle-uri support by
     -+	 * silently degrading to a NOOP.
     -+	 */
     -+	if (!server_supports_v2("bundle-uri", 0))
     -+		return 0;
     -+
     - 	packet_reader_init(&reader, data->fd[0], NULL, 0,
     - 			   PACKET_READ_CHOMP_NEWLINE |
     - 			   PACKET_READ_GENTLE_ON_EOF);
     -@@ transport.c: int transport_fetch_refs(struct transport *transport, struct ref *refs)
     - 	return rc;
     - }
     - 
     --int transport_get_remote_bundle_uri(struct transport *transport)
     -+int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
     - {
     - 	const struct transport_vtable *vtable = transport->vtable;
     - 
     -@@ transport.c: int transport_get_remote_bundle_uri(struct transport *transport)
     - 	if (transport->got_remote_bundle_uri++)
     - 		return 0;
     - 
     --	/*
     --	 * "Support" protocol v0 and v2 without bundle-uri support by
     --	 * silently degrading to a NOOP.
     --	 */
     --	if (!server_supports_v2("bundle-uri", 0))
     --		return 0;
     --
       	/*
     - 	 * This is intentionally below the transport.injectBundleURI,
     - 	 * we want to be able to inject into protocol v0, or into the
     - 	 * dialog of a server who doesn't support this.
     - 	 */
     --	if (!vtable->get_bundle_uri)
     -+	if (!vtable->get_bundle_uri) {
     -+		if (quiet)
     -+			return -1;
     - 		return error(_("bundle-uri operation not supported by protocol"));
     -+	}
     - 
     - 	if (vtable->get_bundle_uri(transport) < 0)
     - 		return error(_("could not retrieve server-advertised bundle-uri list"));
     -
     - ## transport.h ##
     -@@ transport.h: const struct ref *transport_get_remote_refs(struct transport *transport,
     - /**
     -  * Retrieve bundle URI(s) from a remote. Populates "struct
     -  * transport"'s "bundle_uri" and "got_remote_bundle_uri".
     -+ *
     -+ * With `quiet=1` it will not complain if the serve doesn't support
     -+ * the protocol, but only if we discover the server uses it, and
     -+ * encounter issues then.
     -  */
     --int transport_get_remote_bundle_uri(struct transport *transport);
     -+int transport_get_remote_bundle_uri(struct transport *transport, int quiet);
     - 
     - /*
     -  * Fetch the hash algorithm used by a remote.
     + 	 * "Support" protocol v0 and v2 without bundle-uri support by
     + 	 * silently degrading to a NOOP.
  4:  cd906f6d981 !  7:  acc5a8f57f9 bundle-uri: serve bundle.* keys from config
     @@ bundle-uri.c: int bundle_uri_command(struct repository *r,
       	packet_writer_flush(&writer);
       
      
     - ## t/lib-t5730-protocol-v2-bundle-uri.sh ##
     -@@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success "ls-remote with $T5730_PROTOCOL:// using protocol v2" '
     + ## t/lib-bundle-uri-protocol.sh ##
     +@@ t/lib-bundle-uri-protocol.sh: test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol
       	[bundle]
       		version = 1
       		mode = all
      +	[bundle "only"]
     -+		uri = $T5730_BUNDLE_URI_ESCAPED
     ++		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED
       	EOF
     - 	GIT_TRACE_PACKET="$PWD/log" \
     + 
     ++	GIT_TEST_BUNDLE_URI=1 \
       	test-tool bundle-uri \
     -@@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success "ls-remote with $T5730_PROTOCOL:// using protocol v2 and ext
     + 		ls-remote \
     + 		"$BUNDLE_URI_REPO_URI" \
     +@@ t/lib-bundle-uri-protocol.sh: test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol
       	[bundle]
       		version = 1
       		mode = all
      +	[bundle "only"]
     -+		uri = $T5730_BUNDLE_URI_ESCAPED
     -+	EOF
     -+	GIT_TRACE_PACKET="$PWD/log" \
     ++		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED
     + 	EOF
     + 
     ++	GIT_TEST_BUNDLE_URI=1 \
      +	test-tool bundle-uri \
      +		ls-remote \
     -+		"$T5730_URI" \
     ++		"$BUNDLE_URI_REPO_URI" \
      +		>actual &&
      +	test_cmp_config_output expect actual
      +'
      +
     -+
     -+test_expect_success "ls-remote with $T5730_PROTOCOL:// using protocol v2 with list" '
     -+	test_when_finished "rm -f log" &&
     -+
     -+	test_config -C "$T5730_PARENT" \
     -+		bundle.bundle1.uri "$T5730_BUNDLE_URI_ESCAPED-1.bdl" &&
     -+	test_config -C "$T5730_PARENT" \
     -+		bundle.bundle2.uri "$T5730_BUNDLE_URI_ESCAPED-2.bdl" &&
     -+	test_config -C "$T5730_PARENT" \
     -+		bundle.bundle3.uri "$T5730_BUNDLE_URI_ESCAPED-3.bdl" &&
     ++test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol v2 with list" '
     ++	test_config -C "$BUNDLE_URI_PARENT" \
     ++		bundle.bundle1.uri "$BUNDLE_URI_BUNDLE_URI_ESCAPED-1.bdl" &&
     ++	test_config -C "$BUNDLE_URI_PARENT" \
     ++		bundle.bundle2.uri "$BUNDLE_URI_BUNDLE_URI_ESCAPED-2.bdl" &&
     ++	test_config -C "$BUNDLE_URI_PARENT" \
     ++		bundle.bundle3.uri "$BUNDLE_URI_BUNDLE_URI_ESCAPED-3.bdl" &&
      +
      +	# All data about bundle URIs
      +	cat >expect <<-EOF &&
     @@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success "ls-remote with $T573
      +		version = 1
      +		mode = all
      +	[bundle "bundle1"]
     -+		uri = $T5730_BUNDLE_URI_ESCAPED-1.bdl
     ++		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED-1.bdl
      +	[bundle "bundle2"]
     -+		uri = $T5730_BUNDLE_URI_ESCAPED-2.bdl
     ++		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED-2.bdl
      +	[bundle "bundle3"]
     -+		uri = $T5730_BUNDLE_URI_ESCAPED-3.bdl
     - 	EOF
     - 	GIT_TRACE_PACKET="$PWD/log" \
     ++		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED-3.bdl
     ++	EOF
     ++
     ++	GIT_TEST_BUNDLE_URI=1 \
       	test-tool bundle-uri \
     + 		ls-remote \
     + 		"$BUNDLE_URI_REPO_URI" \
  6:  7d86852c015 !  8:  1eec3426aee strbuf: introduce strbuf_strip_file_from_path()
     @@ Commit message
          Re-add the method, this time in strbuf.c, but with a new name:
          strbuf_strip_file_from_path(). The method requirements are slightly
          modified to allow a trailing slash, in which case nothing is done, which
     -    makes the name change valuable. The return value is the number of bytes
     -    removed.
     +    makes the name change valuable.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ strbuf.c: int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
       	return res;
       }
      +
     -+size_t strbuf_strip_file_from_path(struct strbuf *buf)
     ++void strbuf_strip_file_from_path(struct strbuf *sb)
      +{
     -+	size_t len = buf->len;
     -+	size_t offset = offset_1st_component(buf->buf);
     -+	char *path_sep = find_last_dir_sep(buf->buf + offset);
     -+	strbuf_setlen(buf, path_sep ? path_sep - buf->buf + 1 : offset);
     -+	return len - buf->len;
     ++	char *path_sep = find_last_dir_sep(sb->buf);
     ++	strbuf_setlen(sb, path_sep ? path_sep - sb->buf + 1 : 0);
      +}
      
       ## strbuf.h ##
     @@ strbuf.h: int launch_sequence_editor(const char *path, struct strbuf *buffer,
      +/*
      + * Remove the filename from the provided path string. If the path
      + * contains a trailing separator, then the path is considered a directory
     -+ * and nothing is modified. Returns the number of characters removed from
     -+ * the path.
     ++ * and nothing is modified.
      + *
      + * Examples:
     -+ * - "/path/to/file" -> "/path/to/" (returns: 4)
     -+ * - "/path/to/dir/" -> "/path/to/dir/" (returns: 0)
     ++ * - "/path/to/file" -> "/path/to/"
     ++ * - "/path/to/dir/" -> "/path/to/dir/"
      + */
     -+size_t strbuf_strip_file_from_path(struct strbuf *buf);
     ++void strbuf_strip_file_from_path(struct strbuf *sb);
      +
       void strbuf_add_lines(struct strbuf *sb,
       		      const char *prefix,
  7:  186e112d821 !  9:  48731438d6a bundle-uri: allow relative URLs in bundle lists
     @@ Commit message
          every push to a CDN would require altering the table of contents to
          match the expected domain and exact location within it.
      
     -    Allow a bundle list to specify a relative URI for the bundles.
     -    This allows easier distribution of bundle data.
     +    Allow a bundle list to specify a relative URI for the bundles. This URI
     +    is based on where the client received the bundle list. For a list
     +    provided in the 'bundle-uri' protocol v2 command, the Git remote URI is
     +    the base URI. Otherwise, the bundle list was provided from an HTTP URI
     +    not using the Git protocol, and that URI is the base URI. This allows
     +    easier distribution of bundle data.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ bundle-uri.h: struct bundle_list {
       	struct hashmap bundles;
      +
      +	/**
     -+	 * The baseURI of a bundle_list is used as the base for any
     -+	 * relative URIs advertised by the bundle list at that location.
     ++	 * The baseURI of a bundle_list is the URI that provided the list.
      +	 *
     -+	 * When the list is generated from a Git server, then use that
     -+	 * server's location.
     ++	 * In the case of the 'bundle-uri' protocol v2 command, the base
     ++	 * URI is the URI of the Git remote.
     ++	 *
     ++	 * Otherewise, the bundle list was downloaded over HTTP from some
     ++	 * known URI.
     ++	 *
     ++	 * The baseURI is used as the base for any relative URIs
     ++	 * advertised by the bundle list at that location.
      +	 */
      +	char *baseURI;
       };
     @@ t/t5750-bundle-uri-parse.sh: test_expect_success 'bundle_uri_parse_line() just U
      +	test_must_be_empty err &&
      +	test_cmp_config_output expect actual
      +'
     ++
     ++test_expect_success 'bundle_uri_parse_line(): relative URIs and parent paths' '
     ++	cat >in <<-\EOF &&
     ++	bundle.one.uri=bundle.bdl
     ++	bundle.two.uri=../bundle.bdl
     ++	bundle.three.uri=../../bundle.bdl
     ++	EOF
     ++
     ++	cat >expect <<-\EOF &&
     ++	[bundle]
     ++		version = 1
     ++		mode = all
     ++	[bundle "one"]
     ++		uri = <uri>/bundle.bdl
     ++	[bundle "two"]
     ++		uri = bundle.bdl
     ++	[bundle "three"]
     ++		uri = <uri>/../bundle.bdl
     ++	EOF
     ++
     ++	# TODO: We would prefer if parsing a bundle list would not cause
     ++	# a die() and instead would give a warning and allow the rest of
     ++	# a Git command to continue. This test_must_fail is necessary for
     ++	# now until the interface for relative_url() allows for reporting
     ++	# an error instead of die()ing.
     ++	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
     ++	grep "fatal: cannot strip one component off url" err
     ++'
      +
       test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty key or value' '
       	cat >in <<-\EOF &&
     @@ t/t5750-bundle-uri-parse.sh: test_expect_success 'parse config format: just URIs
       	= bogus-value
      
       ## transport.c ##
     -@@ transport.c: int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
     +@@ transport.c: int transport_get_remote_bundle_uri(struct transport *transport)
       	    (git_config_get_bool("transfer.bundleuri", &value) || !value))
       		return 0;
       
      +	if (!transport->bundles->baseURI)
      +		transport->bundles->baseURI = xstrdup(transport->url);
      +
     - 	if (!vtable->get_bundle_uri) {
     - 		if (quiet)
     - 			return -1;
     + 	if (!vtable->get_bundle_uri)
     + 		return error(_("bundle-uri operation not supported by protocol"));
     + 
  8:  f254da46a2c = 10:  69bf154bec6 bundle-uri: download bundles from an advertised list
  9:  b62b4b17481 ! 11:  7e1819162b6 clone: unbundle the advertised bundles
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      -	 * Populate transport->got_remote_bundle_uri and
      -	 * transport->bundle_uri. We might get nothing.
      -	 */
     --	transport_get_remote_bundle_uri(transport, 1);
     +-	transport_get_remote_bundle_uri(transport);
      +	if (!bundle_uri) {
      +		/*
      +		* Populate transport->got_remote_bundle_uri and
      +		* transport->bundle_uri. We might get nothing.
      +		*/
     -+		transport_get_remote_bundle_uri(transport, 1);
     ++		transport_get_remote_bundle_uri(transport);
      +
      +		if (transport->bundles &&
      +		    hashmap_get_size(&transport->bundles->bundles)) {
      +			/* At this point, we need the_repository to match the cloned repo. */
      +			if (repo_init(the_repository, git_dir, work_tree))
      +				warning(_("failed to initialize the repo, skipping bundle URI"));
     -+			if (fetch_bundle_list(the_repository,
     -+					      remote->url[0],
     -+					      transport->bundles))
     ++			else if (fetch_bundle_list(the_repository,
     ++						   remote->url[0],
     ++						   transport->bundles))
      +				warning(_("failed to fetch advertised bundles"));
      +		} else {
      +			clear_bundle_list(transport->bundles);
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       	if (mapped_refs) {
       		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
      
     + ## t/lib-bundle-uri-protocol.sh ##
     +@@ t/lib-bundle-uri-protocol.sh: test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: hav
     + '
     + 
     + test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: request bundle-uris" '
     +-	test_when_finished "rm -rf log cloned cloned2" &&
     ++	test_when_finished "rm -rf log* cloned*" &&
     + 
     + 	GIT_TRACE_PACKET="$PWD/log" \
     + 	GIT_TEST_BUNDLE_URI=0 \
     +@@ t/lib-bundle-uri-protocol.sh: test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
     + 	grep "< bundle-uri" log &&
     + 
     + 	# Client issued bundle-uri command
     +-	grep "> command=bundle-uri" log
     ++	grep "> command=bundle-uri" log &&
     ++
     ++	GIT_TRACE_PACKET="$PWD/log3" \
     ++	git \
     ++		-c transfer.bundleURI=true \
     ++		-c protocol.version=2 \
     ++		clone --bundle-uri="$BUNDLE_URI_BUNDLE_URI" \
     ++		"$BUNDLE_URI_REPO_URI" cloned3 \
     ++		>actual 2>err &&
     ++
     ++	# Server responded using protocol v2
     ++	grep "< version 2" log3 &&
     ++
     ++	# Server advertised bundle-uri capability
     ++	grep "< bundle-uri" log3 &&
     ++
     ++	# Client did not issue bundle-uri command (--bundle-uri override)
     ++	! grep "> command=bundle-uri" log3
     + '
     + 
     + test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol v2" '
     +
       ## t/t5601-clone.sh ##
      @@ t/t5601-clone.sh: test_expect_success 'reject cloning shallow repository using HTTP' '
       	git clone --no-reject-shallow $HTTPD_URL/smart/repo.git repo

-- 
gitgitgadget
