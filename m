From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/3] refs.c: free duplicate entries in the ref array instead of leaking them
Date: Fri,  7 Oct 2011 22:20:22 -0500
Message-ID: <5WORKOGzj9pUA6-WazYHWrx23BzZNuzssM-BrpbAt7jziy1qExfJm7by5NnJUMOk6ewCveYCPmzYGScMzowqtqJ8RZ9pZP6PRSU69BNSzr2gzdZ7nKtDsZyIEWyAD9p9GiIdHbxCa0M@cipher.nrlssc.navy.mil>
References: <3k7giKa3PkJZo51iAXivXCFEZpYY2WC3depjtuvksrCQPax7dSLVCXpMlqLxWtZfSp6P10yMhMg@cipher.nrlssc.navy.mil>
Cc: julian@quantumfyre.co.uk, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 05:21:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCNTR-0002NB-8p
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 05:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143Ab1JHDVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 23:21:06 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:52802 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754034Ab1JHDVE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 23:21:04 -0400
Received: by mail3.nrlssc.navy.mil id p983L0Cn006472; Fri, 7 Oct 2011 22:21:00 -0500
In-Reply-To: <3k7giKa3PkJZo51iAXivXCFEZpYY2WC3depjtuvksrCQPax7dSLVCXpMlqLxWtZfSp6P10yMhMg@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 08 Oct 2011 03:21:00.0370 (UTC) FILETIME=[4D692B20:01CC8569]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183137>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 refs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index cbc4c5d..df39297 100644
--- a/refs.c
+++ b/refs.c
@@ -94,6 +94,7 @@ static void sort_ref_array(struct ref_array *array)
 				die("Duplicated ref, and SHA1s don't match: %s",
 				    a->name);
 			warning("Duplicated ref: %s", a->name);
+			free(b);
 			continue;
 		}
 		i++;
-- 
1.7.7
