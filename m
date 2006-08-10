From: Robert Shearman <rob@codeweavers.com>
Subject: repo-config needs a prefix.
Date: Thu, 10 Aug 2006 10:36:52 +0100
Organization: CodeWeavers
Message-ID: <44DAFE34.50701@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090704000906030805040007"
X-From: git-owner@vger.kernel.org Thu Aug 10 11:37:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB6yp-0007kM-6w
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 11:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWHJJh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 05:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWHJJh0
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 05:37:26 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:65229 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751486AbWHJJhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 05:37:25 -0400
Received: from host86-139-253-196.range86-139.btcentralplus.com ([86.139.253.196] helo=[172.16.0.10])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GB6yi-0001Ui-Vu
	for git@vger.kernel.org; Thu, 10 Aug 2006 04:37:25 -0500
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060725)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25173>

This is a multi-part message in MIME format.
--------------090704000906030805040007
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


This fixes the message received when invoking certain commands from 
outside of a git tree, so e.g. instead of receiving this:
/home/rob/bin/git-fetch: line 89: /FETCH_HEAD: Permission denied
We get this again:
fatal: Not a git repository: '.git'
---
  git.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

--------------090704000906030805040007
Content-Type: text/x-patch;
 name="c0aa527060f6ba202986564731e7277f11f31639.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="c0aa527060f6ba202986564731e7277f11f31639.diff"

diff --git a/git.c b/git.c
index 18ba14a..f9c76a1 100644
--- a/git.c
+++ b/git.c
@@ -264,7 +264,7 @@ static void handle_internal_command(int 
 		{ "prune", cmd_prune, NEEDS_PREFIX },
 		{ "mv", cmd_mv, NEEDS_PREFIX },
 		{ "prune-packed", cmd_prune_packed, NEEDS_PREFIX },
-		{ "repo-config", cmd_repo_config },
+		{ "repo-config", cmd_repo_config, NEEDS_PREFIX },
 	};
 	int i;
 


--------------090704000906030805040007--
