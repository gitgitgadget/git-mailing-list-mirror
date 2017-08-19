Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6201D208CD
	for <e@80x24.org>; Sat, 19 Aug 2017 05:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751018AbdHSF3Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 01:29:24 -0400
Received: from mout.web.de ([212.227.17.12]:52421 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbdHSF3X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 01:29:23 -0400
Received: from [192.168.178.36] ([91.20.52.82]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbyIM-1dyom40nZ8-00JNEP; Sat, 19
 Aug 2017 07:28:58 +0200
Subject: [PATCH 1/4] t5001: add tests for export-ignore attributes and exclude
 pathspecs
To:     git@vger.kernel.org
Cc:     David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
 <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
 <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f65809c4-ce94-559a-855a-bbd9b3b1c936@web.de>
Date:   Sat, 19 Aug 2017 07:28:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:plofc2LO8j5+J2DGXM122vAiwsnKYk9dgRhpxDzYlu8Lad+cENy
 LQ1dMeAu27AcBaDUhiXEGMuDMaQ/1IZ/Dps0XGMfuUlIpWtbmxfyuXwz7+i7U8wjwtZ9WhI
 O6Ra2S7q36zANtLPcqRJ5g9m88oTXv7mvlN7ecfU2tgPkMlxLOxFmMdpfmF3kbfJMi/ls61
 UZKUhsYpEKUnR/8fmbROA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZCoZjNrR9Rc=:I4IGg/5EyO3A6b+ynQOyc7
 6//+O9uii4KnfokKUw9QJpvkl7ohPz9x1C1rBeNQkNiDTqtLmz1YYLEwaAwE8g4els2rNGoRx
 djiATxD522k+Ot6A+mY6xOaV/zNoEEUA9bq0eFJyH0pq5/WpmF9MU7FT18+QFzEfjwbylNeXJ
 7drszRoHr0ugcKY+jA0RS3kN6ADRuOKFXQfUR3xJwW5tPcGtFGZOvcBGiZDfKtxp3V6FRWATg
 QevkCQd7/DMN2tUCQRoLCKQOlFUWN24tBYwc3UTz9GQJWDYf5JAR/CX1ik29YD6nhE6z87OS/
 PQ701/Y+Oy3YIZhfeG7YXiuDEarKMx4RsgbqpWgyKzPAbZRvZGJQBIqGEAPQW/LJTrHi0qhzO
 4pcVI3RvnI1IVlMPEL7R+irp9MuNe9F5B/G8EHb2w4o3rm+GFUEsYi/Ul9Adbpb++k0NwLLHI
 oiPMuAcvItW4e8jVkM6/JGgy29kVdRp0Vw7u2TXviTEs5rqTnL02/ex1XgEkl/yqtV6vMQ/4C
 /Wo0hkDU4TSii/pc5i4nSgsFQDePnoiumJhrWo7JEMNdufB9JgnJ4LmZwv2mBSCYlTKgd9E1n
 PXeGrhkZ1gONEDud1be2LmM5mPYFawWF1F/JsuhTW61BhV8QL6ynKTIU51tdOM4FzoqHYsywm
 cJrtNcah9+/s0aoWV0CiQnaSbvXyoXG71uCSGFcCdqhVP4rQ1ofFhTeGneAvRs+ihPeGub5MO
 Jnpmtmf/xcBxt3nrC3tILXYk7X1M5B2bciCbCjs8QG31rLEA1mYG6ng7qCiuzWtD2XVYQrFgh
 aQcYKPXakZTl+b2wABn7yRHna/XUilTWrDsn/ouQMG7RQNkrJY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Demonstrate mishandling of the attribute export-ignore by git archive
when used together with pathspecs.  Wildcard pathspecs can even cause it
to abort.  And a directory excluded without a wildcard is still included
as an empty folder in the archive.

Test-case-by: David Adam <zanchey@ucc.gu.uwa.edu.au>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t5001-archive-attr.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index b04d955bfa..063622bc71 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -7,11 +7,15 @@ test_description='git archive attribute tests'
 SUBSTFORMAT='%H (%h)%n'
 
 test_expect_exists() {
-	test_expect_success " $1 exists" "test -e $1"
+	test_expect_${2:-success} " $1 exists" "test -e $1"
 }
 
 test_expect_missing() {
-	test_expect_success " $1 does not exist" "test ! -e $1"
+	test_expect_${2:-success} " $1 does not exist" "test ! -e $1"
+}
+
+extract_tar_to_dir () {
+	(mkdir "$1" && cd "$1" && "$TAR" xf -) <"$1.tar"
 }
 
 test_expect_success 'setup' '
@@ -21,12 +25,19 @@ test_expect_success 'setup' '
 
 	echo ignored by tree >ignored-by-tree &&
 	echo ignored-by-tree export-ignore >.gitattributes &&
-	git add ignored-by-tree .gitattributes &&
+	mkdir ignored-by-tree.d &&
+	>ignored-by-tree.d/file &&
+	echo ignored-by-tree.d export-ignore >>.gitattributes &&
+	git add ignored-by-tree ignored-by-tree.d .gitattributes &&
 
 	echo ignored by worktree >ignored-by-worktree &&
 	echo ignored-by-worktree export-ignore >.gitattributes &&
 	git add ignored-by-worktree &&
 
+	mkdir excluded-by-pathspec.d &&
+	>excluded-by-pathspec.d/file &&
+	git add excluded-by-pathspec.d &&
+
 	printf "A\$Format:%s\$O" "$SUBSTFORMAT" >nosubstfile &&
 	printf "A\$Format:%s\$O" "$SUBSTFORMAT" >substfile1 &&
 	printf "A not substituted O" >substfile2 &&
@@ -46,7 +57,37 @@ test_expect_success 'git archive' '
 
 test_expect_missing	archive/ignored
 test_expect_missing	archive/ignored-by-tree
+test_expect_missing	archive/ignored-by-tree.d
+test_expect_missing	archive/ignored-by-tree.d/file
 test_expect_exists	archive/ignored-by-worktree
+test_expect_exists	archive/excluded-by-pathspec.d
+test_expect_exists	archive/excluded-by-pathspec.d/file
+
+test_expect_success 'git archive with pathspec' '
+	git archive HEAD ":!excluded-by-pathspec.d" >archive-pathspec.tar &&
+	extract_tar_to_dir archive-pathspec
+'
+
+test_expect_missing	archive-pathspec/ignored
+test_expect_missing	archive-pathspec/ignored-by-tree
+test_expect_missing	archive-pathspec/ignored-by-tree.d
+test_expect_missing	archive-pathspec/ignored-by-tree.d/file
+test_expect_exists	archive-pathspec/ignored-by-worktree
+test_expect_missing	archive-pathspec/excluded-by-pathspec.d failure
+test_expect_missing	archive-pathspec/excluded-by-pathspec.d/file
+
+test_expect_failure 'git archive with wildcard pathspec' '
+	git archive HEAD ":!excluded-by-p*" >archive-pathspec-wildcard.tar &&
+	extract_tar_to_dir archive-pathspec-wildcard
+'
+
+test_expect_missing	archive-pathspec-wildcard/ignored
+test_expect_missing	archive-pathspec-wildcard/ignored-by-tree
+test_expect_missing	archive-pathspec-wildcard/ignored-by-tree.d
+test_expect_missing	archive-pathspec-wildcard/ignored-by-tree.d/file
+test_expect_exists	archive-pathspec-wildcard/ignored-by-worktree failure
+test_expect_missing	archive-pathspec-wildcard/excluded-by-pathspec.d
+test_expect_missing	archive-pathspec-wildcard/excluded-by-pathspec.d/file
 
 test_expect_success 'git archive with worktree attributes' '
 	git archive --worktree-attributes HEAD >worktree.tar &&
-- 
2.14.1
