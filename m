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
	by dcvr.yhbt.net (Postfix) with ESMTP id 74AF21F461
	for <e@80x24.org>; Sat, 24 Aug 2019 08:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfHXI0x (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 04:26:53 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:42381 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfHXI0w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 04:26:52 -0400
Received: by mail-io1-f49.google.com with SMTP id e20so25543263iob.9
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cn5jFarKJ6VpDNdkWy0N5jDxwa8FQX6TLwwg9G5+5dY=;
        b=bJyUJVGaIktYNQpfw13NnI+oDRp/NsRc8vG6e1UUjKpm80Ne5lTCBztGu4bv7AXOOw
         krHyQ+62jcj/2dUx2V42s0DgH9JRkS+6U0E9hjUvPUpOyddti6pT5ZV7eruWZ4fDHm5J
         o7V1oNVQBEzffoKDv0EdWxFqOTC8Msh3NoIMlGHQRAC4KbX8CzCfyuSA+fUSAFkC1NKC
         alMR2UClq5N0T5BEh8XkAafdpvwPfBND4WIQICRj64C3L5n+MNUwZjgDlUOdbGkGn4vs
         Nz2WQY1WenJcemNrSK5AJbTL/jXHHBPnng3UfzKe47F65q00At5VLUT32kgcVSTTeVmD
         k1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cn5jFarKJ6VpDNdkWy0N5jDxwa8FQX6TLwwg9G5+5dY=;
        b=e1MVb70XvoG6PWCTDRs4PI3cyeipp2anH03XspQ75y5A6dPvDZ2x1DHbG+NtaIXOXP
         S6+m6nxcft0jxmrgZL8ntwDy08h+Aw5trCwg9EA6lRxNCZBiWwVXg4ql/oJjdEQDxjqX
         U8OCjaVaP8mAOjHMCLDWOWQ5sCeERMO4Tm2h+XFACDOtRsdmtU8tgmPJfOcOn73Vlqr3
         T+v0DtQlOa8DtJl274bASq57JfTmRmtnH6kvrnJtAUCdXvKNSAkK/XWnR330oMbXzPlF
         zgSVohuF9ojSs7L+h4M3hUSggHu1ePgLnWNjPv/wvNwqwxkpjAJjSVZcm6smeNgrmJr3
         /xqg==
X-Gm-Message-State: APjAAAUYDopDdA+FQ0O82QYFG07oDOtfICNT9ym2iWMKTG5E7sZwq+D5
        hDz1SFWSo2DCTOO3SZbNQkOoltKM
X-Google-Smtp-Source: APXvYqzdu+7J2nwbmcCOxAmbFDNxRr+W3JYpMh1szP82tULVz7bBb9dnElERks+u6q9pFWbGQp1C7w==
X-Received: by 2002:a5d:9d89:: with SMTP id 9mr11655770ion.212.1566635211497;
        Sat, 24 Aug 2019 01:26:51 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id s4sm7073758iop.25.2019.08.24.01.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 01:26:51 -0700 (PDT)
Date:   Sat, 24 Aug 2019 04:26:49 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 01/13] t4014: drop unnecessary blank lines from test cases
Message-ID: <fb000bfca21bde176f1e7ea947f36f3639f822bd.1566635008.git.liu.denton@gmail.com>
References: <cover.1566285151.git.liu.denton@gmail.com>
 <cover.1566635008.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1566635008.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 47 -----------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ca7debf1d4..3ed3feabfe 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -9,7 +9,6 @@ test_description='various format-patch tests'
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success setup '
-
 	for i in 1 2 3 4 5 6 7 8 9 10; do echo "$i"; done >file &&
 	cat file >elif &&
 	git add file elif &&
@@ -60,20 +59,16 @@ test_expect_success setup '
 '
 
 test_expect_success "format-patch --ignore-if-in-upstream" '
-
 	git format-patch --stdout master..side >patch0 &&
 	cnt=$(grep "^From " patch0 | wc -l) &&
 	test $cnt = 3
-
 '
 
 test_expect_success "format-patch --ignore-if-in-upstream" '
-
 	git format-patch --stdout \
 		--ignore-if-in-upstream master..side >patch1 &&
 	cnt=$(grep "^From " patch1 | wc -l) &&
 	test $cnt = 2
-
 '
 
 test_expect_success "format-patch --ignore-if-in-upstream handles tags" '
@@ -85,7 +80,6 @@ test_expect_success "format-patch --ignore-if-in-upstream handles tags" '
 '
 
 test_expect_success "format-patch doesn't consider merge commits" '
-
 	git checkout -b slave master &&
 	echo "Another line" >>file &&
 	test_tick &&
