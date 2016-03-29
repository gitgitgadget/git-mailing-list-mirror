From: tboegi@web.de
Subject: [PATCH v1 5/7] CRLF: unify the "auto" handling
Date: Tue, 29 Mar 2016 15:25:37 +0200
Message-ID: <1459257937-17350-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:23:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aktbm-0001Jv-85
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbcC2NWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 09:22:51 -0400
Received: from mout.web.de ([212.227.15.3]:64206 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393AbcC2NWq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 09:22:46 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0M0hsk-1ZsOZp45eg-00usms; Tue, 29 Mar 2016 15:22:44
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:9DCKlM8FrnLU0i6Xw64fTjaX9/Xz0ZxS9iF+smFs3SGDfWUtI4F
 8tpaJOv8KJHuC/5feoqWS0FPyLpZ0QAuHbyNo3lTVOL8h1kvw2clJmPblGI2uGahnlXnrKW
 kCZFUx9LM2ImWcX7Gxj09adSC+N+KGDDscN3TPFtZpjVzSwrBXjN5j+BTKgwaLKWyJ5GQxq
 e6DxBopLYrK+OBlYbG3Jg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w+FJJDlqDd8=:OHgLB4lq5fQ4Ekjj9VANCh
 Th1cnYhp2a1pQyUYkRhche5VPGcKKVVE6qTOAGFCvF5Px7j78lwZT0SL4kxXa+tNcC5F03EBS
 SBc8z191MgY7bey5HuPxenGkTFynkbuHIyU0sEonPhS6K4g0zan389ad1yGeKfH8cF2DyAViy
 1OAziVVtwnh6wxkkqyPD45IWWE69B8AMX27o4KCrBnG2JwsGxsgcFpQKFBMLNRQl688eyN8uA
 TmKGa74f3Mcc4UgQ5gdv2DdhVtkL5YwqLkA2KiSEMYWPJSm1JRQQkstSOu/X/lUUu9QdijqVr
 QF6PRvQcQup4TXso0jEFipyEm6gbM+K7KZyDwzVx5xxEQPhZL4I2t6TiQCXy4B4Csw1ywKy+u
 kgbbzLQUukzRly3/WylB1nQCgybdh6qPWABALqWrv9BHSfjucN47MpDiwHXQ3eYLQKq5a04Q/
 nuukZiiSav5qjS1IP/Z/NviH7YUp5lRED+ig31fya0WAtG2mAfvH5s3w1lVtKMzrl73liQFAz
 8EerCiEQy8ZtOun/V5DHBI+K0ntswV0YElRLvOy0bXBLRpRqYMyuvlC1Swy0Cww2OZVrmmTbh
 aCq7yJnAd6BTM9PmbisNgKowrBkOiXhhy0c9kdbGSyWpJeHux1tVHq5ETdi8w8PlsK30/m+Di
 MH6nJ12sJDZyKPnDpUm45YID7cYrpGybqcqyZ8SrMQCRN3+ODenQxX70J4cKcTOs05XsAo4gM
 CD8AuMbqnBsQCyhRxI/sTYTVcyAFn6KVTKQ7PFGVUYJ6C0bLSzHjbwWvIm2m74BIE2ONi7bI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290132>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Make .gitattributes "* text=3Dauto eol=3Dcrlf" to do the same as
setting core.autocrlf=3Dtrue and "* text=3Dauto eol=3Dcrlf" the same
as core.autocrlf=3Dinput

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Documentation/config.txt        | 11 +++++-----
 Documentation/gitattributes.txt |  7 ++++---
 convert.c                       | 37 ++++++++++++++++-----------------
 t/t0025-crlf-auto.sh            |  4 ++--
 t/t0027-auto-crlf.sh            | 45 +++++++++++++++++++--------------=
--------
 5 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4a27ad4..3191a42 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -389,14 +389,15 @@ file with mixed line endings would be reported by=
 the `core.safecrlf`
 mechanism.
=20
 core.autocrlf::
-	Setting this variable to "true" is almost the same as setting
-	the `text` attribute to "auto" on all files except that text
-	files are not guaranteed to be normalized: files that contain
+	Setting this variable to "true" is the same as setting
+	the attributes to "auto eol=3Dcrlf" on all files.
+	Files are not guaranteed to be normalized: files that contain
 	`CRLF` in the repository will not be touched.  Use this
 	setting if you want to have `CRLF` line endings in your
-	working directory even though the repository does not have
-	normalized line endings.  This variable can be set to 'input',
+	working directory and he repository has	normalized line endings.
+	This variable can be set to 'input',
 	in which case no output conversion is performed.
+	Note: older versions of Git behave different.
=20
 core.symlinks::
 	If false, symbolic links are checked out as small plain files that
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index e3b1de8..43b70b5 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -115,6 +115,7 @@ text file is normalized, its line endings are conve=
rted to LF in the
 repository.  To control what line ending style is used in the working
 directory, use the `eol` attribute for a single file and the
 `core.eol` configuration variable for all text files.
+Note that `core.autocrlf` overrides `core.eol`
=20
 Set::
=20
@@ -187,8 +188,8 @@ regardless of their content.
=20
 ------------------------
 *.txt		text
-*.vcproj	eol=3Dcrlf
-*.sh		eol=3Dlf
+*.vcproj	text eol=3Dcrlf
+*.sh		text eol=3Dlf
 *.jpg		-text
 ------------------------
=20
@@ -198,7 +199,7 @@ normalization in Git.
=20
 If you simply want to have CRLF line endings in your working directory
 regardless of the repository you are working with, you can set the
-config variable "core.autocrlf" without changing any attributes.
+config variable "core.autocrlf" without using any attributes.
=20
 ------------------------
 [core]
diff --git a/convert.c b/convert.c
index b6da114..4ed5d89 100644
--- a/convert.c
+++ b/convert.c
@@ -229,7 +229,9 @@ static enum eol output_eol(enum crlf_action crlf_ac=
tion)
 		return EOL_LF;
 	case CRLF_UNDEFINED:
 	case CRLF_AUTO_CRLF:
+		return EOL_CRLF;
 	case CRLF_AUTO_INPUT:
+		return EOL_LF;
 	case CRLF_TEXT:
 	case CRLF_AUTO:
 		/* fall through */
@@ -302,15 +304,12 @@ static int crlf_to_git(const char *path, const ch=
ar *src, size_t len,
 	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
 		if (stats.stat_bits & CONVERT_STAT_BITS_BIN)
 			return 0;
-
-		if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action =3D=3D CRLF_AU=
TO_CRLF) {
-			/*
-			 * If the file in the index has any CR in it, do not convert.
-			 * This is the new safer autocrlf handling.
-			 */
-			if (has_cr_in_index(path))
-				return 0;
-		}
+		/*
+		 * If the file in the index has any CR in it, do not convert.
+		 * This is the new safer autocrlf handling.
+		 */
+		if (has_cr_in_index(path))
+			return 0;
 	}
