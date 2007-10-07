From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/8] Fix up the help text for "stg edit"
Date: Mon, 08 Oct 2007 01:17:30 +0200
Message-ID: <20071007231729.12626.64039.stgit@yoghurt>
References: <20071007231446.12626.14259.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:18:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefOT-0003Sh-P8
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608AbXJGXRf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756214AbXJGXRe
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:17:34 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1366 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980AbXJGXRe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:17:34 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefNK-0000L5-00; Mon, 08 Oct 2007 00:17:30 +0100
In-Reply-To: <20071007231446.12626.14259.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60243>

The sentence structure was strange, and the example format was
somewhat misleading (StGit doesn't care about sign-off lines, for
example).

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/edit.py |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)


diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index 63c710b..e968e25 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -30,19 +30,25 @@ from stgit import stack, git
 help =3D 'edit a patch description or diff'
 usage =3D """%prog [options] [<patch>]
=20
-Edit the given patch (defaulting to the current one) description,
-author information or its diff (if the '--diff' option is
-passed). Without any other option, the command invokes the editor with
-the patch description and diff in the form below:
+Edit the description and author information of the given patch (or the
+current patch if no patch name was given). With --diff, also edit the
+diff.
=20
-  Subject line
+The editor is invoked with the following contents:
=20
-  From: author information
+  Patch short description
+
+  From: A U Thor <author@example.com>
   Date: creation date
=20
-  Patch description
+  Patch long description
+
+If --diff was specified, the diff appears at the bottom, after a
+separator:
+
+  ---
=20
-  Signed-off-by: author
+  Diff text
=20
 Command-line options can be used to modify specific information
 without invoking the editor.
@@ -54,7 +60,7 @@ these files using the '--file' and '--diff' options.
 """
=20
 options =3D [make_option('-d', '--diff',
-                       help =3D 'allow the editing of the patch diff',
+                       help =3D 'edit the patch diff',
                        action =3D 'store_true'),
            make_option('-f', '--file',
                        help =3D 'use FILE instead of invoking the edit=
or'),
