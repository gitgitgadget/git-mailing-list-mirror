From: Phil Lawrence <prlawrence@gmail.com>
Subject: [PATCH] git-gui: Append ampersand to Target of lnk files created by 
	do_cygwin_shortcut.
Date: Mon, 9 Mar 2009 12:22:23 -0500
Message-ID: <530ac78e0903091022s2585231br9ef11d91851250f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 18:23:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgjCm-0002Jw-NW
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 18:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbZCIRW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 13:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753735AbZCIRW1
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 13:22:27 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:44006 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbZCIRW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 13:22:26 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1090659yxm.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=itd4fO6Rih1HM6Pf2LZaMO92EULYK8FOlVqBf0vnTXI=;
        b=ExaRJtDt9guVTL8YSMPl+s2GkPsfZWz1FrPRJ8P1RCLz2aQNkadiYJ4iWXq4WkFEyB
         GIP/Ux7CsOc3aFVCIsAOusfJJue8Qs2sZ/hZs/9CDV2gmo0Mc/5us6H/oqiaOSyhrvkK
         1ihGqM1MAWQwxRtSDPnktbp0JKkgEody5Ynr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=CygQ5Vz8MeKVKo/vkERTx2inYEENQydm98sUZGiB9CL/Z7Hs9sQYWBbylt0D50tjU2
         KOw5uhguZxvyvd6rrdGc0NMJql3NVH0onIIzxrz29epFoFJ0MflKX3bSxBlhFJXUZcS2
         XFRUxrn9xJWkh3tYd1CPyOkzbNWnr4sP1rFzc=
Received: by 10.231.20.2 with SMTP id d2mr1477008ibb.27.1236619343804; Mon, 09 
	Mar 2009 10:22:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112723>

First post here.  First patch, too, so hoping I've invoked git
format-patch correctly...

>From 5fddc9b7bfa0dfb8d2c1c0eb59ae9208ff72540d Mon Sep 17 00:00:00 2001
From: Phil Lawrence <prlawrence@gmail.com>
Date: Thu, 5 Mar 2009 17:56:58 -0600
Subject: [PATCH] Append ampersand to Target of lnk files created by
do_cygwin_shortcut.  Allows shell window to close after starting
 Git GUI as a background process.

---
 lib/shortcut.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/shortcut.tcl b/lib/shortcut.tcl
index 38c3151..2f20eb3 100644
--- a/lib/shortcut.tcl
+++ b/lib/shortcut.tcl
@@ -54,7 +54,7 @@ proc do_cygwin_shortcut {} {
                                        $argv0]
                                win32_create_lnk $fn [list \
                                        $sh -c \
-                                       "CHERE_INVOKING=1 source
/etc/profile;[sq $me]" \
+                                       "CHERE_INVOKING=1 source
/etc/profile;[sq $me] &" \
                                        ] \
                                        [file dirname [file normalize [gitdir]]]
                        } err]} {
--
1.6.1.9.g97c34

Regards,
Phil Lawrence
