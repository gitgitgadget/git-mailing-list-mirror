From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 0/7] Some patches from msysGit (round 2)
Date: Sat, 15 Oct 2011 15:05:13 +0100
Message-ID: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 15 16:05:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF4rt-0003yR-Os
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 16:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab1JOOF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 10:05:27 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:51478 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751412Ab1JOOF0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 10:05:26 -0400
X-Greylist: delayed 54687 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Oct 2011 10:05:26 EDT
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.4])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015140525.WPVV13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 15:05:25 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1RF4rd-0001j9-8n; Sat, 15 Oct 2011 15:05:25 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id ACD97207A7; Sat, 15 Oct 2011 15:05:24 +0100 (BST)
X-Mailer: git-send-email 1.7.5
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=1FnzQMsHqMcA:10 a=tP4I8MbwdgD03AHwlfAA:9 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183655>

This collects some recent patches from the msysGit tree that clear up
test issues on Windows.

This second version incorporates suggestions received from round 1 to:
  avoid duplicating code in t9901 web-browse tests
  drop the t1402 changes in favour of another change from J6t (on pu)
  test for the presence of 'bcomp' in bc3 mergetool

Johannes Schindelin (3):
  t1020: disable the pwd test on MinGW
  t9001: do not fail only due to CR/LF issues
  t9300: do not run --cat-blob-fd related tests on MinGW

Pat Thoyts (3):
  t9901: fix line-ending dependency on windows
  mergetools: use the correct tool for Beyond Compare 3 on Windows
  mingw: ensure sockets are initialized before calling gethostname

Sebastian Schuberth (1):
  git-svn: On MSYS, escape and quote SVN_SSH also if set by the user

 compat/mingw.c             |    7 +++++++
 compat/mingw.h             |    3 +++
 git-svn.perl               |   15 +++++++--------
 mergetools/bc3             |    7 ++++++-
 t/t1020-subdirectory.sh    |    2 +-
 t/t9001-send-email.sh      |    1 +
 t/t9300-fast-import.sh     |    8 ++++----
 t/t9901-git-web--browse.sh |   32 +++++++++++++++++---------------
 8 files changed, 46 insertions(+), 29 deletions(-)

-- 
1.7.7.1.gbba15
