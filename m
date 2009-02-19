From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/4] format-patch --cover-letter --in-reply-to
Date: Thu, 19 Feb 2009 22:26:29 +0100
Message-ID: <cover.1235078708.git.trast@student.ethz.ch>
References: <200902170027.09406.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 22:28:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaGRJ-0002DO-9O
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 22:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208AbZBSV0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 16:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756134AbZBSV0p
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 16:26:45 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:21625 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756140AbZBSV0o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 16:26:44 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 22:26:43 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 22:26:42 +0100
X-Mailer: git-send-email 1.6.2.rc1.295.g1e29
In-Reply-To: <200902170027.09406.trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Feb 2009 21:26:42.0701 (UTC) FILETIME=[C24A4BD0:01C992D8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110756>

Lemma 1: Any task, no matter how trivial, expands to at least three
         patches.

Turns out there were tests, but they never worked.  In any case it
should now know how to properly format References, and also knows
about deep and shallow threading.

I formatted this series with

  git format-patch origin/master..t/thread-reply-to-cover \
    --cover-letter --thread \
    --in-reply-to='<200902170027.09406.trast@student.ethz.ch>'


Thomas Rast (4):
  format-patch: threading test reactivation
  format-patch: track several references
  format-patch: thread as reply to cover letter even with in-reply-to
  format-patch: support deep threading

 Documentation/config.txt           |   10 ++
 Documentation/git-format-patch.txt |   10 ++-
 builtin-log.c                      |   65 ++++++++--
 log-tree.c                         |   11 +-
 revision.h                         |    2 +-
 t/t4014-format-patch.sh            |  265 ++++++++++++++++++++++++++++++------
 6 files changed, 308 insertions(+), 55 deletions(-)
