From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH 1/3] t0027: Cleanup: rename functions, avoid TABs
Date: Wed, 15 Apr 2015 19:00:28 +0200
Message-ID: <552E992C.7000600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 19:00:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiQgE-0007qx-Cl
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 19:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756796AbbDORAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2015 13:00:40 -0400
Received: from mout.web.de ([212.227.17.12]:50774 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756371AbbDORAc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 13:00:32 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MfqAq-1Z3NsH0DH2-00N9xL; Wed, 15 Apr 2015 19:00:29
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Provags-ID: V03:K0:l6OSPMuhpyTOn0gRGdB4r+vOo0o+0n7Whv+1ChOqg04fmu0qnhV
 U3AW5OhKl7DOqZkmITBFt5S/DSd87aMDIoNFODoRxEnYRK3AJzoAUySAF+V2ReegbxCopQU
 Pvcvx/T+CzQBj/IFyOBen4LQoaL7tO2U0H/XslxKqch+Et5AZTMRCH4Tx1djZd9cDNZhBCL
 UN2HBySHQIDbP1V2y+zZQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267217>

Make more clear what the tests are doing:
  commit_check_warn():
    Commit files and checks for conversion warnings.
    Old name: create_file_in_repo()

  checkout_files():
    Checkout files from the repo and check if they have
    the appropriate line endings in the work space.
    Old name: check_files_in_ws()

Replace non-leading TABS with spaces

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Before this changes manage to stay on the "FINO" stack
(First In, Never Out), I send them as RFC.


 t/t0027-auto-crlf.sh | 184 +++++++++++++++++++++++++------------------=
--------
 1 file changed, 92 insertions(+), 92 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 452320d..5858397 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -68,7 +68,7 @@ check_warning () {
 	esac
 }
=20
-create_file_in_repo () {
+commit_check_warn () {
 	crlf=3D$1
 	attr=3D$2
 	lfname=3D$3
@@ -109,7 +109,7 @@ check_files_in_repo () {
 }
=20
=20
-check_files_in_ws () {
+checkout_files () {
 	eol=3D$1
 	crlf=3D$2
 	attr=3D$3
@@ -169,40 +169,40 @@ test_expect_success 'setup master' '
 warn_LF_CRLF=3D"LF will be replaced by CRLF"
 warn_CRLF_LF=3D"CRLF will be replaced by LF"
=20
-test_expect_success 'add files empty attr' '
-	create_file_in_repo false ""     ""        ""        ""        ""    =
    "" &&
-	create_file_in_repo true  ""     "LF_CRLF" ""        "LF_CRLF" ""    =
    "" &&
-	create_file_in_repo input ""     ""        "CRLF_LF" "CRLF_LF" ""    =
    ""
+test_expect_success 'commit files empty attr' '
+	commit_check_warn false ""     ""        ""        ""        ""      =
  "" &&
+	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" ""      =
  "" &&
+	commit_check_warn input ""     ""        "CRLF_LF" "CRLF_LF" ""      =
  ""
 '
=20
-test_expect_success 'add files attr=3Dauto' '
-	create_file_in_repo false "auto" ""        "CRLF_LF" "CRLF_LF" ""    =
    "" &&
-	create_file_in_repo true  "auto" "LF_CRLF" ""        "LF_CRLF" ""    =
    "" &&
-	create_file_in_repo input "auto" ""        "CRLF_LF" "CRLF_LF" ""    =
    ""
+test_expect_success 'commit files attr=3Dauto' '
+	commit_check_warn false "auto" ""        "CRLF_LF" "CRLF_LF" ""      =
  "" &&
+	commit_check_warn true  "auto" "LF_CRLF" ""        "LF_CRLF" ""      =
  "" &&
+	commit_check_warn input "auto" ""        "CRLF_LF" "CRLF_LF" ""      =
  ""
 '
=20
-test_expect_success 'add files attr=3Dtext' '
-	create_file_in_repo false "text" ""        "CRLF_LF" "CRLF_LF" ""    =
    "CRLF_LF" &&
-	create_file_in_repo true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" ""        &&
-	create_file_in_repo input "text" ""        "CRLF_LF" "CRLF_LF" ""    =
    "CRLF_LF"
+test_expect_success 'commit files attr=3Dtext' '
+	commit_check_warn false "text" ""        "CRLF_LF" "CRLF_LF" ""      =
  "CRLF_LF" &&
+	commit_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""        &&
+	commit_check_warn input "text" ""        "CRLF_LF" "CRLF_LF" ""      =
  "CRLF_LF"
 '
=20
-test_expect_success 'add files attr=3D-text' '
-	create_file_in_repo false "-text" ""       ""        ""        ""    =
    "" &&
-	create_file_in_repo true  "-text" ""       ""        ""        ""    =
    "" &&
-	create_file_in_repo input "-text" ""       ""        ""        ""    =
    ""
+test_expect_success 'commit files attr=3D-text' '
+	commit_check_warn false "-text" ""       ""        ""        ""      =
  "" &&
+	commit_check_warn true  "-text" ""       ""        ""        ""      =
  "" &&
+	commit_check_warn input "-text" ""       ""        ""        ""      =
  ""
 '
=20
-test_expect_success 'add files attr=3Dlf' '
-	create_file_in_repo false "lf"    ""       "CRLF_LF" "CRLF_LF"  ""   =
    "CRLF_LF" &&
-	create_file_in_repo true  "lf"    ""       "CRLF_LF" "CRLF_LF"  ""   =
    "CRLF_LF" &&
-	create_file_in_repo input "lf"    ""       "CRLF_LF" "CRLF_LF"  ""   =
    "CRLF_LF"
+test_expect_success 'commit files attr=3Dlf' '
+	commit_check_warn false "lf"    ""       "CRLF_LF" "CRLF_LF"  ""     =
  "CRLF_LF" &&
+	commit_check_warn true  "lf"    ""       "CRLF_LF" "CRLF_LF"  ""     =
  "CRLF_LF" &&
+	commit_check_warn input "lf"    ""       "CRLF_LF" "CRLF_LF"  ""     =
  "CRLF_LF"
 '
=20
-test_expect_success 'add files attr=3Dcrlf' '
-	create_file_in_repo false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" "" &&
-	create_file_in_repo true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" "" &&
-	create_file_in_repo input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" ""
+test_expect_success 'commit files attr=3Dcrlf' '
+	commit_check_warn false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "" &&
+	commit_check_warn true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "" &&
+	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""
 '
=20
 test_expect_success 'create files cleanup' '
@@ -237,7 +237,7 @@ test_expect_success 'commit -text' '
 ######################################################################=
##########
 # Check how files in the repo are changed when they are checked out
 # How to read the table below:
-# - check_files_in_ws will check multiple files with a combination of =
settings
+# - checkout_files will check multiple files with a combination of set=
tings
 #   and attributes (core.autocrlf=3Dinput is forbidden with core.eol=3D=
crlf)
 # - parameter $1 : core.eol               lf | crlf
 # - parameter $2 : core.autocrlf          false | true | input
@@ -249,8 +249,8 @@ test_expect_success 'commit -text' '
 # - parameter $8 : reference for a file with CRLF and a NUL (should be=
 handled as binary when auto)
=20
 #                                            What we have in the repo:
-#                														 ----------------- EOL in repo --------=
--------
-#                														 LF    CRLF  CRLF_mix_LF  LF_mix_CR    =
CRLF_nul
+#                                            ----------------- EOL in =
repo ----------------
+#                                            LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
 #                   settings with checkout:
 #                   core.   core.   .gitattr
 #                    eol     acrlf
@@ -268,68 +268,68 @@ NL=3DLF
 fi
 export CRLF_MIX_LF_CR MIX NL
=20
-check_files_in_ws    lf      false  ""       LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      true   ""       CRLF  CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      input  ""       LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      false "auto"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      true  "auto"    CRLF  CRLF  CRLF         =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      input "auto"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      false "text"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      true  "text"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-check_files_in_ws    lf      input "text"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      false "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      true  "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      input "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      false "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      true  "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      input "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    lf      false "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-check_files_in_ws    lf      true  "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-check_files_in_ws    lf      input "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-
-check_files_in_ws    crlf    false  ""       LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    crlf    true   ""       CRLF  CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    crlf    false "auto"    CRLF  CRLF  CRLF         =
LF_mix_CR    CRLF_nul
-check_files_in_ws    crlf    true  "auto"    CRLF  CRLF  CRLF         =
LF_mix_CR    CRLF_nul
-check_files_in_ws    crlf    false "text"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-check_files_in_ws    crlf    true  "text"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-check_files_in_ws    crlf    false "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    crlf    true  "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    crlf    false "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    crlf    true  "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    crlf    false "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-check_files_in_ws    crlf    true  "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-
-check_files_in_ws    ""      false  ""       LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    ""      true   ""       CRLF  CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    ""      input  ""       LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    ""      false "auto"    $NL   CRLF  $MIX_CRLF_LF =
LF_mix_CR    CRLF_nul
-check_files_in_ws    ""      true  "auto"    CRLF  CRLF  CRLF         =
LF_mix_CR    CRLF_nul
-check_files_in_ws    ""      input "auto"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    ""      false "text"    $NL   CRLF  $MIX_CRLF_LF =
$MIX_LF_CR   CRLF_nul
-check_files_in_ws    ""      true  "text"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-check_files_in_ws    ""      input "text"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    ""      false "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    ""      true  "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    ""      input "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    ""      false "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    ""      true  "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    ""      input "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    ""      false "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-check_files_in_ws    ""      true  "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-check_files_in_ws    ""      input "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-
-check_files_in_ws    native  false  ""       LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    native  true   ""       CRLF  CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    native  false "auto"    $NL   CRLF  $MIX_CRLF_LF =
LF_mix_CR    CRLF_nul
-check_files_in_ws    native  true  "auto"    CRLF  CRLF  CRLF         =
LF_mix_CR    CRLF_nul
-check_files_in_ws    native  false "text"    $NL   CRLF  $MIX_CRLF_LF =
$MIX_LF_CR   CRLF_nul
-check_files_in_ws    native  true  "text"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-check_files_in_ws    native  false "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    native  true  "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    native  false "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    native  true  "lf"      LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-check_files_in_ws    native  false "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
-check_files_in_ws    native  true  "crlf"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
+checkout_files    lf      false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      input  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      false "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
+checkout_files    lf      input "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      false "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+checkout_files    lf      input "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      input "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      input "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    lf      false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+checkout_files    lf      true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+checkout_files    lf      input "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+
+checkout_files    crlf    false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    crlf    true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    crlf    false "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
+checkout_files    crlf    true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
+checkout_files    crlf    false "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+checkout_files    crlf    true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+checkout_files    crlf    false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    crlf    true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    crlf    false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    crlf    true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    crlf    false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+checkout_files    crlf    true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+
+checkout_files    ""      false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    ""      true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    ""      input  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    ""      false "auto"    $NL   CRLF  $MIX_CRLF_LF LF_=
mix_CR    CRLF_nul
+checkout_files    ""      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
+checkout_files    ""      input "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    ""      false "text"    $NL   CRLF  $MIX_CRLF_LF $MI=
X_LF_CR   CRLF_nul
+checkout_files    ""      true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+checkout_files    ""      input "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    ""      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    ""      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    ""      input "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    ""      false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    ""      true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    ""      input "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    ""      false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+checkout_files    ""      true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+checkout_files    ""      input "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+
+checkout_files    native  false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    native  true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    native  false "auto"    $NL   CRLF  $MIX_CRLF_LF LF_=
mix_CR    CRLF_nul
+checkout_files    native  true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    CRLF_nul
+checkout_files    native  false "text"    $NL   CRLF  $MIX_CRLF_LF $MI=
X_LF_CR   CRLF_nul
+checkout_files    native  true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+checkout_files    native  false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    native  true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    native  false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    native  true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    CRLF_nul
+checkout_files    native  false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+checkout_files    native  true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
=20
 test_done
--=20
2.2.0.rc1.790.ge19fcd2
