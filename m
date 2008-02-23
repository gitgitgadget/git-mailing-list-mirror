From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] pack-objects: Print a message describing the number of threads
 for packing
Date: Fri, 22 Feb 2008 20:12:58 -0600
Message-ID: <47BF812A.4020205@nrlssc.navy.mil>
References: <47B1BEC6.6080906@nrlssc.navy.mil> <1203732369-30314-1-git-send-email-casey@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Feb 23 03:14:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSjtx-0007vs-ML
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 03:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbYBWCNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 21:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbYBWCNe
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 21:13:34 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59671 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbYBWCNd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 21:13:33 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1N2Cw8a000687;
	Fri, 22 Feb 2008 20:12:58 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 22 Feb 2008 20:12:58 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1203732369-30314-1-git-send-email-casey@nrlssc.navy.mil>
X-OriginalArrivalTime: 23 Feb 2008 02:12:58.0355 (UTC) FILETIME=[9BD3DC30:01C875C1]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15736001
X-TM-AS-Result: : Yes--5.727100-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMDE2MC03MDQy?=
	=?us-ascii?B?NTctNzA0OTI3LTE4ODAxOS03MDQ3NDctNzAyMTE4LTcwNTU4MS03?=
	=?us-ascii?B?MDM5NjUtNzAyMzc5LTcxMDU3MS03MDg1NTgtMTQ4MDM5LTE0ODA1?=
	=?us-ascii?B?MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74786>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-pack-objects.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 586ae11..5a22f49 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2239,6 +2239,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 #ifdef THREADED_DELTA_SEARCH
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
+	if (progress)
+		fprintf(stderr, "Using %d pack threads.\n",
+			delta_search_threads);
 #endif
 
 	prepare_packed_git();
-- 
1.5.4.2.199.g0941
