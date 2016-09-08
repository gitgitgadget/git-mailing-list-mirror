Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322F120705
	for <e@80x24.org>; Thu,  8 Sep 2016 18:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758565AbcIHSWJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:22:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35610 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758559AbcIHSVv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:21:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id a6so9029981wmc.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 11:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v+m7QaeI4SolK51mH69kp5BaDBWNAA8ORedt75TyxO4=;
        b=JJR0povbI/IzBb9A2yHzoyBAkodeeNnvKlWnP1SPodZs7f5oZoaLWAKQXQfRcm/4yA
         qr2aZOQdxDWsMVu46ZhWe5oCzxzC0y6WpL8EO7GtmpJyjm0rU2YXJoJEop9F2rrvL8sy
         viQAPYlQZe3tuEE0vXcxfjvIkunhsw3v/ojllJHiwU2QDkhb7pSVbwLisc/5Ts48hwGB
         nYnvzVUKzfKEsZtf/E/5n74qPqboZXHTpLCFiWq6NNoxOSaSkmwqk26LuDLkIhPbyzNA
         D7A5KlwWFhe9YNT4KNdXSi61/Vf8p25jREbW3nqMVYsEl52O5fNFaClHp3OfFqNFr8IF
         460Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v+m7QaeI4SolK51mH69kp5BaDBWNAA8ORedt75TyxO4=;
        b=lYa4zQakxrBFa24hGBtWiEBK2V4LxsAr0h2HyU8wfsTRqsLuMD9/aAnq+KBz0nfOij
         XM0mAROtrZMTEPXzmOMN1b/5QKZw2IH1yOwIgRsN+faBfiEJvqcszTcEPrq76agPpqtH
         Sj4ZdienQEuGcIbI7DqUq6YXHPV8DkPCjQXHH5J9p0CvdAkNyj2MABDWe8OnEca8UOA2
         WiWk0tLUs+ZYTBpwY2FhshXYnOTdV06/CjrbZmQ02JqeFq/EsAKwE9S42kLlrJ2O5LXT
         sHOXLflwfEpy94Xjj6qUyd8l8gI9DkYWvMqcmQIjGehHyfcitY+EttFSKKnddPo5eQ1p
         tODA==
X-Gm-Message-State: AE9vXwOqsv0p735OkmwCJTXXFf5SFVQaELy2qEHi/SAL+ueNJOMYIlG269jwVEpKLuF7OQ==
X-Received: by 10.28.199.131 with SMTP id x125mr1575666wmf.70.1473358908942;
        Thu, 08 Sep 2016 11:21:48 -0700 (PDT)
Received: from slxBook4.local.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id b128sm10967467wmb.21.2016.09.08.11.21.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Sep 2016 11:21:48 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 08/10] convert: modernize tests
Date:   Thu,  8 Sep 2016 20:21:30 +0200
Message-Id: <20160908182132.50788-9-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160908182132.50788-1-larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Use `test_config` to set the config, check that files are empty with
`test_must_be_empty`, compare files with `test_cmp`, and remove spaces
after ">" and "<".

Please note that the "rot13" filter configured in "setup" keeps using
`git config` instead of `test_config` because subsequent tests might
depend on it.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t0021-conversion.sh | 58 +++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index e799e59..dc50938 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -38,8 +38,8 @@ script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
 
 test_expect_success check '
 
-	cmp test.o test &&
-	cmp test.o test.t &&
+	test_cmp test.o test &&
+	test_cmp test.o test.t &&
 
 	# ident should be stripped in the repository
 	git diff --raw --exit-code :test :test.i &&
@@ -47,10 +47,10 @@ test_expect_success check '
 	embedded=$(sed -ne "$script" test.i) &&
 	test "z$id" = "z$embedded" &&
 
-	git cat-file blob :test.t > test.r &&
+	git cat-file blob :test.t >test.r &&
 
-	./rot13.sh < test.o > test.t &&
-	cmp test.r test.t
+	./rot13.sh <test.o >test.t &&
+	test_cmp test.r test.t
 '
 
 # If an expanded ident ever gets into the repository, we want to make sure that
@@ -130,7 +130,7 @@ test_expect_success 'filter shell-escaped filenames' '
 
 	# delete the files and check them out again, using a smudge filter
 	# that will count the args and echo the command-line back to us
-	git config filter.argc.smudge "sh ./argc.sh %f" &&
+	test_config filter.argc.smudge "sh ./argc.sh %f" &&
 	rm "$normal" "$special" &&
 	git checkout -- "$normal" "$special" &&
 
@@ -141,7 +141,7 @@ test_expect_success 'filter shell-escaped filenames' '
 	test_cmp expect "$special" &&
 
 	# do the same thing, but with more args in the filter expression
