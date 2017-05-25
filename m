Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFACB20284
	for <e@80x24.org>; Thu, 25 May 2017 19:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036680AbdEYTqO (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:46:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33668 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036667AbdEYTqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:46:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id b84so39668671wmh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IW8fbNco5Hqf3yHvTye8KqqdrLtzBNEOBnUoah7/Ios=;
        b=IJzrijEuVnSCv36urfT9z4VBZHcuq03+4R+hAi5LRsuFV19Nf8pCyQ/cFbwdiUi3pm
         KxFIsZG/i6e6dHh89ghZdfPCuDR/wUOBOmLrahO0q+51uo6PrsQMJcCLbmc10A9c2CEm
         s9JmqxEwJJWUvsHnBbvYgiZ/9nRBFlkC5ESDEPVY91xZ300JdXHRkCB+saTcKK04rfqp
         50V5pVI3sW0gNo9n1JKgtgLcl+U+y82Fk1f3Rd7MtPEp0SeWIcD5Jeip+vkcXzdO+uee
         amNwPSb152KWCf+jFA+sDgbhzreTBjur02PcdUIjfXEK6xLbWYd/hOiJpM6fQ2v096b9
         07JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IW8fbNco5Hqf3yHvTye8KqqdrLtzBNEOBnUoah7/Ios=;
        b=mTz+7u8K9DfQxJjzsVbNcbxeOQZf0zi0Ska0m4a0EGW866+gywkRf+9NK7VReSIQcd
         MoUg2YC6eRWb95v2hty9E6j7sOmyHN50TEQrbtfkkcj4B/hglnuhHDkF4KsUuwq8OKxt
         erlQrOmhd8oct/d3nngdcII/Bya3mw2NhmgEQTcviC3KjZHWU8v4rt9uHlv2UMtijKOb
         /P/PXvz9X5JDmyeRoBj4lon3nlimHgXSUhvf9fchp9JinKX+fYmTadBxfgYC3oTMiCLF
         hH69NiBTtYvGoNaUzVuIjHzTO/IFhYx038HRZK8exRFevLSsCgayFw4tfzBfVu/cPa0U
         BvCg==
X-Gm-Message-State: AODbwcCgy9fUdR2Jcq9uLSfFoWKYjoPYR0rbAaQw26cX/3qr9iMeSqj2
        d0VeQvNhszna7/933X8=
X-Received: by 10.28.4.210 with SMTP id 201mr2723396wme.1.1495741566965;
        Thu, 25 May 2017 12:46:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:46:05 -0700 (PDT)
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
Subject: [PATCH v4 05/31] log: make --regexp-ignore-case work with --perl-regexp
Date:   Thu, 25 May 2017 19:45:09 +0000
Message-Id: <20170525194535.9324-6-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the --regexp-ignore-case option work with --perl-regexp. This
never worked, and there was no test for this. Fix the bug and add a
test.

When PCRE support was added in commit 63e7e9d8b6 ("git-grep: Learn
PCRE", 2011-05-09) compile_pcre_regexp() would only check
opt->ignore_case, but when the --perl-regexp option was added in
commit 727b6fc3ed ("log --grep: accept --basic-regexp and
--perl-regexp", 2012-10-03) the code didn't set the opt->ignore_case.

Change the test suite to test for -i and --invert-regexp with
basic/extended/perl patterns in addition to fixed, which was the only
patternType that was tested for before in combination with those
options.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c     |  1 +
 t/t4202-log.sh | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index 8a8c1789c7..4883cdd2d0 100644
--- a/revision.c
+++ b/revision.c
@@ -1991,6 +1991,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_ERE;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
+		revs->grep_filter.ignore_case = 1;
 		revs->grep_filter.regflags |= REG_ICASE;
 		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 948fd719d2..c25eb9afd1 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -231,14 +231,47 @@ second
 initial
 EOF
 test_expect_success 'log --invert-grep --grep' '
-	git log --pretty="tformat:%s" --invert-grep --grep=th --grep=Sec >actual &&
-	test_cmp expect actual
+	# Fixed
+	git -c grep.patternType=fixed log --pretty="tformat:%s" --invert-grep --grep=th --grep=Sec >actual &&
+	test_cmp expect actual &&
+
+	# POSIX basic
+	git -c grep.patternType=basic log --pretty="tformat:%s" --invert-grep --grep=t[h] --grep=S[e]c >actual &&
+	test_cmp expect actual &&
+
+	# POSIX extended
+	git -c grep.patternType=basic log --pretty="tformat:%s" --invert-grep --grep=t[h] --grep=S[e]c >actual &&
+	test_cmp expect actual &&
+
+	# PCRE
+	if test_have_prereq PCRE
+	then
+		git -c grep.patternType=perl log --pretty="tformat:%s" --invert-grep --grep=t[h] --grep=S[e]c >actual &&
+		test_cmp expect actual
+	fi
 '
 
 test_expect_success 'log --invert-grep --grep -i' '
 	echo initial >expect &&
-	git log --pretty="tformat:%s" --invert-grep -i --grep=th --grep=Sec >actual &&
-	test_cmp expect actual
+
+	# Fixed
+	git -c grep.patternType=fixed log --pretty="tformat:%s" --invert-grep -i --grep=th --grep=Sec >actual &&
+	test_cmp expect actual &&
+
+	# POSIX basic
+	git -c grep.patternType=basic log --pretty="tformat:%s" --invert-grep -i --grep=t[h] --grep=S[e]c >actual &&
+	test_cmp expect actual &&
+
+	# POSIX extended
+	git -c grep.patternType=extended log --pretty="tformat:%s" --invert-grep -i --grep=t[h] --grep=S[e]c >actual &&
+	test_cmp expect actual &&
+
+	# PCRE
+	if test_have_prereq PCRE
+	then
+		git -c grep.patternType=perl log --pretty="tformat:%s" --invert-grep -i --grep=t[h] --grep=S[e]c >actual &&
+		test_cmp expect actual
+	fi
 '
 
 test_expect_success 'log --grep option parsing' '
@@ -256,8 +289,25 @@ test_expect_success 'log -i --grep' '
 
 test_expect_success 'log --grep -i' '
 	echo Second >expect &&
+
+	# Fixed
 	git log -1 --pretty="tformat:%s" --grep=sec -i >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	# POSIX basic
+	git -c grep.patternType=basic log -1 --pretty="tformat:%s" --grep=s[e]c -i >actual &&
+	test_cmp expect actual &&
+
+	# POSIX extended
+	git -c grep.patternType=extended log -1 --pretty="tformat:%s" --grep=s[e]c -i >actual &&
+	test_cmp expect actual &&
+
+	# PCRE
+	if test_have_prereq PCRE
+	then
+		git -c grep.patternType=perl log -1 --pretty="tformat:%s" --grep=s[e]c -i >actual &&
+		test_cmp expect actual
+	fi
 '
 
 test_expect_success 'log -F -E --grep=<ere> uses ere' '
-- 
2.13.0.303.g4ebf302169

