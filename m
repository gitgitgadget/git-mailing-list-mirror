From: Lars Vogel <lars.vogel@gmail.com>
Subject: [PATCH] Use "working tree" instead of "working directory" for git status
Date: Thu,  9 Jun 2016 19:46:14 +0200
Message-ID: <1465494374-10417-1-git-send-email-Lars.Vogel@vogella.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Vogel <Lars.Vogel@vogella.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 19:47:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB42N-0000fZ-Nc
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 19:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbcFIRqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2016 13:46:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34981 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbcFIRqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 13:46:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id k184so12412469wme.2
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jqi3wiWc7KoCZUFvWwYgksFWwF8JWDO2Nu3olH4fWoo=;
        b=an/kHS6QuXX8e71/7ALarTHTD3UNtOMRrae0iL88mmilQMegZTR7wws5+tLXNfql+V
         qidMlaqdQX0Nq2qz93IA06GYvBWFaITc2pZ6NMB1T8VFQoaMWyBANH3mp2Is0BWxeMF4
         9lrYSZt525MC7h/f0Qcz9HCmxbzcrxWP73VGpYFe91f4tzlYbj3WVcVboDk/FgArHERd
         DDMKF6kbUDMM4QkwqtsY8a1H7zPL6ZCjsP0TP324nCR41zfIUeVJXuWKOGJpvz5lpQIk
         tOoJA/P3jtSVlJbi78k+cZe5dRSb9DwMhgTRvrhkCXa665JD2sBZxe/GDww3G9sjXsEC
         Uzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jqi3wiWc7KoCZUFvWwYgksFWwF8JWDO2Nu3olH4fWoo=;
        b=arSpWdNT80MX/0MJjjujiUOqsza0W5rMco3ixN/1SYu8Ho7ZVUtLg4LS/OW4HYzzG0
         ZUzoGRUTp5p7H4CkJty+M+sK0PWR1HgRJ1UDgBNAb7VBDM15S2jFXH1pX0hP3B36vI+i
         p4NzqG/RHYk0LRNivyf8tm1I+niY2QGzvokbpgwykoXK/FUuOdeeCDOmmJBdK4G5yrsb
         dSZwrtPyapx+HUF5hl5XbJSEyLUrVUI4hCj5HzKd7pyRWeiRWZlOFCgzqRr16uMMn/xF
         iQeIpyLluR6Qeu03u3HLGdUMcp174X4LwRdlpLrw4Mr4y/DQw2i64DriRcKYIP8LjSfG
         14Yw==
X-Gm-Message-State: ALyK8tKnEhZvMI9LoF/7UjG6/2jecfdfrQ9FvjFIx5PyzOKmRgQUgSo2O8w6VaJvlh+c1A==
X-Received: by 10.28.218.149 with SMTP id r143mr15154083wmg.102.1465494382234;
        Thu, 09 Jun 2016 10:46:22 -0700 (PDT)
Received: from Frodo.railnet.train ([88.128.80.25])
        by smtp.gmail.com with ESMTPSA id s1sm8099630wjf.43.2016.06.09.10.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jun 2016 10:46:21 -0700 (PDT)
X-Google-Original-From: Lars Vogel <Lars.Vogel@vogella.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296909>

Working directory can be easily confused with the current directory.
In one of my patches I already updated the usage of working directory
with working tree for the man page but I noticed that git status also
uses this incorrect term.
---
 po/bg.po    | 2 +-
 po/ca.po    | 2 +-
 po/de.po    | 2 +-
 po/fr.po    | 2 +-
 po/git.pot  | 2 +-
 po/ko.po    | 2 +-
 po/ru.po    | 2 +-
 po/sv.po    | 2 +-
 po/vi.po    | 2 +-
 po/zh_CN.po | 2 +-
 wt-status.c | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index ac6f103..9390c81 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -2295,7 +2295,7 @@ msgstr ""
=20
 #: wt-status.c:1535
 #, c-format
-msgid "nothing to commit, working directory clean\n"
+msgid "nothing to commit, working tree clean\n"
 msgstr "=D0=BB=D0=B8=D0=BF=D1=81=D0=B2=D0=B0=D1=82 =D0=BA=D0=B0=D0=BA=D0=
=B2=D0=B8=D1=82=D0=BE =D0=B8 =D0=B4=D0=B0 =D0=B5 =D0=BF=D1=80=D0=BE=D0=BC=
=D0=B5=D0=BD=D0=B8, =D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BD=D0=BE=D1=82=D0=
=BE =D0=B4=D1=8A=D1=80=D0=B2=D0=BE =D0=B5 =D1=87=D0=B8=D1=81=D1=82=D0=BE=
\n"
=20
 #: wt-status.c:1642
diff --git a/po/ca.po b/po/ca.po
index 46000d7..f54f137 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -2318,7 +2318,7 @@ msgstr ""
=20
 #: wt-status.c:1535
 #, c-format
-msgid "nothing to commit, working directory clean\n"
+msgid "nothing to commit, working tree clean\n"
 msgstr "no hi ha res a cometre, directori de treball net\n"
=20
 #: wt-status.c:1642
diff --git a/po/de.po b/po/de.po
index 0eadf34..a14fe92 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2356,7 +2356,7 @@ msgstr ""
=20
 #: wt-status.c:1535
 #, c-format
-msgid "nothing to commit, working directory clean\n"
+msgid "nothing to commit, working tree clean\n"
 msgstr "nichts zu committen, Arbeitsverzeichnis unver=C3=A4ndert\n"
=20
 #: wt-status.c:1642
diff --git a/po/fr.po b/po/fr.po
index 55ca387..627315c 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -2394,7 +2394,7 @@ msgstr "rien =C3=A0 valider (utilisez -u pour aff=
icher les fichiers non suivis)\n"
=20
 #: wt-status.c:1535
 #, c-format
