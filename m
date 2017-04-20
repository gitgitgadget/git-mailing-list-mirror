Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8076207BE
	for <e@80x24.org>; Thu, 20 Apr 2017 21:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032082AbdDTVZS (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:25:18 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33171 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947792AbdDTVYj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:24:39 -0400
Received: by mail-wr0-f193.google.com with SMTP id w50so4636820wrc.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2P80E2YsGGzL/3m1OL2CSW3g7GZlRDYEHb+bnrLdkxg=;
        b=B+nQ7jr65tg8Dvb4x+Hxq+NCOT/NKxgOTn1l1nftGqA7BWiRmXwYgb3Jn6yb4vwL06
         U/4UKtGHellWSar60tf6F68HTCDyWF3ws++sVvh5Q+4sq9ZHsW2x4maGnHuspddoe5lv
         lm1sGzljh6FExNumU6dCdmdeVMhRlmAbI8j1e9+BrcFiIYbSUzC37/lUXk7ZEPjqxSXx
         lcm+JT3ViQyqiNebVgGfQdb6HHFkMCmfDyxDekCSbkPV0nSfg82T5IAutoes/hiXCDTj
         m9q+b4Z+OpmQmRDs3X07C34NjHwDFzQv+JGaoG/patGPInmXw6H+6V5vHmoog7vrwOF8
         +rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2P80E2YsGGzL/3m1OL2CSW3g7GZlRDYEHb+bnrLdkxg=;
        b=VpBVyA5K87ENVPfABMOXx5uOwsM4853NYT0yeVrBxGuTcm+DP7xl8yQ54PkGsfqwCK
         UeNFTJxjye+84Zttkq80Bdm0QCmLMRllie88L4g0o7NN6G64R1VUk2m1OJmBmOKGg0mf
         p5n06xEeaZ9TBZQ4xlTBkwDfLLygI71HQuQKU5BiPrrRfKGSfGaeHOvICrs/v0jE755h
         RJXOmAJX0Y2LbjtG/B24aPQkc7FSzfv+Bhb4Zl0eljOZr7altBLyNOZNyNN+ZTEXuh2j
         1W85cNdkW5B80LuDYAVzWCk4eNSLOZkcZfIu+MuhhDFSC++bGrvaWckAirJvUkj+egy0
         wBkg==
X-Gm-Message-State: AN3rC/4ez+ApGbqojs4j7Tc1Yo0KFo4bNjeZjpIWIa47Ixq5TvrWscCj
        0Ek4XSJoa4tQZQ==
X-Received: by 10.223.175.218 with SMTP id y26mr9253422wrd.63.1492723477958;
        Thu, 20 Apr 2017 14:24:37 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k63sm442322wmf.9.2017.04.20.14.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 14:24:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/18] log: add exhaustive tests for pattern style options & config
Date:   Thu, 20 Apr 2017 21:23:34 +0000
Message-Id: <20170420212345.7408-8-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170420212345.7408-1-avarab@gmail.com>
References: <20170420212345.7408-1-avarab@gmail.com>
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
 t/t4202-log.sh | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index f577990716..fc186f10ea 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -262,7 +262,23 @@ test_expect_success 'log --grep -i' '
 
 test_expect_success 'log -F -E --grep=<ere> uses ere' '
 	echo second >expect &&
-	git log -1 --pretty="tformat:%s" -F -E --grep=s.c.nd >actual &&
+	git log -1 --pretty="tformat:%s" -F -E --grep="(s).c.nd" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success LIBPCRE 'log -F -E --perl-regexp --grep=<pcre> uses PCRE' '
+	test_when_finished "rm -rf num_commits" &&
+	git init num_commits &&
+	(
+		cd num_commits &&
+		test_commit 1d &&
+		test_commit 2e
+	) &&
+	echo 2e >expect &&
+	git -C num_commits log -1 --pretty="tformat:%s" -F -E --perl-regexp --grep="[\d]" >actual &&
+	test_cmp expect actual &&
+	echo 1d >expect &&
+	git -C num_commits log -1 --pretty="tformat:%s" -F -E --grep="[\d]" >actual &&
 	test_cmp expect actual
 '
 
@@ -280,6 +296,65 @@ test_expect_success 'log with grep.patternType configuration and command line' '
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
+				--grep="[\d]\|" >actual.perl
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
+				--grep="[\d]\|" >actual.perl.long-arg
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

