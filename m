From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] git-svn fix for systems without strftime %z
Date: Mon, 23 Feb 2009 09:33:02 -0500
Message-ID: <1235399583-6043-1-git-send-email-bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 16:45:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbczU-0001vH-Ds
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 16:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705AbZBWPnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 10:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755577AbZBWPnc
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 10:43:32 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:54242 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756705AbZBWPnb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 10:43:31 -0500
X-Greylist: delayed 4226 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Feb 2009 10:43:31 EST
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Lbbrk-0005d6-EM
	for git@vger.kernel.org; Mon, 23 Feb 2009 09:33:04 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Lbbrj-0001bq-AC
	for git@vger.kernel.org; Mon, 23 Feb 2009 09:33:04 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n1NEX39e006186
	for git@vger.kernel.org; Mon, 23 Feb 2009 09:33:03 -0500
X-Mailer: git-send-email 1.5.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111143>


Hi All,

In packaging the latest stable release for the OpenCSW project, I
found that some of the git-svn tests were failing.  After looking into
it, I saw that strftime calls were passing %z.  While %z is available
on most modern systems, it's not universal.  The forthcoming patch
implements a workaround for this that detects when %z falls through
and will insert the proper value when required.

I've tested this on both Linux and Solaris and it seems to behave as
expected (the test suite is happy on both).

I hope you find this useful.

Thanks
-Ben
