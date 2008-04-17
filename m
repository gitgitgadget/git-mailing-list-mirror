From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-branch.txt: compare --contains, --merged and --no-merged
Date: Fri, 18 Apr 2008 00:27:08 +0200
Message-ID: <1208471228-26232-1-git-send-email-hjemli@gmail.com>
References: <7vzlrsmbqw.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 00:27:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmcZI-00029r-UP
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 00:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbYDQW0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 18:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbYDQW0O
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 18:26:14 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:38827 "EHLO mail48.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186AbYDQW0N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 18:26:13 -0400
Received: from localhost.localdomain (ti0025a380-0176.bb.online.no [88.89.68.176])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id m3HMQ0Ji026623;
	Fri, 18 Apr 2008 00:26:02 +0200 (MEST)
X-Mailer: git-send-email 1.5.5.64.gb1a99
In-Reply-To: <7vzlrsmbqw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79839>

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

Junio C Hamano wrote:
> You did not answer my question as to how --contains and --merged relate to
> each other.

Sorry, I deemed it to be rhetorical.


> I'll answer it myself (please add a documentation updates, as
> this would be confusing).

Something like this, maybe?


 Documentation/git-branch.txt |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 95e9d0d..7e37497 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -120,6 +120,15 @@ OPTIONS
 --no-track::
 	Ignore the branch.autosetupmerge configuration variable.
 
+--contains <commit>::
+	Only list branches which contain the specified commit.
+
+--merged::
+	Only list branches which are fully contained by HEAD.
+
+--no-merged::
+	Do not list branches which are fully contained by HEAD.
+
 <branchname>::
 	The name of the branch to create or delete.
 	The new branch name must pass all checks defined by
@@ -177,6 +186,15 @@ If you are creating a branch that you want to immediately checkout, it's
 easier to use the git checkout command with its `-b` option to create
 a branch and check it out with a single command.
 
+The options `--contains`, `--merged` and `--no-merged` serves three related
+but different purposes:
+<1> `--contains <commit>` is used to find all branches which will need
+special attention if <commit> were to be rebased or amended, since those
+branches contain the specified <commit>.
+<2> `--merged` is used to find all branches which can be safely deleted,
+since those branches are fully contained by HEAD.
+<3> `--no-merged` is used to find branches which are candidates for merging
+into HEAD, since those branches are not fully contained by HEAD.
 
 Author
 ------
-- 
1.5.5.64.gb1a99
