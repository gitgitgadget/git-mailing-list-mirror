From: Ivan Ukhov <ivan.ukhov@gmail.com>
Subject: [PATCH] parse-options: fix the description of defval
Date: Sun, 29 Mar 2015 10:32:55 +0200
Message-ID: <E8C3474A-5A3A-4A51-A798-84FB9AD46A9F@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2093\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 10:33:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yc8ed-0008GL-8R
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 10:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbbC2IdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 04:33:01 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33851 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbbC2Ic6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2015 04:32:58 -0400
Received: by lboc7 with SMTP id c7so31818898lbo.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2015 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=LZT9gbDahAoJwX4lLUpZ5HjAzSxGtnZCXUzKW34x5gE=;
        b=oHKJLQdfPF4SLAUvU3o98jdxn5bec/f5COiRTQms1v7t8VtuMH8ttwOOM5EC1ScZw6
         cxCtZlXS2B7hXhnO05YXTu6wStogoeHEf27l0Eu7bvRj6EBGfTYIT44zAaGKFCdTbbIS
         J2qFKYw1qPIUuGaY9TAFp4rLeJhRTgWByIKshhG7A7na9qo0mwXgdAfYWpSrxuvbJYmV
         O0ffvvQPYS4b8H0E3Y8XFtPTXDUSmc6IXHma3U5b8hAZxa0O1Jw7BQ/tTCZo5OUv9o+b
         AgSZGyj1fP27LezVl+3IK5YMvafWYGABaRHFjT8/K2RvegLsIGLnxXI63ZDugZdmHlvT
         XHqA==
X-Received: by 10.152.23.133 with SMTP id m5mr23945690laf.71.1427617976957;
        Sun, 29 Mar 2015 01:32:56 -0700 (PDT)
Received: from c-15c6e455.011-537-6c6b701.cust.bredbandsbolaget.se (c-15c6e455.011-537-6c6b701.cust.bredbandsbolaget.se. [85.228.198.21])
        by mx.google.com with ESMTPSA id mm7sm1338086lbb.30.2015.03.29.01.32.56
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Mar 2015 01:32:56 -0700 (PDT)
X-Mailer: Apple Mail (2.2093)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266431>

Since the deletion of OPT_SET_PTR, defval can no longer contain a pointer.

Signed-off-by: Ivan Ukhov <ivan.ukhov@gmail.com>
---
 parse-options.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index 7940bc7..c71e9da 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -95,8 +95,7 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *
  * `defval`::
  *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
- *   OPTION_{BIT,SET_INT} store the {mask,integer,pointer} to put in
- *   the value when met.
+ *   OPTION_{BIT,SET_INT} store the {mask,integer} to put in the value when met.
  *   CALLBACKS can use it like they want.
  */
 struct option {
--
1.8.4
