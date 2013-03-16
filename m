From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] advice: Remove unused advice_push_non_ff_default
Date: Sat, 16 Mar 2013 17:58:09 +0000
Message-ID: <5144B2B1.3030106@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 16 19:03:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGvSD-00066J-85
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 19:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980Ab3CPSDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 14:03:09 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:49822 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752216Ab3CPSDI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 14:03:08 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 0B2116F8611;
	Sat, 16 Mar 2013 18:03:06 +0000 (GMT)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 17DB96F860F;
	Sat, 16 Mar 2013 18:03:05 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sat, 16 Mar 2013 18:03:04 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218310>


Commit 27f76a2b ('push: switch default from "matching" to "simple"',
04-01-2013) removed the last use of the 'advice_push_non_ff_default'
variable, along with the advice message which it used to suppress.

Remove the 'advice_push_non_ff_default' variable definition, along
with the now redundant advice.pushnonffdefault config variable
(including it's documentation).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

Commit 27f76a2b is in next, but you are about to re-build next, right?
Could you please squash this (or something like it) into commit 27f76a2b.

Note that this patch was built on the tip of the pu branch. Also, I have
not re-built the documentation to check the formatting; I stopped building
the documentation some time ago!

NOTE: I just noticed that I missed a use of 'pushNonFFDefault' in the
documentation of 'advice.pushUpdateRejected', just above the change made
to Documentation/config.txt below. Sorry about that!

Thanks!

ATB,
Ramsay Jones

 Documentation/config.txt | 6 ------
 advice.c                 | 2 --
 advice.h                 | 1 -
 3 files changed, 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4730dd2..06327cd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -149,12 +149,6 @@ advice.*::
 	pushNonFFCurrent::
 		Advice shown when linkgit:git-push[1] fails due to a
 		non-fast-forward update to the current branch.
-	pushNonFFDefault::
-		Advice to set 'push.default' to 'upstream' or 'current'
-		when you ran linkgit:git-push[1] and pushed 'matching
-		refs' by default (i.e. you did not provide an explicit
-		refspec, and no 'push.default' configuration was set)
-		and it resulted in a non-fast-forward error.
 	pushNonFFMatching::
 		Advice shown when you ran linkgit:git-push[1] and pushed
 		'matching refs' explicitly (i.e. you used ':', or
diff --git a/advice.c b/advice.c
index 780f58d..88c4fea 100644
--- a/advice.c
+++ b/advice.c
@@ -2,7 +2,6 @@
 
 int advice_push_update_rejected = 1;
 int advice_push_non_ff_current = 1;
-int advice_push_non_ff_default = 1;
 int advice_push_non_ff_matching = 1;
 int advice_push_already_exists = 1;
 int advice_push_fetch_first = 1;
@@ -19,7 +18,6 @@ static struct {
 } advice_config[] = {
 	{ "pushupdaterejected", &advice_push_update_rejected },
 	{ "pushnonffcurrent", &advice_push_non_ff_current },
-	{ "pushnonffdefault", &advice_push_non_ff_default },
 	{ "pushnonffmatching", &advice_push_non_ff_matching },
 	{ "pushalreadyexists", &advice_push_already_exists },
 	{ "pushfetchfirst", &advice_push_fetch_first },
diff --git a/advice.h b/advice.h
index fad36df..4d1e1f9 100644
--- a/advice.h
+++ b/advice.h
@@ -5,7 +5,6 @@
 
 extern int advice_push_update_rejected;
 extern int advice_push_non_ff_current;
-extern int advice_push_non_ff_default;
 extern int advice_push_non_ff_matching;
 extern int advice_push_already_exists;
 extern int advice_push_fetch_first;
-- 
1.8.2
