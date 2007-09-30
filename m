From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git stash: document apply's --index switch
Date: Mon, 1 Oct 2007 00:30:27 +0200
Message-ID: <1191190557-24902-1-git-send-email-vmiklos@frugalware.org>
References: <Pine.LNX.4.64.0709302226270.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 00:30:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic7J8-0004DQ-73
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 00:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbXI3Waa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 18:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbXI3Waa
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 18:30:30 -0400
Received: from virgo.iok.hu ([193.202.89.103]:38431 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474AbXI3Wa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 18:30:29 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 43FD11B24FF
	for <git@vger.kernel.org>; Mon,  1 Oct 2007 00:30:28 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 03F2D6FD0A
	for <git@vger.kernel.org>; Mon,  1 Oct 2007 00:30:27 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 97E1F13A406B; Mon,  1 Oct 2007 00:30:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709302226270.28395@racer.site>
X-Mailer: git-send-email 1.5.3.2.111.g5166-dirty
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59577>

---

On Sun, Sep 30, 2007 at 10:29:05PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Now that you know what --index is supposed to do, maybe you are nice
> enough to extend the documentation and post a patch?

something like this?

VMiklos

 Documentation/git-stash.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 05f40cf..5723bb0 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -63,7 +63,7 @@ show [<stash>]::
 	it will accept any format known to `git-diff` (e.g., `git-stash show
 	-p stash@\{1}` to view the second most recent stash in patch form).
 
-apply [<stash>]::
+apply [--index] [<stash>]::
 
 	Restore the changes recorded in the stash on top of the current
 	working tree state.  When no `<stash>` is given, applies the latest
@@ -71,6 +71,11 @@ apply [<stash>]::
 +
 This operation can fail with conflicts; you need to resolve them
 by hand in the working tree.
++
+If the `--index` option is used, then tries to reinstate not only the working
+tree's changes, but also the index's ones. However, this can fail, when you
+have conflicts (which are stored in the index, where you therefore can no
+longer apply the changes as they were originally).
 
 clear::
 	Remove all the stashed states. Note that those states will then
-- 
1.5.3.2.111.g5166-dirty
