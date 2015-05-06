From: Danny Lin <danny0838@gmail.com>
Subject: [PATCH] branch: -r -d(D) should say "remote-tracking branch"
Date: Wed, 6 May 2015 17:46:30 +0800
Message-ID: <CAMbsUu5pKiQ76WrCXvziQ8zER-Mc5oVt7tGnC7Q3RMVX2r8ZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 11:46:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpvuZ-0005lT-7G
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 11:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbbEFJqf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2015 05:46:35 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35067 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbbEFJqb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2015 05:46:31 -0400
Received: by qgej70 with SMTP id j70so1671426qge.2
        for <git@vger.kernel.org>; Wed, 06 May 2015 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=cy1HdsYbvc98yhHKX4hNjfCRhI5kHhscexDnS0NRkUY=;
        b=Q0jwlfxyJstvPjSdQLIG2kphRP7Rsa7Z/XAyFom1eiLV1WdpqtFLxEozl5CZpgHzD0
         jqWSlYSeM8o0IKVdw14Kso022yE6kNf2qtOMz9jo3C4V51rorH8zGFdbNWJGQsVukHs0
         7zyA26DrHgByZxLX3w+knTy75VcQG+P6lnI2qOpclR2xiTGWGpd7MO2sr06U0p8TONqM
         fuKS9jl5W3vSuKG3OazMIZtS1L6pRRFAU2BF8GeNziGH/4DCPIHbyjzCa6Vu2CPUBlTf
         8xanDcTlHrUuRIvWYpygnNH2sJvG9wTiRyEvZL09PIqk/d7v6rs85Cx2waeAZFkmRtsO
         goCg==
X-Received: by 10.140.102.180 with SMTP id w49mr11983705qge.82.1430905590594;
 Wed, 06 May 2015 02:46:30 -0700 (PDT)
Received: by 10.140.98.145 with HTTP; Wed, 6 May 2015 02:46:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268463>

