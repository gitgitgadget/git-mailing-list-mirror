Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42B4C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348307AbiC3RDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349175AbiC3RDF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:03:05 -0400
X-Greylist: delayed 2460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 10:01:18 PDT
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B84438BDE
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:01:17 -0700 (PDT)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Fi/CqLrrNiKwoVsY0M2q/kYNnrlACcY9FOczkCYMB9/HHiHONCYhzJOwG0/W+t+tjr6uKVkRjpUDaQb7WCLpsEzBe3h7Qxdm1MvlA0LnmAP3OCbXJv7fPLRTMpCJre27Pxp2aX/S429WdqqEkgL39XiP5nqW3k3gRAt8zUjjkTbc1UBt9f+O+MQHS2cFr9F3macDdgUlRyuZ5ojq1qGkDD60jR7h9c9QEo7FAySkIkaNkclSMwof4mU1RMvw2u9qqGobuJEuRWt/tIBd2D+KN0Al/U9f7srGTnU1HzjJ84Va/KGq90TDQzUdcSXSjkaWt4d411VhjRuulDB6Fsj68w==; s=purelymail3; d=slashdev.space; v=1; bh=yA6fHiK2kEsbGCex6LMIDWulxSr0FTbT2w1tU8K3b60=; h=Received:From:To;
DKIM-Signature: a=rsa-sha256; b=eX00rhsb3B9MgNEMiJh2/lQWG91x8oes/AQsZgZEHwyAvUkL5XDS2pOb4FVUN8EMddnaGEGkWlJkdErE4FKLPBU9kIVluOZNAmwBgxtLLMggMeqWvC3OL65d6fHHPmV0RJAQWjQUi/227ZAnhPlNr1FDGpXcbcCptBwwyVU9MYbhGHYt90Avxw+AglYxgxtyt35FXULu1/zcyowG0MROikV+nt5zpP2iGSxWSMH8+Dk8cv+i8jvbSwMxDKg46OKYcfN/ls9skXp1psw0goBIivRGBTVtiFAkDuUtlUnRYeB9hin10ned1B+UbTxxL7308dL7TUpEq3V5x2dTTfE+7A==; s=purelymail3; d=purelymail.com; v=1; bh=yA6fHiK2kEsbGCex6LMIDWulxSr0FTbT2w1tU8K3b60=; h=Feedback-ID:Received:From:To;
Feedback-ID: 6471:1573:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 457903941;
          (version=TLSv1.2 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384);
          Wed, 30 Mar 2022 17:01:07 +0000 (UTC)
From:   Garrit Franke <garrit@slashdev.space>
To:     git@vger.kernel.org
Cc:     Garrit Franke <garrit@slashdev.space>
Subject: [PATCH] cli: add -v and -h shorthands
Date:   Wed, 30 Mar 2022 19:00:59 +0200
Message-Id: <20220330170059.5075-1-garrit@slashdev.space>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If "-v" or "-h" is passed as a flag, they will be interpreted as
a "version" or "help" command respectively.

Signed-off-by: Garrit Franke <garrit@slashdev.space>
---
I'm not sure if this was already discussed in the past or if there are
reasons against this, but it would be quite handy if these shorthands
existed for git.

Since this is my first patch for this project, I'm very happy to take
your feedback!

 Documentation/git.txt |  4 +++-
 git.c                 | 15 ++++++++++++---
 po/bg.po              |  4 ++--
 po/ca.po              |  4 ++--
 po/de.po              |  4 ++--
 po/el.po              |  4 ++--
 po/es.po              |  4 ++--
 po/fr.po              |  4 ++--
 po/git.pot            |  2 +-
 po/id.po              |  4 ++--
 po/it.po              |  4 ++--
 po/ko.po              |  4 ++--
 po/pl.po              |  4 ++--
 po/pt_PT.po           |  2 +-
 po/ru.po              |  4 ++--
 po/sv.po              |  4 ++--
 po/tr.po              |  4 ++--
 po/vi.po              |  4 ++--
 po/zh_CN.po           |  4 ++--
 po/zh_TW.po           |  4 ++--
 t/t0012-help.sh       |  2 +-
 21 files changed, 50 insertions(+), 39 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 13f83a2..302607a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,7 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--help] [-C <path>] [-c <name>=3D<value>]
+'git' [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]
     [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<name>]
