From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [GITK PATCH] gitk: support "gitk <tracheophyte> -- ."
Date: Tue, 23 Feb 2010 17:51:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002231748320.3980@intel-tinevez-2-302>
References: <f579dd581002200847o340a3eb9l50d0f1329d4e2c23@mail.gmail.com>  <alpine.DEB.1.00.1002201847290.20986@pacific.mpi-cbg.de> <a5b261831002200948v3c01708dv3e42d08d42e3119@mail.gmail.com> <alpine.DEB.1.00.1002201920350.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kirill <kirillathome@gmail.com>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Pat Thoyts <patthoyts@googlemail.com>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 17:52:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njxzb-0002vV-Ir
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 17:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab0BWQwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 11:52:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:34705 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752554Ab0BWQwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 11:52:09 -0500
Received: (qmail invoked by alias); 23 Feb 2010 16:51:56 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp066) with SMTP; 23 Feb 2010 17:51:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/741FJe+T7vzjXwwy/docHZwiYX27sEgZLjLR+ab
	SJH1VNW7jNwToJ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.1002201920350.20986@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140809>


It might be unintuitive to a user when "gitk HEAD -- ." does not show
any files in the lower right pane. This patch fixes that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	My initial analysis was all wrong.

	Pat: does this look correct to you?

	Kirill: does this fix the issue on your side, too?

	Paul: since we need this for Git Cheetah, and you are probably too 
	busy to apply/review in the next few weeks, I took the liberty of 
	keeping it as a git.git patch. Let me know if I you want it 
	in a different form that does not require git-am's -p2 option.

 gitk-git/gitk |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index cdedaa7..553922f 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7341,6 +7341,9 @@ proc startdiff {ids} {
 
 proc path_filter {filter name} {
     foreach p $filter {
+	if {$p == "."} {
+		return 1
+	}
 	set l [string length $p]
 	if {[string index $p end] eq "/"} {
 	    if {[string compare -length $l $p $name] == 0} {
-- 
1.6.4.297.gcb4cc
