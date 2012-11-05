From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 0/5] push: update remote tags only with force
Date: Sun,  4 Nov 2012 21:08:23 -0600
Message-ID: <1352084908-32333-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 04:09:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVD3h-0002cf-PH
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 04:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab2KEDIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 22:08:42 -0500
Received: from [38.98.186.242] ([38.98.186.242]:34039 "HELO burner.cogcap.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
	id S1752501Ab2KEDIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 22:08:40 -0500
Received: by burner.cogcap.com (Postfix, from userid 10028)
	id 5AEE72B09C4; Sun,  4 Nov 2012 21:08:39 -0600 (CST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209049>

Patch series to prevent push from updating remote tags w/o forcing them.
Split out original patch to ease review.

Chris Rorvick (5):
  push: return reject reasons via a mask
  push: add advice for rejected tag reference
  push: flag updates
  push: flag updates that require force
  push: update remote tags only with force

 Documentation/git-push.txt |   10 +++++-----
 builtin/push.c             |   24 +++++++++++++++---------
 builtin/send-pack.c        |    6 ++++++
 cache.h                    |    7 ++++++-
 remote.c                   |   39 +++++++++++++++++++++++++++++++--------
 t/t5516-fetch-push.sh      |   30 +++++++++++++++++++++++++++++-
 transport-helper.c         |    6 ++++++
 transport.c                |   25 +++++++++++++++----------
 transport.h                |   10 ++++++----
 9 files changed, 119 insertions(+), 38 deletions(-)
