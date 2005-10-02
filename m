From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Update git-clone documentation
Date: Sun, 02 Oct 2005 13:42:57 -0600
Message-ID: <m1wtkv903i.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 02 21:44:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EM9l9-0005pu-20
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 21:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVJBToP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 15:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVJBToP
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 15:44:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10691 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751032AbVJBToP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2005 15:44:15 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j92Jgwsk001924;
	Sun, 2 Oct 2005 13:42:58 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j92Jgv09001923;
	Sun, 2 Oct 2005 13:42:57 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9622>


The documentation for git-clone is behind the actual command.
I have been getting tired of reading the shell script to see
what the arguments are so here is an update of the actual documentation.

Signed-off-by: Eric Biederman <ebiederman@xmission.com>

 git-clone.txt |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -9,7 +9,7 @@ git-clone - Clones a repository.
 
 SYNOPSIS
 --------
-'git clone' [-l] [-u <upload-pack>] [-q] <repository> <directory>
+'git clone' [-l [-s]] [-q] [-n] [-u <upload-pack>] <repository> <directory>
 
 DESCRIPTION
 -----------
@@ -17,6 +17,7 @@ Clones a repository into a newly created
 
 OPTIONS
 -------
+--local::
 -l::
 	When the repository to clone from is on a local machine,
 	this flag bypasses normal "git aware" transport
@@ -25,10 +26,22 @@ OPTIONS
 	The files under .git/objects/ directory are hardlinked
 	to save space when possible.
 
+--shared::
+-s::
+	When the repository to clone is on the local machine,
+	instead of using hard links automatically setup
+	.git/objects/info/alternatives to share the objects
+	with the source repository
+
+--quiet::
 -q::
 	Operate quietly.  This flag is passed to "rsync" and
 	"git-clone-pack" commands when given.
 
+-n::
+	No checkout of HEAD is performed after the clone is complete.
+
+--upload-pack <upload-pack>::
 -u <upload-pack>::
 	When given, and the repository to clone from is handled
 	by 'git-clone-pack', '--exec=<upload-pack>' is passed to
