From: mhagger@alum.mit.edu
Subject: [RFC 09/13] new_branch(): verify that new branch name is a valid full refname
Date: Wed, 19 Oct 2011 22:55:12 +0200
Message-ID: <1319057716-28094-10-git-send-email-mhagger@alum.mit.edu>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:55:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdB4-0003da-2O
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 22:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab1JSUzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 16:55:25 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:60910 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab1JSUzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 16:55:25 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4e-000423-UZ; Wed, 19 Oct 2011 22:49:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183953>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Is it possible to omit the REFNAME_ALLOW_ONELEVEL option from this
call?

 fast-import.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 8d8ea3c..51cf898 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -722,7 +722,7 @@ static struct branch *new_branch(const char *name)
 
 	if (b)
 		die("Invalid attempt to create duplicate branch: %s", name);
-	if (check_refname_format(name, REFNAME_ALLOW_ONELEVEL))
+	if (check_refname_format(name, REFNAME_FULL|REFNAME_ALLOW_ONELEVEL))
 		die("Branch name doesn't conform to GIT standards: %s", name);
 
 	b = pool_calloc(1, sizeof(struct branch));
-- 
1.7.7
