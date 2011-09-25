From: Auke Schrijnen <auke@schrijnen.nl>
Subject: [PATCH] git-completion: offer remotes for 'git remote update'
Date: Sun, 25 Sep 2011 14:06:50 +0200
Message-ID: <347b845858abcc62551d83df324e5c10@schrijnen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 25 14:21:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7nhv-0004fC-7G
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 14:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab1IYMNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 08:13:33 -0400
Received: from server6.bhosted.nl ([94.124.120.40]:18450 "HELO
	server6.bhosted.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752140Ab1IYMNc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 08:13:32 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Sep 2011 08:13:31 EDT
Received: (qmail 11581 invoked by uid 1011); 25 Sep 2011 14:06:50 +0200
X-Sender: auke@schrijnen.nl
User-Agent: Roundcube Webmail/0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182066>

Completion for 'git remote update' only offers configured remote
groups.

Add all remotes to the completion.

Signed-off-by: Auke Schrijnen <auke@schrijnen.nl>
---
  contrib/completion/git-completion.bash |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash 
b/contrib/completion/git-completion.bash
index 8648a36..ad2175c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2293,7 +2293,7 @@ _git_remote ()
  		__gitcomp "$(__git_remotes)"
  		;;
  	update)
-		local i c='' IFS=$'\n'
+		local i c="$(__git_remotes)" IFS=$'\n'
  		for i in $(git --git-dir="$(__gitdir)" config --get-regexp 
"remotes\..*" 2>/dev/null); do
  			i="${i#remotes.}"
  			c="$c ${i/ */}"
-- 
1.7.6.1
