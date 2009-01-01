From: Clemens Buchacher <drizzd@aon.at>
Subject: unpack-trees: fix D/F conflict bugs in verify_absent
Date: Thu,  1 Jan 2009 21:54:30 +0100
Message-ID: <1230843273-11056-1-git-send-email-drizzd@aon.at>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 01 21:56:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIUaT-0004GO-A0
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 21:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbZAAUyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 15:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbZAAUyq
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 15:54:46 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:10325 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbZAAUyp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 15:54:45 -0500
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 1 Jan 2009 21:54:41 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LIUYr-0002wI-MG; Thu, 01 Jan 2009 21:54:33 +0100
X-Mailer: git-send-email 1.6.1
X-OriginalArrivalTime: 01 Jan 2009 20:54:41.0292 (UTC) FILETIME=[2ACCCCC0:01C96C53]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104317>

I came across a few bugs while investigating the changes I proposed in the
modify/delete conflict thread. The first two are quite obvious. The third I'm
not so sure about. I could not find a testcase where it matters. Junio, do you
recall the original intention of that code?

[PATCH 1/3] unpack-trees: handle failure in verify_absent
[PATCH 2/3] unpack-trees: fix path search bug in verify_absent
[PATCH 3/3] unpack-trees: remove redundant path search in verify_absent

 t/t1001-read-tree-m-2way.sh |   51 +++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c              |   37 +++++++++++++++----------------
 2 files changed, 69 insertions(+), 19 deletions(-)
