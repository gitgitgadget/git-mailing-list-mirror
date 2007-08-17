From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH v2] Minor clarifications to git-filter-branch usage and doc
Date: Fri, 17 Aug 2007 19:13:04 -0400
Message-ID: <20070817231304.GA14501@Hermes.local>
References: <Pine.LNX.4.64.0708172252440.20400@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 18 01:13:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMB09-0003QT-MQ
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 01:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbXHQXNF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 19:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755813AbXHQXNE
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 19:13:04 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:40229 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbXHQXND (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 19:13:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id C54C71FFC230
	for <git@vger.kernel.org>; Fri, 17 Aug 2007 23:13:01 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708172252440.20400@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56095>

- Remove "DESTBRANCH" from usage, as it rewrites the branches given.
- Remove an = from an example usage, as the script doesn't understand
it.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 On Aug 17, 2007, at 5:53 PM, Johannes Schindelin wrote:

 > On Fri, 17 Aug 2007, Brian Gernhardt wrote:
 >  
 >> -USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]"
 >> +USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] [BRANCHES]"
 > 
 > It is not just [BRANCHES].  Something like "HEAD~2..HEAD" is perfectly 
 > valid, and it will rewrite only the commits in that range, leaving HEAD~2 
 > and ancestors alone.

 Well then that should be left as REV-RANGE then, but DESTBRANCH still
 needs to leave.

 Documentation/git-filter-branch.txt |    2 +-
 git-filter-branch.sh                |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 915258f..8c43be6 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -120,7 +120,7 @@ have all of them as parents.
 	tag name is expected on standard output.
 +
 The original tags are not deleted, but can be overwritten;
-use "--tag-name-filter=cat" to simply update the tags.  In this
+use "--tag-name-filter cat" to simply update the tags.  In this
 case, be very careful and make sure you have the old tags
 backed up in case the conversion has run afoul.
 +
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index c42e451..0190060 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -8,7 +8,7 @@
 # a new branch. You can specify a number of filters to modify the commits,
 # files and trees.
 
-USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]"
+USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] [REV-RANGE]"
 . git-sh-setup
 
 warn () {
-- 
1.5.3.rc5.11.g312e
