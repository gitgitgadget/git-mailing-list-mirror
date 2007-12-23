From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Fix for missing line in man page rendered for git shortlog
Date: Sun, 23 Dec 2007 19:34:51 +0100
Message-ID: <1198434891-25847-1-git-send-email-hendeby@isy.liu.se>
References: <20071223171840.GA8799@sigill.intra.peff.net>
Cc: git@vger.kernel.org, Gustaf Hendeby <hendeby@isy.liu.se>
To: peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Dec 23 19:35:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6VfS-0007vV-HN
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 19:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbXLWSey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 13:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbXLWSey
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 13:34:54 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:33894 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbXLWSex (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 13:34:53 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 2EFE925A61;
	Sun, 23 Dec 2007 19:34:52 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 13026-05; Sun, 23 Dec 2007 19:34:51 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 3AA0525A44;
	Sun, 23 Dec 2007 19:34:51 +0100 (MET)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 264F11779C; Sun, 23 Dec 2007 19:34:51 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc1.22.g4b71
In-Reply-To: <20071223171840.GA8799@sigill.intra.peff.net>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69191>

This is a work around for a asciidoc/xmlto problem with lines starting
with a '.'.  Until a proper fix for this is found, rewrite problematic
sections.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
Acked-by: Jeff King <peff@peff.net>
---

Jeff King wrote:
> On Sun, Dec 23, 2007 at 03:16:00PM +0100, Gustaf Hendeby wrote:
>
> I mentioned this same issue a few weeks ago:
>
>   <20071211124220.GA17929@sigill.intra.peff.net>

Ah, I missed that one.  Unfortunately, the lack of answers indicate it isn't
trivial to find a general fix to the problem. :(

> I think re-wording is a fine fix, at least for now.
>
>> Something like this (would we then like to reindent this?  it would make the
>> change look much bigger), which seems to work with my asciidoc version:
>
> If by "reindent" you mean not just "wrap the long line" but "the whole
> paragraph should start at the beginning of the line, since it's no
> longer part of the list element", then
>
> Acked-by: Jeff King <peff@peff.net>

I hope I understood corretly when I added your ACK to the patch.

Thanks,
	Gustaf

 Documentation/git-shortlog.txt |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index e14720b..854bf7a 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -37,16 +37,14 @@ OPTIONS
 
 FILES
 -----
-
-.mailmap::
-	If this file exists, it will be used for mapping author email
-	addresses to a real author name. One mapping per line, first
-	the author name followed by the email address enclosed by
-	'<' and '>'. Use hash '#' for comments. Example:
-
-		# Keep alphabetized
-		Adam Morrow <adam@localhost.localdomain>
-		Eve Jones <eve@laptop.(none)>
+If the file .mailmap exists, it will be used for mapping author email
+addresses to a real author name. One mapping per line, first the
+author name followed by the email address enclosed by '<' and '>'. Use
+hash '#' for comments. Example:
+
+	# Keep alphabetized
+	Adam Morrow <adam@localhost.localdomain>
+	Eve Jones <eve@laptop.(none)>
 
 Author
 ------
-- 
1.5.4.rc1.22.g4b71
