From: Jeff Epler <jepler@unpythonic.net>
Subject: [RFC PATCH v2 0/2] git-gui: (un)stage a range of changes at once
Date: Wed, 21 Oct 2009 16:20:21 -0500
Message-ID: <1256160023-29629-1-git-send-email-jepler@unpythonic.net>
Cc: Jeff Epler <jepler@unpythonic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 23:26:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ih0-0002pD-H8
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 23:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545AbZJUVZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 17:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755536AbZJUVZs
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 17:25:48 -0400
Received: from zuul.dsndata.com ([162.40.127.30]:56409 "EHLO zuul.dsndata.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755533AbZJUVZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 17:25:44 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2009 17:25:43 EDT
Received: from lucky2.dsndata.com (lucky2.dsndata.com [198.183.6.22])
	by zuul.dsndata.com (8.13.8/8.13.8) with ESMTP id n9LLKRCH096230;
	Wed, 21 Oct 2009 16:20:28 -0500 (CDT)
	(envelope-from jepler@dsndata.com)
Received: from jepler by lucky2.dsndata.com with local (Exim 4.69)
	(envelope-from <jepler@lucky2.dsndata.com>)
	id 1N0ibb-0000B2-PT; Wed, 21 Oct 2009 16:20:27 -0500
X-Mailer: git-send-email 1.6.3.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (zuul.dsndata.com [162.40.127.30]); Wed, 21 Oct 2009 16:20:28 -0500 (CDT)
X-Scanned-By: MIMEDefang 2.61 on 162.40.127.30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130968>

Compared to the first version, I fixed a bug concerning staging line(s)
when all following lines are deletions (a preexisting bug in git-gui).
This version is made based off the master branch of git-gui.git, rather
than the master branch of git.git.

The first change fixes a long-standing git-gui bug in an area that the
new feature is rewriting anyway.  If there's interest in the new feature
then maybe the two should just be squashed (using the message from the
second).  If not, it'd be nice to see the bugfix applied anyway.


Jeff Epler (2):
  Fix applying a line when all following lines are deletions
  Make it possible to apply a range of changes at once

 git-gui.sh   |   15 +++-
 lib/diff.tcl |  224 ++++++++++++++++++++++++++++++++--------------------------
 2 files changed, 135 insertions(+), 104 deletions(-)
