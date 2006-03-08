From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 0/3] Teach git-blame about renames
Date: Wed, 8 Mar 2006 23:54:12 +0100
Message-ID: <20060308225412.GA461@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Mar 08 23:54:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH7Y8-0005V0-6Y
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 23:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWCHWyU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 17:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWCHWyU
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 17:54:20 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:42114 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1030242AbWCHWyT
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 17:54:19 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id DDA6340FF; Thu,  9 Mar 2006 00:09:44 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FH7Xo-00007h-00; Wed, 08 Mar 2006 23:54:12 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17388>

Hi,

This patch series teaches git-blame about renames. To do this I have
changed the revision.h interface a bit. In particular, it is now
possible for the user of revision.h to specify a
try_to_simply_commit-like function. That function can then do the
rename tracking.

I have also made a small change to sort_in_topological_order to make
it possible to use the object.util field at the same time as a
topological sort is done. Previously the object.util field was
clobbered by the topological sort. In the new interface the auxiliary
data that the topological sort needs to store for each commit object
is stored with a setter function and retrieved by a getter. Pointers
to those functions are passed to sort_in_topological_order.

- Fredrik
