From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] test-generation.c: Fix a compiler warning
Date: Sat, 15 Sep 2012 17:12:57 +0100
Message-ID: <5054A909.1070104@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 19:23:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCw5f-0006yu-Ek
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 19:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab2IORX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 13:23:26 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:44324 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754263Ab2IORX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 13:23:26 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 5BA1AA640C1;
	Sat, 15 Sep 2012 18:23:24 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id BD84CA640BB;	Sat, 15 Sep 2012 18:23:23 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;	Sat, 15 Sep 2012 18:23:22 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205567>


gcc complains as follows:

        CC test-generation.o
    test-generation.c: In function `main':
    test-generation.c:105: warning: control reaches end of \
        non-void function

In order to suppress the warning, we simply add a suitable
return statement to main().

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

Could you please squash this into commit 1784d096 ("test-generation:
compute generation numbers and clock skews", 04-09-2012).

Thanks!

ATB,
Ramsay Jones

 test-generation.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test-generation.c b/test-generation.c
index 4df5a0d..de87f2b 100644
--- a/test-generation.c
+++ b/test-generation.c
@@ -102,4 +102,5 @@ int main(int ac, const char **av)
 
 		show_commit(commit, gd);
 	}
+	return 0;
 }
-- 
1.7.12
