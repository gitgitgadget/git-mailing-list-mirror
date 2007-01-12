From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: [PATCH] fix documentation for git-commit --no-verify
Date: Fri, 12 Jan 2007 09:49:35 +0200
Message-ID: <20070112074935.GB1049@mellanox.co.il>
References: <20070111221211.GM17999@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 08:49:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5HAK-0007j1-0P
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 08:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbXALHt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 02:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbXALHt3
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 02:49:29 -0500
Received: from p02c11o146.mxlogic.net ([208.65.145.69]:46507 "EHLO
	p02c11o146.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161024AbXALHt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 02:49:28 -0500
Received: from unknown [194.90.237.34] (EHLO p02c11o146.mxlogic.net)
	by p02c11o146.mxlogic.net (mxl_mta-4.0.1-4)
	with ESMTP id 88d37a54.2182552496.19691.00-500.p02c11o146.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Fri, 12 Jan 2007 00:49:28 -0700 (MST)
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o146.mxlogic.net (mxl_mta-4.0.1-4)
	with ESMTP id 08d37a54.1962265520.19681.00-001.p02c11o146.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Fri, 12 Jan 2007 00:49:20 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 12 Jan 2007 09:50:54 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri, 12 Jan 2007 09:47:50 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20070111221211.GM17999@mellanox.co.il>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 12 Jan 2007 07:50:54.0065 (UTC) FILETIME=[62F76E10:01C7361E]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14930.001
X-TM-AS-Result: No--11.392300-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36665>

Despite what the documentation claims, git-commit does not check commit
for suspicious lines: all hooks are disabled by default,
and the pre-comit hook could be changed to do something else.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

---

> Quoting Michael S. Tsirkin <mst@mellanox.co.il>:
> Subject: git-commit/git-applypatch whitespace rules different?
> 
> git-commit/git-applypatch whitespace rules seem to be different.
> Is this expected?

OK I found out why this happens, but the documentation can be improved.

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a7adf24..cb081cd 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -72,12 +72,8 @@ OPTIONS
 	Add Signed-off-by line at the end of the commit message.
 
 --no-verify::
-	By default, the command looks for suspicious lines the
-	commit introduces, and aborts committing if there is one.
-	The definition of 'suspicious lines' is currently the
-	lines that has trailing whitespaces, and the lines whose
-	indentation has a SP character immediately followed by a
-	TAB character.  This option turns off the check.
+	This option bypasses the pre-commit hook.
+	See also link:hooks.html[hooks].
 
 -e|--edit::
 	The message taken from file with `-F`, command line with
-- 
MST
