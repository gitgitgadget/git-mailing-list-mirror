From: Johan Herland <johan@herland.net>
Subject: [PATCH] diff funcname_pattern: Allow HTML header tags without
 attributes
Date: Tue, 23 Sep 2008 02:49:23 +0200
Message-ID: <200809230249.23298.johan@herland.net>
References: <b-t750rmbNQ3RJMPXbQJmYFebFR6SfB9QBkJdDzbG7GGT_3aZBkCfw@cipher.nrlssc.navy.mil>
 <CTXDOuN2-1v4gLJ9IqQwhgSzVh_BwEQIV70MoNH_beVI1QE7-TLy7g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 02:51:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khw7f-0004Cd-E4
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 02:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbYIWAtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 20:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbYIWAty
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 20:49:54 -0400
Received: from smtp.getmail.no ([84.208.20.33]:55427 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbYIWAty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 20:49:54 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K7M00M03IATF100@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 23 Sep 2008 02:49:41 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7M00HMHIABU940@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 23 Sep 2008 02:49:23 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7M009MZIABYX90@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 23 Sep 2008 02:49:23 +0200 (CEST)
In-reply-to: <CTXDOuN2-1v4gLJ9IqQwhgSzVh_BwEQIV70MoNH_beVI1QE7-TLy7g@cipher.nrlssc.navy.mil>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96518>

Signed-off-by: Johan Herland <johan@herland.net>
---

On Tuesday 23 September 2008, Brandon Casey wrote:
> And then this goes on top of bc/master-diff-hunk-header once
> bc/maint-diff-hunk-header with the previous patch is merged in.

After looking over this once more, I think the HTML regexp should be
changed as follows. This fixes a buglet that was part of my original
HTML pattern, and although this patch textually depends on Brandon's
work, it is conceptually independent of his refactorization.


Have fun!

...Johan

 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index d0e7319..c8b72f4 100644
--- a/diff.c
+++ b/diff.c
@@ -1424,7 +1424,7 @@ static const struct funcname_pattern_entry *funcname_pattern(const char *ident)
 static const struct funcname_pattern_entry builtin_funcname_pattern[] = {
 	{ "bibtex", "(@[a-zA-Z]{1,}[ \t]*\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	  REG_EXTENDED },
-	{ "html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$", REG_EXTENDED },
+	{ "html", "^[ \t]*(<[Hh][1-6]([ \t].*)?>.*)$", REG_EXTENDED },
 	{ "java",
 	  "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	  "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$",
-- 
1.6.0.2.405.g3cc38
