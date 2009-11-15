From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/3] rebase docs: clarify --merge and --strategy
Date: Sun, 15 Nov 2009 19:25:31 +0100
Message-ID: <b7f805f2497d748b685544b64cd91a36c3bdf5d6.1258309432.git.trast@student.ethz.ch>
References: <cover.1258309432.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 15 19:26:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9jnu-0003YL-Ut
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 19:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbZKOS0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 13:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbZKOS0O
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 13:26:14 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:7158 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228AbZKOS0N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 13:26:13 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 19:26:16 +0100
Received: from localhost.localdomain (129.132.210.10) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 19:26:15 +0100
X-Mailer: git-send-email 1.6.5.2.420.gf6c057.dirty
In-Reply-To: <cover.1258309432.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132947>

Add a paragraph about the swapped sides in a --merge rebase, which was
otherwise only documented in the sources.

Add a paragraph about the effects of the 'ours' strategy to the -s
description.  Also remove the mention of the 'octopus' strategy, which
was copied from the git-merge description but is pointless in a
rebase.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-rebase.txt |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 33e0ef1..5fa9100 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -228,13 +228,20 @@ OPTIONS
 	Use merging strategies to rebase.  When the recursive (default) merge
 	strategy is used, this allows rebase to be aware of renames on the
 	upstream side.
++
+Note that in a rebase merge (hence merge conflict), the sides are
+swapped: "theirs" is the to-be-applied patch, and "ours" is the so-far
+rebased series, starting with <upstream>.
 
 -s <strategy>::
 --strategy=<strategy>::
 	Use the given merge strategy.
-	If there is no `-s` option, a built-in list of strategies
-	is used instead ('git-merge-recursive' when merging a single
-	head, 'git-merge-octopus' otherwise).  This implies --merge.
+	If there is no `-s` option 'git-merge-recursive' is used
+	instead.  This implies --merge.
++
+Due to the peculiarities of 'git-rebase' (see \--merge above), using
+the 'ours' strategy simply discards all patches from the <branch>,
+which makes little sense.
 
 -q::
 --quiet::
-- 
1.6.5.2.420.gf6c057.dirty
