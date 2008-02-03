From: Jean-Luc Herren <jlh@gmx.ch>
Subject: git cvsimport fails noisily if cvs has no server support
Date: Sun, 03 Feb 2008 16:28:24 +0100
Message-ID: <47A5DD98.6000606@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 16:29:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLgmD-0006xL-Li
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 16:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbYBCP23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 10:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbYBCP23
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 10:28:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:54780 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753380AbYBCP23 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 10:28:29 -0500
Received: (qmail invoked by alias); 03 Feb 2008 15:28:25 -0000
Received: from 125-51.78-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.78.51.125]
  by mail.gmx.net (mp026) with SMTP; 03 Feb 2008 16:28:25 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1+7EawHDDG70dTC/wJCTRxAvIkkuUIAGxH16Iwtc+
	AM6fF8zeQfjqDH
User-Agent: Thunderbird 2.0.0.9 (X11/20071118)
X-Enigmail-Version: 0.95.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72361>

Hello list!

cvs (1.12.12) can be compiled with --disable-server to omit
support for cvs servers.  Although this is not ./configure's
default, it was the default on my distro (gentoo).  git-cvsimport
fails loudly as pasted below (note that this command is part of
the test t9600-cvsimport.sh).  Nicer behavior would of course be
to detect the situation and inform the user that server support is
missing (and to skip the test).

jlh

$ git-cvsimport -a -z 0 -C module-git module
Unknown command: `server'

CVS commands are:
        add          Add a new file/directory to the repository
        admin        Administration front end for rcs
[...26 lines omitted...]
        watch        Set watches
        watchers     See who is watching a file
(Specify the --help option for a list of other help options)
Use of uninitialized value in scalar chomp at /home/jlh/cvs/git/t/../git-cvsimport line 345.
Use of uninitialized value in substitution (s///) at /home/jlh/cvs/git/t/../git-cvsimport line 346.
Expected Valid-requests from server, but got: <unknown>
$ 
