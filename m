From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 0/3] git remote with superfluous arguments
Date: Wed, 24 Apr 2013 15:54:34 +0200
Message-ID: <cover.1366811347.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 24 15:54:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV09n-0002N4-WE
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 15:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101Ab3DXNym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 09:54:42 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34610 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754485Ab3DXNyl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 09:54:41 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 24 Apr
 2013 15:54:37 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 24 Apr
 2013 15:54:38 +0200
X-Mailer: git-send-email 1.8.2.1.935.g71f5136
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222249>

Today I botched a cut&paste and ran

  git remote add git remote add origin <url>

only to notice, several commands later, that while it had succeeded,
it had in fact added a remote called 'git' with an url of 'remote'.
Some investigation yielded these fixes.


Thomas Rast (3):
  remote: add a test for extra arguments, according to docs
  remote: check for superfluous arguments in 'git remote add'
  remote: 'show' and 'prune' take more than one remote

 Documentation/git-remote.txt |  4 ++--
 builtin/remote.c             |  2 +-
 t/t5505-remote.sh            | 22 ++++++++++++++++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

-- 
1.8.2.1.931.g0116868
