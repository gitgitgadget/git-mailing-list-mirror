From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 0/3] Teach git-blame about renames (take 2)
Date: Fri, 10 Mar 2006 10:21:35 +0100
Message-ID: <20060310092135.24015.26510.stgit@c165>
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Mar 10 10:21:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHdof-00041E-M1
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 10:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWCJJVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 04:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWCJJVl
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 04:21:41 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:61061 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1751257AbWCJJVl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 04:21:41 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 441024102; Fri, 10 Mar 2006 10:37:12 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1FHdoV-0006FO-00; Fri, 10 Mar 2006 10:21:35 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17461>


Changes since the previous version:

* Fix the things pointed out by Junio.
* Some other minor clean-ups

---

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
to those functions are passed to sort_in_topological_order_fn.

- Fredrik
