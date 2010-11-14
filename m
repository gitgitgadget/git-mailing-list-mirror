From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 002/160] Makefile: Set NO_GETTEXT=YesPlease on Windows & MinGW
Date: Sun, 14 Nov 2010 15:07:24 +0000
Message-ID: <1289747245-23263-2-git-send-email-avarab@gmail.com>
References: <1289747245-23263-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 16:08:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHeBr-0008Ge-Bx
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 16:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab0KNPIM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 10:08:12 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40937 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701Ab0KNPIK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 10:08:10 -0500
Received: by wwb29 with SMTP id 29so498242wwb.1
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 07:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Z49K8vG4TQ35TcQjODNCd2zUbWqfiOyxDjiOuW0yIW4=;
        b=fGtxPqf09fYIwgapgMgC31rV2kBAL9ohggdfIm4c9eVPN9iKzsnIytvKc4neCGkJT3
         x/XKH5iz/FwkAkxWcES19eDzPR02SU2biGiCwAvv/50aaOo4kzdMFp4GKwXKW4a5JrSN
         rUnHVc1PsITr6T8hLd/FOM/zBcy8AlsQDS2Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=v7DHfcs5SwCBJUPYa+7oIwIjLOvO8hE4lqD9zCDzttkHHJWtZt6EENQm+2+KTsnoaq
         VnUx0CjMvGYsAMrWCNvKqTR87CTfx/fw5L3l8Ya0iZ5LBDLMWj9cEC532/UAxG6CLljn
         xTLDnT6PreNRjGcPndqBQZiwFKd/M/R5Antwg=
Received: by 10.216.20.133 with SMTP id p5mr5429398wep.95.1289747288154;
        Sun, 14 Nov 2010 07:08:08 -0800 (PST)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e12sm3208820wer.12.2010.11.14.07.08.07
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 07:08:07 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.326.g36065a
In-Reply-To: <1289747245-23263-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161416>

Change the Windows and MinGW build defaults to not build the gettext
tools by default. Gettext hasn't yet been ported to the default
environments on those systems, although Erik Faye-Lund is working on
MinGW support.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 426e0b1..67d94d3 100644
--- a/Makefile
+++ b/Makefile
@@ -826,6 +826,8 @@ ifeq ($(uname_S),Windows)
 	NO_REGEX =3D YesPlease
 	NO_CURL =3D YesPlease
 	NO_PYTHON =3D YesPlease
+	NO_GETTEXT =3D YesPlease
+	NEEDS_LIBINTL =3D
 	BLK_SHA1 =3D YesPlease
 	NATIVE_CRLF =3D YesPlease
=20
@@ -878,6 +880,8 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	OBJECT_CREATION_USES_RENAMES =3D UnfortunatelyNeedsTo
 	NO_REGEX =3D YesPlease
 	NO_PYTHON =3D YesPlease
+	NO_GETTEXT =3D YesPlease
+	NEEDS_LIBINTL =3D
 	BLK_SHA1 =3D YesPlease
 	ETAGS_TARGET =3D ETAGS
 	COMPAT_CFLAGS +=3D -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnm=
atch -Icompat/win32
--=20
1.7.2.3
