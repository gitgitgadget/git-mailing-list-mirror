From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 0/2] log -L overlapping ranges
Date: Fri, 5 Apr 2013 16:34:46 +0200
Message-ID: <cover.1365172322.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:18:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWIt-0002u6-8S
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161772Ab3DEOez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 10:34:55 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:34508 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161562Ab3DEOez (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 10:34:55 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 5 Apr
 2013 16:34:41 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.239) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 5 Apr
 2013 16:34:51 +0200
X-Mailer: git-send-email 1.8.2.662.g6b31d33
X-Originating-IP: [213.55.184.239]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220199>

I noticed that it doesn't like getting multiple overlapping ranges
from the user.  This fixes it.


Thomas Rast (2):
  log -L: check range set invariants when we look it up
  log -L: fix overlapping input ranges

 line-log.c                          |  43 +++++++--
 t/t4211-line-log.sh                 |   6 ++
 t/t4211/expect.multiple             | 104 ++++++++++++++++++++
 t/t4211/expect.multiple-overlapping | 187 ++++++++++++++++++++++++++++++++++++
 t/t4211/expect.multiple-superset    |  59 ++++++++++++
 5 files changed, 392 insertions(+), 7 deletions(-)
 create mode 100644 t/t4211/expect.multiple
 create mode 100644 t/t4211/expect.multiple-overlapping
 create mode 100644 t/t4211/expect.multiple-superset

-- 
1.8.2.662.g6b31d33
