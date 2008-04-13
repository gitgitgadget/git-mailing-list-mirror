From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] Add examples section to 'git fetch' manual
Date: Sun, 13 Apr 2008 12:34:24 +0300
Message-ID: <20080413093424.GA12861@mithlond.arda.local>
References: <20080413093102.GC12107@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 11:35:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkycC-0007X7-T2
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 11:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbYDMJe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 05:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754543AbYDMJe2
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 05:34:28 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:40229 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752478AbYDMJe2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Apr 2008 05:34:28 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout4-sn1.fre.skanova.net (7.3.129)
        id 47A7970A003DF64D; Sun, 13 Apr 2008 11:34:26 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JkybQ-0003Lf-Ae; Sun, 13 Apr 2008 12:34:24 +0300
Content-Disposition: inline
In-Reply-To: <20080413093102.GC12107@mithlond.arda.local>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79400>

This commit adds examples which intend to cover the various ways of
using 'git fetch'.

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---
 Documentation/git-fetch.txt |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index d982f96..d5b1c9f 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -37,9 +37,50 @@ include::pull-fetch-param.txt[]
 
 include::urls-remotes.txt[]
 
+EXAMPLES
+--------
+
+git fetch git://host.xz/repo.git/ master:pu::
+	Fetch branch `master` from given repository URL and store it locally
+	as `pu`.
+
+git fetch git://host.xz/repo.git/ master:remotes/pu::
+	Fetch branch `master` from given repository URL and store it locally as
+	remote tracking branch `pu`.
+
+git fetch git://host.xz/repo.git/ master::
+	Fetch branch `master` from given repository URL but do not create the
+	branch locally. Only the temporary pointer FETCH_HEAD is set to refer
+	to the fetched branch.
+
+git fetch /home/bob/tmp/repo.git::
+	Fetch the currently active branch from given local repository and set
+	the temporary pointer FETCH_HEAD for the fetched branch.
+
+git fetch alice master:remotes/alice/pu::
+	Fetch branch `master` from remote named `alice` and store it locally as
+	remote tracking branch `alice/pu`. See linkgit:git-remote[1] for more
+	information on configuring remotes.
+
+git fetch alice +master:remotes/alice/pu::
+	The same as above but the remote tracking branch `alice/pu` is updated
+	even if it does not result in a fast forward update.
+
+git fetch alice +master:pu maint:tmp::
+	Fetch branches `master` and `maint` from remote named `alice` and store
+	them locally as `pu` and `tmp` respectively. The branch `pu` is updated
+	even if it does not result in a fast forward update.
+
+git fetch origin::
+	From the remote named `origin` fetch and store all branches as
+	configured in `remote.origin.fetch`. Usually this means fetching all
+	branches and storing them locally as remote tracking branches
+	`origin/*`. See linkgit:git-remote[1] for more information.
+
+
 SEE ALSO
 --------
-linkgit:git-pull[1]
+linkgit:git-pull[1], linkgit:git-remote[1]
 
 
 Author
-- 
1.5.5.32.g5279
