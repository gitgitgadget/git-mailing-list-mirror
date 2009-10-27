From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] gitk: fix typo when diffing committed -> staged
Date: Tue, 27 Oct 2009 18:13:42 +0100
Message-ID: <4AE72A46.5040201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 18:15:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2pdQ-0004d6-Fn
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 18:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbZJ0RO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 13:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbZJ0ROz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 13:14:55 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:39882 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713AbZJ0ROz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 13:14:55 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id ECAC713361C94;
	Tue, 27 Oct 2009 18:14:58 +0100 (CET)
Received: from [80.128.59.71] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1N2pcB-0008K2-00; Tue, 27 Oct 2009 18:13:47 +0100
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131360>

When highlighting a commit, using the context menu over the staged changes
and then selecting "Diff this -> selected" the diff was empty. The same
happened when highlighting the staged changes and using "Diff selected ->
this" over a commit.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

I became aware of this issue while testing the submodule patch sent
earlier. Looks just like a copy & paste typo.

 gitk-git/gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a0214b7..8e892b3 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7224,7 +7224,7 @@ proc diffcmd {ids flags} {
 	set cmd [concat | git diff-index --cached $flags]
 	if {[llength $ids] > 1} {
 	    # comparing index with specific revision
-	    if {$i == 0} {
+	    if {$j == 0} {
 		lappend cmd -R [lindex $ids 1]
 	    } else {
 		lappend cmd [lindex $ids 0]
-- 
1.6.5.2.181.gd6f41.dirty