=20
 	check_safe_crlf(path, crlf_action, &stats, checksafe);
@@ -370,12 +369,10 @@ static int crlf_to_worktree(const char *path, con=
st char *src, size_t len,
 		return 0;
=20
 	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
-		if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action =3D=3D CRLF_AU=
TO_CRLF) {
-			/* If we have any CR or CRLF line endings, we do not touch it */
-			/* This is the new safer autocrlf-handling */
-			if (stats.lonecr || stats.crlf )
-				return 0;
-		}
+		/* If we have any CR or CRLF line endings, we do not touch it */
+		/* This is the new safer autocrlf-handling */
+		if (stats.lonecr || stats.crlf )
+			return 0;
=20
 		if (stats.stat_bits & CONVERT_STAT_BITS_BIN)
 			return 0;
@@ -836,7 +833,11 @@ static void convert_attrs(struct conv_attrs *ca, c=
onst char *path)
 		ca->drv =3D git_path_check_convert(ccheck + 2);
 		if (ca->crlf_action !=3D CRLF_BINARY) {
 			enum eol eol_attr =3D git_path_check_eol(ccheck + 3);
-			if (eol_attr =3D=3D EOL_LF)
+			if (ca->crlf_action =3D=3D CRLF_AUTO && eol_attr =3D=3D EOL_LF)
+				ca->crlf_action =3D CRLF_AUTO_INPUT;
+			else if (ca->crlf_action =3D=3D CRLF_AUTO && eol_attr =3D=3D EOL_CR=
LF)
+				ca->crlf_action =3D CRLF_AUTO_CRLF;
+			else if (eol_attr =3D=3D EOL_LF)
 				ca->crlf_action =3D CRLF_TEXT_INPUT;
 			else if (eol_attr =3D=3D EOL_CRLF)
 				ca->crlf_action =3D CRLF_TEXT_CRLF;
@@ -895,9 +896,9 @@ const char *get_convert_attr_ascii(const char *path=
)
 	case CRLF_AUTO:
 		return "text=3Dauto";
 	case CRLF_AUTO_CRLF:
-		return "text=3Dauto eol=3Dcrlf"; /* This is not supported yet */
+		return "text=3Dauto eol=3Dcrlf";
 	case CRLF_AUTO_INPUT:
-		return "text=3Dauto eol=3Dlf"; /* This is not supported yet */
+		return "text=3Dauto eol=3Dlf";
 	}
 	return "";
 }
diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index c164b46..d0bee08 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -114,7 +114,7 @@ test_expect_success 'autocrlf=3Dtrue does not norma=
lize CRLF files' '
 	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
-test_expect_success 'text=3Dauto, autocrlf=3Dtrue _does_ normalize CRL=
=46 files' '
+test_expect_success 'text=3Dauto, autocrlf=3Dtrue does not normalize C=
RLF files' '
=20
 	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	git config core.autocrlf true &&
@@ -126,7 +126,7 @@ test_expect_success 'text=3Dauto, autocrlf=3Dtrue _=
does_ normalize CRLF files' '
 	LFonlydiff=3D$(git diff LFonly) &&
 	CRLFonlydiff=3D$(git diff CRLFonly) &&
 	LFwithNULdiff=3D$(git diff LFwithNUL) &&
-	test -z "$LFonlydiff" -a -n "$CRLFonlydiff" -a -z "$LFwithNULdiff"
+	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
 test_expect_success 'text=3Dauto, autocrlf=3Dtrue does not normalize b=
inary files' '
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 55f45d3..86175cf 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -174,8 +174,8 @@ attr_ascii () {
 	text,lf)   echo "text eol=3Dlf" ;;
 	text,crlf) echo "text eol=3Dcrlf" ;;
 	auto,)     echo "text=3Dauto" ;;
-	auto,lf)   echo "text eol=3Dlf" ;;
-	auto,crlf) echo "text eol=3Dcrlf" ;;
+	auto,lf)   echo "text=3Dauto eol=3Dlf" ;;
+	auto,crlf) echo "text=3Dauto eol=3Dcrlf" ;;
 	lf,)       echo "text eol=3Dlf" ;;
 	crlf,)     echo "text eol=3Dcrlf" ;;
 	,) echo "" ;;
@@ -396,10 +396,9 @@ commit_chk_wrnNNO ""      ""      false   ""      =
  ""        ""          ""
 commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""      =
    ""          ""
 commit_chk_wrnNNO ""      ""      input   ""        ""        ""      =
    ""          ""
=20
-commit_chk_wrnNNO "auto"  ""      false   "$WILC"   "$WICL"   "$WAMIX"=
    ""          ""
-commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        LF_CRLF =
    ""          ""
-commit_chk_wrnNNO "auto"  ""      input   ""        CRLF_LF   CRLF_LF =
    ""          ""
-
+commit_chk_wrnNNO "auto"  ""      false   "$WILC"   ""        ""      =
    ""          ""
+commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        ""      =
    ""          ""
+commit_chk_wrnNNO "auto"  ""      input   ""        ""        ""      =
    ""          ""
 for crlf in true false input;
 do
 	commit_chk_wrnNNO -text ""      $crlf   ""        ""        ""       =
   ""          ""
@@ -407,8 +406,8 @@ do
 	commit_chk_wrnNNO -text crlf    $crlf   ""        ""        ""       =
   ""          ""
 	commit_chk_wrnNNO ""    lf      $crlf   ""       CRLF_LF    CRLF_LF  =
    ""         CRLF_LF
 	commit_chk_wrnNNO ""    crlf    $crlf   LF_CRLF   ""        LF_CRLF  =
   LF_CRLF     ""
-	commit_chk_wrnNNO auto  lf    	$crlf   ""       CRLF_LF    CRLF_LF   =
  ""          CRLF_LF
-	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF   ""        LF_CRLF   =
  LF_CRLF     ""
+	commit_chk_wrnNNO auto  lf    	$crlf   ""        ""        ""        =
  ""          ""
+	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF   ""        ""        =
  ""          ""
 	commit_chk_wrnNNO text  lf    	$crlf   ""       CRLF_LF    CRLF_LF   =
  ""          CRLF_LF
 	commit_chk_wrnNNO text  crlf  	$crlf   LF_CRLF   ""        LF_CRLF   =
  LF_CRLF     ""
 done
@@ -453,9 +452,9 @@ do
 	check_in_repo_NNO -text ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
 	check_in_repo_NNO -text lf     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
 	check_in_repo_NNO -text crlf   $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
