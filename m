Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35CC2209FD
	for <e@80x24.org>; Thu, 25 May 2017 20:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165439AbdEYUFz (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 16:05:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35553 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161618AbdEYUFy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 16:05:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id g15so35980734wmc.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+8+wnH+regw8gbvrOkMq/I7PNWugJ3KyPn9GQNHKgw=;
        b=LD6dyc6k5iX7JO6AvAgSWPCE4ZyVj4V+G90S6hSUipIlHrEPypeQr5j1sgmq8msKtp
         DQdU1e5T60A30DP+i7dGxK6+xc4EwQdQpV4MGWWos/9HgsyxVPdu5FqVQgJg69qboeiv
         LXpplBsykILn8elWqZWaZ1T0jcyWfVl1FRvvJKo0OABG6m5oKCT5YiyOqAkFUo1zdtkW
         yffTv3TsTdSqrodRvY4LUQjIhtKPGIUWgaFVY/zXKnP7snFkQjmUneFovmB62/KVY+OP
         j2tyQs4qVw3FgR2p8SwRDGgpK9NgycqqyIz644w9d0IxTiHhpZYzDa9iY6XshQP+Jz83
         VLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+8+wnH+regw8gbvrOkMq/I7PNWugJ3KyPn9GQNHKgw=;
        b=YKGPMUjxOg4vYPs61BjJW/N/cpiRRMn1t3AYVKV9evuxWp4+yKoRKhSXb82fNqpmfZ
         z+AJmI5DF7WwN/l6Zikh9r5axWVVC4ToXYHSg39cvnUpM6JvTWCT1LsOO3+8bvaa9+Zg
         wBG7Y94gXkyfNPFUhMwOZ3lCa60TjTEJ2kL/GRmCbcRosW53fHLIwXCJbcD0mqo6Jh6f
         eccsMJY4ruB5PANARDJR0rWBEwsL5zOdk8w4+5rHe+b0sR/vQcUjJa3boHQkKU5pGsHX
         d8l7BtekQManjb0VVnX0XT9njzTBh8xznjhVPybv0SptceCilLL0A/xhA4VwsZahLcAq
         D2+Q==
X-Gm-Message-State: AODbwcBttT5hi/ZHspwleb2LLhbMCRZUqp3cCvvpJgvwlI6AB2H8iFHX
        57t1SqhNvD8naw==
X-Received: by 10.223.145.75 with SMTP id j69mr23810311wrj.23.1495742752750;
        Thu, 25 May 2017 13:05:52 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id r60sm10574313wrb.37.2017.05.25.13.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 13:05:51 -0700 (PDT)
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
Subject: [PATCH v3 3/7] log: add -P as a synonym for --perl-regexp
Date:   Thu, 25 May 2017 20:05:24 +0000
Message-Id: <20170525200528.22037-4-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525200528.22037-1-avarab@gmail.com>
References: <20170525200528.22037-1-avarab@gmail.com>
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
index c44c4337f8..e6050faa14 100755
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

