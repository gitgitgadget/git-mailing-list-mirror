Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA5720188
	for <e@80x24.org>; Sat, 13 May 2017 23:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758229AbdEMXPs (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:15:48 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33585 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758132AbdEMXPr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:15:47 -0400
Received: by mail-qk0-f196.google.com with SMTP id o85so12525848qkh.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLPtsvhMhbE/OtIRnX9nkV4MHDmpoJkQ40yq8sgYAmo=;
        b=Ig9l6JBaaY7P3vMiTY0wkvvGCci3PMffi4tGCfs1sqraQ8bf40ZmhieDPVWk/+ZR0g
         eUzbVzrlW/1s85ErQa+Vr7oop2R2rQf9FXq2V5FUyZyJBdqm+3GYkxiEYIBgU8guwiuU
         Mtk7vDgOm2EUQfK4bkfEkS+3WcuiILCaFK21m6esTeLN6lL6o2/TDcqQ7MXchsIVxTt4
         uKCXfRKFyjwVD1hPm45EFNBY8cut9+ndQ0RfLoP0jSTHCvkgVIVfFjWugpA2ondMSG09
         RPHzt7bup2PLg4Lkcr3PkTu9++M2gte0DtY865cJmXMy92kGnzeYlUl/PCWdeQckUd/z
         wurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLPtsvhMhbE/OtIRnX9nkV4MHDmpoJkQ40yq8sgYAmo=;
        b=nKpg+C66ocyIY5WCLDrCerHTnQ6diNlNjxaqoKc/M2dsTqtJML5mG9EsVewohKFlfz
         OqkVuQVq2oyTNtSu61F2HBjuI8lcCZoX8YKIqZLKR82XP5AwHgkDQPRj8DIv+nZjZKv7
         vMHTrwjNMhA6f9lTOtCO0v1fDS/vls5pYPqvzdhcOS7OI/L2VPXUO8tq72CbOC2wn3Lt
         RlaqFwzaWqZi/kViGzLlm2tmIXCRJcvONKDFY8WU88Qtyzbq3Nuwjq6mgiZMjb1yY1dL
         kKxKnwMfrXhXDekSnw8ObZ/NOBKBV+cCzYq7JG129oYVLxgazUQFJzkorQi5oYrA60Rc
         OTjQ==
X-Gm-Message-State: AODbwcDGwML1mA4QzR+e90z9R0fDH4ZXHDDd5IUBkERv++iDxy/rCDOZ
        qesV+U5IILX01Q==
X-Received: by 10.55.142.69 with SMTP id q66mr9562787qkd.13.1494717346679;
        Sat, 13 May 2017 16:15:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:15:45 -0700 (PDT)
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
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/29] log: add exhaustive tests for pattern style options & config
Date:   Sat, 13 May 2017 23:14:44 +0000
Message-Id: <20170513231509.7834-5-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
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
 t/t4202-log.sh | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index f577990716..e522a2fcd5 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -262,7 +262,28 @@ test_expect_success 'log --grep -i' '
 
 test_expect_success 'log -F -E --grep=<ere> uses ere' '
 	echo second >expect &&
-	git log -1 --pretty="tformat:%s" -F -E --grep=s.c.nd >actual &&
+	# basic would need \(s\) to do the same
+	git log -1 --pretty="tformat:%s" -F -E --grep="(s).c.nd" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success PCRE 'log -F -E --perl-regexp --grep=<pcre> uses PCRE' '
+	test_when_finished "rm -rf num_commits" &&
+	git init num_commits &&
+	(
+		cd num_commits &&
+		test_commit 1d &&
+		test_commit 2e
+	) &&
+	echo 2e >expect &&
+	# In PCRE \d in [\d] is like saying "0-9", and matches the 2
+	# in 2e...
+	git -C num_commits log -1 --pretty="tformat:%s" -F -E --perl-regexp --grep="[\d]" >actual &&
+	test_cmp expect actual &&
+	echo 1d >expect &&
+	# ...in POSIX basic & extended it is the same as [d],
+	# i.e. "d", which matches 1d, but not and does not match 2e.
+	git -C num_commits log -1 --pretty="tformat:%s" -F -E --grep="[\d]" >actual &&
 	test_cmp expect actual
 '
 
@@ -280,6 +301,77 @@ test_expect_success 'log with grep.patternType configuration and command line' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log with various grep.patternType configurations & command-lines' '
+	git init pattern-type &&
+	(
+		cd pattern-type &&
+		test_commit 1 file A &&
+
+		# The tagname is overridden here because creating a
+		# tag called "(1|2)" as test_commit would otherwise
+		# implicitly do would fail on e.g. MINGW.
+		test_commit "(1|2)" file B 2 &&
+
+		echo "(1|2)" >expect.fixed &&
+		cp expect.fixed expect.basic &&
+		cp expect.fixed expect.extended &&
+		cp expect.fixed expect.perl &&
+
+		# A strcmp-like match with fixed.
+		git -c grep.patternType=fixed log --pretty=tformat:%s \
+			--grep="(1|2)" >actual.fixed &&
+
+		# POSIX basic matches (, | and ) literally.
+		git -c grep.patternType=basic log --pretty=tformat:%s \
+			--grep="(.|.)" >actual.basic &&
+
+		# POSIX extended needs to have | escaped to match it
+		# literally, whereas under basic this is the same as
+		# (|2), i.e. it would also match "1". This test checks
+		# for extended by asserting that it is not matching
+		# what basic would match.
+		git -c grep.patternType=extended log --pretty=tformat:%s \
+			--grep="\|2" >actual.extended &&
+		if test_have_prereq PCRE
+		then
+			# Only PCRE would match [\d]\| with only
+			# "(1|2)" due to [\d]. POSIX basic would match
+			# both it and "1", and POSIX extended would
+			# match neither.
+			git -c grep.patternType=perl log --pretty=tformat:%s \
+				--grep="[\d]\|" >actual.perl &&
+			test_cmp expect.perl actual.perl
+		fi &&
+		test_cmp expect.fixed actual.fixed &&
+		test_cmp expect.basic actual.basic &&
+		test_cmp expect.extended actual.extended &&
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
+		if test_have_prereq PCRE
+		then
+			git log --pretty=tformat:%s --perl-regexp \
+				--grep="[\d]\|" >actual.perl.long-arg &&
+			test_cmp expect.perl actual.perl.long-arg
+
+		fi &&
+		test_cmp expect.fixed actual.fixed.long-arg &&
+		test_cmp expect.basic actual.basic.long-arg &&
+		test_cmp expect.extended actual.extended.long-arg
+	)
+'
+
 cat > expect <<EOF
 * Second
 * sixth
-- 
2.11.0

