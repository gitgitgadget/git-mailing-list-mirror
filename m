Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CF3C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0197B61073
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbhJ0Iad (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbhJ0IaH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:30:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A32C061232
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u18so2685316wrg.5
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cq7xpzv9Jt0r+m3QH1PsZIBW9iGrieo+DLK5++RfiqM=;
        b=oFdw7oeiNKexhnTovaZ2H5pNYmOpnVh100E0hnn/QOak9Lyn0BGEca6avMMqkYqE6+
         UlygtapeVIfDKgWB9OfTSCZPHRm7PMGOQXdnOH5XojmCAClactqEZO4VMyzPmW5r0a5P
         0yEs2PlnAUPpUx8x1gXHJ3zcBSKC3bwjJUeeHVJnvmbLhZeEoAjUqWpqwSCtc7l1f5n2
         pT7D8t5XvnBYgTbSNlITg6Ay2RhSr/dzmlfY1bVviWcbFvwTpv70GJDOsPaSwazJ6VW0
         CkDYQzsXQYu202Iqx0qFWKSl40llECamjiAk9byhQ+XCT4QgQ2QwL5e98KwnaRCcNR2b
         A4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cq7xpzv9Jt0r+m3QH1PsZIBW9iGrieo+DLK5++RfiqM=;
        b=nRbwG1iTi4dOG3mLyZ00DkSLyZ/1FDbV9TAaJAb0+STkikXQ7bgyQde7OJKTPYJR0z
         +GcWkzrZ2+VsZEP8v8ctVfE3ErK422+viZt7AAGm9pqwLsRoiiYz34gpjhOwcJ0QfVqJ
         CQd4RWWcw1dKJjMLxFhU0CAFv/dt38pH3KzExyfSBMniMAHZrojIdgkLndlhbHHFqwfq
         3DcveK5UWWII5dwuv0geuMEqdWtYi/9wNVsmY9lxGtV1X/TDxdNHqI6rt2xX3s8aYGgq
         6aOJ2PATF+jrae/45C06dYhlyrew4LAa62IhRZjX3UDRiSg+h+5dC5PpTCFV/4UxQ2+0
         68iA==
X-Gm-Message-State: AOAM532+aPvnxd04xo/A1CZrFeryooRfB8EWQy+lMVD3glXboyu+W1Vt
        8rBjJlXpLGVV/Q/LxXSeNT51p7s38zM=
X-Google-Smtp-Source: ABdhPJxwaWxHhsjSU71/Ur9x/+r9c8GERKGelOVcBluu7EdIo9muIeMY7/fQurb8JA53UCV6CHWmag==
X-Received: by 2002:adf:b350:: with SMTP id k16mr38497497wrd.368.1635323248877;
        Wed, 27 Oct 2021 01:27:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2sm21633262wrb.20.2021.10.27.01.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:27:28 -0700 (PDT)
Message-Id: <5ca169b3f3a0aead986ba2e7bb31ae5678bdc37a.1635323239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
References: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
        <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 08:27:18 +0000
Subject: [PATCH v6 14/15] scalar: implement the `version` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The .NET version of Scalar has a `version` command. This was necessary
because it was versioned independently of Git.

Since Scalar is now tightly coupled with Git, it does not make sense for
them to show different versions. Therefore, it shows the same output as
`git version`. For backwards-compatibility with the .NET version,
`scalar version` prints to `stderr`, though (`git version` prints to
`stdout` instead).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 8aaeca7cc64..b2e92cf63b5 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -10,6 +10,7 @@
 #include "refs.h"
 #include "dir.h"
 #include "packfile.h"
+#include "help.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -356,6 +357,15 @@ static int delete_enlistment(struct strbuf *enlistment)
 	return 0;
 }
 
+/*
+ * Dummy implementation; Using `get_version_info()` would cause a link error
+ * without this.
+ */
+void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
+{
+	die("not implemented");
+}
+
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
@@ -749,6 +759,34 @@ static int cmd_delete(int argc, const char **argv)
 	return res;
 }
 
+static int cmd_version(int argc, const char **argv)
+{
+	int verbose = 0, build_options = 0;
+	struct option options[] = {
+		OPT__VERBOSE(&verbose, N_("include Git version")),
+		OPT_BOOL(0, "build-options", &build_options,
+			 N_("include Git's build options")),
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar verbose [-v | --verbose] [--build-options]"),
+		NULL
+	};
+	struct strbuf buf = STRBUF_INIT;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	if (argc != 0)
+		usage_with_options(usage, options);
+
+	get_version_info(&buf, build_options);
+	fprintf(stderr, "%s\n", buf.buf);
+	strbuf_release(&buf);
+
+	return 0;
+}
+
 static struct {
 	const char *name;
 	int (*fn)(int, const char **);
@@ -760,6 +798,7 @@ static struct {
 	{ "run", cmd_run },
 	{ "reconfigure", cmd_reconfigure },
 	{ "delete", cmd_delete },
+	{ "version", cmd_version },
 	{ NULL, NULL},
 };
 
-- 
gitgitgadget

