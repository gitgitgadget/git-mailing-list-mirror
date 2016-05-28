From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] apply: remove unused parameters from name_terminate()
Date: Sat, 28 May 2016 18:12:01 +0200
Message-ID: <5749C351.8070806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 18:12:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6gqh-0001kw-Ib
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 18:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbcE1QMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 12:12:16 -0400
Received: from mout.web.de ([212.227.15.14]:61282 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870AbcE1QMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 12:12:15 -0400
Received: from [192.168.178.36] ([79.213.120.97]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LzbAA-1bbsiP3a66-014mkx; Sat, 28 May 2016 18:12:03
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
X-Provags-ID: V03:K0:NescxFoWcPPqQzpy7DCHoqviwTQ8j/0LKK8nlkj4lDZ9eoZFyUX
 n/aPY3FcGGj59HeT48Ya+Ok0z7KopwZZQ/62i8HR7VXv6VLK4yBIOzRyjZuvO71dZuu91kl
 M+dbQaCscSGgyJ8ravpgM7z7WwlItqlkV86e+poG6ImMSxGswgu5dTTwowVPJHmrToaO1mM
 1kPgkNSNZachbxARDR16g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7YPOAAL8o4E=:6gAvl+1fEhw+E8V6HI2Fjc
 3W5sf9exjYqTnl1P5+07GiettRYPmWE7MHlZVDr4jiv2u4Evt1ewyUgTytO0J7om74pqtX7mj
 SK5e4Vr/6cRnd+HHpbnWA35dr116YdutmvxpD9OqbWJOxUid0x2dtIHTaDxddKCgiMrQUaMF0
 scgdGg37dmhVvm2wiAQUHXgON5YiK1ehMZJG6pbMS+JB3/RHJ/yepadeoHQj7AQrETAst79EJ
 gyVeETi2t5V4brBb8V7JvWzRKT6WHmYBMoE76wKjJRGjnjOfSPT0cdFkGIcx9G8DciEARi+Oj
 VG87Jz041riG2cxSqKfY55mWFQ7GkCx9TX+Dsn4U4uPUK16701+PnFzgCpvS88SCNOfeQK91h
 Yzewb75ozkbWmfvzmYE03yg4cJDYfkTTj2MduxMWqR3ELrD/fxDYnR5JoZTl7pymAI7OBDBQ/
 xPsMGE3DkQ+2xW13rGDhuRbpJ5fdX9p1Fr8B3XEH52QmXtuKq5a5qiRMN108qKV2zj9ydCvAN
 r8k60jSCccecgGPUbkfoIXd0yirPi4CyQnIifseeKKeWm1CxIdHzPyemt2//+WWcoeK3RK1FZ
 Qs4aURcvnjA21S+USnzROwWj0OfebSkXxoWvk8H9eNuIVoInaHFvHScZxjjOQpsupby0zRTNB
 BRIhMF7KzTQOCiyLEPDV0T5mcwiDmXLnWDOuZng1splDeyect3P+tQ3rjH0gTyWVfH9W5Pmcu
 GLGSUP0m/FgxjnQVlb/lMdXGV9oK89RvLbickLIrjAQdaiOayT6SMZJaaSK9ohmbTt3SB651 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295828>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/apply.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8e4da2e..c770d7d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -442,7 +442,7 @@ static int is_dev_null(const char *str)
 #define TERM_SPACE	1
 #define TERM_TAB	2
 
-static int name_terminate(const char *name, int namelen, int c, int terminate)
+static int name_terminate(int c, int terminate)
 {
 	if (c == ' ' && !(terminate & TERM_SPACE))
 		return 0;
@@ -671,7 +671,7 @@ static char *find_name_common(const char *line, const char *def,
 		if (!end && isspace(c)) {
 			if (c == '\n')
 				break;
-			if (name_terminate(start, line-start, c, terminate))
+			if (name_terminate(c, terminate))
 				break;
 		}
 		line++;
-- 
2.8.3
