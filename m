Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3A81F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 19:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbdCBTGB (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 14:06:01 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33960 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbdCBTF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 14:05:59 -0500
Received: by mail-wr0-f193.google.com with SMTP id u48so10724115wrc.1
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 11:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sbhFXjH75sBahMT40IzGxqLKvBzawLEIdC5LYEiq5Xg=;
        b=Le2rLtdzU7Xqknqt9lPltpW8ExwVjnPxxy0CGieEIIhFdKRW1h62USQKct5woL7lYs
         7VnvKhPFZAas3ow3m+mKGeZoAeQA+JvZoJNCA8k3agP3kKrPHJeb3MvRcEovuwsIBRCc
         IKW+Hso8KAOF+gVvKm63FZ0EAspdaLiUcEQlyFlAS0MUepS7ocmufHzOrItstmBVaS4l
         j8N8mJnKy9mtou/4VanIAcXt9gtysF7dEBU7eqTa3I/bsSTtyID413dcVaZmacDYDGhi
         JAplcOFH9oN85KeGUa3lbpwOt8x7/h5QnSfxmJzYBxE98rZq2nvlFd8f1rupBSYPxb8I
         3XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sbhFXjH75sBahMT40IzGxqLKvBzawLEIdC5LYEiq5Xg=;
        b=Osnl/KGEQPN9tAN0kIl7T5HQLocEcB5+5gXE0NGKHk4fmPg+eOVSDLkDW8ERF3FNZs
         VIbZGlC2Vll6AA8+gcDbvJiYxaa65Yvxg6AvlWJstHXxQv8wwHr3WvYLORRxoZI7SAiA
         elbjEb4NLbnWr6XaJRTmwfwFxXsw4ZWGj1ZgT7UkXOywTCFdyybFoogbRdrKApuyy+H5
         q5omg/rr6bqTqsOBogc/ZGVGBBUsytZG1ezYk6Ak+ynVMsWHVBrA/qDYJXkHY12WTvaV
         ND8R8LryF11bsd1gMiBucDr0dhHTRGg8CHD70ZU44MjQ7qapPXruNpMnFA/KiM4vBMkt
         pLuQ==
X-Gm-Message-State: AMke39milMN9lR/0DcGcHOIrroHfyl9fqDT1f6A9aBVDMSvcpvmFzxaCfO0WVPEp8HBD6Q==
X-Received: by 10.223.135.215 with SMTP id c23mr13376626wrc.135.1488481447148;
        Thu, 02 Mar 2017 11:04:07 -0800 (PST)
Received: from arrakeen.fritz.box ([2001:a61:1062:9001:31e2:d513:37f3:8b3b])
        by smtp.gmail.com with ESMTPSA id 186sm28094129wmw.24.2017.03.02.11.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Mar 2017 11:04:06 -0800 (PST)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com
Cc:     Andreas Heiduk <asheiduk@gmail.com>, git@vger.kernel.org
Subject: [PATCH v3] Documentation: Improve description for core.quotePath
Date:   Thu,  2 Mar 2017 20:03:52 +0100
Message-Id: <1488481432-25336-1-git-send-email-asheiduk@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linking the description for pathname quoting to the configuration
variable "core.quotePath" removes inconstistent and incomplete
sections while also giving two hints how to deal with it: Either with
"-c core.quotePath=false" or with "-z".

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/config.txt              | 23 +++++++++++++----------
 Documentation/diff-format.txt         |  7 ++++---
 Documentation/diff-generate-patch.txt |  7 +++----
 Documentation/diff-options.txt        |  7 +++----
 Documentation/git-apply.txt           |  7 +++----
 Documentation/git-commit.txt          |  9 ++++++---
 Documentation/git-ls-files.txt        | 10 ++++++----
 Documentation/git-ls-tree.txt         | 10 +++++++---
 Documentation/git-status.txt          |  7 +++----
 9 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 015346c..23233d8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -350,16 +350,19 @@ core.checkStat::
 	all fields, including the sub-second part of mtime and ctime.
 
 core.quotePath::
-	The commands that output paths (e.g. 'ls-files',
-	'diff'), when not given the `-z` option, will quote
-	"unusual" characters in the pathname by enclosing the
-	pathname in a double-quote pair and with backslashes the
-	same way strings in C source code are quoted.  If this
-	variable is set to false, the bytes higher than 0x80 are
-	not quoted but output as verbatim.  Note that double
-	quote, backslash and control characters are always
-	quoted without `-z` regardless of the setting of this
-	variable.
+	Commands that output paths (e.g. 'ls-files', 'diff'), will
+	quote "unusual" characters in the pathname by enclosing the
+	pathname in double-quotes and escaping those characters with
+	backslashes in the same way C escapes control characters (e.g.
+	`\t` for TAB, `\n` for LF, `\\` for backslash) or bytes with
+	values larger than 0x80 (e.g. octal `\302\265` for "micro" in
+	UTF-8).  If this variable is set to false, bytes higher than
+	0x80 are not considered "unusual" any more. Double-quotes,
+	backslash and control characters are always escaped regardless
+	of the setting of this variable.  A simple space character is
+	not considered "unusual".  Many commands can output pathnames
+	completely verbatim using the `-z` option. The default value
+	is true.
 
 core.eol::
 	Sets the line ending type to use in the working directory for
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index cf52626..706916c 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -78,9 +78,10 @@ Example:
 :100644 100644 5be4a4...... 000000...... M file.c
 ------------------------------------------------
 
-When `-z` option is not used, TAB, LF, and backslash characters
-in pathnames are represented as `\t`, `\n`, and `\\`,
-respectively.
+Without the `-z` option, pathnames with "unusual" characters are
+quoted as explained for the configuration variable `core.quotePath`
+(see linkgit:git-config[1]).  Using `-z` the filename is output
+verbatim and the line is terminated by a NUL byte.
 
 diff format for merges
 ----------------------
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index d2a7ff5..231105c 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -53,10 +53,9 @@ The index line includes the SHA-1 checksum before and after the change.
 The <mode> is included if the file mode does not change; otherwise,
 separate lines indicate the old and the new mode.
 
-3.  TAB, LF, double quote and backslash characters in pathnames
-    are represented as `\t`, `\n`, `\"` and `\\`, respectively.
-    If there is need for such substitution then the whole
-    pathname is put in double quotes.
+3.  Pathnames with "unusual" characters are quoted as explained for
+    the configuration variable `core.quotePath` (see
+    linkgit:git-config[1]).
 
 4.  All the `file1` files in the output refer to files before the
     commit, and all the `file2` files refer to files after the commit.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index d91ddbd..89cc0f4 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -192,10 +192,9 @@ ifndef::git-log[]
 	given, do not munge pathnames and use NULs as output field terminators.
 endif::git-log[]
 +
-Without this option, each pathname output will have TAB, LF, double quotes,
-and backslash characters replaced with `\t`, `\n`, `\"`, and `\\`,
-respectively, and the pathname will be enclosed in double quotes if
-any of those replacements occurred.
+Without this option, pathnames with "unusual" characters are quoted as
+explained for the configuration variable `core.quotePath` (see
+linkgit:git-config[1]).
 
 --name-only::
 	Show only names of changed files.
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 8ddb207..631cbd8 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -108,10 +108,9 @@ the information is read from the current index instead.
 	When `--numstat` has been given, do not munge pathnames,
 	but use a NUL-terminated machine-readable format.
 +
-Without this option, each pathname output will have TAB, LF, double quotes,
-and backslash characters replaced with `\t`, `\n`, `\"`, and `\\`,
-respectively, and the pathname will be enclosed in double quotes if
-any of those replacements occurred.
+Without this option, pathnames with "unusual" characters are quoted as
+explained for the configuration variable `core.quotePath` (see
+linkgit:git-config[1]).
 
 -p<n>::
 	Remove <n> leading slashes from traditional diff paths. The
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 4f8f20a..25dcdcc 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -117,9 +117,12 @@ OPTIONS
 
 -z::
 --null::
-	When showing `short` or `porcelain` status output, terminate
-	entries in the status output with NUL, instead of LF. If no
-	format is given, implies the `--porcelain` output format.
+	When showing `short` or `porcelain` status output, print the
+	filename verbatim and terminate the entries with NUL, instead of LF.
+	If no format is given, implies the `--porcelain` output format.
+	Without the `-z` option, filenames with "unusual" characters are
+	quoted as explained for the configuration variable `core.quotePath`
+	(see linkgit:git-config[1]).
 
 -F <file>::
 --file=<file>::
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 446209e..1cab703 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -77,7 +77,8 @@ OPTIONS
 	succeed.
 
 -z::
-	\0 line termination on output.
+	\0 line termination on output and do not quote filenames.
+	See OUTPUT below for more information.
 
 -x <pattern>::
 --exclude=<pattern>::
@@ -196,9 +197,10 @@ the index records up to three such pairs; one from tree O in stage
 the user (or the porcelain) to see what should eventually be recorded at the
 path. (see linkgit:git-read-tree[1] for more information on state)
 
-When `-z` option is not used, TAB, LF, and backslash characters
-in pathnames are represented as `\t`, `\n`, and `\\`,
-respectively.
+Without the `-z` option, pathnames with "unusual" characters are
+quoted as explained for the configuration variable `core.quotePath`
+(see linkgit:git-config[1]).  Using `-z` the filename is output
+verbatim and the line is terminated by a NUL byte.
 
 
 Exclude Patterns
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index dbc91f9..9dee7be 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -53,7 +53,8 @@ OPTIONS
 	Show object size of blob (file) entries.
 
 -z::
-	\0 line termination on output.
+	\0 line termination on output and do not quote filenames.
+	See OUTPUT FORMAT below for more information.
 
 --name-only::
 --name-status::
@@ -82,8 +83,6 @@ Output Format
 -------------
         <mode> SP <type> SP <object> TAB <file>
 
-Unless the `-z` option is used, TAB, LF, and backslash characters
-in pathnames are represented as `\t`, `\n`, and `\\`, respectively.
 This output format is compatible with what `--index-info --stdin` of
 'git update-index' expects.
 
@@ -95,6 +94,11 @@ Object size identified by <object> is given in bytes, and right-justified
 with minimum width of 7 characters.  Object size is given only for blobs
 (file) entries; for other entries `-` character is used in place of size.
 
+Without the `-z` option, pathnames with "unusual" characters are
+quoted as explained for the configuration variable `core.quotePath`
+(see linkgit:git-config[1]).  Using `-z` the filename is output
+verbatim and the line is terminated by a NUL byte.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 725065e..ba87365 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -322,10 +322,9 @@ When the `-z` option is given, pathnames are printed as is and
 without any quoting and lines are terminated with a NUL (ASCII 0x00)
 byte.
 
-Otherwise, all pathnames will be "C-quoted" if they contain any tab,
-linefeed, double quote, or backslash characters. In C-quoting, these
-characters will be replaced with the corresponding C-style escape
-sequences and the resulting pathname will be double quoted.
+Without the `-z` option, pathnames with "unusual" characters are
+quoted as explained for the configuration variable `core.quotePath`
+(see linkgit:git-config[1]).
 
 
 CONFIGURATION
