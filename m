Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99770C43457
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4DB222E9
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="MqYIcNtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389714AbgJTBGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 21:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgJTBGT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 21:06:19 -0400
Received: from pine.sfconservancy.org (pine.sfconservancy.org [IPv6:2001:4801:7822:103:be76:4eff:fe10:7c55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EA9C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 18:06:19 -0700 (PDT)
Received: from localhost (unknown [216.161.86.18])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id 88035E471;
        Tue, 20 Oct 2020 01:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1603155978;
        bh=qZohXIs/OIcaE6h0Ps84YrflOHfGWkNB0ReoXgtgiOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqYIcNtdZNiExztCXJpGhOKk6xTAkMwNyV82VeUJSjjhMAa7iCGHpHNRzuyD/TMl9
         GH80BC54ay0DQYok7PrV1efwYFpbPuQnzmMCPF6aTflRoH19NqTh8X+J2QME5MfQZX
         ztANfcVjnbWeeWyVbqUEpJwUcmVMdZDPR5MgX1si1uj95wqzodfOBaxI7JHohfotIH
         V9Y4GWpUmQtVmigt8AOo4IItlr4q1aZhsFSr8+Oo9/i04klyHPnmWrrLdBW5twjN/2
         pVrlFThE9Khxg4/xE0sMOD2VJLOwPwqrI8d6wL4g/PGq018dupQlWEh2f3ltH5ICqT
         ooaCVLtUBmzvg==
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 1/4] doc: preparatory clean-up of description on the sign-off option
Date:   Mon, 19 Oct 2020 18:03:52 -0700
Message-Id: <0a6bdbdcf7fbe96674908dc7314a2069fec850e1.1603155607.git.bkuhn@sfconservancy.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1603155607.git.bkuhn@sfconservancy.org>
References: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com> <cover.1603155607.git.bkuhn@sfconservancy.org>
MIME-Version: 1.0
Organization: Software Freedom Conservancy, Inc.
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Almost identical text on the signed-off-by trailer appears in the
documentation for "git commit" and "git merge" and its friends.

Introduce a new signoff-options.txt file to be shared.  A couple
things of note are:

 - The short-form "-s" is available only in "git commit", but not in
   commands that are friends of "git merge", as it is used as a
   short-hand for "--strategy".

 - The original lacks description on the negated "--no-signoff" form
   on "git commit" side, but it equally is applicable.  It however
   was unclear in the original text that not adding a Signed-off-by
   trailer is the default, so rephrase to explain it as a way to
   countermand a --signoff option that appeared earlier on the same
   command line.

This is in preparation to apply a further clarification on what
exactly the Signed-off-by trailer means.

Suggested-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Taylor Blau <me@ttaylorr.com>
Reviewed-by: Bradley M. Kuhn <bkuhn@sfconservancy.org>
---
 Documentation/git-commit.txt     | 10 ++--------
 Documentation/merge-options.txt  | 11 +----------
 Documentation/signoff-option.txt | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/signoff-option.txt

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a3baea32ae..17150fa7ea 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -59,6 +59,7 @@ commit by giving the same set of parameters (options and paths).
 If you make a commit and then find a mistake immediately after
 that, you can recover from it with 'git reset'.
 
+:git-commit: 1
 
 OPTIONS
 -------
@@ -163,14 +164,7 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 	message, the commit is aborted.  This has no effect when a message
 	is given by other means, e.g. with the `-m` or `-F` options.
 
--s::
---signoff::
-	Add Signed-off-by line by the committer at the end of the commit
-	log message.  The meaning of a signoff depends on the project,
-	but it typically certifies that committer has
-	the rights to submit this work under the same license and
-	agrees to a Developer Certificate of Origin
-	(see http://developercertificate.org/ for more information).
+include::signoff-option.txt[]
 
 -n::
 --no-verify::
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 80d4831662..eb0aabd396 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -77,16 +77,7 @@ When not possible, refuse to merge and exit with a non-zero status.
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
 
---signoff::
---no-signoff::
-	Add Signed-off-by line by the committer at the end of the commit
-	log message.  The meaning of a signoff depends on the project,
-	but it typically certifies that committer has
-	the rights to submit this work under the same license and
-	agrees to a Developer Certificate of Origin
-	(see http://developercertificate.org/ for more information).
-+
-With --no-signoff do not add a Signed-off-by line.
+include::signoff-option.txt[]
 
 --stat::
 -n::
diff --git a/Documentation/signoff-option.txt b/Documentation/signoff-option.txt
new file mode 100644
index 0000000000..d1c6713774
--- /dev/null
+++ b/Documentation/signoff-option.txt
@@ -0,0 +1,14 @@
+ifdef::git-commit[]
+-s::
+endif::git-commit[]
+--signoff::
+--no-signoff::
+	Add Signed-off-by line by the committer at the end of the commit
+	log message.  The meaning of a signoff depends on the project,
+	but it typically certifies that committer has
+	the rights to submit this work under the same license and
+	agrees to a Developer Certificate of Origin
+	(see http://developercertificate.org/ for more information).
++
+The --no-signoff option can be used to countermand an earlier --signoff
+option on the command line.
-- 
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter

