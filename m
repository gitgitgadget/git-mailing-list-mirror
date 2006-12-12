X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/3] git-svn: correctly display fatal() error messages
Date: Tue, 12 Dec 2006 14:47:02 -0800
Message-ID: <11659636263755-git-send-email-normalperson@yhbt.net>
References: <11659636223725-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Tue, 12 Dec 2006 22:47:35 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.2.g6f98
In-Reply-To: <11659636223725-git-send-email-normalperson@yhbt.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34157>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGPL-0007T7-At for gcvg-git@gmane.org; Tue, 12 Dec
 2006 23:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932543AbWLLWrW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 17:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWLLWrU
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 17:47:20 -0500
Received: from hand.yhbt.net ([66.150.188.102]:54308 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932537AbWLLWrP
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 17:47:15 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 82ACE7DC099; Tue, 12 Dec 2006 14:47:14 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 12 Dec 2006
 14:47:06 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

If I wanted to print $@, I'd pass $@ to fatal().  This looks like
a stupid typo on my part.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 819584b..c746a3c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -31,7 +31,7 @@ my %SKIP = ( 'svn:wc:ra_dav:version-url' => 1,
              'svn:entry:committed-date' => 1,
 );
 
-sub fatal (@) { print STDERR $@; exit 1 }
+sub fatal (@) { print STDERR @_; exit 1 }
 # If SVN:: library support is added, please make the dependencies
 # optional and preserve the capability to use the command-line client.
 # use eval { require SVN::... } to make it lazy load
-- 
1.4.4.2.g6f98
