Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0981A1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 15:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeHXSzh (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 14:55:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56091 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHXSzh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 14:55:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so1933889wmc.5
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjlYSJV6SEdnyWwriONhpEYg9dO/ThAdQz/nAcK3wWw=;
        b=qSQZTKsA0AbukBBj06CEZVJ+bzBqzkPjAB9Y4ZogCB9OF5DEGl1nx5s9zOemeHTkqu
         mKLHWyr/BFo9YwSBNHkDybfbfTdsVga99W1NRkCfq2q6RbVMJLZcdRo0mVTyGwsItFxe
         n6VmUWk/VgJQc81AOZ9wtnt/OiuUXwhzs/ORmE+T1Nih4BGLW68jN9N1Hjch/S8XM1hW
         nFNr+6dHk5XLlEKrPDqs/6Q+Uu236KjR8UxAzYIKHEzKGrEgL87NWK0TfFj07tVBLnCS
         Hs6RryEdED0kptsE6VE/MW8Q4kJ2rdV8k94OcFaR8mqREWTfMJUCydusTEhsPUlW2A29
         fZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjlYSJV6SEdnyWwriONhpEYg9dO/ThAdQz/nAcK3wWw=;
        b=EPYpAKhkSXY0DxEfe2p4+ShttaA57frdEU0CWGEtL8CjM894yyoCU3onIQh2Mx9FqO
         IBofZNTYcuzjTD3ybFP6MRyd7Bq/5+GkjSxNAMfMFwU3VYd9rRR015CuWHUHl/wv/cfu
         SD8WqdKNBjvPwBBOLs5I4IKYPbBgA+3Sl6jkbFuGAZJU25rSHJp1sGvV2ccKg+qwbVQn
         DBmiUyHderAafoIusyuqlMeshzwbyRO8PeR7ayp9c7IurmgVKKHhMkNfso1lwCCpl/Rd
         vwxuqHLtpRdO6Kqh4BzQQsjnhs3zRb/GGPvumE28+Rv9xj5g6J8KqzY0bTGUIuxVbYMw
         pz9A==
X-Gm-Message-State: APzg51AGpBbQgAtwCmG9iPcTG6AyjC1+Yl90LO3tZhEcPNo98xDldCQ/
        zYnAzZdrX9vw/pPF4id/534zJk+/A8U=
X-Google-Smtp-Source: ANB0VdYrubv/cdkcBAbs6pSOhgY9H1J14CYwY8adOsMA6A8ur5FGr9vBhijWmCj6L9of06WY/l8AVQ==
X-Received: by 2002:a1c:9692:: with SMTP id y140-v6mr1646931wmd.82.1535124029214;
        Fri, 24 Aug 2018 08:20:29 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id z16-v6sm6689485wrq.78.2018.08.24.08.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 08:20:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/6] tests: fix and add lint for non-portable head -c N
Date:   Fri, 24 Aug 2018 15:20:11 +0000
Message-Id: <20180824152016.20286-2-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
References: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "head -c BYTES" option is non-portable (not in POSIX[1]). Change
such invocations to use the test_copy_bytes wrapper added in
48860819e8 ("t9300: factor out portable "head -c" replacement",
2016-06-30).

This fixes a test added in 9d2e330b17 ("ewah_read_mmap: bounds-check
mmap reads", 2018-06-14), which has been breaking
t5310-pack-bitmaps.sh on OpenBSD since 2.18.0. The OpenBSD ports
already have a similar workaround after their upgrade to 2.18.0[2].

I have not tested this on IRIX, but according to 4de0bbd898 ("t9300:
use perl "head -c" clone in place of "dd bs=1 count=16000" kluge",
2010-12-13) this invocation would have broken things there too.

Also, change a valgrind-specific codepath in test-lib.sh to use this
wrapper. Given where valgrind runs I don't think this would ever
become a portability issue in practice, but it's easier to just use
the wrapper than introduce some exception for the "make test-lint"
check being added here.

1. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/head.html
2. https://github.com/openbsd/ports/commit/08d5d82eaefe5cf2f125ecc0c6a57df9cf91350c#diff-f7d3c4fabeed1691620d608f1534f5e5

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/check-non-portable-shell.pl | 1 +
 t/t5310-pack-bitmaps.sh       | 2 +-
 t/test-lib.sh                 | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index d5823f71d8..c8f10d40a1 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -41,6 +41,7 @@ sub err {
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (use =)';
 	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
+	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
 	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 557bd0d0c0..7bff7923f2 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -335,7 +335,7 @@ test_expect_success 'truncated bitmap fails gracefully' '
 	git rev-list --use-bitmap-index --count --all >expect &&
 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
 	test_when_finished "rm -f $bitmap" &&
-	head -c 512 <$bitmap >$bitmap.tmp &&
+	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
 	mv -f $bitmap.tmp $bitmap &&
 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 	test_cmp expect actual &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8bb0f4348e..44288cbb59 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -867,7 +867,7 @@ then
 		# handle only executables, unless they are shell libraries that
 		# need to be in the exec-path.
 		test -x "$1" ||
-		test "# " = "$(head -c 2 <"$1")" ||
+		test "# " = "$(test_copy_bytes 2 <"$1")" ||
 		return;
 
 		base=$(basename "$1")
@@ -882,7 +882,7 @@ then
 		# do not override scripts
 		if test -x "$symlink_target" &&
 		    test ! -d "$symlink_target" &&
-		    test "#!" != "$(head -c 2 < "$symlink_target")"
+		    test "#!" != "$(test_copy_bytes 2 <"$symlink_target")"
 		then
 			symlink_target=../valgrind.sh
 		fi
-- 
2.18.0.865.gffc8e1a3cd6

