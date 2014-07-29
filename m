From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: fixup for 09/10: plug leak
Date: Tue, 29 Jul 2014 02:05:11 +0200
Message-ID: <53D6E537.2020001@web.de>
References: <53D694A2.8030007@web.de> <53D69793.3010307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 02:05:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuv1-0004uj-C3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 02:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbaG2AFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 20:05:22 -0400
Received: from mout.web.de ([212.227.17.12]:63322 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbaG2AFV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 20:05:21 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MXYWA-1Wwyop33hO-00WVJZ; Tue, 29 Jul 2014 02:05:13
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53D69793.3010307@web.de>
X-Provags-ID: V03:K0:zOSlwD3gx6fAXrT+FbZ9NQscC/5ufihPwHSVGMmnslrhT9PhIsj
 7Sv17PiBvxsU+MopBGOS5niv4ONgIoxvHmybpZRagmrfMDu0sZA+heuDL8CAFwaXoWWD+T2
 kkgx1uYJwLWrUlGe2LXR24usBk1JMiNze6S05d5RItGvbUYmvbADzS0CH7VrbsY+3CzBd9j
 NJyEVvEGk6HdpY0+as14g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254385>

Noticed-by: Jeff King <peff@peff.net>
---
 abspath.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/abspath.c b/abspath.c
index cf9b404..5edb4e7 100644
--- a/abspath.c
+++ b/abspath.c
@@ -146,8 +146,8 @@ const char *real_path_if_valid(const char *path)
  */
 const char *absolute_path(const char *path)
 {
-	static struct strbuf sb;
-	strbuf_init(&sb, 0);
+	static struct strbuf sb = STRBUF_INIT;
+	strbuf_reset(&sb);
 	strbuf_add_absolute_path(&sb, path);
 	return sb.buf;
 }
-- 
2.0.2
