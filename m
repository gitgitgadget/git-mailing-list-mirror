From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] clone: don't use an integer as a NULL pointer
Date: Thu, 26 May 2016 00:12:46 +0100
Message-ID: <5746316E.8020902@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 26 01:12:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hyw-0007j1-6g
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 01:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbcEYXMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 19:12:50 -0400
Received: from avasout01.plus.net ([84.93.230.227]:39187 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbcEYXMt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 19:12:49 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 May 2016 19:12:49 EDT
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id ynCn1s0015VX2mk01nCoB3; Thu, 26 May 2016 00:12:48 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=u1ZbWeDvq19SH6arjJgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295615>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Stefan,

If you need to re-roll your 'sb/submodule-default-paths' branch, could
you please squash this into the relevant patch. (commit 8efbe28b,
"clone: add --init-submodule=<pathspec> switch", 23-05-2016).

Thanks!

ATB,
Ramsay Jones

 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 22b6eac..a056f72 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -925,7 +925,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		struct strbuf sb = STRBUF_INIT;
 		for_each_string_list_item(item, &init_submodules) {
 			strbuf_addf(&sb, "submodule.defaultUpdatePath=%s", item->string);
-			string_list_append(&option_config, strbuf_detach(&sb, 0));
+			string_list_append(&option_config, strbuf_detach(&sb, NULL));
 		}
 	}
 
-- 
2.8.0