@@ -39,6 +39,7 @@ or https://git-scm.com/docs.
=20
 OPTIONS
 -------
+-v::
 --version::
 =09Prints the Git suite version that the 'git' program came from.
 +
@@ -46,6 +47,7 @@ This option is internally converted to `git version ...` =
and accepts
 the same options as the linkgit:git-version[1] command. If `--help` is
 also given, it takes precedence over `--version`.
=20
+-h::
 --help::
 =09Prints the synopsis and a list of the most commonly used
 =09commands. If the option `--all` or `-a` is given then all
diff --git a/git.c b/git.c
index a25940d..6888c11 100644
--- a/git.c
+++ b/git.c
@@ -25,7 +25,7 @@ struct cmd_struct {
 };
=20
 const char git_usage_string[] =3D
-=09N_("git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+=09N_("git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>=
]\n"
 =09   "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--i=
nfo-path]\n"
 =09   "           [-p | --paginate | -P | --no-pager] [--no-replace-object=
s] [--bare]\n"
 =09   "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=
=3D<name>]\n"
@@ -146,7 +146,10 @@ static int handle_options(const char ***argv, int *arg=
c, int *envchanged)
 =09=09 * commands can be written with "--" prepended
 =09=09 * to make them look like flags.
 =09=09 */
-=09=09if (!strcmp(cmd, "--help") || !strcmp(cmd, "--version"))
+=09=09if (!strcmp(cmd, "-h") ||
+=09=09=09!strcmp(cmd, "--help") ||
+=09=09=09!strcmp(cmd, "-v") ||
+=09=09=09!strcmp(cmd, "--version"))
 =09=09=09break;
=20
 =09=09/*
@@ -893,7 +896,13 @@ int cmd_main(int argc, const char **argv)
 =09handle_options(&argv, &argc, NULL);
 =09if (argc > 0) {
 =09=09/* translate --help and --version into commands */
-=09=09skip_prefix(argv[0], "--", &argv[0]);
+=09=09if (!strcmp("-v", argv[0])) {
+=09=09=09argv[0] =3D "version";
+=09=09} else if (!strcmp("-h", argv[0])) {
+=09=09=09argv[0] =3D "help";
+=09=09} else {
+=09=09=09skip_prefix(argv[0], "--", &argv[0]);
+=09=09}
 =09} else {
 =09=09/* The user didn't specify a command; give them help */
 =09=09commit_pager_choice();
diff --git a/po/bg.po b/po/bg.po
index 8328531..7f9994b 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -24979,7 +24979,7 @@ msgstr "=D1=81=D0=B0=D0=BC=D0=BE =D0=B7=D0=B0 =D0=
=B8=D0=B7=D1=87=D0=B8=D1=81=D1=82=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=
=B3=D1=80=D0=B5=D1=88=D0=BA=D0=B8"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
@@ -24987,7 +24987,7 @@ msgid ""
 "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]\n=
"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C =D0=9F=D0=AA=D0=A2] [-c =D0=98=D0=9C=D0=95=
=3D=D0=A1=D0=A2=D0=9E=D0=99=D0=9D=D0=9E=D0=A1=D0=A2]\n"
+"git [-v | --version] [-h | --help] [-C =D0=9F=D0=AA=D0=A2] [-c =D0=98=D0=
=9C=D0=95=3D=D0=A1=D0=A2=D0=9E=D0=99=D0=9D=D0=9E=D0=A1=D0=A2]\n"
 "           [--exec-path[=3D=D0=9F=D0=AA=D0=A2]] [--html-path] [--man-path=
] [--info-path]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
diff --git a/po/ca.po b/po/ca.po
index afcffad..33ecccf 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -24451,14 +24451,14 @@ msgstr "nom=C3=A9s =C3=BAtil per a la depuraci=C3=
=B3"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
bare]\n"
 "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<na=
me>]\n"
 "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]\n=
"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
bare]\n"
 "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<na=
me>]\n"
diff --git a/po/de.po b/po/de.po
index 19ffd9a..0ea3f93 100644
--- a/po/de.po
+++ b/po/de.po
@@ -24744,7 +24744,7 @@ msgstr "nur n=C3=BCtzlich f=C3=BCr Fehlersuche"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
@@ -24752,7 +24752,7 @@ msgid ""
 "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]\n=
