Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0132C433E0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 19:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C2E64E56
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 19:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhB0TWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 14:22:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58970 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230355AbhB0TVA (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Feb 2021 14:21:00 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 291E560DF6;
        Sat, 27 Feb 2021 19:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614453574;
        bh=bJurNQ09ftEn7n+GJ9ZWr+ugrZN+esb6+7mQoM4FRuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ldvZVEpSnI5iP0ImKbldbPXITqgd0HYhlTvFRF/0NYwFiIt3ZDMJYTDcGLg11oM72
         2isf5teGNFMuluVwDUCeH7WEw6HRyeu0PArjbUNO+IJKNNy3yb//I+JJ267A7TZLZe
         pVnBAMeTCm7+MwYuvVBrMm3dsRfSsunxUBbPfM5nf7+BpEKPbiORS6xoyuZsPzdk6p
         IgzslyIHTxaDhNXZrD6mPAncIGYIuDMu7ilTh2rs4U3V6kQw51Re31W3wA6Z6CFsgC
         QmAulG7TM5ncjKoIgpLS5t7N4ezCCV4iAAaPGTLLtlxZV597fYwAEIEClwfWdeQZVQ
         hjhJOza6HV2bRWXlkJE1yIFDwlldVX3j+tXUf30sWN4zVc2QIHG+KMI3qqII1gIowz
         6cv990+VF104HwuzfsPPXtjZLKDLUEBD5ztFyzhwLxVsvkQC+8a27+rLdLPdc8Pkvj
         28GYpte3PUZ7Ev2gB7U9KnFNdKFM/KPeCyfJHZoLgxMWsAFuojQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/4] docs: add line ending configuration article to FAQ
Date:   Sat, 27 Feb 2021 19:18:11 +0000
Message-Id: <20210227191813.96148-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.1.721.g45526154a5
In-Reply-To: <20210227191813.96148-1-sandals@crustytoothpaste.net>
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A common source of problems when working across projects is getting line
endings to work in a consistent way.  Let's explain to users how to
configure their line endings such that they're automatically converted
using the .gitattributes file.  Update a reference to an incorrect FAQ
entry by referring to the previous entry instead of the following one.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 042b11e88a..a132f66032 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -387,6 +387,41 @@ repository will apply to all users of the repository.
 See the following entry for information about normalizing line endings as well,
 and see linkgit:gitattributes[5] for more information about attribute files.
 
+[[line-ending-gitattributes]]
+How do I fix my line endings to work well across platforms?::
+	The best way to do this is to ask Git to perform automatic line ending
+	conversion in your repository such that it always stores LF (Unix) line
+	endings in the repository and checks them out to the user's preferred endings.
+	This is done using the `text` attribute in the `.gitattributes` file in the
+	root of your repository.  If you want to use the built-in heuristic to
+	determine text files, you can write this:
++
+----
+* text=auto
+----
++
+If you have certain files that must always use specific line endings when
+checked out, such as shell scripts, or PowerShell files, you can specifically
+specify the line endings to be used, and you can also specifically mark some
+files as not wanting line-ending conversion (`-text`):
++
+----
+*.sh text eol=lf
+*.ps1 text eol=crlf
+*.jpg -text
+----
++
+When you're done making these changes to the `.gitattributes` file, run `git add
+--renormalize .` and then commit.  This will make sure that the files in the
+repository are properly stored with LF endings.
++
+Using this approach means that each developer can choose the line endings that
+are best for their environment while keeping the repository consistent, avoiding
+needless changes in the repository based on differing line endings, and allowing
+tools like `git diff` to not display spurious whitespace errors.
++
+See linkgit:gitattributes[5] for more information about attribute files.
+
 [[windows-diff-control-m]]
 I'm on Windows and git diff shows my files as having a `^M` at the end.::
 	By default, Git expects files to be stored with Unix line endings.  As such,
@@ -396,7 +431,7 @@ I'm on Windows and git diff shows my files as having a `^M` at the end.::
 +
 You can store the files in the repository with Unix line endings and convert
 them automatically to your platform's line endings.  To do that, set the
-configuration option `core.eol` to `native` and see the following entry for
+configuration option `core.eol` to `native` and see the previous entry for
 information about how to configure files as text or binary.
 +
 You can also control this behavior with the `core.whitespace` setting if you
