From: Tommy Thorn <tt1729@yahoo.com>
Subject: [PATCH] git-p4: Fix an obvious typo
Date: Sat, 2 Feb 2008 00:11:44 -0800 (PST)
Message-ID: <182304.89601.qm@web39507.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 02 09:12:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLDUM-00026E-NI
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 09:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309AbYBBILt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 03:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756304AbYBBILt
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 03:11:49 -0500
Received: from web39507.mail.mud.yahoo.com ([209.191.106.91]:23110 "HELO
	web39507.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755675AbYBBILs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Feb 2008 03:11:48 -0500
Received: (qmail 91837 invoked by uid 60001); 2 Feb 2008 08:11:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=4cSDYi4y/sv8KbOL+R2AjVNfW88QsLkA0Y5Q+9vf3YxXs+vybr6MrP6Z2OvKqT4rye8/fAU/R7jp0H6AZ4AKhZpi5H+Mufo3Ptsc8D1OHoXMpNyOoyfIwye+aTxcBuheIxDO5U/Vi3xk7Qxs5Ns/I5b4GRon1pwp/2kWe3EJMUw=;
X-YMail-OSG: 7BDLeRgVM1mfeL.X0zIS.T1f1PJyJ5B_BdwpYwaBz2iFkso.tr3EXsnAc4JU3ee49dHUlBRnpw9YjX0YwwJ3yJNSRTIqVEPaL7TmS.tv3Jb4GEmNGAM-
Received: from [208.65.183.75] by web39507.mail.mud.yahoo.com via HTTP; Sat, 02 Feb 2008 00:11:44 PST
X-Mailer: YahooMailRC/818.31 YahooMailWebService/0.7.162
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72230>

The regexp "$," can't match anything. Clearly not intended.

This was introduced in ce6f33c8 which is quite a while ago.

Signed-off-by: Tommy Thorn <tommy-git@thorn.ws>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c80a6da..553e237 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1670,7 +1670,7 @@ class P4Clone(P4Sync):
         depotPath = args[0]
         depotDir = re.sub("(@[^@]*)$", "", depotPath)
         depotDir = re.sub("(#[^#]*)$", "", depotDir)
-        depotDir = re.sub(r"\.\.\.$,", "", depotDir)
+        depotDir = re.sub(r"\.\.\.$", "", depotDir)
         depotDir = re.sub(r"/$", "", depotDir)
         return os.path.split(depotDir)[1]
 
-- 
1.5.4.rc5.5.gab98





      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
