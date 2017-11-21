Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF9F2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 17:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbdKURBv (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 12:01:51 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:60234 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdKURBu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 12:01:50 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:53964 helo=DESKTOP-1GPMCEJ)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHBvi-0008FR-9z
        for git@vger.kernel.org; Tue, 21 Nov 2017 12:01:50 -0500
Date:   Tue, 21 Nov 2017 12:00:29 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@DESKTOP-1GPMCEJ
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] notes: fix erroneous "git notes prune [-n | -v]" message
Message-ID: <alpine.LFD.2.21.1711211156110.10397@DESKTOP-1GPMCEJ>
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

It seems clear that the man page SYNPOSIS and the usage message
referring to:

  git notes prune [-n | -v]

is incorrect, as "-n" (dry run) and "-v" (verbose) are not
alternatives, so fix both places to refer to:

  git notes prune [-n] [-v | -q]

to match the rest of the man page.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 43677297f..c75748963 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 'git notes' merge --commit [-v | -q]
 'git notes' merge --abort [-v | -q]
 'git notes' remove [--ignore-missing] [--stdin] [<object>...]
-'git notes' prune [-n | -v]
+'git notes' prune [-n] [-v | -q]
 'git notes' get-ref


diff --git a/builtin/notes.c b/builtin/notes.c
index d7754db14..43bfe3d6a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -33,7 +33,7 @@ static const char * const git_notes_usage[] = {
 	N_("git notes merge --commit [-v | -q]"),
 	N_("git notes merge --abort [-v | -q]"),
 	N_("git notes [--ref <notes-ref>] remove [<object>...]"),
-	N_("git notes [--ref <notes-ref>] prune [-n | -v]"),
+	N_("git notes [--ref <notes-ref>] prune [-n] [-v | -q]"),
 	N_("git notes [--ref <notes-ref>] get-ref"),
 	NULL
 };

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
