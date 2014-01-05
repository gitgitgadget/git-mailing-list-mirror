From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/2] send-pack.c: mark a file-local function static
Date: Sun, 05 Jan 2014 23:55:01 +0000
Message-ID: <52C9F0D5.9080800@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 00:55:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzxXG-0007BK-3K
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 00:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbaAEXzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 18:55:07 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:40978 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751407AbaAEXzG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 18:55:06 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 20D30A648D3;
	Sun,  5 Jan 2014 23:55:04 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id E5230A6475B;
	Sun,  5 Jan 2014 23:55:03 +0000 (GMT)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Sun,  5 Jan 2014 23:55:03 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239981>


Commit f2c681cf ("send-pack: support pushing from a shallow clone
via http", 05-12-2013) adds the 'advertise_shallow_grafts_buf'
function as an external symbol.

Noticed by sparse. ("'advertise_shallow_grafts_buf' was not declared.
Should it be static?")

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
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
