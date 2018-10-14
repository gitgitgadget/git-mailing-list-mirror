Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46451F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 19:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeJOD1E (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 23:27:04 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:39356
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbeJOD1E (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Oct 2018 23:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1539546298;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=AFkQhxDHg5VjzE+SoIYBQYnk74RcpbmFQ70l/1rInck=;
        b=W/H10oaKFVYMEuOifwPd1TRuu4dq65tvrj3gyQnw8eV4TNSArALfogFt0msgz1AD
        kiqJBkOX9ttGn70dZsqtkYqiyiP8uyCJrJ6kpgdSUKAMmtObCBrTLhE+t5TNk9tdsDy
        rIPFkA2OJ2Vm3IySWNH/lVMTm4gm5G/0kHqvyytU=
From:   Jacques Bodin-Hullin <j.bodinhullin@monsieurbiz.com>
To:     git@vger.kernel.org
Message-ID: <01020166741c381f-bd183f7f-725d-4b4f-9f5f-804560b2b00b-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Typo `dashes ?` -> `dashes?`
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 14 Oct 2018 19:44:58 +0000
X-SES-Outgoing: 2018.10.14-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 parse-options.c          | 4 ++--
 t/t0040-parse-options.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 3b874a83a0c89..88512212392ae 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -352,7 +352,7 @@ static void check_typos(const char *arg, const struct option *options)
 		return;
 
 	if (starts_with(arg, "no-")) {
-		error ("did you mean `--%s` (with two dashes ?)", arg);
+		error ("did you mean `--%s` (with two dashes?)", arg);
 		exit(129);
 	}
 
@@ -360,7 +360,7 @@ static void check_typos(const char *arg, const struct option *options)
 		if (!options->long_name)
 			continue;
 		if (starts_with(options->long_name, arg)) {
-			error ("did you mean `--%s` (with two dashes ?)", arg);
+			error ("did you mean `--%s` (with two dashes?)", arg);
 			exit(129);
 		}
 	}
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 5b0560fa20e34..16fd333bd3895 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -222,7 +222,7 @@ test_expect_success 'non ambiguous option (after two options it abbreviates)' '
 '
 
 cat >typo.err <<\EOF
-error: did you mean `--boolean` (with two dashes ?)
+error: did you mean `--boolean` (with two dashes?)
 EOF
 
 test_expect_success 'detect possible typos' '
@@ -232,7 +232,7 @@ test_expect_success 'detect possible typos' '
 '
 
 cat >typo.err <<\EOF
-error: did you mean `--ambiguous` (with two dashes ?)
+error: did you mean `--ambiguous` (with two dashes?)
 EOF
 
 test_expect_success 'detect possible typos' '

--
https://github.com/git/git/pull/540
