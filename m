From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] OPTION_NUMBER should be replaced by OPTION_CMDMODE
Date: Fri, 28 Feb 2014 23:24:08 +0800
Message-ID: <1393601048-16500-1-git-send-email-sunheehnus@gmail.com>
Cc: mhagger@alum.mit.edu, pclouds@gmail.com,
	Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 16:25:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJPJp-0000Ft-0E
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 16:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbaB1PZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 10:25:41 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:50731 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbaB1PZk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 10:25:40 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so871072pde.10
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 07:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iaIMqk7lqWR4LFr1TNcPC0AzYcNS4sOYWZqWbhlyQLY=;
        b=vbIOO/Jt8qo9opPBKZJJEWv0xlUwKIkX6tSnR6kY3HSlROkUQSx9v4z5u4fNKGNq6S
         fPEo2Ue8/X+0GpSn7HeoQUVQbdMG6I4E9W+tihJfrNFTSR/m43WS90LuJULQ4EOecA8j
         06gZklMv5HAc5VdE0DevnBNavuLs68W2upXyjx3BKGTcg+HuT/33y07nHl3RkHMcUlxy
         Zo30f+r1PICpalwsJZzT10Zdd5RZlBx0USDXTwt++h/1avIJW0RjX2w+jaeJ5U+AaoGE
         coOEbymkjfDoP93qu6vapu58zU1j3GF6yFsQ6AUPVk5qnW8zR2BPJ1bWZqkuOVMb3IZe
         Q4Og==
X-Received: by 10.68.143.100 with SMTP id sd4mr4309882pbb.0.1393601140197;
        Fri, 28 Feb 2014 07:25:40 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id un5sm16012428pab.3.2014.02.28.07.25.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2014 07:25:39 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242975>

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
I came I came across this protential bug.
According to parse-options.h OPTION_CMDMODE is an option with noarguments and OPTION_NUMBER is special type option

Thanks,
He Sun
