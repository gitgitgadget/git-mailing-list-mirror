From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 1/2] gitk: Import msgcat for translation support
Date: Fri, 27 Jul 2007 16:53:18 +0200
Message-ID: <20070727165318.e96b1yxxwsooo884@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 16:54:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IERCV-00022F-Fp
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 16:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933350AbXG0Ox0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 10:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761302AbXG0OxZ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 10:53:25 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:58881 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933350AbXG0OxX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2007 10:53:23 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6RErIdA011955
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 27 Jul 2007 16:53:19 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6RErI15029547;
	Fri, 27 Jul 2007 16:53:18 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id AB17DE50349; Fri, 27 Jul 2007 16:53:18 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Fri, 27 Jul 2007
	16:53:18 +0200
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53930>

Import tcl's msgcat package to have the [mc...] procedure for  
translation available.

However, in the current form gitk doesn't load any data a data  
directory or from anywhere; if it should load any translation  
catalogs, of course it needs to load them from a designated data  
directory. For testing, it uses the ./msgs/ subdirectory (marked as  
FIXME), but eventually a full-blown data directory needs to be added  
there instead.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
Actual translation markup will follow.

  gitk |    7 +++++++
  1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 39e452a..c01acfb 100755
--- a/gitk
+++ b/gitk
@@ -7463,6 +7463,13 @@ set fgcolor black
  set diffcolors {red "#00a000" blue}
  set selectbgcolor gray85

+## Internationalization (i18n) through msgcat and gettext. See
+## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
+package require msgcat
+namespace import ::msgcat::mc
+## FIXME: Need to define a suitable msgs/ directory here.
+::msgcat::mcload [file join . msgs]
+
  catch {source ~/.gitk}

  font create optionfont -family sans-serif -size -12
-- 
1.5.3.rc2.12.gbc280
