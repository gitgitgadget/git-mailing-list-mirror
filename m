From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Fix for rpm creation
Date: Thu, 16 Feb 2006 16:33:44 +0100
Message-ID: <200602161633.44399.Josef.Weidendorfer@gmx.de>
References: <20060216135100.GR31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 16:34:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9l8f-0006gU-TG
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 16:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWBPPdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 10:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWBPPdr
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 10:33:47 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:4564 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932282AbWBPPdq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 10:33:46 -0500
Received: from dhcp-3s-57.lrr.in.tum.de (dhcp-3s-57.lrr.in.tum.de [131.159.35.57])
	by mail.in.tum.de (Postfix) with ESMTP id 4C9532119;
	Thu, 16 Feb 2006 16:33:45 +0100 (MET)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.1
In-Reply-To: <20060216135100.GR31278@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16306>


Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---
This fixes "make rpm", which currently gives at the very end:
...
Checking for unpackaged file(s): /usr/lib/rpm/check-files /var/tmp/cogito-0.17rc2.GIT-1-root-weidendo
error: Installed (but unpackaged) file(s) found:
   /usr/share/cogito/default-exclude

Another thing:
"cg-switch origin" currently refuses to switch to the branch.
Wouldn't it be better to handle this like "cg-seek origin"?

Josef



 cogito.spec.in |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

e483d914813413b43fd1d067ebc50d4a86c93df1
diff --git a/cogito.spec.in b/cogito.spec.in
index 1fb3b7b..50c4172 100644
--- a/cogito.spec.in
+++ b/cogito.spec.in
@@ -38,6 +38,8 @@ rm -rf $RPM_BUILD_ROOT
 %{_bindir}/*
 %dir %{_libdir}/cogito
 %{_libdir}/cogito/*
+%dir %{_datadir}/cogito
+%{_datadir}/cogito/*
 %{_mandir}/man*/*
 %doc README COPYING Documentation/tutorial-script
 
-- 
1.2.0.g719b
