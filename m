From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWk=?= Ngoc Duy <pclouds@gmail.com>
Subject: [PATCH] Move all dashed form git commands to libexecdir
Date: Tue, 27 Nov 2007 23:04:23 +0700
Message-ID: <20071127160423.GA22807@laptop>
References: <20071127150229.GA14859@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 17:06:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix2vw-0000ug-AB
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 17:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758193AbXK0QEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 11:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758088AbXK0QEs
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 11:04:48 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:28437 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758006AbXK0QEr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 11:04:47 -0500
Received: by an-out-0708.google.com with SMTP id d31so219354and
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 08:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=gRD+VY+NoFB1PqbaCIkKeg1yzIBSSS6cUfzpYvMD4Zk=;
        b=LodrZQdmRA1WaqS027q2RYOIxUCi0TZrWkYuYlzsldAV/X51+67FT1SacUmGUH0ao+qIYACRngTHwUrDsMY2YEgGtUZtrNd/f0yvdUZv2Ek/J5X6A+O1I4/OAXqhbXMh356we5OSqHT75XolFM4BLZr819KQwAEexNsxM513oyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=IrnA1Jq+FQvGEkyBYGpFwZeCuSF5n7GQ58Uw4T3ZPNkqzqlKfOo2UioNLevOVbP8tMMRyXy6q0yYVkyK+SKqqFrSUpqa4n2IULbpMszQLiwPH/8AAWsXRGz0sG3iFN5klK8Km3ffZAJKibohgK3whaeVbiKlm5jnl6e2eyso7DU=
Received: by 10.100.252.16 with SMTP id z16mr6810177anh.1196179486243;
        Tue, 27 Nov 2007 08:04:46 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.249])
        by mx.google.com with ESMTPS id b7sm777648ana.2007.11.27.08.04.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2007 08:04:45 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 27 Nov 2007 23:04:23 +0700
Content-Disposition: inline
In-Reply-To: <20071127150229.GA14859@laptop>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66233>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Both configure and make-only ways should work now

 Makefile      |    2 +-
 config.mak.in |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 313f9a2..377d7be 100644
--- a/Makefile
+++ b/Makefile
@@ -154,7 +154,7 @@ STRIP ?=3D strip
=20
 prefix =3D $(HOME)
 bindir =3D $(prefix)/bin
-gitexecdir =3D $(bindir)
+gitexecdir =3D $(prefix)/libexec/git-core
 sharedir =3D $(prefix)/share
 template_dir =3D $(sharedir)/git-core/templates
 ifeq ($(prefix),/usr)
diff --git a/config.mak.in b/config.mak.in
index 11d256e..1db0338 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -11,7 +11,7 @@ TCLTK_PATH =3D @TCLTK_PATH@
 prefix =3D @prefix@
 exec_prefix =3D @exec_prefix@
 bindir =3D @bindir@
-#gitexecdir =3D @libexecdir@/git-core/
+gitexecdir =3D @libexecdir@/git-core/
 datarootdir =3D @datarootdir@
 template_dir =3D @datadir@/git-core/templates/
=20
--=20
1.5.3.GIT
