From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 11/17] Documentation/git-format-patch.txt: Add --signoff, --check, and long option-names.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844853961-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844852416-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCP-0004lM-3y
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbVLHX2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbVLHX2X
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:23 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:26318 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932735AbVLHX2R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:17 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051208232816.VWZB17186.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 00:28:16 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 09 Dec 2005 00:28:33 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.99,232,1131318000"; 
   d="scan'208"; a="16674758:sNHT197373510"
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id AE065ADFF6;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <11340844852416-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13401>

The documentation was lacking descriptions for the --signoff and --check
options to git-format-patch.  It was also missing the following long
option-names: --output-directory (-o), --numbered (-n), --keep-subject
(-k), --author (-a), --date (-d), and --mbox (-m).

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-format-patch.txt |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

be287ad64c289c1e3ff43e0784392bda3bbe3557
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 7a3abec..abb8fc8 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -8,7 +8,7 @@ git-format-patch - Prepare patches for e
 
 SYNOPSIS
 --------
-'git-format-patch' [-n][-o <dir>|--stdout][-k][--mbox][--diff-options] <his> [<mine>]
+'git-format-patch' [-n | -k] [-o <dir> | --stdout] [-s] [-c] [--mbox] [--diff-options] <his> [<mine>]
 
 DESCRIPTION
 -----------
@@ -32,23 +32,34 @@ processing with applymbox.
 
 OPTIONS
 -------
--o <dir>::
+-o|--output-directory <dir>::
 	Use <dir> to store the resulting files, instead of the
 	current working directory.
 
--n::
+-n|--numbered::
 	Name output in '[PATCH n/m]' format.
 
--k::
+-k|--keep-subject::
 	Do not strip/add '[PATCH]' from the first line of the
 	commit log message.
 
---author, --date::
+-a|--author, -d|--date::
 	Output From: and Date: headers for commits made by
 	yourself as well.  Usually these are output only for
 	commits made by people other than yourself.
 
---mbox::
+-s|--signoff::
+	Add `Signed-off-by:` line to the commit message, using
+	the committer identity of yourself.
+
+-c|--check::
+        Display suspicious lines in the patch.  The definition
+        of 'suspicious lines' is currently the lines that has
+        trailing whitespaces, and the lines whose indentation
+        has a SP character immediately followed by a TAB
+        character.
+
+-m|--mbox::
 	Format the output files for closer to mbox format by
 	adding a phony Unix "From " line, so they can be
 	concatenated together and fed to `git-applymbox`.
-- 
0.99.9l
