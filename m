From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: fixup for 05/10: plug leak
Date: Tue, 29 Jul 2014 02:05:04 +0200
Message-ID: <53D6E530.5000504@web.de>
References: <53D694A2.8030007@web.de> <53D6964E.1070100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 02:05:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuut-0004sW-H5
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 02:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbaG2AFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 20:05:14 -0400
Received: from mout.web.de ([212.227.17.11]:65172 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603AbaG2AFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 20:05:13 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LxfOx-1WREQy1ep9-017DWn; Tue, 29 Jul 2014 02:05:07
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53D6964E.1070100@web.de>
X-Provags-ID: V03:K0:8pN1xYog9gl3aWmLt+KeKiGTx8AaakZs8HFcqN5lVFPWJWfvkw9
 owvz5+rJRwPyPq6WBkQjBEMLX9neb3l148LHkoRXn8BldrumZOKbGvXQlpZAcFGP0Cy9V4w
 6geKIM7t2cse/jRCKBRACHqYp7en7BtbpUS1jHdEdIjTGbfqYZJ11BkJsELMg2Jap4qKURC
 p8C3P606xtpVNnkjpQiRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254384>

Noticed-by: Jeff King <peff@peff.net>
---
 abspath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/abspath.c b/abspath.c
index 16e7fa2..6aa328f 100644
--- a/abspath.c
+++ b/abspath.c
@@ -58,7 +58,7 @@ static const char *real_path_internal(const char *path, int die_on_error)
 			goto error_out;
 	}
 
-	strbuf_init(&sb, 0);
+	strbuf_reset(&sb);
 	strbuf_addstr(&sb, path);
 
 	while (depth--) {
-- 
2.0.2
