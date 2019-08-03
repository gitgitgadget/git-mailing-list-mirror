Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B90E1F731
	for <e@80x24.org>; Sat,  3 Aug 2019 08:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbfHCIBd (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 04:01:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50310 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387429AbfHCIBd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 04:01:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so70087352wml.0
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 01:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+jEOTdfeVbRH31Y0MtM8/9Hhp7R2alDP7PMQssGzE0Q=;
        b=HypHo3Z/Qka3RD0cUhFem4OfUOkghC0s4cmdzZ3GV8pxqWa8T/1FTCcIRubkipm6fO
         47+u0UUf1l1NB7jbXim/qktjrBAZozkFnh0xqED9AL5v2XJNG1hB/Zp2q8iQmF+ShaTW
         L3wiThVII3TCBlrUma3HqMXuowsGBcpf2JKpZQGSUBYcsEpdJmgI6OdBLpk+K/QMSZ4C
         srTkvApzpGtXJ3p8h8eC4XjVz5CgLieh7FC0FlfftQB0zjWV4Zm8u9sr/vwPWe2ZUbme
         wSbE5YTuA4YtEv1wk7G/BHFzY6hpkJ3VQ6aA1ua0hrUiMkv2AI30azmvsR48Cgm+KMM1
         VqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+jEOTdfeVbRH31Y0MtM8/9Hhp7R2alDP7PMQssGzE0Q=;
        b=cQMce8GSg6rujVeLivO2/GSQgzFzsai8W98tXQe0f16rJBOB2HGq2iDtEPrEMNIIUD
         tgiZD4YkS4Wg5R92uZEeziQEtd9CdgkK9pwNgP+7SIdGrrIbXF+Tp7OaDo+GFR4kjpyw
         u8wvW0nMv71UciRJAseIA8/SCdTod+QWqMho35Nj5qgnSGpp5TnKb0uWQYiNTwAqFQsV
         TimAxdafwOR4bguiM5FR6CB2ic5kzzZRkfT3pz2fh37nd1ad/QxihMiuXc5DB4HnjqN9
         9camYieykcZ/3pswco2ROOzBpitkLYw9w25aaIkxWr9sIUAL9lOpJ6oOB37VIieOWHdj
         5XNQ==
X-Gm-Message-State: APjAAAVKvribUiinOQ542QBnRKxVpr3ohzA8Cvd1b5CS12OT/czYcBZf
        hzi3YKDDMhO4aEXRe0P7crLdJmnX
X-Google-Smtp-Source: APXvYqyukAH7Vm5xcdLDeKg9VpzGLP+sjA2dLnaA5R6XkPT0d9b47UGJ0ktuEJD5jL1ddmmXQ+VYwQ==
X-Received: by 2002:a1c:a101:: with SMTP id k1mr8497403wme.98.1564819290908;
        Sat, 03 Aug 2019 01:01:30 -0700 (PDT)
Received: from localhost.localdomain (x4db55264.dyn.telefonica.de. [77.181.82.100])
        by smtp.gmail.com with ESMTPSA id k17sm101439376wrq.83.2019.08.03.01.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Aug 2019 01:01:30 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] test-lib-functions: show the test name at the start of verbose output
Date:   Sat,  3 Aug 2019 10:01:26 +0200
Message-Id: <20190803080126.29488-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.309.g896d8c5f5f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The verbose output of every test looks something like this:

  expecting success:
          echo content >file &&
          git add file &&
          git commit -m "add file"

  [master (root-commit) d1fbfbd] add file
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+)
   create mode 100644 file
  ok 1 - commit works

i.e. first an "expecting success" (or "checking known breakage") line
followed by the commands to be executed, then the output of those
comamnds, and finally an "ok"/"not ok" line containing the test name.
Note that the test's name is only shown at the very end.

With '-x' tracing enabled and/or in longer tests the verbose output
might be several screenfulls long, making it harder than necessary to
find where the output of the test with a given name starts (especially
when the outputs to different file descriptors are racing, and the
"expecting success"/command block arrives earlier than the "ok" line
of the previous test).

Print the test name at the start of the test's verbose output, i.e. at
the end of the "expecting success" and "checking known breakage"
lines, to make the start of a particular test a bit easier to
recognize.

So the dummy test above would start like this:

  expecting success of 'commit works':
          echo content >file &&
  [...]

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

I remember being annoyed by this every once in a while for years, and
https://public-inbox.org/git/20190802100956.GV20404@szeder.dev/
reminded me again to finally do something about it.

 t/t0000-basic.sh        | 8 ++++----
 t/test-lib-functions.sh | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index e89438e619..6bd21aacab 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -285,14 +285,14 @@ test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
 	mv test-verbose/out test-verbose/out+ &&
 	grep -v "^Initialized empty" test-verbose/out+ >test-verbose/out &&
 	check_sub_test_lib_test test-verbose <<-\EOF
-	> expecting success: true
+	> expecting success of '\''passing test'\'': true
 	> ok 1 - passing test
 	> Z
-	> expecting success: echo foo
+	> expecting success of '\''test with output'\'': echo foo
 	> foo
 	> ok 2 - test with output
 	> Z
-	> expecting success: false
+	> expecting success of '\''failing test'\'': false
 	> not ok 3 - failing test
 	> #	false
 	> Z
@@ -313,7 +313,7 @@ test_expect_success 'test --verbose-only' '
 	check_sub_test_lib_test test-verbose-only-2 <<-\EOF
 	> ok 1 - passing test
 	> Z
-	> expecting success: echo foo
+	> expecting success of '\''test with output'\'': echo foo
 	> foo
 	> ok 2 - test with output
 	> Z
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d4f199391f..165e1e51c7 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -580,7 +580,7 @@ test_expect_failure () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
-		say >&3 "checking known breakage: $2"
+		say >&3 "checking known breakage of '$1': $2"
 		if test_run_ "$2" expecting_failure
 		then
 			test_known_broken_ok_ "$1"
@@ -600,7 +600,7 @@ test_expect_success () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
-		say >&3 "expecting success: $2"
+		say >&3 "expecting success of '$1': $2"
 		if test_run_ "$2"
 		then
 			test_ok_ "$1"
-- 
2.23.0.rc1.309.g896d8c5f5f

