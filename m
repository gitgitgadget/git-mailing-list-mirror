From: mhagger@alum.mit.edu
Subject: [PATCH 03/12] parse_ref_line(): add a check that the refname is properly formatted
Date: Wed, 19 Oct 2011 23:44:43 +0200
Message-ID: <1319060692-27216-4-git-send-email-mhagger@alum.mit.edu>
References: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:45:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdwu-00006A-4z
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab1JSVpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:45:16 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33124 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570Ab1JSVpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:45:13 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGdqr-0004K1-FJ; Wed, 19 Oct 2011 23:39:05 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183972>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 431d3c6..752938c 100644
--- a/refs.c
+++ b/refs.c
@@ -51,6 +51,9 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 		return NULL;
 	line[len] = 0;
 
+	if (check_refname_format(line, REFNAME_ALLOW_ONELEVEL))
+		return NULL;
+
 	return line;
 }
 
-- 
1.7.7
