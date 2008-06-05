From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] Add subcommand "help" to the list of most commonly used subcommands
Date: Thu, 5 Jun 2008 11:19:11 +0300
Message-ID: <20080605081911.GA5946@mithlond.arda.local>
References: <alpine.DEB.1.00.0806050747000.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 10:20:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Ahc-000277-RT
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 10:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbYFEITR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 04:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYFEITQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 04:19:16 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:38234 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751731AbYFEITP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 04:19:15 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.5.014)
        id 483E837C00579AF5; Thu, 5 Jun 2008 11:19:12 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K4Agh-00047O-9Y; Thu, 05 Jun 2008 11:19:11 +0300
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806050747000.21190@racer>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83879>

Johannes Schindelin wrote (2008-06-05 07:48 +0100):

> A typical output would now look like this:
> 
> 	$ git reabse
> 	git: 'reabse' is not a git-command. See 'git --help'.

A side note: The following three commands seem to do exactly the same:

  $ git --help log
  $ git log --help
  $ git help log

Which in itself is good, I think, since in all the cases user expects to
get the manual for "log". It seems that "git help <command>" is the most
often advertised in manuals and tutorials but it does not show in the
list printed by "git / git --help / git help":

  $ git
  usage: [...]

  The most commonly used git commands are:
  [There's no "help" command in the list.]

I think it belongs there, so how about the following patch? There are
two logically separate changes but I didn't feel that they deserve
separate commits.

---snip---
Add subcommand "help" to the list of most commonly used subcommands

Commands "git", "git --help" and "git help" did not list the subcommand
"help" as one of the most commonly used git commands. Yet "git help" is
advertised as the help command of git so this patch adds "help" the
list.

In addition to that change the short description in git-help.txt manual
to start with a capital letter.

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---
 Documentation/git-help.txt |    2 +-
 command-list.txt           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index bfbba9e..4d3613c 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -3,7 +3,7 @@ git-help(1)
 
 NAME
 ----
-git-help - display help information about git
+git-help - Display help information about git
 
 SYNOPSIS
 --------
diff --git a/command-list.txt b/command-list.txt
index 3583a33..510ac69 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -47,7 +47,7 @@ git-get-tar-commit-id                   ancillaryinterrogators
 git-grep                                mainporcelain common
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
-git-help				ancillaryinterrogators
+git-help				ancillaryinterrogators common
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
 git-imap-send                           foreignscminterface
-- 
1.5.6.rc1.15.gc0c85
