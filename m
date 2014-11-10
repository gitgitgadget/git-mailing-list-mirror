From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] run-command: use void to declare that functions take no parameters
Date: Mon, 10 Nov 2014 22:17:00 +0100
Message-ID: <54612B4C.8010609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Etienne Buira <etienne.buira@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 22:17:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnwL0-0008IH-55
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 22:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbaKJVRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 16:17:21 -0500
Received: from mout.web.de ([212.227.15.3]:62560 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748AbaKJVRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 16:17:20 -0500
Received: from [192.168.178.27] ([79.253.174.47]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MgfH5-1XcCbq2Xah-00O1BJ; Mon, 10 Nov 2014 22:17:01
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:8QF0A3QhhAP0IsYuBPIURAyg7vz7W7dB6CP29C223sOkiZxEaEi
 qwaZt/YFSK5jPlYlTMdn26F0IZ0SbmCy8eLjHPgDHVf09PdsjKlA3qXSc57Xr7rAovPxKRk
 cl7E9OAhH45ezuH1+9mMx9oK9th6WYxlYiTqnpV9yLhnHv/foZoxxp3TyZKFcVi63lLmi0Y
 yhn29PGaJ8eNlczqo9IHg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explicitly declare that git_atexit_dispatch() and git_atexit_clear()
take no parameters instead of leaving their parameter list empty and
thus unspecified.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 run-command.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 79a0a76..a476999 100644
--- a/run-command.c
+++ b/run-command.c
@@ -636,7 +636,7 @@ static struct {
 
 static int git_atexit_installed;
 
-static void git_atexit_dispatch()
+static void git_atexit_dispatch(void)
 {
 	size_t i;
 
@@ -644,7 +644,7 @@ static void git_atexit_dispatch()
 		git_atexit_hdlrs.handlers[i-1]();
 }
 
-static void git_atexit_clear()
+static void git_atexit_clear(void)
 {
 	free(git_atexit_hdlrs.handlers);
 	memset(&git_atexit_hdlrs, 0, sizeof(git_atexit_hdlrs));
-- 
2.1.3
