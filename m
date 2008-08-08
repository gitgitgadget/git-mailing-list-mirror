From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] t9700: remove useless check
Date: Fri, 8 Aug 2008 07:59:13 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808080752540.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com,
	Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 07:56:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRKxD-0000ND-BX
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 07:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbYHHFyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 01:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbYHHFyk
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 01:54:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:45121 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752243AbYHHFyk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 01:54:40 -0400
Received: (qmail invoked by alias); 08 Aug 2008 05:54:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 08 Aug 2008 07:54:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XLUkrlUqXpcH5Yzj+ijL1rJmJzO5p2stODIZ4Yd
	mhhMf936nmT2mN
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91622>


t9700 used to check if the basename of the current directory is
'trash directory', the expensive way.

However, there is absolutely no good reason why this test should not
run in, say 'life is good' or 'i love tests'.  So remove the check
altogether.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9700/test.pl |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 4d23125..851cea4 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -14,10 +14,7 @@ use File::Temp;
 BEGIN { use_ok('Git') }
 
 # set up
-our $repo_dir = "trash directory";
 our $abs_repo_dir = Cwd->cwd;
-die "this must be run by calling the t/t97* shell script(s)\n"
-    if basename(Cwd->cwd) ne $repo_dir;
 ok(our $r = Git->repository(Directory => "."), "open repository");
 
 # config
-- 
1.6.0.rc2.23.gd08e9
