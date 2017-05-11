Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E76E2018D
	for <e@80x24.org>; Thu, 11 May 2017 17:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933045AbdEKRCa (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:02:30 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34957 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbdEKRC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:02:27 -0400
Received: by mail-qk0-f196.google.com with SMTP id k74so4497569qke.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KO/y+sV6HVxO7LqYApv5GcMwSc9+aXS1zcQkMHwSrhw=;
        b=FGfhQuGoI2ZQgW4NFM3mcRcwimdwm9VN304Vaxk4utIITZSKhogL1jkrQ8cFEwLu67
         iuVGpMksu9ZlHLZwVO2WizWocWOyP0QhvpCxZqIKY/z3grIBR/SHHYotG5OkWNNTtgs8
         mEQSIyF0lhXov8gSvFYWT3ipK23G9A06x+JT2EwvMp4UJob0gXUlEk0XhDvzDIv/oxAP
         hZAvfCafurfr1TPI5gTBzmSR/sz/yaPOL8sJYJbweGWIf6tlgVANaud11PN2oegynezL
         seWK0PvixY9SXMxPoQVNHP7P0q8AMlymMbNLAd8qAbV1a4BjfIBv3Pjycs2mM4BXkJTx
         tLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KO/y+sV6HVxO7LqYApv5GcMwSc9+aXS1zcQkMHwSrhw=;
        b=NxU9KlW3mQbupxD3QglRcZwj+PSZduzaugn1zhwenQXjrUJee2O86AjnEp5kdnQH/J
         DtY492pk+jFRtnbAMr3Su3HLrttDXHg5E7cLG67t02W7wpoxbl/s2PIVxCbgzvEYgQpU
         z0RbxhRzArtKKePwJE6EIMl0p0VT3Dbkup7iYz8qXfULF9dgPwJtpeptrjmF9wRNB8Ab
         rMV5p/18uceJ0DMDRgICimbHBOXIGi9b1wHMVkS1WueM5V0ugnJbrSVNNFXL8DEu6XCk
         a3dFDASmfmjBA+wwm+0jS0//jZTNVpsLQsL/BCze09/fi0r3Fmq/tSyZJWNcP/SQSx/i
         d5nw==
X-Gm-Message-State: AODbwcDU8m79Eka7DEnIBOtlBr+/FQlALlV+VapcgVURiXgXyxdNxWJn
        Tu7RQyMRrROeqQ==
X-Received: by 10.55.214.7 with SMTP id t7mr134596qki.170.1494522146477;
        Thu, 11 May 2017 10:02:26 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l10sm480407qte.15.2017.05.11.10.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 10:02:25 -0700 (PDT)
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
Subject: [PATCH 3/7] log: add -P as a synonym for --perl-regexp
Date:   Thu, 11 May 2017 17:01:38 +0000
Message-Id: <20170511170142.15934-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511170142.15934-1-avarab@gmail.com>
References: <20170511170142.15934-1-avarab@gmail.com>
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
index b0122a1991..a87b7f6089 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -331,8 +331,20 @@ test_expect_success 'log with various grep.patternType configurations & command-
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
2.11.0

