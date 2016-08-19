Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648B81FD99
	for <e@80x24.org>; Fri, 19 Aug 2016 09:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754176AbcHSJiZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 05:38:25 -0400
Received: from mout.web.de ([212.227.15.14]:64886 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752848AbcHSJiY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 05:38:24 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MUBPu-1bitNf0yMU-00R3Zr; Fri, 19 Aug 2016 11:31:49
 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/1] t0027: Rename NotNormalized (NNO) into CRLF in index
Date:   Fri, 19 Aug 2016 11:41:30 +0200
Message-Id: <20160819094130.21140-1-tboegi@web.de>
X-Mailer: git-send-email 2.9.3.599.g2376d31.dirty
In-Reply-To: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ytplR14oOzoJwnl7l5JbB1/2fgZlOU6aD6XkddsGu6NomBQvgUa
 jtnZF8zW6VNt6vvAglaucgfLZ4+Uz/7E74GlaJmcfm0qWZk/jjD8GEZ7lm5+IGcBCyOXOJZ
 6AQSnso1MsSdk9vZ3KBWXt8ReEZIYRWHDgFE/ld9TH5knIXDHO52dBDJsEXzhlWLFm6XZAH
 KFYT/+MnH2417RRKwnnXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zw0BrbGqPt0=:cNFgb1qN5kzOLk071sPPz0
 YsWbsPxzH3WHNhIs5pnxivHa7Rsd9swgYPVVFzlMtLiEemVaaRRgvVa53hQOtHPceohEM4OJ3
 DPXgeBPpQeQf9C9JdB2Huf8lcn9yVAX7K4xkGNre9K0xNcROqKFK4tfOQNppnZNmVq9idvweq
 r9iI7cfFxpVCcf5NH+SlQQcT4WAxjVAJy2PeEsqZwswzfKj18WlMUSzmLO2s1nc/OZWoDeA27
 fBvSeQr3jpH9Dfymymealc1YMh5YKSnIU86uppG3t6CsabfKLHHbvxv87ctDNMHtS+fLZnQru
 VQUm5DySGZmM15P2t7J61deHMnwXksKHbKqEUUsxLsn4MPWlweVinT/sSRih+4IhSeIcqwIsG
 dwmzih0InaqgbnCDlhJwRiU9NJZME1V1LgOur+JYkyxWWqXBS7MvhuZMLeVNjQReE3JVSvq8K
 2jeN5DalVRBFl6XmFKpzqmnnir6UeMf/8NxmEvQ+0RarMlsorzqmdOURhnQ4TLK2q8eJROMeH
 t8bqVljgnERaiuzHK7ALGyemLC2brYIi2d+hF0A3r5S6dNIln5kbd0YjZHicJ4soyGU7Dvl0b
 GfWj2MnG1UagEUlRULCjih039GywwTVQS+aYUwiSTIiZ0UoBnWPCi4VBCmB7Vu8GPkSKlAPn3
 ijvUMUqG/n55Sx81Y0OVYM3mSJN1C73F7LJI2qLz22XdnVes8aspwPeVTbePBkpoUyIjjnzS6
 wx1IsQiZMEfQEp6D7riDfnv6Nll4FYfhNU3So67jujkLxzEAQTlZjwb3roqk1oCSZMPYFQRQj
 vcNfw6K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Originally NNO stands for content, that had been commited
"Not NOrmalized", in other words files with CRLF in the index.

Make more clear what should be tested:
- commit a file with CRLF into the index
- Change the content in the working tree
- Run "git add" and check for the conversion warnings
- Repeat for different content (text, LF, CRLF, mixed) and
  binary (LF and lone CR, CRLF with NUL)

Rename commit_chk_wrnNNO() into CRI_add_chk_wrn() and rename NNO into CRI.

Integrate create_NNO_files() into 'setup master'

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 t/t0027-auto-crlf.sh | 122 +++++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 90db54c..bfcf14b 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -49,24 +49,6 @@ create_gitattributes () {
 	} >.gitattributes
 }
 
-create_NNO_files () {
-	for crlf in false true input
-	do
-		for attr in "" auto text -text
-		do
-			for aeol in "" lf crlf
-			do
-				pfx=NNO_attr_${attr}_aeol_${aeol}_${crlf}
-				cp CRLF_mix_LF ${pfx}_LF.txt &&
-				cp CRLF_mix_LF ${pfx}_CRLF.txt &&
-				cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
-				cp CRLF_mix_LF ${pfx}_LF_mix_CR.txt &&
-				cp CRLF_mix_LF ${pfx}_CRLF_nul.txt
-			done
-		done
-	done
-}
-
 check_warning () {
 	case "$1" in
 	LF_CRLF) echo "warning: LF will be replaced by CRLF" >"$2".expect ;;
@@ -102,7 +84,7 @@ commit_check_warn () {
 	check_warning "$crlfnul" ${pfx}_CRLF_nul.err
 }
 
