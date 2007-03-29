From: Eric Lesh <eclesh@ucla.edu>
Subject: [PATCH guilt] guilt: Add -h option to show man pages
Date: Thu, 29 Mar 2007 05:38:10 -0700
Message-ID: <1175171890.27597.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Josef \"Jeff\" Sipek" <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Mar 29 14:38:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWttd-000255-Fo
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 14:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbXC2Mi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 08:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbXC2Mi0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 08:38:26 -0400
Received: from smtp-4.smtp.ucla.edu ([169.232.46.137]:33038 "EHLO
	smtp-4.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbXC2MiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 08:38:25 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.158])
	by smtp-4.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l2TCcHSC029845;
	Thu, 29 Mar 2007 05:38:17 -0700
Received: from [192.168.1.7] (adsl-75-26-178-23.dsl.scrm01.sbcglobal.net [75.26.178.23])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l2TCcGmc014580
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Thu, 29 Mar 2007 05:38:17 -0700
X-Mailer: Evolution 2.8.1 
X-Probable-Spam: no
X-Scanned-By: smtp.ucla.edu on 169.232.46.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43430>

From: Eric Lesh <eclesh@ucla.edu>
Date: Thu, 29 Mar 2007 04:38:49 -0700
Subject: [PATCH] guilt: Add -h option to show man pages

git-sh-setup steals the -h|--h* argument and prints the usage message
of the command that calls it, which in this case is guilt.  Rather than
print the unhelpful guilt usage message, call guilt-help on the given
command instead.

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 guilt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/guilt b/guilt
index b1ab5a1..88f5a1b 100755
--- a/guilt
+++ b/guilt
@@ -9,6 +9,14 @@ GUILT_NAME="Space Rock"
 # we change directories ourselves
 SUBDIRECTORY_OK=1
 
+case $1 in
+	-h|--h|--he|--hel|--help)
+	dir=`dirname $0`
+	shift
+	exec "$dir/guilt-help" "$@"
+	exit
+esac
+
 . git-sh-setup
 
 function guilt_commands
-- 
1.5.1-rc1.GIT
