From: dsp@php.net
Subject: [PATCH] checkout: squelch "'mode' may be used uninitialized in this function" warning
Date: Tue,  1 May 2012 00:39:27 +0200
Message-ID: <1335825567-7831-1-git-send-email-dsp@php.net>
Cc: David Soria Parra <dsp@php.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 00:46:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOzMc-0002P1-0F
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 00:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756886Ab2D3Wqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 18:46:31 -0400
Received: from config.schlueters.de ([217.114.211.66]:44894 "EHLO
	config.schlueters.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756673Ab2D3Wqa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 18:46:30 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Apr 2012 18:46:30 EDT
Received: from localhost.localdomain (p4FDB6A24.dip.t-dialin.net [79.219.106.36])
	by config.schlueters.de (Postfix) with ESMTPA id 06D3C61645;
	Tue,  1 May 2012 00:39:37 +0200 (CEST)
X-Mailer: git-send-email 1.7.8.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196623>

From: David Soria Parra <dsp@php.net>

Use a 'fake' initialization for the 'mode' variable to work around a
GCC warning as in 5a7a367. The necessary condition to initialize 'mode'
will always be true but cannot be checked by the compiler.

Signed-off-by: David Soria Parra <dsp@php.net>
---
 builtin/checkout.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 84d3eb3..6b8bf31 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -157,7 +157,7 @@ static int checkout_merged(int pos, struct checkout *state)
 	unsigned char sha1[20];
 	mmbuffer_t result_buf;
 	unsigned char threeway[3][20];
-	unsigned mode;
+	unsigned mode = mode;
 
 	memset(threeway, 0, sizeof(threeway));
 	while (pos < active_nr) {
-- 
1.7.8.GIT
