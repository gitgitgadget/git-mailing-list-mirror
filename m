From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCH 2/2] Documentation: git-send-email: correct statement about standard ports
Date: Thu, 30 Jul 2009 17:08:54 -0600
Message-ID: <1248995334-28545-2-git-send-email-wjl@icecavern.net>
References: <1248995334-28545-1-git-send-email-wjl@icecavern.net>
Cc: "Wesley J. Landaker" <wjl@icecavern.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 01:20:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWeux-0002u8-9f
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 01:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbZG3XTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 19:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbZG3XTj
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 19:19:39 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:49247 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753160AbZG3XTi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 19:19:38 -0400
Received: from jenova.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 9A01336240;
	Fri, 31 Jul 2009 01:09:00 +0200 (CEST)
Received: from tonberry.icecavern.net (tonberry.icecavern.net [10.0.0.9])
	by jenova.icecavern.net (Postfix) with ESMTP id F382274C004;
	Thu, 30 Jul 2009 17:08:58 -0600 (MDT)
Received: by tonberry.icecavern.net (Postfix, from userid 1000)
	id ED61E2FD8C; Thu, 30 Jul 2009 17:08:58 -0600 (MDT)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1248995334-28545-1-git-send-email-wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124487>

The current documentation states that servers typically listen on port
465 and calls this "ssmtp". While it's true that many mail servers use
port 465 for SSL smtp, this is non-standard, and hails from the days
before smtp and submission TLS support, that arrived in RFC2487 and
RFC3207. Port 465 is actually assigned by IANA for unrelated purposes,
and is mostly still used by mail servers today only to support Outlook
Express.

In any case, this patch helps the documentation better reflect both
standards and reality, while still helpfully mentioning ports numbers
that a user may wish to specify.

Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
---
 Documentation/git-send-email.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 1c94351..6415d94 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -142,8 +142,9 @@ user is prompted for a password while the input is masked for privacy.
 
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
-	servers typically listen to smtp port 25 and ssmtp port
-	465); symbolic port names (e.g. "submission" instead of 587)
+	servers typically listen to smtp port 25, but may also listen to
+	submission port 587, or a non-standard SSL smtp port like 465);
+	symbolic port names (e.g. "submission" instead of 587)
 	are also accepted. The port can also be set with the
 	'sendemail.smtpserverport' configuration variable.
 
-- 
1.6.3.1
