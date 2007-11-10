From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] for-each-ref: fix setup of option-parsing for --sort
Date: Sat, 10 Nov 2007 17:07:43 +0100
Message-ID: <1194710863-22868-1-git-send-email-hjemli@gmail.com>
References: <9e4733910711100610y478c62cend1d9af84e0ecc08b@mail.gmail.com>
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 17:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqsrw-0006Ux-MO
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 17:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXKJQHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 11:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbXKJQHO
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 11:07:14 -0500
Received: from mail46.e.nsc.no ([193.213.115.46]:46467 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718AbXKJQHN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 11:07:13 -0500
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id lAAG74Et026639;
	Sat, 10 Nov 2007 17:07:04 +0100 (MET)
X-Mailer: git-send-email 1.5.3.5.623.g0a1d
In-Reply-To: <9e4733910711100610y478c62cend1d9af84e0ecc08b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64355>

The option value for --sort is already a pointer to a pointer to struct
ref_sort, so just use it.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 builtin-for-each-ref.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index da8c794..e909e66 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -847,7 +847,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, "show only <n> matched refs"),
 		OPT_STRING(  0 , "format", &format, "format", "format to use for the output"),
-		OPT_CALLBACK(0 , "sort", &sort_tail, "key",
+		OPT_CALLBACK(0 , "sort", sort_tail, "key",
 		            "field name to sort on", &opt_parse_sort),
 		OPT_END(),
 	};
-- 
1.5.3.5.623.g0a1d
