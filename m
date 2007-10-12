From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: [RFC] git-gui window layout
Date: Fri, 12 Oct 2007 10:49:26 +0200
Message-ID: <470F3516.7020606@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 11:01:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgGNp-0008IN-S3
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 11:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbXJLJA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 05:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754080AbXJLJA2
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 05:00:28 -0400
Received: from pisces.et.put.poznan.pl ([150.254.29.122]:53396 "EHLO
	pisces.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbXJLJA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 05:00:27 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Oct 2007 05:00:26 EDT
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by pisces.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id l9C8o5sh026904
	for <git@vger.kernel.org>; Fri, 12 Oct 2007 10:51:00 +0200 (CEST)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.67] (pc1067.et.put.poznan.pl [150.254.11.67])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id l9C8nPS19403
	for <git@vger.kernel.org>; Fri, 12 Oct 2007 10:49:27 +0200 (MET DST)
User-Agent: Thunderbird 2.0.0.6 (X11/20070917)
X-Enigmail-Version: 0.95.3
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2007.10.12.11853
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __STOCK_PHRASE_24 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60665>

Dear Giters,

I would like you to comment on my idea to change, or at least add a
possibility to change, the current layout of git-gui window.

Nowadays there is a tendency to produce wide screens for laptops and
even standalone LCD monitors. One can safely assume that the minimum
reasonable horizontal resolution of a screen is at least 1024 pixels (I
do not expect anyone using git-gui with 800x600 resolution).
Moreover, most popular window managers decreases the vertical dimension
of a desktop by using horizontally-oriented panels (e.g. KDE, Gnome,
XFCE4, etc.)

The current layout of git-gui window covering the whole desktop area on
a typical WXGA (1280x800) laptop LCD display is thus:

+----------+-----------------------------------+
|          |                                   |
|  staged  |          unstaged                 |
|          |                                   |
+----------+----------------+------------------+
|###     commit log         |      EMPTY       |
|###                        |                  |
+---------------------------+------------------+
|                                              |
|    diff output                               |
|                                              |
+----------------------------------------------+

In my opinion, the staged, unstaged and diff areas are usually used for
displaying things that are taller than wider (e.g. a list of files,
patches of well structured code, which is usually < 80 columns). The
commit log window is also designed for text narrower than < 80 cols.

Therefore in my opinion it might be more useful to restructure this
layout to something like this:

+-------------+----------------------------+---+
|             |                            |###|
|             |       commit log           |###|
|   staged    +----------------------------+---+
|             |                                |
|             |                                |
+----- 1 -----+                                |
|             |       diff output              |
|             2                                |
|  unstaged   |                                |
|             |                                |
|             |                                |
+-------------+--------------------------------+

Buttons (rescan, push, commit, etc.) are denoted here as ###. Besides
the walls denoted as 1 and 2 should be movable so one could adjust the
size of staged/unstaged and diff areas.
The minimum width of diff window would be limited by the commit log
window width (I propose 80 colums) plus the size of the buttons.

Unfortunately, I do not nothing about TCL/TK programming, so I even did
not tried to analyse the code of git-gui. Therefore I am not sure if
such a restructure is easy to implement.

Anyway I hope for your comments to this idea.

BR,
/Adam


-- 
.:.  Adam Piatyszek - "ediap"       .:.  JID: ediap(at)jabber.org .:.
.:.  ediap(at)users.sourceforge.net .:.  PGP key ID: 0x1F115CCB   .:.
