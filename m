From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] git.spec: fix changelog dates
Date: Tue,  5 Apr 2016 14:09:57 +0200
Message-ID: <6ef7d9d87f0c14147267c44e8b382f988936875b.1459858117.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 14:10:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anPo9-0005zT-7I
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 14:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932786AbcDEMKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 08:10:01 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34244 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932735AbcDEMJ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2016 08:09:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 9364120824
	for <git@vger.kernel.org>; Tue,  5 Apr 2016 08:09:58 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 05 Apr 2016 08:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp;
	 bh=UOpKDgedrpBybnUEZ3GRLV7KeKk=; b=MN7ysuuAVsSBmk+AHVB9o2U67tw9
	+4WsMF1ImM9zF5RsZvNXHIbK1g+P6jcUbxWbirQ0JcxRKM+bahzIuMLKuIBnJJK7
	xyasXerTT9v1JXHLaB4z7M/dtQ4PAH+BQUZnu1HacpL6BAMeta26fzdjD9GwDAa6
	ek+sQWiN7R2EF4A=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=UOpKDgedrpBybnUEZ3GRLV7KeK
	k=; b=VZPtRkpktNSaK2Cy57D+UxPIJzqLih9yxJREbI2qZ5G7KYC1CuToF1Ixxi
	qA6mYExlpGQXRReCifxB8EDAnoGBE07LrEafbxjhCpgBtHSE/Q+Ud5z3LNqD6lSj
	++kubRG3hFFJjYGtVL0pSfb/oWXlFFZSFiCRmlSsilD02GXsE=
X-Sasl-enc: WYKHzn9uiFvqpYmtOiR0mwsTYe2b7dHjZMCSnxkUWSo2 1459858198
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 375246800FC;
	Tue,  5 Apr 2016 08:09:58 -0400 (EDT)
X-Mailer: git-send-email 2.8.1.120.g4a400c2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290777>

A few changelog entries have inconsistent dates, which rpmlint reports
as errors.

Fix them based on these assumptions:
- It's easier to mistype a number than a weekday abbreviation.
- changelog date must be before git commit date
- The mistyped date is just a few days off.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I dunno if this is worthwhile, but rpmlint is the first thing we tell
packagers and reviewers to check.

 git.spec.in | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index bfd1cfb..eb581a3 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -229,7 +229,7 @@ rm -rf $RPM_BUILD_ROOT
 * Sat Jan 30 2010 Junio C Hamano <gitster@pobox.com>
 - We don't ship Python bits until a real foreign scm interface comes.
 
-* Mon Feb 04 2009 David J. Mellor <dmellor@whistlingcat.com>
+* Mon Feb 02 2009 David J. Mellor <dmellor@whistlingcat.com>
 - fixed broken git help -w after renaming the git-core package to git.
 
 * Fri Sep 12 2008 Quy Tonthat <qtonthat@gmail.com>
@@ -262,7 +262,7 @@ rm -rf $RPM_BUILD_ROOT
 * Thu Jun 21 2007 Shawn O. Pearce <spearce@spearce.org>
 - Added documentation files for git-gui
 
-* Tue May 13 2007 Quy Tonthat <qtonthat@gmail.com>
+* Sun May 13 2007 Quy Tonthat <qtonthat@gmail.com>
 - Added lib files for git-gui
 - Added Documentation/technical (As needed by Git Users Manual)
 
@@ -272,7 +272,7 @@ rm -rf $RPM_BUILD_ROOT
 * Tue Mar 27 2007 Eygene Ryabinkin <rea-git@codelabs.ru>
 - Added the git-p4 package: Perforce import stuff.
 
-* Mon Feb 13 2007 Nicolas Pitre <nico@fluxnic.net>
+* Mon Feb 12 2007 Nicolas Pitre <nico@fluxnic.net>
 - Update core package description (Git isn't as stupid as it used to be)
 
 * Mon Feb 12 2007 Junio C Hamano <junkio@cox.net>
@@ -326,5 +326,5 @@ rm -rf $RPM_BUILD_ROOT
 * Thu Jul 14 2005 Eric Biederman <ebiederm@xmission.com>
 - Add the man pages, and the --without docs build option
 
-* Wed Jul 7 2005 Chris Wright <chris@osdl.org>
+* Wed Jul 6 2005 Chris Wright <chris@osdl.org>
 - initial git spec file
-- 
2.8.1.120.g4a400c2
