From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add: allow path limiting with -u
Date: Sun, 13 May 2007 20:39:11 -0400
Message-ID: <20070514003910.GA6689@coredump.intra.peff.net>
References: <20070512064159.GA7471@coredump.intra.peff.net> <200705131235.25281.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 02:39:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnOat-0002Aw-HW
	for gcvg-git@gmane.org; Mon, 14 May 2007 02:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbXENAjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 20:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758033AbXENAjO
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 20:39:14 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4414 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181AbXENAjO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 20:39:14 -0400
Received: (qmail 1787 invoked from network); 14 May 2007 00:39:12 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 14 May 2007 00:39:12 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 13 May 2007 20:39:11 -0400
Content-Disposition: inline
In-Reply-To: <200705131235.25281.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47205>

On Sun, May 13, 2007 at 12:35:24PM +0200, Jakub Narebski wrote:

> Do git-add *needs* path specifier (even if it is '.') also for `-u'?
> The changes in documentation were to reflect that `-u' is incompatibile
> with explicit paths, or that `-u' does not require explicit paths
> contrary to git-add without `-u'.

Sorry, I don't understand if you are asking that question, or if you are
asking if the documentation needs to clarify that point.

The answer to the first is "no", the path limiting works exactly as it
does for every other command: no path specifier indicates the whole
tree.

If you are concerned about the latter, do you mean something like this:

-- >8 --
Documentation/git-add: clarify -u with path limiting

Signed-off-by: Jeff King <peff@peff.net>
---
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ea27018..27b9c0f 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -57,8 +57,11 @@ OPTIONS
 	the index.
 
 -u::
-	Update all files that git already knows about. This is what
-	"git commit -a" does in preparation for making a commit.
+	Update only files that git already knows about. This is similar
+	to what "git commit -a" does in preparation for making a commit,
+	except that the update is limited to paths specified on the
+	command line. If no paths are specified, all tracked files are
+	updated.
 
 \--::
 	This option can be used to separate command-line options from
