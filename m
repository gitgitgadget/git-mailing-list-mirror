From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: git-commit/git-applypatch whitespace rules different?
Date: Fri, 12 Jan 2007 00:12:11 +0200
Message-ID: <20070111221211.GM17999@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 23:12:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H589S-0002Bu-Hl
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 23:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXAKWMA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 17:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbXAKWMA
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 17:12:00 -0500
Received: from p02c11o142.mxlogic.net ([208.65.145.65]:53832 "EHLO
	p02c11o142.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbXAKWL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 17:11:59 -0500
Received: from unknown [194.90.237.34] (EHLO p02c11o142.mxlogic.net)
	by p02c11o142.mxlogic.net (mxl_mta-4.0.1-4)
	with ESMTP id f26b6a54.1851222960.9879.00-503.p02c11o142.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 11 Jan 2007 15:11:59 -0700 (MST)
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o142.mxlogic.net (mxl_mta-4.0.1-4)
	with ESMTP id b26b6a54.2674699184.9866.00-028.p02c11o142.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 11 Jan 2007 15:11:55 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 12 Jan 2007 00:13:30 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri, 12 Jan 2007 00:10:25 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 11 Jan 2007 22:13:30.0314 (UTC) FILETIME=[B9AE8AA0:01C735CD]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14930.000
X-TM-AS-Result: No--0.225800-4.000000-31
X-Spam: [F=0.0850997291; S=0.085(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36624>

git-commit/git-applypatch whitespace rules seem to be different.
Is this expected?

Example:
I take a patch, apply it and commit without warnings about whitespace:

$patch -p1 -i /tmp/ipoib_cm.patc
$git commit drivers/infiniband/ulp/ipoib/
Created commit f83bc11fd3cadb0b3f27d31fbaaa1a5d409e65d9
 8 files changed, 339 insertions(+), 31 deletions(-)

but when try git-applypatch:

$git-applypatch test1 /tmp/ipoib_cm.patch test1

Space in indent is followed by a tab.
/tmp/ipoib_cm.patch:174:                test_bit(IPOIB_FLAG_ADMIN_CM,
						 &priv->flags);
Space in indent is followed by a tab.
/tmp/ipoib_cm.patch:181:                test_bit(IPOIB_FLAG_ADMIN_CM,
						 &priv->flags);
Adds trailing whitespace.
/tmp/ipoib_cm.patch:256:        return;
Space in indent is followed by a tab.
/tmp/ipoib_cm.patch:610:                        ret = 0; /* Connection is going
							    away already. */
Space in indent is followed by a tab.
/tmp/ipoib_cm.patch:1227:               neigh = tx->neigh;


why is not git-commit not warning me? I did not set --no-verify ...

-- 
MST
