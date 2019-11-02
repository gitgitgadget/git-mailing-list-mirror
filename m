Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7238C1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 19:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfKBT0s (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 15:26:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59060 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727090AbfKBT0s (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 Nov 2019 15:26:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 224A56052F;
        Sat,  2 Nov 2019 19:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572722806;
        bh=OHvGqGjWSBPK/11vmEGtTNQs3F7YZqvMQ8Uru0N0QQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=igMHWnzSv+vdEoDeTpa7oyBODkyxpkOgL+S47uTeBAL1RmU8D5fkZZodfPO6M89LN
         HoHL6szpxXZhCb4FXcayKd8GKoiEGA57Xt8A7i4qf00ZwNALzYa5bnMAyFWughwY5P
         dgPWCC7ESu2bS2AC5f7aGgoMi1at1PkQ9c9nO9ueEJJjQ+wtEhYjVO/rCJ1kB1YMX1
         wQkd2WeDrsI8HN3fZUzby+DrztQPCRR1V+GtOg7hVoUVx/WU4Y1Hz2v/169UYyB/Ai
         gmqOr34Ts61eBDF9cF7sCqRdxVOdnPYp/dgiBWQtNXKgVjbeyYAUpae/u8s/kIycLp
         8ZFwpvLowhmfzwbbjwk1ZuZonEQMZyAQUUAXBDUC/XfjqR3AvmifLW35UDAJQ7byBI
         MOP018Y817h/Z/k5hrWaKTHhyGxMucifaqXngYhmBoC7ctOxrdUGeQgdEaWVT/Wdc0
         NeE7hzoOTaY9e/BPc5clBIYAs7VOUL1BDcJ6Y1Rt5pJw9I/Rzc2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 1/4] doc: move author and committer information to git-commit(1)
Date:   Sat,  2 Nov 2019 19:26:12 +0000
Message-Id: <20191102192615.10013-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc2.428.g50e10028f1
In-Reply-To: <20191102192615.10013-1-sandals@crustytoothpaste.net>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at one time it made perfect sense to store information about
configuring author and committer information in the documentation for
git commit-tree, in modern Git that operation is seldom used.  Most
users will use git commit and expect to find comprehensive documentation
about its use in the manual page for that command.

Considering that there is significant confusion about how one is to use
the user.name and user.email variables, let's put as much documentation
as possible into an obvious place where users will be more likely to
find it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config/user.txt     |  2 +-
 Documentation/git-commit-tree.txt | 39 ++++---------------------------
 Documentation/git-commit.txt      | 34 ++++++++++++++++++++++++---
 3 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index 0557cbbceb..a1f80e823c 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -13,7 +13,7 @@ committer.email::
 	Also, all of these can be overridden by the `GIT_AUTHOR_NAME`,
 	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`,
 	`GIT_COMMITTER_EMAIL` and `EMAIL` environment variables.
-	See linkgit:git-commit-tree[1] for more information.
+	See linkgit:git-commit[1] for more information.
 
 user.useConfigOnly::
 	Instruct Git to avoid trying to guess defaults for `user.email`
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 4b90b9c12a..d518dffce0 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -42,6 +42,10 @@ tend to just write the result to the file that is pointed at by
 `.git/HEAD`, so that we can always see what the last committed
 state was.
 
+A commit comment is read from stdin. If a changelog
+entry is not provided via "<" redirection, 'git commit-tree' will just wait
+for one to be entered and terminated with ^D.
+
 OPTIONS
 -------
 <tree>::
@@ -69,40 +73,6 @@ OPTIONS
 	Do not GPG-sign commit, to countermand a `--gpg-sign` option
 	given earlier on the command line.
 
-
-Commit Information
-------------------
-
-A commit encapsulates:
-
-- all parent object ids
-- author name, email and date
-- committer name and email and the commit time.
-
-While parent object ids are provided on the command line, author and
-committer information is taken from the following environment variables,
-if set:
-
-	GIT_AUTHOR_NAME
-	GIT_AUTHOR_EMAIL
-	GIT_AUTHOR_DATE
-	GIT_COMMITTER_NAME
-	GIT_COMMITTER_EMAIL
-	GIT_COMMITTER_DATE
-
-(nb "<", ">" and "\n"s are stripped)
-
-In case (some of) these environment variables are not set, the information
-is taken from the configuration items user.name and user.email, or, if not
-present, the environment variable EMAIL, or, if that is not set,
-system user name and the hostname used for outgoing mail (taken
-from `/etc/mailname` and falling back to the fully qualified hostname when
-that file does not exist).
-
-A commit comment is read from stdin. If a changelog
-entry is not provided via "<" redirection, 'git commit-tree' will just wait
-for one to be entered and terminated with ^D.
-
 include::date-formats.txt[]
 
 Discussion
@@ -117,6 +87,7 @@ FILES
 SEE ALSO
 --------
 linkgit:git-write-tree[1]
+linkgit:git-commit[1]
 
 GIT
 ---
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index afa7b75a23..f684f7fdc2 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -352,9 +352,6 @@ changes to tracked files.
 	these files are also staged for the next commit on top
 	of what have been staged before.
 
-:git-commit: 1
-include::date-formats.txt[]
-
 EXAMPLES
 --------
 When recording your own work, the contents of modified files in
@@ -448,6 +445,37 @@ alter the order the changes are committed, because the merge
 should be recorded as a single commit.  In fact, the command
 refuses to run when given pathnames (but see `-i` option).
 
+COMMIT INFORMATION
+------------------
+
+A commit encapsulates:
+
+- all parent object ids
+- author name, email and date
+- committer name and email and the commit time.
+
+While parent object ids are provided on the command line, author and
+committer information is taken from the following environment variables,
+if set:
+
+	GIT_AUTHOR_NAME
+	GIT_AUTHOR_EMAIL
+	GIT_AUTHOR_DATE
+	GIT_COMMITTER_NAME
+	GIT_COMMITTER_EMAIL
+	GIT_COMMITTER_DATE
+
+(nb "<", ">" and "\n"s are stripped)
+
+In case (some of) these environment variables are not set, the information
+is taken from the configuration items user.name and user.email, or, if not
+present, the environment variable EMAIL, or, if that is not set,
+system user name and the hostname used for outgoing mail (taken
+from `/etc/mailname` and falling back to the fully qualified hostname when
+that file does not exist).
+
+:git-commit: 1
+include::date-formats.txt[]
 
 DISCUSSION
 ----------