@@ -101,7 +95,6 @@ test_expect_success "format-patch doesn't consider merge commits" '
 '
 
 test_expect_success "format-patch result applies" '
-
 	git checkout -b rebuild-0 master &&
 	git am -3 patch0 &&
 	cnt=$(git rev-list master.. | wc -l) &&
@@ -109,7 +102,6 @@ test_expect_success "format-patch result applies" '
 '
 
 test_expect_success "format-patch --ignore-if-in-upstream result applies" '
-
 	git checkout -b rebuild-1 master &&
 	git am -3 patch1 &&
 	cnt=$(git rev-list master.. | wc -l) &&
@@ -117,26 +109,19 @@ test_expect_success "format-patch --ignore-if-in-upstream result applies" '
 '
 
 test_expect_success 'commit did not screw up the log message' '
-
 	git cat-file commit side | grep "^Side .* with .* backslash-n"
-
 '
 
 test_expect_success 'format-patch did not screw up the log message' '
-
 	grep "^Subject: .*Side changes #3 with .* backslash-n" patch0 &&
 	grep "^Subject: .*Side changes #3 with .* backslash-n" patch1
-
 '
 
 test_expect_success 'replay did not screw up the log message' '
-
 	git cat-file commit rebuild-1 | grep "^Side .* with .* backslash-n"
-
 '
 
 test_expect_success 'extra headers' '
-
 	git config format.headers "To: R E Cipient <rcipient@example.com>
 " &&
 	git config --add format.headers "Cc: S E Cipient <scipient@example.com>
@@ -145,22 +130,18 @@ test_expect_success 'extra headers' '
 	sed -e "/^\$/q" patch2 > hdrs2 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs2 &&
 	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs2
-
 '
 
 test_expect_success 'extra headers without newlines' '
-
 	git config --replace-all format.headers "To: R E Cipient <rcipient@example.com>" &&
 	git config --add format.headers "Cc: S E Cipient <scipient@example.com>" &&
 	git format-patch --stdout master..side >patch3 &&
 	sed -e "/^\$/q" patch3 > hdrs3 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs3 &&
 	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs3
-
 '
 
 test_expect_success 'extra headers with multiple To:s' '
-
 	git config --replace-all format.headers "To: R E Cipient <rcipient@example.com>" &&
 	git config --add format.headers "To: S E Cipient <scipient@example.com>" &&
 	git format-patch --stdout master..side > patch4 &&
@@ -170,7 +151,6 @@ test_expect_success 'extra headers with multiple To:s' '
 '
 
 test_expect_success 'additional command line cc (ascii)' '
-
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
 	git format-patch --cc="S E Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch5 &&
 	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
@@ -178,7 +158,6 @@ test_expect_success 'additional command line cc (ascii)' '
 '
 
 test_expect_failure 'additional command line cc (rfc822)' '
-
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
 	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch5 &&
 	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
@@ -186,14 +165,12 @@ test_expect_failure 'additional command line cc (rfc822)' '
 '
 
 test_expect_success 'command line headers' '
-
 	git config --unset-all format.headers &&
 	git format-patch --add-header="Cc: R E Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch6 &&
 	grep "^Cc: R E Cipient <rcipient@example.com>\$" patch6
 '
 
 test_expect_success 'configuration headers and command line headers' '
-
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
 	git format-patch --add-header="Cc: S E Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch7 &&
 	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch7 &&
@@ -201,40 +178,34 @@ test_expect_success 'configuration headers and command line headers' '
 '
 
 test_expect_success 'command line To: header (ascii)' '
-
 	git config --unset-all format.headers &&
 	git format-patch --to="R E Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" patch8
 '
 
 test_expect_failure 'command line To: header (rfc822)' '
-
 	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
 	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch8
 '
 
 test_expect_failure 'command line To: header (rfc2047)' '
-
 	git format-patch --to="R Ä Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
 	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" patch8
 '
 
 test_expect_success 'configuration To: header (ascii)' '
-
 	git config format.to "R E Cipient <rcipient@example.com>" &&
 	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" patch9
 '
 
 test_expect_failure 'configuration To: header (rfc822)' '
-
 	git config format.to "R. E. Cipient <rcipient@example.com>" &&
 	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
 	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch9
 '
 
 test_expect_failure 'configuration To: header (rfc2047)' '
-
 	git config format.to "R Ä Cipient <rcipient@example.com>" &&
 	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
 	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" patch9
@@ -249,7 +220,6 @@ check_patch () {
 }
 
 test_expect_success 'format.from=false' '
