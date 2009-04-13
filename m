From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: add documentation for "git replace"
Date: Tue, 14 Apr 2009 00:36:59 +0200
Message-ID: <20090414003659.41d02ae6.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 00:39:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtUoZ-0008La-Bs
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 00:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbZDMWiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 18:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbZDMWiI
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 18:38:08 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:41453 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbZDMWiF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 18:38:05 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id E34C294000A;
	Tue, 14 Apr 2009 00:37:58 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id E1BBF94001E;
	Tue, 14 Apr 2009 00:37:55 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116497>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt |   71 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-replace.txt

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
new file mode 100644
index 0000000..915cb77
--- /dev/null
+++ b/Documentation/git-replace.txt
@@ -0,0 +1,71 @@
+git-replace(1)
+==============
+
+NAME
+----
+git-replace - Create, list, delete refs to replace objects
+
+SYNOPSIS
+--------
+[verse]
+'git replace' [-f] <object> <replacement>
+'git replace' -d <object>...
+'git replace' -l [<pattern>]
+
+DESCRIPTION
+-----------
+Adds a 'replace' reference in `.git/refs/replace/`
+
+The name of the 'replace' reference is the SHA1 of the object that is
+replaced. The content of the replace reference is the SHA1 of the
+replacement object.
+
+Unless `-f` is given, the replace reference must not yet exist in
+`.git/refs/replace/` directory.
+
+OPTIONS
+-------
+-f::
+	If an existing replace ref for the same object exists, it will
+	be overwritten (instead of failing).
+
+-d::
+	Delete existing replace refs for the given objects.
+
+-l <pattern>::
+	List replace refs for objects that match the given pattern (or
+	all if no pattern is given).
+	Typing "git replace" without arguments, also lists all replace
+	refs.
+
+BUGS
+----
+Comparing blobs or trees that have been replaced with those that
+replace them will not work properly. And using 'git reset --hard' to
+go back to a replaced commit will move the branch to the replacement
+commit instead of the replaced commit.
+
+There may be other problems when using 'git rev-list' related to
+pending objects. And of course things may break if an object of one
+type is replaced by an object of another type (for example a blob
+replaced by a commit).
+
+SEE ALSO
+--------
+linkgit:git-tag[1]
+linkgit:git-branch[1]
+
+Author
+------
+Written by Christian Couder <chriscool@tuxfamily.org> and Junio C
+Hamano <gitster@pobox.com>, based on 'git tag' by Kristian Hogsberg
+<krh@redhat.com> and Carlos Rica <jasampler@gmail.com>.
+
+Documentation
+--------------
+Documentation by Christian Couder <chriscool@tuxfamily.org> and the
+git-list <git@vger.kernel.org>, based on 'git tag' documentation.
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.6.2.2.572.g4420a
