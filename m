From: Jeremy White <jwhite@winehq.org>
Subject: [PATCH] Generate a warning message if we find an unrecognized option.
Date: Mon, 08 Feb 2010 16:33:35 -0600
Organization: The Wine Project
Message-ID: <4B70913F.7060809@winehq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 23:53:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NecTy-0000D2-QW
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 23:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab0BHWx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 17:53:27 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:53283 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab0BHWxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 17:53:25 -0500
X-Greylist: delayed 1240 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2010 17:53:25 EST
Received: from jwhite.mn.codeweavers.com ([10.69.137.101] ident=jwhite)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <jwhite@winehq.org>)
	id 1Nec9s-0004Ty-W9
	for git@vger.kernel.org; Mon, 08 Feb 2010 16:32:45 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139330>

---
 imap-send.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 51f371b..885da22 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1360,6 +1360,7 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 		server.ssl_verify = git_config_bool(key, val);
 	else if (!strcmp("preformattedHTML", key))
 		server.use_html = git_config_bool(key, val);
+        else imap_info("Unknown imap configuration option '%s'\n", key);
 	return 0;
 }
 
-- 
1.7.0.rc2.1.gd78df.dirty
