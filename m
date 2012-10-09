From: =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
Subject: [PATCH] configure.ac: Add missing comma to CC_LD_DYNPATH
Date: Tue,  9 Oct 2012 16:26:11 +0200
Message-ID: <1349792771-7936-1-git-send-email-sunny@sunbase.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stefano.lattarini@gmail.com, gitster@pobox.com,
	=?UTF-8?q? "=C3=98yvind=20A.=20Holm" ?= <sunny@sunbase.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 16:44:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLb2g-0002sE-Jj
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 16:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab2JIOoH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2012 10:44:07 -0400
Received: from smtp.domeneshop.no ([194.63.252.54]:47515 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab2JIOoG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 10:44:06 -0400
X-Greylist: delayed 1014 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2012 10:44:06 EDT
Received: from 77.19.187.42.tmi.telenormobil.no ([77.19.187.42] helo=localhost.localdomain)
	by smtp.domeneshop.no with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <sunny@sunbase.org>)
	id 1TLam3-0006Fy-Bo; Tue, 09 Oct 2012 16:27:07 +0200
X-Mailer: git-send-email 1.8.0.rc0.18.gf84667d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207321>

=46rom: "=C3=98yvind A. Holm" <sunny@sunbase.org>

40bfbde ("build: don't duplicate substitution of make variables",
2012-09-11) breaks make by removing a necessary comma at the end of
"CC_LD_DYNPATH=3D-rpath" in line 414.

When executing "./configure --with-zlib=3DPATH", this resulted in

      [...]
      CC xdiff/xhistogram.o
      AR xdiff/lib.a
      LINK git-credential-store
  /usr/bin/ld: bad -rpath option
  collect2: ld returned 1 exit status
  make: *** [git-credential-store] Error 1
  $

during make.

Signed-off-by: =C3=98yvind A. Holm <sunny@sunbase.org>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index da1f41f..c85888c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -411,7 +411,7 @@ else
       LDFLAGS=3D"${SAVE_LDFLAGS}"
    ])
    if test "$git_cv_ld_wl_rpath" =3D "yes"; then
-      CC_LD_DYNPATH=3D-Wl,-rpath
+      CC_LD_DYNPATH=3D-Wl,-rpath,
    else
       AC_CACHE_CHECK([if linker supports -rpath], git_cv_ld_rpath, [
          SAVE_LDFLAGS=3D"${LDFLAGS}"
--=20
1.8.0.rc0.18.gf84667d
