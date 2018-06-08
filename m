Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35AE71F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753232AbeFHWl7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:41:59 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37001 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbeFHWlz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:41:55 -0400
Received: by mail-wr0-f195.google.com with SMTP id d8-v6so14787783wro.4
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHtSXel47iYlwQQl80+guEnuNvU3g0nL+LnWI1twPD4=;
        b=lwddAd7JKTaSvRrctY7MhqeUtvK/b6OM4v+7LOO0wp3XTDeafv84G0Q7xTtlUKquyb
         uI1GYqLzJTShLDfr/flQAmk3hbYXnq5wgdMnUVwPPPH7id7r4lJDh6lmL16CWDAXRO8R
         WvgGCv24z0Shn83cbU08p5NASCiPYJKL+FsuDlItY77Dg0PHc3XpToRzGw3praIjRXiw
         Ldu3HvQ4Hz4V8QNWRtjfDkdxJUUFhLx+3ZYQH+Y049CxGRvg1N8hKV0/UYd5VTaot8RB
         IHhIU1j719I8yFBUW9qDpdEU3yNfffKb/Vyv/aC4yRAWjw0edfmNNJcadjc3/oFUFf3X
         8pCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHtSXel47iYlwQQl80+guEnuNvU3g0nL+LnWI1twPD4=;
        b=oJ/yH3waWLrPQAA3YmYp0KWSxPiOR87lFWOy/V8uXNANv4MIgk46mCRaAYDWnAismW
         lNwgTSvVICQ+XSM1txUaAbr8xM294CdrG/DFrInnrgPjhakqT2VWv/uK2YiqNV/eSzau
         PGwWQUjJs5cfVkvyaq1yW3uDppt7hzwlZZgpekeUJKz9Z6PJ3/2jwciPutFUAPZ7ILKV
         0KoJrfwXfkT34+3QZs+N2x1qTThWPurApCWqN0yknjU1g4UTIS0qj3dsKHmrmLVC4tSy
         PfjsIT82XYPxy0YsH0JH+i9fVrBebMoLbh/N/I0qBDZDzpdbkjvLfSvfRyZrQpz0XWKv
         IqAA==
X-Gm-Message-State: APt69E1HbsKJWDaE+QCIHi9xSFs7SCRAFEnOein/kJqAe0iWtbWppylZ
        aHuvf2CB85rBQ7Tf0/vowPelw+La
X-Google-Smtp-Source: ADUXVKISGNnbY8SW2AU1RN1V6mfvQ3WninDeCbrMLKVJ4RKcQg5DrRx4wklcCAAo1Tuqqc3QPO8o8Q==
X-Received: by 2002:adf:a045:: with SMTP id l5-v6mr5729707wrl.153.1528497713803;
        Fri, 08 Jun 2018 15:41:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:41:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/20] test library: add a test_byte_count
Date:   Fri,  8 Jun 2018 22:41:18 +0000
Message-Id: <20180608224136.20220-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180608224136.20220-1-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new function is like test_line_count except it uses "wc -c"
instead of "wc -l". Perhaps this should be a parameter, but I don't
see us needing "wc -m" (chars), "wc -w" (words) etc.

Change a couple of existing tests that use this, I expect to use this
in later patches when adding more tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README                   |  4 ++++
 t/t6006-rev-list-format.sh |  6 ++----
 t/test-lib-functions.sh    | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index eede11d649..3139c27e4e 100644
--- a/t/README
+++ b/t/README
@@ -728,6 +728,10 @@ library for your script to use.
    Check whether the <expected> rev points to the same commit as the
    <actual> rev.
 
+ - test_byte_count (= | -lt | -ge | ...) <length> <file>
+
+   Check whether a file has the number of bytes it is expected to.
+
  - test_line_count (= | -lt | -ge | ...) <length> <file>
 
    Check whether a file has the number of lines it is expected to.
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index ec42c2f779..ec068c55ab 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -456,14 +456,12 @@ test_expect_success '--abbrev' '
 
 test_expect_success '%H is not affected by --abbrev-commit' '
 	git log -1 --format=%H --abbrev-commit --abbrev=20 HEAD >actual &&
-	len=$(wc -c <actual) &&
-	test $len = 41
+	test_byte_count = 41 actual
 '
 
 test_expect_success '%h is not affected by --abbrev-commit' '
 	git log -1 --format=%h --abbrev-commit --abbrev=20 HEAD >actual &&
-	len=$(wc -c <actual) &&
-	test $len = 21
+	test_byte_count = 21 actual
 '
 
 test_expect_success '"%h %gD: %gs" is same as git-reflog' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2b2181dca0..91a566f14e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -589,6 +589,29 @@ test_path_is_missing () {
 	fi
 }
 
+# test_byte_count checks that a file has the number of bytes it
+# ought to. For example:
+#
+#	test_expect_success 'produce exactly one byte of output' '
+#		do something >output &&
+#		test_byte_count = 1 output
+#	'
+#
+# is like "test $(wc -c <output) = 1" except that it passes the
+# output through when the number of bytes is wrong.
+
+test_byte_count () {
+	if test $# != 3
+	then
+		error "bug in the test script: not 3 parameters to test_byte_count"
+	elif ! test $(wc -c <"$3") "$1" "$2"
+	then
+		echo "test_byte_count: byte count for $3 !$1 $2"
+		cat "$3"
+		return 1
+	fi
+}
+
 # test_line_count checks that a file has the number of lines it
 # ought to. For example:
 #
-- 
2.17.0.290.gded63e768a

