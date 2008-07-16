From: Alex Chiang <achiang@hp.com>
Subject: [PATCH] guilt(1): fix path to git-sh-setup
Date: Wed, 16 Jul 2008 17:23:39 -0600
Message-ID: <20080716232339.GC22919@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Thu Jul 17 01:24:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJGMc-0000lh-QF
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 01:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760114AbYGPXXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 19:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760223AbYGPXXp
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 19:23:45 -0400
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:22192 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760114AbYGPXXm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 19:23:42 -0400
Received: from g1t0039.austin.hp.com (g1t0039.austin.hp.com [16.236.32.45])
	by g5t0007.atlanta.hp.com (Postfix) with ESMTP id BEB7D1419C;
	Wed, 16 Jul 2008 23:23:41 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by g1t0039.austin.hp.com (Postfix) with ESMTP id F1DF6356D0;
	Wed, 16 Jul 2008 23:23:40 +0000 (UTC)
Received: by ldl.fc.hp.com (Postfix, from userid 17609)
	id F125639C080; Wed, 16 Jul 2008 17:23:39 -0600 (MDT)
Mail-Followup-To: Alex Chiang <achiang@hp.com>, jeffpc@josefsipek.net,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88783>

git is in the process of moving subcommands to /usr/libexec/git-core

This move breaks an assumption in guilt about the location of
git-sh-setup.

We can ask git for where it thinks its executables live.

Signed-off-by: Alex Chiang <achiang@hp.com>
---

diff --git a/guilt b/guilt
index 50414a4..ba4593a 100755
--- a/guilt
+++ b/guilt
@@ -23,7 +23,7 @@ esac
 # we change directories ourselves
 SUBDIRECTORY_OK=1
 
-. git-sh-setup
+. `git --exec-path`/git-sh-setup
 
 #
 # Git version check