-msgid "nothing to commit, working directory clean\n"
+msgid "nothing to commit, working tree clean\n"
 msgstr "rien =C3=A0 valider, la copie de travail est propre\n"
=20
 #: wt-status.c:1642
diff --git a/po/git.pot b/po/git.pot
index 72ef798..2957091 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -2192,7 +2192,7 @@ msgstr ""
=20
 #: wt-status.c:1535
 #, c-format
-msgid "nothing to commit, working directory clean\n"
+msgid "nothing to commit, working tree clean\n"
 msgstr ""
=20
 #: wt-status.c:1642
diff --git a/po/ko.po b/po/ko.po
index 3ff3b9b..9520e04 100644
--- a/po/ko.po
+++ b/po/ko.po
@@ -2313,7 +2313,7 @@ msgstr ""
=20
 #: wt-status.c:1535
 #, c-format
-msgid "nothing to commit, working directory clean\n"
+msgid "nothing to commit, working tree clean\n"
 msgstr "=EC=BB=A4=EB=B0=8B=ED=95=A0 =EC=82=AC=ED=95=AD =EC=97=86=EC=9D=
=8C, =EC=9E=91=EC=97=85 =ED=8F=B4=EB=8D=94 =EA=B9=A8=EB=81=97=ED=95=A8\=
n"
=20
 #: wt-status.c:1642
diff --git a/po/ru.po b/po/ru.po
index c0a838b..6fe8c09 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -2233,7 +2233,7 @@ msgstr "=D0=BD=D0=B5=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=
=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=D0=B8=D1=82=D1=8C (=D0=B8=D1=81=D0=BF=D0=
=BE=D0=BB=D1=8C=D0=B7=D1=83=D0=B9=D1=82=D0=B5 =D0=BE=D0=BF=D1=86=D0=B8=D1=
=8E =C2=AB-u
=20
 #: wt-status.c:1535
 #, c-format
-msgid "nothing to commit, working directory clean\n"
+msgid "nothing to commit, working tree clean\n"
 msgstr "=D0=BD=D0=B5=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=BE=D0=BC=D0=BC=D0=
=B8=D1=82=D0=B8=D1=82=D1=8C, =D0=BD=D0=B5=D1=82 =D0=B8=D0=B7=D0=BC=D0=B5=
=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B2 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=
=B5=D0=BC =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B5\n"
=20
 #: wt-status.c:1642
diff --git a/po/sv.po b/po/sv.po
index 32bcaba..801a816 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -2289,7 +2289,7 @@ msgstr "inget att checka in (anv=C3=A4nd -u f=C3=B6=
r att visa osp=C3=A5rade filer)\n"
=20
 #: wt-status.c:1535
 #, c-format
-msgid "nothing to commit, working directory clean\n"
+msgid "nothing to commit, working tree clean\n"
 msgstr "inget att checka in, arbetskatalogen ren\n"
=20
 #: wt-status.c:1642
diff --git a/po/vi.po b/po/vi.po
index edd8e29..18fbdef 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -2306,7 +2306,7 @@ msgstr ""
=20
 #: wt-status.c:1535
 #, c-format
-msgid "nothing to commit, working directory clean\n"
+msgid "nothing to commit, working tree clean\n"
 msgstr "kh=C3=B4ng c=C3=B3 g=C3=AC =C4=91=E1=BB=83 chuy=E1=BB=83n giao=
, th=C6=B0 m=E1=BB=A5c l=C3=A0m vi=E1=BB=87c s=E1=BA=A1ch s=E1=BA=BD\n"
=20
 #: wt-status.c:1642
diff --git a/po/zh_CN.po b/po/zh_CN.po
index a6b06f9..b76f2c0 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -2421,7 +2421,7 @@ msgstr "=E6=97=A0=E6=96=87=E4=BB=B6=E8=A6=81=E6=8F=
=90=E4=BA=A4=EF=BC=88=E4=BD=BF=E7=94=A8 -u =E6=98=BE=E7=A4=BA=E6=9C=AA=E8=
=B7=9F=E8=B8=AA=E7=9A=84=E6=96=87=E4=BB=B6=EF=BC=89\n"
 #  =E8=AF=91=E8=80=85=EF=BC=9A=E4=B8=AD=E6=96=87=E5=AD=97=E7=AC=A6=E4=B8=
=B2=E6=8B=BC=E6=8E=A5=EF=BC=8C=E5=8F=AF=E5=88=A0=E9=99=A4=E5=89=8D=E5=AF=
=BC=E7=A9=BA=E6=A0=BC
 #: wt-status.c:1535
 #, c-format
-msgid "nothing to commit, working directory clean\n"
+msgid "nothing to commit, working tree clean\n"
 msgstr "=E6=97=A0=E6=96=87=E4=BB=B6=E8=A6=81=E6=8F=90=E4=BA=A4=EF=BC=8C=
=E5=B9=B2=E5=87=80=E7=9A=84=E5=B7=A5=E4=BD=9C=E5=8C=BA\n"
=20
 #  =E8=AF=91=E8=80=85=EF=BC=9A=E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=8F=
=A5=E5=B0=BE=E7=A9=BA=E6=A0=BC
diff --git a/wt-status.c b/wt-status.c
index 4f27bd6..4ce4e35 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1554,7 +1554,7 @@ void wt_status_print(struct wt_status *s)
 			else
 				printf(_("nothing to commit\n"));
 		} else
-			printf(_("nothing to commit, working directory clean\n"));
+			printf(_("nothing to commit, working tree clean\n"));
 	}
 }
=20
--=20
2.8.1
