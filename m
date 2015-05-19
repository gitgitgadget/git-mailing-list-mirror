From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] dir: remove unused variable sb
Date: Wed, 20 May 2015 00:13:33 +0200
Message-ID: <555BB58D.1080202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 20 00:14:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yupm1-0002NP-CZ
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbbESWOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:14:00 -0400
Received: from mout.web.de ([212.227.15.4]:61525 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbbESWN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:13:59 -0400
Received: from [192.168.178.27] ([79.253.161.1]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Mbhen-1Ye7ja0ZmP-00J5JZ; Wed, 20 May 2015 00:13:55
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Provags-ID: V03:K0:IZVCa/noHE1dYIn5CATgdCxNBeLpkAPNBJ2rAxNHlAjJzVUUiB2
 o7JoOvHNiJsnKssdjaw2od5miVBOW1YKjDIFXFRApzSaasx9hblYdpvOdg69BFrR/WjC+Sn
 SqJZ4Sdh5NAHrN0wjzpVSanK3J34t91yQ9GOUWH2VJTdOzYwVLpH6OkFB3iiTIQFWMUIE5/
 TUZhneT86t1g4ZG3/xPbQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269419>

It had never been used.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
The parameter prefix of report_path_error() is not (yet?) used either.

 dir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/dir.c b/dir.c
index 0c38d86..bc6c682 100644
--- a/dir.c
+++ b/dir.c
@@ -385,7 +385,6 @@ int report_path_error(const char *ps_matched,
 	/*
 	 * Make sure all pathspec matched; otherwise it is an error.
 	 */
-	struct strbuf sb = STRBUF_INIT;
 	int num, errors = 0;
 	for (num = 0; num < pathspec->nr; num++) {
 		int other, found_dup;
@@ -417,7 +416,6 @@ int report_path_error(const char *ps_matched,
 		      pathspec->items[num].original);
 		errors++;
 	}
-	strbuf_release(&sb);
 	return errors;
 }
 
-- 
2.4.1
