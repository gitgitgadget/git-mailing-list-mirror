From: jepler@unpythonic.net
Subject: [PATCHv3 0/2] git-gui: (un)stage a range of changes at once
Date: Mon,  7 Dec 2009 18:22:41 -0600
Message-ID: <1260231763-19194-1-git-send-email-jepler@unpythonic.net>
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Peter Baumann <waste.manager@gmx.de>,
	Jeff Epler <jepler@unpythonic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 01:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHoJh-00023I-3Y
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 01:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287AbZLHAwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 19:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbZLHAwZ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 19:52:25 -0500
Received: from zuul.dsndata.com ([162.40.127.30]:59024 "EHLO zuul.dsndata.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965259AbZLHAwY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 19:52:24 -0500
X-Greylist: delayed 1770 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2009 19:52:24 EST
Received: from lucky2.dsndata.com (lucky2.dsndata.com [198.183.6.22])
	by zuul.dsndata.com (8.13.8/8.13.8) with ESMTP id nB80Mpso038318;
	Mon, 7 Dec 2009 18:22:51 -0600 (CST)
	(envelope-from jepler@dsndata.com)
Received: from jepler by lucky2.dsndata.com with local (Exim 4.69)
	(envelope-from <jepler@lucky2.dsndata.com>)
	id 1NHnqt-00050n-9w; Mon, 07 Dec 2009 18:22:51 -0600
X-Mailer: git-send-email 1.6.3.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (zuul.dsndata.com [162.40.127.30]); Mon, 07 Dec 2009 18:22:54 -0600 (CST)
X-Scanned-By: MIMEDefang 2.61 on 162.40.127.30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134794>

From: Jeff Epler <jepler@unpythonic.net>

This set of patches allows git-gui to stage multiple lines at once by
selecting the range and then using the "apply lines" item in the context
menu.

Compared to the earlier versions, I've fixed all the bugs I became aware of.
I've also added the missing signed-off-by.

The first patch fixes an existing bug in git-gui when staging a deletion
followed by another deletion followed by the end of the file.

Jeff Epler (2):
  Fix applying a line when all following lines are deletions
  Make it possible to apply a range of changes at once

 git-gui.sh   |   15 +++-
 lib/diff.tcl |  241 ++++++++++++++++++++++++++++++++++------------------------
 2 files changed, 153 insertions(+), 103 deletions(-)
