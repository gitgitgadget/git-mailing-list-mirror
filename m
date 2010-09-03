From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/3] gettext: Add po/README file documenting Git's gettext
Date: Fri,  3 Sep 2010 23:24:54 +0000
Message-ID: <1283556296-7365-2-git-send-email-avarab@gmail.com>
References: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 01:25:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrfdW-0004xM-Bz
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 01:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861Ab0ICXZR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 19:25:17 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43337 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab0ICXZN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 19:25:13 -0400
Received: by wyf22 with SMTP id 22so436222wyf.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 16:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=jxOY/CMESpqtLgZIveaBx5Fq9/NKtQMnRjqz9mYIZyc=;
        b=Pfa1syQ7OupW5YvLtZEnIKj2U1gyzQnyfWZ5s70XsB+QCb+bbZDLd1Yp72km7um8MW
         PHEchiLzuXyvpbQ+j6k5X0pFLD1eySB67wCJus3AkOO3Ws68s6K0QGkgE6zf7avlgVtw
         vgLpq7it3dLgOKIcBX/EqZI5d8Sp+aBePObQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=guBLuiUzRvuk7NKiB4m7QiDPZ41/W/OV+zoxMJPonAc2E8XYCVXRcCuCoKWzWQSSQI
         8ES/mHf6fCy8/IJGdV46WTiuxi7aYHuKbZ7JCXHCDwmveb8D9xruUnls0gOx/ccu4Ig1
         DI083t2hBsC1qTMtjGAau9pNWCoYovOPcV/qk=
Received: by 10.227.141.146 with SMTP id m18mr47525wbu.34.1283556312318;
        Fri, 03 Sep 2010 16:25:12 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a1sm2047451wbb.2.2010.09.03.16.25.10
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 16:25:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.336.g704fc
In-Reply-To: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155284>

Add a po/README file. This documentation is targated at translators
and maintainers of git.git.

Currently it describes how to add new PO files and how to update
them. But in the future we want to add more things to it, e.g. how and
what to add in TRANSLATOR comments, how to make the source more
gettext friendly etc.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Turns out we do just fine with --no-location.

 po/README |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100644 po/README

diff --git a/po/README b/po/README
new file mode 100644
index 0000000..cca8012
--- /dev/null
+++ b/po/README
@@ -0,0 +1,68 @@
+Core GIT Translations
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This directory holds the translations for the core of Git. This
+document describes how to add to and maintain these translations.
+
+
+Generating a .pot file
+----------------------
+
+The po/git.pot file contains a message catalog extracted from Git's
+sources. You need to generate it to add new translations with
+msginit(1), or update existing ones with msgmerge(1).
+
+Since the file can be automatically generated it's not checked into
+git.git. To generate it do, at the top-level:
+
+    make pot
+
+
+Initializing a .po file
+-----------------------
+
+To add a new translation first generate git.pot (see above) and then
+in the po/ directory do:
+
+    msginit --locale=3DXX --no-translator
+
+Where XX is your locale, e.g. "is", "de" or "pt_BR".
+
+Then, because msginit(1) will include a lot of superfluous info we
+don't want run this on it:
+
+    perl -ni -e '
+        if (1 .. /^$/) {
+            s/^#.*\n//;
+            s/(?<=3DProject-Id-Version: )PACKAGE VERSION/Git/;
+            s/"(?:PO-Revision-Date|Language-Team|Last-Translator): .*\=
n//;
+        }
+        s/^#: .*\n//;
+        print
+    ' XX.po
+
+We omit removing "POT-Creation-Date", because msgmerge(1) always adds
+it if it isn't present, and removing it after each msgmerge is harder
+than just including it to begin with.
+
+
+Updating a .po file
+-------------------
+
+If there's an existing *.po file for your language but you need to
+update the translation you first need to generate git.pot (see above)
+and then in the po/ directory do:
+
+    msgmerge --no-location --backup=3Doff -U XX.po git.pot
+
+Where XX.po is the file you want to update.
+
+If you want to generate location comments (it can be very useful to
+see the source for context while translating) do:
+
+    msgmerge --add-location --backup=3Doff -U XX.po git.pot
+
+But then you need remember to remove the comments before you submit
+the file upstream:
+
+    perl -pi -e 's/^#: .*\n//' XX.po
--=20
1.7.2.2.336.g704fc
