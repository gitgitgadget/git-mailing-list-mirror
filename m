From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2 (for GIT-GUI)] git-gui: MERGE_RR lives in .git/ directly
 with newer Git versions
Date: Sat, 12 Jul 2008 15:56:59 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807121556480.8950@racer>
References: <87skufmjg4.fsf@Astalo.kon.iki.fi> <alpine.DEB.1.00.0807121553120.8950@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, spearce@spearce.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Sat Jul 12 16:57:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHgXt-0008Fn-Qk
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 16:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbYGLO5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 10:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbYGLO5A
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 10:57:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:38480 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753510AbYGLO47 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 10:56:59 -0400
Received: (qmail invoked by alias); 12 Jul 2008 14:56:57 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp040) with SMTP; 12 Jul 2008 16:56:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/P13oOLCrP3yHAeMDAKVWmHONtfcZfIl6nRnGYwp
	iPxoVBEdzWvmK0
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0807121553120.8950@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88244>


Now that MERGE_RR was moved out of .git/rr-cache/, we have to delete
it somewhere else.  Just in case somebody wants to use a newer git-gui
with an older Git, the file .git/rr-cache/MERGE_RR is removed, too (if
it exists).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui/lib/merge.tcl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/merge.tcl b/lib/merge.tcl
index cc26b07..5c01875 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -257,6 +257,7 @@ proc _reset_wait {fd} {
 
 		catch {file delete [gitdir MERGE_HEAD]}
 		catch {file delete [gitdir rr-cache MERGE_RR]}
+		catch {file delete [gitdir MERGE_RR]}
 		catch {file delete [gitdir SQUASH_MSG]}
 		catch {file delete [gitdir MERGE_MSG]}
 		catch {file delete [gitdir GITGUI_MSG]}
-- 
1.5.6.2.511.ge432a
