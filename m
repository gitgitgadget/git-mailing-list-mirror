Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6721F424
	for <e@80x24.org>; Fri, 13 Apr 2018 09:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754051AbeDMJnT (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 05:43:19 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33027 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753763AbeDMJnR (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Apr 2018 05:43:17 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id DF5C120BC2;
        Fri, 13 Apr 2018 05:43:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 13 Apr 2018 05:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/+yoBI
        daAbUmRNx8TDs5xNlzh06bjiaaE9wD/ruEND8=; b=VVkQIszs8NyegJp+86PVtl
        FAWdp82Ha5J8nhcwFRYBfqQUD/6GN6CmSeXr1uGxe1NTt73LCKwf9lVBoBJiigZY
        1sUk2zDn3Z6mVFoa/rGRoeJKMxmLiW7XpyHSo3/pKnf5hYtZ4vdPxux+QWHA6IPL
        MOFASUEvnSBYU8DRtajFVPwVgd77CH/atFAl5CMciynTsmPE2woyBHllTkDr1Ek9
        qCXXfpAJNlZPEOtst+mx5PsHsZidFLx6hBKRKxnEej6AW5rLS+jlFPIiPhsJG8qZ
        L4uZAoRiX316egQub+/KoAjqFPHpyfwIWIO8zMHBzjytc34AyDdSd2JUYDZ2LV6A
        ==
X-ME-Sender: <xms:tHvQWutO6AElAgeyWrxd-jmeg-0wZcidUpvVdwqbV9IRP4wuiHbfFQ>
Received: from bod.fritz.box (p54826bc2.dip0.t-ipconnect.de [84.130.107.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4AE23E442C;
        Fri, 13 Apr 2018 05:43:16 -0400 (EDT)
Received: by bod.fritz.box (Postfix, from userid 1000)
        id 6CD967C0179; Fri, 13 Apr 2018 11:43:14 +0200 (CEST)
Date:   Fri, 13 Apr 2018 11:43:14 +0200
From:   Michael Vogt <mvo@ubuntu.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] Add "git show --follow-symlinks HEAD:symlink"
Message-ID: <20180413094314.GA2404@bod>
References: <20180409090047.lfru2ul5fbnggfg7@bod>
 <87in90zq2a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87in90zq2a.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Ævar,

thanks for your quick reply!

On Mon, Apr 09, 2018 at 11:28:45AM +0200, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Apr 09 2018, Michael Vogt wrote:
[..]
> > Subject: [PATCH] support: git show --follow-symlinks HEAD:symlink
> >
> > Add support for the `--follow-symlinks` options to git-show. This
> > allows to write:
> >
> >     git show --follow-symlink HEAD:path-a-symlink
> 
> The patch looks reasonable, but please submit it as described in
> Documentation/SubmittingPatches, i.e. inline instead of as an
> attachment, and with a signed-off-by line etc. We'd also need some tests
> for this.

Thanks for the intial reivew. I updated the patch with a test and
documentation for the new option. Happy to merge the test into one of
the existing test files, I read t/README and greping around I did not
find a place that looked like a good fit. 

I added the updated patch as an mutt inline attachment now.

Cheers,
 Michael

--cNdxnHkX5QqsyA0e
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0001-support-git-show-follow-symlinks-HEAD-symlink.patch"

From 5a9faa9eff00f316fc654c8e3bc85c3ba56ea659 Mon Sep 17 00:00:00 2001
From: Michael Vogt <mvo@ubuntu.com>
Date: Mon, 9 Apr 2018 10:38:13 +0200
Subject: [PATCH] support: git show --follow-symlinks HEAD:symlink

Add support for the `--follow-symlinks` options to git-show. This
allows to write:

    git show --follow-symlink HEAD:path-a-symlink

to get the content of the symlinked file.

Signed-off-by: Michael Vogt <mvo@ubuntu.com>
---
 Documentation/git-show.txt |  6 ++++++
 builtin/log.c              |  7 +++++--
 revision.c                 |  2 ++
 revision.h                 |  1 +
 t/t1800-git-show.sh        | 41 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100755 t/t1800-git-show.sh

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index e73ef5401..fa751c35d 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -39,6 +39,12 @@ OPTIONS
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 
+--follow-symlinks::
+	Follow symlinks inside the repository when requesting objects
+	with extended SHA-1 expressions of the form tree-ish:path-in-tree.
+	Instead of output about the link itself, provide output about
+	the linked-to object.
+
 include::pretty-options.txt[]
 
 
diff --git a/builtin/log.c b/builtin/log.c
index 94ee177d5..e92af4fc7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -142,7 +142,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	struct userformat_want w;
-	int quiet = 0, source = 0, mailmap = 0;
+	int quiet = 0, source = 0, mailmap = 0, follow_symlinks = 0;
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
 	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
 	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
@@ -162,6 +162,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
 			     N_("Process line range n,m in file, counting from 1"),
 			     log_line_range_callback),
+		OPT_BOOL(0, "follow-symlinks", &follow_symlinks,
+			 N_("follow in-tree symlinks (used when showing file content)")),
 		OPT_END()
 	};
 
@@ -173,9 +175,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			     builtin_log_options, builtin_log_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
-
 	if (quiet)
 		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
+	if (follow_symlinks)
+		rev->follow_symlinks = 1;
 	argc = setup_revisions(argc, argv, rev, opt);
 
 	/* Any arguments at this point are not recognized */
diff --git a/revision.c b/revision.c
index b42c836d7..4ab22313f 100644
--- a/revision.c
+++ b/revision.c
@@ -1678,6 +1678,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 
 	if (revarg_opt & REVARG_COMMITTISH)
 		get_sha1_flags |= GET_OID_COMMITTISH;
+	if (revs && revs->follow_symlinks)
+		get_sha1_flags |= GET_OID_FOLLOW_SYMLINKS;
 
 	if (get_oid_with_context(arg, get_sha1_flags, &oid, &oc))
 		return revs->ignore_missing ? 0 : -1;
diff --git a/revision.h b/revision.h
index b8c47b98e..060f1038a 100644
--- a/revision.h
+++ b/revision.h
@@ -122,6 +122,7 @@ struct rev_info {
 			first_parent_only:1,
 			line_level_traverse:1,
 			tree_blobs_in_commit_order:1,
+			follow_symlinks:1,
 
 			/* for internal use only */
 			exclude_promisor_objects:1;
diff --git a/t/t1800-git-show.sh b/t/t1800-git-show.sh
new file mode 100755
index 000000000..86fe8ee02
--- /dev/null
+++ b/t/t1800-git-show.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='Test git show works'
+
+. ./test-lib.sh
+
+test_expect_success 'verify git show HEAD:foo works' '
+    echo "foo content" > foo &&
+    git add foo &&
+    git commit -m "added foo" &&
+    content=$(git show HEAD:foo) &&
+    test "$content" = "foo content"
+'
+
+test_expect_success 'verify git show HEAD:symlink shows symlink points to foo' '
+    echo "foo content" > foo &&
+    ln -s foo symlink &&
+    git add foo symlink &&
+    git commit -m "added foo and a symlink to foo" &&
+    content=$(git show HEAD:foo) &&
+    test "$content" = "foo content" &&
+    symlink=$(git show HEAD:symlink) &e& 
+    test "$symlink" = "foo"
+'
+
+test_expect_success 'verify git show --follow-symlinks HEAD:symlink shows foo' '
+    content=$(git show --follow-symlinks HEAD:symlink) &&
+    test "$content" = "foo content"
+'
+
+test_expect_success 'verify git show --follow-symlinks HEAD:symlink works with subdirs' '
+    mkdir dir &&
+    ln -s dir symlink-to-dir &&
+    echo "bar content" > dir/bar &&
+    git add dir symlink-to-dir &&
+    git commit -m "add dir and symlink-to-dir" &&
+    content=$(git show --follow-symlinks HEAD:symlink-to-dir/bar) &&
+    test "$content" = "bar content"
+'
+
+test_done
-- 
2.17.0


--cNdxnHkX5QqsyA0e--
