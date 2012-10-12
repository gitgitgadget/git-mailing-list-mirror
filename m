From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v4 05/12] Integrate wildmatch to git
Date: Fri, 12 Oct 2012 09:27:50 +0200
Message-ID: <5077C676.3070209@viscovery.net>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com> <1349865651-31889-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 09:28:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMZf9-0000Aa-Q9
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 09:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782Ab2JLH1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 03:27:53 -0400
Received: from so.liwest.at ([212.33.55.24]:51752 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756563Ab2JLH1w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 03:27:52 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TMZew-0004ty-W1; Fri, 12 Oct 2012 09:27:51 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B61851660F;
	Fri, 12 Oct 2012 09:27:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1349865651-31889-6-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207532>

--- >8 ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] test-wildmatch: avoid exit code -1

Our bash on Windows does not recognize -1 as failure.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Please squash this in, in the next round.

 test-wildmatch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test-wildmatch.c b/test-wildmatch.c
index d716852..74c0864 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -4,11 +4,11 @@
 int main(int argc, char **argv)
 {
 	if (!strcmp(argv[1], "wildmatch"))
-		return wildmatch(argv[3], argv[2], 0);
+		return !!wildmatch(argv[3], argv[2], 0);
 	else if (!strcmp(argv[1], "iwildmatch"))
-		return wildmatch(argv[3], argv[2], FNM_CASEFOLD);
+		return !!wildmatch(argv[3], argv[2], FNM_CASEFOLD);
 	else if (!strcmp(argv[1], "fnmatch"))
-		return fnmatch(argv[3], argv[2], FNM_PATHNAME);
+		return !!fnmatch(argv[3], argv[2], FNM_PATHNAME);
 	else
 		return 1;
 }
-- 
1.8.0.rc2.1237.g5522246
