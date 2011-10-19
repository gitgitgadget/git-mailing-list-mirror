From: mhagger@alum.mit.edu
Subject: [RFC 06/13] strbuf_check_branch_ref(): use check_refname_format(..., REFNAME_FULL)
Date: Wed, 19 Oct 2011 22:55:09 +0200
Message-ID: <1319057716-28094-7-git-send-email-mhagger@alum.mit.edu>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:55:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdAp-0003UG-76
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 22:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923Ab1JSUz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 16:55:28 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:60902 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab1JSUzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 16:55:24 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4e-000423-OO; Wed, 19 Oct 2011 22:49:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183951>

From: Michael Haggerty <mhagger@alum.mit.edu>

The reference name should be a full one, so adjust the check
accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_name.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 03ffc2c..335da37 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -883,7 +883,7 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 	if (name[0] == '-')
 		return -1;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
-	return check_refname_format(sb->buf, 0);
+	return check_refname_format(sb->buf, REFNAME_FULL);
 }
 
 /*
-- 
1.7.7
