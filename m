From: skimo@liacs.nl
Subject: [PATCH 01/22] git_connect: unset CONFIG_ENVIRONMENT in child
Date: Thu, 24 May 2007 00:22:50 +0200
Message-ID: <11799589912029-git-send-email-skimo@liacs.nl>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:23:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzFC-0003Mx-77
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274AbXEWWXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756786AbXEWWXk
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:23:40 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33741 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756274AbXEWWXf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:35 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNBQV011546;
	Thu, 24 May 2007 00:23:16 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 4F6827DD9F; Thu, 24 May 2007 00:23:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48190>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 connect.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/connect.c b/connect.c
index 2f61ea3..8f8ff53 100644
--- a/connect.c
+++ b/connect.c
@@ -552,6 +552,7 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 		else {
 			unsetenv(ALTERNATE_DB_ENVIRONMENT);
 			unsetenv(DB_ENVIRONMENT);
+			unsetenv(CONFIG_ENVIRONMENT);
 			unsetenv(GIT_DIR_ENVIRONMENT);
 			unsetenv(GRAFT_ENVIRONMENT);
 			unsetenv(INDEX_ENVIRONMENT);
-- 
1.5.2.784.g5532e
