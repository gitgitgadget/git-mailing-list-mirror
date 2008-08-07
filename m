From: Marcus Griep <marcus@griep.us>
Subject: [PATCH v2 0/2] git-svn multi-glob fix and extension
Date: Thu,  7 Aug 2008 11:34:00 -0400
Message-ID: <1218123242-26260-1-git-send-email-marcus@griep.us>
References: <20080807090008.GA9161@untitled>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 17:46:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR7h6-0007v2-E0
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 17:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbYHGPpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 11:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbYHGPpZ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 11:45:25 -0400
Received: from boohaunt.net ([209.40.206.144]:46970 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003AbYHGPpY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 11:45:24 -0400
X-Greylist: delayed 682 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Aug 2008 11:45:24 EDT
Received: by boohaunt.net (Postfix, from userid 1000)
	id 0EF8F1878CDB; Thu,  7 Aug 2008 11:34:02 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.4.g39f8
In-Reply-To: <20080807090008.GA9161@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91589>


This patch series fixes and extends globs for branches and tags.

The first patch fixes the assertion that protects git-svn from allowing
multi-globs in branch names, whereas the second removes that restriction
altogether, allowing up to one multi-glob set in defining a branch hierarchy.

Also, patches are now under 80 chars wide except for a couple of echos in the
test cases.

Marcus Griep (2):
      Fix multi-glob assertion in git-svn
      git-svn: Allow deep branch names by supporting multi-globs

 git-svn.perl                               |   63 +++++++++---
 t/t9108-git-svn-glob.sh                    |   22 ++++-
 t/t9108-git-svn-multi-glob.sh              |  155 ++++++++++++++++++++++++++++
 t/t9125-git-svn-multi-glob-branch-names.sh |   41 ++++++++
 4 files changed, 264 insertions(+), 17 deletions(-)
