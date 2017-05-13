Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D25120188
	for <e@80x24.org>; Sat, 13 May 2017 23:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756319AbdEMXqH (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:46:07 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35244 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755828AbdEMXqF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:46:05 -0400
Received: by mail-qt0-f194.google.com with SMTP id r58so11267007qtb.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6ItHLS/MYADu9rIzTsu8jClEHafC3aGHqOrLAk2MIk=;
        b=iPxgvWWPKV6cEKHDEu4f2Se5D7p7YgCSKpo5J4xE0/EA/okjd3zSS+an36fP+NUGxP
         eIL7gZ9AdQ+11qt94hAvjf8IFHVn4yVEjYm9hHSSgMli2psZ7icbeKfUcXtk9thkKf1v
         rHN6pVnaXHR/gNmGU17EsMfdXXySnBQ8tm11Ar07BdBilG+HpP7hK4WEjXorDTueAc+g
         w8Tqfv8W8SdGfnGq4wLZlsUlERxQjrqQNGyDo+Hzs6uYV/SmwwAUV23IhnSQzqbkNl3r
         iB3f0n0ZRPGSCIpOMqA4ufBOQqArkflbQ/AUbjwgnIlTRxcP1mfO6anNiJh4x9d2yhm+
         Pw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6ItHLS/MYADu9rIzTsu8jClEHafC3aGHqOrLAk2MIk=;
        b=tRNUtdDsahEGNZxb4IuTDfCVcpqmIHd8M+xUPCbxBRdoqRLCG5P4TqpQk5Oa+zeaIi
         fHF2jR+7JlZp8n5X2n21s6lJXq8Yunqf6iFpo2JWqcQu9rgIAIfDKKEKoW8KFxP1ntxi
         7vJdNuRxU9Ec6k9LcZEUjkdnhMnw/XErcBHssQMfQEL2id7QIVhRjisFmeXOcqUWcymK
         84YTW6SAAc7Bao5BRU5q/yQXbjERNmZOiiUuYXhkwwyY/cqXp2ibIatfyziktFY+Tw6L
         LpKXeLysRFEq1jGOcp7IXblfh88YQ5s7yoRD5MJpFDHMlphwUck6IOlrKhM82YdH1jyt
         y6qQ==
X-Gm-Message-State: AODbwcAcwIwK+WtHPYg5GMYIJmjusD2rFiGBsTHs91xj9XiTPaNu/rh4
        18LgFRGHcNbnsg==
X-Received: by 10.200.39.219 with SMTP id x27mr8159620qtx.80.1494719164360;
        Sat, 13 May 2017 16:46:04 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h14sm5319234qta.18.2017.05.13.16.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:46:03 -0700 (PDT)
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
Subject: [PATCH v2 3/7] log: add -P as a synonym for --perl-regexp
Date:   Sat, 13 May 2017 23:45:31 +0000
Message-Id: <20170513234535.12749-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513234535.12749-1-avarab@gmail.com>
References: <20170513234535.12749-1-avarab@gmail.com>
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
index 9680dfe400..5c05c650cd 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -350,8 +350,20 @@ test_expect_success 'log with various grep.patternType configurations & command-
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

