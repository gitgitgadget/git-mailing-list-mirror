From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 6/6] xdiff/xprepare.c: reduce scope of variables
Date: Wed, 16 Apr 2014 02:33:31 -0700
Message-ID: <1397640811-17719-6-git-send-email-gitter.spiros@gmail.com>
References: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 11:34:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaMEU-0005ya-HN
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 11:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbaDPJeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 05:34:03 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:54314 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043AbaDPJds (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 05:33:48 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so10482619pdj.22
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NoUBzVeW96khFYUoaT68DkH0ShAHhfP4OTzScUHVfhs=;
        b=djyi6Wv+bkGJOloregcvEoKtqlyfV6r3zQhvk7iofgScXWjft9cf71Za8NajuOVyCD
         E1sDUvKOM54ZIs7+AVx5+XBKbeLRDUJxSrFOAfc/UilnupRnRtuHoSq1q+SBDx2lN/to
         AQOUVoS2812G+J2xxLT7fYhbyn/wn4Xc3PyzfNc7rDRm6qhT8KvoAYcAOtEjCjWhYYTl
         1phcehut5Y5aKdeDthkVF3WViGfc02bIKHHORIcJu1gIIAo08mXX7L3Iz5j3J0gaRE/K
         sOo8lY4FdJTDYMXHjs8+FZkU5cbgnJU3UGkQ5D7DkZxDgOARdkA0eY3Sv/PKn+7pNDd4
         lHSg==
X-Received: by 10.66.233.9 with SMTP id ts9mr7338097pac.37.1397640827269;
        Wed, 16 Apr 2014 02:33:47 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id de5sm45687493pbc.66.2014.04.16.02.33.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 02:33:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246323>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 xdiff/xprepare.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 63a22c6..e0b6987 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -161,8 +161,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
 	unsigned int hbits;
 	long nrec, hsize, bsize;
-	unsigned long hav;
-	char const *blk, *cur, *top, *prev;
+	char const *blk, *cur, *prev;
 	xrecord_t *crec;
 	xrecord_t **recs, **rrecs;
 	xrecord_t **rhash;
@@ -193,7 +192,9 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize)) != NULL) {
+                char const *top;
 		for (top = blk + bsize; cur < top; ) {
+                        unsigned long hav;
 			prev = cur;
 			hav = xdl_hash_record(&cur, top, xpp->flags);
 			if (nrec >= narec) {
-- 
1.7.10.4
