From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] refs.c: remove extern keyword from function definition
Date: Fri, 19 Dec 2014 17:24:56 +0000
Message-ID: <54945F68.9000807@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 19 18:25:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y21Im-0006OB-Hu
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 18:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbaLSRZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 12:25:04 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:55473 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751082AbaLSRZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 12:25:03 -0500
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 69BA3401318;
	Fri, 19 Dec 2014 17:24:46 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id D6202400DED;
	Fri, 19 Dec 2014 17:24:45 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Fri, 19 Dec 2014 17:24:45 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261582>


Commit 5ed85684 ("reflog_expire(): new function in the reference
API", 12-12-2014) added a new function definition which included
the extern keyword.

While this is not an illegal use of the keyword, it is somewhat
unusual to include it in a function definition. (It would be
unique in the git codebase). Also, it triggers a warning from
sparse. In order to suppress the warning, simply remove the
extern keyword from reflog_expire() definition.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Michael,

If you need to re-roll your 'mh/reflog-expire' series, could you
please squash this into the relevant patch.

Thanks!

ATB,
Ramsay Jones
 
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 3bd686c..fdef36d 100644
--- a/refs.c
+++ b/refs.c
@@ -4020,12 +4020,12 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-extern int reflog_expire(const char *refname, const unsigned char *sha1,
-			 unsigned int flags,
-			 reflog_expiry_prepare_fn prepare_fn,
-			 reflog_expiry_should_prune_fn should_prune_fn,
-			 reflog_expiry_cleanup_fn cleanup_fn,
-			 void *policy_cb_data)
+int reflog_expire(const char *refname, const unsigned char *sha1,
+		 unsigned int flags,
+		 reflog_expiry_prepare_fn prepare_fn,
+		 reflog_expiry_should_prune_fn should_prune_fn,
+		 reflog_expiry_cleanup_fn cleanup_fn,
+		 void *policy_cb_data)
 {
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
-- 
2.2.0
