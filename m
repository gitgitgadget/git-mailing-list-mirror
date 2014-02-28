From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] parse-options.c:parse_options_check() change OPTION_NUMBER to OPTION_CMDMODE
Date: Fri, 28 Feb 2014 17:07:22 +0800
Message-ID: <1393578442-2822-1-git-send-email-sunheehnus@gmail.com>
Cc: Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:10:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJSm-00077F-GK
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbaB1JK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:10:27 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:35106 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaB1JKW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:10:22 -0500
Received: by mail-pb0-f53.google.com with SMTP id rp16so499999pbb.40
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 01:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gDo66yqSu6Y7nShXyNa7YOsx3DLXKB6X2wKeKm5XSew=;
        b=K2wOXn1mINQafJCdc+52spdg42LVBzWVOKrVyT/aEfhu/dmwkAwPmZ4L4xDAU0w8Tw
         3GpeI5qMaTnUbnEbU5YMbs/Sg3khLZe0sBBpczWAHxiJ8r2+OdUjWI2r7SdcHTSXS+H4
         VtfBQnGIbtxrr00zBvlvnasfcd7HH3+zionCHMOUgFshUvJvoqw+lrjQRF4onybfGL7t
         nLu+dgjevOPbbsfMEN3QWwCp/JwjDFEJFnDUjdCsQ7vktFZAwBfrRd4W8s9Y5folTAM4
         LKPaawv4xoeE3lspH0BANwk3kp+izFFs5bNPp8MdTsln+fN02KWxt8HO8579HOjSeqUE
         R0uw==
X-Received: by 10.68.103.97 with SMTP id fv1mr2349463pbb.64.1393578621727;
        Fri, 28 Feb 2014 01:10:21 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id sy2sm3890873pbc.28.2014.02.28.01.10.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2014 01:10:20 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242913>

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

Hi,
When I was reading code yesterday, I came across this protential bug.
parse-options.h says that OPTION_CMDMODE is an option with no arguments and OPTION_NUMBER is special type option.

According to the information the program says (Should not accept an argument), I think you should take this patch into consideration.
Thanks.

He Sun