"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C <Pfad>] [-c <Name>=3D<Wert>]\n"
+"git [-v | --version] [-h | --help] [-C <Pfad>] [-c <Name>=3D<Wert>]\n"
 "           [--exec-path[=3D<Pfad>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
diff --git a/po/el.po b/po/el.po
index 703f46d..7191847 100644
--- a/po/el.po
+++ b/po/el.po
@@ -18927,14 +18927,14 @@ msgstr ""
=20
 #: git.c:27
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
 "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<na=
me>]\n"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C <=CE=B4=CE=B9=CE=B1=CE=B4=CF=81=CE=BF=CE=BC=
=CE=AE>] [-c <=CF=8C=CE=BD=CE=BF=CE=BC=CE=B1>=3D<=CF=84=CE=B9=CE=BC=CE=AE>]=
\n"
+"git [-v | --version] [-h | --help] [-C <=CE=B4=CE=B9=CE=B1=CE=B4=CF=81=CE=
=BF=CE=BC=CE=AE>] [-c <=CF=8C=CE=BD=CE=BF=CE=BC=CE=B1>=3D<=CF=84=CE=B9=CE=
=BC=CE=AE>]\n"
 "           [--exec-path[=3D<=CE=B4=CE=B9=CE=B1=CE=B4=CF=81=CE=BF=CE=BC=CE=
=AE>]] [--html-path] [--man-path] [--info-"
 "path]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
diff --git a/po/es.po b/po/es.po
index ced2eb6..a812bf4 100644
--- a/po/es.po
+++ b/po/es.po
@@ -24475,7 +24475,7 @@ msgstr "solo =C3=BAtil para depurar"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
@@ -24483,7 +24483,7 @@ msgid ""
 "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]\n=
"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C <ruta>] [-c <nombre>=3D<valor>]\n"
+"git [-v | --version] [-h | --help] [-C <ruta>] [-c <nombre>=3D<valor>]\n"
 "            [--exec-path [=3D <path>]] [--html-path] [--man-path] [--info=
-"
 "path]\n"
 "            [-p | --paginate | -P | --no-pager] [--no-replace-objects] [-=
-"
diff --git a/po/fr.po b/po/fr.po
index fc00401..da60c9c 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -24687,7 +24687,7 @@ msgstr "seulement utile pour le d=C3=A9bogage"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
@@ -24695,7 +24695,7 @@ msgid ""
 "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]\n=
"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C <chemin>] [-c <nom>=3D<valeur>]\n"
+"git [-v | --version] [-h | --help] [-C <chemin>] [-c <nom>=3D<valeur>]\n"
 "           [--exec-path[=3D<chemin>]] [--html-path] [--man-path] [--info-=
"
 "path]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
diff --git a/po/git.pot b/po/git.pot
index 196249a..2cb3747 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -22653,7 +22653,7 @@ msgstr ""
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
diff --git a/po/id.po b/po/id.po
index aa6f170..edb702e 100644
--- a/po/id.po
+++ b/po/id.po
@@ -23740,7 +23740,7 @@ msgstr "hanya berguna untuk penirkutuan"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
@@ -23748,7 +23748,7 @@ msgid ""
 "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]\n=
"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C <jalur>] [-c <nama>=3D<nilai>]\n"
+"git [-v | --version] [-h | --help] [-C <jalur>] [-c <nama>=3D<nilai>]\n"
 "           [--exec-path[=3D<jalur>]] [--html-path] [--man-path] [--info-p=
ath]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
diff --git a/po/it.po b/po/it.po
index c315608..d003e24 100644
--- a/po/it.po
+++ b/po/it.po
@@ -23422,14 +23422,14 @@ msgstr "esci subito dopo aver annunciato le funzi=
onalit=C3=A0"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
 "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<na=
me>]\n"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C <percorso>] [-c <nome>=3D<valore>]\n"
+"git [-v | --version] [-h | --help] [-C <percorso>] [-c <nome>=3D<valore>]=
\n"
 "           [--exec-path[=3D<percorso>]] [--html-path] [--man-path] [--inf=
o-"
 "path]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
diff --git a/po/ko.po b/po/ko.po
index 5d190e5..bd41856 100644
--- a/po/ko.po
+++ b/po/ko.po
@@ -15225,14 +15225,14 @@ msgstr "=EB=94=94=EB=B2=84=EA=B9=85 =EB=A9=94=EC=
=8B=9C=EC=A7=80=EB=A5=BC =ED=91=9C=EC=A4=80=EC=98=A4=EB=A5=98=EB=A1=9C =EC=
=B6=9C=EB=A0=A5=ED=95=A9=EB=8B=88=EB=8B=A4"
=20
 #: git.c:27
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
 "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<na=
