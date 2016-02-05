From: tboegi@web.de
Subject: [PATCH v3 5/7] convert: auto_crlf=false and no attributes set: same as binary
Date: Fri,  5 Feb 2016 17:13:27 +0100
Message-ID: <1454688807-20871-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 17:12:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRj02-0002PV-Ce
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 17:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596AbcBEQMj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 11:12:39 -0500
Received: from mout.web.de ([212.227.17.12]:57890 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753929AbcBEQMY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 11:12:24 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LzK61-1Zx2r11to1-014TtN; Fri, 05 Feb 2016 17:12:22
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:LX03f0Xa+gnjoILYWN146Um58vMtwLcL1DWKx3Aokgglfykxdx9
 ig3gLA9D6Rb+grOh+QcE5yqAvKG9ZrjgjgILNRl1/haRtMeMjsJhMNx9qiRfv6EocBDgn9/
 /lqUUjevBRMB28wUEVRbFUFPrwTovqnpyz8drw/uWMwCa7cT2Bq91Y57fw0HAByqa7ctTzp
 C/nfmwUkSgDfWMVdwuJPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8yxcS0U0ST4=:oBLaA1oi/nrretT64pAZtP
 1EFs5/I+Lq9cI3mX5LTyjKEs0F4tB4BYHPX2s44TGtL3jmh4oF0E3BnfcZQ+HPB4wEzUChe8e
 Gyol7qKPBWuMPnQGh4zT4l4EFf0WBDrHXJBJlFYnuVrUyk0qeF1QdP7xOSE8dBt3fedV1Kqbh
 bAo1lm7He1B0n2PwhXiCkMaNhN26EAXHpAEjLez5eEuGfU5lGuxXTNts0fY63ZitpSE4qSbMF
 Q2w7bkeX3+NuH0pk8akoX+ew2bs3IQh9nXS8olIKfTntocVodAjwWJz/XEGHNOA3mofIXuI88
 RCDcDoiS6BCd+ogxDH2LrlgxS1X4lSrRg7fuODEWOMw4PiCtY3zrQE1tFDrv9lcaH8YSm90mg
 TIKzlZPEwoU7FtKmpEHRzDUJz5z6N+mEpBHfjqapEGXwJomzhcPbonW41585RGxNaLhnkU1jx
 D72CvmsjstpocH44cbO9yd4f4Vt+/yDOY918eZZZAOmCTui8aFq0BFgAW98YBK5MbNJ9VPO9f
 KW1ZmX7l0WtH9Rzv6vr8J219lG+UQKEk5jnYRMjT+YKiM6b04OLh4eorB2Ll+mbigK7goJ34T
 eIL4wp4KXhYumGW0zqt6Tk8dmbHFdEY5mCYDACKBze5wi0LvQcQzQZwWIq2lVz8IGtsk+5dGZ
 xEB+zG5j33OCajJFUnG7uqxEdm+aRF1Wou8BmoNPhmHgKjEG1hUf/8NO27LUWPTVMPQsP75TR
 Yp7NjA0eafnrpOEdM91dmz9KL95dxuFEctlcBKyZcLmJs7mSm4sVp+G1awvi5EhGt3HyXZv3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285585>

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
index 557e574..e9c9448 100644
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
 	else if (output_eol(crlf_action) =3D=3D EOL_CRLF &&
--=20
2.7.0.303.g2c4f448.dirty
