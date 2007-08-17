From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Minor clarifications to git-filter-branch usage and doc
Date: Fri, 17 Aug 2007 17:23:59 -0400
Message-ID: <20070817212359.GA14197@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 23:24:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM9IX-0004nu-Cp
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 23:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086AbXHQVX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 17:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755545AbXHQVX6
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 17:23:58 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:34429 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208AbXHQVX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 17:23:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id A361C1FFC24E
	for <git@vger.kernel.org>; Fri, 17 Aug 2007 21:23:56 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56086>

- Remove "DESTBRANCH" from usage, as it rewrites the branches given
- Remove an = from an example usage that the script doesn't understand

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 It took me way too long to figure out how to just delete a single file
 from the history.

 From the docs and usage it looked I needed
 $ git filter-branch --index-filter \
 	 "git update-index --force-remove file" \
 	 --tag-name-filter=cat newbranch HEAD

 I eventually determined the following
 $ git filter-branch --index-filter \
 	 "git update-index --force-remove file" \
 	 --tag-name-filter cat master

 The following changes changes the parts that led me astray, although I
 think it still could be clearer even if I don't know how to write it.

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
index c42e451..9f10c30 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -8,7 +8,7 @@
 # a new branch. You can specify a number of filters to modify the commits,
 # files and trees.
 
-USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]"
+USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] [BRANCHES]"
 . git-sh-setup
 
 warn () {
-- 
1.5.3.rc5.11.g312e
