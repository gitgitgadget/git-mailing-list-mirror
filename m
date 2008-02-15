From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 3/3] test mailinfo rfc3676 support
Date: Fri, 15 Feb 2008 16:53:38 -0500
Message-ID: <1203112418-25199-3-git-send-email-jaysoffian@gmail.com>
References: 1203042077-11385-1-git-send-email-jaysoffian@gmail.com
 <1203112418-25199-1-git-send-email-jaysoffian@gmail.com>
 <1203112418-25199-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 22:54:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ8WE-0007Z4-3o
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 22:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758334AbYBOVxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 16:53:52 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758273AbYBOVxw
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 16:53:52 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:35923 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758123AbYBOVxt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 16:53:49 -0500
Received: by an-out-0708.google.com with SMTP id d31so183898and.103
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 13:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PgRUC5Y+WT+YaC0GmNtBB+QmxdTNGlDNZmyiaWL9UVA=;
        b=LrKcAWIvC345slG+u6bpd6rpXGGxccwoo2u7AaF+WRHCZdiSk4oFoTc6YR+HEfGkVDB4WOmi7Zb5YIBQpOLIXDKS/tV81qi68EnggxvIDxIcA17GCgNd+NejnuQ0L+V7PJcLYf58g9KkOOLm0fIK1BVwPk25aBqvTTxQeChZLEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=u4b6zPY7d2Mmg5CnVU6cQizOfJLFJ3gUbdrL2KfYtqfZdr2cEcEx++Nhs0piZWZLJSKS/wHP13qAE/K04s+jjcQytO0iaK79fnz02aHjKcLEpWpEuGr9JxU4aNuRRLoPfNdWjUb9LNtEiOQz82P0GTNaIJyZ8goc/AKQpkeYkFM=
Received: by 10.100.132.2 with SMTP id f2mr4671670and.109.1203112428706;
        Fri, 15 Feb 2008 13:53:48 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id b18sm9042393ana.14.2008.02.15.13.53.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Feb 2008 13:53:47 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1.1281.g75df
In-Reply-To: <1203112418-25199-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73988>

Adds format=3Dflowed and format=3Dflowed delsp=3Dyes messages to the
sample.mbox for testing rfc3676 support.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
I added two tests. The previous patch only added one. This also I think
does a better job of checking the new code.

 t/t5100-mailinfo.sh |    2 +-
 t/t5100/info0009    |    5 ++
 t/t5100/info0010    |    5 ++
 t/t5100/msg0009     |   12 +++++
 t/t5100/msg0010     |   12 +++++
 t/t5100/patch0009   |   24 ++++++++++
 t/t5100/patch0010   |   24 ++++++++++
 t/t5100/sample.mbox |  122 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 8 files changed, 205 insertions(+), 1 deletions(-)
 create mode 100644 t/t5100/info0009
 create mode 100644 t/t5100/info0010
 create mode 100644 t/t5100/msg0009
 create mode 100644 t/t5100/msg0010
 create mode 100644 t/t5100/patch0009
 create mode 100644 t/t5100/patch0010

diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 9b1a745..aaf9889 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. ../t5100/sample.mbox >last &&
 	last=3D`cat last` &&
 	echo total is $last &&
-	test `cat last` =3D 8'
+	test `cat last` =3D 10'
=20
 for mail in `echo 00*`
 do