-	check_in_repo_NNO auto  ""     $crlf   LF  LF    LF           LF_mix_=
CR  CRLF_nul
-	check_in_repo_NNO auto  lf     $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
-	check_in_repo_NNO auto  crlf   $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
+	check_in_repo_NNO auto  ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
+	check_in_repo_NNO auto  lf     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
+	check_in_repo_NNO auto  crlf   $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
 	check_in_repo_NNO text  ""     $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
 	check_in_repo_NNO text  lf     $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
 	check_in_repo_NNO text  crlf   $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
@@ -513,8 +512,6 @@ do
 	# text: core.autocrlf=3Dfalse and core.eol unset(or native) uses nati=
ve eol
 	checkout_files "text"  "$id"  ""    false  ""       $NL   CRLF  $MIX_=
CRLF_LF $MIX_LF_CR   $LFNUL
 	checkout_files "text"  "$id"  ""    false  native   $NL   CRLF  $MIX_=
CRLF_LF $MIX_LF_CR   $LFNUL
-	checkout_files "auto"  "$id"  ""    false  ""       $NL   CRLF  $MIX_=
CRLF_LF $MIX_LF_CR   $LFNUL
-	checkout_files "auto"  "$id"  ""    false  native   $NL   CRLF  $MIX_=
CRLF_LF $MIX_LF_CR   $LFNUL
=20
 	for ceol in "" lf crlf native;
 	do
@@ -541,30 +538,30 @@ do
 	for ceol in "" lf crlf native;
 	do
 		# core.autocrlf=3Dtrue
-		checkout_files ""      "$id" ""    true   "$ceol"   CRLF  CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
-		checkout_files "auto"  "$id" ""    true   "$ceol"   CRLF  CRLF  CRLF=
         LF_mix_CR    LF_nul
+		checkout_files ""      "$id" ""     true   "$ceol"   CRLF  CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+		checkout_files "auto"  "$id" ""     true   "$ceol"   CRLF  CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+		checkout_files "auto"  "$id"  ""    false   ""       $NL   CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+		checkout_files "auto"  "$id"  ""    false   native   $NL   CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
 		# text=3Dauto + eol=3DXXX
-		# currently the same as text, eol=3DXXX
-		checkout_files "auto"  "$id" "lf"   "$crlf"  "$ceol"    LF    CRLF  =
CRLF_mix_LF  LF_mix_CR    LF_nul
-		checkout_files "auto"  "$id" "crlf" "$crlf"  "$ceol"    CRLF  CRLF  =
CRLF         CRLF_mix_CR  CRLF_nul
+		checkout_files "auto"  "$id" "lf"   "$crlf" "$ceol"  LF    CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+		checkout_files "auto"  "$id" "crlf" "$crlf" "$ceol"  CRLF  CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
 	done
 done
=20
 #Handling with ident
 for id in ident;
 do
-	for crlf in "" true false input;
+	for crlf in true false input;
 	do
 		for ceol in "" lf crlf native;
 		do
 			# ident does not react on core.autocrlf=3Dtrue
-			checkout_files ""      "$id" ""   "$crlf" "$ceol"   LF    CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+			checkout_files ""      "$id" ""     "$crlf" "$ceol"   LF    CRLF  C=
RLF_mix_LF  LF_mix_CR    LF_nul
 			# ident does not react on text=3Dauto
-			checkout_files "auto"  "$id" ""    true   "$ceol"   LF    CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+			checkout_files "auto"  "$id" ""      true   "$ceol"   LF    CRLF  C=
RLF_mix_LF  LF_mix_CR    LF_nul
 			# text=3Dauto + eol=3DXXX
-			# currently the same as text, eol=3DXXX
-			checkout_files "auto"  "$id" "lf"   "$crlf"  "$ceol"    LF    CRLF =
 CRLF_mix_LF  LF_mix_CR    LF_nul
-			checkout_files "auto"  "$id" "crlf" "$crlf"  "$ceol"    CRLF  CRLF =
 CRLF         CRLF_mix_CR  CRLF_nul
+			checkout_files "auto"  "$id" "lf"   "$crlf"  "$ceol"  LF    CRLF  C=
RLF_mix_LF  LF_mix_CR    LF_nul
+			checkout_files "auto"  "$id" "crlf" "$crlf"  "$ceol"  LF    CRLF  C=
RLF_mix_LF  LF_mix_CR    LF_nul
 		done
 	done
 done
--=20
2.8.0.rc2.6.g3847ccb
