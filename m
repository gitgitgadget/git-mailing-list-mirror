From: mhagger@alum.mit.edu
Subject: [RFC 11/13] replace_object(): the refname is full, so use REFNAME_FULL option
Date: Wed, 19 Oct 2011 22:55:14 +0200
Message-ID: <1319057716-28094-12-git-send-email-mhagger@alum.mit.edu>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:00:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdFH-0005kD-OE
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038Ab1JSVAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:00:04 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:32775 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab1JSVAB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:00:01 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4f-000423-1J; Wed, 19 Oct 2011 22:49:17 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183959>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/replace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 517fa10..f5d4f77 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -94,7 +94,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 		     "refs/replace/%s",
 		     sha1_to_hex(object)) > sizeof(ref) - 1)
 		die("replace ref name too long: %.*s...", 50, ref);
-	if (check_refname_format(ref, 0))
+	if (check_refname_format(ref, REFNAME_FULL))
 		die("'%s' is not a valid ref name.", ref);
 
 	if (!resolve_ref(ref, prev, 1, NULL))
-- 
1.7.7
