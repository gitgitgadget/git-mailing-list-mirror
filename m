Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACDEA2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 19:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdKUTSn (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 14:18:43 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:48981 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdKUTSm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 14:18:42 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:37256 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHE4A-0005ke-Bg
        for git@vger.kernel.org; Tue, 21 Nov 2017 14:18:42 -0500
Date:   Tue, 21 Nov 2017 14:17:21 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] notes: correct 'git notes prune' options to '[-n] [-v]'
Message-ID: <alpine.LFD.2.21.1711211414290.5204@localhost.localdomain>
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

Currently, 'git notes prune' in man page and usage message
incorrectly lists options as '[-n | -v]', rather than '[-n] [-v]'.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  i think i got it right this time.

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 43677297f..e8dec1b3c 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 'git notes' merge --commit [-v | -q]
 'git notes' merge --abort [-v | -q]
 'git notes' remove [--ignore-missing] [--stdin] [<object>...]
-'git notes' prune [-n | -v]
+'git notes' prune [-n] [-v]
 'git notes' get-ref


diff --git a/builtin/notes.c b/builtin/notes.c
index d7754db14..892e37a03 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -33,7 +33,7 @@ static const char * const git_notes_usage[] = {
 	N_("git notes merge --commit [-v | -q]"),
 	N_("git notes merge --abort [-v | -q]"),
 	N_("git notes [--ref <notes-ref>] remove [<object>...]"),
-	N_("git notes [--ref <notes-ref>] prune [-n | -v]"),
+	N_("git notes [--ref <notes-ref>] prune [-n] [-v]"),
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
