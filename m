From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 14:33:28 +0200
Message-ID: <200707211433.29318.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <200707210951.00210.stimming@tuhh.de> <20070721080338.GT32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 14:33:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICE9K-0007bH-Rn
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 14:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937279AbXGUMdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 08:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936739AbXGUMdW
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 08:33:22 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:60127 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936309AbXGUMdV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 08:33:21 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6LCXF31030504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 21 Jul 2007 14:33:15 +0200
Received: from [192.168.2.102] (p549012DA.dip0.t-ipconnect.de [84.144.18.218])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6LCXDBH005025
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jul 2007 14:33:14 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20070721080338.GT32566@spearce.org>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53160>

>From 18d783abd85e074c302c5e7979dfb242b3c6c386 Mon Sep 17 00:00:00 2001
From: Christian Stimming <chs@ckiste.goetheallee>
Date: Sat, 21 Jul 2007 13:51:48 +0200
Subject: [PATCH] Initialize msgcat (gettext).

Use [mc ...] as function name for translating user messages.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---

This patch starts over from before the first i18n patch has been applied and 
takes into account all discussion with Shawn. Currently I don't quite know 
how to apply these patches to the "mob" branch because one would have
to first revert those patches from me that have been applied there... Thanks.

 git-gui.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index c5ff7c8..0c5ca46 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -108,6 +108,12 @@ if {$idx ne {}} {
 }
 unset -nocomplain oguirel idx fd
 
+## Internationalization (i18n) through msgcat and gettext. See
+## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
+package require msgcat
+::msgcat::mcload [file join $oguilib msgs]
+namespace import ::msgcat::mc
+
 ######################################################################
 ##
 ## read only globals
-- 
1.5.2