diff --git a/t/t5100/info0009 b/t/t5100/info0009
new file mode 100644
index 0000000..850ee58
--- /dev/null
+++ b/t/t5100/info0009
@@ -0,0 +1,5 @@
+Author: Jay Soffian
+Email: jaysoffian@example.com
+Subject: Add lorum ipsum text
+Date: Fri, 15 Feb 2008 21:16:18 -0000
+
diff --git a/t/t5100/info0010 b/t/t5100/info0010
new file mode 100644
index 0000000..4a7d931
--- /dev/null
+++ b/t/t5100/info0010
@@ -0,0 +1,5 @@
+Author: Jay Soffian
+Email: jay@example.com
+Subject: Add lorum ipsum text
+Date: Fri, 15 Feb 2008 21:15:32 -0000
+
diff --git a/t/t5100/msg0009 b/t/t5100/msg0009
new file mode 100644
index 0000000..38e4d57
--- /dev/null
+++ b/t/t5100/msg0009
@@ -0,0 +1,12 @@
+The text was added twice, once pre-wrapped, once as a single long line=
,
+which will be flowed.
+
+The next two lines test for space stuffing:
+From nobody
+>
+
+Let's also add some non-ASCII characters:
+
+=E2=91=A0 =E2=91=A1 =E2=91=A2 =E2=91=A3 =E2=91=A4 =E2=91=A5 =E2=91=A6 =
=E2=91=A7 =E2=91=A8 =E2=91=A9
+
+Signed-off-by: Jay Soffian <jaysoffian@example.com>
diff --git a/t/t5100/msg0010 b/t/t5100/msg0010
new file mode 100644
index 0000000..38e4d57
--- /dev/null
+++ b/t/t5100/msg0010
@@ -0,0 +1,12 @@
+The text was added twice, once pre-wrapped, once as a single long line=
,
+which will be flowed.
+
+The next two lines test for space stuffing:
+From nobody
+>
+
+Let's also add some non-ASCII characters:
+
+=E2=91=A0 =E2=91=A1 =E2=91=A2 =E2=91=A3 =E2=91=A4 =E2=91=A5 =E2=91=A6 =
=E2=91=A7 =E2=91=A8 =E2=91=A9
+
+Signed-off-by: Jay Soffian <jaysoffian@example.com>
diff --git a/t/t5100/patch0009 b/t/t5100/patch0009
new file mode 100644
index 0000000..946cd9b
--- /dev/null
+++ b/t/t5100/patch0009
@@ -0,0 +1,24 @@
+---
+Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusm=
od tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim=
 veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex e=
a commodo consequat. Duis aute irure dolor in reprehenderit in voluptat=
e velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occ=
aecat cupidatat non proident, sunt in culpa qui officia deserunt mollit=
 anim id est laborum.
+
+ lorum.txt |    8 ++++++++
+ 1 files changed, 8 insertions(+), 0 deletions(-)
+
+diff --git a/lorum.txt b/lorum.txt
+index cbe5415..c04a705 100644
+--- a/lorum.txt
++++ b/lorum.txt
+@@ -1,2 +1,10 @@
+ From nobody
++Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eius=
mod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mini=
m veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex =
ea commodo consequat. Duis aute irure dolor in reprehenderit in volupta=
te velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint oc=
caecat cupidatat non proident, sunt in culpa qui officia deserunt molli=
t anim id est laborum.
++Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eius=
mod
++tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
++veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex =
ea
++commodo consequat. Duis aute irure dolor in reprehenderit in voluptat=
e
++velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
++occaecat cupidatat non proident, sunt in culpa qui officia deserunt
++mollit anim id est laborum.
+ >
+--=20
+1.5.4.1.1281.g75df
+
diff --git a/t/t5100/patch0010 b/t/t5100/patch0010
new file mode 100644
index 0000000..946cd9b
--- /dev/null
+++ b/t/t5100/patch0010
@@ -0,0 +1,24 @@
+---
+Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusm=
od tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim=
 veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex e=
a commodo consequat. Duis aute irure dolor in reprehenderit in voluptat=
e velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occ=
aecat cupidatat non proident, sunt in culpa qui officia deserunt mollit=
 anim id est laborum.
+
+ lorum.txt |    8 ++++++++
+ 1 files changed, 8 insertions(+), 0 deletions(-)
+
+diff --git a/lorum.txt b/lorum.txt
+index cbe5415..c04a705 100644
+--- a/lorum.txt
++++ b/lorum.txt
+@@ -1,2 +1,10 @@
+ From nobody
++Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eius=
mod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mini=
m veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex =
ea commodo consequat. Duis aute irure dolor in reprehenderit in volupta=
te velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint oc=
caecat cupidatat non proident, sunt in culpa qui officia deserunt molli=
t anim id est laborum.
++Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eius=
mod
++tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
++veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex =
ea
++commodo consequat. Duis aute irure dolor in reprehenderit in voluptat=
e
++velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
++occaecat cupidatat non proident, sunt in culpa qui officia deserunt
++mollit anim id est laborum.
+ >
+--=20
+1.5.4.1.1281.g75df
+
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 070c166..895ec7f 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -407,3 +407,125 @@ Subject: [PATCH] another patch
=20
 Hey you forgot the patch!
