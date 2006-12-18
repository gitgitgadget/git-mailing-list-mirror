X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Add documentation for show-branch --topics
Date: Mon, 18 Dec 2006 10:48:33 -0500
Message-ID: <20061218154812.GA5716@178.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 00:45:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34775>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwKjl-0004ma-JU for gcvg-git@gmane.org; Mon, 18 Dec
 2006 16:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754181AbWLRPsg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 10:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbWLRPsf
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 10:48:35 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:38958 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1754174AbWLRPsf (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 10:48:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1]) by
 silverinsanity.com (Postfix) with ESMTP id 3ED4C1FFD321 for
 <git@vger.kernel.org>; Mon, 18 Dec 2006 15:48:34 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2 
 (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Add a quick paragraph explaining the --topics option for show-branch.
The explanation is an abbreviated version of the commit message from
d320a5437f8304cf9ea3ee1898e49d643e005738.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 git blame helped me find the original description of this feature.
 I'm not sure this is the best explanation possible, but it gives
 both a quick description and a way to figure out what it's doing.
 Which is hopefully better than nothing.

 Documentation/git-show-branch.txt |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index a2445a4..a9a0e0c 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git-show-branch' [--all] [--heads] [--tags] [--topo-order] [--current]
 		[--more=<n> | --list | --independent | --merge-base]
-		[--no-name | --sha1-name] [<rev> | <glob>]...
+		[--no-name | --sha1-name] [--topics] [<rev> | <glob>]...
 
 DESCRIPTION
 -----------
@@ -86,6 +86,14 @@ OPTIONS
 	of "master"), name them with the unique prefix of their
 	object names.
 
+--topics::
+	Shows only commits that are NOT on the first branch given.
+	This helps track topic branches by hiding any commit that
+	is already in the main line of development.  When given
+	"git show-branch --topics master topic1 topic2", this
+	will show the revisions given by "git rev-list ^master
+	topic1 topic2"
+
 Note that --more, --list, --independent and --merge-base options
 are mutually exclusive.
 
-- 
1.4.4.1.GIT