me>]\n"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C <=EA=B2=BD=EB=A1=9C>] [-c <=EC=9D=B4=EB=A6=
=84>=3D<=EA=B0=92>]\n"
+"git [-v | --version] [-h | --help] [-C <=EA=B2=BD=EB=A1=9C>] [-c <=EC=9D=
=B4=EB=A6=84>=3D<=EA=B0=92>]\n"
 "           [--exec-path[=3D<=EA=B2=BD=EB=A1=9C>]] [--html-path] [--man-pa=
th] [--info-path]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
diff --git a/po/pl.po b/po/pl.po
index 0ec127e..de64558 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -24406,7 +24406,7 @@ msgstr "przydatne tylko do odpluskwiania"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
@@ -24414,7 +24414,7 @@ msgid ""
 "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]\n=
"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C <=C5=9Bcie=C5=BCka>] [-c <nazwa>=3D<warto=C5=
=9B=C4=87>]\n"
+"git [-v | --version] [-h | --help] [-C <=C5=9Bcie=C5=BCka>] [-c <nazwa>=
=3D<warto=C5=9B=C4=87>]\n"
 "           [--exec-path[=3D<=C5=9Bcie=C5=BCka>]] [--html-path] [--man-pat=
h] [--info-"
 "path]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
diff --git a/po/pt_PT.po b/po/pt_PT.po
index 70e5c6d..912cb12 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -23666,7 +23666,7 @@ msgstr "apenas =C3=BAtil para depura=C3=A7=C3=A3o"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
diff --git a/po/ru.po b/po/ru.po
index 993d106..2de033a 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -21748,12 +21748,12 @@ msgstr ""
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
bare]\n"
 "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<na=
me>]\n"
 "           <command> [<args>]"
-msgstr "git [--version] [--help] [-C <=D0=BF=D1=83=D1=82=D1=8C>] [-c <=D0=
=B8=D0=BC=D1=8F>=3D<=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B8=D0=B5>]\n   =
        [--exec-path[=3D<=D0=BF=D1=83=D1=82=D1=8C>]] [--html-path] [--man-p=
ath] [--info-path]\n           [-p | --paginate | -P | --no-pager] [--no-re=
place-objects] [--bare]\n           [--git-dir=3D<=D0=BF=D1=83=D1=82=D1=8C>=
] [--work-tree=3D<=D0=BF=D1=83=D1=82=D1=8C>] [--namespace=3D<=D0=B8=D0=BC=
=D1=8F>]\n           <=D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0> [<=D0=B0=
=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D1=8B>]"
+msgstr "git [-v | --version] [-h | --help] [-C <=D0=BF=D1=83=D1=82=D1=8C>]=
 [-c <=D0=B8=D0=BC=D1=8F>=3D<=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B8=D0=
=B5>]\n           [--exec-path[=3D<=D0=BF=D1=83=D1=82=D1=8C>]] [--html-path=
] [--man-path] [--info-path]\n           [-p | --paginate | -P | --no-pager=
] [--no-replace-objects] [--bare]\n           [--git-dir=3D<=D0=BF=D1=83=D1=
=82=D1=8C>] [--work-tree=3D<=D0=BF=D1=83=D1=82=D1=8C>] [--namespace=3D<=D0=
=B8=D0=BC=D1=8F>]\n           <=D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0> =
[<=D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D1=8B>]"
=20
 #: git.c:35
 msgid ""
diff --git a/po/sv.po b/po/sv.po
index fd32ede..8b1b1d8 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -24126,7 +24126,7 @@ msgstr "endast anv=C3=A4ndbart vid fels=C3=B6kning"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
@@ -24134,7 +24134,7 @@ msgid ""
 "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]\n=
