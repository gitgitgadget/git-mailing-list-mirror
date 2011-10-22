From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/2] credential-cache--daemon.c: unlink() a potentially stale
 unix socket
Date: Sat, 22 Oct 2011 18:25:52 +0100
Message-ID: <4EA2FCA0.70002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 22 19:30:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHfOm-0002NP-KE
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 19:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab1JVRaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 13:30:12 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:58283 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754291Ab1JVRaL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Oct 2011 13:30:11 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1RHfOZ-0004ua-f0; Sat, 22 Oct 2011 17:30:10 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184105>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 credential-cache--daemon.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index ee2c15a..c5fb1b2 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -230,6 +230,7 @@ static void serve_cache(const char *socket_path)
 {
 	int fd;
 
+	unlink(socket_path);
 	fd = unix_stream_listen(socket_path);
 	if (fd < 0)
 		die_errno("unable to bind to '%s'", socket_path);
-- 
1.7.7
