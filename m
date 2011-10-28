From: mhagger@alum.mit.edu
Subject: [PATCH v2 03/12] parse_ref_line(): add a check that the refname is properly formatted
Date: Fri, 28 Oct 2011 13:27:55 +0200
Message-ID: <1319801284-15625-4-git-send-email-mhagger@alum.mit.edu>
References: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 13:28:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJkc7-0002WA-Df
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 13:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427Ab1J1L2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 07:28:34 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:54969 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab1J1L2N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 07:28:13 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJkVI-0007Cx-FE; Fri, 28 Oct 2011 13:21:40 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184370>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 7191437..080e277 100644
--- a/refs.c
+++ b/refs.c
@@ -50,6 +50,9 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 		return NULL;
 	line[len] = 0;
 
+	if (check_refname_format(line, REFNAME_ALLOW_ONELEVEL))
+		return NULL;
+
 	return line;
 }
 
-- 
1.7.7
