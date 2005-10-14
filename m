From: Marco Costalba <mcostalba@yahoo.it>
Subject: [ANNOUNCE qgit-0.96]
Date: Fri, 14 Oct 2005 13:28:40 -0700 (PDT)
Message-ID: <20051014202841.76521.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Oct 14 22:31:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQWAy-0005Kn-GL
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 22:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVJNU2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 16:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVJNU2s
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 16:28:48 -0400
Received: from web26306.mail.ukl.yahoo.com ([217.146.176.17]:9908 "HELO
	web26306.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750706AbVJNU2r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 16:28:47 -0400
Received: (qmail 76523 invoked by uid 60001); 14 Oct 2005 20:28:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Ia2oCm0HHJjOu8Csa/Z9Mxod4trJpj6/Avu2qlUmqW84eYYJRwMSD23D+kb/Jux23d9kROlMJcTG5phc7XnS8gLTvYR6mdYffNQ/qEsuI9ND4wjv5JHZ7+UBcIHKfUVCaNzu1Vo9AjkFag6+yW9BmVJdcnnM+LMbKydK4dJJYeM=  ;
Received: from [151.38.110.92] by web26306.mail.ukl.yahoo.com via HTTP; Fri, 14 Oct 2005 13:28:40 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10123>

Hi all,


What is this?

qgit, a git GUI viewer.

With qgit you will be able to browse revisions history, view patch content and changed files, 
graphically following different development branches. Main features are:

 - View revisions, diffs, files history, files annotation.

 - Commit changes visually cherry picking modified files.

 - Apply or format patch series from selected commits, drag and
   drop commits between two instances of qgit.

 - qgit implements a GUI for the most common StGIT commands like push/pop
   and apply/format patches. You can also create new patches or refresh 
   current top one using the same semantics of git commit, i.e. cherry picking
   single modified files.



New in this release

qgit-0.96 implements various suggestions from the list regarding better UI.

Main change is diff viewer implemented as a (bottom) dockable window, so now you can see
revision's description and patch in one view. It is always possible to maximize diff viewer to
browse the path at full screen.

Others updates are speed-up of file names on demand loading and annotation and a better StGIT
integration.

Also fixed some issues about qgit color scheme: qgit colors are now _all_ inerithed by platform,
no more hardcoded ones, so colors are full customizable with proper platform tools.

Anyhow, this is how qgit is meant to be seen, at least by me ;-)
    http://digilander.libero.it/mcostalba/qgit_colors.png


A NOTE: Pasky said:

>* Could you make the grey background for odd commits span to the whole
>line, including the commit graph?

I've done it, but I am not sure about final result, so I've stripped the code from release
version, in any case this is the patch:


--- a/src/mainimpl.cpp
+++ b/src/mainimpl.cpp
@@ -68,7 +68,7 @@
 #define DEF_AUTH_COL_WIDTH	200
 #define DEF_TIME_COL_WIDTH	100
 
-#define IS_INFO_COL(x)  (x == TIME_COL || x == LOG_COL || x == AUTH_COL)
+#define IS_INFO_COL(x)  (x == TIME_COL || x == LOG_COL || x == AUTH_COL || x == GRAPH_COL)
 
 QColor ODD_LINE_COL;
 QColor EVEN_LINE_COL;



Installation

Download from: http://prdownloads.sourceforge.net/qgit/qgit-0.96.tar.bz2?download
GIT archive: cg-clone http://digilander.libero.it/mcostalba/qgit.git

You need scons and qt-mt developer libs, version 3.3.4 or better, already installed.
qgit is NOT compatible with Qt4.
On some platforms (Debian) you should set QTDIR before to compile.

- unpack tar file
- make
- make install

qgit will be installed in $HOME/bin


Changelog

- color scheme is no more hardcoded but inerithed from platform

- rewritten diff viewer as a bottom dockable window: geometry is persistant.

- StGIT add to top (refresh): it is now possible to change patch message

- StGIT commit: restore original files in working dir if commit fails

- added tag list in pop-up menu (right click on main view)

- use CTRL + right click to select a revision to diff against instead of just 
  right click to be compatible with pop-up menu while diff window is open

- updated startup dialog to include some check box for common settings

- make qgit work with time-based arguments

- speed-up of file names on demand loading. Load file names in background is
  still the suggested policy.

- speed-up of annotation, also make annotation work with no loaded file names.
  To have maximum performance, load file names in background is still the suggested policy.

- added status bar on annotation viewer with information on what's going on in
  background.

- time column moved to the right and now display commit author date by default,
  relative time is still available through settings.

- fix broken jump to childs/parent function

- finally fixed QSettings compile warning

- added some more tooltips and menu entries to help first time user

- various small fixes and GUI tweaks.



      Marco



		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free.
http://music.yahoo.com/unlimited/
