Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B13271F89C
	for <e@80x24.org>; Sun, 15 Jan 2017 22:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbdAOWRH (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 17:17:07 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34083 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdAOWRF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 17:17:05 -0500
Received: by mail-qk0-f173.google.com with SMTP id a20so103520932qkc.1
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 14:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gFA3R/V9F0L4hTEamcyZ2Etfw9JUoC58Nc9qPnvrY9w=;
        b=szki8g9nFC3wvOD6i9rqil86hBm/mi0ihExHVtarz5YKlPAdeFEzqRzWU++cMwh8Ru
         8mueyyjWcgZmqj4NgQWofPRXh3C3ORqJkVUINAK3HyyfhqD1Dns7St965E/8h0r+q89E
         IEISYToR9ifXuyKiBohuH2eGEuNAmvdVE45Fc4wN+K6pG8ZJCTDMgAubi+gdPXG5k16N
         jik+gW4LHmWwupH+EwOjQw0XHKvK1i6GKcWyyxUV8BleTIvyAr6PF1Da60QhcTHlSLgc
         Ga4i8Ua6xF9+hiFNvb5TuksKFiKqAU+smuQAzoB/uSd8ba4vKnpIYnCLV0Lysf4zPrt7
         puLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gFA3R/V9F0L4hTEamcyZ2Etfw9JUoC58Nc9qPnvrY9w=;
        b=L1rO5gOPdTemYDvQrv8HjHsognifTc7q3QSvqnFSZSrmYxVjFXrC/QYx8fLpOXYd58
         YYBA15YF+KodKYv2Hk1kv9ZRm2LU2T1Z8I3d2uFr7AKwrqG0gO6C1kZh4QzyLgwRPIp1
         LepTMv+19DsUmAwGM89+FVrDFsDYtDD9SHAMGQdviLkbHMuyY7MorQNiAx8ubqgFpyRo
         Ye3pULvWQwoA2uPNy7bq1twZOrZCRggi+fMfAZCe9w0XiT31jyqE7ALbb06tpgvC0RJh
         U2ZStAhHs5vimyaVNB+WIFjYoDctpo1wjKxZpypiKI8UhwNvVYQcqXFWPSPOU5+/M07c
         Hofw==
X-Gm-Message-State: AIkVDXLsKwIm2l2+Oq81edcF9+wmMfZwOWovKGa+EeFlPoLp9rYzqWqcJlgOz4FBLd/q8YHU
X-Received: by 10.233.232.202 with SMTP id a193mr27633587qkg.113.1484518624450;
        Sun, 15 Jan 2017 14:17:04 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id o7sm1374511qte.30.2017.01.15.14.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Jan 2017 14:17:04 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v3 2/2] diff: document the format of the -O (diff.orderFile) file
Date:   Sun, 15 Jan 2017 17:16:31 -0500
Message-Id: <20170115221631.78838-3-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170115221631.78838-1-hansenr@google.com>
References: <20170111015720.111223-1-hansenr@google.com>
 <20170115221631.78838-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 Documentation/diff-config.txt  |  5 ++---
 Documentation/diff-options.txt | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 5 deletions(-)

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
index e6215c372..d4fb70704 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -466,11 +466,41 @@ information.
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
+If multiple pathnames have the same rank (they match the same pattern
+but no earlier patterns), their output order relative to each other is
+the normal order.
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
+fnmantch(3) without the FNM_PATHNAME flag, except a pathname also
+matches a pattern if removing any number of the final pathname
+components matches the pattern.  For example, the pattern "`foo*bar`"
+matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
 
 ifndef::git-format-patch[]
 -R::
-- 
2.11.0.483.g087da7b7c-goog

