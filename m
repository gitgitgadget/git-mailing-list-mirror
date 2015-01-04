From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] subtree: fix AsciiDoc list item continuation
Date: Sun,  4 Jan 2015 11:54:47 +0100
Message-ID: <1420368887-10958-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 12:09:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7j3c-0004jX-Gd
	for gcvg-git-2@plane.gmane.org; Sun, 04 Jan 2015 12:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbbADLJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2015 06:09:11 -0500
Received: from mailer.zib.de ([130.73.108.11]:60156 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbbADLJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2015 06:09:09 -0500
X-Greylist: delayed 837 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Jan 2015 06:09:08 EST
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id t04At8OV025564;
	Sun, 4 Jan 2015 11:55:08 +0100 (CET)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id t04At72H022984;
	Sun, 4 Jan 2015 11:55:07 +0100 (CET)
X-Mailer: git-send-email 2.1.0.505.ge446440
X-Miltered: at mailer.zib.de with ID 54A91C0C.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 54A91C0C.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 54A91C0C.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262005>

List items must be continued with '+' (see [asciidoc]).

[asciidoc] AsciiDoc user guide 17.7. List Item Continuation
    <http://www.methods.co.nz/asciidoc/userguide.html#X15>

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 contrib/subtree/git-subtree.txt | 194 ++++++++++++++++++----------------------
 1 file changed, 89 insertions(+), 105 deletions(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 8272100..54e4b4a 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -81,12 +81,11 @@ merge::
 	changes into the latest <commit>.  With '--squash',
 	creates only one commit that contains all the changes,
 	rather than merging in the entire history.
-
-	If you use '--squash', the merge direction doesn't
-	always have to be forward; you can use this command to
-	go back in time from v2.5 to v2.4, for example.  If your
-	merge introduces a conflict, you can resolve it in the
-	usual ways.
++
+If you use '--squash', the merge direction doesn't always have to be
+forward; you can use this command to go back in time from v2.5 to v2.4,
+for example.  If your merge introduces a conflict, you can resolve it in
+the usual ways.
 	
 pull::
 	Exactly like 'merge', but parallels 'git pull' in that
@@ -107,21 +106,19 @@ split::
 	contents of <prefix> at the root of the project instead
 	of in a subdirectory.  Thus, the newly created history
 	is suitable for export as a separate git repository.
-	
-	After splitting successfully, a single commit id is
-	printed to stdout.  This corresponds to the HEAD of the
-	newly created tree, which you can manipulate however you
-	want.
-	
-	Repeated splits of exactly the same history are
-	guaranteed to be identical (i.e. to produce the same
-	commit ids).  Because of this, if you add new commits
-	and then re-split, the new commits will be attached as
-	commits on top of the history you generated last time,
-	so 'git merge' and friends will work as expected.
-	
-	Note that if you use '--squash' when you merge, you
-	should usually not just '--rejoin' when you split.
++
+After splitting successfully, a single commit id is printed to stdout.
+This corresponds to the HEAD of the newly created tree, which you can
+manipulate however you want.
++
+Repeated splits of exactly the same history are guaranteed to be
+identical (i.e. to produce the same commit ids).  Because of this, if
+you add new commits and then re-split, the new commits will be attached
+as commits on top of the history you generated last time, so 'git merge'
+and friends will work as expected.
++
+Note that if you use '--squash' when you merge, you should usually not
+just '--rejoin' when you split.
 
 
 OPTIONS
@@ -151,109 +148,96 @@ OPTIONS FOR add, merge, push, pull
 --squash::
 	This option is only valid for add, merge, push and pull
 	commands.
-
-	Instead of merging the entire history from the subtree
-	project, produce only a single commit that contains all
-	the differences you want to merge, and then merge that
-	new commit into your project.
-	
-	Using this option helps to reduce log clutter. People
-	rarely want to see every change that happened between
-	v1.0 and v1.1 of the library they're using, since none of the
-	interim versions were ever included in their application.
-	
-	Using '--squash' also helps avoid problems when the same
-	subproject is included multiple times in the same
-	project, or is removed and then re-added.  In such a
-	case, it doesn't make sense to combine the histories
-	anyway, since it's unclear which part of the history
-	belongs to which subtree.
-	
-	Furthermore, with '--squash', you can switch back and
-	forth between different versions of a subtree, rather
-	than strictly forward.  'git subtree merge --squash'
-	always adjusts the subtree to match the exactly
-	specified commit, even if getting to that commit would
-	require undoing some changes that were added earlier.
-	
-	Whether or not you use '--squash', changes made in your
-	local repository remain intact and can be later split
-	and send upstream to the subproject.
++
+Instead of merging the entire history from the subtree project, produce
+only a single commit that contains all the differences you want to
+merge, and then merge that new commit into your project.
++
+Using this option helps to reduce log clutter. People rarely want to see
+every change that happened between v1.0 and v1.1 of the library they're
+using, since none of the interim versions were ever included in their
+application.
++
+Using '--squash' also helps avoid problems when the same subproject is
+included multiple times in the same project, or is removed and then
+re-added.  In such a case, it doesn't make sense to combine the
+histories anyway, since it's unclear which part of the history belongs
+to which subtree.
++
+Furthermore, with '--squash', you can switch back and forth between
+different versions of a subtree, rather than strictly forward.  'git
+subtree merge --squash' always adjusts the subtree to match the exactly
+specified commit, even if getting to that commit would require undoing
+some changes that were added earlier.
++
+Whether or not you use '--squash', changes made in your local repository
+remain intact and can be later split and send upstream to the
+subproject.
 
 
 OPTIONS FOR split
 -----------------
 --annotate=<annotation>::
 	This option is only valid for the split command.
-
-	When generating synthetic history, add <annotation> as a
-	prefix to each commit message.  Since we're creating new
-	commits with the same commit message, but possibly
-	different content, from the original commits, this can help
-	to differentiate them and avoid confusion.
-	
-	Whenever you split, you need to use the same
-	<annotation>, or else you don't have a guarantee that
-	the new re-created history will be identical to the old
-	one.  That will prevent merging from working correctly. 
-	git subtree tries to make it work anyway, particularly
-	if you use --rejoin, but it may not always be effective.
++
+When generating synthetic history, add <annotation> as a prefix to each
+commit message.  Since we're creating new commits with the same commit
+message, but possibly different content, from the original commits, this
+can help to differentiate them and avoid confusion.
++
+Whenever you split, you need to use the same <annotation>, or else you
+don't have a guarantee that the new re-created history will be identical
+to the old one.  That will prevent merging from working correctly.  git
+subtree tries to make it work anyway, particularly if you use --rejoin,
+but it may not always be effective.
 
 -b <branch>::
 --branch=<branch>::
 	This option is only valid for the split command.
-
-	After generating the synthetic history, create a new
-	branch called <branch> that contains the new history. 
-	This is suitable for immediate pushing upstream. 
-	<branch> must not already exist.
++
+After generating the synthetic history, create a new branch called
+<branch> that contains the new history.  This is suitable for immediate
+pushing upstream.  <branch> must not already exist.
 
 --ignore-joins::
 	This option is only valid for the split command.
-
-	If you use '--rejoin', git subtree attempts to optimize
-	its history reconstruction to generate only the new
-	commits since the last '--rejoin'.  '--ignore-join'
-	disables this behaviour, forcing it to regenerate the
-	entire history.  In a large project, this can take a
-	long time.
++
+If you use '--rejoin', git subtree attempts to optimize its history
+reconstruction to generate only the new commits since the last
+'--rejoin'.  '--ignore-join' disables this behaviour, forcing it to
+regenerate the entire history.  In a large project, this can take a long
+time.
 
 --onto=<onto>::
 	This option is only valid for the split command.
-
-	If your subtree was originally imported using something
-	other than git subtree, its history may not match what
-	git subtree is expecting.  In that case, you can specify
-	the commit id <onto> that corresponds to the first
-	revision of the subproject's history that was imported
-	into your project, and git subtree will attempt to build
-	its history from there.
-	
-	If you used 'git subtree add', you should never need
-	this option.
++
+If your subtree was originally imported using something other than git
+subtree, its history may not match what git subtree is expecting.  In
+that case, you can specify the commit id <onto> that corresponds to the
+first revision of the subproject's history that was imported into your
+project, and git subtree will attempt to build its history from there.
++
+If you used 'git subtree add', you should never need this option.
 
 --rejoin::
 	This option is only valid for the split command.
-
-	After splitting, merge the newly created synthetic
-	history back into your main project.  That way, future
-	splits can search only the part of history that has
-	been added since the most recent --rejoin.
-	
-	If your split commits end up merged into the upstream
-	subproject, and then you want to get the latest upstream
-	version, this will allow git's merge algorithm to more
-	intelligently avoid conflicts (since it knows these
-	synthetic commits are already part of the upstream
-	repository).
-	
-	Unfortunately, using this option results in 'git log'
-	showing an extra copy of every new commit that was
-	created (the original, and the synthetic one).
-	
-	If you do all your merges with '--squash', don't use
-	'--rejoin' when you split, because you don't want the
-	subproject's history to be part of your project anyway.
++
+After splitting, merge the newly created synthetic history back into
+your main project.  That way, future splits can search only the part of
+history that has been added since the most recent --rejoin.
++
+If your split commits end up merged into the upstream subproject, and
+then you want to get the latest upstream version, this will allow git's
+merge algorithm to more intelligently avoid conflicts (since it knows
+these synthetic commits are already part of the upstream repository).
++
+Unfortunately, using this option results in 'git log' showing an extra
+copy of every new commit that was created (the original, and the
+synthetic one).
++
+If you do all your merges with '--squash', don't use '--rejoin' when you
+split, because you don't want the subproject's history to be part of
+your project anyway.
 
 
 EXAMPLE 1. Add command
-- 
2.2.1.217.gb07cdde
