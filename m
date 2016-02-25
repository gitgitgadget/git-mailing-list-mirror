From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] submodule--helper: fix 'dubious bitfield' sparse warnings
Date: Thu, 25 Feb 2016 19:42:00 +0000
Message-ID: <56CF5908.7090800@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 20:42:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ1ne-0006aG-F0
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 20:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933647AbcBYTmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 14:42:06 -0500
Received: from avasout04.plus.net ([212.159.14.19]:51478 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933377AbcBYTmF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 14:42:05 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id Nji01s0054mu3xa01ji1ld; Thu, 25 Feb 2016 19:42:02 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=upoq2KWAZ0OOreiKvdcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287425>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Stefan,

If you need to re-roll (err, one of your) 'sb/submodule-parallel-update'
branches, could you please squash this into the relevant patch.
(ie. "git submodule update: have a dedicated helper for cloning", 23-02-2016).

Thanks!

ATB,
Ramsay Jones

 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f8cdce9..482a3cc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -563,7 +563,7 @@ struct submodule_update_clone {
 	/* index into 'list', the list of submodules to look into for cloning */
 	int current;
 	struct module_list list;
-	int warn_if_uninitialized : 1;
+	unsigned int warn_if_uninitialized : 1;
 	/* update parameter passed via commandline*/
 	struct submodule_update_strategy update;
 	/* configuration parameters which are passed on to the children */
@@ -575,7 +575,7 @@ struct submodule_update_clone {
 	/* lines to be output */
 	struct string_list projectlines;
 	/* If we want to stop as fast as possible and return an error */
-	int quickstop : 1;
+	unsigned int quickstop : 1;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, NULL, NULL, NULL, NULL, \
-- 
2.7.0