git branch -r -d(D) currently says "delete remote branch",
which should be "remote-tracking branch".
---
 builtin/branch.c | 6 +++---
 po/bg.po         | 6 +++---
 po/ca.po         | 6 +++---
 po/de.po         | 6 +++---
 po/fr.po         | 6 +++---
 po/git.pot       | 6 +++---
 po/it.po         | 6 +++---
 po/pt_PT.po      | 6 +++---
 po/sv.po         | 6 +++---
 po/vi.po         | 6 +++---
 po/zh_CN.po      | 6 +++---
 11 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index dc6f0b2..3560c51 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -242,7 +242,7 @@ static int delete_branches(int argc, const char
**argv, int force, int kinds,
                         sha1, &flags);
         if (!target) {
             error(remote_branch
-                  ? _("remote branch '%s' not found.")
+                  ? _("remote-tracking branch '%s' not found.")
                   : _("branch '%s' not found."), bname.buf);
             ret =3D 1;
             continue;
@@ -257,7 +257,7 @@ static int delete_branches(int argc, const char
**argv, int force, int kinds,

         if (delete_ref(name, sha1, REF_NODEREF)) {
             error(remote_branch
-                  ? _("Error deleting remote branch '%s'")
+                  ? _("Error deleting remote-tracking branch '%s'")
                   : _("Error deleting branch '%s'"),
                   bname.buf);
             ret =3D 1;
@@ -265,7 +265,7 @@ static int delete_branches(int argc, const char
**argv, int force, int kinds,
         }
         if (!quiet) {
             printf(remote_branch
-                   ? _("Deleted remote branch %s (was %s).\n")
+                   ? _("Deleted remote-tracking branch %s (was %s).\n"=
)
                    : _("Deleted branch %s (was %s).\n"),
                    bname.buf,
                    (flags & REF_ISBROKEN) ? "broken"
diff --git a/po/bg.po b/po/bg.po
index ccdd11e..8abde0f 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -3037,7 +3037,7 @@ msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82=
=D0=B5 =D0=B4=D0=B0 =D0=B8=D0=B7=D1=82=D1=80=D0=B8=D0=B5=D1=82=D0=B5 =D0=
=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C, =D0=B7=D0=B0=D1=89=D0=
=BE=D1=82

 #: builtin/branch.c:245
 #, c-format
-msgid "remote branch '%s' not found."
+msgid "remote-tracking branch '%s' not found."
 msgstr "=D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D1=
=8F=D1=82 =D0=BA=D0=BB=D0=BE=D0=BD =E2=80=9E%s=E2=80=9C =D0=BD=D0=B5 =D0=
=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=BE=D1=82=
=D0=BA=D1=80=D0=B8=D1=82."

 #: builtin/branch.c:246
@@ -3047,7 +3047,7 @@ msgstr "=D0=BA=D0=BB=D0=BE=D0=BD=D1=8A=D1=82 =E2=80=
=9E%s=E2=80=9C =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0 =D0=B1=
=D1=8A=D0=B4=D0=B5 =D0=BE=D1=82=D0=BA=D1=80=D0=B8=D1=82."

 #: builtin/branch.c:260
 #, c-format
-msgid "Error deleting remote branch '%s'"
+msgid "Error deleting remote-tracking branch '%s'"
 msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B8=
=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0=
 =D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=
=BA=D0=BB=D0=BE=D0=BD =E2=80=9E%s=E2=80=9C"

 #: builtin/branch.c:261
@@ -3057,7 +3057,7 @@ msgstr "=D0=93=D1=80=D0=B5=D1=88=D0=BA=D0=B0 =D0=BF=
=D1=80=D0=B8 =D0=B8=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5=D1=82=
=D0=BE =D0=BD=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C=
"

 #: builtin/branch.c:268
 #, c-format
-msgid "Deleted remote branch %s (was %s).\n"
+msgid "Deleted remote-tracking branch %s (was %s).\n"
 msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D1=82 =D0=BE=D1=82=D0=B4=D0=B0=D0=
=BB=D0=B5=D1=87=D0=B5=D0=BD =D0=BA=D0=BB=D0=BE=D0=BD =E2=80=9E%s=E2=80=9C=
 (=D1=82=D0=BE=D0=B9 =D1=81=D0=BE=D1=87=D0=B5=D1=88=D0=B5 =D0=BA=D1=8A=D0=
=BC =E2=80=9E%s=E2=80=9C).\n"

 #: builtin/branch.c:269
diff --git a/po/ca.po b/po/ca.po
index a649508..8d5992d 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -2857,7 +2857,7 @@ msgstr "No es pot suprimir la branca '%s', en la
qual sou actualment."

 #: builtin/branch.c:245
 #, c-format
-msgid "remote branch '%s' not found."
+msgid "remote-tracking branch '%s' not found."
 msgstr "no s'ha trobat la branca remota '%s'."

 #: builtin/branch.c:246
@@ -2867,7 +2867,7 @@ msgstr "no s'ha trobat la branca '%s'."

 #: builtin/branch.c:260
 #, c-format
-msgid "Error deleting remote branch '%s'"
+msgid "Error deleting remote-tracking branch '%s'"
 msgstr "Error en suprimir la branca remota '%s'"

 #: builtin/branch.c:261
@@ -2877,7 +2877,7 @@ msgstr "Error en suprimir la branca '%s'"

 #: builtin/branch.c:268
 #, c-format
-msgid "Deleted remote branch %s (was %s).\n"
+msgid "Deleted remote-tracking branch %s (was %s).\n"
 msgstr "S'ha suprimit la branca remota %s (ha estat %s).\n"

 #: builtin/branch.c:269
diff --git a/po/de.po b/po/de.po
index 11fbd0f..5c7c0e2 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2907,7 +2907,7 @@ msgstr ""

 #: builtin/branch.c:245
 #, c-format
-msgid "remote branch '%s' not found."
+msgid "remote-tracking branch '%s' not found."
 msgstr "Remote-Branch '%s' nicht gefunden"

 #: builtin/branch.c:246
@@ -2917,7 +2917,7 @@ msgstr "Branch '%s' nicht gefunden."

 #: builtin/branch.c:260
 #, c-format
-msgid "Error deleting remote branch '%s'"
+msgid "Error deleting remote-tracking branch '%s'"
 msgstr "Fehler beim Entfernen des Remote-Branches '%s'"

 #: builtin/branch.c:261
@@ -2927,7 +2927,7 @@ msgstr "Fehler beim Entfernen des Branches '%s'"

 #: builtin/branch.c:268
 #, c-format
-msgid "Deleted remote branch %s (was %s).\n"
+msgid "Deleted remote-tracking branch %s (was %s).\n"
 msgstr "Remote-Branch %s entfernt (war %s).\n"

 #: builtin/branch.c:269
diff --git a/po/fr.po b/po/fr.po
index 3235879..2b5ea7a 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -2945,7 +2945,7 @@ msgstr "Impossible de supprimer la branche '%s'
sur laquelle vous =C3=AAtes."

 #: builtin/branch.c:245
 #, c-format
-msgid "remote branch '%s' not found."
+msgid "remote-tracking branch '%s' not found."
 msgstr "branche distante %s' non trouv=C3=A9e."

 #: builtin/branch.c:246
@@ -2955,7 +2955,7 @@ msgstr "branche '%s' non trouv=C3=A9e."

 #: builtin/branch.c:260
 #, c-format
-msgid "Error deleting remote branch '%s'"
+msgid "Error deleting remote-tracking branch '%s'"
 msgstr "Erreur lors de la suppression de la branche distante '%s'"

 #: builtin/branch.c:261
@@ -2965,7 +2965,7 @@ msgstr "Erreur lors de la suppression de la branc=
he '%s'"

 #: builtin/branch.c:268
 #, c-format
-msgid "Deleted remote branch %s (was %s).\n"
+msgid "Deleted remote-tracking branch %s (was %s).\n"
 msgstr "Branche distante %s supprim=C3=A9e (pr=C3=A9c=C3=A9demment %s)=
=2E\n"

 #: builtin/branch.c:269
diff --git a/po/git.pot b/po/git.pot
index 91fa5a1..4263f6e 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -2708,7 +2708,7 @@ msgstr ""

 #: builtin/branch.c:245
 #, c-format
-msgid "remote branch '%s' not found."
+msgid "remote-tracking branch '%s' not found."
 msgstr ""

 #: builtin/branch.c:246
@@ -2718,7 +2718,7 @@ msgstr ""

 #: builtin/branch.c:260
 #, c-format
-msgid "Error deleting remote branch '%s'"
+msgid "Error deleting remote-tracking branch '%s'"
 msgstr ""

 #: builtin/branch.c:261
@@ -2728,7 +2728,7 @@ msgstr ""

 #: builtin/branch.c:268
 #, c-format
-msgid "Deleted remote branch %s (was %s).\n"
+msgid "Deleted remote-tracking branch %s (was %s).\n"
 msgstr ""

 #: builtin/branch.c:269
diff --git a/po/it.po b/po/it.po
index 9080219..e391e29 100644
--- a/po/it.po
+++ b/po/it.po
@@ -1514,7 +1514,7 @@ msgstr ""

 #: builtin/branch.c:202
 #, c-format
-msgid "remote branch '%s' not found."
+msgid "remote-tracking branch '%s' not found."
 msgstr "il branch remoto '%s' non =C3=A8 stato trovato."

 #: builtin/branch.c:203
@@ -1536,7 +1536,7 @@ msgstr ""

 #: builtin/branch.c:225
 #, c-format
-msgid "Error deleting remote branch '%s'"
+msgid "Error deleting remote-tracking branch '%s'"
 msgstr "Errore nella rimozione del branch remoto '%s'"

 #: builtin/branch.c:226
@@ -1546,7 +1546,7 @@ msgstr "Errore nella rimozione del branch '%s'"

 #: builtin/branch.c:233
 #, c-format
-msgid "Deleted remote branch %s (was %s).\n"
+msgid "Deleted remote-tracking branch %s (was %s).\n"
 msgstr "Ramo remoto %s eliminato (era %s).\n"

 #: builtin/branch.c:234
diff --git a/po/pt_PT.po b/po/pt_PT.po
index 689ad1b..6ef1b35 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -1379,7 +1379,7 @@ msgstr ""

 #: builtin/branch.c:202
 #, c-format
-msgid "remote branch '%s' not found."
+msgid "remote-tracking branch '%s' not found."
 msgstr "rama remota '%s n=C3=A3o encontrada."

 #: builtin/branch.c:203
@@ -1401,7 +1401,7 @@ msgstr ""

 #: builtin/branch.c:225
 #, c-format
-msgid "Error deleting remote branch '%s'"
+msgid "Error deleting remote-tracking branch '%s'"
 msgstr ""

 #: builtin/branch.c:226
@@ -1411,7 +1411,7 @@ msgstr "Erro a eliminar rama '%s'"

 #: builtin/branch.c:233
 #, c-format
-msgid "Deleted remote branch %s (was %s).\n"
+msgid "Deleted remote-tracking branch %s (was %s).\n"
 msgstr ""

 #: builtin/branch.c:234
diff --git a/po/sv.po b/po/sv.po
index 0440443..e71d1d2 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -2811,7 +2811,7 @@ msgstr "Kan inte ta bort grenen \"%s\" som du
befinner dig p=C3=A5 f=C3=B6r n=C3=A4rvarande.

 #: builtin/branch.c:245
 #, c-format
-msgid "remote branch '%s' not found."
+msgid "remote-tracking branch '%s' not found."
 msgstr "fj=C3=A4rrgrenen \"%s\" hittades inte."

 #: builtin/branch.c:246
@@ -2821,7 +2821,7 @@ msgstr "grenen \"%s\" hittades inte."

 #: builtin/branch.c:260
 #, c-format
-msgid "Error deleting remote branch '%s'"
+msgid "Error deleting remote-tracking branch '%s'"
 msgstr "Fel vid borttagning av fj=C3=A4rrgrenen \"%s\""

 #: builtin/branch.c:261
@@ -2831,7 +2831,7 @@ msgstr "Fel vid borttagning av grenen \"%s\""

 #: builtin/branch.c:268
 #, c-format
-msgid "Deleted remote branch %s (was %s).\n"
+msgid "Deleted remote-tracking branch %s (was %s).\n"
 msgstr "Tog bort fj=C3=A4rrgrenen %s (var %s).\n"

 #: builtin/branch.c:269
diff --git a/po/vi.po b/po/vi.po
index 9c2bba8..c6ceb5a 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -2842,7 +2842,7 @@ msgstr "Kh=C3=B4ng th=E1=BB=83 x=C3=B3a nh=C3=A1n=
h =E2=80=9C%s=E2=80=9D c=C3=A1i m=C3=A0 b=E1=BA=A1n hi=E1=BB=87n
nay =C4=91ang =E1=BB=9F."

 #: builtin/branch.c:245
 #, c-format
-msgid "remote branch '%s' not found."
+msgid "remote-tracking branch '%s' not found."
 msgstr "kh=C3=B4ng t=C3=ACm th=E1=BA=A5y nh=C3=A1nh m=C3=A1y ch=E1=BB=A7=
 =E2=80=9C%s=E2=80=9D."

 #: builtin/branch.c:246
@@ -2852,7 +2852,7 @@ msgstr "kh=C3=B4ng t=C3=ACm th=E1=BA=A5y nh=C3=A1=
nh =E2=80=9C%s=E2=80=9D."

 #: builtin/branch.c:260
 #, c-format
-msgid "Error deleting remote branch '%s'"
+msgid "Error deleting remote-tracking branch '%s'"
 msgstr "G=E1=BA=B7p l=E1=BB=97i khi =C4=91ang x=C3=B3a nh=C3=A1nh tr=C3=
=AAn m=C3=A1y ch=E1=BB=A7 =E2=80=9C%s=E2=80=9D"

 #: builtin/branch.c:261
@@ -2862,7 +2862,7 @@ msgstr "G=E1=BA=B7p l=E1=BB=97i khi x=C3=B3a b=E1=
=BB=8F nh=C3=A1nh =E2=80=9C%s=E2=80=9D"

 #: builtin/branch.c:268
 #, c-format
-msgid "Deleted remote branch %s (was %s).\n"
+msgid "Deleted remote-tracking branch %s (was %s).\n"
 msgstr "Nh=C3=A1nh tr=C3=AAn m=C3=A1y ch=E1=BB=A7 \"%s\" =C4=91=C3=A3 =
b=E1=BB=8B x=C3=B3a (t=E1=BB=ABng l=C3=A0 %s).\n"

 #: builtin/branch.c:269
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 2b8d2cb..93b1916 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -2822,7 +2822,7 @@ msgstr "=E6=97=A0=E6=B3=95=E5=88=A0=E9=99=A4=E6=82=
=A8=E5=BD=93=E5=89=8D=E6=89=80=E5=9C=A8=E7=9A=84=E5=88=86=E6=94=AF '%s'=
=E3=80=82"

 #: builtin/branch.c:245
 #, c-format
-msgid "remote branch '%s' not found."
+msgid "remote-tracking branch '%s' not found."
 msgstr "=E8=BF=9C=E7=A8=8B=E5=88=86=E6=94=AF '%s' =E6=9C=AA=E5=8F=91=E7=
=8E=B0=E3=80=82"

 #: builtin/branch.c:246
@@ -2832,7 +2832,7 @@ msgstr "=E5=88=86=E6=94=AF '%s' =E6=9C=AA=E5=8F=91=
=E7=8E=B0=E3=80=82"

 #: builtin/branch.c:260
 #, c-format
-msgid "Error deleting remote branch '%s'"
+msgid "Error deleting remote-tracking branch '%s'"
 msgstr "=E5=88=A0=E9=99=A4=E8=BF=9C=E7=A8=8B=E5=88=86=E6=94=AF '%s' =E6=
=97=B6=E5=87=BA=E9=94=99"

 #: builtin/branch.c:261
@@ -2842,7 +2842,7 @@ msgstr "=E5=88=A0=E9=99=A4=E5=88=86=E6=94=AF '%s'=
 =E6=97=B6=E5=87=BA=E9=94=99"

 #: builtin/branch.c:268
 #, c-format
-msgid "Deleted remote branch %s (was %s).\n"
+msgid "Deleted remote-tracking branch %s (was %s).\n"
 msgstr "=E5=B7=B2=E5=88=A0=E9=99=A4=E8=BF=9C=E7=A8=8B=E5=88=86=E6=94=AF=
 %s=EF=BC=88=E6=9B=BE=E4=B8=BA %s=EF=BC=89=E3=80=82\n"

 #: builtin/branch.c:269
--=20
2.3.7.windows.1
