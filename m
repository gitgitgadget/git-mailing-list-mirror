From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] daemon.c: mark a file-local symbol as static
Date: Sun, 21 Feb 2016 17:33:38 +0000
Message-ID: <56C9F4F2.1060100@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 21 18:33:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXXtK-0005QK-ET
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbcBURdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 12:33:50 -0500
Received: from avasout07.plus.net ([84.93.230.235]:46802 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbcBURdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 12:33:49 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id M5Zm1s0054mu3xa015Znd8; Sun, 21 Feb 2016 17:33:47 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=vrpPQPLEZ42g4ZxXG9EA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286807>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

If you need to re-roll your 'jk/tighten-alloc' branch, could you
please squash this into the relevant patch. (ie. "convert manual
allocations to argv_array").

Thanks!

ATB,
Ramsay Jones

 daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index 3f57adb..8d45c33 100644
--- a/daemon.c
+++ b/daemon.c
@@ -808,7 +808,7 @@ static void check_dead_children(void)
 			cradle = &blanket->next;
 }
 
-struct argv_array cld_argv = ARGV_ARRAY_INIT;
+static struct argv_array cld_argv = ARGV_ARRAY_INIT;
 static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child_process cld = CHILD_PROCESS_INIT;
-- 
2.7.0
