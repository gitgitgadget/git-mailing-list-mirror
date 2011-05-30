From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH 0/2] Tests for some submodule corner cases.
Date: Mon, 30 May 2011 17:51:18 -0400
Message-ID: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 00:05:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRAb0-0004E5-G3
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 00:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab1E3WFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 18:05:52 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:39545 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752355Ab1E3WFu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 18:05:50 -0400
X-Greylist: delayed 853 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 May 2011 18:05:50 EDT
Received: from rincewind.xiplink.com ([192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id p4ULpZN4011591;
	Mon, 30 May 2011 17:51:35 -0400
X-Mailer: git-send-email 1.7.5.3.686.g35b8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174782>

Ran across some submodule behavior that seems wrong to me.  I don't have the
chops to fix the issues, so I thought I'd just point them out with some unit
tests.

Patch 1 tests the case where "submodule add" fails if the path to the
submodule repo is relative (i.e. starts with "../").  This currently fails
with "remote (origin) does not have a url defined in .git/config".  Maybe
there's a reason to fail?  If so, a better error message would be appreciated.

Patch 2 exposes an anomaly in "submodule status", which reports that a
submodule is OK even though it has deleted files.  "git status" inside
the submodule (and in the super-repo) both identify any deleted files, but
"submodule status" doesn't prefix the submodule's HEAD SHA-ID with a "+".

(ps. I didn't sign-off these two patches, since they're just failing unit
tests.  Should I sign-off on them?)

		M.