-commit_chk_wrnNNO () {
+CRI_add_chk_wrn () {
 	attr=$1 ; shift
 	aeol=$1 ; shift
 	crlf=$1 ; shift
@@ -111,7 +93,7 @@ commit_chk_wrnNNO () {
 	lfmixcrlf=$1 ; shift
 	lfmixcr=$1 ; shift
 	crlfnul=$1 ; shift
-	pfx=NNO_attr_${attr}_aeol_${aeol}_${crlf}
+	pfx=CRI_attr_${attr}_aeol_${aeol}_${crlf}
 	#Commit files on top of existing file
 	create_gitattributes "$attr" $aeol &&
 	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
@@ -122,22 +104,22 @@ commit_chk_wrnNNO () {
 		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
 	done
 
-	test_expect_success "commit NNO files crlf=$crlf attr=$attr LF" '
+	test_expect_success "CRLF in index add file crlf=$crlf attr=$attr LF" '
 		check_warning "$lfwarn" ${pfx}_LF.err
 	'
-	test_expect_success "commit NNO files attr=$attr aeol=$aeol crlf=$crlf CRLF" '
+	test_expect_success "CRLF in index add file attr=$attr aeol=$aeol crlf=$crlf CRLF" '
 		check_warning "$crlfwarn" ${pfx}_CRLF.err
 	'
 
-	test_expect_success "commit NNO files attr=$attr aeol=$aeol crlf=$crlf CRLF_mix_LF" '
+	test_expect_success "CRLF in index add file attr=$attr aeol=$aeol crlf=$crlf CRLF_mix_LF" '
 		check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err
 	'
 
-	test_expect_success "commit NNO files attr=$attr aeol=$aeol crlf=$crlf LF_mix_cr" '
+	test_expect_success "CRLF in index add file attr=$attr aeol=$aeol crlf=$crlf LF_mix_cr" '
 		check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err
 	'
 
-	test_expect_success "commit NNO files attr=$attr aeol=$aeol crlf=$crlf CRLF_nul" '
+	test_expect_success "CRLF in index add file attr=$attr aeol=$aeol crlf=$crlf CRLF_nul" '
 		check_warning "$crlfnul" ${pfx}_CRLF_nul.err
 	'
 }
@@ -199,7 +181,7 @@ check_files_in_repo () {
 	compare_files $crlfnul ${pfx}CRLF_nul.txt
 }
 
-check_in_repo_NNO () {
+check_in_repo_CRI () {
 	attr=$1 ; shift
 	aeol=$1 ; shift
 	crlf=$1 ; shift
@@ -208,7 +190,7 @@ check_in_repo_NNO () {
 	lfmixcrlf=$1 ; shift
 	lfmixcr=$1 ; shift
 	crlfnul=$1 ; shift
-	pfx=NNO_attr_${attr}_aeol_${aeol}_${crlf}
+	pfx=CRI_attr_${attr}_aeol_${aeol}_${crlf}
 	test_expect_success "compare_files $lfname ${pfx}_LF.txt" '
 		compare_files $lfname ${pfx}_LF.txt
 	'
@@ -329,8 +311,22 @@ test_expect_success 'setup master' '
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\r\nLINETWO\rLINETHREE"   >CRLF_mix_CR &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONEQ\r\nLINETWO\r\nLINETHREE" | q_to_nul >CRLF_nul &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONEQ\nLINETWO\nLINETHREE" | q_to_nul >LF_nul &&
-	create_NNO_files CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF &&
-	git -c core.autocrlf=false add NNO_*.txt &&
+	for crlf in false true input
+	do
+		for attr in "" auto text -text
+		do
+			for aeol in "" lf crlf
+			do
+				pfx=CRI_attr_${attr}_aeol_${aeol}_${crlf}
+				cp CRLF_mix_LF ${pfx}_LF.txt &&
+				cp CRLF_mix_LF ${pfx}_CRLF.txt &&
+				cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
+				cp CRLF_mix_LF ${pfx}_LF_mix_CR.txt &&
+				cp CRLF_mix_LF ${pfx}_CRLF_nul.txt
+			done
+		done
+	done &&
+	git -c core.autocrlf=false add CRI_*.txt &&
 	git commit -m "mixed line endings" &&
 	test_tick
 '
@@ -391,33 +387,37 @@ test_expect_success 'commit files attr=crlf' '
 	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF" ""
 '
 
-#                 attr                    LF        CRLF      CRLFmixLF   LF_mix_CR   CRLFNUL
-commit_chk_wrnNNO ""      ""      false   ""        ""        ""          ""          ""
-commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""          ""          ""
-commit_chk_wrnNNO ""      ""      input   ""        ""        ""          ""          ""
-
-commit_chk_wrnNNO "auto"  ""      false   "$WILC"   ""        ""          ""          ""
-commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        ""          ""          ""
-commit_chk_wrnNNO "auto"  ""      input   ""        ""        ""          ""          ""
+# Files had been commited with CRLF. run "git add" with different content and
+# check if
+# warning: LF will be replaced by CRLF or
+# warning: CRLF will be replaced by LF are written to stderr
+#               attr                    LF        CRLF      CRLFmixLF   LF_mix_CR   CRLFNUL
+CRI_add_chk_wrn ""      ""      false   ""        ""        ""          ""          ""
+CRI_add_chk_wrn ""      ""      true    LF_CRLF   ""        ""          ""          ""
+CRI_add_chk_wrn ""      ""      input   ""        ""        ""          ""          ""
+
+CRI_add_chk_wrn "auto"  ""      false   "$WILC"   ""        ""          ""          ""
+CRI_add_chk_wrn "auto"  ""      true    LF_CRLF   ""        ""          ""          ""
+CRI_add_chk_wrn "auto"  ""      input   ""        ""        ""          ""          ""
 for crlf in true false input
 do
-	commit_chk_wrnNNO -text ""      $crlf   ""        ""        ""          ""          ""
-	commit_chk_wrnNNO -text lf      $crlf   ""        ""        ""          ""          ""
-	commit_chk_wrnNNO -text crlf    $crlf   ""        ""        ""          ""          ""
-	commit_chk_wrnNNO ""    lf      $crlf   ""       CRLF_LF    CRLF_LF      ""         CRLF_LF
-	commit_chk_wrnNNO ""    crlf    $crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
-	commit_chk_wrnNNO auto  lf    	$crlf   ""        ""        ""          ""          ""
-	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF   ""        ""          ""          ""
-	commit_chk_wrnNNO text  lf    	$crlf   ""       CRLF_LF    CRLF_LF     ""          CRLF_LF
-	commit_chk_wrnNNO text  crlf  	$crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
+	CRI_add_chk_wrn -text ""      $crlf   ""        ""        ""          ""          ""
+	CRI_add_chk_wrn -text lf      $crlf   ""        ""        ""          ""          ""
+	CRI_add_chk_wrn -text crlf    $crlf   ""        ""        ""          ""          ""
+	CRI_add_chk_wrn ""    lf      $crlf   ""        CRLF_LF   CRLF_LF      ""         CRLF_LF
+	CRI_add_chk_wrn ""    crlf    $crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
+	CRI_add_chk_wrn auto  lf    	$crlf   ""        ""        ""          ""          ""
+	CRI_add_chk_wrn auto  crlf  	$crlf   LF_CRLF   ""        ""          ""          ""
+	CRI_add_chk_wrn text  lf    	$crlf   ""        CRLF_LF   CRLF_LF     ""          CRLF_LF
+	CRI_add_chk_wrn text  crlf  	$crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
 done
 
-commit_chk_wrnNNO "text"  ""      false   "$WILC"   "$WICL"   "$WAMIX"    "$WILC"     "$WICL"
-commit_chk_wrnNNO "text"  ""      true    LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
-commit_chk_wrnNNO "text"  ""      input   ""        CRLF_LF   CRLF_LF     ""          CRLF_LF
+CRI_add_chk_wrn   text  ""      false   "$WILC"   "$WICL"   "$WAMIX"    "$WILC"     "$WICL"
+CRI_add_chk_wrn   text  ""      true    LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
+CRI_add_chk_wrn   text  ""      input   ""        CRLF_LF   CRLF_LF     ""          CRLF_LF
 
-test_expect_success 'commit NNO and cleanup' '
-	git commit -m "commit files on top of NNO" &&
+test_expect_success 'commit files with CRLF in index CRI and cleanup' '
+	git commit -m "commit files on top of CRLF" &&
 	rm -f *.txt &&
 	git -c core.autocrlf=false reset --hard
 '
@@ -449,16 +449,16 @@ test_expect_success 'commit -text' '
 for crlf in true false input
 do
 	#                 attr  aeol           LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLFNUL
-	check_in_repo_NNO ""    ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
-	check_in_repo_NNO -text ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
-	check_in_repo_NNO -text lf     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
-	check_in_repo_NNO -text crlf   $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
-	check_in_repo_NNO auto  ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
-	check_in_repo_NNO auto  lf     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
-	check_in_repo_NNO auto  crlf   $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
-	check_in_repo_NNO text  ""     $crlf   LF  LF    LF           LF_mix_CR  LF_nul
-	check_in_repo_NNO text  lf     $crlf   LF  LF    LF           LF_mix_CR  LF_nul
-	check_in_repo_NNO text  crlf   $crlf   LF  LF    LF           LF_mix_CR  LF_nul
+	check_in_repo_CRI ""    ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
+	check_in_repo_CRI -text ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
+	check_in_repo_CRI -text lf     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
+	check_in_repo_CRI -text crlf   $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
+	check_in_repo_CRI auto  ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
+	check_in_repo_CRI auto  lf     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
+	check_in_repo_CRI auto  crlf   $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_CR  CRLF_nul
+	check_in_repo_CRI text  ""     $crlf   LF  LF    LF           LF_mix_CR  LF_nul
+	check_in_repo_CRI text  lf     $crlf   LF  LF    LF           LF_mix_CR  LF_nul
+	check_in_repo_CRI text  crlf   $crlf   LF  LF    LF           LF_mix_CR  LF_nul
 done
 ################################################################################
 # Check how files in the repo are changed when they are checked out
-- 
2.9.3.599.g2376d31.dirty

