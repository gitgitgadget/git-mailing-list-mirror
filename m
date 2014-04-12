From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 2/2] Makefile: allow static linking against libcurl
Date: Sat, 12 Apr 2014 16:15:02 -0700
Message-ID: <1397344502-23459-2-git-send-email-dborowitz@google.com>
References: <1397344502-23459-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 01:15:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ79C-0006zu-0S
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 01:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756719AbaDLXPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 19:15:18 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:40600 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655AbaDLXPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 19:15:16 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so6818299pbb.12
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 16:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bc7+luBi7zD/GkpBo9H2McyvB+3JsJGy/hr+wuonZ80=;
        b=eTZoZZXqHWYJOEmHuZtaChnaODDYpoI/n95EczrgPrgophfLs6wCfdHCLdRsEnP+zx
         9Qr8/iE94rM2DKtDTVWjPVPTCwpLQmuqJJCTf+eNnvw0ARdHW+V/uHha7pHUzhiPvc/d
         D8Uk8V87kBfTC07nUe8LbOqrrC69WxOKz52l/VDbS6bFb5dqSfcBMl5ghqPpJ0W486+G
         Ze2Apim6vJm3Nsl1sM8+mSYM+ujgOx5hqMszHU4hORFQ2TVp2I//ROWhIAL/SP4wDTO3
         f6bhuw//y0xZuk1msgEUTy+VeJ/TkYc+mfmntZvDz+4osNZbMRy1NHW6pnPlkdR2pJ7s
         zLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bc7+luBi7zD/GkpBo9H2McyvB+3JsJGy/hr+wuonZ80=;
        b=icrqfumvjxXtKD2hsO+7vJuVCQ9Gn9oH99LPewE00xNjyUoavIGkemm6n8gaRcKiJ1
         QRd4TmsDA9u1IbC2J3cUKY4u6hgW4p6Kb/n1lszB2+in3j2qHM6rNe8rMD0nuQNwK3v+
         Sg19GDoc/GMagonxa/vPLPQUsfvH7BxAjOufUm84Y/ZR5ZptHwNeo1pQLhBZ6RDqqOuO
         +zVQG9vLsj9aYfDDoIOcS5x9hQKYny0ZvdRjJNcHeL5rzRalRzHxXWfOYFeFxwD8Yntw
         Tkp/JZJBO6tfXceDQ1IfzezteqOb+VquhgUVneMaAaQAGYKd3pIT6miXsct4uZbTR7vY
         FlEA==
X-Gm-Message-State: ALoCoQkO/pfugZJbxZVQrYv0VMeGcoYbvmm2EFvLks07xAJfMjvHg8HgZfF7/+srGGUE1zvvczujQC7xicSIIsVd9f1PbyDtxZOPEmp3n3F6K44xGkkAJl5Qdy83NiAkclOJfJVJCK67PntZJh1phniYDU6LaJvj1TwpBevOlfR9dZ1xhmWOOZstR6+M80hYHEJGzV916VA6tW3uWfPDFMqH8YDHwOtgI2BB4sedDmPHwZHDIh8ISio=
X-Received: by 10.68.240.68 with SMTP id vy4mr31021pbc.127.1397344515522;
        Sat, 12 Apr 2014 16:15:15 -0700 (PDT)
Received: from serval.mtv.corp.google.com (serval.mtv.corp.google.com [172.27.69.27])
        by mx.google.com with ESMTPSA id wd2sm57023669pab.0.2014.04.12.16.15.13
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 16:15:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.423.g4596e3a
In-Reply-To: <1397344502-23459-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246203>

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d6330bc..3c151d3 100644
--- a/Makefile
+++ b/Makefile
@@ -37,6 +37,9 @@ all::
 # Define CURL_CONFIG to the path to a curl-config binary other than the
 # default 'curl-config'.
 #
+# Define CURL_STATIC to statically link libcurl.  Only applies if
+# CURL_CONFIG is used.
+#
 # Define CURLDIR=/foo/bar if your curl header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.  This overrides CURL_CONFIG,
 # but is less robust.
@@ -1139,7 +1142,11 @@ else
 	else
 		CURL_CONFIG ?= curl-config
 		BASIC_CFLAGS += $(shell $(CURL_CONFIG) --cflags)
-		CURL_LIBCURL = $(shell $(CURL_CONFIG) --libs)
+		ifdef CURL_STATIC
+			CURL_LIBCURL = $(shell $(CURL_CONFIG) --static-libs)
+		else
+			CURL_LIBCURL = $(shell $(CURL_CONFIG) --libs)
+		endif
 		ifeq "$(CURL_LIBCURL)" ""
 			$(error curl not detected; try setting CURLDIR)
 		endif
-- 
1.9.1.423.g4596e3a
