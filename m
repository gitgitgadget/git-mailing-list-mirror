From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 3/3] Trivial optimization
Date: Mon, 10 Oct 2005 13:50:34 -0700
Message-ID: <434AD41A.2040903@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020103090802010700010107"
X-From: git-owner@vger.kernel.org Mon Oct 10 22:55:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP4ba-0005TH-VS
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 22:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVJJUuj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 16:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVJJUuj
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 16:50:39 -0400
Received: from terminus.zytor.com ([192.83.249.54]:24542 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751224AbVJJUui
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 16:50:38 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9AKoaKP006967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Oct 2005 13:50:36 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9930>

This is a multi-part message in MIME format.
--------------020103090802010700010107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------020103090802010700010107
Content-Type: text/x-patch;
 name="03-git-dir-environment-is-always-a-string-literal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-git-dir-environment-is-always-a-string-literal.patch"

GIT_DIR_ENVIRONMENT is always a string literal

---
commit db6b7c2ba5e59184de22c55b36c21b5ef94da325
tree dc809b653f9d7dcfa096ca763987ccb0e87599ba
parent 16e46159b554116a7d95a206913fcdf7e79e07d0
author Peter Anvin <hpa@tazenda.sc.orionmulti.com> Mon, 10 Oct 2005 12:33:51 -0700
committer Peter Anvin <hpa@tazenda.sc.orionmulti.com> Mon, 10 Oct 2005 12:33:51 -0700

 rsh.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/rsh.c b/rsh.c
index 8278eab..64c4809 100644
--- a/rsh.c
+++ b/rsh.c
@@ -73,8 +73,7 @@ int setup_connection(int *fd_in, int *fd
 	posn = command;
 	of = 0;
 	of |= add_to_string(&posn, &sizen, "env ", 0);
-	of |= add_to_string(&posn, &sizen, GIT_DIR_ENVIRONMENT, 0);
-	of |= add_to_string(&posn, &sizen, "=", 0);
+	of |= add_to_string(&posn, &sizen, GIT_DIR_ENVIRONMENT "=", 0);
 	of |= add_to_string(&posn, &sizen, path, 1);
 	of |= add_to_string(&posn, &sizen, " ", 0);
 	of |= add_to_string(&posn, &sizen, remote_prog, 1);

--------------020103090802010700010107--
