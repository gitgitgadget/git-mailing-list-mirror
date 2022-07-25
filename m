Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF14C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbiGYUe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiGYUep (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:34:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD20522531
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:34:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so10135642wmb.5
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pp2imNt3nzqwH+MIUUEUHRCp3LeL/HE79H76Q2NiGgw=;
        b=YVb58r5hJPfBVgx3weCvdbL+4fgY2QgCiALaSjfI4g4VF+qa8OGXGVYMBAl7OEHXJa
         hVn7kth676Gt6BRZQLcGnymk2p4yI0wnSDcdrbrpUmL9lHCsB2jwx6TUrdnbFBaac+pX
         AO55ndGrFDSvaS9p8LjfIYupN4Jvfja2eNmwPZ24NmE+HrS6/+lXEdgIyKJyiH7z84uq
         26NRcNdIgxyTW2W9Icg5jKh3saihz81XQaHmz4A3R4IunnlwO8S9989VMGeNtMMhpyhF
         u54MdiE2DY7KRYFo7iYhLDULw8k95SG91euut5ld58wPLlfBRGwZ5MlvVafcXFnaAYI/
         cWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pp2imNt3nzqwH+MIUUEUHRCp3LeL/HE79H76Q2NiGgw=;
        b=qRNRvDMw0W17qr08y+tHA46MvOTe/iJXXzzVfUgnWAOEh6BjlQkrC+Wjr9a5q+/0lI
         6BFsL56yCUilWv+aiHSyP9rct4orR5IfyIsPYMtbQxvK5yzVhlVbsCFF2bih+J87lKk1
         ikVSFn+DBIggAz4QUPI0EBkTSs+VCoV7xQseeW8wgjqLNaQ/9nwxhwlYZMesj8/LPVw0
         38MmY9Waj9MBOvjgaaGyn87bRl80A+IXiVCbFFls2qs9SpdIwvTcB+hrw1GpDwtgGYu+
         4aetzUEnwtFe8l0VscwWdZ5f01bqy4EPtigw4qV9oJLWm447O7RmHP6tw0J6cHe7d7tk
         dtMg==
X-Gm-Message-State: AJIora/pBLxPPSVf9zEAs0uw7J0a7qBVZHiotv85ZJJ5CGiCbtcEuVFw
        TaZpkQ+U02IF6JNa6Z+RTUKdhJXbOb8=
X-Google-Smtp-Source: AGRyM1uP5CIPQETiTwaXaHf4XaouFWNIi3EJKOtHlqXnZyqQVHUgG0Mw8ZsaWV5un2N9pfJINPCtRQ==
X-Received: by 2002:a05:600c:1e21:b0:3a3:27b9:8c00 with SMTP id ay33-20020a05600c1e2100b003a327b98c00mr23096360wmb.138.1658781282020;
        Mon, 25 Jul 2022 13:34:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m184-20020a1c26c1000000b003a04722d745sm19720784wmm.23.2022.07.25.13.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:34:41 -0700 (PDT)
Message-Id: <29e645a54ba7f6f5d2bcd0590d0ba747ef18fef6.1658781277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jul 2022 20:34:35 +0000
Subject: [PATCH 3/5] clone: add --bundle-uri option
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

