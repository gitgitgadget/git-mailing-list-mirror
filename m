Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C2B11FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754893AbdEKJUQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:20:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35731 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755331AbdEKJUO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:20:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id v4so5495219wmb.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pxD1BBkl9JIlbm47I9lFASISQxJNSO0mhqGHNTEMVcw=;
        b=cSofD4EYFhn9fKM/wnRYlqARQYM0vlCrrrbO6YhdqDVqHIXUybv4AZbwqHcg5Zhc2I
         b1+sbYDGJ56+Ihi4mVXaT+229K3UZ+4n/L79AxMdvzVt3kUc5U3UkxU/cz3RHqxWDzc1
         AkeHbUB4KNwTOrz4zYlN5HyrjmuANDEe/ZGmTW2V/dgIU+MKjMjw0Q3kjChvd/2sWEt+
         KXruI2uYSNke33TeooXKc0BxcOyYDPZgsTocOiBcuVcn21bBtVwSuUV91a1iqsauRmr3
         98q2TIyYGFPjOJLAKfJ1uSdOhI0Y3CFFLZ0cjFK4YGeGHSNyUNVJRhKSzQllmuvwSlSV
         yQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pxD1BBkl9JIlbm47I9lFASISQxJNSO0mhqGHNTEMVcw=;
        b=TL85qJSnnCbsB0wK9otzP0u8yrbDsh/cQy3CSmupmvw5yK3SDLEm6ptKkm8PLxNuOd
         wEhmjmXZdD84yKidUb1CHOeHAJC/Pniv7QJkb4fiP00CYz6QOW2+QI0BoT008RVEHLK8
         Ed+xYVz1WBmFnDq6wb1FgoQMlIdUFbUjIbRjYiRr/wDlTOTdOztxmXMGt25GyZ4aZjN1
         xrxG6IYoqYe2dJ142d7NK6sCFz3En8CQf4n5R8Jfso2Q7+mKDOsjeQUVNLmhlWGmA/vG
         wU8Jd19dIjb4ByOlbfBLkdomwrXTJ1JYLJpXpOLRgtnoy8lQQXCJ8BO8ZX8JF7qr3114
         G00Q==
X-Gm-Message-State: AODbwcCMBeH7zIznVd5aKxn1oAhIbMzutgPZpNVWgZ2sIxSu9wwmjBG5
        xCxCzUyrWVdL5nYDPrE=
X-Received: by 10.80.155.22 with SMTP id o22mr54893edi.28.1494494407619;
        Thu, 11 May 2017 02:20:07 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:20:06 -0700 (PDT)
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
Subject: [PATCH 26/29] pack-objects & index-pack: add test for --threads warning
Date:   Thu, 11 May 2017 09:18:26 +0000
Message-Id: <20170511091829.5634-27-avarab@gmail.com>
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

Add a test for the warning that's emitted when --threads or
pack.threads is provided under NO_PTHREADS=YesPlease. This uses the
new PTHREADS prerequisite.

The assertion for C_LOCALE_OUTPUT in the latter test is currently
redundant, since unlike index-pack the pack-objects warnings aren't
i18n'd. However they might be changed to be i18n'd in the future, and
there's no harm in future-proofing the test.

There's an existing bug in the implementation of pack-objects which
this test currently tests for as-is. Details about the bug & the fix
are included in a follow-up change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5300-pack-object.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 43a672c345..1629fa80b0 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -421,6 +421,40 @@ test_expect_success 'index-pack <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
+test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'index-pack --threads=N or pack.threads=N warns when no pthreads' '
+	test_must_fail git index-pack --threads=2 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep -F "no threads support, ignoring --threads=2" err &&
+	test_must_fail git -c pack.threads=2 index-pack 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep -F "no threads support, ignoring pack.threads" err &&
+	test_must_fail git -c pack.threads=2 index-pack --threads=4 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 2 warnings &&
+	grep -F "no threads support, ignoring --threads=4" err &&
+	grep -F "no threads support, ignoring pack.threads" err
+'
+
+test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
+	git pack-objects --threads=2 --stdout --all </dev/null >/dev/null 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep -F "no threads support, ignoring --threads" err &&
+	git -c pack.threads=2 pack-objects --stdout --all </dev/null >/dev/null 2>err &&
+	cat err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 2 warnings &&
+	grep -F "no threads support, ignoring --threads" err &&
+	grep -F "no threads support, ignoring pack.threads" err &&
+	git -c pack.threads=2 pack-objects --threads=4 --stdout --all </dev/null >/dev/null 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 2 warnings &&
+	grep -F "no threads support, ignoring --threads" err &&
+	grep -F "no threads support, ignoring pack.threads" err
+'
+
 #
 # WARNING!
 #
-- 
2.11.0

