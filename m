From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] OPTION_CMDMODE should be used when not accept an argument, and OPTION_NUMBER is of special type. So change the mode to OPTION_CMDMODE
Date: Fri, 28 Feb 2014 22:29:25 +0800
Message-ID: <1393597765-14164-1-git-send-email-sunheehnus@gmail.com>
Cc: mhagger@alum.mit.edu, Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 15:31:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJOT8-0004Yv-OY
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbaB1ObO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 09:31:14 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:52677 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbaB1ObN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 09:31:13 -0500
Received: by mail-pb0-f44.google.com with SMTP id rp16so820962pbb.31
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 06:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rN6AiaB7b9zTk/iT3S2vNI8Gsbr+aDhi0JOzJsga/2k=;
        b=m4wwNpf0JNbe2lKetzHkeRnGd25MQzCao2YPIxV+sZ9uSY7aS5NRa1Q2BzWPHyUNd/
         ZhR3CNtjsPOLbOPfNiOYh2xB1W6xcJCjG1gQv3kSfv1FcB824thCnIG2bF1LdN8bXe6n
         TOLBzhtAd+JwWjnpZWE6ducodLqxdRCVmM9WSm66GTi4JTpGxYLkHJk6qeAfQT+MarCC
         GNkL9Xjg5A2MFm6PGUTYif0x496b5BhstYmSQGlO7CMey/NjQXglldWAH0I+IvGVvbLz
         hKLUu1qefwk/LYoHogbt43LsIXKYTYHsBBAXAMvWj6kzdgfmG+zWp+N86GJV36dcgeSu
         ddbw==
X-Received: by 10.68.34.6 with SMTP id v6mr3795034pbi.61.1393597873197;
        Fri, 28 Feb 2014 06:31:13 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id fk4sm14926776pab.23.2014.02.28.06.31.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2014 06:31:12 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242965>

Signed-off-by: Sun He <sunheehnus@gmail.com>
---
 parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 7b8d3fa..59a52b0 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -371,7 +371,7 @@ static void parse_options_check(const struct option *opts)
 		case OPTION_NEGBIT:
 		case OPTION_SET_INT:
 		case OPTION_SET_PTR:
-		case OPTION_NUMBER:
+		case OPTION_CMDMODE:
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
 			    !(opts->flags & PARSE_OPT_NOARG))
 				err |= optbug(opts, "should not accept an argument");
-- 
1.9.0.138.g2de3478.dirty
---
I came across this protential bug.
According to parse-options.h OPTION_CMDMODE is an option with noarguments and OPTION_NUMBER is special type option.

Thanks,
He Sun
