From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation/git-ls-tree.txt: Add a caveat about prefixing
	pathspec
Date: Mon, 21 Jul 2008 09:56:34 +0200
Message-ID: <20080721075618.14163.45309.stgit@localhost>
References: <20080720233956.GH10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 21 09:57:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKqH8-0001gN-1I
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 09:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbYGUH4n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2008 03:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbYGUH4m
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 03:56:42 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:50236 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753336AbYGUH4m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 03:56:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 5BF9A2ACCA2;
	Mon, 21 Jul 2008 09:56:34 +0200 (CEST)
In-Reply-To: <20080720233956.GH10151@machine.or.cz>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89318>

When run in a working copy subdirectory, git-ls-tree will automagically
add the prefix to the pathspec, which can result in an unexpected behav=
ior
when the tree object accessed is not the root tree object.

This was originally pointed out and described in a patch by
Steve Fr=C3=A9naux <code@istique.net>, this is a shot at clearer and mo=
re
accurate description.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-ls-tree.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.=
txt
index 1cdec22..8bb1864 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -21,6 +21,15 @@ though - 'paths' denote just a list of patterns to m=
atch, e.g. so specifying
 directory name (without '-r') will behave differently, and order of th=
e
 arguments does not matter.
=20
+Note that within a subdirectory of the working copy, 'git ls-tree'
+will automatically prepend the subdirectory prefix to the specified
+paths and assume just the prefix was specified in case no paths were
+given --- no matter what the tree object is!
+Thus, within a subdirectory, 'git ls-tree' behaves as expected
+only when run on a root tree object (e.g. with a 'HEAD' tree-ish,
+but not anymore when passed 'HEAD:Documentation' instead).
+
+
 OPTIONS
 -------
 <tree-ish>::
