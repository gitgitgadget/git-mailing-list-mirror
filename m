Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3DCB20756
	for <e@80x24.org>; Wed, 11 Jan 2017 01:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756093AbdAKB5v (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 20:57:51 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34886 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755909AbdAKB5u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 20:57:50 -0500
Received: by mail-qk0-f182.google.com with SMTP id u25so578618563qki.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 17:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pU86hBjZlIe9q6dKPWJ7l/9Cavs6ChK/fIg9PtNW1sA=;
        b=f7/3IpPmAklwNLtc3NlWVttdY9r7k4jdBM1Pw7GI3LVSeQ3RVNvkcum3k8c7Zc7Nv3
         5bFf1P1Y+MsmEQOkLIgS8wltPgZDueBUJSQ0hJErnX6m/AU6uCULvvQnprwmwv4fyP5O
         Hpqitj33n0aoOHXITBxP3K54cHsvVaGRLzrdZrd/dv2U2Apb0wFPRc1vhm8SNEMW3Ow+
         WPoV0Yoq6Nux/EZqYUNplL5MEFG5PWUw7xg1Fdqt37F34Qr7di0jN3pNtCW0j02+ZvPf
         F4mFrE9s3SnSpcWylYvCrqK4rXESWMjwxSbZowPwSJDbmPSkBjocHl76gX1rOG0dMtv1
         /TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pU86hBjZlIe9q6dKPWJ7l/9Cavs6ChK/fIg9PtNW1sA=;
        b=EyPy7YtNRkyQCShC0fpLOBK7HvMEy2wEEOzR6zl1l1AVhQb+YK9MLVR5503dY6EX8v
         Ejidnf6BTC6N7PA0bS9nnO8WnzkE+VeE9lz+x+1t2RJD4hJ0obH2wYy6brMEbFT1t8ES
         oVaqYUa6T3wC93sEV+M0aKDUQyImQLJLGK+PnGPZBjT315obc+nSb6SA45NDUAnanS9r
         CVpEGxWI2dR7Ijs9UBxMae2UOhwUuJF+316k6zG7vdTiVS5w7Ia2KAzTr5rDI0QwQLpf
         gSG613o+Msbqsx3aPY8ueEKlx2qazJrp70xS2/Kgj5SMygVn7GjGhcc+uEctkzgZHpIz
         jAoQ==
X-Gm-Message-State: AIkVDXJF9L6CSYD1aXKWR59+hrTIr3rnMIkI3p4HxxbXJBuvEG4onDSZXkm5qynlkWz2O/EA
X-Received: by 10.55.124.198 with SMTP id x189mr6235459qkc.95.1484099869227;
        Tue, 10 Jan 2017 17:57:49 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id d15sm2938570qtg.22.2017.01.10.17.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 17:57:48 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 2/2] diff: document the format of the -O (diff.orderFile) file
Date:   Tue, 10 Jan 2017 20:57:20 -0500
Message-Id: <20170111015720.111223-3-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170111015720.111223-1-hansenr@google.com>
References: <20170110004031.57985-1-hansenr@google.com>
 <20170111015720.111223-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 Documentation/diff-config.txt  |  5 ++--
 Documentation/diff-options.txt | 54 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 875212045..9e4111320 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -99,11 +99,10 @@ diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.
 
 diff.orderFile::
-	File indicating how to order files within a diff, using
-	one shell glob pattern per line.
+	File indicating how to order files within a diff.
+	See the '-O' option to linkgit:git-diff[1] for details.
 	If `diff.orderFile` is a relative pathname, it is treated as
 	relative to the top of the work tree.
-	Can be overridden by the '-O' option to linkgit:git-diff[1].
 
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e6215c372..e57e9f810 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -466,11 +466,61 @@ information.
 endif::git-format-patch[]
 
 -O<orderfile>::
-	Output the patch in the order specified in the
-	<orderfile>, which has one shell glob pattern per line.
+	Control the order in which files appear in the output.
 	This overrides the `diff.orderFile` configuration variable
 	(see linkgit:git-config[1]).  To cancel `diff.orderFile`,
 	use `-O/dev/null`.
++
+The output order is determined by the order of glob patterns in
+<orderfile>.
+All files with pathnames that match the first pattern are output
+first, all files with pathnames that match the second pattern (but not
+the first) are output next, and so on.
+All files with pathnames that do not match any pattern are output
+last, as if there was an implicit match-all pattern at the end of the
+file.
+If multiple pathnames have the same rank, their output order relative
+to each other is the normal order.
++
+<orderfile> is parsed as follows:
++
+--
+ - Blank lines are ignored, so they can be used as separators for
+   readability.
+
+ - Lines starting with a hash ("`#`") are ignored, so they can be used
+   for comments.  Add a backslash ("`\`") to the beginning of the
+   pattern if it starts with a hash.
+
+ - Each other line contains a single pattern.
+--
++
+Patterns have the same syntax and semantics as patterns used for
+fnmantch(3) with the FNM_PATHNAME flag, except multiple consecutive
+unescaped asterisks (e.g., "`**`") have a special meaning:
++
+--
+ - A pattern beginning with "`**/`" means match in all directories.
+   For example, "`**/foo`" matches filename "`foo`" anywhere, and
+   "`**/foo/bar`" matches filename "`bar`" anywhere that is directly
+   under directory "`foo`".
+
+ - A pattern ending with "`/**`" matches everything inside a
+   directory, with infinite depth.  For example, "`abc/**`" matches
+   "`abc/def/ghi`" but not "`foo/abc/def`".
+
+ - A slash followed by two consecutive asterisks then a slash
+   ("`/**/`") matches zero or more directory components.  For example,
+   "`a/**/b`" matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
+
+ - A pattern with more than one consecutive unescaped asterisk is
+   invalid.
+--
++
+In addition, a pathname matches a pattern if the pathname with any
+number of its final pathname components removed matches the pattern.
+For example, the pattern "`foo/*bar`" matches "`foo/asdfbar`" and
+"`foo/bar/baz`" but not "`foo/barx`".
 
 ifndef::git-format-patch[]
 -R::
-- 
2.11.0.390.gc69c2f50cf-goog