-
 	git -c format.from=false format-patch --stdout master..side |
 	sed -e "/^\$/q" >patch &&
 	check_patch patch &&
@@ -257,7 +227,6 @@ test_expect_success 'format.from=false' '
 '
 
 test_expect_success 'format.from=true' '
-
 	git -c format.from=true format-patch --stdout master..side |
 	sed -e "/^\$/q" >patch &&
 	check_patch patch &&
@@ -265,7 +234,6 @@ test_expect_success 'format.from=true' '
 '
 
 test_expect_success 'format.from with address' '
-
 	git -c format.from="F R Om <from@example.com>" format-patch --stdout master..side |
 	sed -e "/^\$/q" >patch &&
 	check_patch patch &&
@@ -273,7 +241,6 @@ test_expect_success 'format.from with address' '
 '
 
 test_expect_success '--no-from overrides format.from' '
-
 	git -c format.from="F R Om <from@example.com>" format-patch --no-from --stdout master..side |
 	sed -e "/^\$/q" >patch &&
 	check_patch patch &&
@@ -281,7 +248,6 @@ test_expect_success '--no-from overrides format.from' '
 '
 
 test_expect_success '--from overrides format.from' '
-
 	git -c format.from="F R Om <from@example.com>" format-patch --from --stdout master..side |
 	sed -e "/^\$/q" >patch &&
 	check_patch patch &&
@@ -289,7 +255,6 @@ test_expect_success '--from overrides format.from' '
 '
 
 test_expect_success '--no-to overrides config.to' '
-
 	git config --replace-all format.to \
 		"R E Cipient <rcipient@example.com>" &&
 	git format-patch --no-to --stdout master..side |
@@ -299,7 +264,6 @@ test_expect_success '--no-to overrides config.to' '
 '
 
 test_expect_success '--no-to and --to replaces config.to' '
-
 	git config --replace-all format.to \
 		"Someone <someone@out.there>" &&
 	git format-patch --no-to --to="Someone Else <else@out.there>" \
@@ -311,7 +275,6 @@ test_expect_success '--no-to and --to replaces config.to' '
 '
 
 test_expect_success '--no-cc overrides config.cc' '
-
 	git config --replace-all format.cc \
 		"C E Cipient <rcipient@example.com>" &&
 	git format-patch --no-cc --stdout master..side |
@@ -321,7 +284,6 @@ test_expect_success '--no-cc overrides config.cc' '
 '
 
 test_expect_success '--no-add-header overrides config.headers' '
-
 	git config --replace-all format.headers \
 		"Header1: B E Cipient <rcipient@example.com>" &&
 	git format-patch --no-add-header --stdout master..side |
@@ -331,7 +293,6 @@ test_expect_success '--no-add-header overrides config.headers' '
 '
 
 test_expect_success 'multiple files' '
-
 	rm -rf patches/ &&
 	git checkout side &&
 	git format-patch -o patches/ master &&
@@ -594,7 +555,6 @@ test_expect_success 'thread config + --no-thread' '
 '
 
 test_expect_success 'excessive subject' '
-
 	rm -rf patches/ &&
 	git checkout side &&
 	before=$(git hash-object file) &&
@@ -622,7 +582,6 @@ test_expect_success 'cover-letter inherits diff options' '
 	! grep "file => foo .* 0 *\$" 0000-cover-letter.patch &&
 	git format-patch --cover-letter -1 -M &&
 	grep "file => foo .* 0 *\$" 0000-cover-letter.patch
-
 '
 
 cat > expect << EOF
@@ -636,11 +595,9 @@ cat > expect << EOF
 EOF
 
 test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
-
 	git format-patch --cover-letter -2 &&
 	sed -e "1,/A U Thor/d" -e "/^\$/q" < 0000-cover-letter.patch > output &&
 	test_cmp expect output
-
 '
 
 cat > expect << EOF
@@ -656,13 +613,11 @@ index $before..$after 100644
 EOF
 
 test_expect_success 'format-patch respects -U' '
-
 	git format-patch -U4 -2 &&
 	sed -e "1,/^diff/d" -e "/^+5/q" \
 		<0001-This-is-an-excessively-long-subject-line-for-a-messa.patch \
 		>output &&
 	test_cmp expect output
-
 '
 
 cat > expect << EOF
@@ -679,11 +634,9 @@ index $before..$after 100644
 EOF
 
 test_expect_success 'format-patch -p suppresses stat' '
-
 	git format-patch -p -2 &&
 	sed -e "1,/^\$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
 	test_cmp expect output
-
 '
 
 test_expect_success 'format-patch from a subdirectory (1)' '
-- 
2.23.0.248.g3a9dd8fb08

