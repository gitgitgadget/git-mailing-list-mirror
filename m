From: Jason Sewall <jasonsewall@gmail.com>
Subject: [PATCH][RESEND] Escape some tilde characters causing spurious subscripts in documentation
Date: Sat, 23 Jun 2007 16:51:13 -0700
Message-ID: <11826426733115-git-send-email-jasonsewall@gmail.com>
Cc: Jason Sewall <jasonsewall@gmail.com>
To: gitster@pobox.com, Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 01:51:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2FNv-0003FN-9n
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 01:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbXFWXvS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 19:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbXFWXvS
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 19:51:18 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:7729 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbXFWXvR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 19:51:17 -0400
Received: by py-out-1112.google.com with SMTP id u77so1033757pyb
        for <git@vger.kernel.org>; Sat, 23 Jun 2007 16:51:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=kfhpAh5aNlf/D3ptPO7IhEMeZ0zsr3vdPfgkdy2doZe42geYgamTNdDj35j97QULc/PnGi/5QYwr+Aw1HMxMVRU8nMkeN2Y07gNJNg9ddI53Y26Tk4Wy+WoY7+nHjb7qKXRxDvBs83FQsf5tpCAostFWeb5mhhLWZcEOArEHHvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=AcgN+zTHMVHUxpPPVEqGn687aj6NDsNKUFktCZIwHsrtNN3vdGYbqv6+qgCKSJMXAXUZag5X/jEs80/U8A7QaGHFgTIGxqCW6HUL1TYgqoOWX8ZQB/OeyT6huK51u+lg5DNIXCTdz9mpnnZ9LTUMV32qdsSyQJa4Wax3FcLpm8I=
Received: by 10.141.197.18 with SMTP id z18mr368266rvp.1182642675757;
        Sat, 23 Jun 2007 16:51:15 -0700 (PDT)
Received: from localhost ( [76.102.154.60])
        by mx.google.com with ESMTP id g6sm3419468rvb.2007.06.23.16.51.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jun 2007 16:51:15 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.1.280.g38570
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50761>

A few unescaped tilde characters were causing long parts of the html documentation to be formatted as footnotes. This patch fixes them; I think I found all of them, but no promises.

Signed-off-by: Jason Sewall <jasonsewall@gmail.com>
---
 My second attempt at submitting a patch, this time with git-send-email rather than copy-and-paste into gmail; let me know if this is a reasonably presented patch. It is truly  trivial, but getting those docs cleaned up is important!

 Documentation/git-bundle.txt |    8 ++++----
 Documentation/git-daemon.txt |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 5051e2b..d89f350 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -61,7 +61,7 @@ unbundle <file>::
 [git-rev-list-args...]::
        A list of arguments, acceptable to git-rev-parse and
        git-rev-list, that specify the specific objects and references
-       to transport.  For example, "master~10..master" causes the
+       to transport.  For example, "master\~10..master" causes the
        current master reference to be packaged along with all objects
        added since its 10th ancestor commit.  There is no explicit
        limit to the number of references and objects that may be
@@ -80,12 +80,12 @@ SPECIFYING REFERENCES

 git-bundle will only package references that are shown by
 git-show-ref: this includes heads, tags, and remote heads.  References
-such as master~1 cannot be packaged, but are perfectly suitable for
+such as master\~1 cannot be packaged, but are perfectly suitable for
 defining the basis.  More than one reference may be packaged, and more
 than one basis can be specified.  The objects packaged are those not
 contained in the union of the given bases.  Each basis can be
-specified explicitly (e.g., ^master~10), or implicitly (e.g.,
-master~10..master, master --since=10.days.ago).
+specified explicitly (e.g., ^master\~10), or implicitly (e.g.,
+master\~10..master, master --since=10.days.ago).

 It is very important that the basis used be held by the destination.
 It is okay to err on the side of conservatism, causing the bundle file
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 4b30b18..3f9cec5 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -98,7 +98,7 @@ OPTIONS
 	--verbose, thus by default only error conditions will be logged.

 --user-path, --user-path=path::
-	Allow ~user notation to be used in requests.  When
+	Allow \~user notation to be used in requests.  When
 	specified with no parameter, requests to
 	git://host/~alice/foo is taken as a request to access
 	'foo' repository in the home directory of user `alice`.
--
1.5.2.1.280.g38570
