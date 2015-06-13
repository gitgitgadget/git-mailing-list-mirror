From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/12] remove_branches(): remove temporary
Date: Sat, 13 Jun 2015 16:42:05 +0200
Message-ID: <0c78010d9f06e2bfc8136c1ac11d5bc107a7043a.1434206062.git.mhagger@alum.mit.edu>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 16:42:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3mdz-0007iJ-PB
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 16:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbbFMOme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 10:42:34 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:59754 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753103AbbFMOm2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 10:42:28 -0400
X-AuditID: 12074411-f796c6d000000bc9-cd-557c414d72df
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.41.03017.D414C755; Sat, 13 Jun 2015 10:42:21 -0400 (EDT)
Received: from michael.fritz.box (p5DDB10EE.dip0.t-ipconnect.de [93.219.16.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5DEgGpQ026136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 13 Jun 2015 10:42:20 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434206062.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqOvrWBNqcGueikXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M34sfcdUsJq14kbXHfYGxnUsXYycHBICJhLLVzyDssUkLtxbz9bFyMUhJHCZUaLl0RIo
	5wSTxMK3/cwgVWwCuhKLepqZQGwRATWJiW2HWECKmAU6GCUuLN/GDpIQFrCVuPjrCCOIzSKg
	KjF52gw2EJtXIEpi25fTUOvkJM4f/wk0lIODU8BC4mVTJkhYSMBc4u2KdtYJjLwLGBlWMcol
	5pTm6uYmZuYUpybrFicn5uWlFuma6uVmluilppRuYoSElOAOxhkn5Q4xCnAwKvHwZsRWhwqx
	JpYVV+YeYpTkYFIS5Y3cAxTiS8pPqcxILM6ILyrNSS0+xCjBwawkwiuoXRMqxJuSWFmVWpQP
	k5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4JV2AGoULEpNT61Iy8wpQUgzcXCCDOeS
	EilOzUtJLUosLcmIB8VGfDEwOkBSPEB7Z4K08xYXJOYCRSFaTzHqciz4cXstkxBLXn5eqpQ4
	bzhIkQBIUUZpHtwKWAJ5xSgO9LEwrwdIFQ8w+cBNegW0hAloSXtPFciSkkSElFQDY6QHyz2f
	s1sE7xuqZ8dFzr77/XvW6p9dKj/M/hj6u7z1u+h08dmGymN75Fcub8iKmjxXZs29E83bHgjN
	OBwv8XV5aIQMn/GUW7Nj+q8k3DIsr0mauG9l49M1QW/KmrXmeL5d0t+0au/coC6+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271550>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index f4a6ec9..53b8e13 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -756,8 +756,7 @@ static int remove_branches(struct string_list *branches)
 	strbuf_release(&err);
 
 	for (i = 0; i < branches->nr; i++) {
-		struct string_list_item *item = branches->items + i;
-		const char *refname = item->string;
+		const char *refname = branches->items[i].string;
 
 		if (delete_ref(refname, NULL, 0))
 			result |= error(_("Could not remove branch %s"), refname);
-- 
2.1.4
