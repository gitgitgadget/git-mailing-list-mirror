Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12BDD207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1951603AbdDYVGJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:06:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36318 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948415AbdDYVGH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:06:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id u65so28341383wmu.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=789INEetGrvUv7Ch6HT3OXGp1klQ8InIPdM0lHM0t7o=;
        b=iBb1X/VJY1mMzPIn4x37O1aOxLQBndJ94i9ln6oqn5XIZuzXsVPfpzpr+rjrfc+RHz
         0c4wlrcRlGrkbUpyBJXQuFf/SfOWstPwEhsj6M0HYWAZ+cbcSYnEthRe85a4p9LMFkRj
         NPxG/LmeUjcqlY+gTyC4m5MuM0uSe/4zjZRbf733/+q27mrl18er47t6olbfFZQxmCGs
         vprRkbxiiDGEBCtoc5o3q2HZiqn3yFHvKYkR4v0Q7x6rGzM8fM9etSFkibYjsPhJS1M8
         V75P+LqXcNO+YwrtDKXXp4B91lcJFqULWxKilU9VmwCSI9dXCKPIDZxIbcuKQmVLGHSG
         cnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=789INEetGrvUv7Ch6HT3OXGp1klQ8InIPdM0lHM0t7o=;
        b=gOp2h6cAYbqpXjYpGlWBieJ4vGVBNqqalqki5ch3DxzHJgVTbFOSe74bMvo0Bkbbgw
         NZK/qsqWaSOSEJHorg+uGrWaFL0hU/n4RdGQbtVsApV0U5ENYn5OYJgES+xu1QXI2j+p
         YHVhCk5I6/jTLe/f1QGKELskNJDW1uiG1cs2CyQeGYxD3FfbQQZ8qh+zM+SuP6xvo9Aq
         Ify844gOWQCeoMAp4QuLEWQiRGSQNKL+3ZTcyrzrdaklqHlByT0VxYBQmD2sE1AHzviH
         tXrtQx1GyjLaKXLKCwdPvilhAtZmyiRpHrt1jJs3yWzX9Dr2NZ03lhHqUDfcsyHM21rw
         rn9g==
X-Gm-Message-State: AN3rC/6gilxhMEOSqcwV04iCg8BBKOsKy3eoo+PbhKU3SWwLfKt1nX2u
        qU9ZMx2NGpxNug==
X-Received: by 10.28.158.82 with SMTP id h79mr3410257wme.59.1493154366013;
        Tue, 25 Apr 2017 14:06:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:05 -0700 (PDT)
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
Subject: [PATCH v4 02/19] grep: add tests for grep pattern types being passed to submodules
Date:   Tue, 25 Apr 2017 21:05:31 +0000
Message-Id: <20170425210548.24612-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170425210548.24612-1-avarab@gmail.com>
References: <20170425210548.24612-1-avarab@gmail.com>
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
index 3c580b38ba..e1822feaf1 100755
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
+	if test_have_prereq LIBPCRE
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

