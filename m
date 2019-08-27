Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940DB1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfH0EFO (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:05:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44637 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0EFO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:05:14 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so34656047iog.11
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PdNpr+xjrLYU2MoWEBNF3xcNAmtPLys44nVVsueTa5k=;
        b=DRok/ps7ro+HCrjFsaikfulZm1IpxuHS7BLoatFgX7qGLXyCpTJVRfsJQDxz3zOe7z
         zHS2m7yjiub85IaPjP16FpF27El8sUrZ9D+jV03xHQqZduR2AHt3Ti6beaDJdAVmlHsQ
         f8+uxqJoaIz8sStugzwW8+fQviz7yjb8BscR/MNkYc3GvlfzaivpvOCWyaHW1zQy4Yjh
         hD+t9NI7I7WHu21QgNkpGhev1BrJFvrkMHlazkTOe3RcXAPjNZC30YU0LE1TCCC3f03c
         RNsOMrpyOF/r+f7giMEVPmYhUPA1Cxrzz5loJ0lFcJObmDSPeZP7FTTHlM3DP+EXV25A
         Z1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PdNpr+xjrLYU2MoWEBNF3xcNAmtPLys44nVVsueTa5k=;
        b=g+nGF5qgz0KjM6mkm64pSEUBPhSsjwesP0scQvoH7g53ivL2+LkvRM3I5LGjwWwOSm
         pX1aCvNAUUFN0PIOkkvqDzYD9rckN4Ba8pLkrXXC4gcxyBj9M24gEEGIT1lwSbAo/zME
         OywhQxCi2mTS4oOHC3XKa3V9HnRZIN11UVsttUYg+Wdxt9bP3yDJrCzPzIipP1ryZ7hn
         F3gR3+UQbSqIx/0VYQ5uertoL6tx9AYAsZ5ufaKzGDgh+x+/1QgToopzkaji/u7j2bo4
         3UL+R7Wlg9DALpq6jnp8Jk6MEPtk14Zgx9jD0ViKyBZUrJxCWiAr43bWOqdwMlV2YnOk
         YA+Q==
X-Gm-Message-State: APjAAAWNDFyLzM0tj9W23h5Thv3I8W5okFT9XugfAqC9xh9XoTednwv+
        jaA93CpSx4nMiHPfTy4qYhWpp1OT
X-Google-Smtp-Source: APXvYqywDVKv+J0KrulSmZUOuZYtcLuFuNyvkgjV3mAtSxUxROSG+BTIupmrdo7HnsnEuudY22R7Bg==
X-Received: by 2002:a5e:8344:: with SMTP id y4mr4729459iom.213.1566878712522;
        Mon, 26 Aug 2019 21:05:12 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id v10sm13759244iob.43.2019.08.26.21.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:05:12 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:05:10 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 09/13] t4014: use test_line_count() where possible
Message-ID: <9a42ec2b7e5f9bea3676655e3a066acac3bee1f6.1566878374.git.liu.denton@gmail.com>
References: <cover.1566635008.git.liu.denton@gmail.com>
 <cover.1566878373.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566878373.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert all instances of `cnt=$(... | wc -l) && test $cnt = N` into uses
of `test_line_count()`.

While we're at it, convert one instance of a Git command upstream of a
pipe into two commands. This prevents a failure of a Git command from
being masked since only the return code of the last member of the pipe
is shown.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 35cf798847..18142ee5fa 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -60,23 +60,23 @@ test_expect_success setup '
 
 test_expect_success 'format-patch --ignore-if-in-upstream' '
 	git format-patch --stdout master..side >patch0 &&
-	cnt=$(grep "^From " patch0 | wc -l) &&
-	test $cnt = 3
+	grep "^From " patch0 >from0 &&
+	test_line_count = 3 from0
 '
 
 test_expect_success 'format-patch --ignore-if-in-upstream' '
 	git format-patch --stdout \
 		--ignore-if-in-upstream master..side >patch1 &&
-	cnt=$(grep "^From " patch1 | wc -l) &&
-	test $cnt = 2
+	grep "^From " patch1 >from1 &&
+	test_line_count = 2 from1
 '
 
 test_expect_success 'format-patch --ignore-if-in-upstream handles tags' '
 	git tag -a v1 -m tag side &&
 	git tag -a v2 -m tag master &&
 	git format-patch --stdout --ignore-if-in-upstream v2..v1 >patch1 &&
-	cnt=$(grep "^From " patch1 | wc -l) &&
-	test $cnt = 2
+	grep "^From " patch1 >from1 &&
+	test_line_count = 2 from1
 '
 
 test_expect_success "format-patch doesn't consider merge commits" '
@@ -90,22 +90,23 @@ test_expect_success "format-patch doesn't consider merge commits" '
 	git checkout -b merger master &&
 	test_tick &&
 	git merge --no-ff slave &&
-	cnt=$(git format-patch -3 --stdout | grep "^From " | wc -l) &&
-	test $cnt = 3
+	git format-patch -3 --stdout >patch &&
+	grep "^From " patch >from &&
+	test_line_count = 3 from
 '
 
 test_expect_success 'format-patch result applies' '
 	git checkout -b rebuild-0 master &&
 	git am -3 patch0 &&
-	cnt=$(git rev-list master.. | wc -l) &&
-	test $cnt = 2
+	git rev-list master.. >list &&
+	test_line_count = 2 list
 '
 
 test_expect_success 'format-patch --ignore-if-in-upstream result applies' '
 	git checkout -b rebuild-1 master &&
 	git am -3 patch1 &&
-	cnt=$(git rev-list master.. | wc -l) &&
-	test $cnt = 2
+	git rev-list master.. >list &&
+	test_line_count = 2 list
 '
 
 test_expect_success 'commit did not screw up the log message' '
@@ -795,7 +796,8 @@ test_expect_success 'options no longer allowed for format-patch' '
 
 test_expect_success 'format-patch --numstat should produce a patch' '
 	git format-patch --numstat --stdout master..side >output &&
-	test 5 = $(grep "^diff --git a/" output | wc -l)
+	grep "^diff --git a/" output >diff &&
+	test_line_count = 5 diff
 '
 
 test_expect_success 'format-patch -- <path>' '
@@ -852,8 +854,8 @@ test_expect_success 'format-patch --signature --cover-letter' '
 	git config --unset-all format.signature &&
 	git format-patch --stdout --signature="my sig" --cover-letter \
 		-1 >output &&
-	grep "my sig" output &&
-	test 2 = $(grep "my sig" output | wc -l)
+	grep "my sig" output >sig &&
+	test_line_count = 2 sig
 '
 
 test_expect_success 'format.signature="" suppresses signatures' '
@@ -1591,7 +1593,8 @@ test_expect_success 'format-patch format.outputDirectory option' '
 	test_config format.outputDirectory patches &&
 	rm -fr patches &&
 	git format-patch master..side &&
-	test $(git rev-list master..side | wc -l) -eq $(ls patches | wc -l)
+	git rev-list master..side >list &&
+	test_line_count = $(ls patches | wc -l) list
 '
 
 test_expect_success 'format-patch -o overrides format.outputDirectory' '
-- 
2.23.0.248.g3a9dd8fb08

