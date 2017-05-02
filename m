Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28EBB1F790
	for <e@80x24.org>; Tue,  2 May 2017 15:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750813AbdEBP4i (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 11:56:38 -0400
Received: from mout.web.de ([212.227.15.3]:62691 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbdEBP4h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 11:56:37 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhNaa-1drpCc1i8O-00meNQ; Tue, 02
 May 2017 17:56:34 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] t0027: tests are not expensive; remove t0025
Date:   Tue,  2 May 2017 17:56:31 +0200
Message-Id: <20170502155631.24848-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
References: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:dptc2M5OsaIYpNLOx1bGAXsWQR8h1BDqafg9lELa1Xbji9/R4b8
 KAFBHVHpQ5pmSFEC6H36sYb0qPjhdxU/ekhyi9gGw5v06W86LCTc0RYXyi3ECDgQ+A9YV4O
 XahsmWF/xNv3l9USXgbMM+sGKSny4Q7ZOlYP5I7+Hkw3WPlxrFNFfXddUL7mguuAbFQhqFj
 iBYBcJ/zE8/+7h2q9MxvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w8JMkvZEZDk=:5COCkL7KeM0TzDg3AWHSFV
 JyC8QL17tc90rdfSmyJcHJkf5uMb+EaNoqw/SVrzCvp2uOjLsFyCSJPqnBek7sxGEOBsiiu8F
 fKMVZLs59EXSCMknrjZnZavE3uqRBQsmBMHJJJExf6pjpGMnulz/KLJWo4+qor2uvcrvHuVnl
 4vboT932P2RQM5KNsd5EbVFMqGT51I1TJOSPmXWY+SG9LqwPLlyD+DlRoiVMKdnXOE7jB3RDp
 16OF0rRgR3hXvzM7FW/XcXKPyt+7RiCWK3Slm/TUPrMDLLJksndzl+Q0wx0KEgr6ya+8oY46y
 yeL7aqDMGk8l3UteKX77XLKlRfx/wG3kOCQMzQrCcUw5ClK53Ht2YVJIwx7ADG2EJ7JwArgPf
 de6xdCb1zWy/OBfTb6j48SUt71LLvDFbMehy56cgfSb450WEhz6imhyDFv7GwAYhTwYE8tjuQ
 vvBMy0RgiaW9gQgKMIBPXNHEphhte1ge9fMN7nRSQVLm+utEfEtBAW9cFCQpdoPR1Z3bgDToq
 g9FNaVx++HQMnvm12QuPrqu4UqQTG8ihLA/+xQCrAqjc9jBDAdREB4myXFSqH8L78K6SfCgE4
 PO8SeIzFN/pU3JDl2d3JHeMRq6UhPnA/JQhEbGKM7NmqG4KEhvQPVLsN+vN5AgVF7dKhsCS3J
 D0MWjjqwzEw34oxjN27WvE1wILYTS7k/vq87FYwR4MHm1GNsPh7SN/Oq7qMGVJfcPbRMUSELs
 ZcanSZePlSzJoMdPhTkdluhKYBBkEafqdzvMi2wr4BczHecA9tFDv3+ZKZ+loOt8w8T3G5Qem
 lU9J3AL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

The purpose of t0027 is to test all CRLF related conversions at
"git checkout" and "git add".

Running t0027 under Git for Windows takes 3-4 minutes, so the whole script
had been marked as "EXPENSIVE".

The source code for "Git for Windows" overrides this since 2014:
"t0027 is marked expensive, but really, for MinGW we want to run these
tests always."

Recent "stress" tests show that t0025 if flaky, reported by Lars Schneider,
larsxschneider@gmail.com

All tests from t0025 are covered in t0027 already, so that t0025 can be
retiered:
The execution time for t0027 is 14 seconds under Linux,
and 63 seconds under Mac Os X.
And in case you ask, things are not going significantly faster using a SSD
instead of a spinning disk.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 t/t0025-crlf-auto.sh | 181 ---------------------------------------------------
 t/t0027-auto-crlf.sh |   6 --
 2 files changed, 187 deletions(-)
 delete mode 100755 t/t0025-crlf-auto.sh

diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
deleted file mode 100755
index 89826c5..0000000
--- a/t/t0025-crlf-auto.sh
+++ /dev/null
@@ -1,181 +0,0 @@
-#!/bin/sh
-
-test_description='CRLF conversion'
-
-. ./test-lib.sh
-
-has_cr() {
-	tr '\015' Q <"$1" | grep Q >/dev/null
-}
-
-test_expect_success setup '
-
-	git config core.autocrlf false &&
-
-	for w in Hello world how are you; do echo $w; done >LFonly &&
-	for w in I am very very fine thank you; do echo ${w}Q; done | q_to_cr >CRLFonly &&
-	for w in Oh here is a QNUL byte how alarming; do echo ${w}; done | q_to_nul >LFwithNUL &&
-	git add . &&
-
-	git commit -m initial &&
-
-	LFonly=$(git rev-parse HEAD:LFonly) &&
-	CRLFonly=$(git rev-parse HEAD:CRLFonly) &&
-	LFwithNUL=$(git rev-parse HEAD:LFwithNUL) &&
-
-	echo happy.
-'
-
-test_expect_success 'default settings cause no changes' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git read-tree --reset -u HEAD &&
-
-	! has_cr LFonly &&
-	has_cr CRLFonly &&
-	LFonlydiff=$(git diff LFonly) &&
-	CRLFonlydiff=$(git diff CRLFonly) &&
-	LFwithNULdiff=$(git diff LFwithNUL) &&
-	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
-'
-
-test_expect_success 'crlf=true causes a CRLF file to be normalized' '
-
-	# Backwards compatibility check
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	echo "CRLFonly crlf" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	# Note, "normalized" means that git will normalize it if added
-	has_cr CRLFonly &&
-	CRLFonlydiff=$(git diff CRLFonly) &&
-	test -n "$CRLFonlydiff"
-'
-
-test_expect_success 'text=true causes a CRLF file to be normalized' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	echo "CRLFonly text" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	# Note, "normalized" means that git will normalize it if added
-	has_cr CRLFonly &&
-	CRLFonlydiff=$(git diff CRLFonly) &&
-	test -n "$CRLFonlydiff"
-'
-
-test_expect_success 'eol=crlf gives a normalized file CRLFs with autocrlf=false' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git config core.autocrlf false &&
-	echo "LFonly eol=crlf" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	has_cr LFonly &&
-	LFonlydiff=$(git diff LFonly) &&
-	test -z "$LFonlydiff"
-'
-
-test_expect_success 'eol=crlf gives a normalized file CRLFs with autocrlf=input' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git config core.autocrlf input &&
-	echo "LFonly eol=crlf" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	has_cr LFonly &&
-	LFonlydiff=$(git diff LFonly) &&
-	test -z "$LFonlydiff"
-'
-
-test_expect_success 'eol=lf gives a normalized file LFs with autocrlf=true' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git config core.autocrlf true &&
-	echo "LFonly eol=lf" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	! has_cr LFonly &&
-	LFonlydiff=$(git diff LFonly) &&
-	test -z "$LFonlydiff"
-'
-
-test_expect_success 'autocrlf=true does not normalize CRLF files' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git config core.autocrlf true &&
-	git read-tree --reset -u HEAD &&
-
-	has_cr LFonly &&
-	has_cr CRLFonly &&
-	LFonlydiff=$(git diff LFonly) &&
-	CRLFonlydiff=$(git diff CRLFonly) &&
-	LFwithNULdiff=$(git diff LFwithNUL) &&
-	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
-'
-
-test_expect_success 'text=auto, autocrlf=true does not normalize CRLF files' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git config core.autocrlf true &&
-	echo "* text=auto" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	has_cr LFonly &&
-	has_cr CRLFonly &&
-	LFonlydiff=$(git diff LFonly) &&
-	CRLFonlydiff=$(git diff CRLFonly) &&
-	LFwithNULdiff=$(git diff LFwithNUL) &&
-	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
-'
-
-test_expect_success 'text=auto, autocrlf=true does not normalize binary files' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	git config core.autocrlf true &&
-	echo "* text=auto" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	! has_cr LFwithNUL &&
-	LFwithNULdiff=$(git diff LFwithNUL) &&
-	test -z "$LFwithNULdiff"
-'
-
-test_expect_success 'eol=crlf _does_ normalize binary files' '
-
-	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-	echo "LFwithNUL eol=crlf" > .gitattributes &&
-	git read-tree --reset -u HEAD &&
-
-	has_cr LFwithNUL &&
-	LFwithNULdiff=$(git diff LFwithNUL) &&
-	test -z "$LFwithNULdiff"
-'
-
-test_expect_success 'prepare unnormalized' '
-	> .gitattributes &&
-	git config core.autocrlf false &&
-	printf "LINEONE\nLINETWO\r\n"     >mixed &&
-	git add mixed .gitattributes &&
-	git commit -m "Add mixed" &&
-	git ls-files --eol | egrep "i/crlf" &&
-	git ls-files --eol | egrep "i/mixed"
-'
-
-test_expect_success 'normalize unnormalized' '
-	echo "* text=auto" >.gitattributes &&
-	rm .git/index &&
-	git add . &&
-	git commit -m "Introduce end-of-line normalization" &&
-	git ls-files --eol | tr "\\t" " " | sort >act &&
-cat >exp <<EOF &&
-i/-text w/-text attr/text=auto         LFwithNUL
-i/lf    w/crlf  attr/text=auto         CRLFonly
-i/lf    w/crlf  attr/text=auto         LFonly
-i/lf    w/lf    attr/text=auto         .gitattributes
-i/lf    w/mixed attr/text=auto         mixed
-EOF
-	test_cmp exp act
-'
-
-test_done
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 90db54c..effc3db 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -4,12 +4,6 @@ test_description='CRLF conversion all combinations'
 
 . ./test-lib.sh
 
-if ! test_have_prereq EXPENSIVE
-then
-	skip_all="EXPENSIVE not set"
-	test_done
-fi
-
 compare_files () {
 	tr '\015\000' QN <"$1" >"$1".expect &&
 	tr '\015\000' QN <"$2" | tr -d 'Z' >"$2".actual &&
-- 
2.10.0

