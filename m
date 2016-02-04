From: tboegi@web.de
Subject: [PATCH v2 5/7] convert: auto_crlf=false and no attributes set: same as binary
Date: Thu,  4 Feb 2016 18:49:57 +0100
Message-ID: <1454608197-5456-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 18:49:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRO1w-0001cu-V8
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 18:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758068AbcBDRtO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 12:49:14 -0500
Received: from mout.web.de ([212.227.17.12]:64048 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137AbcBDRs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 12:48:56 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0McWj6-1aj3Qt1TaS-00Hinq; Thu, 04 Feb 2016 18:48:55
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:c6vYcEP//UQHpEKtn2Z60+zPwBhUVzNiwGHr1p6eh/xhemsjToV
 ebQSxwH8o0Q7TrqBkXokLmAJgnfWbI8+K3l6+RvatIerQfTmWdoiYZ//iRMxbCN/iz1eDsW
 pgirXi8FPLC/ye07M2JzmArm4SDCZNvxThOAoK4NfQi1TosA32UQ+oa/loF12MBXvJ9/OvG
 /diqd6MfhgNaQFylSBKaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b1sZbxy5MWo=:V43iRAnIMV/iZxrN4zfulA
 VPT/HnzfmMZ9YeYQphMi5HNAQx2ZuewkKs9ysQPdZgp5QbG1Ws0ZEtr8MqK/25XvHMxJg6DT5
 9GN2+4PsUHVYeeQjxsVzEye3Rvm3VZKomtv5c9CtcTUP/RolC7IaPqn5IEl4nJ1q38cQ8VxSM
 H8/Ex61s+/EP+9ySag1X90R2b9ABy3tgnxASxIYfsSUTzNC8/rGmfx1WAbW0CwSiVaLLJcoOD
 fkZ4mMTYTOUrSigKfNMtT6VwVnH3F4qZ+5PH6W4lEP+fPWVC72jKx3wTxCF5zvwfD7iaGD/eb
 fpakhdY4OxGUgf6NoRCjcVs+/UoY/cf7ZF4qky9jUwKeW/+3Ja+adXKyIFfk/rBB97VTsum7Y
 4DNSMaB9lEzfBs4ejqKWsW0Iky/WQ5gTgcTZ5AGaSSFq0hZs0wVkxYes1KX5nlJ6Xv8l7RxhD
 UR9ZYi28Xh0XOn2EPJcx79OofxsgDtavVz2/d9rLJR0SUdAmYhvCcd/WFbeAYYDcCDRhYPlwV
 pMVy/TGSuDApI4C1jP8sgWur5rHTRuy9qOdskEW0MjtcTbUE8md9cTFE+kLYUqpuHN5H0OP0I
 AeYUGG+TR8yFDQmreznZhNKXCtSX5x6bE6LFkQLctGRVHVsGdCXOC7aCcJvy64Mrl+2dfNb8c
 uCAGsIv5dtsKOKQfjoPYKDCiKpIwTZS8GwULRBn3UrTeCE1CnQ2P0gDtQWFKJa6VvD3+qpATd
 hM26vVc6e9bNhd/GTB8ZJhCwpQgUTkujvgLE10G68Ud72g5T86gGCAKb82T/DT+4dKjcQ769 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285475>

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
index 9ffd043..4e33db1 100644
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
