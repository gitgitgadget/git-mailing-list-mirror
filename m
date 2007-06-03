From: Yann Dirson <ydirson@altern.org>
Subject: [gitk bug] 'invalid command name ".bleft.ctext"' when exiting gitk
Date: Mon, 4 Jun 2007 00:25:16 +0200
Message-ID: <20070603222516.GI6992@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Jun 04 00:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuyWF-000881-CX
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 00:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbXFCWZR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 18:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbXFCWZR
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 18:25:17 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:35838 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847AbXFCWZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 18:25:16 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 68BE07491;
	Mon,  4 Jun 2007 00:25:15 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 2939B1F01B; Mon,  4 Jun 2007 00:25:16 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49043>

If I run "./gitk" on the current git master
(c94bf41c9a78dc1c084f2a2895f95b6b6d8f79b1), and hit Ctrl-Q shortly
after gitk starts to fill the diff pane, I get the following error on
the tty:

|invalid command name ".bleft.ctext"
|    while executing
|"$ctext conf -state normal"
|    (procedure "dispneartags" line 7)
|    invoked from within
|"dispneartags"
|    (procedure "restartatags" line 31)
|    invoked from within
|"restartatags"
|    ("after" script)

This problem is not easy to reproduce at every try, I have to try
several times to see it, but it's still pretty easy to get the error.

Anyone knows what it's trying to do ?  Is that a race condition
between "after idle restartatags" and the widgets being destroyed ?

-- 
Yann.
