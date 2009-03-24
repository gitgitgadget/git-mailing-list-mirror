From: Sam Hocevar <sam@zoy.org>
Subject: [PATCH v4 2/2] git-gui: minor spelling fix and string
	factorisation.
Date: Wed, 25 Mar 2009 00:19:00 +0100
Message-ID: <20090324231900.GB14967@zoy.org>
References: <20090324230238.GQ23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 00:20:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmFvC-0000Eb-52
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 00:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbZCXXTJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 19:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753024AbZCXXTG
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 19:19:06 -0400
Received: from poulet.zoy.org ([80.65.228.129]:47960 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303AbZCXXTF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 19:19:05 -0400
Received: from w00t.w00t (localhost [127.0.0.1])
	by poulet.zoy.org (Postfix) with ESMTP id 2AB6212073C;
	Wed, 25 Mar 2009 00:19:01 +0100 (CET)
Received: by w00t.w00t (Postfix, from userid 1000)
	id F2480C4262; Wed, 25 Mar 2009 00:19:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090324230238.GQ23521@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114512>

Properly spell "successful" and slightly rewrite a couple of strings
that actually say the same thing in order to reduce translation work.

Update .pot and .po files accordingly since no new translation is
required.

Signed-off-by: Sam Hocevar <sam@zoy.org>
---
 =E2=96=81=E2=96=82=E2=96=83=E2=96=84=E2=96=85=E2=96=86=E2=96=87=E2=96=88
 lib/branch_delete.tcl        |    4 ++--
 lib/remote_branch_delete.tcl |    4 +---
 lib/tools.tcl                |    2 +-
 po/de.po                     |   12 +-----------
 po/fr.po                     |   12 +-----------
 po/git-gui.pot               |    9 +--------
 po/hu.po                     |   12 +-----------
 po/it.po                     |   12 +-----------
 po/ja.po                     |   12 +-----------
 po/nb.po                     |   12 +-----------
 po/ru.po                     |   10 ----------
 po/sv.po                     |   12 +-----------
 po/zh_cn.po                  |   10 ----------
 13 files changed, 12 insertions(+), 111 deletions(-)

diff --git a/lib/branch_delete.tcl b/lib/branch_delete.tcl
index ef1930b..20d5e42 100644
--- a/lib/branch_delete.tcl
+++ b/lib/branch_delete.tcl
@@ -51,7 +51,7 @@ constructor dialog {} {
 		$w.check \
 		[mc "Delete Only If Merged Into"] \
 		]
-	$w_check none [mc "Always (Do not perform merge test.)"]
+	$w_check none [mc "Always (Do not perform merge checks)"]
 	pack $w.check -anchor nw -fill x -pady 5 -padx 5
=20
 	foreach h [load_all_heads] {
@@ -112,7 +112,7 @@ method _delete {} {
 	}
 	if {$to_delete eq {}} return
 	if {$check_cmt eq {}} {
-		set msg [mc "Recovering deleted branches is difficult. \n\n Delete t=
he selected branches?"]
+		set msg [mc "Recovering deleted branches is difficult.\n\nDelete the=
 selected branches?"]
 		if {[tk_messageBox \
 			-icon warning \
 			-type yesno \
diff --git a/lib/remote_branch_delete.tcl b/lib/remote_branch_delete.tc=
l
index 89eb0f7..4e02fc0 100644
--- a/lib/remote_branch_delete.tcl
+++ b/lib/remote_branch_delete.tcl
@@ -213,9 +213,7 @@ method _delete {} {
 		-type yesno \
 		-title [wm title $w] \
 		-parent $w \
-		-message [mc "Recovering deleted branches is difficult.
-
-Delete the selected branches?"]] ne yes} {
+		-message [mc "Recovering deleted branches is difficult.\n\nDelete th=
e selected branches?"]] ne yes} {
 		return
 	}
=20
diff --git a/lib/tools.tcl b/lib/tools.tcl
index 6ae63b6..95e6e55 100644
--- a/lib/tools.tcl
+++ b/lib/tools.tcl
@@ -146,7 +146,7 @@ proc tools_complete {fullname w {ok 1}} {
 	}
=20
 	if {$ok} {
-		set msg [mc "Tool completed succesfully: %s" $fullname]
+		set msg [mc "Tool completed successfully: %s" $fullname]
 	} else {
 		set msg [mc "Tool failed: %s" $fullname]
 	}
diff --git a/po/de.po b/po/de.po
index a6f730b..51abb50 100644
--- a/po/de.po
+++ b/po/de.po
@@ -773,16 +773,6 @@ msgstr "Immer (ohne Zusammenf=C3=BChrungstest)"
 msgid "The following branches are not completely merged into %s:"
 msgstr "Folgende Zweige sind noch nicht mit =C2=BB%s=C2=AB zusammengef=
=C3=BChrt:"
=20
-#: lib/branch_delete.tcl:115
-msgid ""
-"Recovering deleted branches is difficult. \n"
-"\n"
-" Delete the selected branches?"
-msgstr ""
-"Gel=C3=B6schte Zweige k=C3=B6nnen nur mit gr=C3=B6=C3=9Ferem Aufwand =
wiederhergestellt werden.\n"
-"\n"
-"Gew=C3=A4hlte Zweige jetzt l=C3=B6schen?"
-
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
@@ -2506,7 +2496,7 @@ msgstr "Starten: %s"
=20
 #: lib/tools.tcl:149
 #, tcl-format
-msgid "Tool completed succesfully: %s"
+msgid "Tool completed successfully: %s"
 msgstr "Werkzeug erfolgreich abgeschlossen: %s"
=20
 #: lib/tools.tcl:151
diff --git a/po/fr.po b/po/fr.po
index e6bf1b4..9b828a2 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -780,16 +780,6 @@ msgstr "Toujours (Ne pas faire de test de fusion.)=
"
 msgid "The following branches are not completely merged into %s:"
 msgstr "Les branches suivantes ne sont pas compl=C3=A8tement fusionn=C3=
=A9es dans %s :"
=20
-#: lib/branch_delete.tcl:115
-msgid ""
-"Recovering deleted branches is difficult. \n"
-"\n"
-" Delete the selected branches?"
-msgstr ""
-"Il est difficile de r=C3=A9cup=C3=A9rer des branches supprim=C3=A9es.=
\n"
-"\n"
-"Supprimer les branches s=C3=A9lectionn=C3=A9es ?"
-
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
@@ -2412,7 +2402,7 @@ msgstr "Lancement de : %s"
=20
 #: lib/tools.tcl:149
 #, tcl-format
-msgid "Tool completed succesfully: %s"
+msgid "Tool completed successfully: %s"
 msgstr "L'outil a termin=C3=A9 avec succ=C3=A8s : %s"
=20
 #: lib/tools.tcl:151
diff --git a/po/git-gui.pot b/po/git-gui.pot
index 15aea0d..53b7d36 100644
--- a/po/git-gui.pot
+++ b/po/git-gui.pot
@@ -753,13 +753,6 @@ msgstr ""
 msgid "The following branches are not completely merged into %s:"
 msgstr ""
=20
-#: lib/branch_delete.tcl:115
-msgid ""
-"Recovering deleted branches is difficult. \n"
-"\n"
-" Delete the selected branches?"
-msgstr ""
-
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
@@ -2220,7 +2213,7 @@ msgstr ""
=20
 #: lib/tools.tcl:149
 #, tcl-format
-msgid "Tool completed succesfully: %s"
+msgid "Tool completed successfully: %s"
 msgstr ""
=20
 #: lib/tools.tcl:151
diff --git a/po/hu.po b/po/hu.po
index f761b64..0f87bc1 100644
--- a/po/hu.po
+++ b/po/hu.po
@@ -776,16 +776,6 @@ msgstr "Mindig (Ne legyen merge teszt.)"
 msgid "The following branches are not completely merged into %s:"
 msgstr "A k=C3=B6vetkez=C5=91 branchek nem teljesen lettek merge-=C3=B6=
lve ebbe: %s:"
=20
-#: lib/branch_delete.tcl:115
-msgid ""
-"Recovering deleted branches is difficult. \n"
-"\n"
-" Delete the selected branches?"
-msgstr ""
-"A t=C3=B6r=C3=B6lt branchek vissza=C3=A1ll=C3=ADt=C3=A1sa bonyolult. =
\n"
-"\n"
-" Biztosan t=C3=B6rli a kiv=C3=A1lasztott brancheket?"
-
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
@@ -2399,7 +2389,7 @@ msgstr "Futtat=C3=A1s: %s..."
=20
 #: lib/tools.tcl:149
 #, tcl-format
-msgid "Tool completed succesfully: %s"
+msgid "Tool completed successfully: %s"
 msgstr "Az eszk=C3=B6z sikeresen befejez=C5=91d=C3=B6tt: %s"
=20
 #: lib/tools.tcl:151
diff --git a/po/it.po b/po/it.po
index 294e595..762632c 100644
--- a/po/it.po
+++ b/po/it.po
@@ -778,16 +778,6 @@ msgstr "Sempre (Non effettuare verifiche di fusion=
e)."
 msgid "The following branches are not completely merged into %s:"
 msgstr "I rami seguenti non sono stati fusi completamente in %s:"
=20
-#: lib/branch_delete.tcl:115
-msgid ""
-"Recovering deleted branches is difficult. \n"
-"\n"
-" Delete the selected branches?"
-msgstr ""
-"Ricomporre rami cancellati pu=C3=B2 essere complicato. \n"
-"\n"
-" Eliminare i rami selezionati?"
-
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
@@ -2418,7 +2408,7 @@ msgstr "Eseguo: %s"
=20
 #: lib/tools.tcl:149
 #, tcl-format
-msgid "Tool completed succesfully: %s"
+msgid "Tool completed successfully: %s"
 msgstr "Il programma esterno =C3=A8 terminato con successo: %s"
=20
 #: lib/tools.tcl:151
diff --git a/po/ja.po b/po/ja.po
index 09d60be..63c4695 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -773,16 +773,6 @@ msgstr "=E7=84=A1=E6=9D=A1=E4=BB=B6(=E3=83=9E=E3=83=
=BC=E3=82=B8=E3=83=86=E3=82=B9=E3=83=88=E3=81=97=E3=81=AA=E3=81=84)"
 msgid "The following branches are not completely merged into %s:"
 msgstr "=E4=BB=A5=E4=B8=8B=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AF %s =E3=81=AB=E5=AE=8C=E5=85=A8=E3=81=AB=E3=83=9E=E3=83=BC=E3=82=
=B8=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=E3=82=93:"
=20
-#: lib/branch_delete.tcl:115
-msgid ""
-"Recovering deleted branches is difficult. \n"
-"\n"
-" Delete the selected branches?"
-msgstr ""
-"=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=82=92=E5=89=8A=E9=99=A4=E3=81=
=99=E3=82=8B=E3=81=A8=E5=85=83=E3=81=AB=E6=88=BB=E3=81=99=E3=81=AE=E3=81=
=AF=E5=9B=B0=E9=9B=A3=E3=81=A7=E3=81=99=E3=80=82 \n"
-"\n"
-" =E9=81=B8=E6=8A=9E=E3=81=97=E3=81=9F=E3=83=96=E3=83=A9=E3=83=B3=E3=83=
=81=E3=82=92=E5=89=8A=E9=99=A4=E3=81=97=E3=81=BE=E3=81=99=E3=81=8B=EF=BC=
=9F"
-
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
@@ -2382,7 +2372,7 @@ msgstr "=E5=AE=9F=E8=A1=8C=E4=B8=AD: %s"
=20
 #: lib/tools.tcl:149
 #, tcl-format
-msgid "Tool completed succesfully: %s"
+msgid "Tool completed successfully: %s"
 msgstr "=E3=83=84=E3=83=BC=E3=83=AB=E3=81=8C=E5=AE=8C=E4=BA=86=E3=81=97=
=E3=81=BE=E3=81=97=E3=81=9F: %s"
=20
 #: lib/tools.tcl:151
diff --git a/po/nb.po b/po/nb.po
index 1c5137d..6de93c2 100644
--- a/po/nb.po
+++ b/po/nb.po
@@ -761,16 +761,6 @@ msgstr "Alltid (Ikke utf=C3=B8r sammensl=C3=A5ings=
test.)"
 msgid "The following branches are not completely merged into %s:"
 msgstr "F=C3=B8lgende grener er ikke fullstendig sl=C3=A5tt sammen med=
 %s:"
=20
-#: lib/branch_delete.tcl:115
-msgid ""
-"Recovering deleted branches is difficult. \n"
-"\n"
-" Delete the selected branches?"
-msgstr ""
-"Gjenoppretting av fjernede grener er vanskelig. \n"
-"\n"
-" Fjern valgte grener?"
-
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
@@ -2331,7 +2321,7 @@ msgstr "Kj=C3=B8rer: %s"
=20
 #: lib/tools.tcl:149
 #, tcl-format
-msgid "Tool completed succesfully: %s"
+msgid "Tool completed successfully: %s"
 msgstr "Verkt=C3=B8yet ble fullf=C3=B8rt med suksess: %s"
=20
 #: lib/tools.tcl:151
diff --git a/po/ru.po b/po/ru.po
index db55b3e..04df2aa 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -661,16 +661,6 @@ msgstr "=D0=92=D1=81=D0=B5=D0=B3=D0=B4=D0=B0 (=D0=BD=
=D0=B5 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D1=8F=D1=82=D1=8C =D0=BF=D1=
=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D1=83 =D0=BD=D0=B0 =D0=BE=D0=B1=D1=8A=
=D0=B5=D0=B4=D0=B8
 msgid "The following branches are not completely merged into %s:"
 msgstr "=D0=A1=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=B5 =D0=B2=D0=
=B5=D1=82=D0=B2=D0=B8 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=
=BD=D1=8B =D1=81 %s =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=
=82=D1=8C=D1=8E:"
=20
-#: lib/branch_delete.tcl:115
-msgid ""
-"Recovering deleted branches is difficult. \n"
-"\n"
-" Delete the selected branches?"
-msgstr ""
-"=D0=92=D0=BE=D1=81=D1=81=D1=82=D0=B0=D0=BD=D0=B0=D0=B2=D0=BB=D0=B8=D0=
=B2=D0=B0=D1=82=D1=8C =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=
=B5 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D1=81=D0=BB=D0=BE=D0=B6=D0=BD=D0=BE=
=2E \n"
-"\n"
-" =D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=B1=D1=80=D0=
=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8?"
-
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
diff --git a/po/sv.po b/po/sv.po
index 167654c..c1535f9 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -780,16 +780,6 @@ msgstr "Alltid (utf=C3=B6r inte sammanslagningstes=
t)."
 msgid "The following branches are not completely merged into %s:"
 msgstr "F=C3=B6ljande grenar =C3=A4r inte till fullo sammanslagna med =
%s:"
=20
-#: lib/branch_delete.tcl:115
-msgid ""
-"Recovering deleted branches is difficult. \n"
-"\n"
-" Delete the selected branches?"
-msgstr ""
-"Det =C3=A4r sv=C3=A5rt att =C3=A5terst=C3=A4lla borttagna grenar.\n"
-"\n"
-" Ta bort valda grenar?"
-
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
@@ -2398,7 +2388,7 @@ msgstr "Exekverar: %s"
=20
 #: lib/tools.tcl:149
 #, tcl-format
-msgid "Tool completed succesfully: %s"
+msgid "Tool completed successfully: %s"
 msgstr "Verktyget avslutades framg=C3=A5ngsrikt: %s"
=20
 #: lib/tools.tcl:151
diff --git a/po/zh_cn.po b/po/zh_cn.po
index d2c6866..91c1be2 100644
--- a/po/zh_cn.po
+++ b/po/zh_cn.po
@@ -676,16 +676,6 @@ msgstr "=E6=80=BB=E6=98=AF=E5=90=88=E5=B9=B6 (=E4=B8=
=8D=E4=BD=9C=E5=90=88=E5=B9=B6=E6=B5=8B=E8=AF=95.)"
 msgid "The following branches are not completely merged into %s:"
 msgstr "=E4=B8=8B=E5=88=97=E5=88=86=E6=94=AF=E6=B2=A1=E6=9C=89=E5=AE=8C=
=E5=85=A8=E8=A2=AB=E5=90=88=E5=B9=B6=E5=88=B0 %s:"
=20
-#: lib/branch_delete.tcl:115
-msgid ""
-"Recovering deleted branches is difficult. \n"
-"\n"
-" Delete the selected branches?"
-msgstr ""
-"=E6=81=A2=E5=A4=8D=E8=A2=AB=E5=88=A0=E9=99=A4=E7=9A=84=E5=88=86=E6=94=
=AF=E9=9D=9E=E5=B8=B8=E5=9B=B0=E9=9A=BE.\n"
-"\n"
-"=E6=98=AF=E5=90=A6=E8=A6=81=E5=88=A0=E9=99=A4=E6=89=80=E9=80=89=E5=88=
=86=E6=94=AF?"
-
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
--=20
1.6.2.1
