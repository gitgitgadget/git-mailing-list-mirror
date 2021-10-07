Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB9BC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 11:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C4361038
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 11:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241090AbhJGLBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbhJGLBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:01:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACFBC061775
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:59:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s15so17816486wrv.11
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kICDSfcRYpWtR/TkrbdlrrkyOK3hh+156uSWJrG1Tkk=;
        b=Codkc+Sipxh0QBnP4TlitSLaLMIn6yP2RW3nihQdAPFSowLEZ2H1QPB2zcO8BEc/mM
         GW/fcd1raIDI5c63ko8XLvH11JGJ/ZZ49AOviEqDB+eIY3NZFNh5i6q9BYr2bgptaYB/
         k+C4cr7chVC/ppOf9kc1B6XfJbs1boAYLLk3uLPxalSrfBRhUJFg0pqfCLPH/6JfOSnh
         raGZ/hNRzkAAo6NjF6L6LejYlaPmuzcsQUcwvX8a/xpYlrmLrLC4dlRfI8ftwQ5USXia
         Sk6PYmAta2z/zkbuxvj2XLfxG+a8O5bRT8y/tgUXxnhTmHjvixE0UMH0wGrWgZtkhoVE
         qy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kICDSfcRYpWtR/TkrbdlrrkyOK3hh+156uSWJrG1Tkk=;
        b=TpHH5LNqb3+ulAc+Vb8/LeAUNqI2LTsD5sLxmJ9V22hO1rKDrnvVMCcPIIJlBuRY4+
         kKA9ejsutbCzT4WWrJIWryT/61QifTP/i7HeZjbm+IzoejtR957Lur5FrD2ykZlHYP75
         Il7lWdd8wrTjLaaERuVr3/q7PsTR6F4lua2XGwBV0d3MGXtB8033a3IOS5QYiRocqHEj
         4x0YWkdauLG8/WjdjE/qDJeAhpMapEJvvTPnk4mjdWPNxpAXRL265TNaW+HAzateo96i
         aAZgemQRhEADIDIT2uFZwSf+yoqWBPLwxPPYe8utNo1sYyBtfU9eXDsKvkaYhoEQEOB1
         HtiA==
X-Gm-Message-State: AOAM533KZnsu/G/pUS2I729phasRGpGEMfKQ2iayfNKmxxxwRgVevBCe
        xmH4UOcdM/m/i8B8JhawTUQRA7fCKis=
X-Google-Smtp-Source: ABdhPJymxRabFsBfRKXuwRaU2aHhF+ZlxfF16+dfRxaLDfH8NxTWoS1jejz64bP9aDwtcJE/X4qABw==
X-Received: by 2002:adf:a30b:: with SMTP id c11mr4480916wrb.289.1633604359273;
        Thu, 07 Oct 2021 03:59:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x17sm23963280wrc.51.2021.10.07.03.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:59:18 -0700 (PDT)
Message-Id: <8069cc536fedce2c4707efa87832bc06b443060f.1633604349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 10:59:07 +0000
Subject: [PATCH v5 13/15] scalar: implement the `delete` command
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
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Delete an enlistment by first unregistering the repository and then
deleting the enlistment directory (usually the directory containing the
worktree `src/` directory).

On Windows, if the current directory is inside the enlistment's
directory, change to the parent of the enlistment directory, to allow us
to delete the enlistment (directories used by processes e.g. as current
working directories cannot be deleted on Windows).

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 63 ++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        |  8 ++++
 contrib/scalar/t/t9099-scalar.sh |  9 +++++
 3 files changed, 80 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 234a7dce479..8aaeca7cc64 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -8,6 +8,8 @@
 #include "config.h"
 #include "run-command.h"
 #include "refs.h"
+#include "dir.h"
+#include "packfile.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -327,6 +329,33 @@ static char *remote_default_branch(const char *url)
 	return NULL;
 }
 
+static int delete_enlistment(struct strbuf *enlistment)
+{
+#ifdef WIN32
+	struct strbuf parent = STRBUF_INIT;
+#endif
+
+	if (unregister_dir())
+		die(_("failed to unregister repository"));
+
+#ifdef WIN32
+	/*
+	 * Change the current directory to one outside of the enlistment so
+	 * that we may delete everything underneath it.
+	 */
+	strbuf_addbuf(&parent, enlistment);
+	strbuf_parent_directory(&parent);
+	if (chdir(parent.buf) < 0)
+		die_errno(_("could not switch to '%s'"), parent.buf);
+	strbuf_release(&parent);
+#endif
+
+	if (remove_dir_recursively(enlistment, 0))
+		die(_("failed to delete enlistment directory"));
+
+	return 0;
+}
+
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
@@ -687,6 +716,39 @@ static int cmd_unregister(int argc, const char **argv)
 	return unregister_dir();
 }
 
+static int cmd_delete(int argc, const char **argv)
+{
+	char *cwd = xgetcwd();
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar delete <enlistment>"),
+		NULL
+	};
+	struct strbuf enlistment = STRBUF_INIT;
+	int res = 0;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	if (argc != 1)
+		usage_with_options(usage, options);
+
+	setup_enlistment_directory(argc, argv, usage, options, &enlistment);
+
+	if (dir_inside_of(cwd, enlistment.buf) >= 0)
+		res = error(_("refusing to delete current working directory"));
+	else {
+		close_object_store(the_repository->objects);
+		res = delete_enlistment(&enlistment);
+	}
+	strbuf_release(&enlistment);
+	free(cwd);
+
+	return res;
+}
+
 static struct {
 	const char *name;
 	int (*fn)(int, const char **);
@@ -697,6 +759,7 @@ static struct {
 	{ "unregister", cmd_unregister },
 	{ "run", cmd_run },
 	{ "reconfigure", cmd_reconfigure },
+	{ "delete", cmd_delete },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 2fa96fcabc6..6fc57707718 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -14,6 +14,7 @@ scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 scalar reconfigure [ --all | <enlistment> ]
+scalar delete <enlistment>
 
 DESCRIPTION
 -----------
@@ -127,6 +128,13 @@ reconfigure the enlistment.
 With the `--all` option, all enlistments currently registered with Scalar
 will be reconfigured. Use this option after each Scalar upgrade.
 
+Delete
+~~~~~~
+
+delete <enlistment>::
+	This subcommand lets you delete an existing Scalar enlistment from your
+	local file system, unregistering the repository.
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 5fe7fabd0e5..7e8771d0eff 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -76,4 +76,13 @@ test_expect_success 'scalar reconfigure' '
 	test true = "$(git -C one/src config core.preloadIndex)"
 '
 
+test_expect_success 'scalar delete without enlistment shows a usage' '
+	test_expect_code 129 scalar delete
+'
+
+test_expect_success 'scalar delete with enlistment' '
+	scalar delete cloned &&
+	test_path_is_missing cloned
+'
+
 test_done
-- 
gitgitgadget

