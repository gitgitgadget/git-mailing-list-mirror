From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 14:57:26 +0200
Message-ID: <20070111125726.GJ1759@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 14:17:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4zoG-0006Xz-El
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 14:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbXAKNRe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 08:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbXAKNRd
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 08:17:33 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:37352 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030350AbXAKNRd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 08:17:33 -0500
X-Greylist: delayed 1222 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 08:17:30 EST
Received: from mellanox.co.il ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with SMTP id l0BCv3AF013273;
	Thu, 11 Jan 2007 14:57:03 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 11 Jan 2007 14:57:26 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36588>

I hit a quota limit on a disk my tree was on, but did not notice.
Doing git pull on a tree seems to have corrupted it.
Now I have:

$ git-fsck-objects
error: 4d4d30be967d3284cbf59afd4fba6ab536e295f5: object not found
error: c03590b581d51d5fa43adbef9415e935d0229412: object not found
missing tree 10147d79b2418168d9433067b6439971bd4f1261
broken link from  commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
              to    tree 10147d79b2418168d9433067b6439971bd4f1261
dangling commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437

The tree can not be pulled into, or from.

-- 
MST
