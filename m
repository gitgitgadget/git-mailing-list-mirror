From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] SubmittingPatches: mention older C compiler compatibility
Date: Mon, 21 May 2007 13:48:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705211347540.6410@racer.site>
References: <20070520154227.GG5412@admingilde.org> <20070521062005.GK3141@spearce.org>
 <20070521073253.GU5412@admingilde.org> <7vabvyfw7n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Waitz <tali@admingilde.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 14:49:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq7KT-0008Mg-4d
	for gcvg-git@gmane.org; Mon, 21 May 2007 14:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939AbXEUMta (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 08:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755966AbXEUMta
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 08:49:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:57110 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755939AbXEUMt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 08:49:29 -0400
Received: (qmail invoked by alias); 21 May 2007 12:49:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 21 May 2007 14:49:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XZNNkF19XNDo+kQjHS8qXrxvKTDXslVPyFVIWW3
	YWRZureqiiKyZf
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabvyfw7n.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48015>


We do not appreciate C99 initializers, declarations after statements,
or "0" instead of "NULL".

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Mon, 21 May 2007, Junio C Hamano wrote:
	
	> Portability rules:
	> 
	>  - We do not do C99 initializers;
	>  - We do not do decl-after-statement;
	> 
	> Readability rules:
	> 
	>  - We always write NULL, not 0, for a NULL pointer.
	> 
	> There may be a handful more unwritten rules we use.

	... so let's start with these 3.

 Documentation/SubmittingPatches |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 6a4da2d..cc74b4b 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -65,6 +65,19 @@ in templates/hooks--pre-commit.  To help ensure this does not happen,
 run git diff --check on your changes before you commit.
 
 
+(1a) Try to be nice to older C compilers
+
+We pride ourselves with the wide range of C compilers you can compile
+git with. That means that you should not use C99 initializers, even
+if a lot of compilers grok it.
+
+Also, variables have to be declared at the beginning of the block
+(you can check this with gcc, using the -Wdeclaration-after-statement
+option).
+
+Another thing: NULL pointers shall be written as NULL, not as 0.
+
+
 (2) Generate your patch using git tools out of your commits.
 
 git based diff tools (git, Cogito, and StGIT included) generate
