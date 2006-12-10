X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] editor: make sure $EDITOR is executed as a command
Date: Sun, 10 Dec 2006 15:04:57 +0100
Message-ID: <20061210140457.GA13173@kzelldran.dyndns.org>
References: <20061210135753.GA12905@kzelldran.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 14:04:10 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061210135753.GA12905@kzelldran.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 10 Dec 2006 14:03:56.0991 (UTC) FILETIME=[089924F0:01C71C64]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33890>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtPHj-0002XQ-C2 for gcvg-git@gmane.org; Sun, 10 Dec
 2006 15:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760783AbWLJOD6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 09:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760786AbWLJOD6
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 09:03:58 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:50865 "EHLO
 postman.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760783AbWLJOD6 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 09:03:58 -0500
Received: from kzelldran.dyndns.org ([84.154.115.16]) by
 postman.fh-hagenberg.at over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Sun, 10 Dec 2006 15:03:56 +0100
Received: from drizzd by kzelldran.dyndns.org with local (Exim 4.63)
 (envelope-from <drizzd@kzelldran.dyndns.org>) id 1GtPIY-0003dd-06 for
 git@vger.kernel.org; Sun, 10 Dec 2006 15:04:58 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

Sorry about the missing subject.

Make sure $EDITOR is executed as a command. Otherwise, _editor may fail if
$EDITOR is set to something like 'editor', which is also a function within
cg-Xlib.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
commit 942341e051fdcbb77a6abfbc58cf08ef8cab388d
tree 96e8fd08cdc7c59b0d3d55d7cb5b4302db443aff
parent b6a6e87cb3e1368ad0f78c18fdb6c29dde4ae83e
author Clemens Buchacher <drizzd@aon.at> Sun, 10 Dec 2006 14:37:37 +0100
committer Clemens Buchacher <drizzd@aon.at> Sun, 10 Dec 2006 14:37:37 +0100

 cg-Xlib |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
index c1262bf..9d04eb4 100755
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -568,7 +568,7 @@ _editor()
 	actionname="$1"; shift
 	actionkey="$1"; shift
 
-	${EDITOR:-vi} "$LOGMSG2"
+	command ${EDITOR:-vi} "$LOGMSG2"
 	[ -z "$force" ] || return 0
 	[ ! "$LOGMSG2" -nt "$LOGMSG" ] || return 0