=20
+From jaysoffian Fri Feb 15 21:16:18 2008
+Message-ID: <47B6011E.3070904@example.com>
+From: Jay Soffian <jaysoffian@example.com>
+User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
+MIME-Version: 1.0
+To: jay@example.com
+Subject: [PATCH] Add lorum ipsum text
+Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed
+Content-Transfer-Encoding: 8bit
+Date: Fri, 15 Feb 2008 21:16:18 -0000
+
+The text was added twice, once pre-wrapped, once as a single long line=
,
+which will be flowed.
+
+The next two lines test for space stuffing:
+ From nobody
+ >
+
+Let's also add some non-ASCII characters:
+
+=E2=91=A0 =E2=91=A1 =E2=91=A2 =E2=91=A3 =E2=91=A4 =E2=91=A5 =E2=91=A6 =
=E2=91=A7 =E2=91=A8 =E2=91=A9
+
+Signed-off-by: Jay Soffian <jaysoffian@example.com>
+---
+Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusm=
od=20
+tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim=20
+veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex e=
a=20
+commodo consequat. Duis aute irure dolor in reprehenderit in voluptate=
=20
+velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint=20
+occaecat cupidatat non proident, sunt in culpa qui officia deserunt=20
+mollit anim id est laborum.
+
+  lorum.txt |    8 ++++++++
+  1 files changed, 8 insertions(+), 0 deletions(-)
+
+diff --git a/lorum.txt b/lorum.txt
+index cbe5415..c04a705 100644
+--- a/lorum.txt
++++ b/lorum.txt
+@@ -1,2 +1,10 @@
+  From nobody
++Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do=20
+eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad=
=20
+minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliqui=
p=20
+ex ea commodo consequat. Duis aute irure dolor in reprehenderit in=20
+voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur=
=20
+sint occaecat cupidatat non proident, sunt in culpa qui officia deseru=
nt=20
+mollit anim id est laborum.
++Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eius=
mod
++tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
++veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex =
ea
++commodo consequat. Duis aute irure dolor in reprehenderit in voluptat=
e
++velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
++occaecat cupidatat non proident, sunt in culpa qui officia deserunt
++mollit anim id est laborum.
+  >
+--=20
+1.5.4.1.1281.g75df
+
+From jaysoffian Fri Feb 15 21:15:32 2008
+Message-Id: <091C406F-24BE-4D13-AD75-0F60F0D1A532@example.com>
+From: Jay Soffian <jay@example.com>
+To: Jay Soffian <jay@example.com>
+Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed; delsp=3Dye=
s
+Content-Transfer-Encoding: quoted-printable
+Mime-Version: 1.0 (Apple Message framework v919.2)
+Subject: [PATCH] Add lorum ipsum text
+X-Mailer: Apple Mail (2.919.2)
+Date: Fri, 15 Feb 2008 21:15:32 -0000
+
+The text was added twice, once pre-wrapped, once as a single long line=
,
+which will be flowed.
+
+The next two lines test for space stuffing:
+ =3D46rom nobody
+ >
+
+Let's also add some non-ASCII characters:
+
+=3DE2=3D91=3DA0 =3DE2=3D91=3DA1 =3DE2=3D91=3DA2 =3DE2=3D91=3DA3 =3DE2=3D=
91=3DA4 =3DE2=3D91=3DA5 =3DE2=3D91=3DA6 =3D
+=3DE2=3D91=3DA7 =3DE2=3D91=3DA8 =3DE2=3D91=3DA9
+
+Signed-off-by: Jay Soffian <jaysoffian@example.com>
+---
+Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do =3D20
+eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad=
 =3D20=3D
+
+minim veniam, quis nostrud exercitation ullamco laboris nisi ut =3D20
+aliquip ex ea commodo consequat. Duis aute irure dolor in =3D20
+reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla =3D=
20
+pariatur. Excepteur sint occaecat cupidatat non proident, sunt in =3D2=
0
+culpa qui officia deserunt mollit anim id est laborum.
+
+  lorum.txt |    8 ++++++++
+  1 files changed, 8 insertions(+), 0 deletions(-)
+
+diff --git a/lorum.txt b/lorum.txt
+index cbe5415..c04a705 100644
+--- a/lorum.txt
++++ b/lorum.txt
+@@ -1,2 +1,10 @@
+  =3D46rom nobody
++Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do =3D2=
0
+eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad=
 =3D20=3D
+
+minim veniam, quis nostrud exercitation ullamco laboris nisi ut =3D20
+aliquip ex ea commodo consequat. Duis aute irure dolor in =3D20
+reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla =3D=
20
+pariatur. Excepteur sint occaecat cupidatat non proident, sunt in =3D2=
0
+culpa qui officia deserunt mollit anim id est laborum.
++Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do =3D2=
0
+eiusmod
++tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
++veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex =
ea
++commodo consequat. Duis aute irure dolor in reprehenderit in voluptat=
e
++velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
++occaecat cupidatat non proident, sunt in culpa qui officia deserunt
++mollit anim id est laborum.
+  >
+--=3D20
+1.5.4.1.1281.g75df
+
--=20
1.5.4.1.1281.g75df