-	git config filter.argc.smudge "sh ./argc.sh %f --my-extra-arg" &&
+	test_config filter.argc.smudge "sh ./argc.sh %f --my-extra-arg" &&
 	rm "$normal" "$special" &&
 	git checkout -- "$normal" "$special" &&
 
@@ -154,9 +154,9 @@ test_expect_success 'filter shell-escaped filenames' '
 '
 
 test_expect_success 'required filter should filter data' '
-	git config filter.required.smudge ./rot13.sh &&
-	git config filter.required.clean ./rot13.sh &&
-	git config filter.required.required true &&
+	test_config filter.required.smudge ./rot13.sh &&
+	test_config filter.required.clean ./rot13.sh &&
+	test_config filter.required.required true &&
 
 	echo "*.r filter=required" >.gitattributes &&
 
@@ -165,17 +165,17 @@ test_expect_success 'required filter should filter data' '
 
 	rm -f test.r &&
 	git checkout -- test.r &&
-	cmp test.o test.r &&
+	test_cmp test.o test.r &&
 
 	./rot13.sh <test.o >expected &&
 	git cat-file blob :test.r >actual &&
-	cmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'required filter smudge failure' '
-	git config filter.failsmudge.smudge false &&
-	git config filter.failsmudge.clean cat &&
-	git config filter.failsmudge.required true &&
+	test_config filter.failsmudge.smudge false &&
+	test_config filter.failsmudge.clean cat &&
+	test_config filter.failsmudge.required true &&
 
 	echo "*.fs filter=failsmudge" >.gitattributes &&
 
@@ -186,9 +186,9 @@ test_expect_success 'required filter smudge failure' '
 '
 
 test_expect_success 'required filter clean failure' '
-	git config filter.failclean.smudge cat &&
-	git config filter.failclean.clean false &&
-	git config filter.failclean.required true &&
+	test_config filter.failclean.smudge cat &&
+	test_config filter.failclean.clean false &&
+	test_config filter.failclean.required true &&
 
 	echo "*.fc filter=failclean" >.gitattributes &&
 
@@ -197,8 +197,8 @@ test_expect_success 'required filter clean failure' '
 '
 
 test_expect_success 'filtering large input to small output should use little memory' '
-	git config filter.devnull.clean "cat >/dev/null" &&
-	git config filter.devnull.required true &&
+	test_config filter.devnull.clean "cat >/dev/null" &&
+	test_config filter.devnull.required true &&
 	for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
 	echo "30MB filter=devnull" >.gitattributes &&
 	GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add 30MB
@@ -207,7 +207,7 @@ test_expect_success 'filtering large input to small output should use little mem
 test_expect_success 'filter that does not read is fine' '
 	test-genrandom foo $((128 * 1024 + 1)) >big &&
 	echo "big filter=epipe" >.gitattributes &&
-	git config filter.epipe.clean "echo xyzzy" &&
+	test_config filter.epipe.clean "echo xyzzy" &&
 	git add big &&
 	git cat-file blob :big >actual &&
 	echo xyzzy >expect &&
@@ -215,20 +215,20 @@ test_expect_success 'filter that does not read is fine' '
 '
 
 test_expect_success EXPENSIVE 'filter large file' '
-	git config filter.largefile.smudge cat &&
-	git config filter.largefile.clean cat &&
+	test_config filter.largefile.smudge cat &&
+	test_config filter.largefile.clean cat &&
 	for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&
 	echo "2GB filter=largefile" >.gitattributes &&
 	git add 2GB 2>err &&
-	! test -s err &&
+	test_must_be_empty err &&
 	rm -f 2GB &&
 	git checkout -- 2GB 2>err &&
-	! test -s err
+	test_must_be_empty err
 '
 
 test_expect_success "filter: clean empty file" '
-	git config filter.in-repo-header.clean  "echo cleaned && cat" &&
-	git config filter.in-repo-header.smudge "sed 1d" &&
+	test_config filter.in-repo-header.clean  "echo cleaned && cat" &&
+	test_config filter.in-repo-header.smudge "sed 1d" &&
 
 	echo "empty-in-worktree    filter=in-repo-header" >>.gitattributes &&
 	>empty-in-worktree &&
@@ -240,8 +240,8 @@ test_expect_success "filter: clean empty file" '
 '
 
 test_expect_success "filter: smudge empty file" '
-	git config filter.empty-in-repo.clean "cat >/dev/null" &&
-	git config filter.empty-in-repo.smudge "echo smudged && cat" &&
+	test_config filter.empty-in-repo.clean "cat >/dev/null" &&
+	test_config filter.empty-in-repo.smudge "echo smudged && cat" &&
 
 	echo "empty-in-repo filter=empty-in-repo" >>.gitattributes &&
 	echo dead data walking >empty-in-repo &&
-- 
2.10.0

