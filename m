From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/9] sparse: Fix some "Using plain integer as NULL pointer"
 warnings
Date: Thu, 07 Apr 2011 19:24:57 +0100
Message-ID: <4D9E0179.60306@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 21:12:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7ucq-0000vz-7q
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 21:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756695Ab1DGTML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 15:12:11 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:59570 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756680Ab1DGTMK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 15:12:10 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1Q7uKI-0002UU-gZ; Thu, 07 Apr 2011 18:53:06 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171080>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 imap-send.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 9adf4b9..e1ad1a4 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1193,13 +1193,13 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 	if (!preauth) {
 #ifndef NO_OPENSSL
 		if (!srvc->use_ssl && CAP(STARTTLS)) {
-			if (imap_exec(ctx, 0, "STARTTLS") != RESP_OK)
+			if (imap_exec(ctx, NULL, "STARTTLS") != RESP_OK)
 				goto bail;
 			if (ssl_socket_connect(&imap->buf.sock, 1,
 					       srvc->ssl_verify))
 				goto bail;
 			/* capabilities may have changed, so get the new capabilities */
-			if (imap_exec(ctx, 0, "CAPABILITY") != RESP_OK)
+			if (imap_exec(ctx, NULL, "CAPABILITY") != RESP_OK)
 				goto bail;
 		}
 #endif
-- 
1.7.4
