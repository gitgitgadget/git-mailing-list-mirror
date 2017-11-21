Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B75920A40
	for <e@80x24.org>; Tue, 21 Nov 2017 15:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbdKUPxP (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 10:53:15 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:55893 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdKUPxO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 10:53:14 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:53022 helo=DESKTOP-1GPMCEJ)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHArJ-0006ez-SU
        for git@vger.kernel.org; Tue, 21 Nov 2017 10:53:13 -0500
Date:   Tue, 21 Nov 2017 10:51:52 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@DESKTOP-1GPMCEJ
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] prune: add "--progress" to man page and usage msg
Message-ID: <alpine.LFD.2.21.1711211048400.8726@DESKTOP-1GPMCEJ>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add mention of git prune's "--progress" option to the SYNOPSIS and
DESCRIPTION sections of the man page, and to the usage message of "git
prune" itself.

While we're here, move the explanation of "--" toward the end of the
DESCRIPTION section, where it belongs.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 7a493c80f..a37c0af93 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -9,7 +9,7 @@ git-prune - Prune all unreachable objects from the object database
 SYNOPSIS
 --------
 [verse]
-'git prune' [-n] [-v] [--expire <expire>] [--] [<head>...]
+'git prune' [-n] [-v] [--progress] [--expire <time>] [--] [<head>...]

 DESCRIPTION
 -----------
@@ -42,12 +42,15 @@ OPTIONS
 --verbose::
 	Report all removed objects.

-\--::
-	Do not interpret any more arguments as options.
+--progress::
+	Show progress.

 --expire <time>::
 	Only expire loose objects older than <time>.

+\--::
+	Do not interpret any more arguments as options.
+
 <head>...::
 	In addition to objects
 	reachable from any of our references, keep objects
diff --git a/builtin/prune.c b/builtin/prune.c
index cddabf26a..d2fdae680 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -8,7 +8,7 @@
 #include "progress.h"

 static const char * const prune_usage[] = {
-	N_("git prune [-n] [-v] [--expire <time>] [--] [<head>...]"),
+	N_("git prune [-n] [-v] [--progress] [--expire <time>] [--] [<head>...]"),
 	NULL
 };
 static int show_only;

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
