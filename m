From: Christian Schlotter <schlotter@users.sourceforge.net>
Subject: [PATCH] git-clone: Sync documentation to usage note.
Date: Thu, 15 Feb 2007 23:13:54 +0100
Message-ID: <117157763494-git-send-email-schlotter@users.sourceforge.net>
Cc: Christian Schlotter <schlotter@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 23:15:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHot9-0007rR-9P
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 23:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161487AbXBOWO4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 17:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161488AbXBOWO4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 17:14:56 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:53448 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161487AbXBOWOy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 17:14:54 -0500
Received: from [84.175.163.191] (helo=acer)
	by mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis),
	id 0ML25U-1HHosN425I-0006Ld; Thu, 15 Feb 2007 23:14:53 +0100
Received: by acer (sSMTP sendmail emulation); Thu, 15 Feb 2007 23:13:54 +0100
X-Mailer: git-send-email 1.5.0
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:03851f2123155a0adb6932167c7dba9e
X-Provags-ID2: V01U2FsdGVkX19Ms7nlrFsqeB/Sq+9H1ryBZgQbjlxNSGVRVPQGmRY7IorEVSb88oGb5bmME4XtRFeO3IrJsqMvUUeOj6t+PpbPNR42KZTNMobM67ZcE3D3sQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39859>

Documentation advertises the new `--depth <n>' parameter with an equal
sign, while the usage notes (shown after `git-clone --help') do not.  If I
understood git-clone's source code correctly, the version without the
equal sign is correct, which is why this patch syncs documentation to the
usage note.

Please note that I was not able to test the new shallow clone feature, as
both
    git clone --depth=5 git://git2.kernel.org/pub/scm/git/git.git
and
    git clone --depth 5 git://git2.kernel.org/pub/scm/git/git.git
do not seem to work.  The former correctly produces the usage note, while
the latter prints

    Initialized empty Git repository in /home/cs/tmp2/git/.git/
    fatal: read error (Connection reset by peer)
    fetch-pack from 'git://git2.kernel.org/pub/scm/git/git.git' failed.

Is this a problem on my end?

Signed-off-by: Christian Schlotter <schlotter@users.sourceforge.net>
---
 Documentation/RelNotes-1.5.0.txt |    2 +-
 Documentation/git-clone.txt      |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RelNotes-1.5.0.txt b/Documentation/RelNotes-1.5.0.txt
index 599efb8..daf4bdb 100644
--- a/Documentation/RelNotes-1.5.0.txt
+++ b/Documentation/RelNotes-1.5.0.txt
@@ -448,7 +448,7 @@ Updates in v1.5.0 since v1.4.4 series
  - There is a partial support for 'shallow' repositories that
    keeps only recent history.  A 'shallow clone' is created by
    specifying how deep that truncated history should be
-   (e.g. "git clone --depth=5 git://some.where/repo.git").
+   (e.g. "git clone --depth 5 git://some.where/repo.git").
 
    Currently a shallow repository has number of limitations:
 
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 707376f..6d32c49 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-clone' [--template=<template_directory>] [-l [-s]] [-q] [-n] [--bare]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth=<depth>] <repository> [<directory>]
+	  [--depth <depth>] <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -96,7 +96,7 @@ OPTIONS
 	if unset the templates are taken from the installation
 	defined default, typically `/usr/share/git-core/templates`.
 
---depth=<depth>::
+--depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
 	specified number of revs.  A shallow repository has
 	number of limitations (you cannot clone or fetch from
-- 
1.5.0
