From: tboegi@web.de
Subject: [PATCH v1 5/6] convert: auto_crlf=false and no attributes set: same as binary
Date: Tue,  2 Feb 2016 17:53:14 +0100
Message-ID: <1454431994-2097-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 17:52:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQeBx-0003F9-6J
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 17:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756644AbcBBQwe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2016 11:52:34 -0500
Received: from mout.web.de ([212.227.15.14]:58997 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754263AbcBBQwV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 11:52:21 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LtXDY-1a1Aiu1eU8-010wZ8; Tue, 02 Feb 2016 17:52:20
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:w7N/cLBAa6VPWux9TMJNDkkkn9D6xbmOucqLu8mvl3VrAPjXXfy
 RciqTZZS2ROOS7Z5BZMqjltgLkhwd5cIcGCNBICvMAENWu/7qDWg3J3sejVTpiPa8JtXgpf
 5JpEI7dmyvu6j+rhNQ1NWh9aDbRd0lKNNdMpaADMvLMlIgeCEPL5/kKPMiHQzPX0ANl/lRo
 UwTXahhkg6m2vBiidXQwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pXEfj9dodXo=:okzd4iQV+/lFZL9hyxxC/O
 1Vo1yFcSbGudLR5PJ17NjJvE8oFqHlg1RIcS+hrIwiV4+5xeSDqENzsAUO9d8xG17vBIPiMK+
 yuMvF6KGYi6vvRGSZB8UrDThtk3xj00KmC0NbG1gzK78ugQnZ/eRDANPL/xIsV2UycKNPO4Ow
 HqOxaOVdIir7ZN2mNGd2t7ZqADpl8/CBypqIq57B0WulsGLglyqI77qOBVexHTZRh1ducf429
 CsSySNz2+P7IlgsK0aRsYApS0W80A2XocuUWzH1KVvmzFVysJgbhuJrJUD4oK2L+B2kCAgY+h
 SI596RSgUp/40S8oaO172PtR8hcGrECJ7wev7lXP42n1IKyqTg6ne24bzeOIIOJztmFA42OiG
 ZScyJHuy+DZu/qidb5iQYs6bZ7oAaRSVj3u/qI1+VRn0L2POTaio3N+/YO0pmXlA7bTZ/CDeq
 Xw2u8mwZmxhmpDMCQASR4hUCkfpmCXRrMtoGdsomHb6qSPKdYNnkGUlAolwvy5RmqiXL04r8f
 W0XMAMMnDzc7UEN1WI+slnEGfcnE7LxPLOIo5OAgjF5MBoPVgp1lFVnhzOUJmuLdzTFbMqqd7
 vwWYKxvd/3yCWc+Aft01NcTOfNuxhnslc57+IFdGazTQfQunw/1aXuW8mtP9eV4cxQ/nWtuu3
 VQLUjd/4Vpw945C2phk61Q0r2OGQkb601vMIB2h3D/XRII1TVbkWQ/YlpoE0B0x3bf6VsrPX6
 0V/W5LDS7rJNUGSSPX/oRro/W25eB3NMcVruYbxPbqt+GPizdAr68Z5hfDNsjXjaJ2B/Bcws 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285278>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

When core.autocrlf is set to false, and no attributes are set, the file
is treated as binary.
Simplify the logic and remove duplicated code when dealing with
(crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALSE) by =
setting
crlf_action=3DCRLF_BINARY already in convert_attrs().

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/convert.c b/convert.c
index a5701a1..50bdc42 100644
--- a/convert.c
+++ b/convert.c
@@ -235,7 +235,6 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 	char *dst;
=20
 	if (crlf_action =3D=3D CRLF_BINARY ||
-	    (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALS=
E) ||
 	    (src && !len))
 		return 0;
=20
@@ -798,6 +797,8 @@ static void convert_attrs(struct conv_attrs *ca, co=
nst char *path)
 		ca->crlf_action =3D CRLF_GUESS;
 		ca->ident =3D 0;
 	}
+	if (ca->crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_F=
ALSE)
+		ca->crlf_action =3D CRLF_BINARY;
 }
=20
 int would_convert_to_git_filter_fd(const char *path)
@@ -1382,8 +1383,7 @@ struct stream_filter *get_stream_filter(const cha=
r *path, const unsigned char *s
=20
 	crlf_action =3D ca.crlf_action;
=20
-	if ((crlf_action =3D=3D CRLF_BINARY) || (crlf_action =3D=3D CRLF_INPU=
T) ||
-	    (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALS=
E))
+	if ((crlf_action =3D=3D CRLF_BINARY) || (crlf_action =3D=3D CRLF_INPU=
T))
 		filter =3D cascade_filter(filter, &null_filter_singleton);
=20
 	else if ((crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUE=
SS))
--=20
2.7.0.303.g2c4f448.dirty
