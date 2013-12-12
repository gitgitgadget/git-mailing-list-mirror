From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] send-pack.c: mark a file-local function static
Date: Thu, 12 Dec 2013 23:15:54 +0000
Message-ID: <52AA43AA.9030703@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 00:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrFUD-0004D0-8S
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 00:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915Ab3LLXQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 18:16:00 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:45202 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751579Ab3LLXQA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 18:16:00 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 28184A64F51;
	Thu, 12 Dec 2013 23:15:58 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id EF227A648E4;
	Thu, 12 Dec 2013 23:15:57 +0000 (GMT)
Received: from [192.168.254.16] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Thu, 12 Dec 2013 23:15:57 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239250>


Commit f2c681cf ("send-pack: support pushing from a shallow clone
via http", 05-12-2013) adds the 'advertise_shallow_grafts_buf'
function as an external symbol. This symbol does not require
more than file visibility.

Noticed by sparse. ("'advertise_shallow_grafts_buf' was not declared.
Should it be static?")

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Duy,

If you need to re-roll the patches in your 'nd/shallow-clone' branch,
could you please squash this into your patch. Thanks!

BTW, I have not been following these patches, but I noticed that the
'remove_nonexistent_ours_in_pack()' function has no callers. (There are
two commented out callers - but they seem to have *always* been commented
out ;-) ). So, step 5 is no longer required? :-D

ATB,
Ramsay Jones

 send-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/send-pack.c b/send-pack.c
index 2a199cc..6129b0f 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -183,7 +183,7 @@ static int advertise_shallow_grafts_cb(const struct commit_graft *graft, void *c
 	return 0;
 }
 
-void advertise_shallow_grafts_buf(struct strbuf *sb)
+static void advertise_shallow_grafts_buf(struct strbuf *sb)
 {
 	if (!is_repository_shallow())
 		return;
-- 
1.8.5
