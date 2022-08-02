Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E84C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiHBMaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbiHBM3w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:29:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414E15073D
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:29:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so17705337wrh.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F5mnbe6cQVKNs5hDJq87ao07TTZJ+9EzkJCzIacIGYQ=;
        b=FBOlM3EpLu3pF0nPa8gWJ1BVKs+TdcLsX9XxaDfM3jpf97i208FEbkqe4W/OeRSVJX
         R9kDuKHSOkO0s/1HKn8l3R4No9dykC1v4oGTbDWYtEnPei1hbYhf9Sni/HukRZug+jE6
         N1uhp+xQ6MeoksMZCYgnw46JFVYtDk8wr0CmRj74iNwVuoy5SXDXdpaq/vmSJ1L2K3Ep
         fXqh3DoMJLV1szDx2gR9v4sKaIBeHDKjrhjbn4ejWYgJ5OOqiyJIbFyB4nPpf/GC6h04
         LCmqJhyEiwvX5CHsyw2ulwxFoJVcmcaO4wYHsRe4CR1ziNZJVTv8V7tCM5Qkbp20pa/1
         4Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F5mnbe6cQVKNs5hDJq87ao07TTZJ+9EzkJCzIacIGYQ=;
        b=yY2nThbAm4+71C28CuaBwGekeaJBMmo5uYVv5gti2Qep5tgxKO8SxskDjMeWOttw63
         CDWTwQDfsl2h/N5QvbFIXGR3TeFehLMLgz0oxyvvGJZgpPBUbRfnLmMkd+FFkUaU7ltQ
         WwD3j6Av/JvWGoNrx9V1C0zqt7b5ljohLXn5lLmpil1AwcTEs09jvkufGZ4f/I+h2l2k
         af47tcZp/GrgRS3JUFgYL6ixnKIl7nAgVpXyVcfmL5A4yRww8JF81q4ejsl9Kksa9l04
         uJPKKH6ksKntt3uGpQky7g7qPLP39V9rDMVHT7EYmzT0PaRWJzOUSfAf2iqs8UqOCNCb
         VHpw==
X-Gm-Message-State: ACgBeo13aY5A+5KbGlt12IkbNXr+0x6FTIcN4bQsleXYqwzrtzTufrXz
        OiNBRPVoJHJ48uKTSfCiePyMnBBg9Xo=
X-Google-Smtp-Source: AA6agR73pSlWUXGTuOQAJhKo6P8a+QJIuJ6/gaTOBIwHp0MA4B2vdNcVfUljcziBh0I6YiUZ6PeqRg==
X-Received: by 2002:a05:6000:508:b0:21d:4105:caf9 with SMTP id a8-20020a056000050800b0021d4105caf9mr13175372wrf.699.1659443389373;
        Tue, 02 Aug 2022 05:29:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003a3442f1229sm28763343wmq.29.2022.08.02.05.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:29:48 -0700 (PDT)
Message-Id: <00debaf6e77852efe1dcad4bfda5ebd5bf590ac4.1659443384.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
        <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Aug 2022 12:29:42 +0000
Subject: [PATCH v2 3/5] clone: add --bundle-uri option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Cloning a remote repository is one of the most expensive operations in
Git. The server can spend a lot of CPU time generating a pack-file for
the client's request. The amount of data can clog the network for a long
time, and the Git protocol is not resumable. For users with poor network
connections or are located far away from the origin server, this can be
especially painful.

Add a new '--bundle-uri' option to 'git clone' to bootstrap a clone from
a bundle. If the user is aware of a bundle server, then they can tell
Git to bootstrap the new repository with these bundles before fetching
the remaining objects from the origin server.

Reviewed-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-clone.txt |  6 ++++++
 builtin/clone.c             | 15 +++++++++++++++
 t/t5558-clone-bundle-uri.sh | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100755 t/t5558-clone-bundle-uri.sh

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 632bd1348ea..60fedf7eb5e 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -323,6 +323,12 @@ or `--mirror` is given)
 	for `host.xz:foo/.git`).  Cloning into an existing directory
 	is only allowed if the directory is empty.
 
+--bundle-uri=<uri>::
+	Before fetching from the remote, fetch a bundle from the given
+	`<uri>` and unbundle the data into the local repository. The refs
+	in the bundle will be stored under the hidden `refs/bundle/*`
+	namespace.
+
 :git-clone: 1
 include::urls.txt[]
 
diff --git a/builtin/clone.c b/builtin/clone.c
index c4ff4643ecd..4224d562758 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -34,6 +34,7 @@
 #include "list-objects-filter-options.h"
 #include "hook.h"
 #include "bundle.h"
+#include "bundle-uri.h"
 
 /*
  * Overall FIXMEs:
@@ -77,6 +78,7 @@ static int option_filter_submodules = -1;    /* unspecified */
 static int config_filter_submodules = -1;    /* unspecified */
 static struct string_list server_options = STRING_LIST_INIT_NODUP;
 static int option_remote_submodules;
+static const char *bundle_uri;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -160,6 +162,8 @@ static struct option builtin_clone_options[] = {
 		    N_("any cloned submodules will use their remote-tracking branch")),
 	OPT_BOOL(0, "sparse", &option_sparse_checkout,
 		    N_("initialize sparse-checkout file to include only files at root")),
+	OPT_STRING(0, "bundle-uri", &bundle_uri,
+		   N_("uri"), N_("a URI for downloading bundles before fetching from origin remote")),
 	OPT_END()
 };
 
@@ -1232,6 +1236,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (transport->smart_options && !deepen && !filter_options.choice)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
+	/*
+	 * Before fetching from the remote, download and install bundle
+	 * data from the --bundle-uri option.
+	 */
+	if (bundle_uri) {
+		/* At this point, we need the_repository to match the cloned repo. */
+		repo_init(the_repository, git_dir, work_tree);
+		if (fetch_bundle_uri(the_repository, bundle_uri))
+			warning(_("failed to fetch objects from bundle URI '%s'"),
+				bundle_uri);
+	}
 
 	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
 	refspec_ref_prefixes(&remote->fetch,
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
new file mode 100755
index 00000000000..f709bcb729c
--- /dev/null
+++ b/t/t5558-clone-bundle-uri.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='test fetching bundles with --bundle-uri'
+
+. ./test-lib.sh
+
+test_expect_success 'fail to clone from non-existent file' '
+	test_when_finished rm -rf test &&
+	git clone --bundle-uri="$(pwd)/does-not-exist" . test 2>err &&
+	grep "failed to download bundle from URI" err
+'
+
+test_expect_success 'fail to clone from non-bundle file' '
+	test_when_finished rm -rf test &&
+	echo bogus >bogus &&
+	git clone --bundle-uri="$(pwd)/bogus" . test 2>err &&
+	grep "is not a bundle" err
+'
+
+test_expect_success 'create bundle' '
+	git init clone-from &&
+	git -C clone-from checkout -b topic &&
+	test_commit -C clone-from A &&
+	test_commit -C clone-from B &&
+	git -C clone-from bundle create B.bundle topic
+'
+
+test_expect_success 'clone with path bundle' '
+	git clone --bundle-uri="clone-from/B.bundle" \
+		clone-from clone-path &&
+	git -C clone-path rev-parse refs/bundles/topic >actual &&
+	git -C clone-from rev-parse topic >expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget

