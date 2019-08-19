Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D65C1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 23:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfHSXwv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 19:52:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41805 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfHSXwv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 19:52:51 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so8229496ioj.8
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 16:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LB8+QP0W14RloAxZEFjr6JGDTw9glCiy+r71pQ3Kpn0=;
        b=aBZKz5N+KZ3Syqti3vj4XoYdfhs/JBhcJNW/aEEd18+BP6jf8cPviv6iNkMu6VNTOk
         Sp5MDfBsXpYFS9uRn3eEFjQVzzP9zaJsS6iTgXOo9NfS6O5Pksz9LKpiMZmIXPHZcZOI
         SN9kmsbbgHvXO9/6OpgQuKngSLltx9LQozxaFGix3qA6706I7rDUaGXDQdC+otkjb6+y
         zx5f5DC25xQzMRpAr7TSrnEwkyZBZlKf2IdmTBDDgjZf7s7UEyn5VrUtDKyhez0vaVs7
         Aj1r+odm4TOQFPrl9+OOFXduOtPJ/q33HRb2jp2uorM9FtjdOGmNXDRCXJR1CYWOplA8
         HENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LB8+QP0W14RloAxZEFjr6JGDTw9glCiy+r71pQ3Kpn0=;
        b=Iv14PuYyIw4OUdQzAEyY/ThzGZyuy1DEzpmIHNl3PhPBt6+kvPVC4Sp5xWezBMX7bB
         39R+Tc/UgfF9rj+Vwq399c9QFH3Y/cttZ07F3I5fKr2EJ2+0ARQX6BqsnlPSqHOlYwdG
         +4CSZcX2FKp3OUidOJ/w7ZE91yzvGUyt8NlUIsT0QgNkkiC6an3p1QtfvQOWg+eoS45W
         P0SWWC+iWWynb/cXmyO3goG+/XJluu9OQihtDcFQ/W6TNOKAQ9cAAqTm1m0rsL+2Uyml
         fNblr2FtfGpiXQjZmq43OX664/7fd/eUcDyOIDxmNdmZGM+Oi4zQGPgT8WJ4+vYgFCpE
         +/Ow==
X-Gm-Message-State: APjAAAXlW6YjAtHimWwxo1gwAGYlv73pLysmFtx+EKdpMVUpYcYi+uJ2
        jiAi4OuAE/bLI7u0ihpi8o91D9t6
X-Google-Smtp-Source: APXvYqx+pdqeCAwt0GQjHnML7CR09ueLJEgZJFktvxC9EH5TKObl4uRFtLzfEJ1LeBHX3cLpMwiieQ==
X-Received: by 2002:a05:6638:105:: with SMTP id x5mr472201jao.43.1566258768412;
        Mon, 19 Aug 2019 16:52:48 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id h3sm5002943iof.65.2019.08.19.16.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:52:47 -0700 (PDT)
Date:   Mon, 19 Aug 2019 19:52:46 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/4] t4014: clean up style
Message-ID: <76a0a274fde564f709d294acd7d6da17167f05b5.1566258525.git.liu.denton@gmail.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1566258525.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git's tests, there is typically no space between the redirection
operator and the filename. Remove these spaces.

Since output is silenced when running without `-v` and debugging
output is useful with `-v`, remove redirections to /dev/null.

Change here-docs from `<<\EOF` to `<<-\EOF` so that they can be indented
along with the rest of the test case.

Convert all instances of `cnt=$(... | wc -l) && test $cnt = N` into
uses of `test_line_count()`.

For style, move the ending sq of test cases onto its own line whenever
they do not conform.

Rename output files from "expected" to "expect" to conform with the
usual convention.

Finally, refactor to remove Git commands upstream of pipe as well as Git
commands that are in a non-variable-assignment subshell (e.g. `echo
"base-commit: $(git rev-parse HEAD)"`. This way, if an invocation of a
Git command fails, the return code won't be lost. Keep upstream non-Git
commands since we have to assume a base level of sanity.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

This patch is getting a little unwieldy. Perhaps we could split it into
several smaller patches? Unfortunately, I'm not really sure where a
logical place to split it would be.

 t/t4014-format-patch.sh | 733 +++++++++++++++++++++-------------------
 1 file changed, 387 insertions(+), 346 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ca7debf1d4..0114608b1f 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -34,7 +34,8 @@ test_expect_success setup '
 	git commit -m "Side changes #3 with \\n backslash-n in it." &&
 
 	git checkout master &&
-	git diff-tree -p C2 | git apply --index &&
+	git diff-tree -p C2 >patch &&
+	git apply --index <patch &&
 	test_tick &&
 	git commit -m "Master accepts moral equivalent of #2" &&
 
@@ -62,26 +63,24 @@ test_expect_success setup '
 test_expect_success "format-patch --ignore-if-in-upstream" '
 
 	git format-patch --stdout master..side >patch0 &&
-	cnt=$(grep "^From " patch0 | wc -l) &&
-	test $cnt = 3
-
+	grep "^From " patch0 >from0 &&
+	test_line_count = 3 from0
 '
 
 test_expect_success "format-patch --ignore-if-in-upstream" '
 
 	git format-patch --stdout \
 		--ignore-if-in-upstream master..side >patch1 &&
-	cnt=$(grep "^From " patch1 | wc -l) &&
-	test $cnt = 2
-
+	grep "^From " patch1 >from1 &&
+	test_line_count = 2 from1
 '
 
 test_expect_success "format-patch --ignore-if-in-upstream handles tags" '
 	git tag -a v1 -m tag side &&
 	git tag -a v2 -m tag master &&
 	git format-patch --stdout --ignore-if-in-upstream v2..v1 >patch1 &&
-	cnt=$(grep "^From " patch1 | wc -l) &&
-	test $cnt = 2
+	grep "^From " patch1 >from1 &&
+	test_line_count = 2 from1
 '
 
 test_expect_success "format-patch doesn't consider merge commits" '
@@ -96,29 +95,31 @@ test_expect_success "format-patch doesn't consider merge commits" '
 	git checkout -b merger master &&
 	test_tick &&
 	git merge --no-ff slave &&
-	cnt=$(git format-patch -3 --stdout | grep "^From " | wc -l) &&
-	test $cnt = 3
+	git format-patch -3 --stdout >patch &&
+	grep "^From " patch >from &&
+	test_line_count = 3 from
 '
 
 test_expect_success "format-patch result applies" '
 
 	git checkout -b rebuild-0 master &&
 	git am -3 patch0 &&
-	cnt=$(git rev-list master.. | wc -l) &&
-	test $cnt = 2
+	git rev-list master.. >list &&
+	test_line_count = 2 list
 '
 
 test_expect_success "format-patch --ignore-if-in-upstream result applies" '
 
 	git checkout -b rebuild-1 master &&
 	git am -3 patch1 &&
-	cnt=$(git rev-list master.. | wc -l) &&
-	test $cnt = 2
+	git rev-list master.. >list &&
+	test_line_count = 2 list
 '
 
 test_expect_success 'commit did not screw up the log message' '
 
-	git cat-file commit side | grep "^Side .* with .* backslash-n"
+	git cat-file commit side >actual &&
+	grep "^Side .* with .* backslash-n" actual
 
 '
 
@@ -131,7 +132,8 @@ test_expect_success 'format-patch did not screw up the log message' '
 
 test_expect_success 'replay did not screw up the log message' '
 
-	git cat-file commit rebuild-1 | grep "^Side .* with .* backslash-n"
+	git cat-file commit rebuild-1 >actual &&
+	grep "^Side .* with .* backslash-n" actual
 
 '
 
@@ -141,8 +143,8 @@ test_expect_success 'extra headers' '
 " &&
 	git config --add format.headers "Cc: S E Cipient <scipient@example.com>
 " &&
-	git format-patch --stdout master..side > patch2 &&
-	sed -e "/^\$/q" patch2 > hdrs2 &&
+	git format-patch --stdout master..side >patch2 &&
+	sed -e "/^\$/q" patch2 >hdrs2 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs2 &&
 	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs2
 
@@ -153,7 +155,7 @@ test_expect_success 'extra headers without newlines' '
 	git config --replace-all format.headers "To: R E Cipient <rcipient@example.com>" &&
 	git config --add format.headers "Cc: S E Cipient <scipient@example.com>" &&
 	git format-patch --stdout master..side >patch3 &&
-	sed -e "/^\$/q" patch3 > hdrs3 &&
+	sed -e "/^\$/q" patch3 >hdrs3 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs3 &&
 	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs3
 
@@ -163,8 +165,8 @@ test_expect_success 'extra headers with multiple To:s' '
 
 	git config --replace-all format.headers "To: R E Cipient <rcipient@example.com>" &&
 	git config --add format.headers "To: S E Cipient <scipient@example.com>" &&
-	git format-patch --stdout master..side > patch4 &&
-	sed -e "/^\$/q" patch4 > hdrs4 &&
+	git format-patch --stdout master..side >patch4 &&
+	sed -e "/^\$/q" patch4 >hdrs4 &&
 	grep "^To: R E Cipient <rcipient@example.com>,\$" hdrs4 &&
 	grep "^ *S E Cipient <scipient@example.com>\$" hdrs4
 '
@@ -172,72 +174,82 @@ test_expect_success 'extra headers with multiple To:s' '
 test_expect_success 'additional command line cc (ascii)' '
 
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
-	git format-patch --cc="S E Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch5 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
-	grep "^ *S E Cipient <scipient@example.com>\$" patch5
+	git format-patch --cc="S E Cipient <scipient@example.com>" --stdout master..side >patch5 &&
+	sed -e "/^\$/q" patch5 >hdrs5 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
+	grep "^ *S E Cipient <scipient@example.com>\$" hdrs5
 '
 
 test_expect_failure 'additional command line cc (rfc822)' '
 
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
-	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch5 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
-	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" patch5
+	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side >patch5 &&
+	sed -e "/^\$/q" patch5 >hdrs5 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
+	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
 '
 
 test_expect_success 'command line headers' '
 
 	git config --unset-all format.headers &&
-	git format-patch --add-header="Cc: R E Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch6 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>\$" patch6
+	git format-patch --add-header="Cc: R E Cipient <rcipient@example.com>" --stdout master..side >patch6 &&
+	sed -e "/^\$/q" patch6 >hdrs6 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>\$" hdrs6
 '
 
 test_expect_success 'configuration headers and command line headers' '
 
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
-	git format-patch --add-header="Cc: S E Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch7 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch7 &&
-	grep "^ *S E Cipient <scipient@example.com>\$" patch7
+	git format-patch --add-header="Cc: S E Cipient <scipient@example.com>" --stdout master..side >patch7 &&
+	sed -e "/^\$/q" patch7 >hdrs7 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs7 &&
+	grep "^ *S E Cipient <scipient@example.com>\$" hdrs7
 '
 
 test_expect_success 'command line To: header (ascii)' '
 
 	git config --unset-all format.headers &&
-	git format-patch --to="R E Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
-	grep "^To: R E Cipient <rcipient@example.com>\$" patch8
+	git format-patch --to="R E Cipient <rcipient@example.com>" --stdout master..side >patch8 &&
+	sed -e "/^\$/q" patch8 >hdrs8 &&
+	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_failure 'command line To: header (rfc822)' '
 
-	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
-	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch8
+	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout master..side >patch8 &&
+	sed -e "/^\$/q" patch8 >hdrs8 &&
+	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_failure 'command line To: header (rfc2047)' '
 
-	git format-patch --to="R Ä Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
-	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" patch8
+	git format-patch --to="R Ä Cipient <rcipient@example.com>" --stdout master..side >patch8 &&
+	sed -e "/^\$/q" patch8 >hdrs8 &&
+	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_success 'configuration To: header (ascii)' '
 
 	git config format.to "R E Cipient <rcipient@example.com>" &&
-	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
-	grep "^To: R E Cipient <rcipient@example.com>\$" patch9
+	git format-patch --stdout master..side >patch9 &&
+	sed -e "/^\$/q" patch9 >hdrs9 &&
+	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs9
 '
 
 test_expect_failure 'configuration To: header (rfc822)' '
 
 	git config format.to "R. E. Cipient <rcipient@example.com>" &&
-	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
-	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch9
+	git format-patch --stdout master..side >patch9 &&
+	sed -e "/^\$/q" patch9 >hdrs9 &&
+	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs9
 '
 
 test_expect_failure 'configuration To: header (rfc2047)' '
 
 	git config format.to "R Ä Cipient <rcipient@example.com>" &&
-	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
-	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" patch9
+	git format-patch --stdout master..side >patch9 &&
+	sed -e "/^\$/q" patch9 >hdrs9 &&
+	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
 '
 
 # check_patch <patch>: Verify that <patch> looks like a half-sane
@@ -250,52 +262,52 @@ check_patch () {
 
 test_expect_success 'format.from=false' '
 
-	git -c format.from=false format-patch --stdout master..side |
-	sed -e "/^\$/q" >patch &&
+	git -c format.from=false format-patch --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
 	check_patch patch &&
-	! grep "^From: C O Mitter <committer@example.com>\$" patch
+	! grep "^From: C O Mitter <committer@example.com>\$" hdrs
 '
 
 test_expect_success 'format.from=true' '
 
-	git -c format.from=true format-patch --stdout master..side |
-	sed -e "/^\$/q" >patch &&
-	check_patch patch &&
-	grep "^From: C O Mitter <committer@example.com>\$" patch
+	git -c format.from=true format-patch --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
+	check_patch hdrs &&
+	grep "^From: C O Mitter <committer@example.com>\$" hdrs
 '
 
 test_expect_success 'format.from with address' '
 
-	git -c format.from="F R Om <from@example.com>" format-patch --stdout master..side |
-	sed -e "/^\$/q" >patch &&
-	check_patch patch &&
-	grep "^From: F R Om <from@example.com>\$" patch
+	git -c format.from="F R Om <from@example.com>" format-patch --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
+	check_patch hdrs &&
+	grep "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--no-from overrides format.from' '
 
-	git -c format.from="F R Om <from@example.com>" format-patch --no-from --stdout master..side |
-	sed -e "/^\$/q" >patch &&
-	check_patch patch &&
-	! grep "^From: F R Om <from@example.com>\$" patch
+	git -c format.from="F R Om <from@example.com>" format-patch --no-from --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
+	check_patch hdrs &&
+	! grep "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--from overrides format.from' '
 
-	git -c format.from="F R Om <from@example.com>" format-patch --from --stdout master..side |
-	sed -e "/^\$/q" >patch &&
-	check_patch patch &&
-	! grep "^From: F R Om <from@example.com>\$" patch
+	git -c format.from="F R Om <from@example.com>" format-patch --from --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
+	check_patch hdrs &&
+	! grep "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--no-to overrides config.to' '
 
 	git config --replace-all format.to \
 		"R E Cipient <rcipient@example.com>" &&
-	git format-patch --no-to --stdout master..side |
-	sed -e "/^\$/q" >patch10 &&
-	check_patch patch10 &&
-	! grep "^To: R E Cipient <rcipient@example.com>\$" patch10
+	git format-patch --no-to --stdout master..side >patch10 &&
+	sed -e "/^\$/q" patch10 >hdrs10 &&
+	check_patch hdrs10 &&
+	! grep "^To: R E Cipient <rcipient@example.com>\$" hdrs10
 '
 
 test_expect_success '--no-to and --to replaces config.to' '
@@ -303,31 +315,31 @@ test_expect_success '--no-to and --to replaces config.to' '
 	git config --replace-all format.to \
 		"Someone <someone@out.there>" &&
 	git format-patch --no-to --to="Someone Else <else@out.there>" \
-		--stdout master..side |
-	sed -e "/^\$/q" >patch11 &&
-	check_patch patch11 &&
-	! grep "^To: Someone <someone@out.there>\$" patch11 &&
-	grep "^To: Someone Else <else@out.there>\$" patch11
+		--stdout master..side >patch11 &&
+	sed -e "/^\$/q" patch11 >hdrs11 &&
+	check_patch hdrs11 &&
+	! grep "^To: Someone <someone@out.there>\$" hdrs11 &&
+	grep "^To: Someone Else <else@out.there>\$" hdrs11
 '
 
 test_expect_success '--no-cc overrides config.cc' '
 
 	git config --replace-all format.cc \
 		"C E Cipient <rcipient@example.com>" &&
-	git format-patch --no-cc --stdout master..side |
-	sed -e "/^\$/q" >patch12 &&
-	check_patch patch12 &&
-	! grep "^Cc: C E Cipient <rcipient@example.com>\$" patch12
+	git format-patch --no-cc --stdout master..side >patch12 &&
+	sed -e "/^\$/q" patch12 >hdrs12 &&
+	check_patch hdrs12 &&
+	! grep "^Cc: C E Cipient <rcipient@example.com>\$" hdrs12
 '
 
 test_expect_success '--no-add-header overrides config.headers' '
 
 	git config --replace-all format.headers \
 		"Header1: B E Cipient <rcipient@example.com>" &&
-	git format-patch --no-add-header --stdout master..side |
-	sed -e "/^\$/q" >patch13 &&
-	check_patch patch13 &&
-	! grep "^Header1: B E Cipient <rcipient@example.com>\$" patch13
+	git format-patch --no-add-header --stdout master..side >patch13 &&
+	sed -e "/^\$/q" patch13 >hdrs13 &&
+	check_patch hdrs13 &&
+	! grep "^Header1: B E Cipient <rcipient@example.com>\$" hdrs13
 '
 
 test_expect_success 'multiple files' '
@@ -357,7 +369,7 @@ test_expect_success 'reroll count (-v)' '
 check_threading () {
 	expect="$1" &&
 	shift &&
-	(git format-patch --stdout "$@"; echo $? > status.out) |
+	git format-patch --stdout "$@" >patch &&
 	# Prints everything between the Message-ID and In-Reply-To,
 	# and replaces all Message-ID-lookalikes by a sequence number
 	perl -ne '
@@ -372,12 +384,11 @@ check_threading () {
 			print;
 		}
 		print "---\n" if /^From /i;
-	' > actual &&
-	test 0 = "$(cat status.out)" &&
+	' <patch >actual &&
 	test_cmp "$expect" actual
 }
 
-cat >> expect.no-threading <<EOF
+cat >>expect.no-threading <<EOF
 ---
 ---
 ---
@@ -388,7 +399,7 @@ test_expect_success 'no threading' '
 	check_threading expect.no-threading master
 '
 
-cat > expect.thread <<EOF
+cat >expect.thread <<EOF
 ---
 Message-Id: <0>
 ---
@@ -405,7 +416,7 @@ test_expect_success 'thread' '
 	check_threading expect.thread --thread master
 '
 
-cat > expect.in-reply-to <<EOF
+cat >expect.in-reply-to <<EOF
 ---
 Message-Id: <0>
 In-Reply-To: <1>
@@ -425,7 +436,7 @@ test_expect_success 'thread in-reply-to' '
 		--thread master
 '
 
-cat > expect.cover-letter <<EOF
+cat >expect.cover-letter <<EOF
 ---
 Message-Id: <0>
 ---
@@ -446,7 +457,7 @@ test_expect_success 'thread cover-letter' '
 	check_threading expect.cover-letter --cover-letter --thread master
 '
 
-cat > expect.cl-irt <<EOF
+cat >expect.cl-irt <<EOF
 ---
 Message-Id: <0>
 In-Reply-To: <1>
@@ -478,7 +489,7 @@ test_expect_success 'thread explicit shallow' '
 		--in-reply-to="<test.message>" --thread=shallow master
 '
 
-cat > expect.deep <<EOF
+cat >expect.deep <<EOF
 ---
 Message-Id: <0>
 ---
@@ -496,7 +507,7 @@ test_expect_success 'thread deep' '
 	check_threading expect.deep --thread=deep master
 '
 
-cat > expect.deep-irt <<EOF
+cat >expect.deep-irt <<EOF
 ---
 Message-Id: <0>
 In-Reply-To: <1>
@@ -519,7 +530,7 @@ test_expect_success 'thread deep in-reply-to' '
 		--in-reply-to="<test.message>" master
 '
 
-cat > expect.deep-cl <<EOF
+cat >expect.deep-cl <<EOF
 ---
 Message-Id: <0>
 ---
@@ -543,7 +554,7 @@ test_expect_success 'thread deep cover-letter' '
 	check_threading expect.deep-cl --cover-letter --thread=deep master
 '
 
-cat > expect.deep-cl-irt <<EOF
+cat >expect.deep-cl-irt <<EOF
 ---
 Message-Id: <0>
 In-Reply-To: <1>
@@ -625,7 +636,7 @@ test_expect_success 'cover-letter inherits diff options' '
 
 '
 
-cat > expect << EOF
+cat >expect <<EOF
   This is an excessively long subject line for a message due to the
     habit some projects have of not having a short, one-line subject at
     the start of the commit message, but rather sticking a whole
@@ -638,12 +649,12 @@ EOF
 test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
 
 	git format-patch --cover-letter -2 &&
-	sed -e "1,/A U Thor/d" -e "/^\$/q" < 0000-cover-letter.patch > output &&
+	sed -e "1,/A U Thor/d" -e "/^\$/q" <0000-cover-letter.patch >output &&
 	test_cmp expect output
 
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 index $before..$after 100644
 --- a/file
 +++ b/file
@@ -665,7 +676,7 @@ test_expect_success 'format-patch respects -U' '
 
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 
 diff --git a/file b/file
 index $before..$after 100644
@@ -681,7 +692,7 @@ EOF
 test_expect_success 'format-patch -p suppresses stat' '
 
 	git format-patch -p -2 &&
-	sed -e "1,/^\$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
+	sed -e "1,/^\$/d" -e "/^+5/q" <0001-This-is-an-excessively-long-subject-line-for-a-messa.patch >output &&
 	test_cmp expect output
 
 '
@@ -736,7 +747,7 @@ test_expect_success 'format-patch from a subdirectory (3)' '
 '
 
 test_expect_success 'format-patch --in-reply-to' '
-	git format-patch -1 --stdout --in-reply-to "baz@foo.bar" > patch8 &&
+	git format-patch -1 --stdout --in-reply-to "baz@foo.bar" >patch8 &&
 	grep "^In-Reply-To: <baz@foo.bar>" patch8 &&
 	grep "^References: <baz@foo.bar>" patch8
 '
@@ -827,21 +838,24 @@ test_expect_success 'format-patch with multiple notes refs' '
 	! grep "this is note 2" out
 '
 
-echo "fatal: --name-only does not make sense" > expect.name-only
-echo "fatal: --name-status does not make sense" > expect.name-status
-echo "fatal: --check does not make sense" > expect.check
+echo "fatal: --name-only does not make sense" >expect.name-only
+echo "fatal: --name-status does not make sense" >expect.name-status
+echo "fatal: --check does not make sense" >expect.check
 
 test_expect_success 'options no longer allowed for format-patch' '
-	test_must_fail git format-patch --name-only 2> output &&
+	test_must_fail git format-patch --name-only 2>output &&
 	test_i18ncmp expect.name-only output &&
-	test_must_fail git format-patch --name-status 2> output &&
+	test_must_fail git format-patch --name-status 2>output &&
 	test_i18ncmp expect.name-status output &&
-	test_must_fail git format-patch --check 2> output &&
-	test_i18ncmp expect.check output'
+	test_must_fail git format-patch --check 2>output &&
+	test_i18ncmp expect.check output
+'
 
 test_expect_success 'format-patch --numstat should produce a patch' '
-	git format-patch --numstat --stdout master..side > output &&
-	test 5 = $(grep "^diff --git a/" output | wc -l)'
+	git format-patch --numstat --stdout master..side >output &&
+	grep "^diff --git a/" output >diff &&
+	test_line_count = 5 diff
+'
 
 test_expect_success 'format-patch -- <path>' '
 	git format-patch master..side -- file 2>error &&
@@ -852,20 +866,21 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
 	git format-patch --ignore-if-in-upstream HEAD
 '
 
-git_version="$(git --version | sed "s/.* //")"
-
 signature() {
+	git_version="$(git --version >version && sed "s/.* //" version)" &&
 	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
 }
 
 test_expect_success 'format-patch default signature' '
-	git format-patch --stdout -1 | tail -n 3 >output &&
+	git format-patch --stdout -1 >patch &&
+	tail -n 3 patch >output &&
 	signature >expect &&
 	test_cmp expect output
 '
 
 test_expect_success 'format-patch --signature' '
-	git format-patch --stdout --signature="my sig" -1 | tail -n 3 >output &&
+	git format-patch --stdout --signature="my sig" -1 >patch &&
+	tail -n 3 patch >output &&
 	signature "my sig" >expect &&
 	test_cmp expect output
 '
@@ -897,8 +912,8 @@ test_expect_success 'format-patch --signature --cover-letter' '
 	git config --unset-all format.signature &&
 	git format-patch --stdout --signature="my sig" --cover-letter \
 		-1 >output &&
-	grep "my sig" output &&
-	test 2 = $(grep "my sig" output | wc -l)
+	grep "my sig" output >sig &&
+	test_line_count = 2 sig
 '
 
 test_expect_success 'format.signature="" suppresses signatures' '
@@ -1256,283 +1271,283 @@ append_signoff()
 
 test_expect_success 'signoff: commit with no body' '
 	append_signoff </dev/null >actual &&
-	cat <<\EOF | sed "s/EOL$//" >expected &&
-4:Subject: [PATCH] EOL
-8:
-9:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	cat <<-\EOF | sed "s/EOL$//" >expect &&
+	4:Subject: [PATCH] EOL
+	8:
+	9:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: commit with only subject' '
 	echo subject | append_signoff >actual &&
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: commit with only subject that does not end with NL' '
 	printf subject | append_signoff >actual &&
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: no existing signoffs' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	body
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: no existing signoffs and no trailing NL' '
 	printf "subject\n\nbody" | append_signoff >actual &&
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: some random signoff' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Signed-off-by: my@house
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: my@house
-12:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	Signed-off-by: my@house
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: my@house
+	12:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: misc conforming footer elements' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Signed-off-by: my@house
-(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
-Tested-by: Some One <someone@example.com>
-Bug: 1234
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: my@house
-15:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	Signed-off-by: my@house
+	(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
+	Tested-by: Some One <someone@example.com>
+	Bug: 1234
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: my@house
+	15:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: some random signoff-alike' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
-Fooled-by-me: my@house
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-11:
-12:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	body
+	Fooled-by-me: my@house
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	11:
+	12:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: not really a signoff' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-I want to mention about Signed-off-by: here.
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:I want to mention about Signed-off-by: here.
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	I want to mention about Signed-off-by: here.
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:I want to mention about Signed-off-by: here.
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: not really a signoff (2)' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-My unfortunate
-Signed-off-by: example happens to be wrapped here.
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:Signed-off-by: example happens to be wrapped here.
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	My unfortunate
+	Signed-off-by: example happens to be wrapped here.
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:Signed-off-by: example happens to be wrapped here.
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: valid S-o-b paragraph in the middle' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-Signed-off-by: my@house
-Signed-off-by: your@house
+	Signed-off-by: my@house
+	Signed-off-by: your@house
 
-A lot of houses.
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:Signed-off-by: my@house
-10:Signed-off-by: your@house
-11:
-13:
-14:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	A lot of houses.
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:Signed-off-by: my@house
+	10:Signed-off-by: your@house
+	11:
+	13:
+	14:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: the same signoff at the end' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: the same signoff at the end, no trailing NL' '
 	printf "subject\n\nSigned-off-by: C O Mitter <committer@example.com>" |
 		append_signoff >actual &&
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: the same signoff NOT at the end' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Signed-off-by: C O Mitter <committer@example.com>
-Signed-off-by: my@house
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-12:Signed-off-by: my@house
-EOF
-	test_cmp expected actual
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: my@house
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	12:Signed-off-by: my@house
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: tolerate garbage in conforming footer' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Tested-by: my@house
-Some Trash
-Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-13:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	Tested-by: my@house
+	Some Trash
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	13:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: respect trailer config' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-Myfooter: x
-Some Trash
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-11:
-12:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual &&
+	Myfooter: x
+	Some Trash
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	11:
+	12:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual &&
 
 	test_config trailer.Myfooter.ifexists add &&
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-Myfooter: x
-Some Trash
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	Myfooter: x
+	Some Trash
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: footer begins with non-signoff without @ sign' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Reviewed-id: Noone
-Tested-by: my@house
-Change-id: Ideadbeef
-Signed-off-by: C O Mitter <committer@example.com>
-Bug: 1234
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-14:Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	test_cmp expected actual
+	Reviewed-id: Noone
+	Tested-by: my@house
+	Change-id: Ideadbeef
+	Signed-off-by: C O Mitter <committer@example.com>
+	Bug: 1234
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	14:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'format patch ignores color.ui' '
@@ -1547,42 +1562,42 @@ test_expect_success 'cover letter using branch description (1)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter master >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (2)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter rebuild-1~2..rebuild-1 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (3)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter ^master rebuild-1 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (4)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter master.. >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (5)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter -2 HEAD >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (6)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter -2 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter with nothing' '
@@ -1636,7 +1651,8 @@ test_expect_success 'format-patch format.outputDirectory option' '
 	test_config format.outputDirectory patches &&
 	rm -fr patches &&
 	git format-patch master..side &&
-	test $(git rev-list master..side | wc -l) -eq $(ls patches | wc -l)
+	git rev-list master..side >list &&
+	test_line_count = $(ls patches | wc -l) list
 '
 
 test_expect_success 'format-patch -o overrides format.outputDirectory' '
@@ -1649,20 +1665,41 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
 
 test_expect_success 'format-patch --base' '
 	git checkout patchid &&
-	git format-patch --stdout --base=HEAD~3 -1 | tail -n 7 >actual1 &&
-	git format-patch --stdout --base=HEAD~3 HEAD~.. | tail -n 7 >actual2 &&
-	echo >expected &&
-	echo "base-commit: $(git rev-parse HEAD~3)" >>expected &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
-	signature >> expected &&
-	test_cmp expected actual1 &&
-	test_cmp expected actual2 &&
+
+	git format-patch --stdout --base=HEAD~3 -1 >patch &&
+	tail -n 7 patch >actual1 &&
+
+	git format-patch --stdout --base=HEAD~3 HEAD~.. >patch &&
+	tail -n 7 patch >actual2 &&
+
+	echo >expect &&
+	git rev-parse HEAD~3 >commit-id-base &&
+	echo "base-commit: $(cat commit-id-base)" >>expect &&
+
+	git show --patch HEAD~2 >patch &&
+	git patch-id --stable <patch >patch.id.raw &&
+	awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >>expect &&
+
+	git show --patch HEAD~1 >patch &&
+	git patch-id --stable <patch >patch.id.raw &&
+	awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >>expect &&
+
+	signature >>expect &&
+	test_cmp expect actual1 &&
+	test_cmp expect actual2 &&
+
 	echo >fail &&
-	echo "base-commit: $(git rev-parse HEAD~3)" >>fail &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --unstable | awk "{print \$1}")" >>fail &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --unstable | awk "{print \$1}")" >>fail &&
-	signature >> fail &&
+	echo "base-commit: $(cat commit-id-base)" >>fail &&
+
+	git show --patch HEAD~2 >patch &&
+	git patch-id --unstable <patch >patch.id.raw &&
+	awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >>fail &&
+
+	git show --patch HEAD~1 >patch &&
+	git patch-id --unstable <patch >patch.id.raw &&
+	awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >>fail &&
+
+	signature >>fail &&
 	! test_cmp fail actual1 &&
 	! test_cmp fail actual2
 '
@@ -1672,8 +1709,9 @@ test_expect_success 'format-patch --base errors out when base commit is in revis
 	test_must_fail git format-patch --base=HEAD~1 -2 &&
 	git format-patch --stdout --base=HEAD~2 -2 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(git rev-parse HEAD~2)" >expected &&
-	test_cmp expected actual
+	git rev-parse HEAD~2 >commit-id-base &&
+	echo "base-commit: $(cat commit-id-base)" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'format-patch --base errors out when base commit is not ancestor of revision list' '
@@ -1699,8 +1737,8 @@ test_expect_success 'format-patch --base errors out when base commit is not ance
 	test_must_fail git format-patch --base=$(cat commit-id-Z) -3 &&
 	git format-patch --stdout --base=$(cat commit-id-base) -3 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(cat commit-id-base)" >expected &&
-	test_cmp expected actual
+	echo "base-commit: $(cat commit-id-base)" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'format-patch --base=auto' '
@@ -1711,8 +1749,9 @@ test_expect_success 'format-patch --base=auto' '
 	test_commit N2 &&
 	git format-patch --stdout --base=auto -2 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(git rev-parse upstream)" >expected &&
-	test_cmp expected actual
+	git rev-parse upstream >commit-id-base &&
+	echo "base-commit: $(cat commit-id-base)" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'format-patch errors out when history involves criss-cross' '
@@ -1748,8 +1787,9 @@ test_expect_success 'format-patch format.useAutoBaseoption' '
 	git config format.useAutoBase true &&
 	git format-patch --stdout -1 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(git rev-parse upstream)" >expected &&
-	test_cmp expected actual
+	git rev-parse upstream >commit-id-base &&
+	echo "base-commit: $(cat commit-id-base)" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'format-patch --base overrides format.useAutoBase' '
@@ -1757,8 +1797,9 @@ test_expect_success 'format-patch --base overrides format.useAutoBase' '
 	git config format.useAutoBase true &&
 	git format-patch --stdout --base=HEAD~1 -1 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(git rev-parse HEAD~1)" >expected &&
-	test_cmp expected actual
+	git rev-parse HEAD~1 >commit-id-base &&
+	echo "base-commit: $(cat commit-id-base)" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'format-patch --base with --attach' '
-- 
2.23.0.248.g3a9dd8fb08

