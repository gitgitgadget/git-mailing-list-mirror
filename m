Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9127C1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755192AbdEKJTW (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:19:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34093 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755129AbdEKJTS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:19:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so5503743wmf.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CcKirEDw/BK8THeqRiSpRy2Ya5BeiKnvFgH33Fz9iK4=;
        b=rkvJn2ic7Aq8Uh/Hplwdf5MR5NWiQMFO+4quDCmxNwiXY5u94uMIPNzXNGdMWNq6Cr
         jpK7UPdO6IQwSIAJnhpSQo5LAwTUW1HRDzjc/mT913YG9eFs8te0JM1ej1hRKqWxFwXg
         szdi50b9rN7atLKRBNrCqQBMF8rvrG3WTmWdx9DGt3YMwmtM8PG8PaTRObjGAsJJUsAL
         t9ZF6SjK9SUZbjXu83jxXnUOQzilQXIt3AJ/zBjnqBVlY2R9v5g7pBgU5te37ALiH1hk
         NZ9cdoOBqbZt3lwkt+C0/mfhDVjymxzwFyI9rgm9Z07Dh1KjwBcAedfGJYfwXEIZb5zp
         R1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcKirEDw/BK8THeqRiSpRy2Ya5BeiKnvFgH33Fz9iK4=;
        b=sZYwY8GpLZmk6ROxqlN8DskKEdEsFtLqs2op+J08p9AXeLw5QqBM8gxzBXpxuz1JZA
         qSasjr+deW8xw8X+LtXmXFiKWZV3TUDlEkkoSZf+DtTy3zaFbSlPZGe7EGf13xFweE1S
         9q4oovkOZCJjoOwi4CkMFSg2fIJvJ4k5p49aSKN70txiexG8anZXe0buxBl5i4Ff3SdH
         MmptLOfWlK4w1u3hXT7VnaRTJCO78ZHdqW/pV74Ba4XdyW+ktGIK2l1TZthQGUmKg37w
         xC3gS03CbixqvMgEWJv9t1nFg53DTe3KxHfn88hlDmz5QuVZsdaoDZXFHHPPaju8AaRH
         syiA==
X-Gm-Message-State: AODbwcCvx8s0Be/SEPZmXjXVlIjId4Jv+MBvEJsgcSO6OBupvh2fWxRu
        +8C5f2zJcxurpQ==
X-Received: by 10.80.132.70 with SMTP id 64mr7486941edp.181.1494494357059;
        Thu, 11 May 2017 02:19:17 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:16 -0700 (PDT)
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
Subject: [PATCH 10/29] grep: add tests for grep pattern types being passed to submodules
Date:   Thu, 11 May 2017 09:18:10 +0000
Message-Id: <20170511091829.5634-11-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
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
index 3c580b38ba..ef658b7899 100755
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

