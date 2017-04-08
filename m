Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256FE20970
	for <e@80x24.org>; Sat,  8 Apr 2017 13:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbdDHN0G (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 09:26:06 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33088 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbdDHN0E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 09:26:04 -0400
Received: by mail-wr0-f193.google.com with SMTP id g19so23519192wrb.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1EK76eUAeTwg7xQlWzWduWJlyRsJ2drtiQMIYfZFrh4=;
        b=RDCuhf1Erj0CGFXEkqa7tXTXrSmv3hW+rsJ5bIVXDVJ3ZHcgBndfPERApM0+okKYQd
         YdPB/3k0n9km+Bwt/4hHf2zWc9TOWJPmbPEnkZ8sCMsfKvQdz8VA0rg2SwSdgSQl5mRo
         73flZxmyigRavJvYzxGMiox1mOsxhiMcOncPEjIZoneFYGDKibv3/Z/MBcfPdt4cJVPr
         t9hmfj0vsbSnQLeHouPYwYMCi58IzDqP3X1EZXuGj91KUC/O4HHABLnPpS6d3UCS77V0
         L+rZ8FhvILR2A2Oi9edIaKll+ZlVjLns61FtlTwNo3gVsNJYTKtztmajXSbpWDf75nFo
         q9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EK76eUAeTwg7xQlWzWduWJlyRsJ2drtiQMIYfZFrh4=;
        b=fH4nb9nCwgU1kw4TgDrvyMuQqwFXnBvetxTq6Hzo6QisScBUqO6EORPMYojFSd8hEN
         uMAFGPzEWTJU/KrcgmlAYrZUzRmyckFYwgwegq1qKVm8Gd78x0eNlJGMUdTbEb7+KVa6
         GgFkqRnBE2kKU3Sv6GufiCRdG7xK0C3jZZ2QHzWoLOg9Tsmpgsx0RO4QmJhNOTVXkw9r
         nnZGBqTK/cjuGFX1wpBvGgvVvlzDMyGdzdX5NmPoH0DOQVnJPc3J4dsZYLuABbV+8c59
         X13I3iqLyXoND/pXDzo/6TvBFOSKtviA7Ip8n6ikqpz07+7YZR2NZ7hisTwYKD9Cgz4w
         H9XA==
X-Gm-Message-State: AN3rC/4W2vw7/Ij4MG+2vX5g1HcLY7RCuIpMrT7ukbpszWJVOCR8nTtW0552gYhtzMOfFQ==
X-Received: by 10.223.169.34 with SMTP id u31mr9935871wrc.54.1491657962513;
        Sat, 08 Apr 2017 06:26:02 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v14sm2744864wmv.24.2017.04.08.06.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 06:26:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/12] log: add exhaustive tests for pattern style options & config
Date:   Sat,  8 Apr 2017 13:24:59 +0000
Message-Id: <20170408132506.5415-6-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170408132506.5415-1-avarab@gmail.com>
References: <20170408132506.5415-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add exhaustive tests for how the different grep.patternType options &
the corresponding command-line options affect git-log.

Before this change it was possible to patch revision.c so that the
--basic-regexp option was synonymous with --extended-regexp, and
--perl-regexp wasn't recognized at all, and still have 100% of the
test suite pass.

This was because the first test being modified here, added in commit
34a4ae55b2 ("log --grep: use the same helper to set -E/-F options as
"git grep"", 2012-10-03), didn't actually check whether we'd enabled
extended regular expressions as distinct from re-toggling non-fixed
string support.

Fix that by changing the pattern to a pattern that'll only match if
--extended-regexp option is provided, but won't match under the
default --basic-regexp option.

Other potential regressions were possible since there were no tests
for the rest of the combinations of grep.patternType configuration
toggles & corresponding git-log command-line options. Add exhaustive
tests for those.

The patterns being passed to fixed/basic/extended/PCRE are carefully
crafted to return the wrong thing if the grep engine were to pick any
other matching method than the one it's told to use.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 48b55bfd27..00d0585253 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -261,7 +261,13 @@ test_expect_success 'log --grep -i' '
 
 test_expect_success 'log -F -E --grep=<ere> uses ere' '
 	echo second >expect &&
-	git log -1 --pretty="tformat:%s" -F -E --grep=s.c.nd >actual &&
+	git log -1 --pretty="tformat:%s" -F -E --grep="(s).c.nd" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success LIBPCRE 'log -F -E --perl-regexp --grep=<pcre> uses PCRE' '
+	echo second >expect &&
+	git log -1 --pretty="tformat:%s" -F -E --perl-regexp --grep="s(?=ec)econd" >actual &&
 	test_cmp expect actual
 '
 
@@ -279,6 +285,65 @@ test_expect_success 'log with grep.patternType configuration and command line' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log with various grep.patternType configurations & command-lines' '
+	git init pattern-type &&
+	(
+		cd pattern-type &&
+		test_commit 1 file A &&
+		test_commit "(1|2)" file B &&
+
+		echo "(1|2)" >expect.fixed &&
+		cp expect.fixed expect.basic &&
+		cp expect.fixed expect.extended &&
+		cp expect.fixed expect.perl &&
+
+		git -c grep.patternType=fixed log --pretty=tformat:%s \
+			--grep="(1|2)" >actual.fixed &&
+		git -c grep.patternType=basic log --pretty=tformat:%s \
+			--grep="(.|.)" >actual.basic &&
+		git -c grep.patternType=extended log --pretty=tformat:%s \
+			--grep="\|2" >actual.extended &&
+		if test_have_prereq LIBPCRE
+		then
+			git -c grep.patternType=perl log --pretty=tformat:%s \
+				--grep="\((?=1)" >actual.perl
+		fi &&
+		test_cmp expect.fixed actual.fixed &&
+		test_cmp expect.basic actual.basic &&
+		test_cmp expect.extended actual.extended &&
+		if test_have_prereq LIBPCRE
+		then
+			test_cmp expect.perl actual.perl
+		fi &&
+
+		git log --pretty=tformat:%s -F \
+			--grep="(1|2)" >actual.fixed.short-arg &&
+		git log --pretty=tformat:%s -E \
+			--grep="\|2" >actual.extended.short-arg &&
+		test_cmp expect.fixed actual.fixed.short-arg &&
+		test_cmp expect.extended actual.extended.short-arg &&
+
+		git log --pretty=tformat:%s --fixed-strings \
+			--grep="(1|2)" >actual.fixed.long-arg &&
+		git log --pretty=tformat:%s --basic-regexp \
+			--grep="(.|.)" >actual.basic.long-arg &&
+		git log --pretty=tformat:%s --extended-regexp \
+			--grep="\|2" >actual.extended.long-arg &&
+		if test_have_prereq LIBPCRE
+		then
+			git log --pretty=tformat:%s --perl-regexp \
+				--grep="\((?=1)" >actual.perl.long-arg
+		fi &&
+		test_cmp expect.fixed actual.fixed.long-arg &&
+		test_cmp expect.basic actual.basic.long-arg &&
+		test_cmp expect.extended actual.extended.long-arg &&
+		if test_have_prereq LIBPCRE
+		then
+			test_cmp expect.perl actual.perl.long-arg
+		fi
+	)
+'
+
 cat > expect <<EOF
 * Second
 * sixth
-- 
2.11.0

