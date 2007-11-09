From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Remove non-existing commands from git(7) and delete their manpages
Date: Fri, 9 Nov 2007 01:20:02 +0100
Message-ID: <20071109002001.GB5082@diku.dk>
References: <Pine.LNX.4.64.0711072253580.4362@racer.site> <7vlk998u6r.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711080041120.4362@racer.site> <20071108145435.GA18727@diku.dk> <4733249B.9020504@op5.se> <20071108160114.GB20988@diku.dk> <7vzlxo1mga.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:20:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIYD-0000R4-ST
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758875AbXKIBUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759983AbXKIBUU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:20:20 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:38206 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759943AbXKIBUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:20:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 7A0BB770009;
	Fri,  9 Nov 2007 01:20:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xd9fwkoMIm6c; Fri,  9 Nov 2007 01:20:02 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 4875A52C358;
	Fri,  9 Nov 2007 01:20:02 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id EC77C6DFE34; Fri,  9 Nov 2007 01:19:40 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 284BD5B8001; Fri,  9 Nov 2007 01:20:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vzlxo1mga.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64101>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/cmd-list.perl       |    3 --
 Documentation/git-local-fetch.txt |   66 -------------------------------------
 Documentation/git-ssh-fetch.txt   |   52 -----------------------------
 Documentation/git-ssh-upload.txt  |   48 ---------------------------
 4 files changed, 0 insertions(+), 169 deletions(-)
 delete mode 100644 Documentation/git-local-fetch.txt
 delete mode 100644 Documentation/git-ssh-fetch.txt
 delete mode 100644 Documentation/git-ssh-upload.txt

 Junio C Hamano <gitster@pobox.com> wrote Thu, Nov 08, 2007:
 > Thanks.
 > 
 > But lost-found is merely deprecated but not removed yet, so I
 > think it should be kept in the list cmd-list.perl generates.
 
 I don't understand why you want to still advertise commands that have
 been deprecated, but here is a sliced out part of my previous patch,
 which I hope is acceptible.
 
 > We may want a mechanism to mark it deprecated in the list as
 > well, though.  Perhaps ...

 It might also make sense to put this kind of information in the manpage
 document header:

 	git-lost-found(1)
	=================
	:Deprecated:	Use git-fsck --lost-found instead.

 And then modify asciidoc.conf to put in a warnings a few places.

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 8d21d42..8a0679a 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -124,7 +124,6 @@ git-index-pack                          plumbingmanipulators
 git-init                                mainporcelain
 git-instaweb                            ancillaryinterrogators
 gitk                                    mainporcelain
-git-local-fetch                         synchingrepositories
 git-log                                 mainporcelain
 git-lost-found                          ancillarymanipulators
 git-ls-files                            plumbinginterrogators
@@ -178,8 +177,6 @@ git-show-branch                         ancillaryinterrogators
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
1.5.3.5.1623.gabaff-dirty

-- 
Jonas Fonseca
