From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/6] worktree: fix incorrect references to file "locked"
Date: Sat, 18 Jul 2015 19:10:55 -0700
Message-ID: <dfaad2ac35a59b93f1f650d3398c861abd84f289.1437271363.git.mhagger@alum.mit.edu>
References: <cover.1437271363.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 04:11:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGe52-0008Qc-4m
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 04:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbbGSCLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 22:11:41 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:62847 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752637AbbGSCLk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2015 22:11:40 -0400
X-AuditID: 1207440d-f79136d00000402c-56-55ab0759fd8e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.AE.16428.9570BA55; Sat, 18 Jul 2015 22:11:37 -0400 (EDT)
Received: from localhost.localdomain ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6J2BUOd011238
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jul 2015 22:11:36 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1437271363.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqBvJvjrUYN4xCYuuK91MFg29V5gt
	bq+Yz2zRPeUto8WZN42MDqwef99/YPLYOesuu8fFS8oeix94eXzeJBfAGsVtk5RYUhacmZ6n
	b5fAnbHx/l7WgqdcFWuP9LI1ML7l6GLk5JAQMJHY/GQiI4QtJnHh3nq2LkYuDiGBy4wSMw79
	ZYZw1jNJzLq2jB2kik1AV2JRTzMTiC0isIlRovV1PojNLOAgsflzI9AkDg5hAQ+JTbf8QMIs
	AqoSy08tB1vAKxAlceLBEVaIZXIS54//ZAaxOQUsJCa9amEDsYUEzCVuz/vHPIGRdwEjwypG
	ucSc0lzd3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU0k2MkIDi3cH4f53MIUYBDkYlHt4J31aF
	CrEmlhVX5h5ilORgUhLlLX0FFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCm8+4OlSINyWxsiq1
	KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBq8IG1ChYlJqeWpGWmVOCkGbi4AQZ
	ziUlUpyal5JalFhakhEPioz4YmBsgKR4gPa+YgXZW1yQmAsUhWg9xagoJc7rADJXACSRUZoH
	NxaWJl4xigN9Kcw7GaSdB5hi4LpfAQ1mAhrcuXoFyOCSRISUVANjv/8hzsaXn0PXHenhLjC1
	Unz2/Flstl37pZ6Aew+VlQ9ciTkT/WKf2WHGKnaLpmUeDy8d/8p6ZbespfzLH39L/D7zzNiU
	Vrcn5XzZ76eZrhsrFon/NPDRcgyIkvB2WtCs2esWdV/DZf/L2UL/2W4line1Hljd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274186>

The manpage referred to file "lock" in a couple of places. The file is
actually called "locked".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-worktree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 707dfd0..6cb3877 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -39,7 +39,7 @@ repository so that they do not get automatically pruned.
 
 If a linked working tree is stored on a portable device or network share
 which is not always mounted, you can prevent its administrative files from
-being pruned by creating a file named 'lock' alongside the other
+being pruned by creating a file named 'locked' alongside the other
 administrative files, optionally containing a plain text reason that
 pruning should be suppressed. See section "DETAILS" for more information.
 
@@ -167,7 +167,7 @@ performed manually, such as:
   warn if the worktree is dirty)
 - `mv` to move or rename a worktree and update its administrative files
 - `list` to list linked working trees
-- `lock` to prevent automatic pruning of administrative files (for instance,
+- `locked` to prevent automatic pruning of administrative files (for instance,
   for a worktree on a portable device)
 
 GIT
-- 
2.1.4
