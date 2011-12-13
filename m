From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] Makefile: add 'help' target for target summary
Date: Tue, 13 Dec 2011 20:16:04 +0700
Message-ID: <1323782164-11759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 14:17:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaSEg-0007OA-Fy
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 14:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645Ab1LMNRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Dec 2011 08:17:13 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36252 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab1LMNRM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 08:17:12 -0500
Received: by iaeh11 with SMTP id h11so4767606iae.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 05:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Uf/n3ZTf4VSrXbDaATNsu71CfQlgjYOtEGbhrT8GnnM=;
        b=kwt9gfd/OkfDaQyHhhOzAixSOQgYH1sc3JIF+4MSH/DYcCUebHHjTiQ6Yd4qA80QEc
         Y9GSzUecnqEQR4KViFmS7vBrTJqejTiiDRHi4ZUqv0anHdS/qgSFd635g4P6Z/fAi/3r
         4lg25af4k8bkZ1a8N5H7B6XZt51TccK8MLV+E=
Received: by 10.50.36.230 with SMTP id t6mr19166487igj.83.1323782231749;
        Tue, 13 Dec 2011 05:17:11 -0800 (PST)
Received: from tre ([115.74.32.245])
        by mx.google.com with ESMTPS id x18sm8307299ibi.2.2011.12.13.05.17.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 05:17:10 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 13 Dec 2011 20:16:05 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187018>

I find this "make help" very helpful (at work, on a different
project). With this I don't have to crawl through Makefile when I need
something but cannot remember what's the target name. It should also
help discover new targets.

We may also have "make vars" (or something like that) that shows list
of user-configurable variables, basically a conversion of the big
comment block near the makefile's top into a printable target.

I don't work with this Makefile much, so this is just an idea. Anyone
up to turn it to something actually useful?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index ed82320..abf6cf9 100644
--- a/Makefile
+++ b/Makefile
@@ -2603,3 +2603,17 @@ profile-all: profile-clean
 	$(MAKE) CFLAGS=3D"$(PROFILE_GEN_CFLAGS)" all
 	$(MAKE) CFLAGS=3D"$(PROFILE_GEN_CFLAGS)" -j1 test
 	$(MAKE) CFLAGS=3D"$(PROFILE_USE_CFLAGS)" all
+
+.PHONY: help
+
+help:
+	@echo "test		Run the test suite"
+	@echo "coverage	Build git with coverage support"
+	@echo "cover_db	Generate coverage database from *.gcov"
+	@echo "cover_db_html	Generate coverage report"
+	@echo "profile-all	Build git with profiling support"
+	@echo "clean		Clean intermediate files"
+	@echo "distclean	Clean even more for dist packaging"
+	@echo "sparse		Run git with sparse"
+	@echo "cscope		Generate cscope symbol database"
+	@echo "check-docs	Check documentation"
--=20
1.7.8.36.g69ee2
