From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 18/22] resolve_ref(): verify that the input refname has the right format
Date: Thu, 15 Sep 2011 23:10:39 +0200
Message-ID: <1316121043-29367-19-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:18:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JKj-00010Q-OI
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934982Ab1IOVSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:18:49 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40167 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934922Ab1IOVSt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:18:49 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J92-00019o-0a; Thu, 15 Sep 2011 23:06:52 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181509>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index b055501..ee3e0cc 100644
--- a/refs.c
+++ b/refs.c
@@ -504,6 +504,9 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 	if (flag)
 		*flag = 0;
 
+	if (check_refname_format(ref, REFNAME_ALLOW_ONELEVEL))
+		return NULL;
+
 	for (;;) {
 		char path[PATH_MAX];
 		struct stat st;
-- 
1.7.6.8.gd2879
