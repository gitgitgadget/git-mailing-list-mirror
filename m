From: mhagger@alum.mit.edu
Subject: [RFC 08/13] expand_namespace(): the refname is full, so use REFNAME_FULL option
Date: Wed, 19 Oct 2011 22:55:11 +0200
Message-ID: <1319057716-28094-9-git-send-email-mhagger@alum.mit.edu>
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
	id 1RGdB5-0003da-4G
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 22:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab1JSUz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 16:55:26 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:60909 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab1JSUzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 16:55:25 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4e-000423-Sc; Wed, 19 Oct 2011 22:49:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183955>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 environment.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/environment.c b/environment.c
index 0bee6a7..a6d6f04 100644
--- a/environment.c
+++ b/environment.c
@@ -107,7 +107,7 @@ static char *expand_namespace(const char *raw_namespace)
 		if (strcmp((*c)->buf, "/") != 0)
 			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
 	strbuf_list_free(components);
-	if (check_refname_format(buf.buf, 0))
+	if (check_refname_format(buf.buf, REFNAME_FULL))
 		die("bad git namespace path \"%s\"", raw_namespace);
 	strbuf_addch(&buf, '/');
 	return strbuf_detach(&buf, NULL);
-- 
1.7.7
