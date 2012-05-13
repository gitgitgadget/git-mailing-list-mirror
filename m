From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] builtin/blame.c: Fix a "Using plain integer as NULL pointer"
 warning
Date: Sun, 13 May 2012 22:41:16 +0100
Message-ID: <4FB02A7C.1000605@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rene.scharfe@lsrfire.ath.cx, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 01:01:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SThmx-0001nX-Rr
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 01:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129Ab2EMXAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 May 2012 19:00:53 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:43014 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752879Ab2EMXAw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2012 19:00:52 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1SThmV-00054g-aI; Sun, 13 May 2012 23:00:51 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197756>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

I try to catch these warnings, while the topics are still in the
pu branch, so that we can squash the fix into them before they
hit next. I don't know how I missed this one (commit 4b4132f,
"blame: factor out helper for calling xdi_diff()", 09-05-2012)
which was part of the 'rs/xdiff-lose-emit-func' branch.

Sorry about that.

ATB,
Ramsay Jones


 builtin/blame.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 778d661..24d3dd5 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -93,7 +93,7 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b, long ctxlen,
 {
 	xpparam_t xpp = {0};
 	xdemitconf_t xecfg = {0};
-	xdemitcb_t ecb = {0};
+	xdemitcb_t ecb = {NULL};
 
 	xpp.flags = xdl_opts;
 	xecfg.ctxlen = ctxlen;
-- 
1.7.10
