Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF3D201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756335AbdETVnA (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:00 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36526 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756280AbdETVm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:42:57 -0400
Received: by mail-wr0-f193.google.com with SMTP id v42so5740717wrc.3
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vV7BFiq/BTehNN11B98yop+05YUyY0d6/QUseeX/WcI=;
        b=C51XqOpajK/1DS5nU0yGjMv2DC5KZDoJ1+cjEgXQESL9HjxGRWlmS9z2yRXVgZopaL
         J5g6M+zI56qWl7H3I92Hu5gBcrzuLvmkzKTjKmvZyzryk3jpKvblhdGvfjEjdf1A9Ase
         QTiWHJUvUewFkB+JHc6rnr6s32ej7xFCv7rcVX+/fFQ8HyrQm+GDRPeQMl+ufCm4hCb4
         /FXq7TmVTtUrVlIQSUFlqjuK+hpsuGKeYO5oOY57ZRBYK0CJK5PPLZIh7hn3ND5D4B0q
         i8Y227HySErbI8P2tZ1yVmRHs9IPjKwAQlKPcJTltj1cxKnop7uwUT/Msczu74xrLDsj
         b1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vV7BFiq/BTehNN11B98yop+05YUyY0d6/QUseeX/WcI=;
        b=CzdCq5B66iQ3QNByo9vTCsL7acI6NfeayHEncIPz4i57ooSdoqVcWaEePWSYG/hK82
         ZIQMfJNrZ/E+ecqLGqjlSpJ27+rjsjDwmJkKSRuXdrIY3bhOllaZA+/zQm3LcbqRrH1F
         cMOgFiJajff2IAPs6YibbBcoMW+WkPnbdMv1jWORj9i4RX/iN/iT+pFWzFwwqZzC/mSl
         thsbbijAE5FK8W3lPR3ee7yo8rltXFKUHphlTbeTqKdS4AcgwB9dIpJEKg/GX8RgE3FW
         8Sf66gbgBeGqhFpvla14l/xX9gVv8IfjnUMgN/SjxOuk87QzekWm0n3KHYIf/FAFCog5
         ovbQ==
X-Gm-Message-State: AODbwcD2TWU20u5NK5pnJ7bh56Ue9wXk8lU5Vujyridc7RhLJBiL6lIt
        gPKMFkEP1YJ0bA==
X-Received: by 10.223.161.65 with SMTP id r1mr7821470wrr.114.1495316575781;
        Sat, 20 May 2017 14:42:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:42:54 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/30] log: add exhaustive tests for pattern style options & config
Date:   Sat, 20 May 2017 21:42:07 +0000
Message-Id: <20170520214233.7183-5-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
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
 t/t4202-log.sh | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index f577990716..a8dce0ca2d 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -262,7 +262,30 @@ test_expect_success 'log --grep -i' '
 
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
+
+	# In PCRE \d in [\d] is like saying "0-9", and matches the 2
+	# in 2e...
+	echo 2e >expect &&
+	git -C num_commits log -1 --pretty="tformat:%s" -F -E --perl-regexp --grep="[\d]" >actual &&
+	test_cmp expect actual &&
+
+	# ...in POSIX basic and extended it is the same as [d],
+	# i.e. "d", which matches 1d, but does not match 2e.
+	echo 1d >expect &&
+	git -C num_commits log -1 --pretty="tformat:%s" -F -E --grep="[\d]" >actual &&
 	test_cmp expect actual
 '
 
@@ -280,6 +303,79 @@ test_expect_success 'log with grep.patternType configuration and command line' '
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
+			# both it and "1" since similarly to the
+			# extended match above it is the same as
+			# \([\d]\|\). POSIX extended would
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
2.13.0.303.g4ebf302169

