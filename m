From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Effective difference between git-rebase and git-resolve
Date: Sun, 26 Mar 2006 15:29:28 -0500
Message-ID: <20060326202927.GA6436@fieldses.org>
References: <20060325035423.GB31504@buici.com> <Pine.LNX.4.64.0603242014160.15714@g5.osdl.org> <7v64m3ys3a.fsf@assigned-by-dhcp.cox.net> <20060325063225.GA13791@buici.com> <7vacbfxadu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Singer <elf@buici.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 22:29:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNbrs-0000ES-0q
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 22:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWCZU3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 15:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWCZU3c
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 15:29:32 -0500
Received: from mail.fieldses.org ([66.93.2.214]:54151 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751487AbWCZU3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Mar 2006 15:29:32 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1FNbrc-0008PI-LR; Sun, 26 Mar 2006 15:29:28 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vacbfxadu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18056>

On Fri, Mar 24, 2006 at 11:15:57PM -0800, Junio C Hamano wrote:
>      - Patch C does not apply.  git-am stops here, with conflicts to
>        be resolved in the working tree.  Yet-to-be-applied D and E
>        are still kept in .dotest/ directory at this point.  What the
>        user does is exactly the same as fixing up unapplicable patch
>        when running git-am:
>     
>        - Resolve conflict just like any merge conflicts.
>        - "git am --resolved --3way" to continue applying the patches.

So, does this sum it up accurately for the man page?

--b.

Document git-rebase behavior on conflicts.

---

 Documentation/git-rebase.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

3ef0c8cc7a505f9023a87e7e1ca22251a91bf188
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index b36276c..4a7e67a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -48,6 +48,18 @@ would be:
              /
     D---E---F---G master
 
+In case of conflict, git-rebase will stop at the first problematic commit
+and leave conflict markers in the tree.  After resolving the conflict manually
+and updating the index with the desired resolution, you can continue the
+rebasing process with
+
+    git am --resolved --3way
+
+Alternatively, you can undo the git-rebase with
+
+    git reset --hard ORIG_HEAD
+    rm -r .dotest
+
 OPTIONS
 -------
 <newbase>::
-- 
1.2.4.g0382
