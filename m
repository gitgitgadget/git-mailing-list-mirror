From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Set core.ignorecase globally
Date: Fri, 2 Nov 2012 18:39:26 +0400
Message-ID: <6DB2AD2A-6531-497E-B87E-0E884C4BCFBE@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 15:46:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUIVt-0003A2-A0
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 15:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab2KBOqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 10:46:12 -0400
Received: from mail1.intellij.net ([46.137.178.215]:44629 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab2KBOqL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2012 10:46:11 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Nov 2012 10:46:10 EDT
Received: (qmail 10641 invoked by uid 89); 2 Nov 2012 14:39:28 -0000
Received: by simscan 1.1.0 ppid: 10553, pid: 10632, t: 0.0909s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-62-119-91.eu-west-1.compute.internal with ESMTPA; 2 Nov 2012 14:39:28 -0000
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208938>

Hi,

Currently, core.ignorecase is set to true on case insensitive system like Windows or Mac on `git init` and `git clone`, and this setting is local to the created/cloned repository.
Here is the man entry:

core.ignorecase
           If true, this option enables various workarounds to enable git to work better on filesystems that are
           not case sensitive, like FAT. For example, if a directory listing finds "makefile" when git expects
           "Makefile", git will assume it is really the same file, and continue to remember it as "Makefile".

           The default is false, except git-clone(1) or git-init(1) will probe and set core.ignorecase true if
           appropriate when the repository is created.

I suggest to set this globally by default when Git is installed, because there is little sense to have this option false on case insensitive systems (it will lead to confusions when renaming a file by changing only the case of letters). 

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
