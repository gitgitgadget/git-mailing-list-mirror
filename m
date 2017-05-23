Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8275920281
	for <e@80x24.org>; Tue, 23 May 2017 19:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764458AbdEWTZ1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:25:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36679 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764386AbdEWTZY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:25:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id k15so40570923wmh.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=r87BKAHucgtjSeg4AObx4z9vIX8Waok1gaLH+PqO2EQ=;
        b=iKB6MuJn1JKcrTBxkWIwvAW9JYCJEA5bjX8tPs0FOCwb8mz7rSlmeE12IzUCUn/2Pc
         Qu/LpdvFe8DOSUJx4G6DHr6hm/34oSBmX53auzi3NNXvT4Iav59W+YeMKlTrZ2VRzoAI
         qDWg0rBcQG1ex8GA9Y7It/gNpFoRg68+j99K9mFBXvmQLr3wEDcc01GEPwpTrH+cuF1Y
         UvbHQF1acIfcUB11E9VAIpYElIPTEJCFJoi6TKM7oa83bfBh9g03kTEUEGkmbRDOfloA
         mQvmv8GPKQRUqlbg6LvlxGI8cV6b1Lw3tcSDv4QJDCNIBQmTQcq2xpG5XNeAOr1h3h6L
         OAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r87BKAHucgtjSeg4AObx4z9vIX8Waok1gaLH+PqO2EQ=;
        b=SURrjEFF/ZNAKGurKfH3Jvk33XlNSih+KS6ImBNTkGm88O+xFUOIrlB1fj55gA49H5
         3c+HGkLjh0jK6GhpoQ89R4XxiI753uLlFvJV70AvcfnO+dak7j7dei+Z31xGoyhjlfpu
         LNgV3CYi1b/m+rqldWwph+lWIxsZ0RNucRD+mX9j9rVqrB4eeP3nRuHUhIciJfFtOOSa
         60D1P/8+OP7L1+ixR809DGHpE9RQs+ma6NJCnnX3Bfz7aMG3lGKiIL/3sjrXUBcI86wC
         7+sKSH7uPOXhpE1iaE7Htu8MJNmMUrgQnIGkp++nPi8BYRicKiYFDRcjL21h28yOdyfM
         6duw==
X-Gm-Message-State: AODbwcA7rh00vrHgAZWjVMm/wOvhdO5hd2hk1sWiQSUCHFYTiENy0pdI
        XJ8rDM82hegc1A==
X-Received: by 10.28.210.13 with SMTP id j13mr3306759wmg.110.1495567523177;
        Tue, 23 May 2017 12:25:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a24sm2203480wra.17.2017.05.23.12.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:25:22 -0700 (PDT)
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
        Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/7] log: add -P as a synonym for --perl-regexp
Date:   Tue, 23 May 2017 19:24:49 +0000
Message-Id: <20170523192453.14172-4-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170523192453.14172-1-avarab@gmail.com>
References: <20170523192453.14172-1-avarab@gmail.com>
In-Reply-To: <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
References: <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a short -P option as a synonym for the longer --perl-regexp, for
consistency with the options the corresponding grep invocations
accept.

This was intentionally omitted in commit 727b6fc3ed ("log --grep:
accept --basic-regexp and --perl-regexp", 2012-10-03) for unspecified
future use.

Make it consistent with "grep" rather than to keep it open for future
use, and to avoid the confusion of -P meaning different things for
grep & log, as is the case with the -G option.

As noted in the aforementioned commit the --basic-regexp option can't
have a corresponding -G argument, as the log command already uses that
for -G<regex>.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/rev-list-options.txt |  1 +
 revision.c                         |  2 +-
 t/t4202-log.sh                     | 12 ++++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a46f70c2b1..9c44eae55d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -91,6 +91,7 @@ endif::git-rev-list[]
 	Consider the limiting patterns to be fixed strings (don't interpret
 	pattern as a regular expression).
 
+-P::
 --perl-regexp::
 	Consider the limiting patterns to be Perl-compatible regular
 	expressions.
diff --git a/revision.c b/revision.c
index 4883cdd2d0..60329da1bd 100644
--- a/revision.c
+++ b/revision.c
@@ -1996,7 +1996,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_FIXED;
-	} else if (!strcmp(arg, "--perl-regexp")) {
+	} else if (!strcmp(arg, "--perl-regexp") || !strcmp(arg, "-P")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_PCRE;
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index dbed3efeee..2b07d1c0c2 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -404,8 +404,20 @@ test_expect_success 'log with various grep.patternType configurations & command-
 			--grep="(1|2)" >actual.fixed.short-arg &&
 		git log --pretty=tformat:%s -E \
 			--grep="\|2" >actual.extended.short-arg &&
+		if test_have_prereq PCRE
+		then
+			git log --pretty=tformat:%s -P \
+				--grep="[\d]\|" >actual.perl.short-arg
+		else
+			test_must_fail git log -P \
+				--grep="[\d]\|"
+		fi &&
 		test_cmp expect.fixed actual.fixed.short-arg &&
 		test_cmp expect.extended actual.extended.short-arg &&
+		if test_have_prereq PCRE
+		then
+			test_cmp expect.perl actual.perl.short-arg
+		fi &&
 
 		git log --pretty=tformat:%s --fixed-strings \
 			--grep="(1|2)" >actual.fixed.long-arg &&
-- 
2.13.0.303.g4ebf302169

