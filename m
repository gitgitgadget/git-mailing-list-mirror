From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Documentation/git-filter-branch: add a new msg-filter
	example
Date: Mon, 25 Feb 2008 15:43:53 +0100
Message-ID: <20080225144353.GT31441@genesis.frugalware.org>
References: <20080223193058.GE31441@genesis.frugalware.org> <7vejb3319j.fsf@gitster.siamese.dyndns.org> <20080223220433.GG31441@genesis.frugalware.org> <alpine.DEB.1.00.0802241151390.6881@eeepc-johanness> <7v7iguxmlq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 15:44:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTeZE-000062-AF
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 15:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbYBYOn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 09:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754381AbYBYOnz
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 09:43:55 -0500
Received: from virgo.iok.hu ([193.202.89.103]:60921 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754351AbYBYOnz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 09:43:55 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0E7AF1B250F;
	Mon, 25 Feb 2008 15:43:53 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9489544668;
	Mon, 25 Feb 2008 15:41:23 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 6D43011901F5; Mon, 25 Feb 2008 15:43:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v7iguxmlq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75032>

There were no example on how to edit commit messages, so add an msg-filter
example.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sun, Feb 24, 2008 at 09:58:41AM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> Ahhhhhhh, that was the little voice that kept telling me there
> is something wrong with the patch...

uh-oh. third try :)

 Documentation/git-filter-branch.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index e22dfa5..1948f6f 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -240,6 +240,15 @@ committed a merge between P1 and P2, it will be propagated properly
 and all children of the merge will become merge commits with P1,P2
 as their parents instead of the merge commit.
 
+You can rewrite the commit log messages using `--message-filter`.  For
+example, `git-svn-id` strings in a repository created by `git-svn` can
+be removed this way:
+
+-------------------------------------------------------
+git filter-branch --message-filter '
+	sed -e "/^git-svn-id:/d"
+'
+-------------------------------------------------------
 
 To restrict rewriting to only part of the history, specify a revision
 range in addition to the new branch name.  The new branch name will
-- 
1.5.4.3
