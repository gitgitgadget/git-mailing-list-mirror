From: Sven Verdoolaege <skimo@kotnet.org>
Subject: t4201-shortlog.sh does bad things to my terminal
Date: Mon, 23 Apr 2007 19:03:01 +0200
Message-ID: <20070423170301.GL955MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 23 19:03:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg1wY-0007gH-SJ
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 19:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbXDWRDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Apr 2007 13:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbXDWRDL
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 13:03:11 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:39623 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030501AbXDWRDI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 13:03:08 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JGY004BJND1BE@smtp17.wxs.nl> for git@vger.kernel.org; Mon,
 23 Apr 2007 19:03:07 +0200 (CEST)
Received: (qmail 3754 invoked by uid 500); Mon, 23 Apr 2007 17:03:01 +0000
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45335>

Running t4201-shortlog.sh in a non-utf8 terminal has some unpleasant ef=
fects:

bash-3.00$ xterm -v
XFree86 4.2.99.903(174)
bash-3.00$ locale
LANG=3Den_US
LC_CTYPE=3D"en_US"
LC_NUMERIC=3D"en_US"
LC_TIME=3D"en_US"
LC_COLLATE=3DPOSIX
LC_MONETARY=3D"en_US"
LC_MESSAGES=3D"en_US"
LC_PAPER=3D"en_US"
LC_NAME=3D"en_US"
LC_ADDRESS=3D"en_US"
LC_TELEPHONE=3D"en_US"
LC_MEASUREMENT=3D"en_US"
LC_IDENTIFICATION=3D"en_US"
LC_ALL=3D
bash-3.00$ sh ./t4201-shortlog.sh --verbose
Created commit b8ab028: This is a very, very long first line for the co=
mmit message to see if it is wrapped correctly
 1 files changed, 1 insertions(+), 1 deletions(-)
Created commit 3da0b85: Th=F0















(The cursor is now about half way the last line.)

It appears that this message is printing a control character to turn of=
f echoing,
because the terminal appears completely unresponsive afterwards.
Typing "reset" restores the terminal.

Is this really necessary?

skimo
