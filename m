From: Stefan Haller <lists@haller-berlin.de>
Subject: [PATCH] gitk: Make text selectable on Mac
Date: Sun, 14 Nov 2010 13:22:56 +0100
Message-ID: <1289737376-33373-1-git-send-email-lists@haller-berlin.de>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 14 13:23:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHbc0-0005qt-6r
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 13:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab0KNMXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 07:23:08 -0500
Received: from mail.ableton.net ([62.96.12.117]:55792 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755332Ab0KNMXF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 07:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-Id:Date:Subject:Cc:To:From; bh=f1sCVr1pEgxohfpOw8SOaGgkP4AWPblTBOBgmu2GzwU=;
	b=soDa12YCtpKEkJAA4eRzSftrfQTHcLICfeFveMFU78LrbTZ6N1jGg/Kh2eH8bL9F26i7Jpa+oyPLTdoAzU5Iktp0DJq7R7AMMVHc20KJC5op1oXSi3+2Nv0+Dy7Hr/MCDysAqpMPYJwPI3wEQjDoUcj/+nFqN3sihkTCz9yi4SM=;
Received: from dslb-088-074-017-003.pools.arcor-ip.net ([88.74.17.3] helo=localhost.localdomain)
	by mail.ableton.net with esmtpa (Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PHbRi-0002fU-CR; Sun, 14 Nov 2010 13:12:34 +0100
X-Mailer: git-send-email 1.7.3.2.154.gcfae0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161407>

From: Stefan Haller <stefan@haller-berlin.de>

Stolen from git-gui, 23effa79f7 (original log message by
Shawn O. Pearce <spearce@spearce.org> follows):

    git-gui: Force focus to the diff viewer on mouse click.

    Apparently a "feature" of Tcl/Tk on Mac OS X is that a disabled text
    widget cannot receive focus or receive a selection within it.  This
    makes the diff viewer almost useless on that platform as you cannot
    select individual parts of the buffer.

    Now we force focus into the diff viewer when its clicked on with
    button 1.  This works around the feature and allows selection to
    work within the viewer just like it does on other less sane systems,
    like Microsoft Windows.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 45e3380..14ffde2 100755
--- a/gitk
+++ b/gitk
@@ -2453,6 +2453,7 @@ proc makewindow {} {
     global ctxbut
     bind $cflist $ctxbut {pop_flist_menu %W %X %Y %x %y}
     bind $ctext $ctxbut {pop_diff_menu %W %X %Y %x %y}
+    bind $ctext <Button-1> {focus %W}
 
     set maincursor [. cget -cursor]
     set textcursor [$ctext cget -cursor]
-- 
1.7.3.2.154.gcfae0
