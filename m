From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] submodule: don't use an integer as a NULL pointer
Date: Sun, 21 Feb 2016 17:27:12 +0000
Message-ID: <56C9F370.3020802@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 18:27:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXXn6-0007Mo-HY
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbcBUR1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 12:27:25 -0500
Received: from avasout04.plus.net ([212.159.14.19]:51642 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbcBUR1X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 12:27:23 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id M5TL1s0014mu3xa015TMqJ; Sun, 21 Feb 2016 17:27:21 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=dpRsOzxM2zGelKR7xSMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286802>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Stefan,

If you need to re-roll your 'sb/submodule-init' branch, could
you please squash this into the relevant patch.

Thanks!

ATB,
Ramsay Jones

 submodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 30c393b..ccafd45 100644
--- a/submodule.c
+++ b/submodule.c
@@ -253,7 +253,7 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
 		return NULL;
 	case SM_UPDATE_COMMAND:
 		strbuf_addf(&sb, "!%s", s->command);
-		return strbuf_detach(&sb, 0);
+		return strbuf_detach(&sb, NULL);
 	}
 	return NULL;
 }
-- 
2.7.0
