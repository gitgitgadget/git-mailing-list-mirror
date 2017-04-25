Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3A6207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954721AbdDYVGd (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:06:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32848 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948376AbdDYVGa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:06:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id y10so17340445wmh.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwlaqKrw7klxJIFcFHvPpNKfNHawuhZRwSB2NcOUEpk=;
        b=gQDwKv9St3tHRccZr4UC8B30JY1L86bYDeSIQfWkyU9vYMEnHQqicEZieGJQWoJ76s
         XRYAsKDwOx0fRnYhbFaBaYqp7jBJxR13WVI+SmbaWa1ETiE+oysjugTNCRy9wT+U0SLY
         d5XbKkCBtoUUPElXpzi75kjEeY1iU5gEm7HFfp8wlVI0PMv+wPsEoGuQEuCNcmsN2D2+
         VsVvWNoYDzKvv1pwVA9BJQ5NuJ6kkAcxZBhLG3hUVqHH/DxNArp95FmySja3zJkihDgZ
         e3pcOnJSzcAAAjccMbDKBlpqQt93UxzPkmd1tD100mfhi6LsJKFMgT+uP7iAGJZ8/06v
         spTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwlaqKrw7klxJIFcFHvPpNKfNHawuhZRwSB2NcOUEpk=;
        b=kQw62lIDyKRI/+wZBg1nc46TqNJnHx6AhdOuLF6cb8dicgWUtB3qq5RkwC2wKBKgfp
         Bs9sB5/t8neg01M0y4Cux2opM7jlhKFE6IRBW11lko8G6XBQt1jrmJH7lV7Yg6Xb8nFk
         eeHTs55BsnacZOcmWAVLBeYkELyS/NbqXiCsZm2d1XA0g+utbIRW+FgQQN8jzwMFqFwY
         PblapBbtTltLMKhwcGiVROSgvYfglGwedFnopO6LD59ZWNYoOBaVw9quNME98xqhngIq
         oYvjzcwHk3Gb6o7dzrZVU6RV4CsZreqhaAhkMeOstWL7NWlCy30wFXrumxoxDHFU5EZR
         l6CA==
X-Gm-Message-State: AN3rC/7EidDyetk4loVCvpHNzyK68ta04IQCB3LnOOTXUtyCZHiFbg+q
        GosVuTCaxqayQg==
X-Received: by 10.28.238.211 with SMTP id j80mr3467870wmi.97.1493154389226;
        Tue, 25 Apr 2017 14:06:29 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:28 -0700 (PDT)
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
Subject: [PATCH v4 09/19] log: add -P as a synonym for --perl-regexp
Date:   Tue, 25 Apr 2017 21:05:38 +0000
Message-Id: <20170425210548.24612-10-avarab@gmail.com>
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

Add a short -P option as a synonym for the longer --perl-regexp, for
consistency with the options the corresponding grep invocations
accept.

This was intentionally omitted in commit 727b6fc3ed ("log --grep:
accept --basic-regexp and --perl-regexp", 2012-10-03) for unspecified
future use.

Since nothing has come along in over 4 1/2 years that's wanted to use
it, it's more valuable to make it consistent with "grep" than to keep
it open for future use, and to avoid the confusion of -P meaning
different things for grep & log, as is the case with the -G option.

As noted in the aforementioned commit the --basic-regexp option can't
have a corresponding -G argument, as the log command already uses that
for -G<regex>.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/rev-list-options.txt | 1 +
 revision.c                         | 2 +-
 t/t4202-log.sh                     | 9 +++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a02f7324c0..5b7fa49a7f 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -91,6 +91,7 @@ endif::git-rev-list[]
 	Consider the limiting patterns to be fixed strings (don't interpret
 	pattern as a regular expression).
 
+-P::
 --perl-regexp::
 	Consider the limiting patterns to be Perl-compatible regular expressions.
 	Requires libpcre to be compiled in.
diff --git a/revision.c b/revision.c
index 7ff61ff5f7..03a3a012de 100644
--- a/revision.c
+++ b/revision.c
@@ -1995,7 +1995,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_FIXED;
-	} else if (!strcmp(arg, "--perl-regexp")) {
+	} else if (!strcmp(arg, "--perl-regexp") || !strcmp(arg, "-P")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_PCRE;
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index fc186f10ea..06acc848b8 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -331,8 +331,17 @@ test_expect_success 'log with various grep.patternType configurations & command-
 			--grep="(1|2)" >actual.fixed.short-arg &&
 		git log --pretty=tformat:%s -E \
 			--grep="\|2" >actual.extended.short-arg &&
+		if test_have_prereq PCRE
+		then
+			git log --pretty=tformat:%s -P \
+				--grep="[\d]\|" >actual.perl.short-arg
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
2.11.0

