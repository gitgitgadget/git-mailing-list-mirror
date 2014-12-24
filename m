From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] merge: release strbuf after use in suggest_conflicts()
Date: Wed, 24 Dec 2014 01:18:38 +0100
Message-ID: <549A065E.8060008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 01:18:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3ZfC-0004yB-Gq
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 01:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756646AbaLXASu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 19:18:50 -0500
Received: from mout.web.de ([212.227.15.14]:58512 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbaLXASu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 19:18:50 -0500
Received: from [192.168.178.27] ([79.253.147.237]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MCeX4-1YBr7P2yDS-009NJg; Wed, 24 Dec 2014 01:18:45
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
X-Provags-ID: V03:K0:WXXwDTHzle73+Ba7X/zQPxPuLxSHNM8g64mKQqeAU2O/FAS66aB
 wc58X4km9ccS2u6tkB6l5FFLXr4LbM+5BTt/ZJkK8+g9QLS59yvAAy0t3pLWYHLuUGMNVnf
 T4fzQkEXCOEoerT3L+Y1Bxn1KjkOZY32ZEwtqY+8F4FZEZ5i4/FvFFb1suHd/fikBe22RBr
 ke4LcXt5qtxpocoP/jmEg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261782>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/merge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 215d485..d722889 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -894,6 +894,7 @@ static int suggest_conflicts(void)
 
 	append_conflicts_hint(&msgbuf);
 	fputs(msgbuf.buf, fp);
+	strbuf_release(&msgbuf);
 	fclose(fp);
 	rerere(allow_rerere_auto);
 	printf(_("Automatic merge failed; "
-- 
2.2.1
