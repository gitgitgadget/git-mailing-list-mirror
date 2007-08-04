From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Document GIT_SSH environment variable alongside other variables
Date: Sat, 4 Aug 2007 02:06:52 -0400
Message-ID: <20070804060652.GA28379@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 08:07:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHCn0-0002sr-G7
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 08:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbXHDGG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 02:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753990AbXHDGG6
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 02:06:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43361 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbXHDGG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 02:06:57 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHCmq-00084g-CH; Sat, 04 Aug 2007 02:06:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 52E2A20FBAE; Sat,  4 Aug 2007 02:06:52 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54797>

The GIT_SSH environment variable has survived for quite a while
without being documented, but has been mentioned on list and on
my day-job repositories can only be accessed via magic supplied
through the wonderous hack that is GIT_SSH.

Advertising it alongside other "low level magic" such as GIT_PAGER
and GIT_MERGE_VERBOSITY will certainly help others who need to
spread their own pixie dust to make things work.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4c4d174..18f8b6a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -421,6 +421,22 @@ other
 	to an empty string or to the value "cat", git will not launch
 	a pager.
 
+'GIT_SSH'::
+	If this environment variable is set then gitlink:git-fetch[1]
+	and gitlink:git-push[1] will use this command instead
+	of `ssh` when they need to connect to a remote system.
+	The 'GIT_SSH' command will be given exactly two arguments:
+	the 'username@host' (or just 'host') from the URL and the
+	shell command to execute on that remote system.
++
+To pass options to the program that you want to list in GIT_SSH
+you will need to wrap the program and options into a shell script,
+then set GIT_SSH to refer to the shell script.
++
+Usually it is easier to configure any desired options through your
+personal `.ssh/config` file.  Please consult your ssh documentation
+for further details.
+
 'GIT_FLUSH'::
 	If this environment variable is set to "1", then commands such
 	as git-blame (in incremental mode), git-rev-list, git-log,
-- 
1.5.3.rc3.941.gaac97
