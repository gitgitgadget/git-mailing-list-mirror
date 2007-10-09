From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 3/6] manual: Fix example finding commits referencing given content.
Date: Tue, 9 Oct 2007 23:02:19 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071009210219.GE31317@ins.uni-bonn.de>
References: <20071009205755.GB31317@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 23:34:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfMiE-0001Kc-GS
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 23:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111AbXJIVdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 17:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755091AbXJIVds
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 17:33:48 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:60276 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbXJIVdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 17:33:47 -0400
Received: from localhost.localdomain (xdsl-87-78-163-242.netcologne.de [87.78.163.242])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 10BDF4000022C
	for <git@vger.kernel.org>; Tue,  9 Oct 2007 23:02:57 +0200 (CEST)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1IfMDb-0000mX-De
	for git@vger.kernel.org; Tue, 09 Oct 2007 23:02:19 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071009205755.GB31317@ins.uni-bonn.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60445>

If I'm handed a file, then it typically lives outside the
working directory.  git-log only operates on in-tree files,
so the first 'filename' should be an in-tree one, or it should
look at all files.  This patch does the latter, so it would
also find renamed files.  However, it is also slower.
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 6adeca7..2b1b324 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -926,7 +926,7 @@ file such that it contained the given content either before or after the
 commit.  You can find out with this:
 
 -------------------------------------------------
-$  git log --raw --abbrev=40 --pretty=oneline -- filename |
+$  git log --raw --abbrev=40 --pretty=oneline |
 	grep -B 1 `git hash-object filename`
 -------------------------------------------------
 
-- 
1.5.3.3.g34c6d
