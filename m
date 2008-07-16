From: Petr Baudis <pasky@suse.cz>
Subject: [PATCHv2] Documentation/git-submodule.txt: Add Description section
Date: Wed, 16 Jul 2008 20:44:12 +0200
Message-ID: <20080716184248.6524.38463.stgit@localhost>
References: <20080715183705.GD4379@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heikki Orsila <shdl@zakalwe.fi>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 16 20:45:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJC06-00056c-Tp
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 20:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbYGPSoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752972AbYGPSoU
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:44:20 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:62442 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752442AbYGPSoT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 14:44:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 634D82ACC76;
	Wed, 16 Jul 2008 20:44:13 +0200 (CEST)
In-Reply-To: <20080715183705.GD4379@zakalwe.fi>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88714>

Figuring out how submodules work conceptually is quite a bumpy
ride for a newcomer; the user manual helps (if one knows to actually
look into it), but the reference documentation should provide good
quick intro as well. This patch attempts to do that, with suggestions
from Heikki Orsila.

Cc: Heikki Orsila <shdl@zakalwe.fi>
Signed-off-by: Petr Baudis <pasky@suse.cz>
---

I have adjusted the description a bit; however, I believe mentioning remotes in
the description would only raise the danger of confusion - I emphasized the
level of separation, though.

 Documentation/git-submodule.txt |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 76702a0..87c4ece 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -16,6 +16,28 @@ SYNOPSIS
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 
 
+DESCRIPTION
+-----------
+Submodules are a special kind of tree entries which refer to a particular tree
+in another repository (living at a given URL).  The tree entry describes
+the existence of a submodule with the given name and the exact revision that
+should be used, while the location of the repository is described in the
+`/.gitmodules` file.
+
+When checked out, submodules will maintain their own independent repositories
+within their directories; the only link between the submodule and the "parent
+project" is the tree entry within the parent project mentioned above.
+
+This command will manage the tree entries and contents of the gitmodules file
+for you, as well as inspecting the status of your submodules and updating them.
+When adding a new submodule to the tree, the 'add' subcommand is to be used.
+However, when pulling a tree containing submodules, these will not be checked
+out by default; the 'init' and 'update' subcommands will maintain submodules
+checked out and at appropriate revision in your working tree. You can inspect
+the current status of your submodules using the 'submodule' subcommand and get
+an overview of changes 'update' would perform using the 'summary' subcommand.
+
+
 COMMANDS
 --------
 add::
