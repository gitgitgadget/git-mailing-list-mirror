From: Remi Vanicat <vanicat@debian.org>
Subject: git diff and file deleted from the cache
Date: Sun, 11 Nov 2007 13:43:26 +0100
Message-ID: <876409j6kx.dlv@vanicat.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 13:43:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrCAD-0000Dg-Pw
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 13:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbXKKMn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 07:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbXKKMn2
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 07:43:28 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:60732 "EHLO smtp.Neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753063AbXKKMn2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2007 07:43:28 -0500
Received: from vanicat.homelinux.org ([77.193.67.174])
 by sp604005mt.gpm.neuf.ld
 (Sun Java System Messaging Server 6.2-5.05 (built Feb 16 2006))
 with ESMTP id <0JRC004D4E0E04N4@sp604005mt.gpm.neuf.ld> for
 git@vger.kernel.org; Sun, 11 Nov 2007 13:43:26 +0100 (CET)
Received: from moi by vanicat.homelinux.org with local (Exim 4.68)
	(envelope-from <remi.vanicat@laposte.net>)
	id 1IrC9u-0007QI-96	for git@vger.kernel.org; Sun, 11 Nov 2007 13:43:26 +0100
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: remi.vanicat@laposte.net
X-SA-Exim-Scanned: No (on vanicat.homelinux.org); SAEximRunCond expanded to
 false
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64451>

The manual of git-diff tell me that :
  git-diff [--options] <commit> [--] [<path>...]
      This form is to view the changes you have in your working tree
      relative to the named <commit>. You can use HEAD to compare it wi=
th
      the latest commit, or a branch name to compare with the tip of a
      different branch.

So the following seem strange :

$ echo foo > bar
$ git commit -m "committing bar" -a
Created commit 074893b: committing bar
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 bar
$ git rm --cached bar
rm 'bar'
$ git diff HEAD --
diff --git a/bar b/bar
deleted file mode 100644
index 257cc56..0000000
--- a/bar
+++ /dev/null
@@ -1 +0,0 @@
-foo

I excepted the diff to be empty, as HEAD and the working directory are
synchronized, I've only modified the cache.

--=20
R=C3=A9mi Vanicat
