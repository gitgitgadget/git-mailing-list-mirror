From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: merge -s ffonly
Date: Mon, 6 Oct 2008 16:56:11 -0700
Message-ID: <20081006235611.GA17662@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 01:57:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmzx5-000638-FF
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 01:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbYJFX4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 19:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbYJFX4N
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 19:56:13 -0400
Received: from george.spearce.org ([209.20.77.23]:35435 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbYJFX4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 19:56:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9A65F3835F; Mon,  6 Oct 2008 23:56:11 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97643>

I really don't care about this feature.  But Randal's whining on
#git made me stop what I was doing and write something that might
turn into it.

Totally untested code.  It might reformat your C:\ drive and install
Windows ME.  Install as $(git --exec-path)/git-merge-ffonly and
call as `git merge -s ffonly`.

If you care about this sort of feature, test it, write tests for it,
make a formal patch, and send it for review.  No, I will not do this
for you.  As I said, I don't care about this as a feature.

--8<--
diff --git a/git-merge-ffonly.sh b/git-merge-ffonly.sh
new file mode 100644
index 0000000..24363b5
--- /dev/null
+++ b/git-merge-ffonly.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+while test $# -gt 0
+do
+	if test "z$1" = z--
+	then
+		shift
+		break
+	else
+		shift
+	fi
+done
+
+while test $# -gt 0
+do
+	if test -n "$(git rev-list $1..HEAD)"
+	then
+		exit 2
+	fi
+	shift
+done

-- 
Shawn.
