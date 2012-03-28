From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] config: remove useless assignment
Date: Wed, 28 Mar 2012 22:18:37 +0200
Message-ID: <4F73721D.4010808@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:18:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzKV-000615-7V
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347Ab2C1USq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 16:18:46 -0400
Received: from india601.server4you.de ([85.25.151.105]:33545 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758331Ab2C1USp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 16:18:45 -0400
Received: from [192.168.2.105] (p579BEDD3.dip.t-dialin.net [87.155.237.211])
	by india601.server4you.de (Postfix) with ESMTPSA id E690B2F8038;
	Wed, 28 Mar 2012 22:18:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120312 Thunderbird/11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194184>

v1.7.9-8-g270a344 (config: stop using config_exclusive_filename) replaced
config_exclusive_filename with given_config_file.  In one case this
resulted in a self-assignment, which is reported by clang as a warning.
Remove the useless code.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/config.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d41a9bf..33c8820 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -397,8 +397,6 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 				xstrdup(prefix_filename(prefix,
 							strlen(prefix),
 							given_config_file));
-		else
-			given_config_file = given_config_file;
 	}
 
 	if (respect_includes == -1)
-- 
1.7.9.2
