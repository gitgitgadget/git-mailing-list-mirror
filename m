Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50FCE20188
	for <e@80x24.org>; Sat, 13 May 2017 23:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758679AbdEMXQV (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:16:21 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32781 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758672AbdEMXQT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:16:19 -0400
Received: by mail-qt0-f194.google.com with SMTP id a46so11218566qte.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2zMwXh8trdmcwjE/e2uC+o9wo1wy08yAT61WNTksp+M=;
        b=VfFMQpLzh3Oeg41Wgbdyv3AsLoPdkqcQeCLlVV4pmyZHjZ3kna4orA+GMGtOuCal3A
         2q1AYlB2SHi4KNNrTnrKExpbcxVjkiUhrWyjbd1GyOnr8XCl7YjWVtUx1Nne77a0Eo5L
         o/y2EYfjgq8zDUgczy4tRhWLtzZA3G89uKhnCbUFxPK6cdbWR3e8q6mvSYg8NhO4ayU6
         bypWQJXtJmaPDmAc13R4tSEqJInImAY6/ioXp3iCeUgpFheyK69ssG6n9W7RdxnQ22Y6
         e4J0IxFbKnvLw1IUW+rK5BU9dS03e7hieoxCiFf+ApD6aihmI0fb28UYdTjVe3V8XpV4
         qhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2zMwXh8trdmcwjE/e2uC+o9wo1wy08yAT61WNTksp+M=;
        b=DUH+uxPRrqeuOci3RyfdezXjBlDpXDQbKRR4ZoBz0EHsfpk77wHnTMSqnht82y9i/2
         zxQOFIb4zNQtR2PryKliMNw5RoeGFLiOPFfM4P9AMoWRibY3b89o1gDdio6yzFo57gKV
         Y0TOzFRkZQv3NnVCcBvwWPY//O3h5expLzKUUH9PJ/LO0yF3tNS+b7EFxSl6fmKvrsRw
         Nc9DT26oVs4WR1eQbHwBqsjgmfFfUg7QfEmVwH1wNJEx0mL/Pic6qNJxhWxwf+i+W4Wo
         gdjdXufnSOMkmslJJEQvMw3olulW4XAWeQqVeHmwyMVUCTG0fPARIFhLqMMvWGzkg4+C
         ACDg==
X-Gm-Message-State: AODbwcAHA0Ioer4ssqbojR1jUYpV7sDEyM7h2i1jCLpEAevBeJMUh6Qd
        uZptWMV+VBAQ0Q==
X-Received: by 10.237.56.38 with SMTP id j35mr3265846qte.288.1494717373743;
        Sat, 13 May 2017 16:16:13 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:16:12 -0700 (PDT)
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
Subject: [PATCH v2 10/29] grep: add tests for grep pattern types being passed to submodules
Date:   Sat, 13 May 2017 23:14:50 +0000
Message-Id: <20170513231509.7834-11-avarab@gmail.com>
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

Add testing for grep pattern types being correctly passed to
submodules. The pattern "(.|.)[\d]" matches differently under
fixed (not at all), and then matches different lines under
basic/extended & perl regular expressions, so this change asserts that
the pattern type is passed along correctly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7814-grep-recurse-submodules.sh | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 1472855e1d..3a58197f47 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -313,4 +313,53 @@ test_incompatible_with_recurse_submodules ()
 test_incompatible_with_recurse_submodules --untracked
 test_incompatible_with_recurse_submodules --no-index
 
+test_expect_success 'grep --recurse-submodules should pass the pattern type along' '
+	# Fixed
+	test_must_fail git grep -F --recurse-submodules -e "(.|.)[\d]" &&
+	test_must_fail git -c grep.patternType=fixed grep --recurse-submodules -e "(.|.)[\d]" &&
+
+	# Basic
+	git grep -G --recurse-submodules -e "(.|.)[\d]" >actual &&
+	cat >expect <<-\EOF &&
+	a:(1|2)d(3|4)
+	submodule/a:(1|2)d(3|4)
+	submodule/sub/a:(1|2)d(3|4)
+	EOF
+	test_cmp expect actual &&
+	git -c grep.patternType=basic grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+	test_cmp expect actual &&
+
+	# Extended
+	git grep -E --recurse-submodules -e "(.|.)[\d]" >actual &&
+	cat >expect <<-\EOF &&
+	.gitmodules:[submodule "submodule"]
+	.gitmodules:	path = submodule
+	.gitmodules:	url = ./submodule
+	a:(1|2)d(3|4)
+	submodule/.gitmodules:[submodule "sub"]
+	submodule/a:(1|2)d(3|4)
+	submodule/sub/a:(1|2)d(3|4)
+	EOF
+	test_cmp expect actual &&
+	git -c grep.patternType=extended grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+	test_cmp expect actual &&
+	git -c grep.extendedRegexp=true grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+	test_cmp expect actual &&
+
+	# Perl
+	if test_have_prereq PCRE
+	then
+		git grep -P --recurse-submodules -e "(.|.)[\d]" >actual &&
+		cat >expect <<-\EOF &&
+		a:(1|2)d(3|4)
+		b/b:(3|4)
+		submodule/a:(1|2)d(3|4)
+		submodule/sub/a:(1|2)d(3|4)
+		EOF
+		test_cmp expect actual &&
+		git -c grep.patternType=perl grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+		test_cmp expect actual
+	fi
+'
+
 test_done
-- 
2.11.0

