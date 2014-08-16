From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] clean: use f(void) instead of f() to declare a pointer to
 a function without arguments
Date: Sat, 16 Aug 2014 13:16:56 +0200
Message-ID: <53EF3DA8.7040605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 16 13:18:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIc01-00072k-Sh
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 13:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbaHPLSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 07:18:07 -0400
Received: from mout.web.de ([212.227.15.14]:64902 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319AbaHPLSG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 07:18:06 -0400
Received: from [192.168.178.27] ([79.253.189.61]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MRTvU-1Wq2Ty1KXY-00SgwM; Sat, 16 Aug 2014 13:17:54
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:ZxZYG3cSnHi6+UWKRV7ztRjJpkb6SQLVjiQdukw7xiDy7GxwL1T
 oxa/1QSY5P7Md4JYgreQv9qP3C81Urqe8kM1DwFB8ikJxAIso6g+mHTn77/r6z2iInzuTyd
 9DowZexi9c9krhkQmX/II62db0YOL8AwzC7RVosTkkBu+GCqcNKFm7XrTgGeKMP6XuOgT47
 XINg4gwJUoKvDuc6XN6Wg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255323>

Explicitly state that menu_item functions like clean_cmd don't take
any arguments by using void instead of an empty parameter list.

Found using gcc -Wstrict-prototypes.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/clean.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 1032563..3beeea6 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -67,7 +67,7 @@ struct menu_item {
 	char hotkey;
 	const char *title;
 	int selected;
-	int (*fn)();
+	int (*fn)(void);
 };
 
 enum menu_stuff_type {
-- 
2.1.0
