Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F6C1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932626AbeASRew (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:34:52 -0500
Received: from sonic310.consmr.mail.bf2.yahoo.com ([74.6.135.253]:43563 "EHLO
        sonic310-17.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932527AbeASReW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jan 2018 12:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516383261; bh=CBBYyTt8GHNeoxT6kog35VG8dlbhBCuAESudH7fRobI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MYvmHEF3jGwOdA0Rg6vUStd8/mutmXWZqigiHmYM5lAVJA4ZYJ2jYofj6kEDTDtM0q88LcHXyUc8weA8lNMiWdEM1uF8+QvGLK5SXgZI1uVdDp/PvJ/PCDRfmHVpYIOwYu2uCsboHuye9F4mO3BgwDnbjhOc4IcCa9f0xKeXu91yWda1yb+UBKn2vEjx2atzAKgMgllud6ATBGnKviJdM1IrwWOBmFqp5jvBs3xK+Os6z9+6XVX6X2tPJVNf8PIXZf5ozQt+Hc/dkcGbV7CCqyHm6kz60cuJx3TBUeVJObjV6CiSiC20Mpf5p0FOPlH6TrrC5M6dj/AefoVltNmjbA==
X-YMail-OSG: OcwKA2IVM1nR685H_PgrSyORB1DBjADiHR2iOS3D42fMftF4oEjeb7tUV7NHTCn
 jdKmQIOQZJi4.ELN2KEeFDSwdyUNy3quJ4cvrtlSGffELUPDwjY0wsYszdbeeIVQtd8RJEfMwkUw
 Wkv4DuECOmldzqkvVPTNqUgDm88OT1fSt_l_m5X5.q2bq9X.O5cwi_wHQ7j_3plVJnLGK8lECJs9
 8C0wQx1EKV6iiUr7CAKSrm4C0z5W_G2ogOq.m1OTswnDC0S1HCldjnpaCQLfbmD1Et7HdSigwjtc
 HMqDY9kmtqIdbJKlJ2Rhqy3w6d2HVPGWIExbODAIA7cJbq_yCNDCPjLs4Uhkvhqo8AQPwkL6_Y4E
 W2BsyH6u4YWrpRWEGX41xlyOv5hakLffIy3YnSVrbbrjGWXAQdMD_WDk8osJmyd9NZceNKD9vIhE
 PFqZKRdEc.0Vxo2fSQhYhtlFJxMBIjR9XK_YcMooph.y9mZUNx4Pf5aikYeZ5.5w2pHkGLkoEoZ5
 u4QYg6Qr.Waw2bptLeS45Ve3qV.XKOnBdphY7vTSjb7Z3FqZWCw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jan 2018 17:34:21 +0000
Received: from smtpgate102.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([72.30.28.113])
          by smtp406.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID e78d06b6c08cf8709c5b5470ad5cf24d;
          Fri, 19 Jan 2018 17:34:19 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 2/6] Add tar extract install options override in installation processing.
Date:   Fri, 19 Jan 2018 12:34:02 -0500
Message-Id: <20180119173406.13324-4-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180119173406.13324-1-randall.s.becker@rogers.com>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

* Makefile: Add TAR_EXTRACT_OPTIONS to allow platform options to be
  specified if needed. The default is xof.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1a9b23b67..040e9eacd 100644
--- a/Makefile
+++ b/Makefile
@@ -429,6 +429,9 @@ all::
 # running the test scripts (e.g., bash has better support for "set -x"
 # tracing).
 #
+# Define TAR_EXTRACT_OPTIONS if you want to change the default behaviour
+# from xvf to something else during installation.
+#
 # When cross-compiling, define HOST_CPU as the canonical name of the CPU on
 # which the built Git will run (for instance "x86_64").
 
@@ -452,6 +455,7 @@ LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
+TAR_EXTRACT_OPTIONS = xof
 
 # Create as necessary, replace existing, make ranlib unneeded.
 ARFLAGS = rcs
@@ -2569,7 +2573,7 @@ install: all
 ifndef NO_GETTEXT
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
 	(cd po/build/locale && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xof -)
+	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) $(TAR_EXTRACT_OPTIONS) -)
 endif
 ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
-- 
2.16.0.31.gf1a482c

