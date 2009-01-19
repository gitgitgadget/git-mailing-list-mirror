From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Provide pessimistic defaults for cross compilation tests.
Date: Mon, 19 Jan 2009 21:34:01 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20090119203400.GA3539@ins.uni-bonn.de>
References: <loom.20090115T123123-915@post.gmane.org> <20090116094110.GD25275@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Julius Naperkowski <j.nap@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 21:35:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP0qG-0006t1-Q1
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 21:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbZASUeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 15:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbZASUeG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 15:34:06 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:59659 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbZASUeF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 15:34:05 -0500
Received: from localhost.localdomain (xdsl-87-78-65-140.netcologne.de [87.78.65.140])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id B12CA400038B9;
	Mon, 19 Jan 2009 21:34:01 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1LP0or-0001sa-9M; Mon, 19 Jan 2009 21:34:01 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Julius Naperkowski <j.nap@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090116094110.GD25275@ins.uni-bonn.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106388>

In a cross compile setup, configure tests that run programs
cannot be executed; in that case, provide pessimistic default
values.

Bug reported by Julius Naperkowski.
---

> I can post a patch to add sane default settings for AC_RUN_IFELSE in
> cross compile setups, this weekend.

 configure.ac |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 363547c..4a208d4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -360,6 +360,7 @@ AC_RUN_IFELSE(
 		else if (strcmp(buf, "12345"))
 		  return 2;]])],
 	[ac_cv_c_c99_format=yes],
+	[ac_cv_c_c99_format=no],
 	[ac_cv_c_c99_format=no])
 ])
 if test $ac_cv_c_c99_format = no; then
@@ -380,6 +381,7 @@ AC_RUN_IFELSE(
 		FILE *f = fopen(".", "r");
 		return f && fread(&c, 1, 1, f)]])],
 	[ac_cv_fread_reads_directories=no],
+	[ac_cv_fread_reads_directories=yes],
 	[ac_cv_fread_reads_directories=yes])
 ])
 if test $ac_cv_fread_reads_directories = yes; then
@@ -414,6 +416,7 @@ AC_RUN_IFELSE(
 		  if (snprintf(buf, 3, "%s", "12345") != 5
 		      || strcmp(buf, "12")) return 1]])],
 	[ac_cv_snprintf_returns_bogus=no],
+	[ac_cv_snprintf_returns_bogus=yes],
 	[ac_cv_snprintf_returns_bogus=yes])
 ])
 if test $ac_cv_snprintf_returns_bogus = yes; then
-- 
1.6.1.137.g3d9e8
