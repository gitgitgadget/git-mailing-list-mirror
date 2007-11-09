From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] Documentation: remove documentation for removed tools.
Date: Thu, 08 Nov 2007 17:22:44 -0800
Message-ID: <7vy7d8xlej.fsf_-_@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711072253580.4362@racer.site>
	<7vlk998u6r.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711080041120.4362@racer.site>
	<20071108145435.GA18727@diku.dk> <4733249B.9020504@op5.se>
	<20071108160114.GB20988@diku.dk>
	<7vzlxo1mga.fsf@gitster.siamese.dyndns.org>
	<20071109002001.GB5082@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:23:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIaf-0000zM-2l
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbXKIBXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbXKIBXE
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:23:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39657 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbXKIBXC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:23:02 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E0E802FC;
	Thu,  8 Nov 2007 20:23:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C303E93A7D;
	Thu,  8 Nov 2007 20:23:17 -0500 (EST)
In-Reply-To: <20071109002001.GB5082@diku.dk> (Jonas Fonseca's message of "Fri,
	9 Nov 2007 01:20:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64105>

Old commit walkers other than http/curl transport have been removed
for some time now.  Remove their documents.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/cmd-list.perl       |    3 --
 Documentation/git-local-fetch.txt |   66 -------------------------------------
 Documentation/git-ssh-fetch.txt   |   52 -----------------------------
 Documentation/git-ssh-upload.txt  |   48 ---------------------------
 4 files changed, 0 insertions(+), 169 deletions(-)
 delete mode 100644 Documentation/git-local-fetch.txt
 delete mode 100644 Documentation/git-ssh-fetch.txt
 delete mode 100644 Documentation/git-ssh-upload.txt

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 0066064..964fda3 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -128,7 +128,6 @@ git-index-pack                          plumbingmanipulators
 git-init                                mainporcelain
 git-instaweb                            ancillaryinterrogators
 gitk                                    mainporcelain
-git-local-fetch                         synchingrepositories
 git-log                                 mainporcelain
 git-lost-found                          ancillarymanipulators	deprecated
 git-ls-files                            plumbinginterrogators
@@ -182,8 +181,6 @@ git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-setup                            purehelpers
-git-ssh-fetch                           synchingrepositories
-git-ssh-upload                          synchingrepositories
 git-stash                               mainporcelain
 git-status                              mainporcelain
 git-stripspace                          purehelpers
diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
deleted file mode 100644
index e830dee..0000000
--- a/Documentation/git-local-fetch.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-git-local-fetch(1)
-==================
-
-NAME
-----
-git-local-fetch - Duplicate another git repository on a local system
-
-
-SYNOPSIS
---------
-[verse]
-'git-local-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [-l] [-s] [-n]
-                  commit-id path
-
-DESCRIPTION
------------
-THIS COMMAND IS DEPRECATED.
-
-Duplicates another git repository on a local system.
-
-OPTIONS
--------
--c::
-	Get the commit objects.
--t::
-	Get trees associated with the commit objects.
--a::
-	Get all the objects.
--v::
-	Report what is downloaded.
--s::
-	Instead of regular file-to-file copying use symbolic links to the objects
-	in the remote repository.
--l::
-	Before attempting symlinks (if -s is specified) or file-to-file copying the
-	remote objects, try to hardlink the remote objects into the local
-	repository.
--n::
-	Never attempt to file-to-file copy remote objects.  Only useful with
-	-s or -l command-line options.
-
--w <filename>::
-        Writes the commit-id into the filename under $GIT_DIR/refs/<filename> on
-        the local end after the transfer is complete.
-
---stdin::
-	Instead of a commit id on the command line (which is not expected in this
-	case), 'git-local-fetch' expects lines on stdin in the format
-
-		<commit-id>['\t'<filename-as-in--w>]
-
---recover::
-	Verify that everything reachable from target is fetched.  Used after
-	an earlier fetch is interrupted.
-
-Author
-------
-Written by Junio C Hamano <junkio@cox.net>
-
-Documentation
---------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the gitlink:git[7] suite
diff --git a/Documentation/git-ssh-fetch.txt b/Documentation/git-ssh-fetch.txt
deleted file mode 100644
index 8d3e2ff..0000000
--- a/Documentation/git-ssh-fetch.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-git-ssh-fetch(1)
-================
-
-NAME
-----
-git-ssh-fetch - Fetch from a remote repository over ssh connection
-
-
-
-SYNOPSIS
---------
-'git-ssh-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] commit-id url
-
-DESCRIPTION
------------
-THIS COMMAND IS DEPRECATED.
-
-Pulls from a remote repository over ssh connection, invoking
-git-ssh-upload on the other end. It functions identically to
-git-ssh-upload, aside from which end you run it on.
-
-
-OPTIONS
--------
-commit-id::
-        Either the hash or the filename under [URL]/refs/ to
-        pull.
-
--c::
-	Get the commit objects.
--t::
-	Get trees associated with the commit objects.
--a::
-	Get all the objects.
--v::
-	Report what is downloaded.
--w::
-        Writes the commit-id into the filename under $GIT_DIR/refs/ on
-        the local end after the transfer is complete.
-
-
-Author
-------
-Written by Daniel Barkalow <barkalow@iabervon.org>
-
-Documentation
---------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the gitlink:git[7] suite
diff --git a/Documentation/git-ssh-upload.txt b/Documentation/git-ssh-upload.txt
deleted file mode 100644
index 5e2ca8d..0000000
--- a/Documentation/git-ssh-upload.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-git-ssh-upload(1)
-=================
-
-NAME
-----
-git-ssh-upload - Push to a remote repository over ssh connection
-
-
-SYNOPSIS
---------
-'git-ssh-upload' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] commit-id url
-
-DESCRIPTION
------------
-THIS COMMAND IS DEPRECATED.
-
-Pushes from a remote repository over ssh connection, invoking
-git-ssh-fetch on the other end. It functions identically to
-git-ssh-fetch, aside from which end you run it on.
-
-OPTIONS
--------
-commit-id::
-        Id of commit to push.
-
--c::
-        Get the commit objects.
--t::
-        Get tree associated with the requested commit object.
--a::
-        Get all the objects.
--v::
-        Report what is uploaded.
--w::
-        Writes the commit-id into the filename under [URL]/refs/ on
-        the remote end after the transfer is complete.
-
-Author
-------
-Written by Daniel Barkalow <barkalow@iabervon.org>
-
-Documentation
---------------
-Documentation by Daniel Barkalow
-
-GIT
----
-Part of the gitlink:git[7] suite
-- 
1.5.3.5.1622.g41d10