"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C <s=C3=B6kv=C3=A4g>] [-c <namn>=3D<v=C3=A4rde=
>]\n"
+"git [-v | --version] [-h | --help] [-C <s=C3=B6kv=C3=A4g>] [-c <namn>=3D<=
v=C3=A4rde>]\n"
 "           [--exec-path[=3D<s=C3=B6kv=C3=A4g>]] [--html-path] [--man-path=
] [--info-"
 "path]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
diff --git a/po/tr.po b/po/tr.po
index 6afb871..0f39310 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -24215,7 +24215,7 @@ msgstr "yaln=C4=B1zca hata ay=C4=B1klama i=C3=A7in =
yararl=C4=B1"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
@@ -24223,7 +24223,7 @@ msgid ""
 "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]\n=
"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C <yol>] [-c <ad>=3D<de=C4=9Fer>]\n"
+"git [-v | --version] [-h | --help] [-C <yol>] [-c <ad>=3D<de=C4=9Fer>]\n"
 "           [--exec-path[=3D<yol>]] [--html-path] [--man-path] [--info-pat=
h]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
diff --git a/po/vi.po b/po/vi.po
index 0d5b144..f3ba1bb 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -24290,7 +24290,7 @@ msgstr "ch=E1=BB=89 h=E1=BB=AFu =C3=ADch khi c=E1=
=BA=A7n g=E1=BB=A1 l=E1=BB=97i"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
@@ -24298,7 +24298,7 @@ msgid ""
 "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]\n=
"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C </=C4=91=C6=B0=E1=BB=9Dng/d=E1=BA=ABn/>] [-c=
 <t=C3=AAn>=3D<gi=C3=A1 tr=E1=BB=8B>]\n"
+"git [-v | --version] [-h | --help] [-C </=C4=91=C6=B0=E1=BB=9Dng/d=E1=BA=
=ABn/>] [-c <t=C3=AAn>=3D<gi=C3=A1 tr=E1=BB=8B>]\n"
 "           [--exec-path[=3D</=C4=91=C6=B0=E1=BB=9Dng/d=E1=BA=ABn/>]] [--h=
tml-path] [--man-path] [--info-"
 "path]\n"
 "           [-p | --paginate | -P --no-pager] [--no-replace-objects] [--"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 484f2d8..a91a280 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -23838,7 +23838,7 @@ msgstr "=E5=8F=AA=E5=AF=B9=E8=B0=83=E8=AF=95=E6=9C=
=89=E7=94=A8"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
@@ -23846,7 +23846,7 @@ msgid ""
 "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]\n=
"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C <=E8=B7=AF=E5=BE=84>] [-c <=E5=90=8D=E7=A7=
=B0>=3D<=E5=8F=96=E5=80=BC>]\n"
+"git [-v | --version] [-h | --help] [-C <=E8=B7=AF=E5=BE=84>] [-c <=E5=90=
=8D=E7=A7=B0>=3D<=E5=8F=96=E5=80=BC>]\n"
 "           [--exec-path[=3D<=E8=B7=AF=E5=BE=84>]] [--html-path] [--man-pa=
th] [--info-path]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
diff --git a/po/zh_TW.po b/po/zh_TW.po
index 60fe123..5cad03c 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -23689,7 +23689,7 @@ msgstr "=E5=8F=AA=E5=B0=8D=E9=99=A4=E9=8C=AF=E6=9C=
=89=E7=94=A8"
=20
 #: git.c:28
 msgid ""
-"git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+"git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]\n"
 "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
@@ -23697,7 +23697,7 @@ msgid ""
 "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]\n=
"
 "           <command> [<args>]"
 msgstr ""
-"git [--version] [--help] [-C <=E8=B7=AF=E5=BE=91>] [-c <=E5=90=8D=E7=A8=
=B1>=3D<=E6=95=B8=E5=80=BC>]\n"
+"git [-v | --version] [-h | --help] [-C <=E8=B7=AF=E5=BE=91>] [-c <=E5=90=
=8D=E7=A8=B1>=3D<=E6=95=B8=E5=80=BC>]\n"
 "           [--exec-path[=3D<=E8=B7=AF=E5=BE=91>]] [--html-path] [--man-pa=
th] [--info-path]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--=
"
 "bare]\n"
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 6c3e1f7..6c33a43 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -181,7 +181,7 @@ for cmd in git "git help"
 do
 =09test_expect_success "'$cmd' section spacing" '
 =09=09test_section_spacing_trailer git help <<-\EOF &&
-=09=09usage: git [--version] [--help] [-C <path>] [-c <name>=3D<value>]
+=09=09usage: git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<=
value>]
=20
 =09=09These are common Git commands used in various situations:
=20
--=20
2.35.1

